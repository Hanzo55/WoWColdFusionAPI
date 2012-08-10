<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var ca 			= CreateObject( 'component', 'com.blizzard.request.CharacterAchievementsRequest' ).init( getPublicKey(), getPrivateKey(), getCache() ) />
		<cfset var baseUrl 		= ca.getRequestEndpoint() />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & getEndpoint() & baseUrl />		
		
		<cfset ca.setBaseEndpoint( baseEndpoint ) />
		
		<cfreturn ca />
	</cffunction>
	
</cfcomponent>