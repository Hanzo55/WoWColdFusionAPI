<cfcomponent output="false" extends="com.blizzard.request.AbstractRequest">

	<cffunction name="getDecorated" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
		
		<cfreturn variables.decorated />
	</cffunction>
	
	<cffunction name="setDecorated" returntype="void" access="public" output="false">
		<cfargument name="decorated" type="com.blizzard.request.AbstractRequest" required="true" />
		
		<cfset variables.decorated = arguments.decorated />
	</cffunction>

	<!--- INHERITED METHODS FROM BASE CLASS MADE AVAILABLE TO DECORATOR
	
	The following methods (below) are here as convenience, so you do not have to declare
	them in your concrete decoraters; by being present here, they automatically delgate back
	to the decorated object.
	
	As a result, by being present in this list below, they cannot be overridden in a decorator.
	If you need to intercept the functionality of any method listed below, remove it from
	here, and add it to the concrete decorater (yes, all of your decorators), as well as the interface.
	--->
	
	<cffunction name="setJSON" returntype="void" access="public" output="false">
		<cfargument name="json" type="string" required="true" />
		
		<cfset getDecorated().setJSON(arguments.json) />
	</cffunction>
	
	<cffunction name="getJSON" returntype="string" access="public" output="false">
	
		<cfreturn getDecorated().getJSON() />
	</cffunction>	

	<cffunction name="getPublicKey" returntype="string" access="public" output="false">
		
		<cfreturn getDecorated().getPublicKey() />
	</cffunction>

	<cffunction name="getPrivateKey" returntype="string" access="public" output="false">
		
		<cfreturn getDecorated().getPrivateKey() />
	</cffunction>

	<cffunction name="getEndpoint" returntype="string" access="public" output="false">
	
		<cfreturn getDecorated().getEndpoint() />
	</cffunction>
	
	<cffunction name="resetResponse" returntype="void" access="public" output="false">

		<cfset getDecorated().resetResponse() />
	</cffunction>	
	
	<cffunction name="getResponse" returntype="struct" access="public" output="false">

		<cfreturn getDecorated().getResponse() />
	</cffunction>

	<cffunction name="getCache" returntype="any" access="public" output="false">
	
		<cfreturn getDecorated().getCache() />
	</cffunction>
	
	<cffunction name="setCache" returntype="void" access="public" output="false">
		<cfargument name="cache" type="any" required="true" />
	
		<cfreturn getDecorated().setCache(arguments.cache) />
	</cffunction>	

	<cffunction name="setResponseKey" returntype="void" access="public" output="false">
		<cfargument name="key" type="string" required="true" />
		<cfargument name="value" type="any" required="true" />		
	
		<cfset getDecorated().setResponseKey(arguments.key, arguments.value) />
	</cffunction>
	
</cfcomponent>