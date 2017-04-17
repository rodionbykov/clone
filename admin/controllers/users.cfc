component accessors="true" output="false" {

    property name="securityService";

    public void function init (any fw) {
        VARIABLES.fw = ARGUMENTS.fw;
    }

    public void function before(any rc) {
        param name="rc.messages" default=ArrayNew(1);
        param name="rc.errors" default=ArrayNew(1);
        param name="rc.infos" default=ArrayNew(1);
        param name="rc.warnings" default=ArrayNew(1);
    }

    public void function list(any rc){
       rc.users = EntityLoad("User");
    }

}