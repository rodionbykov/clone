component accessors="true" {

  property name="fw";
  property name="settingsFile";
  property name="settings";

  public any function init(any settingsFile){
    variables.settingsFile= arguments.settingsFile
    variables.settings = []

    return this
  }

  public Array function getSettings(){
    if( ArrayLen(variables.settings) eq 0 )
      this.populateSettings( importSettings() )

    return variables.settings
  }

  public any function getSetting(String k){
    var result = false

    if ( ArrayLen(variables.settings) eq 0 ){
      this.getSettings()
    }

    for (var s in variables.settings){
      if(s.getName() eq k){
        result = s
      }
    }

    return result
  }

  public any function getValue(String arg_name){
    return this.getSetting(arg_name).getValue()
  }

  public Struct function importSettings(){
    if( FileExists(variables.settingsFile) )
      var jsonSettings = FileRead(variables.settingsFile, "utf-8")

    var structSettings = DeserializeJSON(jsonSettings)

    return structSettings
  }

  public Array function populateSettings(Struct arg_settings){
    var bf = variables.fw.getBeanFactory()

    variables.settings = []

    for(var k in arg_settings){
      variables.settings.append( bf.getBean( "Setting", { name: k, value: arg_settings[k] } ) )
    }

    return variables.settings
  }

}
