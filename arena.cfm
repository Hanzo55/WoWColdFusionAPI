<cfprocessingdirective pageencoding="utf-8">
<cfscript>
wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache,region='cn',locale='zh_CN');

wowbg = wow.getBattlegroups();
wowarena = wow.getArenaInfo('battle-group-1','2v2',10);
</cfscript>

<cfdump var=#wowbg#>
<cfdump var=#wowarena#>