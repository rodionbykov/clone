component persistent="false" accessors="true" {

    property name="settings";

    public any function init(){

        VARIABLES.settings = EntityLoad("Setting");

        return THIS;
    }

}