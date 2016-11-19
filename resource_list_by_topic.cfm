<cfparam name="url.selected_state" default="none">
<cfparam name="url.selected_county" default="none">

<script>
function open_close(e,parent_set_id){
//alert(e.value);
var child_set_div_id = "child_set_" + parent_set_id;
if (e.value == "+"){
e.value="-";

document.getElementById(child_set_div_id).style.display="block";
}else{
e.value="+";
document.getElementById(child_set_div_id).style.display="none";
}
}
</script>

<cfinclude template="menu.cfm">

<cfif url.selected_state IS "none">
	<cfquery name="resource_list" datasource="who">
		SELECT   category, 
		category_index, 
		resource_index, 
		category_topic_index, 
		topic, 
		street, 
		title, 
		link, 
		full_address, 
		city, 
		county, 
		state, 
		zip, 
		contact_information, 
		description, 
		account_id, 
		date_and_time, 
		contact_email, 
		contact_form, 
		contact_phone, 
		directions, 
		lat, 
		lng, 
		category_topic_id,
		category_id,
		category_topic_resource_id
FROM     dbo.v_resource_with_topic_and_category			
WHERE category_topic_id = <cfqueryparam cfsqltype="cf_sql_int" 
				value="#url.category_topic_id#">
				</cfquery>
	
<cfelseif url.selected_county IS "">
<cfquery name="resource_list" datasource="who">
	SELECT   category, 
		category_index, 
		resource_index, 
		category_topic_index, 
		topic, 
		street, 
		title, 
		link, 
		full_address, 
		city, 
		county, 
		state, 
		zip, 
		contact_information, 
		description, 
		account_id, 
		date_and_time, 
		contact_email, 
		contact_form, 
		contact_phone, 
		directions, 
		lat, 
		lng, 
		category_topic_id,
		category_id,
		category_topic_resource_id
FROM     dbo.v_resource_with_topic_and_category			
WHERE category_topic_id = <cfqueryparam cfsqltype="cf_sql_int" 
				value="#url.category_topic_id#">
		AND (state = <cfqueryparam sqltype="cf_sql_varchar" value="#url.selected_state#">
			OR state IS NULL)
		ORDER BY title
	</cfquery>
<cfelse>
<cfquery name="resource_list" datasource="who">
		SELECT   category, 
		category_index, 
		resource_index, 
		category_topic_index, 
		topic, 
		street, 
		title, 
		link, 
		full_address, 
		city, 
		county, 
		state, 
		zip, 
		contact_information, 
		description, 
		account_id, 
		date_and_time, 
		contact_email, 
		contact_form, 
		contact_phone, 
		directions, 
		lat, 
		lng, 
		category_topic_id,
		category_id,
		category_topic_resource_id
FROM     dbo.v_resource_with_topic_and_category			
WHERE category_topic_id = <cfqueryparam cfsqltype="cf_sql_int" 
				value="#url.category_topic_id#">
		AND state = <cfqueryparam sqltype="cf_sql_varchar" value="#url.selected_state#">
		AND (county = <cfqueryparam sqltype="cf_sql_varchar" value="#url.selected_county#">
			OR county IS NULL)
		ORDER BY title
	</cfquery>
</cfif>


<cfoutput>
<a href="get_help.cfm"><h1>Get Help</h1></a>
</cfoutput>

<cfoutput query="#resource_list#" group="category">

<a href="get_help.cfm?category_id=#category_id#"><h2>#category#</h2></h1></a>
<cfoutput>
<div>
<div >
	<input type="button" value="Connect Me" onclick="document.location.href='connect_me.cfm?category_topic_resource_id=#category_topic_resource_id#&category_topic_id=#url.category_topic_id#&selected_state=#url.selected_state#&selected_county=#url.selected_county#'"/><b style="font-size:115%">#title#</b>
	<cfif session.role NEQ "Guest">
		<a href="edit_resource_for_topic.cfm?category_topic_resource_id=#category_topic_resource_id#&category_topic_id=#category_topic_id#""><font color="blue">edit</font></a>
	 </cfif>
	 <cfif account_id IS session.account_id OR session.role IS "Moderator" OR session.role IS "Admin">
		<a href="delete_resource.cfm?category_topic_resource_id=#category_topic_resource_id#&category_topic_id=#category_topic_id#"><font color="red">hide</font></a>
	 </cfif>

	 </div>
	 <cfif len(link) gt 0>
	 <a style="margin-left:10px" href="#link#">web site</a>
	 </cfif>
	 <cfif len(directions) gt 0>
	 <a style="margin-left:10px" href="#directions#">directions</a>
	 </cfif>
	 <div style="margin-left:20px;">#description#</div> 
<div style="margin-bottom:10px;">
	<cfif len(contact_email) gt 0>
		email=<a href="mailto:#contact_email#">#contact_email#</a>
	</cfif>
	<cfif len(contact_form) gt 0>
		web_form=<a href="#contact_form#">contact form</a>
	 </cfif>
	 <cfif len(contact_phone)>
		phone=<a href="tel:#contact_phone#">#contact_phone#</a>
	 </cfif>
	 
</div>
	<cfquery name="tag_list" datasource="who">
		SELECT tag from dbo.category_topic_resource_tag  where dbo.category_topic_resource_tag.category_topic_resource_id = #category_topic_resource_id#
	</cfquery>
	
<div style="margin-bottom:15px;margin-left:20px;">
tags:
<cfloop query="tag_list">
#item_tag#
</cfloop>
</div>
</cfoutput>
<cfif cgi.script_name IS "/resource_list_by_topic.cfm">
<h3>
<a style="margin-left:10px;" href="new_resource_for_topic.cfm?category_topic_id=#category_topic_id#">Add a Resource</a>
</h3>
</cfif>

</cfoutput>
<cfif resource_list.recordcount IS 0>
	<cfquery name="lookup_resource" datasource="who">
	SELECT topic FROM category_topic WHERE category_topic_id = #category_topic_id#
	</cfquery>
	<cfoutput>
		<h2>#lookup_resource.topic#</h2>
		
			<h3>
			<a style="margin-left:10px;" href="new_resource_for_topic.cfm?category_topic_id=#category_topic_id#">Add a Resource</a>
</h3>
		
	</cfoutput>
</cfif>
