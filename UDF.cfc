<cfcomponent output="false">

    <cffunction name="i18n" access="public" returntype="string" output="false">
        <cfargument name="arg_token" type="string" required="true" />
        <cfargument name="arg_defaultlabel" type="string" required="false" default="" />

        <cfset result = "" />

        <cfset var ll = REQUEST.language.getLanguageLabels() />
        <cfset var section = ListFirst(arg_token, ".") />
        <cfset var anchor = ListLast(arg_token, ".") />

        <cfif StructKeyExists(ll, section)>
            <cfif StructKeyExists(ll[section], anchor)>
                <cfset result = ll[section][anchor] />
            </cfif>
        </cfif>

        <cfreturn result />
    </cffunction>

</cfcomponent>