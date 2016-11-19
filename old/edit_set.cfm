<cfinclude template="menu.cfm">

<h1>Edit Top Level Category</h1>
<cfif session.role NEQ "Admin">
	<p> Only admins can edit top level categories </p>
<cfelse>
	<a href="new_set.cfm">New Category</a>
	<cfif isdefined('btn_save')>
		
		<cfquery name="update_set" datasource="who">
			UPDATE   dbo.[set]
			SET	
			set_name=<cfqueryparam sqltype="cf_sql_varchar" value="#form.set_name#">
			WHERE [set].set_id = <cfqueryparam sqltype="cf_sql_int" value="#url.set_id#">	
		</cfquery>
		<cflocation addtoken="no" url="http://#cgi.server_name#/get_help.cfm">
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
			Category
			</td>
		

			<td>
			<input type="text" size="100" name="set_name" value="#set.set_name#">
			</td>
			<!---<td style="font-color:red;">
			<a  href="set_delete.cfm?set_id=#set.set_id#><font color="red">delete</font> </a>
			</td>--->
		</tr>
		
	</table>
	<input type="submit" name="btn_save" value="Save">
	</form>
	</cfoutput>
	<a href="new_set.cfm">New Category</a>
	<cfinclude template="set_list.cfm">
</cfif>