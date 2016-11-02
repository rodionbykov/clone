component persistent="false" accessors="true" {

    property name="code";
    property name="name";
    property name="native";
    property name="labels";
    property name="isdirty";

    public any function init(String code, String name, String native) {

        VARIABLES.code = ARGUMENTS.code;
        VARIABLES.name = ARGUMENTS.name;
        VARIABLES.native = ARGUMENTS.native;
        VARIABLES.isDirty = true;

        VARIABLES.labels = {};

        return THIS;
    }

    public void function setLabel(String arg_section, String arg_anchor, String arg_label) {
        if ( NOT StructKeyExists(VARIABLES.labels, arg_section) ){
            VARIABLES.labels[arg_section] = {};
        }
        if ( NOT StructKeyExists(VARIABLES.labels[arg_section], arg_anchor) ){
            VARIABLES.labels[arg_section][arg_anchor] = "";
        }
        VARIABLES.labels[arg_section][arg_anchor] = arg_label;
    }

    public Boolean function isDirty(){
       return VARIABLES.isDirty;
    }

    public Struct function toStruct(){
       var result = {};

       result[VARIABLES.code] = {
          'name' = VARIABLES.name,
          'native' = VARIABLES.native,
          'labels' = VARIABLES.labels
       };

       return result;
    }

}