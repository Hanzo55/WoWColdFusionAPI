<cfcomponent output="false">

	<cffunction name="nameToSlug" returntype="string" access="public" output="false">
		<cfargument name="name" type="string" required="true" />
	
		<cfreturn LCase(Replace(Trim(arguments.name),' ','-','ALL')) />
	</cffunction>

</cfcomponent>