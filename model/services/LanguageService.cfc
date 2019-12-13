component accessors="true" {

  property name="fw";
  property name="languagesFile";
  property name="labelsFile";
  property name="languages";

  public any function init(languagesFile, labelsFile){
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
            if(not structKeyExists(structLabels[s][i], l.getCode()))
              structLabels[s][i][l.getCode()] = "$#l.getCode()#:#s#.#i#"

            l.setLabel(s, i, structLabels[s][i][l.getCode()])
          }
        }
      }
    }

    return variables.languages
  }

  public any function getLanguage(arg_code){
    if(ArrayLen(variables.languages) eq 0)
      importLanguages()

    for(l in variables.languages){
      if(l.getCode() eq arg_code){
        return l
      }
    }
  }

  public void function exportLanguages(){
    var result = {}

    for(var lang in variables.languages){
      var labels = lang.getLabels()
      for(var section in labels){
        for(var item in labels[section]){
          //writeDump(section & '.' & item & ' : ' & labels[section][item]);
          if(not StructKeyExists(result, section))
            result[section] = {}

          if(not StructKeyExists(result[section], item))
            result[section][item] = {}

          if(not StructKeyExists(result[section][item], lang.getCode()))
            result[section][item][lang.getCode()] = labels[section][item]
            //writeDump(result)
        }
      }
    }

    FileWrite(labelsFile, formatJson(SerializeJSON(result)), "UTF-8")

    result = {}

    for(var lang in variables.languages)
      result[lang.getCode()] = {
        name : lang.getName(),
        native : lang.getNative()
      }

    FileWrite(languagesFile, formatJson(SerializeJSON(result)), "UTF-8")

  }

  public boolean function hasDirtyLanguage(){
    for(var lang in variables.languages)
      if(lang.isDirty()) return true

    return false
  }

  public void function setAllDirty(value){
    for(var lang in variables.languages)
      lang.setIsDirty(arguments.value)
  }

  private string function formatJson(val) {
    var result = ""
    var str = val
    var pos = 0
    var strLen = Len(str)
    var indentStr = "  "
    var newLine = chr(10)
    var char = ""
    var quoteOpened = false

    for(var i=1; i lte strLen; i++){
      char = Mid(str, i, 1)

      if(char eq '}' or char eq ']'){
        result &= newLine
        pos--
        for (var j=1; j lte pos; j++)
          result &= indentStr
      }

      if(char eq "'" or char eq '"'){
        quoteOpened = not quoteOpened
      }

      result &= char

      if(char eq ":")
        result &= " "

      if(char eq '{' or char eq '[' or (char eq ',' and not quoteOpened)){
        result &= newLine
        if (char eq '{' or char eq '[')
          pos++
        for (var k=1; k lte pos; k++)
          result &= indentStr
      }

    }

    result &= newLine

    return result
  }

}
