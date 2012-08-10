<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var battlegroups = CreateObject( 'component', 'com.blizzard.request.BattlegroupsRequest' ).init( getPublicKey(), getPrivateKey(), getCache() ) />
		<cfset var baseUrl 		= battlegroups.getRequestEndpoint() />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & getEndpoint() & baseUrl />			
		
		<cfset battlegroups.setBaseEndpoint( baseEndpoint ) />
		
		<cfreturn battlegroups />
	</cffunction>
	
</cfcomponent>