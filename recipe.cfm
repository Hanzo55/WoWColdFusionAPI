<cfscript>
wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache);

wowitem = wow.getRecipe(33994);
</cfscript>

<cfdump var=#wowitem#>