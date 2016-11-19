<cfparam name="url.s" default="1">
<cfquery name="set_items_by_set" datasource = "who">
SELECT   dbo.item.item_id, dbo.item.set_id, dbo.item.item_type_id, dbo.item.title, dbo.item.link, dbo.item.full_address, dbo.item.contact_information, dbo.item.description, dbo.item.account_id, dbo.item.date_and_time, dbo.item.set_item_index, dbo.set_item.set_item_id, dbo.set_item.set_id AS Expr1
FROM     dbo.item INNER JOIN
             dbo.set_item ON dbo.item.item_id = dbo.set_item.item_id
  WHERE dbo.set_item.set_id = <cfqueryparam  
					value="#url.s#"  
					cfsqltype="CF_SQL_INTEGER"  
					> 
  ORDER BY set_item.set_item_index
</cfquery>
<!--- <cfdump var="#set_items_by_set#"> --->