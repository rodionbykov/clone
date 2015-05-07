component persistent="false" accessors="true" {
        
    property name="LanguageService";

    public any function init(){   
        return THIS;
    }

    public string function getLanguages(string format = "JSON"){
        return SerializeJSON(VARIABLES.languageService.getLanguages());
    }

}