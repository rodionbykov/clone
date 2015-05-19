component persistent="true" entityname="Setting" table="settings" accessors="true" {

    property name="name" column="name" fieldType="id";
    property name="value" column="value";
    property name="valuetype" column="valuetype";
    property name="controltype" column="controltype";

    public any function init(name, value = "") {

        VARIABLES.name = ARGUMENTS.name;
        VARIABLES.value = ARGUMENTS.value;

        return THIS;
    }

}