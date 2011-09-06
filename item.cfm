<cfscript>
wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache);

wowitem = wow.getItem(49263);
</cfscript>

<cfdump var=#wowitem#>