//Compile dynamic textured equipment

//don't rely on C preprocessor

// 20 slots per equipment piece
//      -> in CfgWeapons.hpp
//      -> in weapons.hpp

//  static ui.hpp with 12 layers.

// - compile materials.hpp
//      - Material name from folder structure
//          -- wfar_retextures_material - texture.paa - group - addon - family - camo.rhai
//          => wfar_retextures_material_shark_helmet_cup_ech_marpat_wd
//      - Base texture from inheritance
//          -- C++ inheritance-ish 
//      - Overlay texture from paa

info("Running...");
const root = HEMTT_RFS.join("addons").join("retextures");
const class_prefix = "wfar_retextures";
const pbo_prefix = "z/wfar/addons/retextures";

const EQUIP_SLOTS = 400;

fn create(value, parent) {
    this.create(`${value}: ${parent}`);
};
fn create(value) {
    this.fprint(`class ${value} {`);
    this.class = value;
    this.depth += 1;
};
fn finish() {
    this.depth = max(0, this.depth - 1);
    this.fprint("};");
};
fn fprint(value) {
    let whitespace = "";
    for i in 0..this.depth {whitespace.append("    ")};
    this.file.write(`${whitespace}${value}` + "\r\n");
};
fn addEquipment(value) {
    if(this.hasData) {
        this.file.write(",\r\n" + `"${value}"`);
    } else {
        this.file.write(`"${value}"`);
    }
    this.hasData = true;
}

//Initialise build files
let cfgWeapons = #{
    file: root.join("build").join("CfgWeapons.hpp").create_file(),
    class: "",
    depth: 0
}; 
cfgWeapons.create("CfgWeapons");
let cfgMaterials = #{
    file: root.join("build").join("materials.hpp").create_file(),
    class: "",
    depth: 0
};
cfgMaterials.create("wfar_retextures");
cfgMaterials.fprint(`slots = ${EQUIP_SLOTS};`);
let cfgEquipment = #{
    file: root.join("build").join("equipment.hpp").create_file(),
    hasData: false
};

fn array.to_configPath() {
    return this.reduce(|accum, value| { `${accum}/${value}` }, "");
}
fn array.to_configValue() {
    //Needs curly closure
    let string = "{";
    for element in this {
        let value = element.to_string();
        if value.len == 0 {
            string.append(`"",`);
        } else {
            value.replace(`\\`, "\\");
            string.append(value.to_string() + ',');
        };
    };
    string[string.len-1] = '}';
    return string;
}
fn string.to_configValue() {
    if this.contains("paa") {
        return `QQUOTE("${this}")`;
    }
    if this.len == 0 {
        return `""`;
    }
    return `QUOTE(${this})`;
}
fn to_configValue() {
    return `"${this.to_string()}"`;
}

fn get_file_properties() {
    const parts = this.file_name().split(".");
    return (#{
        name: parts[0],
        extension: parts[-1]
    });
}

fn build_procTex(unique_name) {
    return `"#(rgb,2048,2048,3)ui(""wfar_retextures_RscDisplayMaterial"",""${unique_name}"",""ca"")"`;
};

fn compile_classes(file, propTree, folders, cfgWeapons, cfgEquipment, classes) {
    info("compile_classes");
    const folderTree = folders.reduce(|accum, value| {if accum == "" { `${value}`} else { `${accum}_${value}` }}, "");
    let imported_classes = [];
    
    const material_class = `${global::class_prefix}_${folderTree}`;
    for class in classes {
        let config = #{
            name: `${global::class_prefix}_${folderTree}` + (if class.suffix == "" {""} else {`_${class.suffix}`}),
            parent: class.parent,
            properties: propTree
        };
        if !(config.parent in imported_classes) {
            cfgWeapons.fprint(`class ${config.parent};`);
            imported_classes+=config.parent;
        };

        config.properties.displayName = class.displayName;

        const base_class = config.name;
        config.properties["hiddenSelectionsTextures[]"] = propTree["hiddenSelectionsTextures[]"].map(|value| {""});
        cfgWeapons.create(base_class, config.parent); //Writing Class
        cfgWeapons.fprint(`wfar_retextures_baseClass = "${config.name}";`);
        cfgWeapons.fprint(`wfar_retextures_materialClass = "${material_class}";`);
        for key in config.properties.keys() {
            cfgWeapons.fprint(`${key} = ${config.properties[key].to_configValue()};`);
        };
        cfgWeapons.finish(); //Class Closed
        cfgEquipment.addEquipment(base_class);

        for slot in 0..global::EQUIP_SLOTS {
            const config_name = config.name + `_${slot}`;
            config.properties["hiddenSelectionsTextures[]"] = propTree["hiddenSelectionsTextures[]"].map(|value| { if value == "#MATERIAL_SLOT" { build_procTex(config_name) } else { value }});
            //Writing Class
            cfgWeapons.create(config_name, config.name);
            cfgWeapons.fprint(`wfar_retextures_classSlot = ${slot};`);
            cfgWeapons.fprint(`scope = "1";`);
            cfgWeapons.fprint(`dlc = "";`);
            cfgWeapons.fprint(`${"hiddenSelectionsTextures[]"} = ${config.properties["hiddenSelectionsTextures[]"].to_configValue()};`);
            cfgWeapons.finish();
            //Class Closed
    
            cfgEquipment.addEquipment(config_name);
        };
    };
};
fn compile_materials(file, propTree, folders, cfgMaterials, materials, class_type) {
    cfgMaterials.create(class_type);

    for material in materials {
        //Writing Class
        cfgMaterials.create(material.class);
        for key in material.keys() {
            if key in ["layers", "class"] { continue };
            cfgMaterials.fprint(`${key} = ${material[key].to_configValue()};`);
        };

        cfgMaterials.create("layers");
        for index in material.layers.keys() {
            cfgMaterials.create(index);
            let keys = material.layers[index].keys();
            let data = material.layers[index]["data"];
            if data.contains("paa") && (!data.contains("\\")) {
                const checkFile = file.join(data);
                if !checkFile.exists() {
                    throw "ERROR: Material File Not Found!";
                };
                data = ([global::pbo_prefix, "data"] + folders + [data]).to_configPath();
                data.replace("/", "\\");
                cfgMaterials.fprint(`data = ${data.to_configValue()};`);
                keys = keys.filter(|value| {value != "data"});
            };
            for key in keys {
                let value = material.layers[index][key];
                cfgMaterials.fprint(`${key} = ${value.to_configValue()};`);
            }
            cfgMaterials.finish();
        };
        cfgMaterials.finish();//layers Closed
        cfgMaterials.finish();//class closed
    };

    cfgMaterials.finish();//materials closed
};

fn crawler(file, propTree, folders, cfgWeapons, cfgMaterials, cfgEquipment) {
    //Folders need a (folder_name).rhai file to be crawled
    const includeFile = file.join(file.file_name() + ".rhai");
    if !includeFile.exists() { return };
    folders += file.file_name();
    //info(array_as_string(propTree.folders));

    //include create crawler propTree
    import includeFile.to_string() as included;
    //Inheritance
    try { propTree += included::properties; } catch {};

    //Build up classes
    let classes = [];
    try { classes = included::classes; } catch {};
    if classes.len > 0 { 
        compile_classes(file, propTree, folders, cfgWeapons, cfgEquipment, classes);
    };

    cfgMaterials.create(file.file_name());
    //Build up base materials
    let bases = [];
    try { bases = included::bases; } catch {};
    if bases.len > 0 { 
        compile_materials(file, propTree, folders, cfgMaterials, bases, "bases");
    };

    //Build up materials
    let materials = [];
    try { materials = included::materials; } catch {};
    if materials.len > 0 { 
        compile_materials(file, propTree, folders, cfgMaterials, materials, "materials");
    };

    for file in file.list() {
        if file.is_dir() {
            crawler(file, propTree, folders, cfgWeapons, cfgMaterials, cfgEquipment);
        };
    };
    cfgMaterials.finish();
};

//Crawl the data folder structure
for file in root.join("data").list() {
    if !file.is_dir() { continue };
    crawler(file, #{}, [], cfgWeapons, cfgMaterials, cfgEquipment);
}; 

cfgWeapons.finish();
cfgMaterials.finish();

info("Completed!");
//throw "Completed!";