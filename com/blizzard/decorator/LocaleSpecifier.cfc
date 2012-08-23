<cfcomponent output="false" extends="com.blizzard.decorator.RequestDecorator">

	<cffunction name="init" returntype="LocaleSpecifier" access="public" output="false">
		<cfargument name="decorated" type="com.blizzard.request.AbstractRequest" required="true" />
	
		<cfset setDecorated( arguments.decorated ) />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setGlobalIdentifier" returntype="void" access="public" output="false">
		<cfargument name="gi" type="string" required="true" />

		<cfset var qURL = getDecorated().getGlobalIdentifer() />

		<cfset qURL = qURL & '&locale=' & getDecorated().getLocalization() />
		
		<cfset getDecorated().setGlobalIdentifier( qURL ) />
	</cffunction>	

</cfcomponent>