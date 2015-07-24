component extends="framework.one" {

    THIS.name = "Clone";
    THIS.ormenabled = true;
    THIS.datasource = "clone";

    variables.framework = {
        action = 'do',
        usingSubsystems = true,
        defaultSubsystem = 'front',
        defaultSection = 'home',
        defaultItem = 'welcome',
        reloadApplicationOnEveryRequest = true,
        generateSES = false,
        SESOmitIndex = true,
        // framework.ioc
        diEngine = 'di1',
        diLocations = 'model,controllers'
    }

    public void function setupApplication(){

        APPLICATION.languageService = getBeanFactory().getBean("LanguageService");
        APPLICATION.securityService = getBeanFactory().getBean("SecurityService");
        //var languageServiceDecorator = getBeanFactory().getBean("LanguageServiceDecorator");
        //var langs = languageServiceDecorator.getLanguages();

        //fileWrite('resources/languages.json', langs, 'utf-8');
    }

    public void function setupRequest(){
        REQUEST.language = APPLICATION.languageService.getLanguage("en");
        StructAppend(URL, CreateObject("component", "UDF"));
        APPLICATION.securityService.checkUser();
    }

    public void function onError(Exception, event){
        setLayout(getSubSystem() & ':layouts.default');
        super.onError(arguments.Exception, arguments.event);
    }

}
