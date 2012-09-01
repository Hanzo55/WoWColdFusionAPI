<cfcomponent output="false" extends="com.blizzard.request.AbstractRequest">

	<cffunction name="getResourceIdentifier" returntype="string" access="public" output="false">
	
		<cfreturn '/realm/status' />
	</cffunction>

	<cffunction name="resetResponse" returntype="void" access="public" output="false">
	
		<cfset setResponse( getResultStruct('realms') ) />
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