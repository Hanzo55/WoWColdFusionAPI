<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var item = CreateObject('component','com.blizzard.request.ItemRequest').init(getPublicKey(), getPrivateKey(), getCache()) />
		<cfset var baseUrl = item.getRequestEndpoint() & '/' & arguments.itemId />
		<cfset var endpoint = getBnetProtocol() & getBnetHost() & getEndpoint() & baseUrl />
		
		<cfset item.setBaseEndpoint(endpoint) />
		
		<cfreturn item />		
	</cffunction>
	
</cfcomponent>