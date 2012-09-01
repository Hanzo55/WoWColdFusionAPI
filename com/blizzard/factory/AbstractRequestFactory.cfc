<cfcomponent output="false">

	<cffunction name="init" returntype="AbstractRequestFactory" access="public" output="false">
		<cfargument name="bnet_host" type="string" required="true" />
		<cfargument name="bnet_protocol" type="string" required="true" />
		<cfargument name="endpoint" type="string" required="true" />
		<cfargument name="publicKey" type="string" required="true" />
		<cfargument name="privateKey" type="string" required="true" />	
		<cfargument name="cache" type="struct" required="true" />	
		<cfargument name="locale" type="string" required="true" />

		<cfset variables.bnet_host 			= arguments.bnet_host />
		<cfset variables.bnet_protocol 	= arguments.bnet_protocol />
		<cfset variables.endpoint			= arguments.endpoint />
		<cfset variables.publicKey 			= arguments.publicKey />
		<cfset variables.privateKey 		= arguments.privateKey />
		<cfset variables.cache 				= arguments.cache />
		<cfset variables.locale					= arguments.locale />

		<cfset variables.builder 				= StructNew() />

		<cfset constructBuilders() />

		<cfreturn this />
	</cffunction>
	
	<cffunction name="addBuilder" returntype="void" access="public" output="false">
		<cfargument name="builder_name" type="string" required="true" />
	
		<cfset variables.builder['#ListLast(arguments.builder_name,'.')#'] = CreateObject('component','#arguments.builder_name#').init(
				variables.bnet_host, variables.bnet_protocol, variables.endpoint, variables.locale
			) />
		<cfset variables.builder['#ListLast(arguments.builder_name,'.')#'].addAuthenticationSettings(variables.publicKey, variables.privateKey) />
		<cfset variables.builder['#ListLast(arguments.builder_name,'.')#'].addCache(variables.cache) />
	</cffunction>

	<cffunction name="getBuilder" returntype="com.blizzard.builder.AbstractRequestBuilder" access="public" output="false">
		<cfargument name="builder_name" type="string" required="true" />

		<cfreturn variables.builder['#arguments.builder_name#'] />	
	</cffunction>

	<cffunction name="getRequest" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
		<cfargument name="builder_full_name" type="string" required="true" />
		<cfargument name="parameters" type="struct" required="true" />
		
		<cfset var builder_name = arguments.builder_full_name & 'RequestBuilder' />

		<cfset var requestObject = getBuilder(builder_name) />
		
		<cfreturn requestObject.constructRequestObject(argumentCollection=arguments.parameters) />
	</cffunction>
	
	<cffunction name="constructBuilders" returntype="void" access="public" output="false">
	
		<cfthrow type="MethodNotImplemented" message="Not Implemented" detail="constructBuilders() is not implemented. This method must be implemented in a subclass." />	
	</cffunction>

</cfcomponent>