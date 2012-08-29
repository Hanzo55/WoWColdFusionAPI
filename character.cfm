<cfsilent>
	<cfparam name="charName" default="Mature" />
	<cfparam name="serverName" default="Deathwing" />

	<cfscript>
	wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache);
	
	wowchar = wow.getCharacter(realm=serverName,name=charName,talents=true);
	</cfscript>
</cfsilent>
<cfdump var=#wowchar#>