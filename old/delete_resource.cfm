<cfinclude template="menu.cfm">


<h1>Edit Resource</h1>
<a href="new_resource.cfm">New Resource</a>
<cfif isdefined('btn_delete')>
	
	<cfquery name="update_resource" datasource="who">
		DELETE FROM   dbo.item
		WHERE item_id = <cfqueryparam sqltype="cf_sql_int" value="#url.item_id#">

	</cfquery>
	<cfif isdefined('url.set_id')>
		<cflocation addtoken="no" url="http://whocanhelp.org/resource_list_by_topic.cfm?topic_id=#url.set_id#">
	<cfelseif isdefined('url.return_to')>
		<cflocation addtoken="no" url="http://whocanhelp.org/my_account.cfm">
	<cfelse>
		<cflocation addtoken="no" url="http://whocanhelp.org/all_resources.cfm">
	
	</cfif>
	
<cfelseif isdefined('btn_cancel')>
	<cflocation addtoken="no" url="http://whocanhelp.org/resource_list_by_topic.cfm?topic_id=#url.set_id#">
</cfif>
<cfquery name="resource" datasource="who">
	SELECT   dbo.item.item_id, 
	dbo.item.set_id, 
	dbo.item.item_type_id, 
	dbo.item.title, 
	dbo.item.link, 
	dbo.item.street,
	dbo.item.city,
	dbo.item.state,
	dbo.item.zip,	
	dbo.item.contact_information, 
	dbo.item.contact_email, 
	dbo.item.contact_form, 
	dbo.item.contact_phone,
	dbo.item.description, 
	dbo.item.account_id, 
	dbo.item.date_and_time, 
	dbo.item.set_item_index
	FROM     dbo.item 
	WHERE dbo.item.item_id = <cfqueryparam sqltype="cf_sql_int" value="#url.item_id#">
	ORDER BY title

</cfquery>


<cfoutput>
<form name="edit_resource" method="post">
<h2> Are you sure you want to delete this resource ?</h2>
<input type="submit" value="Yes. Delete it." name="btn_delete">
<input type="submit" value="No. Cancel." name="btn_cancel">
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
