<cfscript>
wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache,region='cn',locale='zh_CN');

wowitem = wow.getItem(49263);
</cfscript>

<cfdump var=#wowitem#>