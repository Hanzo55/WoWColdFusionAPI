<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var fields = '' />
		<cfset var args = arguments />
		<cfset var baseEndpoint = '' />
		<cfset var baseUrl = '' />
		<cfset var sortedKeys = '' />
		<cfset var arg = '' />

		<cfset var guild = CreateObject( 'component', 'com.blizzard.request.GuildRequest' ).init( getPublicKey(), getPrivateKey(), getCache() ) />
		<cfset guild = CreateObject( 'component', 'com.blizzard.decorator.LastModifiedCleaner' ).init( guild ) />
		
		<cfset baseUrl = guild.getRequestEndpoint() & '/' & variables.util.nameToSlug( arguments.realm ) & '/' & UrlEncodedFormat( arguments.name ) />
		<cfset baseEndpoint = getBnetProtocol() & getBnetHost() & getEndpoint() & baseUrl />		

		<cfset StructDelete( args, 'realm' ) />
		<cfset StructDelete( args, 'name' ) />
		
		<cfset sortedKeys = ListSort( StructKeyList(args), "text" ) />
		
		<cfloop list="#sortedKeys#" index="arg">

			<cfif StructKeyExists( arguments, arg ) AND Len( arguments[arg] ) AND ( arguments[arg] )>

				<cfset fields = ListAppend( fields, LCase( arg ) ) />

				<!--- decorate further if achievements are involved --->
				<cfif NOT CompareNoCase( LCase( arg ), 'achievements' )>
					<cfset guild = CreateObject( 'component', 'com.blizzard.decorator.AchievementCleaner' ).init( guild ) />
				</cfif>				

			</cfif>

		</cfloop>

		<cfif Len(fields)>
			<cfset baseEndpoint = baseEndpoint & '?fields=' & fields />		
		</cfif>
		
		<cfset guild.setBaseEndpoint( baseEndpoint ) />
		
		<cfreturn guild />		
	</cffunction>
	
</cfcomponent>