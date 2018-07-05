component persistent="false" accessors="true" {

    property name="fw";
    property name="applicationConfig";
    property name="settings";

    public any function init(any applicationConfig){

        VARIABLES.applicationConfig = ARGUMENTS.applicationConfig;
        VARIABLES.settings = [];             

        return THIS;
    }

    public any function configure(){
       if (NOT DirectoryExists("#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.resourcesDir#")){
           directoryCreate("#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.resourcesDir#");
        }
        THIS.getSettings();
    }

    public Array function getSettings(){
        if ( ArrayLen(VARIABLES.settings) EQ 0 ){
            THIS.populateSettings( importSettings() );
        }

        return VARIABLES.settings;
    }

    public any function getSetting(String k){
        var result = false;

        if ( ArrayLen(VARIABLES.settings) EQ 0 ){
            getSettings();
        }

        for (var s in VARIABLES.settings){
            if(s.getName() EQ k){
                result = s;
            }
        }

        return result;
    }

    public Struct function importSettings(){
        if( FileExists( "#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.defaultsDir#/#VARIABLES.applicationConfig.settingsJSON#" ) 
            AND NOT 
            FileExists( "#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.resourcesDir#/#VARIABLES.applicationConfig.settingsJSON#" )){
            FileCopy( "#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.defaultsDir#/#VARIABLES.applicationConfig.settingsJSON#", 
                      "#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.resourcesDir#/#VARIABLES.applicationConfig.settingsJSON#" );
        }

        if( FileExists("#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.resourcesDir#/#VARIABLES.applicationConfig.settingsJSON#") ){
            var jsonSettings = FileRead("#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.resourcesDir#/#VARIABLES.applicationConfig.settingsJSON#", "utf-8");
        }

        var structSettings = DeserializeJSON(jsonSettings);

        return structSettings;
    }

    public Struct function importLanguages(){

        if( FileExists( "#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.defaultsDir#/#VARIABLES.applicationConfig.languagesJSON#" ) AND NOT FileExists( "#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.resourcesDir#/#VARIABLES.applicationConfig.languagesJSON#" )){
            FileCopy( "#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.defaultsDir#/#VARIABLES.applicationConfig.languagesJSON#", "#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.resourcesDir#/#VARIABLES.applicationConfig.languagesJSON#" );
        }

        if( FileExists("#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.resourcesDir#/#VARIABLES.applicationConfig.languagesJSON#") ){
            var jsonLanguages = FileRead("#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.resourcesDir#/#VARIABLES.applicationConfig.languagesJSON#", "utf-8");
        }

        if( FileExists( "#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.defaultsDir#/#VARIABLES.applicationConfig.labelsJSON#" ) AND NOT FileExists( "#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.resourcesDir#/#VARIABLES.applicationConfig.labelsJSON#" )){
           FileCopy( "#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.defaultsDir#/#VARIABLES.applicationConfig.labelsJSON#", "#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.resourcesDir#/#VARIABLES.applicationConfig.labelsJSON#" );
        }

        if( FileExists("#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.resourcesDir#/#VARIABLES.applicationConfig.labelsJSON#") ){
            var jsonLabels = FileRead("#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.resourcesDir#/#VARIABLES.applicationConfig.labelsJSON#", "utf-8");
        }

        var structLanguages = DeserializeJSON(jsonLanguages);
        var structLabels = DeserializeJSON(jsonLabels);

        for(var l in structLanguages){
            structLanguages[l].labels = structLabels[l];
        }

        return structLanguages;
    }

    public void function exportLanguages(Struct arg_languages){
        var structLabels = Duplicate(arg_languages);
        var structLanguages = Duplicate(arg_languages);

        // modify structures to fit file format
        for(var l in arg_languages){Bean
            StructDelete( structLabels[l], "name");
            StructDelete( structLabels[l], "native");
            structLabels[l] = structLabels[l].labels;
            StructDelete( structLanguages[l], "labels");
        }

        var jsonLabels = SerializeJSON(structLabels);
        FileWrite("#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.resourcesDir#/#VARIABLES.applicationConfig.labelsJSON#", jsonLabels);

        var jsonLanguages = SerializeJSON(structLanguages);
        FileWrite("#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.resourcesDir#/#VARIABLES.applicationConfig.languagesJSON#", jsonLanguages);
    }

    private void function populateSettings(argSettings){

        var bf = VARIABLES.fw.getBeanFactory();

        VARIABLES.settings = [];

        for (var k in argSettings){
            VARIABLES.settings.append( bf.getBean( "Setting", { name: k, value: argSettings[k] } ) );
        }

    }

}