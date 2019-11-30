component accessors="true" {

  property name="code";
  property name="name";
  property name="native";
  property name="labels";
  property name="isdirty";

  public any function init(String code, String name, String native) {

    variables.code = arguments.code
    variables.name = arguments.name
    variables.native = arguments.native
    variables.isDirty = false

    variables.labels = {}

    return this
  }

  public string function label(String arg_token, String arg_label = ""){
    return this.setLabel(ListFirst(arg_token, "."), ListLast(arg_token, "."), arg_label)
  }

  public string function getLabel(String arg_section, String arg_item, String arg_label = ""){
    return this.setLabel(arg_section, arg_item, arg_label)
  }

  public string function setLabel(String arg_section, String arg_item, String arg_label) {
    if ( not StructKeyExists(variables.labels, arg_section) ){
      variables.labels[arg_section] = {}
    }

    if ( not StructKeyExists(variables.labels[arg_section], arg_item) ){
      variables.labels[arg_section][arg_item] = ""
    }

    // overcoming strange cf behaviour for structGet
    if( IsStruct(variables.labels[arg_section][arg_item]) and StructIsEmpty(variables.labels[arg_section][arg_item]) ){
      variables.labels[arg_section][arg_item] = ""
    }

    if(arg_label neq "" and variables.labels[arg_section][arg_item] neq arg_label){
      variables.labels[arg_section][arg_item] = arg_label
      variables.isDirty = true
    }

    return variables.labels[arg_section][arg_item]
  }

  public boolean function isDirty(){
    return variables.isDirty
  }

  public Struct function toStruct(){
    var result = {};

    result[variables.code] = {
      'name' = variables.name,
      'native' = variables.native,
      'labels' = variables.labels
    };

    return result;
  }

}
