<cfinclude template="menu.cfm"><h1>Add Category</h1>

<cfif isdefined('btn_submit')>
	<cfquery name="lookup_category" datasource="who" result="rs">
			SELECT dbo.category.category_id
			FROM dbo.category
			WHERE dbo.category.category = <cfqueryparam sqltype="cf_sql_varchar" value="#form.category#">
		
		</cfquery>
		
		<cfif lookup_category.recordcount NEQ 0>
			That category already exists
		<cfelse>
			<cfquery name="insert_category" datasource="who" result="rs">
			INSERT INTO dbo.category(category)
			VALUES(<cfqueryparam sqltype="cf_sql_varchar" value="#form.category#">)
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
		<input type="text" name="category" >
		</td>
	</tr>
		
	</table>
	<input type="submit" name="btn_submit" value="Save">
</form>
<cfinclude template="category_list.cfm">