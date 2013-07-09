<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
	<title>SMYAYA Schema Builder!</title>
	<!--
	Google Maps Source Code and Pin Drop Code:
	Copyright 2008 Google Inc. 
	Licensed under the Apache License, Version 2.0: 
	http://www.apache.org/licenses/LICENSE-2.0 
	-->
	<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=AIzaSyBJnUNRBz-bDFDaCRO1RCovC6JvHU3SbB0"
	type="text/javascript"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
	<link rel="stylesheet" href="../resources/demos/style.css" />
	<script src="../jquery.maskedinput.min.js" type="text/javascript"></script>
	<!--
	The following is to add the item to the geo list.
	Public Domain Code by John Amoratis
	-->
	<script>
	var $smyayaGeoLat = 0;
	var $smyayaGeoLng = 0;
	
	function addItemToList($whichList,$whichOperation){
	
		if ($whichOperation == 1) {
			if ($smyayaGeoLat > 0){	
				var x=document.getElementById($whichList);
				var option=document.createElement("option");
				option.text = '{';
				option.text += '"title":"'+prompt('Please enter a title')+'",';
				option.text += '"subtitle":"'+prompt('Please enter a subtitle')+'",';
				option.text += '"geolat":"'+$smyayaGeoLat+'","geolong":"'+$smyayaGeoLng+'"';
				option.text += '},';
				try
				{
				// for IE earlier than version 8
				x.add(option,x.options[2]);
				}
				catch (e)
				{
				x.add(option,2);
				}	
			}else
			{
				alert ('Oops!  Error. Please find a spot first.');
			}
		} else if ($whichOperation == 2) {
			var $itemTitle = document.getElementById('itemTitle').value;
			var $itemText = document.getElementById('itemText').value;
			
			var x=document.getElementById($whichList);
			var option=document.createElement("option");
			option.text = '{';
			option.text += '"title":"'+$itemTitle+'",';
			option.text += '"content":"'+$itemText+'"';
			option.text += '},';
			try
			{
			// for IE earlier than version 8
			x.add(option,x.options[2]);
			}
			catch (e)
			{
			x.add(option,2);
			}
		}else
			{
			alert ('Oops!  Error. Please find a spot first.');
			}
		}
		
	<!--
	Delete item from list when press delete
	-->
	
	function removeOption($whichList)
	{
		var x=document.getElementById($whichList);
		x.remove(x.selectedIndex);
	}
	
	function KeyCheck($whichList)
	{
	   var KeyID = event.keyCode;
	   switch(KeyID)
	   {
	   case 8:
	   removeOption($whichList);
	   break; 
	   case 46:
	   removeOption($whichList);
	   break;
	   default:
	   break;
	   }
	}
	
	var map = null;
	var geocoder = null;
	
	function initialize() {
		if (GBrowserIsCompatible()) {
		map = new GMap2(document.getElementById("map_canvas"));
		map.setCenter(new GLatLng(37.4419, -122.1419), 1);
		map.setUIToDefault();
		geocoder = new GClientGeocoder();
		}
	}
	
	function showAddress(address) {
		if (geocoder) {
			geocoder.getLatLng(
			address,
			function(point) {
			if (!point) {
			alert(address + " not found");} 
		else {	
			map.setCenter(point, 15);
			var marker = new GMarker(point, {draggable: true});
			map.addOverlay(marker);
			GEvent.addListener(marker, "dragend", function() {
			marker.openInfoWindowHtml(marker.getLatLng().toUrlValue(6));
			});
			GEvent.addListener(marker, "click", function() {
			marker.openInfoWindowHtml(marker.getLatLng().toUrlValue(6));
			$smyayaGeoLat = marker.getLatLng().lat().toString();
			$smyayaGeoLng = marker.getLatLng().lng().toString();
			});
			GEvent.trigger(marker, "click");
	}
	}
	);
	}
	}
	</script>
	
	<style>
	body{
	background-color:gold;
	}
	</style>
</head>

<body onload="initialize()" onunload="GUnload()">


<div id="tabs">
<ul>
<li><a href="#fragment-1"><span>1. Pick a Title</span></a></li>
<li><a href="#fragment-2"><span>2. Geolocations</span></a></li>
<li><a href="#fragment-3"><span>3. Set a newsfeed</span></a></li>
<li><a href="#fragment-4"><span>4. Enter Menu Items</span></a></li>
<li><a href="#fragment-6"><span>5. Make the schema!</span></a></li>
</ul>
<div id="fragment-1">
1. Select a Title<br>
<input type="text" name="mainTitle" id="mainTitle" maxlength="12"><br>
(Please do not use spaces)
<br><br>
What is going on here?<br>This is where schemas are made for the smyaya app. You can select menu items and geolocations. They will be placed into a schema and zipped into a zip file. Then the smyaya app can import them. Once you download your schema (in step 5) you will have to upload it to a server and then announce the address to your students, club members, or whoever else you are working with. In the future, we would like to continue to streamline this process for users. In the mean time, we hope you enjoy creating your schema! Thank you! <a href="mailto:saintmarysyaya@gmail.com">E-mail us if you need support</a></div>
<div id="fragment-2">
<form action="#" onsubmit="showAddress(this.address.value); return false">
<p>
Enter an address, and then drag the marker to tweak the location.
<br/>
The latitude/longitude will appear in the infowindow after each geocode/drag.
</p>
<p>
<input type="text" style="width:350px" name="address" value="139 Church St, Saint Marys, PA" />
<input type="submit" value="Find" /> <input type="button" onclick="addItemToList('geoItems',1)" value="Add to Schema" />
</p>
<div id="map_canvas" style="width: 600px; height: 400px"></div>
</form>

<div id="geoListListbox" style="position:absolute;position:absolute;bottom:20px;width:400px;left:650px;font-size:9px;">

<select style="width:400px;height:400px;" size="3" id="geoItems" name="geoItems" onkeydown="KeyCheck('geoItems')">
<option>{
<option>"geolocations": [
<option>]
<option>}
</select></div>

</div>
<div id="fragment-3">
<input type="text" id="nowNews" onkeydown="validateNewsFeedURL(this.value)" style="width:500px;"><input type="button" onclick="javascript:document.getElementById('iPhonePreview').src=document.getElementById('nowNews').value;" value="Preview Now"><br><br><span style="color:gray;">Please use the complete address (in other words, starting with http://www )</span><br><br>Note: This is a very approximate preview and may not match actual appearance in iPhone<br>
<div style="background-image:url('iPhone.png');width:380px;height:770px;">
<iframe id="iPhonePreview" src="http://www.smyaya.com" style="position:relative;top:122px;left:46px;width:290px;height:520px;"></iframe></div>
<!-- iPhone image courtest of open clip art: http://openclipart.org/detail/172475/iphone-5-black-by-jhnri4-172475 -->
</div>
<div id="fragment-4">

<div style="position:relative;left:0px;height:500px;width:400px;"><input id="itemTitle" type="text"><br>
<textarea id="itemText" style="height:500px;">Place text here...</textarea></div>
<div style="position:absolute;left:400px;top:0;height:500px;width:200px;padding-top:200px;"><input type="button" value="Add >>>" onclick="addItemToList('menuItems',2)"></div>
<div style="position:absolute;top:70px;left:600px;height:500px;width:200px;"><select style="width:400px;height:400px;" size="3" id="menuItems" name="menuItems" onkeydown="KeyCheck('menuItems')">
<option>{
<option>"menuitems": [
<option>]
<option>}
</select></div>
<br>

<br><br>

<hr>
<br>
</div>

<div id="fragment-6">
Create zip file of elements<br>

<script type="text/javascript">
function saveZip(){

$mainTitle = document.getElementById('mainTitle').value;
alert($mainTitle);
$nowAddress = document.getElementById('nowNews').value;
$sendGeo = getGeoJSON();
$sendMenuItems = getMenuItemContent();
alert($sendGeo);

$.ajax(
{
type: "POST",
url: "form-processor.php",
data: {
mainTitle:$mainTitle,
geoJSON:$sendGeo,
menuItemJSON:$sendMenuItems,
nowAddress:$nowAddress}
}).done(function( msg ) {
//document.getElementById('mainBackDiv').innerHTML = msg;
//alert(msg);
$resultContent = 'Success! Here is your download link:<br>';
$resultContent += '<a href="http://s468732416.onlinehome.us/schemebuilda/'+$mainTitle+'.zip"><br>';
$resultContent += '(Right click or option click the link to download your schema.)';

document.getElementById('zipResult').innerHTML = $resultContent;

alert( "Data Saved: " + msg + $data );
});


}

//where geoItems turned into string

function getGeoJSON(){
$geoJSONline = "";
for (var i=0;i<document.getElementById('geoItems').length;i++)
{ 
$geoJSONline += document.getElementById('geoItems').options[i].value;
}
return $geoJSONline;
}


function getMenuItemContent(){
$menuItemsLine = "";
for (var i=0;i<document.getElementById('menuItems').length;i++)
{ 
$menuItemsLine += document.getElementById('menuItems').options[i].value;
}
return $menuItemsLine;
}


</script>


<input type="button" onclick="saveZip()" value="Build this Schema!">
<div id="zipResult" style="width:500px;height:500px;"></div>


</div>


</div>

<script>
$( "#tabs" ).tabs();
$("#geoItems").dblclick(function() {
alert(document.getElementById('geoItems').value);
});
$("#menuItems").dblclick(function() {
alert(document.getElementById('menuItems').value);
});
</script>
</body>
</html>
