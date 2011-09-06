<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="init" returntype="CharacterAchievementsRequestBuilder" access="public" output="false">
		<cfargument name="bnet_host" type="string" required="true" />
		<cfargument name="bnet_protocol" type="string" required="true" />
			
		<cfreturn super.init(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var ca = CreateObject('component','com.blizzard.request.CharacterAchievementsRequest').init(getPublicKey(), getPrivateKey(), getCache()) />
		<cfset var baseUrl = ca.getEndpoint() />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />		
		
		<cfset ca.setBaseEndpoint(baseEndpoint) />
		
		<cfreturn ca />
	</cffunction>
	
</cfcomponent>