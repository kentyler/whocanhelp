<cfoutput>
<cfquery name="get_related_account" datasource="who">
	SELECT        dbo.account.account_id, dbo.account.account_name, dbo.account.account_email, dbo.account.account_phone, dbo.account.account_password, dbo.account.is_approved, dbo.account.account_user_name, 
                         dbo.account_relationship.account_relationship, dbo.account_related_account.related_account_id, dbo.account_relationship.account_relationship_id

	FROM            dbo.account INNER JOIN
                         dbo.account_related_account ON dbo.account.account_id = dbo.account_related_account.related_account_id INNER JOIN
                         dbo.account_relationship ON dbo.account_related_account.account_relationship_id = dbo.account_relationship.account_relationship_id
	WHERE  dbo.account_related_account.account_id=<cfqueryparam sqltype="cf_sql_int" value="#get_account.account_id#">
</cfquery>

	<h3>Related Accounts</h3>
	<table>
	<tr>
		<th></th>
		<th>Account</th>
		<th>&nbsp;&nbsp;</th>
		<th >Relationship</th>
	</tr>
	<cfoutput query="get_related_account">
		<tr>
			<td>
			<input type="button" value="+" id="btn_add_#related_account_id-account_relationship_id#" onclick="open_close(this,#related_account_id-account_relationship_id#);" />
			</td>
			<td>
			#account_name#
			</td>
			<th>&nbsp;&nbsp;</th>
			<td>
			#account_relationship#
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<div id="related_accounts_#related_account_id-account_relationship_id#" style="display:none;">
				related accounts
				</div>
			</td>
		</tr>
		
	</cfoutput>
	</table>
<script>
	function open_close(e,parent_set_id){
	//alert(e.value);
	var child_set_div_id = "related_accounts_" + parent_set_id;
	if (e.value == "+"){
		e.value="-";
		document.getElementById(child_set_div_id).style.display="block";
	}else{
		e.value="+";
		document.getElementById(child_set_div_id).style.display="none";
	}
	}
</script>

</cfoutput>