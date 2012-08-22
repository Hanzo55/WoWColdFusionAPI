<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var reqObj	= CreateObject( 'component', 'com.blizzard.request.d3.ItemRequest' ).init( getPublicKey(), getPrivateKey(), getCache() ) />
		<cfset var ri 		= reqObj.getResourceIdentifier() & '/' & arguments.itemId />
		<cfset var absUrl 	= getBaseUrl() & ri />
		
		<cfset reqObj.setGlobalIdentifier( absUrl ) />
		
		<cfreturn reqObj />		
	</cffunction>
	
</cfcomponent>