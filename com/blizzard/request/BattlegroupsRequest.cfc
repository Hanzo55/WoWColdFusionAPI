<cfcomponent output="false" extends="com.blizzard.request.AbstractRequest" implements="com.blizzard.interface.IBnetRequest">

	<cffunction name="getResourceIdentifier" returntype="string" access="public" output="false">
	
		<cfreturn '/data/battlegroups/' />	<!--- the trailing slash is required for this one, with the intent that filters will be added in the future (ie. /battlegroups/ruin) --->
	</cffunction>

	<cffunction name="resetResponse" returntype="void" access="public" output="false">
	
		<cfset setResponse( getResultStruct('battlegroups') ) />
	</cffunction>
	
	<cffunction name="setResponseData" returntype="void" access="public" output="false">
		<cfargument name="data" type="any" required="true" />

		<cfset setResponseKey('battlegroups', arguments.data.battlegroups) />
	</cffunction>

	<cffunction name="getResponseData" returntype="struct" access="public" output="false">

		<cfreturn getResponseKey('battlegroups') />
	</cffunction>
	
</cfcomponent>