component persistent="false" accessors="true" {

    property name="fw";
    property name="params";
    property name="settings";

    public any function init(any params){

        VARIABLES.params = ARGUMENTS.params;
        VARIABLES.settings = [];

        return THIS;
    }

    public any function configure(){
        THIS.getSettings();
    }

    public Array function getSettings(){
        if ( ArrayLen(VARIABLES.settings) EQ 0 ){
            var structSettings = importSettings();
            THIS.populateSettings( structSettings );
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
        if( FileExists( "#VARIABLES.params.rootDir#/#VARIABLES.params.configDir#/#VARIABLES.params.settingsJSON#" ) AND NOT FileExists( "#VARIABLES.params.rootDir#/#VARIABLES.params.resourcesDir#/#VARIABLES.params.settingsJSON#" )){
            FileCopy( "#VARIABLES.params.rootDir#/#VARIABLES.params.configDir#/#VARIABLES.params.settingsJSON#", "#VARIABLES.params.rootDir#/#VARIABLES.params.resourcesDir#/#VARIABLES.params.settingsJSON#" );
        }

        if( FileExists("#VARIABLES.params.rootDir#/#VARIABLES.params.resourcesDir#/#VARIABLES.params.settingsJSON#") ){
            var jsonSettings = FileRead("#VARIABLES.params.rootDir#/#VARIABLES.params.resourcesDir#/#VARIABLES.params.settingsJSON#", "utf-8");
        }

        var structSettings = DeserializeJSON(jsonSettings);

        return structSettings;
    }

    public Struct function importLanguages(){

        if( FileExists( "#VARIABLES.params.rootDir#/#VARIABLES.params.configDir#/#VARIABLES.params.languagesJSON#" ) AND NOT FileExists( "#VARIABLES.params.rootDir#/#VARIABLES.params.resourcesDir#/#VARIABLES.params.languagesJSON#" )){
            FileCopy( "#VARIABLES.params.rootDir#/#VARIABLES.params.configDir#/#VARIABLES.params.languagesJSON#", "#VARIABLES.params.rootDir#/#VARIABLES.params.resourcesDir#/#VARIABLES.params.languagesJSON#" );
        }

        if( FileExists("#VARIABLES.params.rootDir#/#VARIABLES.params.resourcesDir#/#VARIABLES.params.languagesJSON#") ){
            var jsonLanguages = FileRead("#VARIABLES.params.rootDir#/#VARIABLES.params.resourcesDir#/#VARIABLES.params.languagesJSON#", "utf-8");
        }

        if( FileExists( "#VARIABLES.params.rootDir#/#VARIABLES.params.configDir#/#VARIABLES.params.labelsJSON#" ) AND NOT FileExists( "#VARIABLES.params.rootDir#/#VARIABLES.params.resourcesDir#/#VARIABLES.params.labelsJSON#" )){
           FileCopy( "#VARIABLES.params.rootDir#/#VARIABLES.params.configDir#/#VARIABLES.params.labelsJSON#", "#VARIABLES.params.rootDir#/#VARIABLES.params.resourcesDir#/#VARIABLES.params.labelsJSON#" );
        }

        if( FileExists("#VARIABLES.params.rootDir#/#VARIABLES.params.resourcesDir#/#VARIABLES.params.labelsJSON#") ){
            var jsonLabels = FileRead("#VARIABLES.params.rootDir#/#VARIABLES.params.resourcesDir#/#VARIABLES.params.labelsJSON#", "utf-8");
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
        for(var l in arg_languages){
            StructDelete( structLabels[l], "name");
            StructDelete( structLabels[l], "native");
            structLabels[l] = structLabels[l].labels;
            StructDelete( structLanguages[l], "labels");
        }

        var jsonLabels = SerializeJSON(structLabels);
        FileWrite("#VARIABLES.params.rootDir#/#VARIABLES.params.resourcesDir#/#VARIABLES.params.labelsJSON#", jsonLabels);

        var jsonLanguages = SerializeJSON(structLanguages);
        FileWrite("#VARIABLES.params.rootDir#/#VARIABLES.params.resourcesDir#/#VARIABLES.params.languagesJSON#", jsonLanguages);
    }

    private void function populateSettings(argSettings){

        var bf = VARIABLES.fw.getBeanFactory();

        VARIABLES.settings = [];

        for (var k in argSettings){
            VARIABLES.settings.append( bf.getBean( "Setting", { name: k, value: argSettings[k] } ) );
        }

    }

}