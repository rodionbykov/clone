component accessors="true" {

  property name="code";
  property name="pluralname";
  property name="singularname";
  property name="tokens";

  public any function init(String code, String pluralname, String singularname) {

    variables.code = arguments.code
    variables.pluralname = arguments.pluralname
    variables.singularname = arguments.singularname
    variables.tokens = []

    return this
  }

}
