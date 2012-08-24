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
	them in your concrete decorators; by being present here, they're automatically inherited
	by the concrete subclass, and simply hand off execution to the decoration chain.
	
	Additionally, by being in this abstract base class, they do not have to be a part of the
	IRequestDecorator interface.

	--KNOW THE RAMIFICATIONS OF THIS--
	
	As a result of being present in this list below, they **cannot be overridden in a decorator, 
	and therefore be decorated.**

	If you need to intercept the functionality of any method listed below:
	
	1. Remove it from here
	2. Add it to the concrete decorater.
	3. Add it to the interface.

	The result is that you will have *all* of your decorators with their own implementations 
	of IRequestDecorator methods, and they will either do their own fanciness, or they will
	blindly pass functionality on to the decoration chain.
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

	<cffunction name="getResourceIdentifier" returntype="string" access="public" output="false">
	
		<cfreturn getDecorated().getResourceIdentifier() />
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
	
	<cffunction name="getGlobalIdentifier" returntype="string" access="public" output="false">
	
		<cfreturn getDecorated().getGlobalIdentifier() />
	</cffunction>
	
	<cffunction name="setLocalization" returntype="void" access="public" output="false">
		<cfargument name="locale" type="string" required="true" />
	
		<cfset getDecorated().setLocalization( arguments.locale ) />
	</cffunction>

	<cffunction name="getLocalization" returntype="string" access="public" output="false">
	
		<cfreturn getDecorated().getLocalization() />
	</cffunction>
	
</cfcomponent>