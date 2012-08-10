<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var ga 			= CreateObject( 'component', 'com.blizzard.request.RecipeRequest' ).init( getPublicKey(), getPrivateKey(), getCache() ) />
		<cfset var baseUrl 		= ga.getRequestEndpoint() & '/' & arguments.recipeId />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & getEndpoint() & baseUrl />		
		
		<cfset ga.setBaseEndpoint( baseEndpoint ) />
		
		<cfreturn ga />
	</cffunction>
	
</cfcomponent>