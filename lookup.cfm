<cfscript>
wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache,region='kr',locale='ko_KR');

wow_cr = wow.getCharacterRaces();
wow_cc = wow.getCharacterClasses();
wow_gr = wow.getGuildRewards();
wow_gp = wow.getGuildPerks();
</cfscript>

<cfdump var=#wow_cr#>
<cfdump var=#wow_cc#>
<cfdump var=#wow_gr#>
<cfdump var=#wow_gp#>