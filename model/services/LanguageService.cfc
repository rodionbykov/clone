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

        <cfstoredproc procedure="get_language_labels">
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

    <cffunction name="setLanguageLabel" access="public" returntype="void" output="false">
        <cfargument name="arg_language" type="any" required="true" />
        <cfargument name="arg_labelkey" type="string" required="true" />
        <cfargument name="arg_label" type="string" required="true" />

        <cfset var section = ListFirst(ARGUMENTS.arg_labelkey, ".") />
        <cfset var anchor = ListLast(ARGUMENTS.arg_labelkey, ".") />

        <cfstoredproc procedure="set_language_label">
            <cfprocparam cfsqltype="CF_SQL_CHAR" value="#ARGUMENTS.arg_language.getCode()#" />
            <cfprocparam cfsqltype="CF_SQL_VARCHAR" value="#LOCAL.section#" />
            <cfprocparam cfsqltype="CF_SQL_VARCHAR" value="#LOCAL.anchor#" />
            <cfprocparam cfsqltype="CF_SQL_LONGVARCHAR" value="#ARGUMENTS.arg_label#" />
            <cfprocresult name="LOCAL.languagelabel" />
        </cfstoredproc>

        <cfif LOCAL.languagelabel.RecordCount EQ 1>
            <cfset arg_language.setLanguageLabel(LOCAL.section, LOCAL.anchor, ARGUMENTS.arg_label) />
        </cfif>

    </cffunction>

</cfcomponent>