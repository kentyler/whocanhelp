<cfinclude template="menu.cfm">

<h1>Edit Top Level Category</h1>
<cfif session.role IS "Guest">
	<p> Only logged in users, moderators and admins can edit topics </p>
<cfelse>
	<a href="new_subset.cfm?parent_set_id=#url.parent_set_id#">New Topic</a>
	<cfif isdefined('btn_save')>
		
		<cfquery name="update_set" datasource="who">
			UPDATE   dbo.[set]
			SET	
			set_name=<cfqueryparam sqltype="cf_sql_varchar" value="#form.set_name#">
			WHERE [set].set_id = <cfqueryparam sqltype="cf_sql_int" value="#url.set_id#">	
		</cfquery>
		
	</cfif>
	<cfquery name="set" datasource="who">
		SELECT   set_name, set_id
		FROM     dbo.[set]
		WHERE dbo.[set].set_id = <cfqueryparam sqltype="cf_sql_int" value="#url.set_id#">
	</cfquery>


	<cfoutput>
	<form name="edit_set" method="post">
	<table>
		<tr>
			<td>
			Topic
			</td>
			<td>
			<input type="text" size="100" name="set_name" value="#set.set_name#">
			</td>
			
		</tr>
		
	</table>
	<input type="submit" name="btn_save" value="Save">
	</form>
	</cfoutput>
	<a href="new_subset.cfm?parent_set_id=#url.parent_set_id#">New Topic</a>
	<cfset parent_set_id = url.parent_set_id>
	<cfinclude template="subset_list.cfm">
</cfif>