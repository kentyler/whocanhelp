<cfinclude template="menu.cfm">
<cfquery name="set_list" datasource="who">
		SELECT set_id, set_name
		FROM dbo.[set]
		WHERE dbo.[set].set_id <> <cfqueryparam sqltype="cf_sql_int" value="#url.set_id#">
		AND dbo.[set].set_name IS NOT NULL
		AND dbo.[set].set_id > 10
	</cfquery>
<h1>Edit Resource</h1>
<a href="new_resource.cfm">New Resource</a>
<cfif isdefined('btn_delete')>
	
	<cfquery name="update_resource" datasource="who">
		DELETE FROM   dbo.set_item
		WHERE item_id = <cfqueryparam sqltype="cf_sql_int" value="#url.item_id#">
		AND set_id = <cfqueryparam sqltype="cf_sql_int" value="#url.set_id#">

	</cfquery>
	<cflocation addtoken="no" url="http://whocanhelp.org/resource_list_by_topic.cfm?topic_id=#url.set_id#">

<cfelseif isdefined('btn_cancel')>
	<cflocation addtoken="no" url="http://whocanhelp.org/resource_list_by_topic.cfm?topic_id=#url.set_id#">
</cfif>
<cfquery name="resource" datasource="who">
	SELECT   dbo.item.item_id, dbo.item.set_id, dbo.item.item_type_id, dbo.item.title, dbo.item.link, dbo.item.street, dbo.item.city, dbo.item.state, dbo.item.zip, dbo.item.contact_information, dbo.item.contact_email, dbo.item.contact_form, dbo.item.contact_phone, dbo.item.description, dbo.item.account_id, dbo.item.date_and_time, 
             dbo.item.set_item_index, dbo.set_item.set_item_id, dbo.set_item.set_id AS Expr1, dbo.[set].set_name
FROM     dbo.item INNER JOIN
             dbo.set_item ON dbo.item.item_id = dbo.set_item.item_id INNER JOIN
             dbo.[set] ON dbo.set_item.set_id = dbo.[set].set_id
	WHERE dbo.item.item_id = <cfqueryparam sqltype="cf_sql_int" value="#url.item_id#">
	ORDER BY title

</cfquery>


<cfoutput>
<h3>#resource.set_name#</h3>
<form name="edit_resource" method="post">
<h2>This will remove this resource from #resource.set_name#, but the resource will not be deleted.</h2>
<input type="submit" value="Yes. Remove it." name="btn_delete">
<input type="submit" value="No. Cancel." name="btn_cancel">
<h3>Or, you can move this resource to a different topic</h3>
<select name="new_set_id">
	<option></option>
	<cfloop query="set_list">
	<option value="#set_id#">#set_name#</option>
	</cfloop>
</select>
<div>
<input type="submit" value="Move" name="btn_move">
</div>
<table>
	<tr>
		<td>
		Title
		</td>
		<td>
		<input type="text" size="100" name="title" value="#resource.title#">
		</td>
	</tr>
	<tr>
		<td>
		Website
		</td>
		<td>
		<input type="text" size="100" name="link" value="#resource.link#">
		</td>
		</tr>
	<tr>
		<td>
		Description
		</td>
		<td>
		<textarea name="description" rows="10" cols="80">#resource.description#</textarea>
		</td>
		</tr>
	<tr>
		<td>
		Address
		</td>
		<td>
		<input type="text" size="100" name="street" value="#resource.street#">
		</td>
		</tr>
		<tr>
		<td>
		City
		</td>
		<td>
		<input type="text" size="100" name="city" value="#resource.city#">
		</td>
		</tr>
		<tr>
		<td>
		State
		</td>
		<td>
		<input type="text" size="100" name="state" value="#resource.state#">
		</td>
		</tr>
		<tr>
		<td>
		ZIP
		</td>
		<td>
		<input type="text" size="100" name="zip" value="#resource.zip#">
		</td>
		</tr>
		<tr>
		<td>
		Contact Information
		</td>
		<td>
		<textarea name="contact_information" rows="10" cols="80">#resource.contact_information#</textarea>
		</td>
		</tr>
		<tr>
		<td>
		Contact Email (an email address to request help)
		</td>
		<td>
		<input type="text" size="100" name="contact_email" value="#resource.contact_email#">
		</td>
		</tr>
		<tr>
		<td>
		Contact Form (a form that needs to be filled out to request help)
		</td>
		<td>
		<input type="text" size="100" name="contact_form" value="#resource.contact_form#">
		</td>
		</tr>
		<tr>
		<td>
		Contact Phone (the main contact phone number)
		</td>
		<td>
		<input type="text" size="100" name="contact_phone" value="#resource.contact_phone#">
		</td>
		</tr>
</table>

</form>
</cfoutput>
