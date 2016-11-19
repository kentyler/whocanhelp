<cfoutput>

<cfquery name="set_list" datasource="who">
	SELECT  set_id,set_name
	FROM     [set]
	WHERE [set].parent_set_id = 10
	ORDER BY set_name
</cfquery>

<h3>Category List</h3>
<table border="1" >
	<tr>
		<th>
		Category
		</th>
		
	
		</tr>
		<cfoutput query="set_list">
		<tr>
		<td>
		<a href="edit_set.cfm?set_id=#set_id#"><font color="red">edit</font></a>
		</td>
		<td>
		#set_name# <input type="checkbox" name="cb_#set_name#"
		</td>
	
		</cfoutput>
</table>
</cfoutput>