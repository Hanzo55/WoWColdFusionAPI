<cfscript>
wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache);

wowchar = wow.getCharacter(realm='Deathwing',name='Mature',quests=true,pvp=true);
</cfscript>

<cfdump var=#wowchar#>