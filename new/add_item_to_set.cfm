
	<cfquery name="insert_set_item" datasource="who" result="rs">
	INSERT INTO   dbo.set_item
		( set_id, 
		item_id
		)
		VALUES(
		<cfqueryparam sqltype="cf_sql_int" value="#url.set_id#">,
		<cfqueryparam sqltype="cf_sql_int" value="#url.item_id#">
		)
	</cfquery>
	<cflocation addtoken="no" url="http://whocanhelp.org/resource_list_by_topic.cfm?topic_id=#url.set_id#">
	