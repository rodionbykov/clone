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

    public void function login (any rc) {
        var user = VARIABLES.securityService.login(rc.username, rc.passwd);

        if(LOCAL.user.getID() GT 0) {
            ArrayAppend(rc.messages, i18n("login.welcome", "Welcome back!"));
            SESSION.user = LOCAL.user;
        }else{
            ArrayAppend(rc.errors, i18n("login.incorrect", "Login incorrect, please try again"));
        }

        VARIABLES.fw.redirect("home.login", "all");

        // TODO cflogin here !
    }

    public void function logout (any rc) {
        SESSION.user = VARIABLES.securityService.logout(SESSION.user.getSessionToken());
        VARIABLES.fw.redirect("home.welcome", "all");
    }

}
