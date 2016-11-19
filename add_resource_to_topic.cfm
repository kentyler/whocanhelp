<cfinclude template="header.cfm">
<script>
function open_close(e,parent_set_id){
	//alert(e.value);
	var child_set_div_id = "topic_" + parent_set_id;
	child_set_div_id = child_set_div_id.trim();
	if(document.getElementById(child_set_div_id).style.display == "none"){	

		document.getElementById(child_set_div_id).style.display="block";
	}else{
	
	document.getElementById(child_set_div_id).style.display="none";
	}
}

function add_to_topic(id_to_add){

}
</script>
<cfif isdefined('form.btn_submit')>
<CFLOOP collection="#FORM#" item="i">
   
   <cfif left(i,3) IS "add">
   <cfset id = mid(i,14,99)>
  
   <cfquery name="add" datasource="who">
		INSERT INTO category_topic_resource(category_topic_id,resource_id,account_id)
		VALUES(<cfqueryparam sqltype="cf_sql_int" value="#id#">,
		<cfqueryparam sqltype="cf_sql_int" value="#url.resource_id#">,
		#session.account_id#)
   </cfquery>
   </cfif>
</CFLOOP>
<cfoutput><h4>The resource has been added to the selected topics.</cfoutput>
</cfif>

<cfquery name="get_resource" datasource="who">
	SELECT title FROM dbo.resource WHERE resource_id = <cfqueryparam sqltype="cf_sql_int" value="#url.resource_id#">
</cfquery>

<cfinclude template="menu.cfm">
<cfquery name="get_current_links" datasource="who">
	SELECT   category, topic, title, category_topic_id, category_id, category_topic_resource_id, resource_id
FROM     dbo.v_resource_with_topic_and_category
	WHERE resource_id=<cfqueryparam sqltype="cf_sql_int" value="#url.resource_id#">
	Order by category, Topic
</cfquery>
<h3>Categories where this Resource is currenty attached</h3>
<cfoutput query= "get_current_links">
<div>
	<a href="get_help.cfm?category_id=#category_id#">#category#</a>:
	<a href="resource_list_by_topic.cfm?category_topic_id=#category_topic_id#">#topic#</a>
</div>
</cfoutput>

<cfoutput>
<div>
</div>
</cfoutput>


<form name="frm_add" method="post">
<cfoutput>
<h3>Add "#get_resource.title#" to a different Category and Topic</h3>
</cfoutput>
<p> 1) Open Categories and check all the topics you want to add the resource to.</p>
<p> 2) <input type="submit" name="btn_submit" value="Add to Topics"/></p>


<cfquery name="get_headings" datasource="who">
SELECT    category, topic, category_id, category_topic_id, category_index, category_topic_index
FROM     dbo.v_category_topic_with_category
ORDER BY category_index, category_topic_index

</cfquery>
<!--- <cfdump var="#get_headings#"> --->
<cfoutput query="#get_headings#" group="category">
<div id="category_#category_id#">
	
<input  class="plusminus" type="button" name="btn_open" value="#category#" onclick="open_close(this,#category_id#);"> 


<div id="topic_#trim(category_id)#" style="margin-left:20px;display:none;">
<cfoutput group="topic">
<div>
 <a href="resource_list_by_topic.cfm?category_topic_id=#trim(category_topic_id)#">#topic#</a>
 
 <cfif session.role NEQ  "Guest" and len(#topic#) GT 0>
	<input type="checkbox" name="add_to_topic_#category_topic_id#">
 </cfif>
 </div>
 </cfoutput>
 </div>

</cfoutput>
<div>
<input type="submit" name="btn_submit" value="Save Changes">
</div>
</form>