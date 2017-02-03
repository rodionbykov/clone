component persistent="false" accessors="true" {

    property name="fw";

    public any function init(){
        return THIS;
    }

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

}