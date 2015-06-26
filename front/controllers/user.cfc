component accessors="true" output="false" {

    property name="securityService";

    public void function init (any fw) {
        VARIABLES.fw = ARGUMENTS.fw;
    }

    public void function login (any rc) {
        SESSION.user = VARIABLES.securityService.login(rc.username, rc.passwd);
        VARIABLES.fw.redirect("home.welcome");
    }

    public void function logout (any rc) {
        SESSION.user = VARIABLES.securityService.logout(SESSION.user.getSessionToken());
        VARIABLES.fw.redirect("home.welcome");
    }

}