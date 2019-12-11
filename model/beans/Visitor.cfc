component accessors="true"{

  property name="firstVisit";
  property name="lastVisit";
  property name="remoteIP";
  property name="userAgent";
  property name="roles";

  public any function init(String remoteIP, String userAgent = ""){
    variables.firstVisit = Now()
    variables.lastVisit = Now()
    variables.remoteIP = arguments.remoteIP
    variables.userAgent = arguments.userAgent
    variables.roles = []
  }

}
