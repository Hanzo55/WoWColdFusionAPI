<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="init" returntype="CharacterRequestBuilder" access="public" output="false">
		<cfargument name="bnet_host" type="string" required="true" />
		<cfargument name="bnet_protocol" type="string" required="true" />
			
		<cfreturn super.init(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">

		<cfset var fields = '' />
		<cfset var args = arguments />
		<cfset var baseUrl = '' />
		<cfset var baseEndpoint = '' />
		<cfset var sortedKeys = '' />
		<cfset var arg = '' />		
		
		<cfset var character = CreateObject('component','com.blizzard.request.CharacterRequest').init(getPublicKey(), getPrivateKey(), getCache()) />
		<cfset character = CreateObject('component','com.blizzard.decorator.LastModifiedCleaner').init(character) />	

		<cfset baseUrl = character.getEndpoint() & '/' & variables.util.nameToSlug(arguments.realm) & '/' & arguments.name />
		<cfset baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />

		<cfset StructDelete(args,'realm') />
		<cfset StructDelete(args,'name') />
		
		<cfset sortedKeys = ListSort(StructKeyList(args),"text") />
		
		<cfloop list="#sortedKeys#" index="arg">
			<cfif StructKeyExists(arguments, arg) AND Len(arguments[arg]) AND (arguments[arg])>
				<cfset fields = ListAppend(fields, LCase(arg)) />
				<!--- decorate further if achievements are involved --->
				<cfif NOT CompareNoCase(LCase(arg), 'achievements')>
					<cfset character = CreateObject('component','com.blizzard.decorator.AchievementCleaner').init(character) />
				</cfif>
			</cfif>
		</cfloop>

		<cfif Len(fields)>
			<cfset baseEndpoint = baseEndpoint & '?fields=' & fields />		
		</cfif>

		<cfset character.setBaseEndpoint(baseEndpoint) />
		
		<cfreturn character />
	</cffunction>

</cfcomponent>