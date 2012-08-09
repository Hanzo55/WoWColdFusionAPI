<!---
Copyright (c) 2012 Shawn Holmes

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
--->
<cfcomponent output="false">

	<!--- INIT --->
	
	<cffunction name="init" returntype="community_platform" access="public" output="false">
		<cfargument name="cache" type="any" required="true" />
		<cfargument name="region" type="string" required="false" default="us" />
		<cfargument name="publicKey" type="string" required="false" default="" />
		<cfargument name="privateKey" type="string" required="false" default="" />
		<cfargument name="useSSL" type="boolean" required="false" default="#iif((Len(arguments.publicKey) GT 0 AND Len(arguments.privateKey) GT 0),de('true'),de('false'))#" />
		
		<cfscript>
			// BASIC PROPERTIES
			setRegion(arguments.region);
			setPublicKey(arguments.publicKey);
			setPrivateKey(arguments.privateKey);
			setUseSSL(arguments.useSSL);
			setBnetProtocol( iif(useBnetSSL(),de('https://'),de('http://')) );	//we'll use the value of useSSL() to default it, but user can change later if needed
			
			// FACTORY
			variables.factory = CreateObject('component','com.blizzard.factory.RequestFactory').init(
				argumentCollection=getFactoryInitializer(arguments.cache)
			);
		</cfscript>
		
		<cfreturn this />
	</cffunction>

	<!--- GETTERS/SETTERS --->

	<cffunction name="setRegion" returntype="void" access="public" output="false">
		<cfargument name="region" type="string" required="true" />
	
		<cfset variables.region = arguments.region />
	</cffunction>

	<cffunction name="getRegion" returntype="string" access="public" output="false">
		
		<cfreturn variables.region />
	</cffunction>

	<cffunction name="setPublicKey" returntype="void" access="public" output="false">
		<cfargument name="key" type="string" required="true" />
	
		<cfset variables.publicKey = arguments.key />
	</cffunction>

	<cffunction name="getPublicKey" returntype="string" access="public" output="false">
		
		<cfreturn variables.publicKey />
	</cffunction>

	<cffunction name="setPrivateKey" returntype="void" access="public" output="false">
		<cfargument name="key" type="string" required="true" />
	
		<cfset variables.privateKey = arguments.key />
	</cffunction>
	
	<cffunction name="getPrivateKey" returntype="string" access="public" output="false">
		
		<cfreturn variables.privateKey />
	</cffunction>
	
	<cffunction name="setUseSSL" returntype="void" access="public" output="false">
		<cfargument name="ssl" type="boolean" required="true" />
	
		<cfset variables.useSSL = arguments.ssl />
	</cffunction>
	
	<cffunction name="getUseSSL" returntype="boolean" access="public" output="false">
		
		<cfreturn variables.useSSL />
	</cffunction>

	<cffunction name="setBnetHost" returntype="void" access="public" output="false">
		<cfargument name="bnet_host" type="string" required="true" />		
		
		<cfthrow type="MethodNotImplemented" message="Not Implemented" detail="setBnetHost() is not implemented. To change the top-level domain name used in the request, call setRegion() instead." />
	</cffunction>
	
	<cffunction name="getBnetHost" returntype="string" access="public" output="false">
		
		<cfreturn getRegion() & '.battle.net' />
	</cffunction>
	
	<cffunction name="setBnetProtocol" returntype="void" access="public" output="false">
		<cfargument name="protocol" type="string" required="true" />
	
		<cfset variables.bnet_protocol = arguments.protocol />
	</cffunction>
	
	<cffunction name="getBnetProtocol" returntype="string" access="public" output="false">
		
		<cfreturn variables.bnet_protocol />
	</cffunction>
	
	<!--- PRIVATE METHODS --->
	
	<cffunction name="getServiceEndpoint" returntype="string" access="private" output="false">
	
		<cfreturn '/api' />
	</cffunction>
	
	<cffunction name="getFactoryInitializer" returntype="struct" access="private" output="false">
		<cfargument name="cache" type="any" required="true" />
	
		<cfset var settings 			= StructNew() />

		<cfset settings.publicKey		= getPublicKey() />
		<cfset settings.privateKey 		= getPrivateKey() />
		<cfset settings.bnet_host 		= getBnetHost() />
		<cfset settings.bnet_protocol 	= getBnetProtocol() />
		<cfset settings.endpoint		= getServiceEndpoint() />
		
		<cfset settings.cache 			= arguments.cache />		
	
		<cfreturn settings />
	</cffunction>
	
	<cffunction name="useBnetSSL" returntype="boolean" access="private" output="false">
	
		<cfreturn getUseSSL() />
	</cffunction>	

</cfcomponent>