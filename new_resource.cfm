<cfinclude template="menu.cfm">
<cfset do_search = true>



<h1>New Unassigned Resource</h1>

<cfif isdefined('btn_save')>
	<cfquery name="lookup_title" datasource="who">
		SELECT   
				title
		FROM     dbo.item
		WHERE title = <cfqueryparam sqltype="cf_sql_varchar" value="#form.title#">
	</cfquery>
	<cfif lookup_title.recordcount IS 0>
	<cfquery name="insert_resource" datasource="who" result="rs">
		INSERT INTO   dbo.resource
		(
		title, 
		link, 
		description, 
		contact_email,
		contact_information,
		contact_form,
		account_id,
		street,
		city,
		county,
		state,
		zip,
		contact_phone
		)
		VALUES(
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.title#">, 
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.link#">, 
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.description#">, 
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.contact_email#">, 
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.contact_information#">,
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.contact_form#">,
		<cfqueryparam sqltype="cf_sql_int" value="#session.account_id#">,
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.street#">,
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.city#">,
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.county#">,
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.state#">,
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.zip#">,
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.contact_phone#">
		)
	</cfquery>
		<cfset new_id = rs.identitycol>
		<cflocation addtoken="no" url="http://whocanhelp.org/all_resources.cfm?new_id=#new_id#">
	

	<cfelse>
		<h3>Sorry, that resource has already been entered</h3>
	</cfif>

</cfif>
<cfif isdefined('url.title')>
	<cfset use_title = url.title>
<cfelse>
	<cfset use_title  = "">
</cfif>

		<form name="new_resource" method="post">
		<table>
			<tr>
				<td width="100">
				Title
				</td>
				<td>
				<cfoutput>
				<input type="text" size="100" name="title" value="#use_title#">
				</cfoutput>
				</td>
			</tr>
			<tr>
				<td width="100">
				Website
				</td>
				<td>
				<input type="text" size="100" name="link">
				</td>
				</tr>
			<tr>
				<td width="100">
				Description
				</td>
				<td>
				<textarea name="description" rows="10" cols="80"></textarea>
				</td>
				</tr>
				<tr>
				<td width="100">
				Street
				</td>
				<td>
				<input type="text" size="100" name="street">
				</td>
				</tr>
				<tr>
				<td width="100">
				City
				</td>
				<td>
				<input type="text" size="100" name="city">
				</td>
				</tr>
				<tr>
				<td width="100">
				County
				</td>
				<td>
				<input type="text" size="100" name="county">
				</td>
				</tr>
			<tr>
				<td width="100">
				State
				</td>
				<td>
				<select name="state">
					<option></option>
					<cfoutput query="state_list">
						<cfset this_state = state>
						<cfif url.selected_state IS this_state>
						<option value="#state#" selected=true>#state# - #state_name#</option>
						<cfelse>
						<option value="#state#">#state# - #state_name#</option>
						</cfif>
						
					</cfoutput>
				</select>
				
				</td>
				</tr>
				<tr>
				<td width="100">
				ZIP
				</td>
				<td>
				<input type="text" size="100" name="zip">
				</td>
				</tr>
				<tr>
					<td width="100">
					Contact Email 
					</td>
					<td>
					<input type="text" size="100" name="contact_email">
					</td>
				</tr>
					<tr><td colspan="2">(an email address to request help)</td></tr>
				<tr>
					<td width="100">
					Contact Form 
					</td>
					<td>
					<input type="text" size="100" name="contact_form">
					</td>
				</tr>
					<tr><td colspan="2">(a form that needs to be filled out to request help)</td></tr>
				<tr>
					<td width="100">
					Contact Phone 
					</td>
					<td>
					<input type="text" size="100" name="contact_phone">
					</td>
				</tr>
					<tr><td colspan="2">(the main contact phone number)</td></tr>
				<tr>
				<td width="100">
				Other Contact Information
				</td>
				<td>
				<textarea name="contact_information" rows="10" cols="80"></textarea>
				</td>
				</tr>
		</table>
		<input type="submit" name="btn_save" value="Save">
		</form>

	
