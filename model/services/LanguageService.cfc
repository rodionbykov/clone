<cfcomponent persistent="false" accessors="true" output="false">

    <cfproperty name="languages" />

    <cffunction name="init" access="public" returntype="any" output="false">

        <cfset VARIABLES.languages = EntityLoad("Language") />

        <cfloop array="#VARIABLES.languages#" index="l">
            <cfset l.setLanguageLabels(THIS.getLanguageLabels(l.getCode())) />
        </cfloop>

        <cfreturn THIS />
    </cffunction>

    <cffunction name="getLanguage" access="public" returntype="any" output="false">
        <cfargument name="arg_languagecode" type="string" required="true" />

        <cfset var result = 0 />

        <cfloop array="#VARIABLES.languages#" index="l">
            <cfif l.getCode() EQ ARGUMENTS.arg_languagecode>
                <cfset LOCAL.result = l />
            </cfif>
        </cfloop>

        <cfreturn LOCAL.result />
    </cffunction>

    <cffunction name="getLanguageLabels" access="public" returntype="struct" output="false">
        <cfargument name="arg_languagecode" type="string" required="true" />

        <cfset var result = StructNew() />

        <cfstoredproc procedure="getLanguageLabels">
            <cfprocparam cfsqltype="CF_SQL_CHAR" value="#ARGUMENTS.arg_languagecode#" />
            <cfprocresult name="LOCAL.languagelabels" resultset="1" />
            <cfprocresult name="LOCAL.sections" resultset="2" />
            <cfprocresult name="LOCAL.languages" resultset="3" />
        </cfstoredproc>

        <cfloop query="LOCAL.sections">
            <cfset LOCAL.section = LOCAL.sections.section />
            <cfset StructInsert(LOCAL.result, LOCAL.section, StructNew()) />
            <cfquery dbtype="query" name="LOCAL.qrySectionAnchors">
                SELECT anchor, label
                FROM LOCAL.languagelabels
                WHERE section = '#LOCAL.section#'
            </cfquery>
            <cfloop query="LOCAL.qrySectionAnchors">
                <cfset StructInsert(LOCAL.result['#LOCAL.section#'], LOCAL.qrySectionAnchors.anchor, LOCAL.qrySectionAnchors.label) />
            </cfloop>
        </cfloop>

        <cfreturn LOCAL.result />
    </cffunction>

</cfcomponent>