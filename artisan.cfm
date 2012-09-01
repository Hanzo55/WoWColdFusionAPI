<cfscript>
d3 = CreateObject('component','com.blizzard.services.d3').init(cache=application.cache);

d3artisan = d3.getArtisan('blacksmith');
</cfscript>

<cfdump var=#d3artisan#>