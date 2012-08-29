<cfscript>
wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache,region='kr',locale='ko_KR');

wowquest = wow.getQuestInfo(25);
</cfscript>

<cfdump var=#wowquest#>