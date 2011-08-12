<cfcomponent output="false" extends="com.blizzard.request.AbstractRequest" implements="com.blizzard.interface.IBnetRequest">

	<cffunction name="init" returntype="GuildRequest" access="public" output="false">

		<cfset setEndpoint('/api/wow/guild') />
		
		<cfreturn super.init(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="resetResponse" returntype="void" access="public" output="false">
	
		<cfset var result = getResultStruct('guild') />
		
		<cfset setResponse(result) />
	</cffunction>
	
	<cffunction name="setResponseData" returntype="void" access="public" output="false">
		<cfargument name="data" type="any" required="true" />

		<cfset setResponseKey('guild', arguments.data) />	
	</cffunction>

	<cffunction name="getResponseData" returntype="struct" access="public" output="false">

		<cfreturn getResponseKey('guild') />
	</cffunction>
	
</cfcomponent>