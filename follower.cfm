<cfscript>
d3 = CreateObject('component','com.blizzard.services.d3').init(cache=application.cache);

d3follower = d3.getFollower('enchantress');
</cfscript>

<!--- <cfdump var=#wowitem#> --->
<cfdump var=#d3follower#>