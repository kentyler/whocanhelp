<cfoutput>
<cfquery name="get_parent_set" datasource="who">
	SELECT  set_id,set_name
	FROM     [set]
	WHERE [set].set_id = #parent_set_id#

</cfquery>
<cfquery name="set_list" datasource="who">
	SELECT  set_id,set_name
	FROM     [set]
	WHERE [set].parent_set_id = #parent_set_id#
	ORDER BY set_name
</cfquery>

<h3>Topic List for #get_parent_set.set_name#</h3>
<table border="1" >
	<tr>
		<th>
		Topic
		</th>
		
	
		</tr>
		<cfoutput query="set_list">
		<tr>
		<td>
		<a href="edit_set.cfm?set_id=#set_id#"><font color="red">edit</font></a>
		</td>
		<td>
		#set_name#
		</td>
	
		</cfoutput>
</table>
</cfoutput>