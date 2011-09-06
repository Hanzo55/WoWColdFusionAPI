<cfscript>
wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache);

wowguild = wow.getGuild(realm='Deathwing',name='Descendants of Draenor');
</cfscript>

<cfdump var=#wowguild#>