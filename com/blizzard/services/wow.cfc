<!---
Copyright (c) 2011 Shawn Holmes

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
	
	<cffunction name="init" returntype="wow" access="public" output="false">
		<cfargument name="region" type="string" required="false" default="us" />
		
		<cfscript>
			// SET REGION
			setRegion(arguments.region);
			
			// INSTANCE URL
			variables.endpoint = StructNew();
			
			// ENDPOINTS
			variables.endpoint.realm = 'http://' & getRegion() & '.battle.net/api/wow/realm/status';
			variables.endpoint.character = 'http://' & getRegion() & '.battle.net/api/wow/character';
			
			// NOT YET ACTIVE
			/*
			variables.endpoint.guild = 'http://' & getRegion() & '.battle.net/api/wow/guild/status';
			variables.endpoint.arena = 'http://' & getRegion() & '.battle.net/api/wow/character';
			*/
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

	<!--- PRIVATE METHODS --->

	<cffunction name="nameToSlug" returntype="string" access="private" output="false">
		<cfargument name="name" type="string" required="true" />
	
		<cfreturn LCase(Replace(Trim(arguments.name),' ','-','ALL')) />
	</cffunction>

	<cffunction name="getResultStruct" returntype="struct" access="private" output="false">
		<cfargument name="resultVarName" type="string" required="true" />
	
		<cfset var res = StructNew() />
		
		<cfset res['response'] = false />
		<cfset res['error'] = false />
		<cfset res['#arguments.resultVarName#'] = StructNew() />
		
		<cfreturn res />
	</cffunction>
	
	<cffunction name="getRealmStruct" returntype="struct" access="private" output="false">
		<cfargument name="name" type="string" required="false" default="" hint="the fully formatted name of the realm" />
		<cfargument name="slug" type="string" required="false" default="" hint="'data-friendly' version of the name; punctuation removed and spaces converted to dashes" />
		<cfargument name="type" type="string" required="false" default="" hint="type of the realm: pve, pvp, rp or rppvp" />
		<cfargument name="status" type="boolean" required="false" default="false" hint="true if realm is up, false otherwise" />
		<cfargument name="queue" type="boolean" required="false" default="false" hint="true if realm has a queue, false otherwise" />
		<cfargument name="population" type="string" required="false" default="" hint="the realm's population: low, medium, high, n/a" />
	
		<cfset var thisArg = 0 />
		<cfset var rs = StructNew() />
		
		<cfloop list="#StructKeyList(arguments)#" index="thisArg">
			<cfset rs['#LCase(thisArg)#'] = arguments[thisArg] />
		</cfloop>

		<cfreturn rs />
	</cffunction>

	<cffunction name="EpochTimeToLocalDate" returntype="date" access="private" output="false">
		<cfargument name="epoch" type="string" required="true" />

		<!--- 
			/**
			 * Converts Epoch time to a ColdFusion date object in local time.
			 * 
			 * @param epoch      Epoch time, in seconds. (Required)
			 * @return Returns a date object. 
			 * @author Rob Brooks-Bilson (rbils@amkor.com) 
			 * @version 1, June 21, 2002 
			 */
		 --->
		
		<cfreturn DateAdd("s", arguments.epoch, DateConvert("utc2Local", "January 1 1970 00:00")) />
	</cffunction>

	<!--- PUBLIC METHODS --->

	<cffunction name="getRealms" returntype="struct" access="public" output="false">
		<cfargument name="name" type="string" required="false" default="" />
		<cfargument name="type" type="string" required="false" default="" />
		<cfargument name="population" type="string" required="false" default="" />
	
		<cfset var thisArg = '' />
		<cfset var baseEndpoint = variables.endpoint.realm />
		<cfset var thisName = '' />
		<cfset var data = '' />
		<cfset var jsonObj = '' />
		<cfset var cfArr = '' />
		<cfset var cfElem = '' />
		<cfset var cfObjStruct = StructNew() />
		<cfset var result = GetResultStruct('realms') />

		<cfloop collection="#arguments#" item="thisArg">
			<cfif Len(arguments[thisArg])>
				<cfset baseEndpoint = baseEndpoint & '?' />
				<cfbreak />
			</cfif>
		</cfloop>

		<cfif Len(arguments.name)>
			<cfloop list="#arguments.name#" index="thisName">
				<cfset baseEndpoint = ListAppend(baseEndpoint, 'realm=' & nameToSlug(thisName), '&') />
			</cfloop>
		</cfif>

		<cfif Len(arguments.type)>
			<cfset baseEndpoint = ListAppend(baseEndpoint, 'type=' & arguments.type, '&') />
		</cfif>
		
		<cfif Len(arguments.population)>
			<cfset baseEndpoint = ListAppend(baseEndpoint, 'population=' & arguments.population, '&') />
		</cfif>		

		<cftry>
			<cfhttp url="#baseEndpoint#"
					method="GET"
					result="data"
					throwonerror="true"
					timeout="15" />
					
			<cfset jsonObj = data.FileContent />
	
			<cfset cfArr = DeserializeJSON(jsonObj.toString()).realms />
	
			<cfloop array="#cfArr#" index="cfElem">
			
				<!--- we insert the key, bracket-style, to preserve the (lower) case --->
				<cfset cfObjStruct['#cfElem.slug#'] = getRealmStruct(argumentCollection=cfElem) />
			</cfloop>
			
			<cfset result.response = 'Success' />
			<cfset result.realms = cfObjStruct />
			
			<cfcatch type="any">
				<cfset result.error = true />
				<cfset result.response = cfcatch.message & ':' & cfcatch.detail />
			</cfcatch>
			
		</cftry>
	
		<cfreturn result />
	</cffunction>

	<cffunction name="getCharacter" returntype="struct" access="public" output="false">
		<cfargument name="realm" type="string" required="true" default="" />	
		<cfargument name="name" type="string" required="true" default="" />

		<cfset var data = '' />
		<cfset var jsonObj = '' />
		<cfset var cfCharacterStruct = '' />
		<cfset var dateLastModified = '' />
		<cfset var baseEndpoint = variables.endpoint.character & '/' & nameToSlug(arguments.realm) & '/' & arguments.name />
		<cfset var result = GetResultStruct('character') />		

		<cftry>
			<cfhttp url="#baseEndpoint#"
					method="GET"
					result="data"
					throwonerror="true"
					timeout="15" />
					
			<cfset jsonObj = data.FileContent />
			
			<!--- save a copy of date, so it doesn't get munged; DeserializeJSON() doesn't recognize an Epoch time --->
			<cfset dateLastModified = ReReplace(jsonObj.toString(),'.*"lastModified":([0-9]+).*','\1','ONE') />
	
			<cfset cfCharacterStruct = DeserializeJSON(jsonObj.toString()) />
			
			<!--- fix lastModified (we shave it by a factor of 10, to deal with seconds rather than ms, due to size of integers in cf) --->
			<cfset cfCharacterStruct['lastModified'] = EpochTimeToLocalDate(Left(dateLastModified,10)) />
	
			<cfset result.response = 'Success' />
			<cfset result.character = cfCharacterStruct />
			
			<cfcatch type="any">
				<cfset result.error = true />
				<cfset result.response = cfcatch.message & ':' & cfcatch.detail />
			</cfcatch>
		</cftry>
	
		<cfreturn result />	
	</cffunction>

</cfcomponent>