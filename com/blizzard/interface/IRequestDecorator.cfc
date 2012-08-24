<cfinterface>

	<cffunction name="setGlobalIdentifier" returntype="void" output="false">
		<cfargument name="gi" type="string" required="true" />	
	
		<!--- the global identifier is the complete URL to the RESTful service in question, along with any parameters that are needed --->
	</cffunction>
	
	<cffunction name="setResponseData" returntype="void" output="false">
		<cfargument name="data" type="any" required="true" />		
	
		<!--- this method is responsible for taking JSON (either from the cache or the live API) and getting it into a ColdFusion-friendly struct, where it is stored for future access --->
	</cffunction>

	<cffunction name="cleanJSON" returntype="string" output="false">
		<cfargument name="json" type="string" required="true" />
	
		<!--- this method is private to the decorators and is used to clean JSON that has been munged, due to a number of a reasons that ColdFusion suffers from when deserializing JSON. --->
	</cffunction>


</cfinterface>