<cfinclude template="menu.cfm">

<h1>Edit Category</h1>
<cfif session.role NEQ "Admin">
	<p> Only admins can edit top level categories </p>
<cfelse>
	
	<cfif isdefined('btn_save')>
		<cfif isdefined(form.is_current)>
			<cfset visible = 1>
		<cfelse>
			<cfset visible = 0>
		</cfif>
		<cfquery name="update_category" datasource="who">
			UPDATE   dbo.category
			SET	
			category=<cfqueryparam sqltype="cf_sql_varchar" value="#form.category#">,
			is_current = #visible#
			WHERE category.category_id = <cfqueryparam sqltype="cf_sql_int" value="#url.category_id#">	
		</cfquery>
		<cflocation addtoken="no" url="http://#cgi.server_name#/get_help.cfm">
	</cfif>
	<cfquery name="category" datasource="who">
		SELECT   category, category_id, is_current
		FROM     dbo.category
		WHERE dbo.category.category_id = <cfqueryparam sqltype="cf_sql_int" value="#url.category_id#">
	</cfquery>


	<cfoutput>
	<form name="edit_category" method="post">
	<table>
		<tr>
			<td>
			Category
			</td>
		

			<td>
			<input type="text" size="100" name="category" value="#category.category#">
			</td>
			<td>Visible</td>
			<td>
			<cfif category.is_current IS 1>
			<input type="checkbox"  name="is_current" checked=true >
				<cfelse>
				<input type="checkbox"  name="is_current" >
			</cfif>
			
			</td>
			<!---<td style="font-color:red;">
			<a  href="delete_category.cfm?category_id=#category.category_id#><font color="red">delete</font> </a>
			</td>--->
		</tr>
		
	</table>
	<input type="submit" name="btn_save" value="Save">
	</form>
	</cfoutput>
	
	<cfinclude template="category_list.cfm">
	<a href="new_category.cfm">New Category</a>
</cfif>