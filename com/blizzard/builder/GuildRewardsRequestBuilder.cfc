<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var guild_rw 	= CreateObject( 'component', 'com.blizzard.request.GuildRewardsRequest' ).init( getPublicKey(), getPrivateKey(), getCache() ) />
		<cfset var baseUrl 		= guild_rw.getRequestEndpoint() />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & getEndpoint() & baseUrl />		
		
		<cfset guild_rw.setBaseEndpoint( baseEndpoint ) />
		
		<cfreturn guild_rw />
	</cffunction>
	
</cfcomponent>