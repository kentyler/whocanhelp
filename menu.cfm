<cfparam name="session.role" default="Guest">
<cfparam name="session.account_name" default="">

	<cfif session.role IS "Guest">
		<cfoutput>#session.account_name# (#session.role#)</cfoutput>
		
			<a style="margin-left:20px;" href="account_login.cfm">Log In</a>
		
			<a style="margin-left:20px;" href="account_create.cfm">Create Account</a>
	<cfelse>
		<cfoutput><a href="my_account.cfm">#session.account_name# (#session.role#)</a></cfoutput>
		<cfif session.role IS "Admin">
			<a  style="margin-left:20px;" href="site_admin.cfm">Site Admin</a>
		</cfif>
		
			<a style="margin-left:20px;" href="account_logout.cfm">Log Out</a>
		
	
	</cfif>
	

<cfoutput>
<!--- <a style="margin-left:20px;" href="https://whocanhelp.org/your_location.cfm">Your Location</a> --->
<a style="margin-left:20px;" href="about_us.cfm">About Us</a>

<a style="margin-left:20px;" href="get_help.cfm">Get Help</a>
<cfif isdefined('session.role') and session.role NEQ "Guest">
	<a style="margin-left:10px;" href="all_resources.cfm">All Resources</a>
</cfif>
<a style="margin-left:20px;" href="http://www.whocanhelp.org/wordpress/">Blog</a>
<div>
<cfinclude template="area_selector.cfm">
</div>
</cfoutput>
<script src="http://www.whocanhelp.org/jquery.js"></script>