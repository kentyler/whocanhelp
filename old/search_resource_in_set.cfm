<cfinclude template="menu.cfm">
<cfparam name="form.search_title" default="">
<cfquery name="get_set" datasource="who">
SELECT set_name from dbo.[set] WHERE set_id = <cfqueryparam sqltype="cf_sql_int" value="#url.set_id#">
</cfquery>
<h1>New Resource</h1>
<cfoutput><h2>#get_set.set_name#</h2></cfoutput>
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
	<cfquery name="insert_set_item" datasource="who" result="rs">
	INSERT INTO   dbo.set_item
		( set_id, 
		item_id
		)
		VALUES(
		<cfqueryparam sqltype="cf_sql_int" value="#url.set_id#">,
		<cfqueryparam sqltype="cf_sql_int" value="#rs.generatedkey#">
		)
	</cfquery>
	<cflocation addtoken="no" url="http://whocanhelp.org/resource_list_by_topic.cfm?topic_id=#url.set_id#">
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
					<tr>
					<td colspan="3">
					<button type="button" onclick="document.location.href='http://whocanhelp.org/add_item_to_set.cfm?set_id=#url.set_id#&item_id=#item_id#'">Add to #get_set.set_name#</button>
					
					<button type="button" onclick="document.location.href='http://whocanhelp.org/new_resource_for_set.cfm?set_id=#url.set_id#&title=#form.search_title#';">Create a New Resource</button>
										<button type="button" onclick="">Cancel</button>
					</td>
				</tr>
			</cfoutput>
		</table>
		</cfoutput>
		
	<cfelse>
		<cflocation addtoken="no" url="http://whocanhelp.org/new_resource_for_set.cfm?set_id=#url.set_id#&title=#form.search_title#">
	</cfif>
</cfif>
<cfoutput>
<form name="search" method="post">
<h3>Before you create a new Resource search the database to see if the Resource has already been entered.</h3>
Type Resource Title <input type="text" size="100" name="search_title" value="#form.search_title#">
<input type="submit" name="btn_search" value="Search">
</form>
</cfoutput>