<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var char_races = CreateObject( 'component', 'com.blizzard.request.CharacterRacesRequest' ).init( getPublicKey(), getPrivateKey(), getCache() ) />
		<cfset var baseUrl 		= char_races.getRequestEndpoint() />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & getEndpoint() & baseUrl />
		
		<cfset char_races.setBaseEndpoint( baseEndpoint ) />
		
		<cfreturn char_races />
	</cffunction>
	
</cfcomponent>