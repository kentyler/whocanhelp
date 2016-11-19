buttonbutton
	<cfif isdefined('url.id')>
		<cfset session_id = url.id
	<cfset strNumbers = "012345678987654321012345678909876543210">
	<cfset randnumber = "">
	<cfloop from="1" to="9" index="i">
    <cfset thisnumber = Mid(
    strNumbers,
    RandRange( 1, Len( strNumbers ) ),
    1
    ) />
	<cfset randnumber = "#randnumber##thisnumber#">
	<cfif i IS 3 OR i IS 6>
		<cfset randnumber = "#randnumber#-">
	</cfif>
	</cfloop>
	<cfoutput>#randnumber#</cfoutput>
	
	<form name="frm_button" method="post">
	Enter a comma seperated list of button labels
	<input type="text" name="label_names" value="">
	<input type="submit" name="btn_submit" value="Enter">
	
	
	<cfif isdefined('form.label_names')>
		
		<cfset label_list = form.label_names>
	<cfelse>
		<cfset session.label_list = label_list>
		
	</cfif>
	<cfset number_of_buttons = listlen(label_list,",")>
		<cfloop list="#label_list#" index="i">
			<cfoutput>
			<div>
			<input type="button" value="#i#" onclick="alert('you clicked #i#');">
			</div></cfoutput>
		</cfloop>
	
	
	</form>