<cfoutput>#i18n('home.welcome')#</cfoutput>

<cfdump var="#rc.user.getRolesList()#" />
<cfdump var="#rc.user.isGranted("user")#" label="has user" />
<cfdump var="#rc.user.isGranted("Administrator")#" label="has admin" />