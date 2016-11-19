<cfinclude template="menu.cfm">
<cfparam name="form.search_title" default="">

<h1>New Resource</h1>

<cfif isdefined('btn_save')>
	<cfquery name="lookup_title" datasource="who">
		SELECT   item_id,
				title
		FROM     dbo.item
		WHERE title = <cfqueryparam sqltype="cf_sql_varchar" value="#form.title#">
	</cfquery>
	<cfif lookup_title.recordcount IS 0>
	<cfquery name="insert_resource" datasource="who" result="rs">
		INSERT INTO   dbo.item
		(
		item_type_id, 
		title, 
		link, 
		description, 
		contact_email,
		contact_information,
		contact_form,
		account_id,
		street,
		city,
		state,
		zip,
		contact_phone
		)
		VALUES(
		
		1, 
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.title#">, 
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.link#">, 
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.description#">, 
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.contact_email#">, 
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.contact_information#">,
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.contact_form#">,
		<cfqueryparam sqltype="cf_sql_int" value="#session.account_id#">,
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.street#">,
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.city#">,
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.state#">,
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.zip#">,
		<cfqueryparam sqltype="cf_sql_varchar" value="#form.contact_phone#">
		)
	</cfquery>
	
	<cflocation addtoken="no" url="http://whocanhelp.org/all_resources.cfm">
	<cfelse>
		<h3>Sorry, that resource has already been entered</h3>
	</cfif>
<cfelseif isdefined('btn_search')>
	<cfquery name="search_title" datasource ="who">
		SELECT title, city, street, item_id
		FROM dbo.item
		WHERE title LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.search_title#%">
	</cfquery>
	<cfif search_title.recordcount GT 0>
		<cfoutput>
		<h3>Resources with names like '#form.search_title#' are already in the Database.</h3>
		<table cellspacing="2" border="1">
			<cfoutput query="search_title">
				<tr>
					<td>
					#title#
					</td>
					<td>
					#street#
					</td>
					<td>
					#city#
					</td>
					</tr>
					
			</cfoutput>
		</table>
		
					<button type="button" onclick="document.location.href='http://whocanhelp.org/new_resource.cfm?title=#form.search_title#';">Create a New Resource</button>
										<button type="button" onclick="">Cancel</button>
		</cfoutput>
		
	<cfelse>
		<cflocation addtoken="no" url="http://whocanhelp.org/new_resource.cfm?title=#form.search_title#">
	</cfif>
</cfif>
