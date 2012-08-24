<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">

		<cfset var ri		= 0 />
		<cfset var absUrl	= 0 />
	
		<cfset var reqObj 	= CreateObject( 'component', 'com.blizzard.request.ArenaInfoRequest' ).init( getPublicKey(), getPrivateKey(), getCache() ) />
		<cfset reqObj		= CreateObject( 'component', 'com.blizzard.decorator.LocaleSpecifier' ).init( reqObj ) />

		<cfset ri			= reqObj.getResourceIdentifier() & '/' & variables.util.nameToSlug( arguments.battlegroup ) & '/' & ( arguments.team_type ) />
		<cfset absUrl 		= getBaseUrl() & ri />
		
		<cfif StructKeyExists( arguments, 'size' ) AND ( arguments.size )>
			<cfset absUrl = absUrl & '?size=' & arguments.size />		
		</cfif>		
		
		<cfset reqObj.setLocalization( getLocalization() ) />		
		<cfset reqObj.setGlobalIdentifier( absUrl ) />
		
		<cfreturn reqObj />		
	</cffunction>
	
</cfcomponent>