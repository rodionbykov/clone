component persistent="false" accessors="true" {
        
    property name="languages";

    public any function init(){
    
        VARIABLES.languages = EntityLoad("Language");

        return THIS;
    }

}