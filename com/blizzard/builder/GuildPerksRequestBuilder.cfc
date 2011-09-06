<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="init" returntype="GuildPerksRequestBuilder" access="public" output="false">
		<cfargument name="bnet_host" type="string" required="true" />
		<cfargument name="bnet_protocol" type="string" required="true" />
			
		<cfreturn super.init(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var guild_perk = CreateObject('component','com.blizzard.request.GuildPerksRequest').init(getPublicKey(), getPrivateKey(), getCache()) />
		<cfset var baseUrl = guild_perk.getEndpoint() />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />		
		
		<cfset guild_perk.setBaseEndpoint(baseEndpoint) />
		
		<cfreturn guild_perk />
	</cffunction>
	
</cfcomponent>