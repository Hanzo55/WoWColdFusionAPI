<cfprocessingdirective pageEncoding="utf-8">

<cfscript>
wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache,region='cn',locale='zh_CN');

//wowguild = wow.getGuild(realm='黑铁',name='回音群岛');
wowguild = wow.getGuild(realm='风暴之怒',name='We are the future');
</cfscript>

<cfdump var=#wowguild#>