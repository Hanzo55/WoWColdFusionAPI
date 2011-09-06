<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="init" returntype="ItemRequestBuilder" access="public" output="false">
		<cfargument name="bnet_host" type="string" required="true" />
		<cfargument name="bnet_protocol" type="string" required="true" />
			
		<cfreturn super.init(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var item = CreateObject('component','com.blizzard.request.ItemRequest').init(getPublicKey(), getPrivateKey(), getCache()) />
		<cfset var baseUrl = item.getEndpoint() & '/' & arguments.itemId />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />		
		
		<cfset item.setBaseEndpoint(baseEndpoint) />
		
		<cfreturn item />		
	</cffunction>
	
</cfcomponent>