<cfprocessingdirective pageEncoding="utf-8">

<cfscript>
//wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache,region='tw',locale='zh_TW');
d3 = CreateObject('component','com.blizzard.services.d3').init(cache=application.cache);

//wowchar = wow.getCharacter(realm='暗影之月',name='鬥歐寶寶',quests=true,pvp=true);

d3hero = d3.getHero('Hanzo-1150','8391756');
</cfscript>

<cfdump var=#d3hero#>