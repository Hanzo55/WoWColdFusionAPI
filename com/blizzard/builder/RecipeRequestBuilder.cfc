<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">

		<cfset var ri		= 0 />
		<cfset var absUrl	= 0 />
	
		<cfset var reqObj	= CreateObject( 'component', 'com.blizzard.request.RecipeRequest' ).init( getPublicKey(), getPrivateKey(), getCache() ) />
		<cfset reqObj		= CreateObject( 'component', 'com.blizzard.decorator.LocaleSpecifier' ).init( reqObj ) />
				
		<cfset ri 			= reqObj.getResourceIdentifier() & '/' & arguments.recipeId />
		<cfset absUrl 		= getBaseUrl() & ri />		

		<cfset reqObj.setLocalization( getLocalization() ) />		
		<cfset reqObj.setGlobalIdentifier( absUrl ) />
		
		<cfreturn reqObj />
	</cffunction>
	
</cfcomponent>