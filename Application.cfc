component extends="vendor.fw1.framework.one" {

  this.name = "clone" & hash( getCurrentTemplatePath() );
  this.applicationTimeout = createTimeSpan( 0, 0, 5, 0 );

  this.datasource= "clone";
  this.ormenabled = true;

  this.mappings[ "/framework" ] = ExpandPath("./vendor/fw1/framework/");
  this.customTagPaths = ExpandPath("./customtags");

  variables.rootDir = getDirectoryFromPath( getCurrentTemplatePath() );
  variables.configDir = rootDir & "/config";
  variables.setupDir = rootDir & "/setup";
  variables.settingsFilename = "settings.json";
  variables.languagesFilename = "languages.json";
  variables.labelsFilename = "labels.json";
  variables.settingsFile = variables.configDir & "/" & variables.settingsFilename;
  variables.languagesFile = variables.configDir & "/" & variables.languagesFilename;
  variables.labelsFile = variables.configDir & "/" & variables.labelsFilename;

  variables.framework = {
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

  public void function setupApplication(){
    try{
      if (not DirectoryExists( VARIABLES.configDir )){
        DirectoryCreate( VARIABLES.configDir );
      }
    }catch(any e){
      throw("Cannot create config directory");
    }
    try{
      if(not FileExists(VARIABLES.settingsFile))
        FileCopy(VARIABLES.setupDir & "/" & VARIABLES.settingsFilename, VARIABLES.configDir);
      if(not FileExists(VARIABLES.languagesFile))
        FileCopy(VARIABLES.setupDir & "/" & VARIABLES.languagesFilename, VARIABLES.configDir);
      if(not FileExists(VARIABLES.labelsFile))
        FileCopy(VARIABLES.setupDir & "/" & VARIABLES.labelsFilename, VARIABLES.configDir);
    }catch(any e){
      throw("Cannot copy setup files");
    }
// writeDump(getApplicationMetadata());
// writeDump(getApplicationSettings());

        // loading application parameters which will be used by other services, for example LanguageService
        var configService = getBeanFactory().getBean( "ConfigService", { settingsFile = VARIABLES.settingsFile } );
        configService.configure();
writedump(configService.getSettings());
WRITEDUMP(configService.getSetting("locale"));

        // loading available languages and labels for display
        var languageService = getBeanFactory().getBean("LanguageService", { languagesFile = VARIABLES.languagesFile, labelsFile = VARIABLES.labelsFile } )
        languageService.configure()
        writedump(languageService.getLanguages())
        var currLang = (languageService.getLanguage( configService.getValue("language") ))
        writeOutput(currLang.label("home.welcome"))
        abort;

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
       // var languageService = getBeanFactory().getBean("LanguageService");
       // languageService.update();
    }

    public void function onError(exception, eventName){
        include 'error.cfm';
    }

}