<cfparam name="url.selected_state" default="CA">
<cfparam name="url.selected_county" default="none">
<cfparam name="url.selected_city" default="none">
<cfparam name="url.selected_zip" default="none">

<cfquery name="state_list" datasource="who">
SELECT state, state_name from dbo.state ORDER BY state
</cfquery>

<cfquery name="county_list" datasource="who">
SELECT county from dbo.county ORDER BY county
</cfquery>

<cfquery name="city_list" datasource="who">
SELECT city from dbo.city ORDER BY city
</cfquery>

<cfquery name="zip_list" datasource="who">
SELECT zip from dbo.zip ORDER BY zip
</cfquery>

<script>
function get_selected_state(){
	var state = document.getElementById('select_state').value;
	return state;
}
function get_selected_county(){
	var county = document.getElementById('select_county').value;
	return county
}
function getFileName() {
//this gets the full url
var url = document.location.href;
//this removes the anchor at the end, if there is one
url = url.substring(0, (url.indexOf("#") == -1) ? url.length : url.indexOf("#"));
//this removes the query after the file name, if there is one
url = url.substring(0, (url.indexOf("?") == -1) ? url.length : url.indexOf("?"));
//this removes everything before the last slash in the path
url = url.substring(url.lastIndexOf("/") + 1, url.length);
//return
return url;
}

function get_topic_id(){
	var topic_id = getAllUrlParams().topic_id;
	if (topic_id == undefined){
		return "";
	}else{
		return "&topic_id=" + topic_id;
	}

}
function select_state(state_abbr){
	//alert(document.location);
	//var current_location = document.location.href;
	document.location.href= "http://" + document.location.hostname + "/" + getFileName() + "?selected_state=" + get_selected_state() + get_topic_id();
}
function select_county(county){
	//alert(document.location);
	var loc = "http://" + document.location.hostname + "/" + getFileName() +  "?selected_state=" + get_selected_state() + "&selected_county=" + get_selected_county() + get_topic_id();
	//console.log(loc);
	document.location.href= loc;
}
</script>
<div style="margin-top:5px;display:block;">
<cfoutput>
Select State <select name="select_state" id="select_state" onchange="select_state(this.value);">
	<option></option>
	<cfoutput query="state_list">
		<cfif url.selected_state IS state>
			<option selected>#state#</option>
		<cfelse>
			<option >#state#</option>
		</cfif>
	</cfoutput>
</select> AND County <select onchange="select_county(this.value);" name="select_county" id="select_county">
	<option></option>
		<cfoutput query="county_list">
			<cfif url.selected_county IS county>
				<option selected>#county#</option>
			<cfelse>
				<option >#county#</option>
			</cfif>
		</cfoutput>
	</select><!---
	 OR City <select>
	<option></option>
<cfoutput query="city_list">
		<cfif url.selected_city IS city>
			<option selected>#city#</option>
		<cfelse>
			<option >#city#</option>
		</cfif>
	</cfoutput></select> OR ZIP <select>
	<option></option>
<cfoutput query="zip_list">
		<cfif url.selected_zip IS zip>
			<option selected>#zip#</option>
		<cfelse>
			<option >#zip#</option>
		</cfif>
	</cfoutput></select>--->
</cfoutput>
</div>