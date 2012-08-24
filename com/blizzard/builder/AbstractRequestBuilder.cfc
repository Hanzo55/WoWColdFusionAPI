<cfcomponent output="false">

	<cffunction name="init" returntype="AbstractRequestBuilder" access="public" output="false">
		<cfargument name="bnet_host" type="string" required="true" />
		<cfargument name="bnet_protocol" type="string" required="true" />
		<cfargument name="endpoint" type="string" required="true" />
		<cfargument name="locale" type="string" required="true" />

		<cfset variables.bnet_host 			= arguments.bnet_host />
		<cfset variables.bnet_protocol 	= arguments.bnet_protocol />
		<cfset variables.endpoint 			= arguments.endpoint />
		<cfset variables.locale					= arguments.locale />

		<cfset variables.util 					= CreateObject('component','com.hanzo.util.bnet') />
	
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getBnetHost" returntype="string" access="public" output="false">

		<cfreturn variables.bnet_host />	
	</cffunction>

	<cffunction name="getBnetProtocol" returntype="string" access="public" output="false">
	
		<cfreturn variables.bnet_protocol />
	</cffunction>
	
	<cffunction name="getEndpoint" returntype="string" access="public" output="false">
	
		<cfreturn variables.endpoint />
	</cffunction>

	<cffunction name="getPublicKey" returntype="string" access="public" output="false">
		
		<cfreturn variables.publicKey />
	</cffunction>
	
	<cffunction name="getPrivateKey" returntype="string" access="public" output="false">
		
		<cfreturn variables.privateKey />
	</cffunction>	

	<cffunction name="getCache" returntype="struct" access="public" output="false">
	
		<cfreturn variables.cache />
	</cffunction>
	
	<cffunction name="getLocalization" returntype="string" access="public" output="false">
		
		<cfreturn variables.locale />
	</cffunction>
 
	<cffunction name="addAuthenticationSettings" returntype="void" access="public" output="false">
		<cfargument name="publicKey" type="string" required="true" />
		<cfargument name="privateKey" type="string" required="true" />		
	
		<cfset variables.publicKey = arguments.publicKey />
		<cfset variables.privateKey = arguments.privateKey />
	</cffunction>
	
	<cffunction name="addCache" returntype="void" access="public" output="false">
		<cfargument name="cache" type="struct" required="true" />		
	
		<cfset variables.cache = arguments.cache />
	</cffunction>

	<cffunction name="constructRequestObject" returntype="void" access="public" output="false">

		<cfthrow type="MethodNotImplemented" message="Not Implemented" detail="constructRequestObject() is not implemented. This method must be implemented in a subclass." />	
	</cffunction>

	<cffunction name="getBaseUrl" returntype="string" access="public" output="false">
	
		<cfreturn getBnetProtocol() & getBnetHost() & getEndpoint() />
	</cffunction>

</cfcomponent>