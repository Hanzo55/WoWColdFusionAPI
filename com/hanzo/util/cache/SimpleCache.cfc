<cfcomponent output="false">

	<cffunction name="init" returntype="SimpleCache" access="public" output="false">

		<cfset variables.ttl = 20 />
		<cfset variables.ttl_metric = "n" />
		<cfset variables.store = StructNew() />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setCache" returntype="void" access="public" output="false">
		<cfargument name="key" type="string" required="true" />
		<cfargument name="object" type="string" required="true" />
		
		<cfset var hash_key = Hash(arguments.key) />
		<cfset var loc_obj = arguments.object />
		
		<!--- TODO: BSON? Some other binary compression? encoding would be done here --->

		<cflock name="cacheInit" type="exclusive" timeout="15">		
			<cfset variables.store['#hash_key#'] = StructNew() />
			<cfset variables.store['#hash_key#'].data = loc_obj />
			<cfset variables.store['#hash_key#'].lastModified = Now() />
			<cfset variables.store['#hash_key#'].cachedUntil = DateAdd(variables.ttl_metric, variables.ttl, Now()) />
		</cflock>
	</cffunction>
	
	<cffunction name="getCache" returntype="struct" access="public" output="false">
		<cfargument name="key" type="string" required="true" />

		<cfset var cached = 0 />
		<cfset var hash_key = Hash(arguments.key) />

		<cflock type="readonly" name="cacheRead" timeout="30">
			<cfset cached = variables.store['#hash_key#'] />
		</cflock>
		
		<!--- TODO: This is where we'd do some kind of decoding of binary store --->

		<cfreturn cached />
	</cffunction>

	<cffunction name="isCached" returntype="boolean" access="public" output="false">
		<cfargument name="key" type="string" required="true" />

		<cfset var hash_key = Hash(arguments.key) />
		<cfset var isCached = false />
		
		<cflock type="readonly" name="cacheRead" timeout="30">
			<cfset isCached = StructKeyExists(variables.store, '#hash_key#') />
		</cflock>

		<cfreturn isCached />
	</cffunction>
	
	<cffunction name="dump" returntype="struct" access="public" output="false">
	
		<cfset var store = 0 />
		
		<cflock type="readonly" name="cacheRead" timeout="30">
			<cfset store = variables.store />
		</cflock>
	
		<cfreturn store />
	</cffunction>

</cfcomponent>