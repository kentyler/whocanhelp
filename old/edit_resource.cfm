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

<cfif isdefined('form.btn_save_resource')>
	
	<cfquery name="update_resource" datasource="who">
		UPDATE   dbo.item
		SET
		title=<cfqueryparam sqltype="cf_sql_varchar" value="#form.title#">, 
		link=<cfqueryparam sqltype="cf_sql_varchar" value="#form.link#">, 
		description=<cfqueryparam sqltype="cf_sql_varchar" value="#form.description#">, 
		street=<cfqueryparam sqltype="cf_sql_varchar" value="#form.street#">,
		city=<cfqueryparam sqltype="cf_sql_varchar" value="#form.city#">,
		county=<cfqueryparam sqltype="cf_sql_varchar" value="#form.county#">,
		state=<cfqueryparam sqltype="cf_sql_varchar" value="#form.state#">,
		zip=<cfqueryparam sqltype="cf_sql_varchar" value="#form.zip#">,
		contact_information=<cfqueryparam sqltype="cf_sql_varchar" value="#form.contact_information#">,
		contact_email=<cfqueryparam sqltype="cf_sql_varchar" value="#form.contact_email#">,
		contact_form=<cfqueryparam sqltype="cf_sql_varchar" value="#form.contact_form#">,
		contact_phone=<cfqueryparam sqltype="cf_sql_varchar" value="#form.contact_phone#">,
		account_id=<cfqueryparam sqltype="cf_sql_int" value="#form.account_id#">
		WHERE item_id = <cfqueryparam sqltype="cf_sql_int" value="#url.item_id#">
		
	</cfquery>
	<!---<cfif isdefined('url.topic_id')>
	<cflocation addtoken="no" url="http://whocanhelp.org/resource_list_by_topic.cfm?topic_id=#url.topic_id#">
	<cfelse>
	<!--- <cflocation addtoken="no" url="http://whocanhelp.org/resource_list.cfm"> --->
	</cfif>--->
</cfif>

<cfquery name="account_list" datasource="who">
	SELECT account_id, account_name
	FROM account
	ORDER BY account_name
</cfquery>
<cfquery name="resource" datasource="who">
	SELECT   dbo.item.item_id, 
	dbo.item.set_id, 
	dbo.item.item_type_id, 
	dbo.item.title, 
	dbo.item.link, 
	dbo.item.street,
	dbo.item.city,
	dbo.item.county,
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
	FROM     dbo.item LEFT OUTER JOIN
				 dbo.set_item ON dbo.item.item_id = dbo.set_item.item_id
	WHERE dbo.item.item_id = <cfqueryparam sqltype="cf_sql_int" value="#url.item_id#">
	ORDER BY title

</cfquery>
<cfoutput>

</cfoutput>
<a href="new_resource.cfm">New Resource</a>
<cfif isdefined('url.topic_id')>
	<div>
	<cfoutput>
	<a href="add_resource_to_topic.cfm?topic_id=#url.topic_id#&item_id=#url.item_id#">Add this Resource to a different Topic<a>
	</cfoutput>
	</div>
</cfif>




<cfoutput>
<form name="edit_resource" method="post">
<table>
	<tr>
		<td width="100">
		Title
		</td>
		<td>
		<input type="text" size="100" name="title" value="#resource.title#">
		</td>
	</tr>
	<tr>
		<td width="100">
		Website
		</td>
		<td>
		<input type="text" size="100" name="link" value="#resource.link#">
		</td>
		</tr>
	<tr>
		<td width="100">
		Description
		</td>
		<td>
		<textarea name="description" rows="10" cols="80">#resource.description#</textarea>
		</td>
		</tr>
	<tr>
		<td width="100">
		Address
		</td>
		<td>
		<input type="text" size="100" name="street" value="#resource.street#">
		</td>
		</tr>
		<tr>
		<td width="100">
		City
		</td>
		<td>
		<input type="text" size="100" name="city" value="#resource.city#">
		</td>
		</tr>
		
		<tr>
				<td width="100">
				State
				</td>
				<td>
				
				<select name="state">
					<option></option>
					<cfloop query="state_list">
						<cfset this_state = state>
						<cfif resource.state IS this_state>
						<option value="#state#" selected=true>#state# - #state_name#</option>
						<cfelse>
						<option value="#state#">#state# - #state_name#</option>
						</cfif>
						
					</cfloop>
				</select>
				
				</td>
				</tr>
			<tr>
		<td width="100">
		County
		</td>
		<td>
		<input type="text" size="100" name="county" value="#resource.county#">
		</td>
		</tr>
		<tr>
		<td width="100">
		ZIP
		</td>
		<td>
		<input type="text" size="100" name="zip" value="#resource.zip#">
		</td>
		</tr>
		<tr>
		<td width="100">
		Latidude
		</td>
		<td>
		<input type="text" size="100" name="zip" value="#resource.lat#">
		</td>
		</tr>
		<tr>
		<td width="100">
		Longitude
		</td>
		<td>
		<input type="text" size="100" name="zip" value="#resource.lng#">
		</td>
		</tr>
		<tr>
		<td width="100">
		Contact Information
		</td>
		<td>
		<textarea name="contact_information" rows="10" cols="80">#resource.contact_information#</textarea>
		</td>
		</tr>
		<tr>
		<td width="100">
		Contact Email 
		</td>
		<td>
		<input type="text" size="100" name="contact_email" value="#resource.contact_email#">
		</td>
		</tr>
		<tr><td colspan="2">(an email address to request help)</td></tr>
		<tr>
		<td width="100">
		Contact Form 
		</td>
		<td>
		<input type="text" size="100" name="contact_form" value="#resource.contact_form#">
		</td>
		</tr>
		<tr><td colspan="2">(a form that needs to be filled out to request help)</td></tr>
		<tr>
		<td width="100">
		Contact Phone 
		</td>
		<td>
		<input type="text" size="100" name="contact_phone" value="#resource.contact_phone#">
		</td>
		</tr>
		<tr><td colspan="2">(the main contact phone number)</td></tr>
		<tr>
		<td width="100">
		Entered By 
		</td>
		<td>
		<cfset this_account=#resource.account_id#>
		<select name="account_id" >
			
			<cfloop query="account_list">
			<cfif this_account IS account_id>
			<option value="#account_id#" selected="true">#account_name#</option>
			<cfelse>
			<option value="#account_id#">#account_name#</option>
			</cfif>
			
			</cfloop>
		</select>
		</td>
		</tr>
</table>
<input type="submit" name="btn_save_resource" value="Save">
</form>

<cfquery name="tag_list" datasource="who">
		SELECT item_tag from dbo.item_tag  where dbo.item_tag.item_id = #item_id#
	</cfquery>
<div style="margin-bottom:15px;margin-left:20px;">
tags:
<cfloop query="tag_list">
#item_tag# <a href="edit_tag.cfm?item_id=#item_id#" style="margin-left:10px;"><font color="blue">edit</font></a>
<a href="delete_tag.cfm?item_id=#item_id#" style="margin-left:10px;"><font color="red">delete</font></a>
<h4><a href="add_tag.cfm?item_id=#item_id#" style="margin-left:10px;">Add Tag</a></h4>
</cfloop>
</div>
<a href="new_resource.cfm">New Resource</a>
<cfset use_street = replacenocase(#trim(resource.street)#," ","+","ALL")>
<cfset use_city = replacenocase(#trim(resource.city)#," ","+","ALL")>
<cfset use_state = replacenocase(#trim(resource.state)#," ","+","ALL")>
<cfset use_zip = replacenocase(#trim(resource.zip)#," ","+","ALL")>
<script>
	$.get( "https://maps.googleapis.com/maps/api/geocode/json?address=#use_street#,+#use_city#,+#use_state#&key=AIzaSyBp1_uutb0Me0nhVbjcp_2oGZ2VfycAnHM", function( data ) {
		jdata = data;
		jlat = jdata.results[0].geometry.location.lat;
		jlng = jdata.results[0].geometry.location.lng;
	
	 $.get("update_lat_long.cfm?item_id=#resource.item_id#&lat=" + jlat + "&lng=" + jlng, function(data, status){
       // alert("Data: " + data + "\nStatus: " + status);
		});
		//alert(jlat + ' ' + jlng);
		})
	</script>
</cfoutput>



