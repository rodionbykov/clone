component accessors="true" {

  property name="fw";
  property name="languagesFile";
  property name="labelsFile";
  property name="languages";

  public any function init(any languagesFile, any labelsFile){
    variables.languagesFile = arguments.languagesFile
    variables.labelsFile = arguments.labelsFile
    variables.languages = []

    return this
  }

  public any function importLanguages(){

    if( FileExists(variables.languagesFile) ){
      var jsonLanguages = FileRead(variables.languagesFile, "utf-8")
      var structLanguages = DeserializeJSON(jsonLanguages)

      for(s in structLanguages){
        var l = variables.fw.getBeanFactory().getBean( "Language",
          { code = s, name = structLanguages[s]["name"], native = structLanguages[s]["native"] }
        )
        variables.languages.append(l)
      }
    }

    if( FileExists(variables.labelsFile) ){
      var jsonLabels = FileRead(variables.labelsFile, "utf-8")
      var structLabels = DeserializeJSON(jsonLabels)

      for(s in structLabels){
        for(i in structLabels[s]){
          for(l in variables.languages){
            l.setLabel(s, i, structLabels[s][i][l.getCode()])
          }
        }
      }
    }

    return variables.languages
  }

  public any function getLanguage(String arg_code){

    if(ArrayLen(variables.languages) eq 0)
      importLanguages()

    for(l in variables.languages){
      if(l.getCode() eq arg_code){
        return l
      }
    }
  }

// todo all languages export to json
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
      FileWrite("#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.resourcesDir#/#VARIABLES.applicationConfig.labelsJSON#", jsonLabels);

      var jsonLanguages = SerializeJSON(structLanguages);
      FileWrite("#VARIABLES.applicationConfig.rootDir#/#VARIABLES.applicationConfig.resourcesDir#/#VARIABLES.applicationConfig.languagesJSON#", jsonLanguages);
  }

}
