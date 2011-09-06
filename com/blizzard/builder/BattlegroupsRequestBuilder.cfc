<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="init" returntype="BattlegroupsRequestBuilder" access="public" output="false">
		<cfargument name="bnet_host" type="string" required="true" />
		<cfargument name="bnet_protocol" type="string" required="true" />
			
		<cfreturn super.init(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var battlegroups = CreateObject('component','com.blizzard.request.BattlegroupsRequest').init(getPublicKey(), getPrivateKey(), getCache()) />
		<cfset var baseUrl = battlegroups.getEndpoint() />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />			
		
		<cfset battlegroups.setBaseEndpoint(baseEndpoint) />
		
		<cfreturn battlegroups />
	</cffunction>
	
</cfcomponent>