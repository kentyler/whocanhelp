<cfinclude template="menu.cfm">

<h1>Delete Topic</h1>

<cfif isdefined('btn_delete')>
	
	<cfquery name="update_resource" datasource="who">
		DELETE FROM   dbo.[set]
		WHERE set_id = <cfqueryparam sqltype="cf_sql_int" value="#url.set_id#">

	</cfquery>
	<cflocation addtoken="no" url="http://whocanhelp.org/get_help.cfm">

<cfelseif isdefined('btn_cancel')>
	<cflocation addtoken="no" url="http://whocanhelp.org/get_help.cfm">
</cfif>
<cfquery name="get_set" datasource="who">
	SELECT   dbo.[set].set_id, 
	dbo.[set].set_name,
	dbo.[set].account_id
	FROM     dbo.[set] 
	WHERE dbo.[set].set_id = <cfqueryparam sqltype="cf_sql_int" value="#url.set_id#">
</cfquery>


	<cfoutput>
	<form name="edit_set" method="post">
	<input type="submit" value="Yes. Delete it." name="btn_delete">
	<input type="submit" value="No. Cancel." name="btn_cancel">
	<table>
		<tr>
			<td>
			Topic
			</td>
		

			<td>
			<input type="text" size="100" name="set_name" value="#get_set.set_name#">
			</td>
			
		</tr>
		
	</table>
	
	</form>
	</cfoutput>

	<cfinclude template="set_list.cfm">
