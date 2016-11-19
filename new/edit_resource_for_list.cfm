<cfinclude template="menu.cfm">
<cfif isdefined('url.topic_id')>
<cfquery name="get_category" datasource="who">
	SELECT set_name, set_id FROM dbo.[set] where set_id = 
	(SELECT parent_set_id FROM dbo.[set] WHERE set_id =<cfqueryparam sqltype="cf_sql_int" value="#url.topic_id#">)
</cfquery>
<cfquery name="get_topic" datasource="who">
	SELECT set_name, set_id FROM dbo.[set] where set_id = 
	<cfqueryparam sqltype="cf_sql_int" value="#url.topic_id#">
</cfquery>
</cfif>
<cfoutput>
<div>
<cfif isdefined('url.topic_id')>
<h3><a href="get_help.cfm?category_id=#get_category.set_id#">Return to #get_category.set_name#</a></h3>
<h4><a href="resource_list_by_topic.cfm?topic_id=#get_topic.set_id#">Return to #get_topic.set_name#</a></h4>
</cfif>
</div>
</cfoutput>
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
	dbo.item.set_item_index, 
	dbo.item.lng,
	dbo.item.lat,
	dbo.set_item.set_item_id,
	dbo.set_item.set_id AS Expr1
	FROM     dbo.item INNER JOIN
				 dbo.set_item ON dbo.item.item_id = dbo.set_item.item_id
	WHERE dbo.item.item_id = <cfqueryparam sqltype="cf_sql_int" value="#url.item_id#">
	ORDER BY title

</cfquery>
<cfoutput>
<h1>Edit Resource: #resource.title#</h1>
</cfoutput>
<a href="new_resource.cfm">New Resource</a>
<cfif isdefined('url.topic_id')>
<div>
<cfoutput>
<a href="add_resource_to_topic.cfm?topic_id=#url.topic_id#&item_id=#url.item_id#">Add this Resource to a different Topic<a>
</cfoutput>
</div>
</cfif>
<cfif isdefined('btn_save')>
	
	<cfquery name="update_resource" datasource="who">
		UPDATE   dbo.item
		SET
		
		title=<cfqueryparam sqltype="cf_sql_varchar" value="#form.title#">, 
		link=<cfqueryparam sqltype="cf_sql_varchar" value="#form.link#">, 
		description=<cfqueryparam sqltype="cf_sql_varchar" value="#form.description#">, 
		street=<cfqueryparam sqltype="cf_sql_varchar" value="#form.street#">,
		city=<cfqueryparam sqltype="cf_sql_varchar" value="#form.city#">,
		state=<cfqueryparam sqltype="cf_sql_varchar" value="#form.state#">,
		zip=<cfqueryparam sqltype="cf_sql_varchar" value="#form.zip#">,
		contact_information=<cfqueryparam sqltype="cf_sql_varchar" value="#form.contact_information#">,
		contact_email=<cfqueryparam sqltype="cf_sql_varchar" value="#form.contact_email#">,
		contact_form=<cfqueryparam sqltype="cf_sql_varchar" value="#form.contact_form#">,
		contact_phone=<cfqueryparam sqltype="cf_sql_varchar" value="#form.contact_phone#">
		WHERE item_id = <cfqueryparam sqltype="cf_sql_int" value="#url.item_id#">
		
		 
		 
		
	</cfquery>
	<cflocation addtoken="no" url="http://whocanhelp.org/resource_list_by_topic.cfm?topic_id=#url.topic_id#">
</cfif>



<cfoutput>
<form name="edit_resource" method="post">
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
<input type="submit" name="btn_save" value="Save">
</form>
<cfset use_street = replacenocase(#trim(resource.street)#," ","+","ALL")>
<cfset use_city = replacenocase(#trim(resource.city)#," ","+","ALL")>
<cfset use_state = replacenocase(#trim(resource.state)#," ","+","ALL")>
<cfset use_zip = replacenocase(#trim(resource.zip)#," ","+","ALL")>
<script>
lat = '#resource.lat#';
if (lat.length == 0){
	//alert('yes');
$.get( "https://maps.googleapis.com/maps/api/geocode/json?address=#use_street#,+#use_city#,+#use_state#&key=AIzaSyBp1_uutb0Me0nhVbjcp_2oGZ2VfycAnHM", function( data ) {
  jdata = data;
	jlat = jdata.results[0].geometry.location.lat;
	jlng = jdata.results[0].geometry.location.lng;
	
	 $.get("update_lat_long.cfm?item_id=#resource.item_id#&lat=" + jlat + "&lng=" + jlng, function(data, status){
       // alert("Data: " + data + "\nStatus: " + status);
		});
	});
	} else {
	jlat = #resource.lat#;
	jlng = #resource.lng#;
	}
	alert(jlat + ' ' + jlng);
</script>
</cfoutput>

<a href="new_resource.cfm">New Resource</a>

<cfinclude template="map.cfm">