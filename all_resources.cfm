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
<cfif isdefined('form.search_term')>

	<cfset use_term=form.search_term>
<cfelse>
	<cfset use_term = "">
</cfif>
<cfif NOT isdefined('form.search_term')>
	<cfquery name="resource_list" datasource="who">
		SELECT   
			dbo.resource.resource_id,
		dbo.resource.title, 
		dbo.resource.directions, 
		dbo.resource.link, 
		dbo.resource.city, 
		dbo.resource.description, 
		dbo.resource.contact_email, 
		dbo.resource.contact_form, 
		dbo.resource.contact_phone, 
		dbo.resource.account_id,
		dbo.resource.is_current
		FROM     dbo.resource
		WHERE dbo.resource.title IS NOT NULL
		ORDER BY dbo.resource.title
	</cfquery>
<cfelse>
<cfquery name="resource_list" datasource="who">
		SELECT   
		dbo.resource.resource_id,
		dbo.resource.title, 
		dbo.resource.directions, 
		dbo.resource.link, 
		dbo.resource.city, 
		dbo.resource.description, 
		dbo.resource.contact_email, 
		dbo.resource.contact_form, 
		dbo.resource.contact_phone, 
		dbo.resource.account_id,
		dbo.resource.is_current
		FROM     dbo.resource
		
		
		WHERE dbo.resource.title LIKE <cfqueryparam sqltype="cf_sql_varchar" value="%#use_term#%">
		ORDER BY dbo.resource.title
	</cfquery>
</cfif>

<cfif isdefined('url.new_id')>
<cfquery name="new_resource" datasource="who">
		SELECT   
		dbo.resource.resource_id,
		dbo.resource.title, 
		dbo.resource.directions, 
		dbo.resource.link, 
		dbo.resource.city, 
		dbo.resource.description, 
		dbo.resource.contact_email, 
		dbo.resource.contact_form, 
		dbo.resource.contact_phone, 
		dbo.resource.account_id,
		dbo.resource.is_current
		FROM     dbo.resource
		WHERE    dbo.resource.resource_id =<cfqueryparam sqltype="cf_sql_integer" value="#url.new_id#">
		ORDER BY dbo.resource.title
	</cfquery>
</cfif>


<cfoutput>

</cfoutput>
<cfif isdefined('url.new_id')>
		<h3>You entered a new resource</h3>
		<cfoutput query="#new_resource#">
		<cfif (is_current IS 1) OR (session.role IS "admin")>
			<div style="background-color:lightblue">
			<b style="font-size:115%">#title#</b>
			<cfif session.role NEQ "Guest">
				<a href="edit_resource.cfm?resource_id=#resource_id#"><font color="blue">edit</font></a>
			 </cfif>
			 <cfif account_id IS session.account_id OR session.role IS "Moderator" OR session.role IS "Admin">
				<a href="delete_resource.cfm?resource_id=#resource_id#"><font color="red">hide</font></a>
			 </cfif>

			 </div>
			 <div>
				<cfif is_current IS 1>
					<input type="checkbox" checked=true name="is_current">
				<cfelse>
					<input type="checkbox"  name="is_current">
				</cfif>
			 </div>
			 <cfif len(link) gt 0>
				<a style="margin-left:10px" href="#link#">web site</a>
			 </cfif>
			 <cfif len(directions) gt 0>
				<a style="margin-left:10px" href="#directions#">directions</a>
			 </cfif>
			 <div style="margin-left:20px;">#description#</div> 
			<div>
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
		</cfif>

	</cfoutput>
</cfif>
<a href="get_help.cfm"><h1>All Resources</h1></a>
<cfoutput>
<h3>
<a style="margin-left:10px;" href="new_resource.cfm">Add a Resource</a>
</h3>
</cfoutput>
<div>

<cfoutput>
<form name="frm_search" method="post" >
Search By Name <input type="text" name="search_term" value="#use_term#">
<input type="submit" value="Go">
</form>
</cfoutput>
</div>
<cfoutput query="#resource_list#">
<cfif (is_current IS 1) OR (is_current IS 0 AND session.role IS "admin")>
	<div >
	<b style="font-size:115%">#title#</b>
	<cfif session.role NEQ "Guest">
		<a href="edit_resource_for_list.cfm?resource_id=#resource_id#"><font color="blue">edit</font></a>
	 </cfif>
	 <cfif account_id IS session.account_id OR session.role IS "Moderator" OR session.role IS "Admin">
		<a href="delete_resource.cfm?resource_id=#resource_id#"><font color="red">hide</font></a>
	 </cfif>

	 </div>
	 <div style="margin-bottom:15px;margin-left:15px;">
	 <div>
				Visible	<cfif is_current IS 1>
						<input type="checkbox" checked=true name="is_current">
					<cfelse>
						<input type="checkbox"  name="is_current">
					</cfif>
				 </div>
	 <cfif len(link) gt 0>
		<a style="margin-left:10px" href="#link#">web site</a>
	 </cfif>
	 <cfif len(directions) gt 0>
		<a style="margin-left:10px" href="#directions#">directions</a>
	 </cfif>
	 <div >#description#</div> 

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
</cfif>

</cfoutput>

<h3>
<a style="margin-left:10px;" href="search_resource.cfm">Add a Resource</a>
</h3>

<cfif resource_list.recordcount IS 0>
	<h4>No resources were found that match your search.</h4>
</cfif>