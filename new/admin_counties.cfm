<cfinclude template="menu.cfm">
<cfquery name="state_list" datasource="who">
	SELECT state, state_name, state_id
	FROM dbo.state
	ORDER BY state

</cfquery>
<script>
function open_close(e,parent_set_id){
//alert(e.value);
var child_set_div_id = "near_" + parent_set_id;
var child_button_id = "add_near_" + parent_set_id;
if (e.value == "+"){
e.value="-";

console.log(child_button_id);
document.getElementById(child_set_div_id).style.display="block";
document.getElementById(child_button_id).style.display="block";
}else{
e.value="+";
document.getElementById(child_set_div_id).style.display="none";
document.getElementById(child_button_id).style.display="none";
}
}
</script>

<cfif isdefined('url.state_id')>
<cfquery name="county_list" datasource="who">
	SELECT        TOP (100) PERCENT dbo.county.county, 
		county_1.county AS near_county, 
		county_1.county_id as near_county_id,
		dbo.county.state_id, 
		dbo.county.county_id
FROM            dbo.county LEFT OUTER JOIN
                         dbo.county_near_county ON dbo.county.county_id = dbo.county_near_county.county_id LEFT OUTER JOIN
                         dbo.county AS county_1 ON dbo.county_near_county.near_county_id = county_1.county_id

	WHERE dbo.county.state_id = <cfqueryparam sqltype="cf_sql_int" value="#url.state_id#">
	ORDER BY dbo.county.county, county_1.county
	</cfquery>
	
</cfif>
<script>
function by_state(state_id){
var url ="admin_counties.cfm?state_id=" + state_id ;
document.location.href=url;
}
</script>
<h2>Counties</h2>
Select a State
<cfset selected_state = "No State Selected">
<select name="select_state" onchange="by_state(this.options[this.selectedIndex].value);">
	<option></option>
	<cfoutput query="state_list">
		<cfif url.state_id IS state_id>
			<option value="#state_id#">#state_name# </option>
			<cfset selected_state = state_name>
		<cfelse>
			<option value="#state_id#" selected>#state_name# </option>
			
		</cfif>
	</cfoutput>
</select>

<cfif isdefined('county_list')>
	<cfif county_list.recordcount IS 0>
		<h3>No counties have been entered for this state</h3>
	<cfelse>
	<h2><cfoutput>#selected_state#</cfoutput></h2>
	<cfoutput query="county_list" group="county">
				<div ><input type="button" value="+" id="btn_add_#county_id#" onclick="open_close(this,#county_id#);" />
				
						#county# 
						<a href="edit_resource.cfm?item_id=#county_id#&topic_id=#county_id#""><font color="blue">edit</font></a>
						<a href="delete_resource.cfm?item_id=#county_id#&set_id=#county_id#"><font color="red">delete</font></a>
							<a href="remove_resource.cfm?item_id=#county_id#&set_id=#county_id#"><font color="orange">remove</font></a>
						
						<div style="display:none;" id="add_near_#county_id#">
										<div>Nearby Counties</div>
										<input type="button" value="add">
						</div>
						</div>
					
				<cfoutput>
					<div style="display:none;margin-left:20px;" id="near_#county_id#">
					
						#near_county#
						<a href="edit_resource.cfm?item_id=#county_id#&topic_id=#county_id#""><font color="blue">edit</font></a>
						<a href="delete_resource.cfm?item_id=#county_id#&set_id=#county_id#"><font color="red">delete</font></a>
							<a href="remove_resource.cfm?item_id=#county_id#&set_id=#county_id#"><font color="orange">remove</font></a>
							</div>
					
				</cfoutput>

			</cfoutput>
	
	</cfif>
	<form name="new_county" method="post">
	<h3>New County</h3>
	<input type="text" name="new_county" value="">
	<input type="submit" value="Save">
	</form>
</cfif>