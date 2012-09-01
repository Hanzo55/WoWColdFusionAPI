<cfsilent>
	<cfprocessingdirective pageEncoding="utf-8">
	
	<cfparam name="charName" default="Mature" />
	<cfparam name="serverName" default="Deathwing" />

	<cfscript>
	wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache,region='tw',locale='zh_TW');
	d3 = CreateObject('component','com.blizzard.services.d3').init(cache=application.cache);
	
	wowchar = wow.getCharacter(realm='暗影之月',name='鬥歐寶寶',quests=true,pvp=true);
	d3profile = d3.getCareer('Hanzo-1150');	
	</cfscript>
</cfsilent>
<cfdump var=#wowchar#>
<cfdump var=#d3profile#>