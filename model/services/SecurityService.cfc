component accessors="true" {

  property name="fw";
  property name="rolesFile";
  property name="securityFile";
  property name="tokens";
  property name="roles";

  public any function init(rolesFile, securityFile){
    variables.rolesFile = arguments.rolesFile
    variables.securityFile = arguments.securityFile
    variables.tokens = {}
    variables.roles = []

    return this
  }

  public any function importRoles(){
    variables.tokens = {}
    variables.roles = []

    if( FileExists(variables.rolesFile) ){
      var jsonRoles = FileRead(variables.rolesFile)
      var arrRoles = DeserializeJSON(jsonRoles)

      for(var r in arrRoles)
        ArrayAppend(variables.roles, variables.fw.getBeanFactory().getBean("Role", { code = r.code, pluralname = r.pluralname, singularname = r.singularname }))

      if( FileExists(variables.securityFile) ){
        var jsonTokens = FileRead(variables.securityFile, "utf-8")
        variables.tokens = DeserializeJSON(jsonTokens)

        var strRoles = {}

        for(var s in variables.tokens)
          for(var i in variables.tokens[s])
            for(var r in variables.tokens[s][i]){
              if(not StructKeyExists(strRoles, r))
                strRoles[r] = []

              ArrayAppend(strRoles[r], s & "." & i)
            }

        for(var r in variables.roles)
          if(structKeyExists(strRoles, r.getCode()))
            r.setTokens(strRoles[r.getCode()])

      }
    }

    return variables.roles
  }

  public any function getRole(arg_rolecode){
    if(ArrayLen(variables.roles) eq 0)
      importRoles()

    for(var r in variables.roles)
      if(r.getCode() eq arg_rolecode)
        return r

    return false
  }

  public any function allow(arg_token){
    if(ArrayLen(variables.roles) eq 0)
      importRoles()

    var section = ListFirst(arg_token, ".")
    var item = ListLast(arg_token, ".")

    if(not StructKeyExists(variables.tokens, section))
      return true

    if(not StructKeyExists(variables.tokens[section], item))
      return true

    if(isUserInAnyRole(variables.tokens[section][item]))
      return true

    return false
  }

  public any function login(){
    cflogin(){
        cfloginuser(name="test@gmail.com", password="12345", roles="user")
      }
      writedump(getUserRoles())
      writedump(getAuthUser())
  }

/*
    public any function getUser(){
       return VARIABLES.fw.getBeanFactory().getBean("UserBean");
    }

    public any function login(string arg_login, string arg_passwd){
        var qryUser = "";
        var qryRoles = "";
        var user = VARIABLES.fw.getBeanFactory().getBean("UserBean");

        storedproc procedure="usp_login" {
            procparam type="in" sqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.arg_login#";
            procparam type="in" sqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.arg_passwd#";
            procresult name="qryUser" resultset="1";
            procresult name="qryRoles" resultset="2";
        }

        if(qryUser.recordcount eq 1){
            LOCAL.user = EntityLoadByPK("User", LOCAL.qryUser.id);
        }

        return LOCAL.user;
    }
*/

}
