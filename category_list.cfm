<cfoutput>

<cfquery name="category_list" datasource="who">
	SELECT  category_id,category,is_current
	FROM     category
	
	ORDER BY category
</cfquery>

<h3>Category List</h3>
<table border="1" >
	<tr>
		<th>
		Category
		</th>
		<th>
		</th>
		<th>
		Visible
		</th>
	
		</tr>
		<cfoutput query="category_list">
		<tr>
		<td>
		<a href="edit_category.cfm?category_id=#category_id#"><font color="green">edit</font></a>
		</td>
		
		<td>
		#category#
		</td>
		<td>
		<cfif is_current IS 1>
			<input type="checkbox" checked="true">
		<cfelse>
			<input type="checkbox" >
		</cfif>
		</td>
	<td>
		<a href="delete_category.cfm?category_id=#category_id#"><font color="red">hide</font></a>
		</td>
		</cfoutput>
</table>
</cfoutput>