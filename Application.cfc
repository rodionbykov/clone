component extends="framework.one" {

    THIS.name = "Clone12312";
    THIS.ormenabled = true;
    THIS.datasource = "clone";

    variables.framework = {
        action = 'action',
        usingSubsystems = true,
        defaultSubsystem = 'front',
        defaultSection = 'home',
        defaultItem = 'welcome',
        reloadApplicationOnEveryRequest = true,
        generateSES = true,
        SESOmitIndex = true,
        // framework.ioc
        diEngine = 'di1',
        diLocations = 'model,controllers'
    }

    void function setupApplication(){

        var APPLICATION.languageService = getBeanFactory().getBean("LanguageService");
        var languageServiceDecorator = getBeanFactory().getBean("LanguageServiceDecorator");
        var langs = languageServiceDecorator.getLanguages();

        fileWrite('resources/languages.json', langs, 'utf-8');

    }

    void function onError(Exception, event){
        setLayout(getSubSystem() & ':layouts.default');
        super.onError(arguments.Exception, arguments.event);
    }

    void function setupRequest(){

    }

}
