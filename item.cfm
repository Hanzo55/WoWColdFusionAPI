<cfscript>
wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache,region='us',publicKey='W62vzqkhxmpkiiZU',privateKey='bBwPHUQc15EfBBBh');

wowitem = wow.getItem(49263);
</cfscript>

<cfdump var=#wowitem#>