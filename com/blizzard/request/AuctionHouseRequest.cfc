<cfcomponent output="false" extends="com.blizzard.request.AbstractRequest" implements="com.blizzard.interface.IBnetRequest">

	<cffunction name="init" returntype="AuctionHouseRequest" access="public" output="false">

		<cfset setEndpoint('/api/wow/auction/data') />
		
		<cfreturn super.init(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="resetResponse" returntype="void" access="public" output="false">
	
		<cfset var result = getResultStruct('auctionHouse') />
		
		<cfset setResponse(result) />
	</cffunction>
	
	<cffunction name="setResponseData" returntype="void" access="public" output="false">
		<cfargument name="data" type="any" required="true" />

		<!--- not a huge fan of how i do this. 
		we step in on the set(), 
		ignore the incoming argument, 
		work directly with the unprocessed json stored via setJSON(),
		and create a new data chunk which replaces the stuff that came in via input arg. 
		
		oh, did i mention we make a 2nd entirely separate cfhttp call? yeesh.
		--->

		<cfset var auctionHouseData = 0 />
		<cfset var ah_response = 0 />
		<cfset var i = 0 />
		<cfset var json = getJSON() />
		<cfset var dateLastModifiedArr = ReMatch('"lastModified":[0-9]+', json) />
		<cfset var ah = DeserializeJSON(json) />

		<cfloop from="1" to="#ArrayLen(ah.files)#" index="i">
			<cfset ah.files[i]['lastModified'] = EpochTimeToLocalDate(ReReplace(dateLastModifiedArr[i],'"lastModified":([0-9]+)','\1','ONE')) />		
		</cfloop>		
		
		<!--- ah.files should now be a cleaned ver. of arguments.data, but wait, there's more! --->

		<cfif ArrayLen(ah.files)>
			
			<cfset auctionHouseData = CreateObject('component','com.blizzard.request.AuctionHouseDataRequest').init(getPublicKey(), getPrivateKey()) />
			
			<!--- TODO: process all urls in the files array --->
			<cfset auctionHouseData.send(ah.files[1]['url']) />
		
			<cfset ah_response = auctionHouseData.getResponse() />
			
			<cfset ah['data'][1] = ah_response />
		</cfif>

		<cfset setResponseKey('auctionHouse', ah) />	
	</cffunction>

	<cffunction name="getResponseData" returntype="struct" access="public" output="false">

		<cfreturn getResponseKey('auctionHouse') />
	</cffunction>
	
</cfcomponent>