<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var reqObj	= CreateObject( 'component', 'com.blizzard.request.CharacterAchievementsRequest' ).init( getPublicKey(), getPrivateKey(), getreqObjche() ) />
		<cfset var ri 		= reqObj.getRequestEndpoint() />
		<cfset var absUrl 	= getBaseUri() & ri />		
		
		<cfset reqObj.setGlobalIdentifier( absUrl ) />
		
		<cfreturn reqObj />
	</cffunction>
	
</cfcomponent>