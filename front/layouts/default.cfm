<cffunction name="i18n"><cfreturn "test" /></cffunction>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <cfoutput>
    <title>#i18n('meta.title')#</title>
    </cfoutput>
    <!-- Bootstrap -->
    <link href="vendor/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Main styles -->
    <link href="front/assets/css/main.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>

<cfoutput>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="##navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.cfm">#i18n('menu.title')#</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#buildURL("home.about")#">#i18n('menu.about')#</a></li>
                <cfif NOT IsUserInRole("user")>
                    <li class="active"><a href="index.cfm?do=home.login">#i18n('menu.login')#</a></li>
                <cfelse>
                        <li><p class="navbar-text"><strong>#SESSION.user.getFirstName()# #SESSION.user.getLastName()#</strong></p></li>
                        <li class="active"><a href="index.cfm?do=user.logout">#i18n('menu.logout')#</a></li>
                </cfif>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</nav>
</cfoutput>

<cfparam name="rc.messages" default="#ArrayNew(1)#" />
<cfparam name="rc.infos" default="#ArrayNew(1)#" />
<cfparam name="rc.warnings" default="#ArrayNew(1)#" />
<cfparam name="rc.errors" default="#ArrayNew(1)#" />

<cfoutput>
<div class="container">

    <cfif ArrayLen(rc.messages) GT 0>
        <cfloop array="#rc.messages#" index="message">
            <div class="alert alert-success">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">
                    ?</button>
                <span class="glyphicon glyphicon-ok"></span> <strong>Success Message</strong>
                <hr class="message-inner-separator">
                <p>#message#</p>
            </div>
        </cfloop>
    </cfif>

    <cfif ArrayLen(rc.infos) GT 0>
        <cfloop array="#rc.infos#" index="info">
            <div class="alert alert-info">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">
                    ?</button>
                <span class="glyphicon glyphicon-info-sign"></span> <strong>Info Message</strong>
                <hr class="message-inner-separator">
                <p>#info#</p>
            </div>
        </cfloop>
    </cfif>

    <cfif ArrayLen(rc.warnings) GT 0>
        <cfloop array="#rc.warnings#" index="warning">
            <div class="alert alert-warning">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">
                    ?</button>
                <span class="glyphicon glyphicon-record"></span> <strong>Warning Message</strong>
                <hr class="message-inner-separator">
                <p>#warning#</p>
            </div>
        </cfloop>
    </cfif>


    <cfif ArrayLen(rc.errors) GT 0>
        <cfloop array="#rc.errors#" index="error">
            <div class="alert alert-danger">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">
                    ?</button>
                <span class="glyphicon glyphicon-hand-right"></span> <strong>Danger Message</strong>
                <hr class="message-inner-separator">
                <p>#error#</p>
            </div>
        </cfloop>
    </cfif>

    <cfoutput>#body#</cfoutput>

    <footer> <!--- TODO add language selector --->
        <p>&copy; #Year(Now())# Company, Inc.
            <!---
        <cfloop array="#rc.languageService.getLanguages()#" index="i">
             · <a href="#buildURL(rc.do)#">#i.getNative()#</a>
        </cfloop>
        --->
        </p>
    </footer>

</div>
</cfoutput>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="vendor/jquery/dist/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="vendor/bootstrap/dist/js/bootstrap.min.js"></script>
</body>
</html>

