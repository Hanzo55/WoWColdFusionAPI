<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="init" returntype="GuildAchievementsRequestBuilder" access="public" output="false">
		<cfargument name="bnet_host" type="string" required="true" />
		<cfargument name="bnet_protocol" type="string" required="true" />
			
		<cfreturn super.init(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var ga = CreateObject('component','com.blizzard.request.GuildAchievementsRequest').init(getPublicKey(), getPrivateKey(), getCache()) />
		<cfset var baseUrl = ga.getEndpoint() />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />		
		
		<cfset ga.setBaseEndpoint(baseEndpoint) />
		
		<cfreturn ga />
	</cffunction>
	
</cfcomponent>