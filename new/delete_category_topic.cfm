<cfinclude template="menu.cfm">
	<cfquery name="category_topic" datasource="who">
		SELECT   dbo.category.category, dbo.category_topic.category_topic_id, dbo.category_topic.category_id, dbo.category_topic.topic, dbo.category_topic.is_current, dbo.category_topic.set_id, dbo.category_topic.parent_set_id, dbo.category_topic.category_topic_index, dbo.category_topic.account_id
			FROM     dbo.category INNER JOIN
             dbo.category_topic ON dbo.category.category_id = dbo.category_topic.category_id
		WHERE dbo.category_topic.category_topic_id = <cfqueryparam sqltype="cf_sql_int" value="#url.category_topic_id#">
	</cfquery>
	<cfoutput>
	Return to <a href="get_help.cfm?category_id=#url.category_id#">Get Help</a>
<h3>Delete Topic from Category #category_topic.category#</h3>
<p><cfif category_topic.is_current IS 0>
	This topic has already been marked not "current", so it will not longer appear.</p>
	</cfif>
	</cfoutput>
<cfif isdefined('btn_delete')>
	
	<cfquery name="update_resource" datasource="who">
		UPDATE dbo.category_topic
		SET is_current = 0
		WHERE category_topic_id = <cfqueryparam sqltype="cf_sql_int" value="#url.category_topic_id#">

	</cfquery>
	<cflocation addtoken="no" url="http://whocanhelp.org/get_help.cfm">

<cfelseif isdefined('btn_cancel')>
	<cflocation addtoken="no" url="http://whocanhelp.org/get_help.cfm">
</cfif>


	<cfoutput>
	<form name="delete_category_topic" method="post">
	<input type="submit" value="Yes. Delete it." name="btn_delete">
	<input type="submit" value="No. Cancel." name="btn_cancel">
	<table>
		<tr>
			<td>
			Topic
			</td>
			<td>
			#category_topic.topic#
			</td>
			
		</tr>
		
	</table>
	
	</form>
	</cfoutput>
<cfset category = category_topic.category>
	<cfset category_id = url.category_id>
	<cfinclude template="category_topic_list.cfm">
