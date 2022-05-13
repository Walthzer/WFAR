
class ctrlMenuStrip;
class display3DEN
{
    class Controls
    {
        class MenuStrip: ctrlMenuStrip
        {
            class Items
            {
                class Attributes
                {
                    items[] += {QGVAR(attributes)};
                };
                class GVAR(attributes)
                {
                    text = "WFAR Continuity";
                    action = QUOTE(edit3DENMissionAttributes QQGVAR(attributes));
                };
            };
        };
    };
};

class Cfg3DEN
{
    class Attributes // Attribute UI controls are placed in this pre-defined class
    {
        class Default;
        class GVAR(empty): Default {
            h = 0;
        };
    };

    class Mission
    {
        class GVAR(attributes) // Custom section class, everything inside will be opened in one window
        {
            displayName = "WFAR Continuity Attributes";
            display = "Display3DENEditAttributesPreview";
            class AttributeCategories
            {
                class GVARMAIN(attributes)
                {
                    class Attributes
                    {
                        class GVAR(enable)
                        {
                            property = QGVAR(enable);
                            displayName = "Enable Continuity";
                            tooltip = "Let continuity automatically save/load this mission PBO";
                            control = "Checkbox";
                            expression = QUOTE(GVAR(enable) = _value);
                            defaultValue = "false";
                            condition = "1";
                        };
                        class GVAR(scenarioSaveDateUTC)
                        {
                            property = QGVAR(scenarioSaveDateUTC);
                            control = QGVAR(empty);
                            expression = QUOTE(GVAR(scenarioSaveDateUTC) = _value);
                            defaultValue = "[]";
                            condition = "1";
                        };
                    };
                };
            };
        };
    };

    class EventHandlers
    {
        class ADDON
        {
            OnMissionSave = QUOTE(call FUNC(onMissionSave));
        };
    };

    class Logic
    {
        class AttributeCategories
        {

            class wfar_attributes
            {
                displayName = "";
                collapsed = 1;
                class Attributes
                {
                    class GVAR(objectID)
                    {
                        displayName = "";
                        tooltip = "";
                        property = QGVAR(objectID);
                        control = QGVAR(empty);

                        expression = QUOTE(if (is3DEN || {_value < 0}) exitWith {}; [ARR_2(_this,_value)] call FUNC(registerObjectID));

                        defaultValue = "-1";

                        unique = 0;
                        validate = "none";
                        condition = "1";
                        typeName = "NUMBER";
                    };
                };
            };
        };
    };

    class Marker
    {
        class AttributeCategories
        {

            class wfar_attributes
            {
                displayName = "";
                collapsed = 1;
                class Attributes
                {
                    class GVAR(objectID)
                    {
                        displayName = "";
                        tooltip = "";
                        property = QGVAR(objectID);
                        control = QGVAR(empty);

                        expression = QUOTE(if (is3DEN || {_value < 0}) exitWith {}; [ARR_2(_this,_value)] call FUNC(registerObjectID));

                        defaultValue = "-1";

                        unique = 0;
                        validate = "none";
                        condition = "1";
                        typeName = "NUMBER";
                    };
                };
            };
        };
    };

    class Object
    {
        class AttributeCategories
        {

            class wfar_attributes
            {
                displayName = "wfar";
                collapsed = 1;
                class Attributes
                {
                    class GVAR(objectID)
                    {
                        displayName = "";
                        tooltip = "";
                        property = QGVAR(objectID);
                        control = QGVAR(empty);

                        expression = QUOTE(if (is3DEN || {_value < 0}) exitWith {}; [ARR_2(_this,_value)] call FUNC(registerObjectID));

                        defaultValue = "-1";

                        unique = 0;
                        validate = "none";
                        condition = "1";
                        typeName = "NUMBER";
                    };
                };
            };
        };
    };
};