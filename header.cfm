<head>
<cfif left(cgi.server_name,3) IS "dev">D
</cfif>
<script src="https://www.whocanhelp.org/jquery.js"></script>
<link rel="shortcut icon" href="https://www.whocanhelp.org/files/whocanhelp.png" type="image/x-icon">
<style>
   body {font-family:verdana,sans-serif;font-size:14px;background-color:beige}
   .plusminus{font-family:verdana,sans-serif;font-size:14px;width:250px;background-color:white;}
	
 @media only screen and (max-device-width: 480px) {
   body {font-family:verdana,sans-serif;font-size:48px;}
   .plusminus{font-family:verdana,sans-serif;font-size:48px;width:100%;height:2em;background-color:white;}
   input{font-size:48px;}
   table tr td {font-size:48pxx;}
 }
 </style>
 <script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-87729042-1', 'auto');
  ga('send', 'pageview');

</script>
 <script>
 function getAllUrlParams(url) {

  // get query string from url (optional) or window
  var queryString = url ? url.split('?')[1] : window.location.search.slice(1);

  // we'll store the parameters here
  var obj = {};

  // if query string exists
  if (queryString) {

    // stuff after # is not part of query string, so get rid of it
    queryString = queryString.split('#')[0];

    // split our query string into its component parts
    var arr = queryString.split('&');

    for (var i=0; i<arr.length; i++) {
      // separate the keys and the values
      var a = arr[i].split('=');

      // in case params look like: list[]=thing1&list[]=thing2
      var paramNum = undefined;
      var paramName = a[0].replace(/\[\d*\]/, function(v) {
        paramNum = v.slice(1,-1);
        return '';
      });

      // set parameter value (use 'true' if empty)
      var paramValue = typeof(a[1])==='undefined' ? true : a[1];

      // (optional) keep case consistent
      paramName = paramName.toLowerCase();
      paramValue = paramValue.toLowerCase();

      // if parameter name already exists
      if (obj[paramName]) {
        // convert value to array (if still string)
        if (typeof obj[paramName] === 'string') {
          obj[paramName] = [obj[paramName]];
        }
        // if no array index number specified...
        if (typeof paramNum === 'undefined') {
          // put the value on the end of the array
          obj[paramName].push(paramValue);
        }
        // if array index number specified...
        else {
          // put the value at that index number
          obj[paramName][paramNum] = paramValue;
        }
      }
      // if param name doesn't exist yet, set it
      else {
        obj[paramName] = paramValue;
      }
    }
  }

  return obj;
}

 </script>
 </head>
 


 