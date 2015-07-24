component persistent="true" entityname="Language" table="languages" accessors="true" {

    // persistent properties
    property name="code" column="code" fieldType="id";
    property name="name" column="name";
    property name="nativename" column="nativename";

    // non-persistent properties
    property name="languagelabels" type="struct" persistent="false";

    public any function init(code, name = "", nativename = "") {

        VARIABLES.code = ARGUMENTS.code;
        VARIABLES.name = ARGUMENTS.name;
        VARIABLES.nativename = ARGUMENTS.nativename;

        VARIABLES.languagelabels = StructNew();

        return THIS;
    }

    public void function setLanguageLabel(section, anchor, label) {
        if ( NOT StructKeyExists(VARIABLES.languagelabels, ARGUMENTS.section) ){
            VARIABLES.languagelabels[ARGUMENTS.section] = StructNew();
        }
        if ( NOT StructKeyExists(VARIABLES.languagelabels[ARGUMENTS.section], ARGUMENTS.anchor) ){
            VARIABLES.languagelabels[ARGUMENTS.section][ARGUMENTS.anchor] = StructNew();
        }
        VARIABLES.languagelabels[ARGUMENTS.section][ARGUMENTS.anchor] = ARGUMENTS.label;
    }

}