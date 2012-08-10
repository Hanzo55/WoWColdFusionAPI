<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var guild_perk 	= CreateObject( 'component', 'com.blizzard.request.GuildPerksRequest' ).init( getPublicKey(), getPrivateKey(), getCache() ) />
		<cfset var baseUrl 		= guild_perk.getRequestEndpoint() />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & getEndpoint() & baseUrl />		
		
		<cfset guild_perk.setBaseEndpoint( baseEndpoint ) />
		
		<cfreturn guild_perk />
	</cffunction>
	
</cfcomponent>