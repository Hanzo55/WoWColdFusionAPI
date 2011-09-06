<cfscript>
wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache);

wowrealms = wow.getRealms();
</cfscript>

<cfdump var=#wowrealms#>