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
		dbo.item.item_id,
		dbo.item.title, 
		dbo.item.directions, 
		dbo.item.link, 
		dbo.item.city, 
		dbo.item.description, 
		dbo.item.contact_email, 
		dbo.item.contact_form, 
		dbo.item.contact_phone, 
		dbo.item.account_id
		FROM     dbo.item
		WHERE   (dbo.item.item_type_id = 1)
		ORDER BY dbo.item.title
	</cfquery>
<cfelse>
<cfquery name="resource_list" datasource="who">
		SELECT   
		dbo.item.item_id,
		dbo.item.title, 
		dbo.item.directions, 
		dbo.item.link, 
		dbo.item.city, 
		dbo.item.description, 
		dbo.item.contact_email, 
		dbo.item.contact_form, 
		dbo.item.contact_phone, 
		dbo.item.account_id
		FROM     dbo.item
		WHERE   (dbo.item.item_type_id = 1)
		
		AND dbo.item.title LIKE <cfqueryparam sqltype="cf_sql_varchar" value="%#use_term#%">
		ORDER BY dbo.item.title
	</cfquery>
</cfif>

<cfif isdefined('url.new_id')>
<cfquery name="new_resource" datasource="who">
		SELECT   
		dbo.item.item_id,
		dbo.item.title, 
		dbo.item.directions, 
		dbo.item.link, 
		dbo.item.city, 
		dbo.item.description, 
		dbo.item.contact_email, 
		dbo.item.contact_form, 
		dbo.item.contact_phone, 
		dbo.item.account_id
		FROM     dbo.item
		WHERE   (dbo.item.item_type_id = 1)
		
		AND dbo.item.item_id =<cfqueryparam sqltype="cf_sql_integer" value="#url.new_id#">
		ORDER BY dbo.item.title
	</cfquery>
</cfif>


<cfoutput>

</cfoutput>
<cfif isdefined('url.new_id')>
		<h3>You entered a new resource</h3>
		<cfoutput query="#new_resource#">

		<div style="background-color:lightblue">
		<b style="font-size:115%">#title#</b>
		<cfif session.role NEQ "Guest">
			<a href="edit_resource.cfm?item_id=#item_id#"><font color="blue">edit</font></a>
		 </cfif>
		 <cfif account_id IS session.account_id OR session.role IS "Moderator" OR session.role IS "Admin">
			<a href="delete_resource.cfm?item_id=#item_id#"><font color="red">delete</font></a>
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


	</cfoutput>
</cfif>
<a href="get_help.cfm"><h1>All Resources</h1></a>
<cfoutput>
<h3>
<a style="margin-left:10px;" href="search_resource.cfm">Add a Resource</a>
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

<div>
<b style="font-size:115%">#title#</b>
<cfif session.role NEQ "Guest">
	<a href="edit_resource.cfm?item_id=#item_id#"><font color="blue">edit</font></a>
 </cfif>
 <cfif account_id IS session.account_id OR session.role IS "Moderator" OR session.role IS "Admin">
	<a href="delete_resource.cfm?item_id=#item_id#"><font color="red">delete</font></a>
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


</cfoutput>

<h3>
<a style="margin-left:10px;" href="search_resource.cfm">Add a Resource</a>
</h3>

<cfif resource_list.recordcount IS 0>
	<h4>No resources were found that match your search.</h4>
</cfif>