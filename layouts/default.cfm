<cfoutput>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>#i18n('meta.title', 'Clone')#</title>
    <!-- Bootstrap -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Main styles -->
    <link href="assets/css/main.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>

<nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
      <a class="navbar-brand" href="##">#i18n('menu.title', 'Clone')#</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="##navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

<div class="collapse navbar-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item active">
            <a class="nav-link" href="##">Home<span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="##">Link</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="http://example.com" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Dropdown</a>
            <div class="dropdown-menu" aria-labelledby="dropdown01">
              <a class="dropdown-item" href="##">Action</a>
              <a class="dropdown-item" href="##">Another action</a>
              <a class="dropdown-item" href="##">Something else here</a>
            </div>
          </li>
        </ul>
        <form class="form-inline my-2 my-lg-0">
          <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
      </div>
    </nav>

<!--- <ul class="nav navbar-nav navbar-right">
    <li><a href="#buildURL("home.about")#">#i18n('menu.about', 'About')#</a></li>
    <cfif NOT IsUserInRole("user")>
        <li class="active"><a href="index.cfm?do=home.login">#i18n('menu.login', 'Login')#</a></li>
    <cfelse>
            <li><p class="navbar-text"><strong>#SESSION.user.getFirstName()# #SESSION.user.getLastName()#</strong></p></li>
            <li class="active"><a href="index.cfm?do=user.logout">#i18n('menu.logout', 'Log out')#</a></li>
    </cfif>
</ul> --->


  <main role="main" class="container">
    <cfoutput>#body#</cfoutput>
  </main><!-- /.container -->

  <footer class="footer">
    <div class="container">
      <span class="text-muted">#i18n('layout.copyright', '&copy; $YEAR$ Company, Inc.', {'YEAR' = Year(Now())})#</span>
    </div>
  </footer>

</div>
</cfoutput>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="vendor/jquery/jquery-3.4.1.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
