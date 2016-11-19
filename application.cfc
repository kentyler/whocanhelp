


/**
@title "Application.cfc reference in CFScript for Coldfusion 9"
@description "This component includes all Application.cfc methods and variables, set to their default values (if applicable). Please note that default values are not always desirable, and some methods or variables should be modified or removed depending on the situation."
@author "Russ Spivey (http://cfruss.blogspot.com)"

@dateCreated "November 29, 2009"
@licence "This work is licensed under the Creative Commons Attribution 3.0 United States License. To view a copy of this license, visit http://creativecommons.org/licenses/by/3.0/us/ or send a letter to Creative Commons, 171 Second Street, Suite 300, San Francisco, California, 94105, USA."

@hint "You implement methods in Application.cfc to handle ColdFusion application events and set variables in the CFC to configure application characteristics."
*/

component output="false" {


/* **************************** APPLICATION VARIABLES **************************** */

// The application name. If you do not set this variable, or set it to the empty string, your CFC applies to the unnamed application scope, which is the ColdFusion J2EE servlet context.
THIS.name = "foo";

// Life span, as a real number of days, of the application, including all Application scope variables.
THIS.applicationTimeout = createTimeSpan(0, 1, 0, 0);

// Whether the application supports Client scope variables.
THIS.clientManagement = false;

// Where Client variables are stored; can be cookie, registry, or the name of a data source.
THIS.clientStorage = "registry"; //cookie||registry||datasource

// Contains ColdFusion custom tag paths.
THIS.customTagPaths = "";

// The Google Maps API key required to embed Google Maps in your web pages.
THIS.googleMapKey = "";

// Name of the data source from which the query retrieves data.
THIS.datasource = "";

// Whether to store login information in the Cookie scope or the Session scope.
THIS.loginStorage = "cookie"; //cookie||session

// A structure that contains ColdFusion mappings. Each element in the structure consists of a key and a value. The logical path is the key and the absolute path is the value.
THIS.mappings = {};

// Whether to enable validation on cfform fields when the form is submitted.
THIS.serverSideFormValidation = true;

// Whether the application supports Session scope variables.
THIS.sessionManagement = true;

// Life span, as a real number of days, of the user session, including all Session variables.
THIS.sessionTimeout = createTimeSpan(0, 0, 30, 0);

// Whether to send CFID and CFTOKEN cookies to the client browser.
THIS.setClientCookies = true;

// Whether to set CFID and CFTOKEN cookies for a domain (not just a host).
THIS.setDomainCookies = false;

// Whether to protect variables from cross-site scripting attacks.
THIS.scriptProtect = false;

// A Boolean value that specifies whether to add a security prefix in front of the value that a ColdFusion function returns in JSON-format in response to a remote call.
THIS.secureJSON = false;

// The security prefix to put in front of the value that a ColdFusion function returns in JSON-format in response to a remote call if the secureJSON setting is true.
THIS.secureJSONPrefix = "";

// A comma-delimited list of names of files. Tells ColdFusion not to call the onMissingTemplate method if the files are not found.
THIS.welcomeFileList = "";

// A struct that contains the following values: server, username, and password.If no value is specified, takes the value in the administrator.
THIS.smtpServersettings = {};

// Request timeout. Overrides the default administrator settings.
THIS.timeout = 30; // seconds

// A list of ip addresses that need debugging.
THIS.debugipaddress = "";

// Overrides the default administrator settings. It does not report compile-time exceptions.
THIS.enablerobustexception = false;

/* ORM variables */

// Specifies whether ORM should be used for the ColdFusion application.Set the value to true to use ORM. The default is false.
THIS.ormenabled = false;

// The struct that defines all the ORM settings. Documentation: http://help.adobe.com/en_US/ColdFusion/9.0/Developing/WSED380324-6CBE-47cb-9E5E-26B66ACA9E81.html
THIS.ormsettings = {};

// note: THIS.datasource applies to cfquery as well as ORM. It is defined on line 31.


/* **************************** APPLICATION METHODS **************************** */

/**
@hint "Runs when an application times out or the server is shutting down."
@ApplicationScope "The application scope."
*/
public void function onApplicationEnd(struct ApplicationScope=structNew()) {

return;
}

/**
@hint "Runs when ColdFusion receives the first request for a page in the application."
*/
public boolean function onApplicationStart() {

return true;
}

/**
@hint "Intercepts any HTTP or AMF calls to an application based on CFC request."
@cfcname "Fully qualified dotted path to the CFC."

@method "The name of the method invoked."
@args "The arguments (struct) with which the method is invoked."
*/
public void function onCFCRequest(required string cfcname, required string method, required string args) {

return;
}

/**
@hint "Runs when an uncaught exception occurs in the application."
@Exception "The ColdFusion Exception object. For information on the structure of this object, see the description of the cfcatch variable in the cfcatch description."
@EventName "The name of the event handler that generated the exception. If the error occurs during request processing and you do not implement an onRequest method, EventName is the empty string."

note: This method is commented out because it should only be used in special cases
*/

public void function onError(required any Exception, required string EventName) {

	
		TagContext = serialize(arguments.exception.tagcontext);
		TagContext = left(TagContext,500)
		Message= #arguments.exception.message#;
		Details= #arguments.exception.detail#;
		Type= #arguments.exception.type#;
include "sorry.cfm";
return;
}


/**
@hint "Runs when a request specifies a non-existent CFML page."
@TargetPage "The path from the web root to the requested CFML page."
note: This method is commented out because it should only be used in special cases
*/
/*
public boolean function onMissingTemplate(required string TargetPage) {
return true;
}
*/

/**
@hint "Runs when a request starts, after the onRequestStart event handler. If you implement this method, it must explicitly call the requested page to process it."
@TargetPage "Path from the web root to the requested page."
note: This method is commented out because it should only be used in special cases
*/
/*
public void function onRequest(required string TargetPage) {
return;
}
*/

/**
@hint "Runs at the end of a request, after all other CFML code."

*/
public void function onRequestEnd() {
include template="footer.cfm"
return;

}

/**
@hint "Runs when a request starts."
@TargetPage "Path from the web root to the requested page."
*/
public boolean function onRequestStart(required string TargetPage) {

include template="header.cfm"
return true;
}

/**
@hint "Runs when a session ends."
@SessionScope "The Session scope"

@ApplicationScope "The Application scope"
*/
public void function onSessionEnd(required struct SessionScope, struct ApplicationScope=structNew()) {

return;
}

/**
@hint "Runs when a session starts."
*/
public void function onSessionStart() {
session.return_url = "none"
session.account_name = "none"
session.account_user_name="guest"
session.account_id = 0
session.role = "guest"
/* 3 = guest */
if(listlen(cgi.server_name,".") IS 3){
session.suffix = listfirst(cgi.server_name,".")
}else{
session.suffix = "www"
}

return;
}

}