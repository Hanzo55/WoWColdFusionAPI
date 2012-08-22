<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var thisRealm 	= '' />
		<cfset var realmList 	= '' />	
		<cfset var reqObj 		= CreateObject( 'component', 'com.blizzard.request.RealmRequest' ).init( getPublicKey(), getPrivateKey(), getCache() ) />

		<cfset var absUrl = getBaseUri() & reqObj.getResourceIdentifier() />

		<cfif StructKeyExists( arguments, 'name' ) AND Len( arguments.name )>
			<cfloop list="#arguments.name#" index="thisRealm">
				<cfset realmList = ListAppend( realmList, variables.util.nameToSlug( Trim( thisRealm ) ) ) />
			</cfloop>

			<cfset absUrl = absUrl & '?realms=' & realmList />
		</cfif>
		
		<cfset reqObj.setGlobalIdentifier( absUrl ) />
		
		<cfreturn reqObj />
	</cffunction>
	
</cfcomponent>