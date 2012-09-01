<cfprocessingdirective pageEncoding="utf-8">

<cfscript>
wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache,region='cn',locale='zh_CN');

wowrealms = wow.getRealms('玛洛加尔');
</cfscript>

<cfdump var=#wowrealms#>