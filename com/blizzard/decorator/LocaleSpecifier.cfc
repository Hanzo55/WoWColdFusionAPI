<cfcomponent output="false" extends="com.blizzard.decorator.RequestDecorator" implements="com.blizzard.interface.IRequestDecorator">

	<cffunction name="init" returntype="LocaleSpecifier" access="public" output="false">
		<cfargument name="decorated" type="com.blizzard.request.AbstractRequest" required="true" />
	
		<cfset setDecorated( arguments.decorated ) />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setGlobalIdentifier" returntype="void" access="public" output="false">
		<cfargument name="gi" type="string" required="true" />

		<cfset var qURL = 0 />
		<cfset var token = '?' />

		<!--- pass the original set through the chain, ensuring we have set something in the chain, and the property is seeded --->
		<cfset getDecorated().setGlobalIdentifier( arguments.gi ) />

		<!--- now, grab that back --->
		<cfset qURL = getDecorated().getGlobalIdentifier() />

		<!--- check it for a ? --->
		<cfif Find('?', qURL)>
			<cfset token = '&' />
		</cfif>	
		
		<cfset qURL = qURL & token & 'locale=' & getDecorated().getLocalization() />
		
		<!--- and pass it back into the chain again --->
		<cfset getDecorated().setGlobalIdentifier( qURL ) />
	</cffunction>
	
	<cffunction name="setResponseData" returntype="void" access="public" output="false">
		<cfargument name="data" type="any" required="true" />
		
		<cfset getDecorated().setResponseData( arguments.data ) />
	</cffunction>
	
	<cffunction name="cleanJSON" returntype="string" access="public" output="false">
		<cfargument name="json" type="string" required="true" />

		<cfset getDecorated().cleanJSON( arguments.json ) />
	</cffunction>	

</cfcomponent>