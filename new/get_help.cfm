<cfinclude template="header.cfm">
 <script>
	function open_close(e,parent_set_id){
	//alert(e.value);
	var child_set_div_id = "category_" + parent_set_id;
	if (document.getElementById(child_set_div_id).style.display == "none"){
		

		document.getElementById(child_set_div_id).style.display="block";
	}else{
		
		document.getElementById(child_set_div_id).style.display="none";
	}
}
	function go_to_category_topic(category_topic_id){
	var url = "resource_list_by_topic.cfm?category_topic_id=" + category_topic_id + "&selected_state=" + get_selected_state() + "&selected_county=" + get_selected_county();
		document.location.href = url;
	}
</script>

<cfinclude template="menu.cfm"><h3>Get Help</h3>
<cfquery name="get_categories_and_topics" datasource="who">
SELECT   TOP (100) PERCENT dbo.category.category_id, dbo.category.account_id, dbo.category.category, ct.category_topic_id, ct.topic, dbo.category.category_index, ct.category_topic_index
FROM     dbo.category LEFT OUTER JOIN
             dbo.v_category_topic_current AS ct ON dbo.category.category_id = ct.category_id
WHERE   (dbo.category.is_current = 1)
ORDER BY dbo.category.category_index, ct.category_topic_index

</cfquery>

<cfoutput query="#get_categories_and_topics#" group="category">
<div id="category">
	
<input  class="plusminus"  type="button" name="btn_open" value="#category#" onclick="open_close(this,#category_id#);"> 
	<cfif session.role IS "Admin">
	<a href="edit_category.cfm?category_id=#category_id#"><font color="blue">edit</font></a>
 </cfif>
 <cfif session.account_id NEQ "">
	 <cfif account_id IS session.account_id OR session.role IS "Moderator" OR session.role IS "Admin">
		<a href="delete_category.cfm?category_id=#category_id#">
		<font color="red">delete</font></a>
	 </cfif>
 </cfif> 
</div>
<cfif isdefined('url.category_id') AND url.category_id IS category_id>
	<div id="category_#category_id#" style="margin-left:20px;display:block;">
<cfelse>
<div id="category_#category_id#" style="margin-left:20px;display:none;">
</cfif>

<cfoutput group="topic">
<div>
 <a  href="javascript:void(0)" onclick="go_to_category_topic(#category_topic_id#);">#topic#</a>
 

 <cfif session.role NEQ  "Guest">
	<a href="edit_category_topic.cfm?category_id=#category_id#&category_topic_id=#category_topic_id#">
	<font style="margin-left:7px;font-size:10px;" color="blue">edit</font></a>
 </cfif>
 <cfif session.account_id NEQ "">
 <cfif account_id IS session.account_id OR session.role IS "Moderator" OR session.role IS "Admin">
	<a href="delete_category_topic.cfm?category_id=#category_id#&category_topic_id=#category_topic_id#">
	<font  style="margin-left:7px;font-size:10px;" color="red">delete</font></a>
 </cfif>
 
 </cfif>
 </div>
 </cfoutput>
 <button type="button" onclick="document.location.href='new_category_topic.cfm?category_id=#category_id#'">Add Topic</a>
</div>

</cfoutput>
<cfif session.role IS "Admin"><a href="new_category.cfm">add</a></cfif>