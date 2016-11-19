<cfoutput>

<cfquery name="category_topic_list" datasource="who">
	SELECT  category_topic_id,topic, is_current
	FROM     category_topic
	WHERE category_id = <cfqueryparam cfsqltype="cf_sql_int" value="#category_id#">
	ORDER BY topic
</cfquery>


<h3>Topic List for #category#</h3>
<table border="1" >
	<tr>
		<th>
		Category
		</th>
		<th></th>
		<cfif session.role IS "admin">
		<th>Current</th>
		</cfif>
		</tr>
		<cfoutput query="category_topic_list">
		<tr>
		<cfif session.role IS "admin">
		<td>
		<a href="edit_category_topic.cfm?category_topic_id=#category_topic_id#&category_id=#category_id#">edit</a>
		</td>
		</cfif>
		<td>
		#topic#
		</td>
		
		<td>
		<cfif is_current IS 1>
			<input type="checkbox" checked=true>
		<cfelse>
			<input type="checkbox">
		</cfif>
		</td>
	<td>
		<a href="delete_category_topic.cfm?category_topic_id=#category_topic_id#&category_id=#category_id#">
		<font color="red">delete</font></a>
		</td>
		</cfoutput>
</table>
</cfoutput>