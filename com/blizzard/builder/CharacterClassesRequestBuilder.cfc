<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var char_classes	= CreateObject( 'component', 'com.blizzard.request.CharacterClassesRequest' ).init( getPublicKey(), getPrivateKey(), getCache() ) />
		<cfset var baseUrl 		= char_classes.getRequestEndpoint() />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & getEndpoint() & baseUrl />	
		
		<cfset char_classes.setBaseEndpoint( baseEndpoint ) />
		
		<cfreturn char_classes />
	</cffunction>
	
</cfcomponent>