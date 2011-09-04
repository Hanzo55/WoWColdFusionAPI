<cfscript>
wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache);

wowquest = wow.getQuestInfo(25);
</cfscript>

<cfdump var=#wowquest#>