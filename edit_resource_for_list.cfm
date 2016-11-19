<cfinclude template="menu.cfm">

<cfset resource_id = url.resource_id>
<cfinclude template="resource_by_resource_id.cfm">

<cfoutput>
<h1>Edit Resource: #resource.title#</h1>
</cfoutput>
<a href="new_resource.cfm">New Resource</a>

<div>
<cfoutput>
<a href="add_resource_to_topic.cfm?resource_id=#url.resource_id#">Add this Resource to a different Topic<a>
</cfoutput>
</div>

<cfif isdefined('btn_save')>
	<cfif isdefined('form.is_current')>
		<cfset current = 1>
	<cfelse>
		<cfset current = 0>
	</cfif>
	<cfquery name="update_resource" datasource="who">
		UPDATE   dbo.resource
		SET
		is_current=<cfqueryparam sqltype="cf_sql_bit" value="#current#">, 
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
		WHERE resource_id = <cfqueryparam sqltype="cf_sql_int" value="#url.resource_id#">
		
		 
		 
		
	</cfquery>
	<cflocation addtoken="no" url="http://whocanhelp.org/all_resources.cfm">
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
		Is Current
		</td>
		<td>
		<cfif resource.is_current is 1>
		<input type="checkbox"  name="is_current" checked=true>
		<cfelse>
		<input type="checkbox"  name="is_current" >
		</cfif>
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