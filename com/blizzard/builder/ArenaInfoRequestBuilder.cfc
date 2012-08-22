<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var reqObj 	= CreateObject( 'component', 'com.blizzard.request.ArenaInfoRequest' ).init( getPublicKey(), getPrivateKey(), getCache() ) />
		<cfset var ri		= reqObj.getRequestEndpoint() & '/' & variables.util.nameToSlug( arguments.battlegroup ) & '/' & ( arguments.team_type ) />
		<cfset var absUrl 	= getBaseUri() & ri />
		
		<cfif StructKeyExists( arguments, 'size' ) AND ( arguments.size )>
			<cfset absUrl = absUrl & '?size=' & arguments.size />		
		</cfif>		
		
		<cfset reqObj.setGlobalIdentifier( absUrl ) />
		
		<cfreturn reqObj />		
	</cffunction>
	
</cfcomponent>