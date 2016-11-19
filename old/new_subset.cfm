<cfinclude template="menu.cfm"><h1>Add Topic</h1>

<cfif isdefined('btn_submit')>
	<cfquery name="lookup_set" datasource="who" result="rs">
			SELECT dbo.[set].set_id
			FROM dbo.[set]
			WHERE dbo.[set].set_name = <cfqueryparam sqltype="cf_sql_varchar" value="#form.subset_name#">
			AND dbo.[set].parent_set_id = <cfqueryparam sqltype="cf_sql_int" value="#url.parent_set_id#">
		</cfquery>
		
		<cfif lookup_set.recordcount NEQ 0>
			That category already exists
		<cfelse>
			<cfquery name="lookup_email" datasource="who" result="rs">
			INSERT INTO dbo.[set](set_name,parent_set_id)
			VALUES(<cfqueryparam sqltype="cf_sql_varchar" value="#form.subset_name#">,
			<cfqueryparam sqltype="cf_sql_int" value="#url.parent_set_id#">)
		</cfquery>
		The topic has been added.
		</cfif>

</cfif>

<form method="post">
<table>
	<tr>
		<td>
		New Topic 
		</td>
		<td>
		<input type="text" name="subset_name" >
		</td>
	</tr>
		
	</table>
	<input type="submit" name="btn_submit" value="Save">
</form>
<cfset parent_set_id = url.parent_set_id>
<cfinclude template="subset_list.cfm">