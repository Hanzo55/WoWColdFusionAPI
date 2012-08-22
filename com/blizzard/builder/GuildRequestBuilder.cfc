<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">

		<cfset var args = arguments />	
		<cfset var fields = '' />
		<cfset var absUrl = '' />
		<cfset var ri = '' />
		<cfset var sortedKeys = '' />
		<cfset var arg = '' />

		<cfset var reqObj = CreateObject( 'component', 'com.blizzard.request.GuildRequest' ).init( getPublicKey(), getPrivateKey(), getCache() ) />
		<cfset reqObj = CreateObject( 'component', 'com.blizzard.decorator.LastModifiedCleaner' ).init( reqObj ) />
		
		<cfset ri = reqObj.getRequestEndpoint() & '/' & variables.util.nameToSlug( arguments.realm ) & '/' & UrlEncodedFormat( arguments.name ) />
		<cfset absUrl = getBaseUri() & ri />		

		<cfset StructDelete( args, 'realm' ) />
		<cfset StructDelete( args, 'name' ) />
		
		<cfset sortedKeys = ListSort( StructKeyList(args), "text" ) />
		
		<cfloop list="#sortedKeys#" index="arg">

			<cfif StructKeyExists( arguments, arg ) AND Len( arguments[arg] ) AND ( arguments[arg] )>

				<cfset fields = ListAppend( fields, LCase( arg ) ) />

				<!--- decorate further if achievements are involved --->
				<cfif NOT CompareNoCase( LCase( arg ), 'achievements' )>
					<cfset reqObj = CreateObject( 'component', 'com.blizzard.decorator.AchievementCleaner' ).init( reqObj ) />
				</cfif>				

			</cfif>

		</cfloop>

		<cfif Len(fields)>
			<cfset absUrl = absUrl & '?fields=' & fields />		
		</cfif>
		
		<cfset reqObj.setGlobalIdentifier( absUrl ) />
		
		<cfreturn reqObj />		
	</cffunction>
	
</cfcomponent>