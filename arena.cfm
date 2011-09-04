<cfscript>
wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache);

wowbg = wow.getBattlegroups();
wowarena = wow.getArenaInfo('Nightfall','2v2',10);
</cfscript>

<cfdump var=#wowbg#>
<cfdump var=#wowarena#>