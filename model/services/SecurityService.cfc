component accessors="true" {

  property name="fw";
  property name="securityFile";
  property name="tokens";

  public any function init(securityFile){
    variables.securityFile = arguments.securityFile
    variables.tokens = {}

    return this
  }

    public any function importTokens(){

    if( FileExists(variables.securityFile) ){
      var jsonTokens = FileRead(variables.securityFile, "utf-8")
      var structTokens = DeserializeJSON(jsonTokens)

      for(s in structLanguages){
        var l = variables.fw.getBeanFactory().getBean( "Language",
          { code = s, name = structLanguages[s]["name"], native = structLanguages[s]["native"] }
        )
        variables.languages.append(l)
      }
    }

    return variables.tokens
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

UPDATE `06_mailing_aanmeldingen`
		SET status_aanmelding = 0, opt_in = 0, datum_aanmelding = NOW(), datum_opt_in = NOW()
		WHERE actie_id IN (SELECT actie_id FROM `01_actie` WHERE merk_id = var_brand_id)
			AND gegevens_id IN (SELECT gegevens_id FROM `04_gegevens` WHERE email = var_email);