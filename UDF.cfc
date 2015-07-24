<cfcomponent output="false">

    <cffunction name="i18n" access="public" returntype="string" output="false">
        <cfargument name="arg_labelkey" type="string" required="true" />
        <cfargument name="arg_defaultlabel" type="string" required="false" default="" />
        <cfargument name="arg_replacements" type="array" required="false" default="#ArrayNew(1)#" />

        <cfset result = "" />

        <cfset var ll = REQUEST.language.getLanguageLabels() />
        <cfset var section = ListFirst(ARGUMENTS.arg_labelkey, ".") />
        <cfset var anchor = ListLast(ARGUMENTS.arg_labelkey, ".") />

        <cfif StructKeyExists(ll, section) AND StructKeyExists(ll[section], anchor)>
            <cfset result = ll[section][anchor] />
        <cfelse>
            <cfif Len(ARGUMENTS.arg_defaultlabel) GT 0>
                <cfset APPLICATION.languageService.setLanguageLabel(REQUEST.language, ARGUMENTS.arg_labelkey, ARGUMENTS.arg_defaultlabel) />
                <cfset result = ARGUMENTS.arg_defaultlabel />
            <cfelse>
                <cfset result = "MISSING:" & ARGUMENTS.arg_labelkey />
            </cfif>
        </cfif>

        <cfreturn result />
    </cffunction>

</cfcomponent>