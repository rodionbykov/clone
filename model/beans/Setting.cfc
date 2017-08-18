component persistent="true" entityname="Setting" table="settings" accessors="true" {

    property name="id" column="id" fieldtype="id";
    property name="label" column="label";
    property name="value" column="value";
    property name="valuetype" column="valuetype";

    public any function init(String id, String label="", String value="", String valuetype="STRING") {

        VARIABLES.name = ARGUMENTS.name;
        VARIABLES.label = ARGUMENTS.label;
        VARIABLES.value = ARGUMENTS.value;
        VARIABLES.valuetype = ARGUMENTS.valuetype;        

        return THIS;
    }

}