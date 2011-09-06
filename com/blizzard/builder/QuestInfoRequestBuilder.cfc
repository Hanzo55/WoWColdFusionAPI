<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="init" returntype="QuestInfoRequestBuilder" access="public" output="false">
		<cfargument name="bnet_host" type="string" required="true" />
		<cfargument name="bnet_protocol" type="string" required="true" />
			
		<cfreturn super.init(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var quest_info = CreateObject('component','com.blizzard.request.QuestInfoRequest').init(getPublicKey(), getPrivateKey(), getCache()) />
		<cfset var baseUrl = quest_info.getEndpoint() & '/' & (arguments.questId) />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />
		
		<cfset quest_info.setBaseEndpoint(baseEndpoint) />
		
		<cfreturn quest_info />
	</cffunction>
	
</cfcomponent>