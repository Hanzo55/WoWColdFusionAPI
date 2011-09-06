<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="init" returntype="ArenaInfoRequestBuilder" access="public" output="false">
		<cfargument name="bnet_host" type="string" required="true" />
		<cfargument name="bnet_protocol" type="string" required="true" />
			
		<cfreturn super.init(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var arena_info = CreateObject('component','com.blizzard.request.ArenaInfoRequest').init(getPublicKey(), getPrivateKey(), getCache()) />
		<cfset var baseUrl = arena_info.getEndpoint() & '/' & variables.util.nameToSlug(arguments.battlegroup) & '/' & (arguments.team_type) />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />
		
		<cfif StructKeyExists(arguments,'size') AND (arguments.size)>
			<cfset baseEndpoint = baseEndpoint & '?size=' & arguments.size />		
		</cfif>		
		
		<cfset arena_info.setBaseEndpoint(baseEndpoint) />
		
		<cfreturn arena_info />		
	</cffunction>
	
</cfcomponent>