<cfinclude template="menu.cfm">
<cfif isdefined('btn_save')>
			<cfif isdefined('form.is_current')>
				<cfset current = 1>
			<cfelse>
				<cfset current = 0>
			</cfif>
		<cfquery name="update_category_topic" datasource="who">
			UPDATE   dbo.category_topic
			SET	
			topic=<cfqueryparam sqltype="cf_sql_varchar" value="#form.topic#">,
			is_current= #current#
			WHERE category_topic.category_topic_id = <cfqueryparam sqltype="cf_sql_int" value="#url.category_topic_id#">	
		</cfquery>
		
	</cfif>
	
<cfquery name="category_topic" datasource="who">
		SELECT   dbo.category.category, dbo.category_topic.category_topic_id, dbo.category_topic.category_id, dbo.category_topic.topic, dbo.category_topic.is_current, dbo.category_topic.set_id, dbo.category_topic.parent_set_id, dbo.category_topic.category_topic_index, dbo.category_topic.account_id
			FROM     dbo.category INNER JOIN
             dbo.category_topic ON dbo.category.category_id = dbo.category_topic.category_id
		WHERE dbo.category_topic.category_topic_id = <cfqueryparam sqltype="cf_sql_int" value="#url.category_topic_id#">
	</cfquery>
	<cfoutput>
	Return to <a href="get_help.cfm?category_id=#url.category_id#">Get Help</a>
<h3>Edit Topic for #category_topic.category#</h3>

</cfoutput>
<cfif session.role IS "Guest">
	<p> Only logged in users, moderators and admins can edit topics </p>
<cfelse>

	


	<cfoutput>
	<form name="edit_set" method="post">
	<table>
		<tr>
			<td>
			Topic
			</td>
			<td>
			<input type="text" size="100" name="topic" value="#category_topic.topic#">
			</td>
			
		</tr>
		<tr>
			<td>
			Current
			</td>
			<td>
			<cfif session.role IS "admin">
			<cfif category_topic.is_current IS 1>
			<input type="checkbox" name="is_current" checked=true >
			<cfelse>
			<input type="checkbox" name="is_current"  >
			</cfif>
			<cfelse>
				<input type="hidden" name="is_current" value="#is_current#">
			</cfif>
			
			</td>
			
		</tr>
	</table>
	<input type="submit" name="btn_save" value="Save">
	</form>
	</cfoutput>
	<cfset category = category_topic.category>
	<cfset category_id = url.category_id>
	<cfinclude template="category_topic_list.cfm">
	<a href="new_category_topic.cfm?category_id=#url.category_id#">New Topic</a>
</cfif>