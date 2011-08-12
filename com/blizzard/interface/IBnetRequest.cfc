<cfinterface>

	<cffunction name="resetResponse" returntype="void" access="public" output="false">
		
		<!---
		prime the response struct by calling GetResultStruct(), with a parameter representing
		the 'key' that unique defines this type of request, passing that entire result to setResponse()
		--->
	</cffunction>

	<cffunction name="getResponseData" returntype="struct" access="public" output="false">

		<!--- call getResponseKey(), passing the unique key, and return the result --->
	</cffunction>

	<cffunction name="setResponseData" returntype="void" access="public" output="false">
		<cfargument name="data" type="any" required="true" />

		<!---
		call setResponseKey(), passing in the unique key representing the type of request
		--->
	</cffunction>

	<cffunction name="getEndpoint" returntype="string" access="public" output="false">
	
		<!--- return the unique endpoint --->
	</cffunction>
	
	<cffunction name="getResponse" returntype="struct" access="public" output="false">

		<!--- return the unique response --->
	</cffunction>

	<cffunction name="getJSON" returntype="string" access="public" output="false">
	
		<!--- return the raw json string --->
	</cffunction>

	<cffunction name="setJSON" returntype="void" access="public" output="false">
		<cfargument name="json" type="string" required="true" />

		<!--- set json raw --->	
	</cffunction>

	<cffunction name="getPublicKey" returntype="string" access="public" output="false">
		
		<!--- set public key --->
	</cffunction>

	<cffunction name="getPrivateKey" returntype="string" access="public" output="false">
		
		<!--- set private key --->
	</cffunction>

	<cffunction name="setResponseKey" returntype="void" access="public" output="false">
		<cfargument name="key" type="string" required="true" />
		<cfargument name="value" type="any" required="true" />		
	
		
	</cffunction>
		
</cfinterface>