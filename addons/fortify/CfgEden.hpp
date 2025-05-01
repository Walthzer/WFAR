class Cfg3DEN
{
    class Object
    {
        class AttributeCategories
        {

            class wfar_attributes
            {
                displayName = "WFAR";
                collapsed = 1;
                class Attributes
                {
                    class GVAR(supplyRange)
                    {
                        displayName = "Supply range";
                        tooltip = "Set the object's supply range: -1 is disabled, 0 is global range, 0 < is specific range";
                        property = QGVAR(supplyRange);
                        control = "Edit";

                        expression = QUOTE(if (is3DEN || {_value < 0}) exitWith {}; [ARR_3(_this,_value,true)] call FUNC(registerSupplier));

                        defaultValue = -1;

                        unique = 0;
                        validate = "number";
                        condition = "1";
                        typeName = "NUMBER";
                    };
                };
            };
        };
    };
};