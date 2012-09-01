<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var absUrl		= '' />
		<cfset var thisRealm = '' />
		<cfset var realmList 	= '' />	
		<cfset var reqObj 		= CreateObject( 'component', 'com.blizzard.request.RealmRequest' ).init( getPublicKey(), getPrivateKey(), getCache() ) />
		<cfset reqObj			= CreateObject( 'component', 'com.blizzard.decorator.LocaleSpecifier' ).init( reqObj ) />		

		<cfset absUrl 			= getBaseUrl() & reqObj.getResourceIdentifier() />

		<cfif StructKeyExists( arguments, 'name' ) AND Len( arguments.name )>
			<cfloop list="#arguments.name#" index="thisRealm">
				<cfset realmList = ListAppend( realmList, variables.util.nameToSlug( Trim( thisRealm ) ) ) />
			</cfloop>

			<cfset absUrl = absUrl & '?realms=' & realmList />
		</cfif>
		
		<cfset reqObj.setLocalization( getLocalization() ) />		
		<cfset reqObj.setGlobalIdentifier( absUrl ) />
		
		<cfreturn reqObj />
	</cffunction>
	
</cfcomponent>