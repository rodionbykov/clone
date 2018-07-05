component persistent="false" accessors="true" {

    property name="name";
    property name="value";

    public any function init(String name="", String value="") {

        VARIABLES.name = ARGUMENTS.name;
        VARIABLES.value = ARGUMENTS.value;

        return THIS;
    }

}