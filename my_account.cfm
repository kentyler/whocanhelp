<cfinclude template="menu.cfm"><h1>My Account</h1>

<cfquery name="get_account" datasource="who">
	SELECT   dbo.account.account_id, dbo.account.account_name, dbo.account.account_email, dbo.account.account_phone, dbo.account.account_password, dbo.account.is_approved, dbo.account.account_user_name, dbo.account_role.account_role
	FROM     dbo.account INNER JOIN
             dbo.account_role ON dbo.account.account_role_id = dbo.account_role.account_role_id
	WHERE dbo.account.account_id=<cfqueryparam sqltype="cf_sql_int" value="#session.account_id#">
</cfquery>

<cfquery name="get_account" datasource="who">
	SELECT   dbo.account.account_id, dbo.account.account_name, dbo.account.account_email, dbo.account.account_phone, dbo.account.account_password, dbo.account.is_approved, dbo.account.account_user_name, dbo.account_role.account_role
	FROM     dbo.account INNER JOIN
             dbo.account_role ON dbo.account.account_role_id = dbo.account_role.account_role_id
	WHERE dbo.account.account_id=<cfqueryparam sqltype="cf_sql_int" value="#session.account_id#">
</cfquery>

<cfquery name="account_resource_list" datasource="who">
	SELECT   dbo.item.item_id, 
	dbo.item.set_id, 
	dbo.item.item_type_id, 
	dbo.item.title, 
	dbo.item.link, 
	dbo.item.street, 
	dbo.item.city,
	dbo.item.directions,
	dbo.item.state, 
	dbo.item.zip, 
	dbo.item.contact_information, 
	dbo.item.contact_email,
	dbo.item.contact_form,
	dbo.item.contact_phone,
	dbo.item.description, 
	dbo.item.account_id, 
	dbo.item.date_and_time
	
	FROM     dbo.item
		WHERE dbo.item.account_id=<cfqueryparam sqltype="cf_sql_int" value="#session.account_id#">
	ORDER BY title
</cfquery>

<cfoutput>
<form method="post">
<table>
	<tr>
		<td>
		Name
		</td>
		<td>
		<input type="text" name="account_name" value="#get_account.account_name#">
		</td>
	</tr>
	<tr>
		<td>
		Phone
		</td>
		<td>
		<input type="text" name="account_phone" value="#get_account.account_phone#">
		</td>
	</tr>
	<tr>
		<td>
		Email
		</td>
		<td>
		<input type="text" name="account_password" value="#get_account.account_email#">
		</td>
	</tr>
	<tr>
		<td>
		Password
		</td>
		<td>
		<input type="password" name="password" value="#get_account.account_password#">
		</td>
	</tr>
	<tr>
		<td>
		Site Role
		</td>
		<td>
		<b>#get_account.account_role#</b>
		</td>
	</tr>
	
	
	</table>
	</form>
	<cfinclude template="account_related_accounts.cfm">
	
	</cfoutput>
	
	<h3>Resources Entered</h3>
	<cfoutput query="account_resource_list">
	
		<div style="background-color:lightblue">
		<b style="font-size:115%">#title#</b>
		<cfif session.role NEQ "Guest">
			<a href="edit_resource.cfm?item_id=#item_id#"><font color="blue">edit</font></a>
		 </cfif>
		 <cfif account_id IS session.account_id OR session.role IS "Moderator" OR session.role IS "Admin">
			<a href="delete_resource.cfm?item_id=#item_id#&return_to=my_account"><font color="red">delete</font></a>
		 </cfif>

		 </div>
		 <cfif len(link) gt 0>
			<a style="margin-left:10px" href="#link#">web site</a>
		 </cfif>
		 <cfif len(directions) gt 0>
			<a style="margin-left:10px" href="#directions#">directions</a>
		 </cfif>
		 <div style="margin-left:20px;">#description#</div> 
		<div>
		<cfif len(contact_email) gt 0>
			email=<a href="mailto:#contact_email#">#contact_email#</a>
		</cfif>
		<cfif len(contact_form) gt 0>
			web_form=<a href="#contact_form#">contact form</a>
		 </cfif>
		 <cfif len(contact_phone)>
			phone=<a href="tel:#contact_phone#">#contact_phone#</a>
		 </cfif>
		 
		</div>


	</cfoutput>