<cfinclude template="menu.cfm"><h1>Retrieve Password</h1>

<cfif isdefined('btn_submit')>
	<cfif isdefined('chk_remember')>
		remember
	</cfif>
	<cfquery name="find" datasource="who">
		SELECT account_id, 
				account_name,
				account_email,
				account_phone,
				account_role_id,
				account_password
		FROM dbo.Account
		WHERE dbo.Account.account_email = <cfqueryparam sqltype="cf_sql_varchar" value="#form.email#">
	</cfquery>
	
	<cfif find.recordcount gt 0>
		<cfmail subject="Your request to WhoCanHelp.org" from="ken@whocanhelp.org" to="#find.account_email#">
			<cfloop query="find">
			Here is your password for WhoCanHelp.org: #account_password#
			</cfloop>
		</cfmail>
		Your password as been emailed to you.
		<cfset success = true>
	<cfelse>
		Sorry, we can't find that email.
		<cfset success = false>
	</cfif>
	
</cfif>


<cfif isdefined('success') and success IS true>

<cfelse>
<p>I Forgot My Password</p>
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
		
		
		</table>
		<input type="submit" name="btn_submit" value="Search">
		
	</form>
</cfif>