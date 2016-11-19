<cfoutput>*</cfoutput>
<cfquery name="sorry" datasource="link">
	INSERT INTO error_log(message,details,type,tagcontext)
	VALUES(<cfqueryparam  
                value="#message#"  
                cfsqltype="CF_SQL_VARCHAR"  
                maxlength="500">  ,<cfqueryparam  
                value="#details#"  
                cfsqltype="CF_SQL_VARCHAR"  
                maxlength="500">  ,<cfqueryparam  
                value="#type#"  
                cfsqltype="CF_SQL_VARCHAR"  
                maxlength="500"> 
,<cfqueryparam  
                value="#tagcontext#"  
                cfsqltype="CF_SQL_VARCHAR"  
                maxlength="500"> 				)
</cfquery>

<cfoutput>$</cfoutput>