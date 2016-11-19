<cfinclude template="menu.cfm">
Back to <a href="all_resources.cfm">All Resources</a>

<h3>Hide Resource</h3>
<a href="new_resource.cfm">New Resource</a>
<cfif not isdefined('url.category_topic_id')>
<cfif isdefined('btn_delete')>
	
	<cfquery name="update_resource" datasource="who">
		UPDATE dbo.resource
		SET is_current = 0
		WHERE resource_id = <cfqueryparam sqltype="cf_sql_int" value="#url.resource_id#">

	</cfquery>
	<cfif isdefined('url.category_topic_id')>
		<cflocation addtoken="no" url="http://whocanhelp.org/resource_list_by_topic.cfm?category_topic_id=#url.category_topic_id#">
	<cfelseif isdefined('url.return_to')>
		<cflocation addtoken="no" url="http://whocanhelp.org/my_account.cfm">
	<cfelse>
		<cflocation addtoken="no" url="http://whocanhelp.org/all_resources.cfm">
	
	</cfif>
	
<cfelseif isdefined('btn_cancel')>
	<cflocation addtoken="no" url="http://whocanhelp.org/all_resources.cfm">
</cfif>
<cfelse>

</cfif>

<cfquery name="resource" datasource="who">
	SELECT   dbo.resource.resource_id, 
	
	 
	dbo.resource.title, 
	dbo.resource.link, 
	dbo.resource.street,
	dbo.resource.city,
	dbo.resource.state,
	dbo.resource.zip,	
	dbo.resource.contact_information, 
	dbo.resource.contact_email, 
	dbo.resource.contact_form, 
	dbo.resource.contact_phone,
	dbo.resource.description, 
	dbo.resource.account_id, 
	dbo.resource.date_and_time, 
	dbo.resource.set_item_index
	FROM     dbo.resource 
	WHERE dbo.resource.resource_id = <cfqueryparam sqltype="cf_sql_int" value="#url.resource_id#">
	ORDER BY dbo.resource.title

</cfquery>


<cfoutput>
<form name="delete_resource" method="post">
<h2> Are you sure you want to hide this resource ?</h2>
<input type="submit" value="Yes. Hide it." name="btn_delete">
<input type="submit" value="No. Cancel." name="btn_cancel">
<table>
	<tr>
		<td>
		Title
		</td>
		<td>
		#resource.title#
		</td>
	</tr>
	<tr>
		<td>
		Website
		</td>
		<td>
		#resource.link#
		</td>
		</tr>
	<tr>
		<td>
		Description
		</td>
		<td>
		#resource.description#
		</td>
		</tr>
	<tr>
		<td>
		Address
		</td>
		<td>
		#resource.street#
		</td>
		</tr>
		<tr>
		<td>
		City
		</td>
		<td>
		#resource.city#
		</td>
		</tr>
		<tr>
		<td>
		State
		</td>
		<td>
		#resource.state#
		</td>
		</tr>
		<tr>
		<td>
		ZIP
		</td>
		<td>
		#resource.zip#
		</td>
		</tr>
		<tr>
		<td>
		Contact Information
		</td>
		<td>
		#resource.contact_information#
		</td>
		</tr>
		<tr>
		<td>
		Contact Email (an email address to request help)
		</td>
		<td>
		#resource.contact_email#
		</td>
		</tr>
		<tr>
		<td>
		Contact Form (a form that needs to be filled out to request help)
		</td>
		<td>
		#resource.contact_form#
		</td>
		</tr>
		<tr>
		<td>
		Contact Phone (the main contact phone number)
		</td>
		<td>
		#resource.contact_phone#
		</td>
		</tr>
</table>

</form>
</cfoutput>
