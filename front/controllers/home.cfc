component {

    public void function init (any fw) {

        VARIABLES.fw = ARGUMENTS.fw;

    }

    public void function welcome (any rc) {

        var l = APPLICATION.languageService.getLanguage('en');
        rc.welcome = l.getlanguagelabels()['home']['welcome'];

    }

}