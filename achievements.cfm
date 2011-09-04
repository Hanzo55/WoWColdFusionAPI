<cfscript>
wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache);

wowca = wow.getCharacterAchievements();
wowga = wow.getGuildAchievements();
</cfscript>

<cfdump var=#wowca#>
<cfdump var=#wowga#>