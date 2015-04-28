component extends="framework.one" {

    THIS.name = "Clone";
    THIS.ormenabled = true;
    THIS.datasource = "clone";

    variables.framework = {
        action = 'action',
        usingSubsystems = false,
        defaultSection = 'home',
        defaultItem = 'welcome',
        reloadApplicationOnEveryRequest = false,
        generateSES = true,    
        SESOmitIndex = true,        
        // framework.ioc
        diEngine = 'di1',        
        diLocations = 'model,controllers'
    }

    function setupRequest(){

        var lm = getBeanFactory().getBean("LanguageService").init();

        writeDump(lm.getLanguages());

    }

}
