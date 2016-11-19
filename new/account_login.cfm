<cfinclude template="menu.cfm"><h1>Login</h1>

<cfif isdefined('btn_submit')>
	<cfif isdefined('chk_remember')>
		remember
	</cfif>
	<cfquery name="login" datasource="who">
		SELECT account_id, 
				account_name,
				account_email,
				account_phone,
				account_role_id
		FROM dbo.Account
		WHERE dbo.Account.account_email = <cfqueryparam sqltype="cf_sql_varchar" value="#form.email#">
		AND dbo.Account.account_password = <cfqueryparam sqltype="cf_sql_varchar" value="#form.password#">
	</cfquery>
	<cfset session.account_id = login.account_id>
	<cfset session.account_name = login.account_name>
	<cfset session.account_email = login.account_email>
	<cfset session.account_phone = login.account_phone>
	<cfif login.account_role_id IS 1>
		<cfset session.role = "Contributor">
	<cfelseif login.account_role_id IS 2>
		<cfset session.role = "Moderator">
	<cfelseif login.account_role_id IS 3>
		<cfset session.role = "Admin">
	<cfelse>
		<cfset session.role = "guest">
	</cfif>
	
	<cfif isdefined('session.bookmark')>
	<cflocation addtoken="no" url="http://whocanhelp.org#session.bookmark#?bookmark">
	<cfelse>
	<cflocation addtoken="no" url="http://whocanhelp.org/get_help.cfm">
	</cfif>
	
</cfif>

<p> Login to your Account</p>
<form method="post">
<table>
	<tr>
		<td>
		Your Email
		</td>
		<td>
		<input type="text" name="email" >
		</td>
	</tr>
	<tr>
		<td>
		Your Password
		</td>
		<td>
		<input type="password" name="password" >
		</td>
	</tr>
	<tr>
		<td colspan="2">
		<a href="forgot_password.cfm">I forgot my password</a>
		</td>
	</tr>
	</table>
	<input type="submit" name="btn_submit" value="Login">
	<div>
	<input type="checkbox" name="chk_remember" > Remember me on this computer.
	</div>
	<h3>Don't have an Account ? <a href="account_create.cfm">create one</a></h3>
</form>