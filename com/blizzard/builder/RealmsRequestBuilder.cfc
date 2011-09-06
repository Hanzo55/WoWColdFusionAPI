<cfcomponent output="false" extends="com.blizzard.builder.AbstractRequestBuilder">

	<cffunction name="init" returntype="RealmsRequestBuilder" access="public" output="false">
		<cfargument name="bnet_host" type="string" required="true" />
		<cfargument name="bnet_protocol" type="string" required="true" />
			
		<cfreturn super.init(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="constructRequestObject" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
	
		<cfset var thisRealm = '' />
		<cfset var realmList = '' />	
		<cfset var realms = CreateObject('component','com.blizzard.request.RealmRequest').init(getPublicKey(), getPrivateKey(), getCache()) />

		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & realms.getEndpoint() />

		<cfif StructKeyExists(arguments,'name') AND Len(arguments.name)>
			<cfloop list="#arguments.name#" index="thisRealm">
				<cfset realmList = ListAppend(realmList, variables.util.nameToSlug(Trim(thisRealm))) />
			</cfloop>

			<cfset baseEndpoint = baseEndpoint & '?realms=' & realmList />
		</cfif>
		
		<cfset realms.setBaseEndpoint(baseEndpoint) />
		
		<cfreturn realms />
	</cffunction>
	
</cfcomponent>