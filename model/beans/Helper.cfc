<cfcomponent output="false">

    <cffunction name="i18n" access="public" returntype="string" output="false">
        <cfargument name="arg_labelkey" type="string" required="true" hint="Language Label is section.anchor" />
        <cfargument name="arg_defaultlabel" type="string" required="false" default="" />
        <cfargument name="arg_replacements" type="struct" required="false" default="#StructNew()#" />

        <cfset result = "" />

        <cfset var labels = REQUEST.language.getLabels() />
        <cfset var section = ListFirst(arg_labelkey, ".") />
        <cfset var anchor = ListLast(arg_labelkey, ".") />

        <cfif StructKeyExists(labels, section) AND StructKeyExists(labels[section], anchor)>
            <cfset result = labels[section][anchor] />
        <cfelse>
            <cfif Len(arg_defaultlabel) GT 0>
                <cfset REQUEST.language.setLabel(section, anchor, arg_defaultlabel) />
                <cfset result = arg_defaultlabel />
            <cfelse>
                <cfset result = "MISSING:" & arg_labelkey />
            </cfif>
        </cfif>

        <cfif NOT StructIsEmpty(arg_replacements)>
            <cfloop collection="#arg_replacements#" index="i">
                <cfset result = REReplaceNoCase(result, "\$#i#\$", StructFind(arg_replacements, i), "ALL" ) />
            </cfloop>
        </cfif>

        <cfreturn result />
    </cffunction>

</cfcomponent>