<cfcomponent output="false" extends="com.blizzard.request.AbstractRequest" implements="com.blizzard.interface.IBnetRequest">

	<cffunction name="init" returntype="RealmRequest" access="public" output="false">

		<cfset setEndpoint('/api/wow/realm/status') />
		
		<cfreturn super.init(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="resetResponse" returntype="void" access="public" output="false">
	
		<cfset var result = getResultStruct('realms') />
		
		<cfset setResponse(result) />
	</cffunction>
	
	<cffunction name="setResponseData" returntype="void" access="public" output="false">
		<cfargument name="data" type="any" required="true" />

		<cfset var realm = '' />
		<cfset var realmStruct = StructNew() />
		
		<cfloop array="#arguments.data.realms#" index="realm">
		
			<cfset realmStruct['#variables.util.nameToSlug(realm.name)#'] = realm />
		</cfloop>

		<cfset setResponseKey('realms', realmStruct) />	
	</cffunction>

	<cffunction name="getResponseData" returntype="struct" access="public" output="false">

		<cfreturn getResponseKey('realms') />
	</cffunction>

</cfcomponent>