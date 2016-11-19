<cfinclude template="header.cfm">
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
	function go_to_topic(topic_id){
	var url = "resource_list_by_topic.cfm?topic_id=" + topic_id + "&selected_state=" + get_selected_state() + "&selected_county=" + get_selected_county();
		document.location.href = url;
	}
</script>

<cfinclude template="menu.cfm"><h1>Get Help</h1>
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
ORDER BY s.set_index, subset_index, s1.set_name

</cfquery>
<!--- <cfdump var="#get_headings#"> --->
<cfoutput query="#get_headings#" group="set_name">
<div id="parent_set">
	
<input style="width:60px;" class="plusminus" type="button" name="btn_open" value="+" onclick="open_close(this,#set_id#);"> #set_name#
	<cfif session.role IS "Admin">
	<a href="edit_set.cfm?parent_set_id=#parent_set_id#&set_id=#set_id#"><font color="blue">edit</font></a>
 </cfif>
 <cfif session.account_id NEQ "">
	 <cfif account_id IS session.account_id OR session.role IS "Moderator" OR session.role IS "Admin">
		<a href="delete_set.cfm?parent_set_id=#parent_set_id#&set_id=#set_id#">
		<font color="red">delete</font></a>
	 </cfif>
 </cfif> 
</div>
<cfif isdefined('url.category_id') AND url.category_id IS set_id>
	<div id="child_set_#set_id#" style="margin-left:20px;display:block;">
<cfelse>
<div id="child_set_#set_id#" style="margin-left:20px;display:none;">
</cfif>

<cfoutput group="subset_name">
<div>
 <a  href="javascript:void(0)" onclick="go_to_topic(#topic_id#);">#subset_name#</a>
 

 <cfif session.role NEQ  "Guest">
	<a href="edit_subset.cfm?parent_set_id=#parent_set_id#&set_id=#topic_id#">
	<font style="margin-left:7px;font-size:10px;" color="blue">edit</font></a>
 </cfif>
 <cfif session.account_id NEQ "">
 <cfif account_id IS session.account_id OR session.role IS "Moderator" OR session.role IS "Admin">
	<a href="delete_subset.cfm?parent_set_id=#parent_set_id#&set_id=#topic_id#">
	<font  style="margin-left:7px;font-size:10px;" color="red">delete</font></a>
 </cfif>
  <cfif account_id IS session.account_id OR session.role IS "Moderator" OR session.role IS "Admin">
	<a href="remove_subset.cfm?parent_set_id=#parent_set_id#&set_id=#topic_id#">
	<font  style="margin-left:7px;font-size:10px;" color="orange">remove</font></a>
 </cfif>
 </cfif>
 </div>
 </cfoutput>
 <button type="button" onclick="document.location.href='new_subset.cfm?parent_set_id=#set_id#'">Add Topic</a>
</div>

</cfoutput>
<cfif session.role IS "Admin"><a href="new_set.cfm">add</a></cfif>