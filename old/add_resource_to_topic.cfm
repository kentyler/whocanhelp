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

function add_to_topic(id_to_add){

}
</script>
<cfquery name="get_resource" datasource="who">
	SELECT title FROM dbo.item WHERE item_id = <cfqueryparam sqltype="cf_sql_int" value="#url.item_id#">
</cfquery>

<cfinclude template="menu.cfm">
<cfquery name="get_category" datasource="who">
	SELECT set_name, set_id FROM dbo.[set] where set_id = 
	(SELECT parent_set_id FROM dbo.[set] WHERE set_id =<cfqueryparam sqltype="cf_sql_int" value="#url.topic_id#">)
</cfquery>
<cfquery name="get_topic" datasource="who">
	SELECT set_name, set_id FROM dbo.[set] where set_id = 
	<cfqueryparam sqltype="cf_sql_int" value="#url.topic_id#">
</cfquery>
<cfoutput>
<div>
<h3><a href="get_help.cfm?category_id=#get_category.set_id#">Return to #get_category.set_name#</a></h3>
<h4><a href="resource_list_by_topic.cfm?topic_id=#get_topic.set_id#">Return to #get_topic.set_name#</a></h4>
</div>
</cfoutput>
<cfif isdefined('form.btn_submit')>
<CFLOOP collection="#FORM#" item="i">
   
   <cfif left(i,3) IS "add">
   <cfset id = mid(i,14,99)>
  
   <cfquery name="add" datasource="who">
		INSERT INTO set_item(set_id,item_id,account_id)
		VALUES(<cfqueryparam sqltype="cf_sql_int" value="#id#">,
		<cfqueryparam sqltype="cf_sql_int" value="#url.item_id#">,
		#session.account_id#)
   </cfquery>
   </cfif>
</CFLOOP>
<cfoutput><h4>The resource has been added to the selected topics.</cfoutput>
</cfif>

<form name="frm_add" method="post">
<cfoutput>
<h3>Add "#get_resource.title#" to a different Category and Topic</h3>
</cfoutput>
<p> 1) Open Categories and check all the topics you want to add the resource to.</p>
<p> 2) <input type="submit" name="btn_submit" value="Add to Topics"/></p>


<cfquery name="get_headings" datasource="who">
SELECT   s.set_id, s.set_name, 
		s.parent_set_id, 
		s.set_index, 
		s1.set_id AS topic_id, 
		s1.set_name AS subset_name, 
		s1.set_index AS subset_index, 
		s.account_id, 
		s1.account_id AS subset_account_id
FROM     dbo.[set] AS s LEFT OUTER JOIN
             dbo.[set] AS s1 ON s.set_id = s1.parent_set_id
WHERE   (s.parent_set_id = 10)
ORDER BY s.set_index, subset_index

</cfquery>
<!--- <cfdump var="#get_headings#"> --->
<cfoutput query="#get_headings#" group="set_name">
<div id="parent_set">
	
<input style="width:60px;" class="plusminus" type="button" name="btn_open" value="+" onclick="open_close(this,#set_id#);"> #set_name#


<div id="child_set_#set_id#" style="margin-left:20px;display:none;">
<cfoutput group="subset_name">
<div>
 <a href="resource_list_by_topic.cfm?topic_id=#topic_id#">#subset_name#</a>
 
 <cfif session.role NEQ  "Guest">
	<input type="checkbox" name="add_to_topic_#topic_id#">
 </cfif>
 </div>
 </cfoutput>
 </div>

</cfoutput>
</form>