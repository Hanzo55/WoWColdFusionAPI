<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="init" returntype="GuildRewardsRequestBuilder" access="public" output="false">
		<cfargument name="bnet_host" type="string" required="true" />
		<cfargument name="bnet_protocol" type="string" required="true" />
			
		<cfreturn super.init(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var guild_rw = CreateObject('component','com.blizzard.request.GuildRewardsRequest').init(getPublicKey(), getPrivateKey(), getCache()) />
		<cfset var baseUrl = guild_rw.getEndpoint() />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />		
		
		<cfset guild_rw.setBaseEndpoint(baseEndpoint) />
		
		<cfreturn guild_rw />
	</cffunction>
	
</cfcomponent>