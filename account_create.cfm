<cfinclude template="menu.cfm"><h1>Create an Account</h1>

<cfif isdefined('btn_submit')>
	<cfquery name="lookup_email" datasource="who">
		SELECT account_id, account_name from dbo.Account
		WHERE dbo.Account.account_email = <cfqueryparam sqltype="cf_sql_varchar" value="#form.email#">
		</cfquery>
	<cfif lookup_email.recordcount GT 0>
		<h3>This email has already been used to create an account.</h3>
	<cfelse>
		<cfif len(class_code) gt 0>
			<cfset account_role_id = 1>
			<cfset session.role = "Contributor">
		<cfelse>
			<cfset account_role_id = 4>
			<cfset session.role="Guest">
		</cfif>
		
		<cfquery name="lookup_email" datasource="who" result="rs">
			INSERT INTO dbo.Account(account_name,
					account_email,
					account_phone,
					account_password,
					class_code,
					account_role_id)
			VALUES(<cfqueryparam sqltype="cf_sql_varchar" value="#form.name#">,
			<cfqueryparam sqltype="cf_sql_varchar" value="#form.email#">,
			<cfqueryparam sqltype="cf_sql_varchar" value="#form.phone#">,
			<cfqueryparam sqltype="cf_sql_varchar" value="#form.password#">,
			<cfqueryparam sqltype="cf_sql_varchar" value="#form.class_code#">,
			<cfqueryparam sqltype="cf_sql_int" value="#account_role_id#">)
		</cfquery>
		Your account has been created.
		<cfset session.account_id = rs.generatedkey>
		<cfset session.account_name = form.name>
		<cflocation URL="http://whocanhelp.org/index.cfm" addtoken="no">
	</cfif>
	
</cfif>

<p>Create an Account</p>
<form method="post">
<table>
	<tr>
		<td>
		Your Name 
		</td>
		<td>
		<input type="text" name="name" >
		</td>
	</tr>
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
		Your Phone Number
		</td>
		<td>
		<input type="text" name="phone" >
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
		<td>
		Class Code</br>(if your teacher provided one)
		</td>
		<td>
		<input type="text" name="class_code" >
		</td>
	</tr>
	
	</table>
	<input type="submit" name="btn_submit" value="Save">
</form>