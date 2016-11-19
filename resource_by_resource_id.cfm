<cfoutput>
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
	dbo.resource.set_item_index, 
	dbo.resource.lng,
	dbo.resource.lat,
	dbo.resource.is_current
	FROM     dbo.resource 
	WHERE dbo.resource.resource_id = <cfqueryparam sqltype="cf_sql_int" value="#resource_id#">


</cfquery>
</cfoutput>