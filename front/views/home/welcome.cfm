<cfoutput>

    <div class="starter-template">
        <h1>#i18n('home.title')#</h1>
        <p class="lead">
            #i18n('home.welcome')#
        </p>
    </div>

</cfoutput>

<!---
<cfdump var="#rc.user#" />
<cfdump var="#rc.user.getRolesList()#" />
<cfdump var="#SESSION.user.isGranted("user")#" label="has user" />
<cfdump var="#rc.user.isGranted("Administrator")#" label="has admin" />
--->