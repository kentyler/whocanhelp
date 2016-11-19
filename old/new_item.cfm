<cfinclude template="menu.cfm"><h1>Add Top Level Category</h1>

<cfif isdefined('btn_submit')>
	<cfquery name="lookup_set" datasource="who" result="rs">
			SELECT dbo.[set].set_id
			FROM dbo.[set]
			WHERE dbo.[set].set_name = <cfqueryparam sqltype="cf_sql_varchar" value="#form.set_name#">
			AND dbo.[set].parent_set_id = 10
		</cfquery>
		
		<cfif lookup_set.recordcount NEQ 0>
			That category already exists
		<cfelse>
			<cfquery name="lookup_email" datasource="who" result="rs">
			INSERT INTO dbo.[set](set_name,parent_set_id)
			VALUES(<cfqueryparam sqltype="cf_sql_varchar" value="#form.set_name#">,
			10)
		</cfquery>
		The category has been added.
		</cfif>

</cfif>

<form method="post">
<table>
	<tr>
		<td>
		New Category 
		</td>
		<td>
		<input type="text" name="set_name" >
		</td>
	</tr>
		
	</table>
	<input type="submit" name="btn_submit" value="Save">
</form>
<cfinclude template="set_list.cfm">