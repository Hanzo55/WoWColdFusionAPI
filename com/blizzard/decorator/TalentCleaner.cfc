<cfcomponent output="false" extends="com.blizzard.decorator.RequestDecorator">

	<cffunction name="init" returntype="TalentCleaner" access="public" output="false">
		<cfargument name="decorated" type="com.blizzard.request.AbstractRequest" required="true" />
	
		<cfset setDecorated(arguments.decorated) />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setResponseData" returntype="void" access="public" output="false">
		<cfargument name="data" type="any" required="true" />

		<cfset var bad_data = arguments.data />
		<cfset var json = getDecorated().getJSON() />
		
		<!--- attempt clean it --->
		<cfset var cleaned = DeserializeJSON(cleanJSON(json)) />
		
		<!--- replace talents on the munged data if 0-length Arrays come back from the cleaner --->
		<cfif NOT ArrayLen(bad_data['talents'][1]['talents'])>
			<cfset bad_data['talents'][1] = cleaned['talents'][1] />
		</cfif>

		<cfif NOT ArrayLen(bad_data['talents'][2]['talents'])>
			<cfset bad_data['talents'][2] = cleaned['talents'][2] />
		</cfif>

		<!--- and we store that new fixed data --->
		<cfset getDecorated().setResponseData(bad_data) />	
	</cffunction>	

	<cffunction name="cleanJSON" returntype="string" access="private" output="false">
		<cfargument name="json" type="string" required="true" />

		<cfset var data = 0 />
		<cfset var found = Find('"calcTalent":"......"',arguments.json) />
		
		<cfif (found)>
			<cfset data = DeserializeJSON(arguments.json) />
			
			<!--- set the two talent arrays to 0 elements --->
			<cfset data['talents'][1]['talents'] = ArrayNew(1) />
			<cfset data['talents'][2]['talents'] = ArrayNew(1) />			
			
			<cfreturn SerializeJSON(data) />
		<cfelse>
			<cfreturn arguments.json />
		</cfif>
	</cffunction>

</cfcomponent>