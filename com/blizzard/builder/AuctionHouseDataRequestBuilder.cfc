<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="init" returntype="AuctionHouseDataRequestBuilder" access="public" output="false">
		<cfargument name="bnet_host" type="string" required="true" />
		<cfargument name="bnet_protocol" type="string" required="true" />
			
		<cfreturn super.init( argumentCollection=arguments ) />
	</cffunction>
	
	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var ah_data 	= CreateObject( 'component', 'com.blizzard.request.AuctionHouseDataRequest' ).init( getPublicKey(), getPrivateKey(), getCache() ) />
		<cfset ah_data 		= CreateObject( 'component', 'com.blizzard.decorator.LocaleSpecifier' ).init( ah_data ) />
		
		<cfset ah_data.setGlobalIdentifier( arguments.endPoint ) />
		
		<cfreturn ah_data />				
	</cffunction>
	
</cfcomponent>