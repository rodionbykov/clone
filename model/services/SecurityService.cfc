<cfcomponent output="false">

    <cffunction name="init" access="public" returntype="any" output="false">
        <cfset THIS.arrGrantedTokens = [] />
        <cfreturn THIS />
    </cffunction>

  <cffunction name="log">

  </cffunction>

  <cffunction name="checkUser">
    <cfif structKeyExists(SESSION, "user")>
        <cfset SESSION.user = THIS.pass(SESSION.user.getSessionToken()) />
    <cfelse>
        <cfset SESSION.user = EntityNew("User") />
    </cfif>
  </cffunction>

  <cffunction name="login" output="false" hint="Login action" returntype="Struct">
    <cfargument name="arg_login" required="true" type="string" />
    <cfargument name="arg_password" required="true" type="string" />

    <cfset var qryUser = "" />
    <cfset var qryRoles = "" />
    <cfset var user = EntityNew("User") />

    <cfstoredproc procedure="usp_login">
      <cfprocparam type="in" cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.arg_login#" />
      <cfprocparam type="in" cfsqltype="CF_SQL_VARCHAR" value="#Hash(ARGUMENTS.arg_password)#" />
      <cfprocresult name="qryUser" resultset="1" />
      <cfprocresult name="qryRoles" resultset="2" />
    </cfstoredproc>

    <cfif qryUser.recordcount eq 1>
       <cfset LOCAL.user = EntityLoadByPK("User", LOCAL.qryUser.id) />
       <cfset LOCAL.user.setSessionToken(LOCAL.qryUser.sessiontoken) />
       <cflogin>
         <cfloginuser name = "#LOCAL.user.getLogin()#" password = "" roles = "#LOCAL.user.getRolesList()#"/>
       </cflogin>
    </cfif>

    <cfreturn user />
  </cffunction>

  <cffunction name="fblogin" output="false" hint="OAuth login action" returntype="Struct">
    <cfargument name="arg_fbid" required="true" type="string" />
    <cfargument name="arg_fbtoken" required="true" type="string" />

    <cfset var qryUser = "" />
    <cfset var qryRoles = "" />
    <cfset var qryTokens = "" />
    <cfset var fb_user = {id: 0, username: '', name: '', first_name: '', last_name: '', gender: '', link: '', locale: ''} />
    <cfset var user = { id: 0, login: '', firstname: '', lastname: '', email: '', moment: '', lastactionmoment: '', sessiontoken: '', usersession_isactive: 0, roles: [], tokens: [] } />
    <cfset var role = { id: 0,  pluralname: '', singularname: ''} />
    <cfset var token = { id: 0,  token: ''} />

    <cftry>
      <cfset var facebookGraphAPI = new FacebookGraphAPI(accessToken = ARGUMENTS.arg_fbtoken, appId = "") />
      <cfset var userObject = facebookGraphAPI.getObject(id = ARGUMENTS.arg_fbid) />

      <cfif structKeyExists(userObject, "id")>
        <cfset fb_user.id = userObject.id>
      </cfif>
      <cfif structKeyExists(userObject, "username")>
        <cfset fb_user.username = userObject.username>
      </cfif>
      <cfif structKeyExists(userObject, "name")>
        <cfset fb_user.name = userObject.name>
      </cfif>
      <cfif structKeyExists(userObject, "first_name")>
        <cfset fb_user.first_name = userObject.first_name>
      </cfif>
      <cfif structKeyExists(userObject, "last_name")>
        <cfset fb_user.last_name = userObject.last_name>
      </cfif>
      <cfif structKeyExists(userObject, "gender")>
        <cfset fb_user.gender = userObject.gender>
      </cfif>
      <cfif structKeyExists(userObject, "link")>
        <cfset fb_user.link = userObject.link>
      </cfif>
      <cfif structKeyExists(userObject, "locale")>
        <cfset fb_user.locale = userObject.locale>
      </cfif>

<!--- call login safely, as user was authenticated by fb --->
      <cfstoredproc procedure="usp_oauth_login">
        <cfprocparam type="in" cfsqltype="CF_SQL_VARCHAR" value="#fb_user.id#" />
        <cfprocparam type="in" cfsqltype="CF_SQL_VARCHAR" value="fb" />
        <cfprocresult name="qryUser" resultset="1" />
        <cfprocresult name="qryRoles" resultset="2" />
        <cfprocresult name="qryTokens" resultset="3" />
      </cfstoredproc>

<!--- if not logged in, register with fb credentials --->
      <cfif qryUser.RecordCount EQ 0>
        <cfstoredproc procedure="usp_oauth_register">
          <cfprocparam type="in" cfsqltype="CF_SQL_VARCHAR" value="#fb_user.id#" />
          <cfprocparam type="in" cfsqltype="CF_SQL_VARCHAR" value="fb" />
          <cfprocparam type="in" cfsqltype="CF_SQL_VARCHAR" value="#fb_user.username#" />
          <cfprocparam type="in" cfsqltype="CF_SQL_VARCHAR" value="#fb_user.first_name#" />
          <cfprocparam type="in" cfsqltype="CF_SQL_VARCHAR" value="#fb_user.last_name#" />
          <cfprocresult name="qryUser" resultset="1" />
          <cfprocresult name="qryRoles" resultset="2" />
          <cfprocresult name="qryTokens" resultset="3" />
        </cfstoredproc>
      </cfif>

      <cfif qryUser.recordcount eq 1>
        <cfset user.id = qryUser.id />
        <cfset user.login = qryUser.login />
        <cfset user.firstname = qryUser.firstname />
        <cfset user.lastname = qryUser.lastname />
        <cfset user.email = qryUser.email />
        <cfset user.sessiontoken = qryUser.sessiontoken />
        <cfset user.moment = qryUser.moment />
        <cfset user.lastactionmoment = qryUser.lastactionmoment />
        <cfset user.usersession_isactive = qryUser.usersession_isactive />

        <cfloop query="qryRoles">
          <cfset role = structNew() />
          <cfset role.id = qryRoles.id />
          <cfset role.pluralname = qryRoles.pluralname />
          <cfset role.singularname = qryRoles.singularname />
          <cfset arrayAppend(user.roles, role) />
        </cfloop>

        <cfloop query="qryTokens">
          <cfset token = structNew() />
          <cfset token.id = qryTokens.id />
          <cfset token.token = qryTokens.token />
          <cfset arrayAppend(user.tokens, token) />
        </cfloop>
      </cfif>

      <cfreturn user />
      <cfcatch>
        <cfsavecontent variable="err" >
          <cfdump var='#cfcatch#' />
        </cfsavecontent>
        <cffile action="write" file="#ExpandPath("err.html")#" output="#err#" />
      </cfcatch>
    </cftry>

<!---<cffile action="write" file="#ExpandPath("C:/Inetpub/wwwroot/default/dump.html")#" output="#output#" />--->

  </cffunction>

  <cffunction name="register" output="false" hint="Register user" returntype="Struct">
    <cfargument name="arg_login" required="true" type="string" />
    <cfargument name="arg_password" required="true" type="string" />
    <cfargument name="arg_email" required="true" type="string" />
    <cfargument name="arg_firstname" required="false" type="string" default="" />
    <cfargument name="arg_lastname" required="false" type="string" default="" />

    <cfset var qryUser = "" />
    <cfset var qryRoles = "" />
    <cfset var res = { id: 0, login: '', firstname: '', lastname: '', email: '', moment: '', lastactionmoment: '', sessiontoken: '', usersession_isactive: 0, roles: [], tokens: [] } />

    <cfstoredproc procedure="usp_register">
      <cfprocparam type="in" cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.arg_login#" />
      <cfprocparam type="in" cfsqltype="CF_SQL_VARCHAR" value="#Hash(ARGUMENTS.arg_password)#" />
      <cfprocparam type="in" cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.arg_email#" />
      <cfprocparam type="in" cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.arg_firstname#" />
      <cfprocparam type="in" cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.arg_lastname#" />
      <cfprocresult name="qryUser" resultset="1" />
      <cfprocresult name="qryRoles" resultset="2" />
    </cfstoredproc>

    <cfif qryUser.recordcount eq 1>
      <cfset res.id = qryUser.id />
      <cfset res.login = qryUser.login />
      <cfset res.firstname = qryUser.firstname />
      <cfset res.lastname = qryUser.lastname />
      <cfset res.email = qryUser.email />
      <cfset res.sessiontoken = qryUser.sessiontoken />
      <cfset res.moment = qryUser.moment />
      <cfset res.lastactionmoment = qryUser.lastactionmoment />
    </cfif>

    <cfreturn res />
  </cffunction>

  <cffunction name="pass" output="false" hint="Passing into system" returntype="Struct">
    <cfargument name="arg_sessiontoken" required="true" type="string" />

    <cfset var qryUser = "" />
    <cfset var qryRoles = "" />
    <cfset var user = EntityNew("User") />

    <cfstoredproc procedure="usp_pass">
      <cfprocparam type="in" cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.arg_sessiontoken#" />
      <cfprocresult name="qryUser" resultset="1" />
      <cfprocresult name="qryRoles" resultset="2" />
    </cfstoredproc>

    <cfif qryUser.recordcount eq 1>
      <cfset user = EntityLoadByPK("User", qryUser.id) />
      <cfset user.setSessionToken(qryUser.sessiontoken) />
    </cfif>

    <cfreturn user />
  </cffunction>

  <cffunction name="ping" output="false" hint="Pinging user into system" returntype="Struct">
    <cfargument name="arg_sessiontoken" required="true" type="string" />

    <cfset var qryUser = "" />
    <cfset var qryRoles = "" />
    <cfset var res = { id: 0, login: '', firstname: '', lastname: '', email: '', moment: '', lastactionmoment: '', sessiontoken: '', usersession_isactive: 0 } />

    <cfset res = THIS.pass(ARGUMENTS.arg_sessiontoken) />

    <cfif res.id GT 0>
      <cfstoredproc procedure="usp_ping">
        <cfprocparam type="in" cfsqltype="CF_SQL_INTEGER" value="#res.id#" />
      </cfstoredproc>
    </cfif>

    <cfreturn res />
  </cffunction>

  <cffunction name="logout" output="false" hint="Log out action" returntype="Struct">
    <cfargument name="arg_sessiontoken" required="true" type="string" />

    <cfset var user = EntityNew("User") />

    <cfstoredproc procedure="usp_logout">
      <cfprocparam type="in" cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.arg_sessiontoken#" />
      <cfprocresult name="qryUser" resultset="1" />
    </cfstoredproc>

    <cfif qryUser.recordcount eq 1>
      <cfset LOCAL.user = EntityLoadByPK("User", qryUser.id) />
      <cfset LOCAL.user.setSessionToken(qryUser.sessiontoken) />

      <cflogout />
    </cfif>

    <cfreturn LOCAL.user />
  </cffunction>

</cfcomponent>