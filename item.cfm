<cfscript>
//wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache,region='cn',locale='zh_CN');
d3 = CreateObject('component','com.blizzard.services.d3').init(cache=application.cache);

//wowitem = wow.getItem(49263);
d3item = d3.getItem('item/CjkI69nckwISBwgEFYqrsRAd0cNHrB3qGB9bHTbMOzodql7udR1Vum3gHee-mnEwCTj7AkAAUBJg-wIYlK6NiwJQAFgC');
</cfscript>

<!--- <cfdump var=#wowitem#> --->
<cfdump var=#d3item#>