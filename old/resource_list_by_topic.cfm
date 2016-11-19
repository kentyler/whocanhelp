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
		SELECT   dbo.set_item.set_id, 
		dbo.item.item_id,
		dbo.item.title, 
		dbo.item.directions, 
		dbo.item.link, 
		dbo.item.city, 
		dbo.item.county,
		dbo.item.state,
		dbo.item.description, 
		dbo.item.contact_email, 
		dbo.item.contact_form, 
		dbo.item.contact_phone, 
		dbo.item.account_id,
		dbo.[set].set_name
		FROM     dbo.set_item INNER JOIN
					 dbo.item ON dbo.set_item.item_id = dbo.item.item_id INNER JOIN
					 dbo.[set] ON dbo.set_item.set_id = dbo.[set].set_id LEFT OUTER JOIN
					 dbo.item_type ON dbo.set_item.item_type_id = dbo.item_type.item_type_id
		WHERE   (dbo.set_item.set_id = <cfqueryparam sqltype="cf_sql_integer" value="#url.topic_id#">)
		ORDER BY dbo.item.title
	</cfquery>
	
<cfelseif url.selected_county IS "">
<cfquery name="resource_list" datasource="who">
		SELECT   dbo.set_item.set_id, 
		dbo.item.item_id,
		dbo.item.title, 
		dbo.item.directions, 
		dbo.item.link, 
		dbo.item.city, 
		dbo.item.county,
		dbo.item.state,
		dbo.item.description, 
		dbo.item.contact_email, 
		dbo.item.contact_form, 
		dbo.item.contact_phone, 
		dbo.item.account_id,
		dbo.[set].set_name
		FROM     dbo.set_item INNER JOIN
					 dbo.item ON dbo.set_item.item_id = dbo.item.item_id INNER JOIN
					 dbo.[set] ON dbo.set_item.set_id = dbo.[set].set_id LEFT OUTER JOIN
					 dbo.item_type ON dbo.set_item.item_type_id = dbo.item_type.item_type_id
		WHERE   (dbo.set_item.set_id = <cfqueryparam sqltype="cf_sql_integer" value="#url.topic_id#">)
		AND (dbo.item.state = <cfqueryparam sqltype="cf_sql_varchar" value="#url.selected_state#">
			OR dbo.item.state IS NULL)
		ORDER BY dbo.item.title
	</cfquery>
<cfelse>
<cfquery name="resource_list" datasource="who">
		SELECT   dbo.set_item.set_id, 
		dbo.item.item_id,
		dbo.item.title, 
		dbo.item.directions, 
		dbo.item.link, 
		dbo.item.city, 
		dbo.item.county,
		dbo.item.state,
		dbo.item.description, 
		dbo.item.contact_email, 
		dbo.item.contact_form, 
		dbo.item.contact_phone, 
		dbo.item.account_id,
		dbo.[set].set_name
		FROM     dbo.set_item INNER JOIN
					 dbo.item ON dbo.set_item.item_id = dbo.item.item_id INNER JOIN
					 dbo.[set] ON dbo.set_item.set_id = dbo.[set].set_id LEFT OUTER JOIN
					 dbo.item_type ON dbo.set_item.item_type_id = dbo.item_type.item_type_id
		WHERE   (dbo.set_item.set_id = <cfqueryparam sqltype="cf_sql_integer" value="#url.topic_id#">)
		AND dbo.item.state = <cfqueryparam sqltype="cf_sql_varchar" value="#url.selected_state#">
		AND (dbo.item.county = <cfqueryparam sqltype="cf_sql_varchar" value="#url.selected_county#">
			OR dbo.item.county IS NULL)
		ORDER BY dbo.item.title
	</cfquery>
</cfif>

<cfquery name="get_category" datasource="who">
	SELECT parent_set_id, set_id FROM dbo.[set] WHERE set_id = <cfqueryparam sqltype="cf_sql_int" value="#url.topic_id#">
</cfquery>
<cfoutput>
<a href="get_help.cfm"><h1>Get Help</h1></a>
</cfoutput>

<!--- <cfdump var="#resource_list#"> --->

<cfoutput query="#resource_list#" group="set_name">

<a href="get_help.cfm?category_id=#get_category.parent_set_id#"><h2>#set_name#</h2></h1></a>
<cfoutput>
<div>
<div >
	<input type="button" value="Connect Me" onclick="document.location.href='connect_me.cfm?item_id=#item_id#&topic_id=#url.topic_id#&selected_state=#url.selected_state#&selected_county=#url.selected_county#'"/><b style="font-size:115%">#title#</b>
	<cfif session.role NEQ "Guest">
		<a href="edit_resource.cfm?item_id=#item_id#&topic_id=#set_id#""><font color="blue">edit</font></a>
	 </cfif>
	 <cfif account_id IS session.account_id OR session.role IS "Moderator" OR session.role IS "Admin">
		<a href="delete_resource.cfm?item_id=#item_id#&set_id=#set_id#"><font color="red">delete</font></a>
	 </cfif>
	  <cfif account_id IS session.account_id OR session.role IS "Moderator" OR session.role IS "Admin">
		<a href="remove_resource.cfm?item_id=#item_id#&set_id=#set_id#"><font color="orange">remove</font></a>
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
		SELECT item_tag from dbo.item_tag  where dbo.item_tag.item_id = #item_id#
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
<a style="margin-left:10px;" href="search_resource_in_set.cfm?set_id=#set_id#">Add a Resource</a>
</h3>
</cfif>

</cfoutput>
<cfif resource_list.recordcount IS 0>
	<cfquery name="lookup_set" datasource="who">
	SELECT set_name FROM dbo.[set] WHERE set_id = #topic_id#
	</cfquery>
	<cfoutput>
		<h2>#lookup_set.set_name#</h2>
		<cfif cgi.script_name IS "/resource_list_by_topic.cfm">
			<h3>
			<a style="margin-left:10px;" href="search_resource_in_set.cfm?set_id=#topic_id#">Add a Resource</a>
			</h3>
		</cfif>
	</cfoutput>
</cfif>
