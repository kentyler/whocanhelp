<cfquery name="insert_lat_long" datasource="who">
	UPDATE dbo.item
	SET lat = <cfqueryparam sqltype="cf_sql_varchar" value="#url.lat#">,
	lng = <cfqueryparam sqltype="cf_sql_varchar" value="#url.lng#">
	WHERE item_id = <cfqueryparam sqltype="cf_sql_int" value="#url.item_id#">

</cfquery>