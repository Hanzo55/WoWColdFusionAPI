<cfprocessingdirective pageEncoding="utf-8">

<cfscript>
wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache,region='tw',locale='zh_TW');

wowchar = wow.getCharacter(realm='暗影之月',name='鬥歐寶寶',quests=true,pvp=true);
</cfscript>

<cfdump var=#wowchar#>