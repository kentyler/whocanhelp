<cfoutput>

<cfquery name="resource_list" datasource="who">
	SELECT   dbo.item.item_id, 
	dbo.item.set_id, 
	dbo.item.item_type_id, 
	dbo.item.title, 
	dbo.item.link, 
	dbo.item.street, 
	dbo.item.city,
	dbo.item.state, 
	dbo.item.zip, 
	dbo.item.contact_information, 
	dbo.item.contact_email,
	dbo.item.contact_form,
	dbo.item.contact_phone,
	dbo.item.description, 
	dbo.item.account_id, 
	dbo.item.date_and_time, 
	dbo.item.set_item_index, 
	dbo.set_item.set_item_id, 
	dbo.set_item.set_id AS Expr1
	FROM     dbo.item INNER JOIN
				 dbo.set_item ON dbo.item.item_id = dbo.set_item.item_id
	WHERE dbo.set_item.set_id = 3
	ORDER BY title
</cfquery>

<h3>Resource List</h3>
<table border="1" >
	<tr>
		<th></th>
		<th>
		Title
		</th>
		
	
		<th>
		Website
		</th>
	
		<th>
		Description
		</th>
		
		<th>
		Address
		</th>
		<th>
		City
		</th>
		<th>
		State
		</th>
		<th>
		ZIP
		</th>
		<th>
		Contact Information
		</th>
		<th>
		Contact Email
		</th>
		<th>
		Contact Form
		</th>
		<th>
		Contact Phone
		</th>
		</th>
		<cfoutput query="resource_list">
		<tr>
		<td>
		<a href="edit_resource.cfm?item_id=#item_id#"><font color="red">edit</font></a>
		</td>
		<td>
		#title#
		</td>
	
		<td>
		#link#
		</td>
		
		<td>
		#description#
		</td>
		<td>
		#street#
		</td>
	<td>
		#city#
		</td>
		<td>
		#state#
		</td>
		<td>
		#zip#
		</td>
		<td>
		#contact_information#
		</td>
		<td>
		#contact_email#
		</td>
		<td>
		#contact_form#
		</td>
		<td>
		#contact_phone#
		</td>
		</tr>
		</cfoutput>
</table>
</cfoutput>