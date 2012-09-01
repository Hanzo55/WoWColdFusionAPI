<cfprocessingdirective pageEncoding="utf-8">

<cfscript>
wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache,region='tw',locale='zh_TW');

wowah = wow.getAuctionHouse(realm='暗影之月');
</cfscript>

<cfdump var=#wowah# top="10">