<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="setDataFactory" returntype="void" access="public" output="false">
		<cfargument name="data_factory" type="com.blizzard.factory.RequestFactory" required="true" />
	
		<cfset variables.data_factory = arguments.data_factory />
	</cffunction>
	
	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var auctionHouse = CreateObject( 'component', 'com.blizzard.request.AuctionHouseRequest' ).init( getPublicKey(), getPrivateKey(), getCache() ) />
		<cfset var baseUrl 		= auctionHouse.getRequestEndpoint() & '/' & variables.util.nameToSlug( arguments.realm ) />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & getEndpoint() & baseUrl />
		
		<cfset auctionHouse.setDataFactory( variables.data_factory ) />

		<cfset auctionHouse.setBaseEndpoint( baseEndpoint ) />
		
		<cfreturn auctionHouse />
	</cffunction>
	
</cfcomponent>