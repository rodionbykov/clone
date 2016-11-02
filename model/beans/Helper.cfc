<cfcomponent output="false">

    <cffunction name="i18n" access="public" returntype="string" output="false">
        <cfargument name="arg_labelkey" type="string" required="true" hint="Language Label is section.anchor" />
        <cfargument name="arg_defaultlabel" type="string" required="false" default="" />
        <cfargument name="arg_replacements" type="struct" required="false" default="#StructNew()#" />

        <cfset result = "" />

        <cfset var labels = REQUEST.language.getLabels() />
        <cfset var section = ListFirst(ARGUMENTS.arg_labelkey, ".") />
        <cfset var anchor = ListLast(ARGUMENTS.arg_labelkey, ".") />

        <cfif StructKeyExists(labels, section) AND StructKeyExists(labels[section], anchor)>
            <cfset result = labels[section][anchor] />
        <cfelse>
            <!--- not so fast
            <cfif Len(ARGUMENTS.arg_defaultlabel) GT 0>
                <cfset REQUEST.language.setLabel(REQUEST.language, ARGUMENTS.arg_labelkey, ARGUMENTS.arg_defaultlabel) />
                <cfset result = ARGUMENTS.arg_defaultlabel />
            <cfelse>
                <cfset result = "MISSING:" & ARGUMENTS.arg_labelkey />
            </cfif>
            --->
        </cfif>

        <cfreturn result />
    </cffunction>

</cfcomponent>