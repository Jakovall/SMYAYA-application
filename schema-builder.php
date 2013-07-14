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
				option.text += '"title":"'+document.getElementById('geoName').value+'",';
				option.text += '"subtitle":"'+document.getElementById('geoSubtitle').value+'",';
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
		
	
	</script>
	
	

	
	<script type="text/javascript">
	
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
	alert(address + " not found");
	} else {
	
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
	
	<script type="text/javascript">
	//Autocorrect title to be valid
	function makeAlphaNumeric($inputString,$spaceFlag){
	    if ($spaceFlag == 1){
		return $inputString.replace(/[^a-z \u00D1\u00F10-9]/ig,'');
		}else{
			return $inputString.replace(/\W/g, '');
		}
	}
	
	function cleanNewsFeedURL($inputString){
		var n=$inputString.indexOf('http://www.');
		if (n != 0){
		    //$inputString.replace('http://www.', '');
		    alert('This address must begin with "http://www."');
		    return 'http://www.';// + $inputString;
		}else{
			return $inputString;
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
<li><a href="#fragment-0"><span>Quick Tour</span></a></li>
<li><a href="#fragment-1"><span>1. Choose a Title</span></a></li>
<li><a href="#fragment-2"><span>2. Add Geo</span></a></li>
<li><a href="#fragment-3"><span>3. Enter a News Page</span></a></li>
<li><a href="#fragment-4"><span>4. Enter Info Items</span></a></li>
<li><a href="#fragment-6"><span>5. Make Your Schema!</span></a></li>
</ul>
<div id="fragment-0" style="overflow:auto;">
<div style="clear:both;width:100%;height:2em;background-color:black;line-height:2em;overflow:hidden;"><div id="innerTags" style="color:gold;padding-left:1em;width:100%;overflow:hidden;">Technologies: Objective C Javascript JSON PHP JQuery Ajax JQuery UI Github </div></div>
<img align="left" src="schema-illustration.jpg"><br><img style="margin-right:.5em;" align="left" src="john1-1.jpg"><span style="font-size:.8em;"><span style="font-weight:bold;">Meta Ministry?</span><br>In the modern era, for a parish or ministry to be absent from iOS devices is inexcusable. Let's get everybody onto iPhones and iPads! I took a poll at our Life Teen and 100% of kids owned an iOS device. On the same day, I asked the students to raise their hands if they had picked up the paper parish bulletin even one single time in the past year... and zero hands went up. What if we changed the whole way young people tapped into Church news? Proudly presenting: the SMYAYA App, a tool that lets everybody instantly share their ministries, clubs, and classes with iOS users. As youth minister, I warmly encourage all ministries and classes to translate their news and communications to the mobile devices that form such a crucial part of the lives of young people. The very act of achieving this constitutes a broad and significant youth ministry advancement.</span><br><div style="background-color:gold;width:100%;height:auto;float:left;"><div style="width:45%;background-color:gold;padding:1em;float:left;"><span style="font-size:.8em;"><span style="font-weight:bold;clear:both;">Presenting SMYAYA</span><br>I have assembled a highly intelligent team which has produced this amazing tool. Every ministry, club, or class has a story to tell about itself, news to share, and places that are important to its members, so my team has produced an amazing app to help them accomplish these goals. The SMYAYA App is attractive, easy to use, and free. Just build your own schema, place that schema onto a server, and share the address to your schema with your club, class, or those you serve in your ministry. This is not a commercial service, and it may not be for everyone. If you need more functionality, then you should build your own app from the ground up or use a commercial app service. SMYAYA is not an 'app builder.' It is one single app which accepts 'schemas' to fill in simple content.</span></span></div>
<div style="width:45%;background-color:gold;padding:1em;float:left;"><span style="font-size:.8em;"><span style="font-weight:bold;">&nbsp;</span><br>Many who serve in the Church would describe themselves as technological novices. Here is an empowering way to share some basic information, news, and geolocations. Simply use the tabs at the top of this page to create your own schema. Then place it onto your own web server space. Then, the next time your club, class, or ministry meets, have everyone use their iOS devices to install SMYAYA from the App Store, and then distribute the web address where they can download your schema. In minutes, you will have forged an important new connection with your group.</span></div></div><br>&nbsp;<br>
<div style="display:inline-block;width:33%;float:left;border:1px;"><img style="border:2px dotted gold;margin-right:1em;" align="left" src="john.png">&#74;ohn &#65;moratis<br>Youth Minister,<br>Web Programmer</div>
<div style="display:inline-block;width:33%;float:left;"><img style="border:2px dotted gold;margin-right:1em;" align="left" src="chris.png">&#67;hris &#68;ollinger<br>Computer Science Student,<br>Seton Hill University<br>Lead Objective C Programmer</div>
<div style="display:inline-block;width:33%;border:1px;float:left;"><img style="border:2px dotted gold;margin-right:1em;" align="left" src="kurt.png">&#75;urt &#70;loyd<br>Digital Artist,<br>Lead Graphic Designer</div>

</div>
<div id="fragment-1">
1. Enter a Title for Your Schema<br>
<input type="text" name="mainTitle" id="mainTitle" onkeyup="javascript:this.value=makeAlphaNumeric(this.value);" maxlength="12"><br>
Alphabetic characters only, please. (No spaces, numbers, punctuation, etc.)
<br><br>
What is going on here?<br>This is where schemas are made for the smyaya app. You can select menu items and geolocations. They will be placed into a schema and zipped into a zip file. Then the smyaya app can import them. Once you download your schema (in step 5) you will have to upload it to a server and then announce the address to your students, club members, or whoever else you are working with. In the future, we would like to continue to streamline this process for users. In the mean time, we hope you enjoy creating your schema! Thank you! <a href="mailto:saintmarysyaya@gmail.com">E-mail us if you need support</a></div>
<div id="fragment-2">
<form action="#" onsubmit="showAddress(this.address.value); return false">
<p>
Instructions:<br>
<!-- 1. Enter an address<br>
2. Click the <span style="background-color:Gainsboro;">&nbsp;Find&nbsp;</span> button
<br/>
3. When the correct location appears, type in a Title and Subtitle<br>
4. Click the <span style="background-color:Gainsboro;">&nbsp;Add to Schema&nbsp;</span> button.<br>
5. Repeat this process for additional locations 
</p>
<hr> -->
<p>
1. Enter an address here: <input type="text" style="width:350px;font-size:.8em;" id="geoAddress" name="address" value="139 Church St, Saint Marys, PA" />
2. Click <input type="submit" value="Find" /> <br>
3. Give this place a name: <input type="text" style="width:250px;font-size:.8em;" id="geoName" name="geoName" value="Saint Example Hall" onkeyup="javascript:this.value=makeAlphaNumeric(this.value,1);" /> &nbsp;&nbsp;... and a subtitle: <input type="text" style="width:250px;font-size:.8em;" id="geoSubtitle" name="geoSubtitle" value="Where insert content happens" onkeyup="javascript:this.value=makeAlphaNumeric(this.value,1);" /><br>
4. Click <input type="button" onclick="addItemToList('geoItems',1)" value="Add to Schema" /> <br>5. <input type="button" value="Clear Fields"> and repeat for additional locations
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
Enter the address of a news page (must be in html format, not an rss feed for example.)
<input type="text" id="nowNews"  style="width:500px;" value="http://www." onkeyup="javascript:this.value=cleanNewsFeedURL(this.value);"><!-- <input type="button" onclick="javascript:document.getElementById('iPhonePreview').src=document.getElementById('nowNews').value;" value="Preview Now">--><!--<span style="color:red;">Please use the complete address (in other words, starting with http://www )<br>Also, please use a newsfeed which is device aware, such as a WordPress page which will automatically scale itself to look good on various screen sizes</span>--><br><!-- <br><br>Note: This is a very approximate preview and may not match actual appearance in iPhone<br>-->
<br>Figure: A sample news feed page.<br>
<img style="border:2px dotted gold;" src="sample-news-page.jpg"><br>This sample news feed page was served by a WordPress blog. Many WordPress pages specially adapt themselvess to the iPhone's screen dimensions. We encourage those making SMYAYA schemas to test out their news feed pages on several iOS devices to ensure that the pages look great. Your users deserve the best.
<div style="visibility:hidden;background-image:url('iPhone.png');width:380px;height:770px;">
<iframe style="visibility:hidden;" id="iPhonePreview" src="http://www.smyaya.com" style="position:relative;top:122px;left:46px;width:290px;height:520px;"></iframe></div>
<!-- iPhone image courtest of open clip art: http://openclipart.org/detail/172475/iphone-5-black-by-jhnri4-172475 -->
</div>
<div id="fragment-4">

<div style="position:relative;left:0px;height:500px;width:400px;"><input id="itemTitle" type="text" onkeyup="javascript:this.value=makeAlphaNumeric(this.value,1);"><br>
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
Create your schema file!<br>
<div id="saveAlerts" style="color:red;"></div>
<script type="text/javascript">
function saveZip(){
document.getElementById('saveAlerts').innerHTML = '';


$mainTitle = document.getElementById('mainTitle').value;
$errFlag = 0;

if ($mainTitle == ''){
    document.getElementById('saveAlerts').innerHTML = document.getElementById('saveAlerts').innerHTML + '<br>No title has been set! <b>Resolution: Go to tab 1 and enter a title</b>';
    $errFlag = 1;
}


if (document.getElementById('geoItems').length < 5){
	document.getElementById('saveAlerts').innerHTML = document.getElementById('saveAlerts').innerHTML + '<br>No Geo Items are set! <b>Resolution: Go to tab 2 and add some geo locations</b>';
	//alert('No geo items are set!');
	$errFlag = 1;
};

if (document.getElementById('nowNews').value == 'http://www.'){
    document.getElementById('saveAlerts').innerHTML = document.getElementById('saveAlerts').innerHTML + '<br>No news page has been set! <b>Resolution: Go to tab 3 and enter an address for your news page</b>';
    $errFlag = 1;
}
//alert(document.getElementById('menuItems').length+'');
if (document.getElementById('menuItems').length < 5){
	document.getElementById('saveAlerts').innerHTML = document.getElementById('saveAlerts').innerHTML + '<br>No Menu Items are set! <b>Resolution: Go to tab 4 and add some menu items</b>';
	//alert('No geo items are set!');
	$errFlag = 1;
};


//if ($mainTitle != ''

if ($errFlag != 1){

alert('Your schema is being created. You will soon be presented with a download link. Please download your schema to your own computer, then upload it to your own server space. Have your students or group members install SMYAYA from the App Store, then distribute your schema link to them.');
$nowAddress = document.getElementById('nowNews').value;
$sendGeo = getGeoJSON();
$sendMenuItems = getMenuItemContent();

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
$resultContent += '(Right click or option click the link to download your schema. THEN put it up on your own web server space, and distribute the link to your students or club members!)';

document.getElementById('zipResult').innerHTML = $resultContent;

//location.href = 'http://s468732416.onlinehome.us/schemebuilda/wfe.zip';

//alert( "Data Saved: " + msg + $data );
});

}//end if $errFlag != 1
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
