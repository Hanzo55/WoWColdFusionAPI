<cfcomponent output="false">

	<cffunction name="init" returntype="AbstractRequest" access="public" output="false">
		<cfargument name="publicKey" type="string" required="false" />
		<cfargument name="privateKey" type="string" required="false" />
		<cfargument name="cache" type="struct" required="false" />
		
		<cfscript>
		// HEADERS
		variables.headers = StructNew();
		
		// RESPONSE
		variables.response = StructNew();
		
		// PUB/PRIV
		variables.publicKey = "";
		variables.privateKey = "";
		
		// UTIL
		variables.util = CreateObject('component','com.hanzo.util.bnet');		
		
		if (StructKeyExists(arguments,'publicKey') AND Len(arguments.publicKey))
			setPublicKey(arguments.publicKey);
			
		if (StructKeyExists(arguments,'privateKey') AND Len(arguments.privateKey))
			setPrivateKey(arguments.privateKey);

		setCache(arguments.cache);
		</cfscript>
		
		<cfreturn this />
	</cffunction>

	<!--- PROPERTIES --->

	<cffunction name="setCache" returntype="void" access="public" output="false">
		<cfargument name="cache" type="any" required="true" />
	
		<cfset variables.cache = arguments.cache />
	</cffunction>

	<cffunction name="getCache" returntype="any" access="public" output="false">
		
		<cfreturn variables.cache />
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

	<cffunction name="getRequestEndpoint" returntype="string" access="public" output="false">

		<cfthrow type="MethodNotImplemented" message="Not Implemented" detail="getRequestEndpoint() is not implemented. This method must be implemented in a subclass." />
	</cffunction>

	<cffunction name="setRequestUrl" returntype="void" access="public" output="false">
		<cfargument name="request_url" type="string" required="true" />
		
		<cfset variables.request_url = arguments.request_url />
	</cffunction>

	<cffunction name="getRequestUrl" returntype="string" access="public" output="false">

		<cfreturn variables.request_url />
	</cffunction>

	<cffunction name="getJSON" returntype="string" access="public" output="false">
	
		<cfreturn variables.json />
	</cffunction>

	<cffunction name="setJSON" returntype="void" access="public" output="false">
		<cfargument name="json" type="string" required="true" />
		
		<cfset variables.json = arguments.json />
	</cffunction>

	<cffunction name="setHeader" returntype="void" access="public" output="false">
		<cfargument name="key" type="string" required="true" />
		<cfargument name="value" type="string" required="true" />		
	
		<cfset variables.headers['#arguments.key#'] = arguments.value />
	</cffunction>	

	<cffunction name="getHeader" returntype="string" access="public" output="false">
		<cfargument name="key" type="string" required="true" />
	
		<cfreturn variables.headers['#arguments.key#'] />
	</cffunction>

	<cffunction name="getHeaders" returntype="struct" access="public" output="false">
	
		<cfreturn variables.headers />
	</cffunction>
	
	<cffunction name="setHeaders" returntype="void" access="private" output="false">
		<cfargument name="headers" type="struct" required="true" />
	
		<cfset variables.headers />
	</cffunction>

	<cffunction name="getResponse" returntype="struct" access="public" output="false">
	
		<cfreturn variables.response />
	</cffunction>

	<cffunction name="setResponse" returntype="void" access="public" output="false">
		<cfargument name="response" type="struct" required="true" />

		<cfset variables.response = response />
	</cffunction>

	<cffunction name="setResponseKey" returntype="void" access="public" output="false">
		<cfargument name="key" type="string" required="true" />
		<cfargument name="value" type="any" required="true" />		
	
		<cfset variables.response['#arguments.key#'] = arguments.value />
	</cffunction>	

	<cffunction name="getResponseKey" returntype="any" access="private" output="false">
		<cfargument name="key" type="string" required="true" />
	
		<cfif StructKeyExists(variables.response, '#arguments.key#')>
			<cfreturn variables.response['#arguments.key#'] />
		<cfelse>
			<cfreturn StructNew() />
		</cfif>
	</cffunction>

	<cffunction name="setGlobalIdentifier" returntype="void" access="public" output="false">
		<cfargument name="gi" type="string" required="true" />
	
		<cfset variables.gi = arguments.gi />
	</cffunction>
	
	<cffunction name="getGlobalIdentifier" returntype="string" access="private" output="false">

		<cfreturn variables.gi />
	</cffunction>

	<!--- PRIVATE METHODS --->
	
	<cffunction name="cacheIsDirty" returntype="boolean" access="public" output="false">
		<cfargument name="absUrl" type="string" request="true" />

		<cfset var isCached = false />
		<cfset var cachedResult = 0 />
		<cfset var sendIfModifiedSince = false />
		
		<cfset isCached = getCache().isCached(getRequestUrl()) />
	
		<cfif (isCached)>
		
			<cfset cachedResult = getCache().getCache(getRequestUrl()) />
			
			<cfif DateCompare(Now(), cachedResult['cachedUntil']) GTE 0>
			
				<cfset sendIfModifiedSince = true />
				<cfset setHeader('If-Modified-Since', date_RFC1129(cachedResult['lastModified'])) />
				
			<cfelse>
			
				<cfset setJSON(cachedResult.data) />

			</cfif>
			
		</cfif>
		
		<cfreturn ((NOT isCached) OR (sendIfModifiedSince)) />
	</cffunction>	

	<cffunction name="isBnetAuthenticated" returntype="boolean" access="private" output="false">
		
		<cfreturn (Len(getPublicKey()) GT 0 AND Len(getPrivateKey()) GT 0) />
	</cffunction>

	<cffunction name="date_RFC1129" returntype="string" access="private" output="false">
		<cfargument name="raw_date" type="date" required="false" default="#Now()#">
		
		<cfset var localNow = DateAdd( 's', GetTimeZoneInfo().UTCTotalOffset, arguments.raw_date ) />
		<cfreturn DateFormat(localNow, 'ddd, dd mmm yyyy') & ' ' & TimeFormat(localNow, 'HH:mm:ss') & ' GMT' />
	</cffunction>	

	<cffunction name="epochTimeToLocalDate" returntype="date" access="private" output="false">
		<cfargument name="epoch" type="string" required="true" />

		<!--- 
			/**
			 * Converts Epoch time to a ColdFusion date object in local time.
			 * 
			 * @param epoch      Epoch time, in seconds. (Required)
			 * @return Returns a date object. 
			 * @author Rob Brooks-Bilson (rbils@amkor.com) 
			 * @modified by Shawn Holmes to convert ms to s for integer-size boundary in CF
			 * @version 1, June 21, 2002 
			 */
		 --->
		
		<cfreturn DateAdd("s", Left(arguments.epoch,10), DateConvert("utc2Local", "January 1 1970 00:00")) />
	</cffunction>

	<cffunction name="hmacEncrypt" returntype="binary" access="public" output="false">
	   <cfargument name="signKey" type="string" required="true" />
	   <cfargument name="signMessage" type="string" required="true" />
	
		<cfset var jMsg = JavaCast("string",arguments.signMessage).getBytes("utf-8") />
		<cfset var jKey = JavaCast("string",arguments.signKey).getBytes("utf-8") />
		
		<cfset var key = CreateObject("java","javax.crypto.spec.SecretKeySpec") />
		<cfset var mac = CreateObject("java","javax.crypto.Mac") />
		
		<cfset key = key.init(jKey,"HmacSHA1") />
		
		<cfset mac = mac.getInstance(key.getAlgorithm()) />
		<cfset mac.init(key) />
		<cfset mac.update(jMsg) />
		
		<cfreturn mac.doFinal() />
	</cffunction>

	<cffunction name="bnetSign" returntype="string" access="private" output="false">
		<cfargument name="abs_url" type="string" required="true" />
	
		<cfset var no_query = arguments.abs_url />
		<cfset var pos = 0 />
		<cfset var pos2 = Find('?', arguments.abs_url) />
		<cfset var UrlPath = '' />
		<cfset var StringToSign = '' />
		<cfset var Signature = '' />

		<cfif (pos2)>
			<cfset no_query = Left(arguments.abs_url, pos2-1) />
		</cfif>
		
		<cfset pos = Find('battle.net/', no_query) />

		<cfset UrlPath = Mid(no_query, pos+10, Len(no_query)-(pos+10)+1) />

		<cfset StringToSign = 'GET' & Chr(10) & date_RFC1129() & Chr(10) & UrlPath & Chr(10) />

		<cfset Signature = BinaryEncode( hmacEncrypt( getPrivateKey(), StringToSign ), 'Base64' ) />

		<cfreturn 'BNET' & ' ' & getPublicKey() & ':' & Signature />	
	</cffunction>

	<cffunction name="getResultStruct" returntype="struct" access="private" output="false">
		<cfargument name="resultVarName" type="string" required="true" />
	
		<cfset var res = StructNew() />
		
		<cfset res['response'] = false />
		<cfset res['error'] = false />
		<cfset res['secure'] = false />
		<cfset res['#arguments.resultVarName#'] = StructNew() />
		
		<cfreturn res />
	</cffunction>

	<cffunction name="sendRequest" returntype="void" access="private" output="false">

		<cfset var data = 0 />
		<cfset var error = 0 />

		<cfset resetResponse() />

		<cfset setRequestUrl(getGlobalIdentifier()) />
		
		<cfset setHeader('Date', date_RFC1129()) />
		
		<cfif (isBnetAuthenticated())>
			<cfset setHeader('Authorization', bnetSign(getRequestUrl())) />
		</cfif>
		
		<cfif cacheIsDirty(getRequestUrl())>

			<cftry>
				<cfhttp url="#getRequestUrl()#"
						method="GET"
						result="data"
						throwonerror="false"
						timeout="15"
						charset="utf-8">
					<cfloop list="#StructKeyList(getHeaders())#" index="headerKey">
						<cfhttpparam type="header" name="#headerKey#" value="#getHeader(headerKey)#" />
					</cfloop>
				</cfhttp>
				
				<cfif StructKeyExists(data,'FileContent')>

					<cfif NOT IsSimpleValue(data.FileContent)>
						<!--- CF9 and prev. do not parse application/json appropriately --->								
						<cfset setJSON(data.FileContent.toString('utf-8')) />								
					<cfelse>
						<!--- CF10, however, parses it into text correctly --->
						<cfset setJSON(data.FileContent) />						
					</cfif>
					
				<cfelse>
				
					<cfthrow message="Response Not Returned from Battle.Net" detail="The request to the Battle.net API was not returned." type="BNetAPI" />
					
				</cfif>
				
				<cfswitch expression="#data.Responseheader.Status_Code#">
				
					<cfcase value="200">
	
						<cfset setResponseKey('modified', true) />
						<cfset setResponseKey('url', getRequestUrl()) />
						<cfset setResponseKey('response', 'Success') />
						<cfset setResponseKey('secure', iif(isBnetAuthenticated(),de('true'),de('false'))) />

						<cfset setResponseData(DeserializeJSON(getJSON())) />

						<!--- cache it --->
						<cfset getCache().setCache(getRequestUrl(), getJSON()) />
					
					</cfcase>
					
					<cfcase value="304">

						<!--- not modified, go back to the cache --->
						<cfset setJSON(getCache().getCache(getRequestUrl()).data) />

						<cfset setResponseKey('modified', false) />
						<cfset setResponseKey('url', getRequestUrl()) />
						<cfset setResponseKey('response', 'Success') />
			
						<cfset setResponseData(DeserializeJSON(getJSON())) />
						
						<!--- re-cache to update cachedUntil --->
						<cfset getCache().setCache(getRequestUrl(), getJSON()) />
					
					</cfcase>
					
					<cfcase value="404">

						<cfset setResponseKey('modified', false) />
						<cfset setResponseKey('url', getRequestUrl()) />
						<cfset setResponseKey('response', 'Failure') />
						<cfset setResponseKey('error', true) />
						
						<cfif Len(getJSON())>
							<cfset setResponseKey('errorDetail', DeserializeJSON(getJSON()).reason) />
						<cfelse>
							<cfset setResponseKey('errorDetail', 'API Currently Not Implemented') />
						</cfif>
					
					</cfcase>
					
					<cfcase value="500">

						<cfset error = DeserializeJSON(getJSON()) />
					
						<cfswitch expression="#error.reason#">
							<cfcase value="Invalid Application">
								<cfset error.detail = 'A request was made including application identification information, but either the application key is invalid or missing.' />
							</cfcase>
							<cfcase value="Invalid application permissions">
								<cfset error.detail = 'A request was made to an API resource that requires a higher application permission level.' />
							</cfcase>
							<cfcase value="Access denied, please contact api-support@blizzard.com">
								<cfset error.detail = 'The application or IP address has been blocked from making further requests. This ban may not be permanent.' />
							</cfcase>
							<cfcase value="When in doubt, blow it up. (page not found)">
								<cfset error.detail = 'A request was made to a resource that doesn''t exist.' />
							</cfcase>
							<cfcase value="If at first you don't succeed, blow it up again. (too many requests)">
								<cfset error.detail = 'The application or IP has been throttled.' />					
							</cfcase>
							<cfcase value="Have you not been through enough? Will you continue to fight what you cannot defeat? (something unexpected happened)">
								<cfset error.detail = 'There was a server error or equally catastrophic exception preventing the request from being fulfilled.' />					
							</cfcase>
							<cfcase value="Invalid authentication header.">
								<cfset error.detail = 'The application authorization information was mallformed or missing when expected.' />					
							</cfcase>
							<cfcase value="Invalid application signature.">
								<cfset error.detail = 'The application request signature was missing or invalid. This will also be thrown if the request date outside of a 15 second window from the current GMT time.' />					
							</cfcase>															
							<cfdefaultcase>
								<cfset error.detail = 'Unknown error from Bnet Community API' />					
							</cfdefaultcase>
						</cfswitch>
					
						<cfthrow message="#error.reason#" detail="#error.detail#" type="BNetAPI" />
					
					</cfcase>
					
					<cfdefaultcase>
						<cfthrow message="Unknown Status Code" detail="The BNetAPI returned a status code of #data.Responseheader.Status_Code#, which is unhandled." type="BNetAPI" />
					</cfdefaultcase>
				
				</cfswitch>

				<cfcatch type="any">
					
					<!--- handle native errors --->
					
					<cfset setResponseKey('modified', false) />
					<cfset setResponseKey('url', getRequestUrl()) />
					<cfset setResponseKey('response', 'Failure') />
					<cfset setResponseKey('error', true) />
	
					<cfset setResponseKey('errorDetail', cfcatch.message & ': ' & cfcatch.detail) />

				</cfcatch>

			</cftry>

		<cfelse>

			<cfset setResponseKey('modified', false) />
			<cfset setResponseKey('url', getRequestUrl()) />
			<cfset setResponseKey('response', 'Success') />

			<cfset setResponseData(DeserializeJSON(getJSON())) />	
		
		</cfif>
	</cffunction>

	<!--- PUBLIC METHODS --->
	
	<cffunction name="getResult" returntype="struct" access="public" output="false">

		<cfset sendRequest() />	
	
		<cfreturn getResponse() />
	</cffunction>

</cfcomponent>