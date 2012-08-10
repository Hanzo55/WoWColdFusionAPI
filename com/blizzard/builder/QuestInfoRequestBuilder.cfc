<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var quest_info 	= CreateObject( 'component', 'com.blizzard.request.QuestInfoRequest' ).init( getPublicKey(), getPrivateKey(), getCache() ) />
		<cfset var baseUrl 		= quest_info.getRequestEndpoint() & '/' & ( arguments.questId ) />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & getEndpoint() & baseUrl />
		
		<cfset quest_info.setBaseEndpoint( baseEndpoint ) />
		
		<cfreturn quest_info />
	</cffunction>
	
</cfcomponent>