component accessors="true"{

  public String function i18n(String arg_token, String arg_label = "", Struct arg_replacements = {}){
    var result = request.language.label(arg_token, arg_label)

    if (not StructIsEmpty(arg_replacements)){
      for(r in arg_replacements){
        result = REReplaceNoCase(result, "\$#r#\$", StructFind(arg_replacements, r), "ALL")
      }
    }

    return result
  }

}
