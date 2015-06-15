component {

    public void function init (any fw) {

        VARIABLES.fw = ARGUMENTS.fw;

    }

    public void function welcome (any rc) {
        rc.user = EntityLoadByPK("User", 2);
    }

}