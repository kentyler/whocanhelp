<cfset structClear(session)>
<cfset session.Role = "Guest">
<cfset session.Account_id = 0>
<h3>You are logged out</h3>
<a href="account_login.cfm">Log In</a>
<h4><a href="get_help.cfm">Home</a>
