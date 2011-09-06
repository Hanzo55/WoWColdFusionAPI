<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="init" returntype="CharacterClassesRequestBuilder" access="public" output="false">
		<cfargument name="bnet_host" type="string" required="true" />
		<cfargument name="bnet_protocol" type="string" required="true" />
			
		<cfreturn super.init(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var char_classes = CreateObject('component','com.blizzard.request.CharacterClassesRequest').init(getPublicKey(), getPrivateKey(), getCache()) />
		<cfset var baseUrl = char_classes.getEndpoint() />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />	
		
		<cfset char_classes.setBaseEndpoint(baseEndpoint) />
		
		<cfreturn char_classes />
	</cffunction>
	
</cfcomponent>