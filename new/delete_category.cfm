<cfinclude template="menu.cfm">

<h1>Delete Category</h1>
<p>If you delete this category all Topics that have been assigned to it will also be deleted</p>
<cfif isdefined('btn_delete')>
	<!--- lets deactive instead of deleteing --->
	<cfquery name="update_resource" datasource="who">
		UPDATE   dbo.category
		SET is_current = 0
		WHERE category_id = <cfqueryparam sqltype="cf_sql_int" value="#url.category_id#">

	</cfquery>
	<cflocation addtoken="no" url="http://whocanhelp.org/get_help.cfm">

<cfelseif isdefined('btn_cancel')>
	<cflocation addtoken="no" url="http://whocanhelp.org/get_help.cfm">
</cfif>
<cfquery name="category" datasource="who">
		SELECT   category, category_id
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
			<input type="text" size="100" name="set_name" value="#category.category#">
			</td>
			<!---<td style="font-color:red;">
			<a  href="delete_category.cfm?category_id=#category.category_id#><font color="red">delete</font> </a>
			</td>--->
		</tr>
		
	</table>
	<input type="submit" name="btn_delete" value="Delete">
	<input type="submit" name="btn_cancel" value="Cancel">
	</form>
	</cfoutput>
	
	<cfinclude template="category_list.cfm">
	<a href="new_category.cfm">New Category</a>
