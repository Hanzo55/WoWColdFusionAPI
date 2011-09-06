<cfscript>
wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache);

wowah = wow.getAuctionHouse(realm='Deathwing');
</cfscript>

<cfdump var=#wowah# top="10">