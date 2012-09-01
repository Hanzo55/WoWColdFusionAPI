<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">

		<cfset var ri		= 0 />
		<cfset var absUrl	= 0 />
		<cfset var item 	= arguments.itemId />
	
		<cfset var reqObj	= CreateObject( 'component', 'com.blizzard.request.d3.ItemRequest' ).init( getPublicKey(), getPrivateKey(), getCache() ) />
		<cfset reqObj		= CreateObject( 'component', 'com.blizzard.decorator.LocaleSpecifier' ).init( reqObj ) />

		<!--- as a convenience, we'll strip the prepended "item/" if discovered, since it appears that tooltipParams returns this prepended directly from the BNet API. --->
		<cfif NOT CompareNoCase( Left( item, 5), 'item/' )>
			<cfset item = Right( item, Len( item ) -5 ) />
		</cfif>
				
		<cfset ri 			= reqObj.getResourceIdentifier() & '/' & item />
		<cfset absUrl 		= getBaseUrl() & ri />
		
		<cfset reqObj.setLocalization( getLocalization() )>
		<cfset reqObj.setGlobalIdentifier( absUrl ) />
		
		<cfreturn reqObj />		
	</cffunction>
	
</cfcomponent>