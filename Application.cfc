component extends="vendor.fw1.framework.one" {

    THIS.name = "clone" & hash( getCurrentTemplatePath() );
    THIS.applicationTimeout = createTimeSpan( 0, 0, 5, 0 );

    THIS.datasource = getApplicationConfig("datasource");

    THIS.ormenabled = true;

    THIS.mappings[ "/framework" ] = getApplicationConfig("rootDir") & "vendor/fw1/framework/";

    THIS.customTagPaths = "./customtags";

    VARIABLES.framework = {
        action = 'do',        
        usingSubsystems = true,
        defaultSubsystem = 'front',
        defaultSection = 'home',
        defaultItem = 'welcome',
        subsystemDelimiter = ':',        
        error = 'front:home.error',
        reloadApplicationOnEveryRequest = true,
        generateSES = false,
        SESOmitIndex = false,
        diLocations = 'model,controllers',
        initMethod = 'configure'
    };

    //public void function onApplicationStart(){
    //}

    public any function getApplicationConfig(string argParam = ""){
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
        var configService = getBeanFactory().getBean( "ConfigService", { applicationConfig = getApplicationConfig() } );
        configService.configure();
writedump(configService.getSettings());
        // loading available languages and labels for display
        //var languageService = getBeanFactory().getBean("LanguageService");
        //languageService.configure();

        //APPLICATION.securityService = getBeanFactory().getBean("SecurityService");

        REQUEST.momentStart = GetTickCount();
        WriteOutput("App set up ");
    }

    public void function setupRequest(){
ORMRELOAD();
        // get application language which may be overridden by user settings
        //var languageService = getBeanFactory().getBean("LanguageService");
        //REQUEST.language = languageService.getCurrentLanguage();

        var helperBean = getBeanFactory().getBean("Helper");
        StructAppend(URL, helperBean);

        param name="REQUEST.momentStart" default="#GetTickCount()#";
        WriteOutput("Req set up");

        //var securityService = getBeanFactory().getBean("SecurityService");

        //REQUEST.user = securityService.getUser();

        // check if current URL is accessible to user
        // user should have roles and roles have tokens associated with them
        //APPLICATION.securityService.checkUser();
    }

    public void function onRequestEnd(){
       var duration = GetTickCount() - REQUEST.momentStart;
       writedump(duration & " ms");

       // TODO do it only in dev mode, not live mode
       var languageService = getBeanFactory().getBean("LanguageService");
       languageService.update();
    }

    public void function onError(exception, eventName){
        include 'error.cfm';
    }

}