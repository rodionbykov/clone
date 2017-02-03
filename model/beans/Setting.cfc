component persistent="true" entityname="Setting" table="users_settings" accessors="true" {

    property name="id" fieldtype="id" generator="native" column="id" setter="false";
    property name="name" column="name";
    property name="value" column="value";
    property name="valuetype" column="valuetype";
    property name="controltype" column="controltype";
    property name="dictionary" column="dictionary";

    public any function init(String name, String value = "", String valuetype="STRING", String controltype="INPUT", String dictionary="{}") {

        VARIABLES.name = ARGUMENTS.name;
        VARIABLES.value = ARGUMENTS.value;
        VARIABLES.valuetype = ARGUMENTS.valuetype;
        VARIABLES.controltype = ARGUMENTS.controltype;

        VARIABLES.dictionary = {};
        try{
            VARIABLES.dictionary = DeserializeJSON(ARGUMENTS.dictionary);
        }catch(any e){

        }

        return THIS;
    }

}