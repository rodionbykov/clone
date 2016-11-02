<cfcomponent persistent="false" accessors="true" output="true">

    <cfproperty name="fw" />
    <cfproperty name="languages" />
    <cfproperty name="currentLanguage" />

    <cfproperty name="configService" />

    <cffunction name="init" access="public" returntype="any" output="false">
        <cfargument name="fw" required="true" />

        <cfset VARIABLES.languages = ArrayNew(1) />
        <cfset VARIABLES.currentLanguage = false />

        <cfreturn THIS />
    </cffunction>

    <cffunction name="configure" access="public" returntype="any" output="false">

        <cfset var structLanguages = VARIABLES.configService.importLanguages() />

        <!--- loading languages --->
        <cftry>
            <cfloop collection="#structLanguages#" index="i">
                <cfset var l = VARIABLES.fw.getBeanFactory().getBean( "Language", { code = i, name = StructFind(structLanguages, i)["name"], native = StructFind(structLanguages, i)["native"] } ) />
                <cfset l.setLabels( StructFind(structLanguages, i)["labels"] ) />
                <cfset ArrayAppend(VARIABLES.languages, l) />
            </cfloop>

            <cfcatch>
                <cfdump var="#cfcatch#">
            </cfcatch>
        </cftry>

        <cfset var configLanguage = VARIABLES.configService.getSetting("language") />

        <cfloop array="#VARIABLES.languages#" index="i">
            <cfif i.getCode() EQ configLanguage.getValue()>
                <cfset LOCAL.result = i />
                <cfset THIS.setCurrentLanguage(i) />
            </cfif>
        </cfloop>

        <cfreturn THIS />
    </cffunction>

    <cffunction name="update" access="public" returntype="void" output="false">
        <cfset var result = {} />

        <cfloop array="#VARIABLES.languages#" index="i">
            <cfset StructAppend( LOCAL.result, i.toStruct(), true ) />
        </cfloop>

        <cfset VARIABLES.configService.exportLanguages(LOCAL.result) />
    </cffunction>

    <cffunction name="findOne" access="public" returntype="any" output="false"
                hint="Returns Language object by provided language code">
        <cfargument name="arg_languagecode" type="string" required="true" />

        <cfset var result = StructNew() />

        <cfreturn LOCAL.result />
    </cffunction>

</cfcomponent>