<cfquery name="state_list" datasource="who">
	SELECT state, state_name, state_id
	FROM dbo.state
	ORDER BY state

</cfquery>

<h2>States</h2>
<table>

<cfoutput query="state_list">
	<tr>
		<td>
			#state#
		</td>
		<td>
			#state_name#
		</td>
		<td>
			<a href="admin_counties.cfm?state_id=#state_id#">Counties</a>
		</td>
	</tr>
</cfoutput>
</table>