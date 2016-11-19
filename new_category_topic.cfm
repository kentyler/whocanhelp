<cfinclude template="menu.cfm"><h1>Add Topic</h1>

<cfif isdefined('btn_submit')>
	<cfquery name="lookup_category_topic" datasource="who" result="rs">
			SELECT dbo.category_topic.category_topic_id
			FROM dbo.category_topic
			WHERE dbo.category_topic.category_id = <cfqueryparam sqltype="cf_sql_int" value="#url.category_id#">
			ANd dbo.category_topic.topic = <cfqueryparam sqltype="cf_sql_varchar" value="#form.topic#">
		
		</cfquery>
		
		<cfif lookup_category_topic.recordcount NEQ 0>
			That topic already exists for this category
		<cfelse>
			<cfquery name="insert_category_topic" datasource="who" result="rs">
			INSERT INTO dbo.category_topic(topic,category_id)
			VALUES(<cfqueryparam sqltype="cf_sql_varchar" value="#form.topic#">,
			<cfqueryparam sqltype="cf_sql_int" value="#url.category_id#">)
		</cfquery>
		The topic has been added.
		</cfif>

</cfif>
<cfquery name="category" datasource="who">
		SELECT   category, category_id
		FROM     dbo.category
		WHERE dbo.category.category_id = <cfqueryparam sqltype="cf_sql_int" value="#url.category_id#">
	</cfquery>
<form method="post">
<table>
	<tr>
		<td>
		<cfoutput>New Topic for Category #category.category#</cfoutput>
		</td>
		<td>
		<input type="text" name="topic" >
		</td>
	</tr>
		
	</table>
	<input type="submit" name="btn_submit" value="Save">
</form>
<cfset category = category.category>
<cfset category_id = url.category_id>
<cfinclude template="category_topic_list.cfm">