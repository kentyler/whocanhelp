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

<cfquery name="resource" datasource="who">
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
	WHERE   (dbo.item.item_id = <cfqueryparam sqltype="cf_sql_integer" value="#url.item_id#">)

</cfquery>

<cfif session.role IS "Guest">
	Please Login or Create an Account so that WhoCanHelp can send your contact information to this Resource.
	<cfabort>
<cfelse>
	<cfset use_email=session.account_email>
	<cfset use_phone=session.account_phone>
	<cfset use_name=session.account_name>
</cfif>

<cfoutput>
<h1>Connect Me To</h1>
<div>
<a href="resource_list_by_topic.cfm?topic_id=#url.topic_id#&selected_state=#url.selected_state#&selected_county=#url.selected_county#">Back to Resource List</a>
</cfoutput>
<!--- <cfdump var="#resource_list#"> --->
<div style="background-color:lightblue;">
<cfoutput query="#resource#" >

	<b style="font-size:115%">#title#</b>
	
	
	 <cfif len(link) gt 0>
	 <div>Web Site= <a style="margin-left:10px" href="#link#">#link#</a></div>
	 </cfif>
	 <cfif len(directions) gt 0>
	 <div>
	 Directions=
	 <cfif left(directions,3) IS "htt">
	 <a href="#directions#">#directions#</a>
	 <cfelse>
	 #directions#
	 </cfif>
	 </div>
	 </cfif>
	 <div style="margin-left:20px;">#description#</div> 
	<div>
	<cfif len(contact_email) gt 0>
		Email=<a href="mailto:#contact_email#">#contact_email#</a>
	</cfif>
	<cfif len(contact_form) gt 0>
		web_form=<a href="#contact_form#">contact form</a>
	 </cfif>
	 <cfif len(contact_phone)>
		phone=<a href="tel:#contact_phone#">#contact_phone#</a>
	 </cfif>
	 
	</div>

</cfoutput>
</div>
<cfif resource.contact_email NEQ "">
<form name="send_email" method="post">
	<p>This page can send an email requesting help for you</p>
	<p>In that email</p>
	<cfoutput>
	<table>
	<tr>
		<td>
		Use this name
		</td>
		<td>
		<input type="text" value="#use_name#">
		</td>
	</tr>
	<tr>
		<td>
		Use this email
		</td>
		<td>
		<input type="text" value="#use_email#">
		</td>
	</tr>
	<tr>
		<td>
		Use this phone number
		</td>
		<td>
		<input type="text" value="#use_phone#">
		</td>
	</tr>
	<tr>
		<td>
		Add a personal note
		</td>
		<td>
		<textarea rows="4" cols="40"></textarea>
		</td>
	</tr>
	</table>
	
	
		</cfoutput>
		<p> This is the email that will be sent to this organization </p>
		<cfoutput>
		Email will be sent to:#resource.contact_email#
		<cfsavecontent variable="email_body">
		#session.account_name# is seeking help from your organization. </br>
		
		You can email them at #session.account_email#</br>
		
		or phone them at #session.account_phone#</br>
		Please get in touch with them as soon as possible</br>
		<p>This email was sent by #session.account_name# from the <a href="whocanhelp.org/about_us.cfm">WhoCanHelp.org</a> web site.</p>
		<p>Please help us deliver better service to people seeking help by clicking on one or more of these three links and letting us know
		how your encounter with #session.account_name# went.</p>
		<div><a href="">Responded to #session.account_id#</a></div>
		<div><a href="">Met/Talked with #session.account_id#</a> OR <a href="">We were not able to connect with #session.account_id#</a></div>
		<div><a href="">We were able to help #session.account_id#</a> OR <a href="">We were not able to help #session.account_id#</a></div>
		</cfsavecontent>
		</cfoutput>
		<div style="background-color:gold;">
		<cfoutput>#email_body#</cfoutput>
		</div>
		
		<input type="checkbox" checked="checked"> Send me a copy of this email.</br>
		<input type="submit" name="btn_send" value="Send the Email"></br>
		
		</form>
		
		<cfif isdefined('form.btn_send')>
			<h3>The Email was Sent.</h3>
		</cfif>
		<cfoutput>
		<cfmail 
		type="HTML"
		from="joe4data@databetter.com" 
		to="#use_email#" 
		subject="#session.account_name# is seeking help from your organization. "> 
		#email_body#
	 
		</cfmail>
		</cfoutput>

		<cfif isdefined('form.checked')>
			<cfmail 
			type="HTML"
			from="joe4data@databetter.com" 
			to="#session.account_email#" 
			subject="WhoCanHelp.org sent:#session.account_name# is seeking help from your organization. "> 
			To #resource.contact_email#
			#email_body#
		 
		</cfmail>
		</cfif>
	<cfelse>
		<h3>Sorry, This resource does not have a contact email address listed</h3>
	</cfif>