<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var reqObj	= CreateObject( 'component', 'com.blizzard.request.GuildAchievementsRequest' ).init( getPublicKey(), getPrivateKey(), getCache() ) />
		<cfset var ri 		= reqObj.getResourceIdentifier() />
		<cfset var absUrl 	= getBaseUrl() & ri />		
		
		<cfset reqObj.setGlobalIdentifier( absUrl ) />
		
		<cfreturn reqObj />
	</cffunction>
	
</cfcomponent>