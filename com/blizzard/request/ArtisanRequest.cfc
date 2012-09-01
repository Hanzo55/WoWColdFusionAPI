<cfcomponent output="false" extends="com.blizzard.request.AbstractRequest">

	<cffunction name="getResourceIdentifier" returntype="string" access="public" output="false">
	
		<cfreturn '/data/artisan' />
	</cffunction>

	<cffunction name="resetResponse" returntype="void" access="public" output="false">
	
		<cfset setResponse( getResultStruct('artisan') ) />
	</cffunction>
	
	<cffunction name="setResponseData" returntype="void" access="public" output="false">
		<cfargument name="data" type="any" required="true" />

		<cfset setResponseKey('artisan', arguments.data) />	
	</cffunction>

	<cffunction name="getResponseData" returntype="struct" access="public" output="false">

		<cfreturn getResponseKey('artisan') />
	</cffunction>
	
</cfcomponent>