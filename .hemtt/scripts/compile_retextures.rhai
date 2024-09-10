// Compile material definitions from wfar\retextures\data

//don't rely on C preprocessor

// - compile materials.hpp
//      - Material name from folder structure
//          -- wfar_retextures_material - texture.paa - group - addon - family - camo.rhai
//          => wfar_retextures_material_shark_helmet_cup_ech_marpat_wd
//      - Base texture from inheritance
//          -- C++ inheritance-ish 
//      - Overlay texture from paa


// - compile CfgWeapons.hpp
//      - Classname from folder structure
//          -- wfar_retextures - texture.paa - group - addon - family - components - camo.rhai
//          => wfar_retextures_shark_helmet_cup_ech_ * ess_headset * _marpat_wd
//      - Class properties from object maps poly_fill inheritance
//          -- C++ inheritance-ish 
//

info("Running...");
const root = HEMTT_RFS.join("addons").join("retextures");
const real_prefix = "N:/ArmaGithubAddonRepositories/WFAR";


const class_prefix = "wfar_retextures";
const pbo_prefix = "z/wfar/addons/retextures";

const material_class_template = #{
header: `
class #CLASS_NAME: GVAR(RscDisplayMaterial) {
    class ControlsBackground: ControlsBackground {
    `,
layer: `
        class layer#LAYER_ID: layer0 {
            text = "#PATH_SLOT";
        };
    `,
footer: `};
};
`
};

fn compile_path(array) {
    const path = array.reduce(|accum, value| { `${accum}/${value}` }, "");
    return path;
};

fn to_arma_path(path, prefix) {
    //TODO->clean up this filth
    const arma_path = (prefix + path.to_string()).split("/").reduce(|accum, value| {if accum == "" { if value == "" {""} else {`\${value}`}} else { `${accum}\${value}` }}, "");
    return arma_path;
};

fn format_arma_config(value) {
    switch value.type_of() {
        "array" => return array_as_string(value),
        //default
        _ => return `"${to_arma_path(value, "")}"`,
    };    
}

fn array_as_string(arg) {
    if type_of(arg) != "array" { 
        arg = to_arma_path(`${arg}`, "");
        return `"${arg}"`;
    };
    let array_string = arg.reduce(|accum, value| {`${accum}${array_as_string(value)},`}, "{");
    if (array_string[-1] == ",") {array_string.pop()};
    array_string += "}";
    return array_string;
}

fn get_file_properties(path) {
    const parts = path.file_name().split(".");
    return (#{
        name: parts[0],
        extension: parts[-1]
    });
}

fn build_procedural_ui_texture(material_classname, weapon_classname) {
    const procedural = `#(rgb,2048,2048,3)ui(""${material_classname}"",""${weapon_classname}"",""ca"")`;
    //info(procedural);
    return procedural;
};

fn folder_compile_classes(path, tree, folders, templates) {
    const tree_folders = folders.reduce(|accum, value| {if accum == "" { `${value}`} else { `${accum}_${value}` }}, "");

    //Initialise cfgWeapons file
    let cfgweapon_out = global::root.join("build").join("CfgWeapons.hpp").create_file();
    cfgweapon_out.write("class CfgWeapons {\r\n");
    let material_out = global::root.join("build").join("ui.hpp").create_file();
    let weapon_classnames_out = global::root.join("build").join("weapons.hpp").create_file();
    let imported_classes = [];

    //Process texture files
    for path in path.list() {
        let file_properties = get_file_properties(path);
        if file_properties.extension != "paa" { continue };

        const texture_arma_path = to_arma_path(compile_path(["data"] + folders + [`${path.file_name()}`]), global::pbo_prefix);

        for (template, index) in templates {
            if index > 0 { template.fill_with(templates[0]) }; //mixin

            for class in template.classes {
                //Material Class
                const suffix = if class[0] == "" { `${template.camo}`} else { `${class[0]}_${template.camo}` };
                const material = #{
                    name: `${global::class_prefix}_material_${file_properties.name}_${tree_folders}_${suffix}`,
                    layers: template.material_layers.map(|value| { if value == "#TEXTURE_SLOT" { texture_arma_path } else { to_arma_path(value, "") } })
                };

                let material_class = global::material_class_template.header;
                material_class.replace("#CLASS_NAME", material.name);
                for (texture_path, index) in material.layers {
                    material_class += global::material_class_template.layer;
                    material_class.replace("#LAYER_ID", `${index}`);
                    material_class.replace("#PATH_SLOT", texture_path);
                };
                material_class+=global::material_class_template.footer;
                material_out.write(material_class);

                //CfgWeapon class
                let cfgWeapon = #{
                    name: `${global::class_prefix}_${file_properties.name}_${tree_folders}_${suffix}`,
                    parent: class[1],
                    properties: tree
                };
                cfgWeapon.properties.displayName = class[2];
                cfgWeapon.properties.displayName.replace("#CAMO", template.camo_name);
                const procedural = build_procedural_ui_texture(material.name, cfgWeapon.name);
                cfgWeapon.properties["hiddenSelectionsTextures[]"] = tree["hiddenSelectionsTextures[]"].map(|value| { if value == "#MATERIAL_SLOT" { procedural } else { value }});  

                if !(cfgWeapon.parent in imported_classes) {
                    cfgweapon_out.write(`   class ${cfgWeapon.parent};`+"\r\n");
                    imported_classes+=cfgWeapon.parent;
                };
                cfgweapon_out.write(`   class ${cfgWeapon.name}: ${cfgWeapon.parent} {` + "\r\n");
                for key in cfgWeapon.properties.keys() {
                    cfgweapon_out.write(`       ${key} = ${format_arma_config(cfgWeapon.properties[key])};`+ "\r\n");
                };
                cfgweapon_out.write("   };"+ "\r\n");

                weapon_classnames_out.write(`"${cfgWeapon.name}",`+"\r\n");
                info(cfgWeapon.name);
                
            };
        };
        //throw "STOP";
    };

    //Close of files
    cfgweapon_out.write(`};`);
};

fn crawler(path, tree, folders) {
    //Folders need a (folder_name).rhai file to be crawled
    const includePath = path.join(path.file_name() + ".rhai");
    if !includePath.exists() { return };
    folders += path.file_name();
    //info(array_as_string(tree.folders));

    //include into crawler tree
    //import global::real_prefix + includePath.to_string() as included;
    import includePath.to_string() as included;
    let templates = [];
    try {
        tree += included::properties;
    } catch {};
    try {
        templates = included::templates;
    } catch {};

    //Build up classes
    if templates.len > 0 { 
        folder_compile_classes(path, tree, folders, templates);
    };
    
    for (template, index) in templates {
        if(index > 0) { template += templates[0] };
        
    }

    for path in path.list() {
        if path.is_dir() {
            crawler(path, tree, folders);
        };
    };
};

//Crawl the data folder structure
for path in root.join("data").list() {
    if !path.is_dir() { continue };
    crawler(path, #{}, []);
}; 

info("Completed!");
//throw "Completed!";