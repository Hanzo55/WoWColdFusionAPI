<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="init" returntype="CharacterRacesRequestBuilder" access="public" output="false">
		<cfargument name="bnet_host" type="string" required="true" />
		<cfargument name="bnet_protocol" type="string" required="true" />
			
		<cfreturn super.init(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var char_races = CreateObject('component','com.blizzard.request.CharacterRacesRequest').init(getPublicKey(), getPrivateKey(), getCache()) />
		<cfset var baseUrl = char_races.getEndpoint() />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />
		
		<cfset char_races.setBaseEndpoint(baseEndpoint) />
		
		<cfreturn char_races />
	</cffunction>
	
</cfcomponent>