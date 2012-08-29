<cfscript>
wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache,region='cn',locale='zh_CN');

wowca = wow.getCharacterAchievements();
wowga = wow.getGuildAchievements();
</cfscript>

<cfdump var=#wowca#>
<cfdump var=#wowga#>