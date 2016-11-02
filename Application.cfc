component extends="vendor.fw1.framework.one" {

    THIS.name = "clone" & hash( getCurrentTemplatePath() );
    THIS.applicationTimeout = createTimeSpan( 0, 0, 5, 0 );

    THIS.datasource = getParams("datasource");

    THIS.ormenabled = true;
    THIS.ormSettings.datasource = getParams("ormdatasource");

    THIS.mappings[ "/framework" ] = "#getDirectoryFromPath(getCurrentTemplatePath())#vendor/fw1/framework/";

    VARIABLES.framework = {
        action = 'do',
        usingSubsystems = true,
        defaultSubsystem = 'front',
        defaultSection = 'home',
        defaultItem = 'welcome',
        reloadApplicationOnEveryRequest = true,
        generateSES = true,
        SESOmitIndex = true,
        diLocations = 'model,controllers',
        initMethod = 'configure'
    };

    //public void function onApplicationStart(){
    //}

    public Any function getParams(String argParam = ""){
        var result = {};
        try{
          var jsonParams = FileRead("config/application.json", "utf-8");
          result = DeserializeJSON(jsonParams);
        }catch (any e){

        }

        result.rootDir = getDirectoryFromPath( getCurrentTemplatePath() );

        if(argParam NEQ ""){
            return StructFind(result, argParam);
        }else{
            return result;
        }
    }

    public void function setupApplication(){

        // loading application parameters which will be used by other services, for example LanguageService
        var configService = getBeanFactory().getBean( "ConfigService", { params = getParams() } );
        configService.configure();

        // loading available languages and labels for display
        var languageService = getBeanFactory().getBean("LanguageService");
        languageService.configure();

        //APPLICATION.securityService = getBeanFactory().getBean("SecurityService");

        REQUEST.momentStart = GetTickCount();
        WriteOutput("App set up <br />");
    }

    public void function setupRequest(){

        // get application language which may be overridden by user settings
        var languageService = getBeanFactory().getBean("LanguageService");
        REQUEST.language = languageService.getCurrentLanguage();

        var helperBean = getBeanFactory().getBean("Helper");
        StructAppend(URL, helperBean);

        param name="REQUEST.momentStart" default="#GetTickCount()#"; WriteOutput("Req set up <br />");

        //APPLICATION.securityService.checkUser();
    }

    public void function onRequestEnd(){
       var duration = GetTickCount() - REQUEST.momentStart;
       writedump(duration & " ms");

       var languageService = getBeanFactory().getBean("LanguageService");
       languageService.update();
    }

    public void function onError(exception, eventName){
        //writeDump(exception);writeDump(eventName);
        setLayout(getSubSystem() & ':layouts.default');
        super.onError(arguments.Exception, arguments.eventName);
    }

}