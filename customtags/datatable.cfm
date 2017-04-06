<cfparam name="ATTRIBUTES.width" default="100%" />
<cfparam name="ATTRIBUTES.border" default="0" />
<cfparam name="ATTRIBUTES.class" default="" />

<cfparam name="ATTRIBUTES.data" default="#ArrayNew(1)#" />
<cfparam name="ATTRIBUTES.cols" default="#StructNew()#" />

<cfif THISTAG.ExecutionMode EQ "Start">
    <cfoutput>
    <table width="#ATTRIBUTES.width#" border="#ATTRIBUTES.border#" class="#ATTRIBUTES.class#">
        <thead>
            <tr>
                <cfloop collection="#ATTRIBUTES.cols#" item="c">
                <th>#StructFind(ATTRIBUTES.cols, c)#</th>
                </cfloop>
            </tr>
        </thead>
        <tbody>
        <cfif IsArray(ATTRIBUTES.data)>
            <cfloop array="#ATTRIBUTES.data#" index="r">
            <tr>
                <cfloop collection="#ATTRIBUTES.cols#" item="c">
                <td></td>
                </cfloop>
            </tr>
            </cfloop>
        </cfif>
        </tbody>
    </table>
    </cfoutput>
</cfif>