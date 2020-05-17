component accessors="true" {

  property name="name";
  property name="value";

  public any function init(String name="", String value=""){
    variables.name = arguments.name
    variables.value = arguments.value

    return this
  }

}
