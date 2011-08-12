<cfcomponent output="false" extends="com.blizzard.decorator.RequestDecorator">

	<cffunction name="init" returntype="LastModifiedCleaner" access="public" output="false">
		<cfargument name="decorated" type="com.blizzard.request.AbstractRequest" required="true" />
	
		<cfset setDecorated(arguments.decorated) />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setResponseData" returntype="void" access="public" output="false">
		<cfargument name="data" type="any" required="true" />

		<!--- Rules:
		
		1. the data coming in is already ruined. 
		2. We cannot touch the JSON set via setJSON() -- we need it to remain as it arrived via bnet if we're chaining decorators (line 38) --->

		<cfset var bad_data = arguments.data />
		<cfset var json = getDecorated().getJSON() />
		
		<!--- clean it --->
		<cfset var cleaned = DeserializeJSON(cleanJSON(json)) />
		
		<!--- replace lastModified on the munged data --->
		<cfset bad_data['lastModified'] = cleaned['lastModified'] />

		<!--- and we store that new fixed data --->
		<cfset getDecorated().setResponseData(bad_data) />	
	</cffunction>	

	<cffunction name="cleanJSON" returntype="string" access="private" output="false">
		<cfargument name="json" type="string" required="true" />

		<!--- save a copy of date, so it doesn't get munged; DeserializeJSON() doesn't recognize an Epoch time --->
		<cfset var dateLastModified = ReReplace(arguments.json,'.*"lastModified":([0-9]+).*','\1','ONE') />
	
		<cfset var data = DeserializeJSON(arguments.json) />
		
		<!--- repair date/time objects that were deserialized incorrectly --->
		<cfset data['lastModified'] = EpochTimeToLocalDate(dateLastModified) />
		
		<cfreturn SerializeJSON(data) />
	</cffunction>

</cfcomponent>