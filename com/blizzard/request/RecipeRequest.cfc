<cfcomponent output="false" extends="com.blizzard.request.AbstractRequest" implements="com.blizzard.interface.IBnetRequest">

	<cffunction name="getResourceIdentifier" returntype="string" access="public" output="false">
	
		<cfreturn '/recipe' />
	</cffunction>

	<cffunction name="resetResponse" returntype="void" access="public" output="false">
	
		<cfset setResponse( getResultStruct('recipe') ) />
	</cffunction>
	
	<cffunction name="setResponseData" returntype="void" access="public" output="false">
		<cfargument name="data" type="any" required="true" />

		<cfset setResponseKey('recipe', arguments.data) />
	</cffunction>

	<cffunction name="getResponseData" returntype="struct" access="public" output="false">

		<cfreturn getResponseKey('recipe') />
	</cffunction>
	
</cfcomponent>