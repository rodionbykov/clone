component extends="vendor.fw1.framework.one" {

  this.name = "clone" & hash( getCurrentTemplatePath() );
  this.applicationTimeout = createTimeSpan( 0, 1, 0, 0 );
  this.sessionmanagement = "true";
  this.sessiontimeout = createtimespan(0, 0, 10, 0);
  this.loginstorage = "session";

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
  variables.rolesFilename = "roles.json";
  variables.securityFilename = "security.json";
  variables.settingsFile = variables.configDir & "/" & variables.settingsFilename;
  variables.languagesFile = variables.configDir & "/" & variables.languagesFilename;
  variables.labelsFile = variables.configDir & "/" & variables.labelsFilename;
  variables.rolesFile = variables.configDir & "/" & variables.rolesFilename;
  variables.securityFile = variables.configDir & "/" & variables.securityFilename;

  variables.framework = {
    action = 'do',
    usingSubsystems = false,
    defaultSection = 'home',
    defaultItem = 'welcome',
    error = 'home.error',
    reloadApplicationOnEveryRequest = true,
    generateSES = false,
    SESOmitIndex = false,
    diLocations = 'model,controllers'
  };

  //public void function onApplicationStart(){
  //}

  public void function setupApplication(){
    try{
      if (not DirectoryExists( variables.configDir )){
        DirectoryCreate( variables.configDir )
      }
    }catch(any e){
      throw("Cannot create config directory")
    }
    try{
      if(not FileExists(variables.settingsFile))
        FileCopy(variables.setupDir & "/" & variables.settingsFilename, variables.configDir)
      if(not FileExists(variables.languagesFile))
        FileCopy(variables.setupDir & "/" & variables.languagesFilename, variables.configDir)
      if(not FileExists(variables.labelsFile))
        FileCopy(variables.setupDir & "/" & variables.labelsFilename, variables.configDir)
      if(not FileExists(variables.rolesFile))
        FileCopy(variables.setupDir & "/" & variables.rolesFilename, variables.configDir)
      if(not FileExists(variables.securityFile))
        FileCopy(variables.setupDir & "/" & variables.securityFilename, variables.configDir)
    }catch(any e){
      throw("Cannot copy setup files");
    }

    // writeDump(getApplicationMetadata())
    // writeDump(getApplicationSettings())

    //APPLICATION.securityService = getBeanFactory().getBean("SecurityService")

    // loading application parameters which will be used by other services, for example LanguageService
    var configService = getBeanFactory().getBean("ConfigService", { settingsFile = variables.settingsFile })

    // loading available languages and labels for display
    var languageService = getBeanFactory().getBean("LanguageService", { languagesFile = variables.languagesFile, labelsFile = variables.labelsFile } )

    // loading security tokens
    var securityService = getBeanFactory().getBean("SecurityService", { rolesFile = variables.rolesFile, securityFile = variables.securityFile })

    REQUEST.momentStart = GetTickCount()
  }

  public void function setupRequest(){

    // ORMRELOAD();

    var configService = getBeanFactory().getBean("ConfigService")
    var languageService = getBeanFactory().getBean("LanguageService")

    REQUEST.language = languageService.getLanguage( configService.getValue("language") )

    var helperBean = getBeanFactory().getBean("Helper")
    StructAppend(URL, helperBean); // hack I probably read on Ray Camden blog but I not sure

    param name="REQUEST.momentStart" default="#GetTickCount()#";

    var securityService = getBeanFactory().getBean("SecurityService")
    writedump(securityService.getRole("user"))

    //REQUEST.user = securityService.getUser()

    // check if current URL is accessible to user
    // user should have roles and roles have tokens associated with them
    //APPLICATION.securityService.checkUser()
  }

  public void function onRequestEnd(){
      request.duration = GetTickCount() - request.momentStart
      writedump(var="#request.duration#", label="duration, ms")

      var languageService = getBeanFactory().getBean("LanguageService");
      if(languageService.hasDirtyLanguage()){
        languageService.exportLanguages()
        languageService.setAllDirty(false)
        writedump("wrote file")
      }
  }

  public void function onError(exception, eventName){
      include 'error.cfm'
  }

}
