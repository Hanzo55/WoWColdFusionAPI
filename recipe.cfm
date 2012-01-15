<cfscript>
wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache,region='us',publicKey='W62vzqkhxmpkiiZU',privateKey='bBwPHUQc15EfBBBh');

wowitem = wow.getRecipe(33994);
</cfscript>

<cfdump var=#wowitem#>