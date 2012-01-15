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
		<cfargument name="cache" type="any" required="true" />
		<cfargument name="region" type="string" required="false" default="us" />
		<cfargument name="publicKey" type="string" required="false" default="" />
		<cfargument name="privateKey" type="string" required="false" default="" />
		<cfargument name="useSSL" type="boolean" required="false" default="#iif((Len(arguments.publicKey) GT 0 AND Len(arguments.privateKey) GT 0),de('true'),de('false'))#" />
		
		<cfscript>
			// BASIC PROPERTIES
			setRegion(arguments.region);
			setPublicKey(arguments.publicKey);
			setPrivateKey(arguments.privateKey);
			setUseSSL(arguments.useSSL);
			setBnetProtocol( iif(useBnetSSL(),de('https://'),de('http://')) );	//we'll use the value of useSSL() to default it, but user can change later if needed
			
			// FACTORY
			variables.factory = CreateObject('component','com.blizzard.factory.RequestFactory').init(
				argumentCollection=getFactoryInitializer(arguments.cache)
			);
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
	
	<cffunction name="setUseSSL" returntype="void" access="public" output="false">
		<cfargument name="ssl" type="boolean" required="true" />
	
		<cfset variables.useSSL = arguments.ssl />
	</cffunction>
	
	<cffunction name="getUseSSL" returntype="boolean" access="public" output="false">
		
		<cfreturn variables.useSSL />
	</cffunction>

	<cffunction name="setBnetHost" returntype="void" access="public" output="false">
		<cfargument name="bnet_host" type="string" required="true" />		
		
		<cfthrow type="MethodNotImplemented" message="Not Implemented" detail="setBnetHost() is not implemented. To change the top-level domain name used in the request, call setRegion() instead." />
	</cffunction>
	
	<cffunction name="getBnetHost" returntype="string" access="public" output="false">
		
		<cfreturn getRegion() & '.battle.net' />
	</cffunction>
	
	<cffunction name="setBnetProtocol" returntype="void" access="public" output="false">
		<cfargument name="protocol" type="string" required="true" />
	
		<cfset variables.bnet_protocol = arguments.protocol />
	</cffunction>
	
	<cffunction name="getBnetProtocol" returntype="string" access="public" output="false">
		
		<cfreturn variables.bnet_protocol />
	</cffunction>	

	<!--- PRIVATE METHODS --->
	
	<cffunction name="getFactoryInitializer" returntype="struct" access="private" output="false">
		<cfargument name="cache" type="any" required="true" />
	
		<cfset var settings 			= StructNew() />

		<cfset settings.publicKey		= getPublicKey() />
		<cfset settings.privateKey 		= getPrivateKey() />
		<cfset settings.bnet_host 		= getBnetHost() />
		<cfset settings.bnet_protocol 	= getBnetProtocol() />
		
		<cfset settings.cache = arguments.cache />		
	
		<cfreturn settings />
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

	<cffunction name="useBnetSSL" returntype="boolean" access="private" output="false">
	
		<cfreturn getUseSSL() />
	</cffunction>

	<!--- PUBLIC METHODS --->

	<cffunction name="getCharacter" returntype="struct" access="public" output="false">
		<cfargument name="realm" type="string" required="true" default="" />	
		<cfargument name="name" type="string" required="true" default="" />
		<cfargument name="guild" type="boolean" required="false" />
		<cfargument name="stats" type="boolean" required="false" />
		<cfargument name="talents" type="boolean" required="false" />
		<cfargument name="items" type="boolean" required="false" />
		<cfargument name="reputation" type="boolean" required="false" />
		<cfargument name="titles" type="boolean" required="false" />
		<cfargument name="professions" type="boolean" required="false" />
		<cfargument name="appearance" type="boolean" required="false" />
		<cfargument name="companions" type="boolean" required="false" />
		<cfargument name="mounts" type="boolean" required="false" />
		<cfargument name="pets" type="boolean" required="false" />
		<cfargument name="achievements" type="boolean" required="false" />
		<cfargument name="progression" type="boolean" required="false" />
		<cfargument name="quests" type="boolean" required="false" />
		<cfargument name="pvp" type="boolean" required="false" />

		<cfreturn variables.factory.getRequest('Character', arguments).getResult() />
	</cffunction>

	<cffunction name="getRealms" returntype="struct" access="public" output="false">
		<cfargument name="name" type="string" required="false" default="" />

		<cfreturn variables.factory.getRequest('Realms', arguments).getResult() />
	</cffunction>

	<cffunction name="getGuild" returntype="struct" access="public" output="false">
		<cfargument name="realm" type="string" required="true" />
		<cfargument name="name" type="string" required="true" />
		<cfargument name="members" type="boolean" required="false" />		
		<cfargument name="achievements" type="boolean" required="false" />

		<cfreturn variables.factory.getRequest('Guild', arguments).getResult() />
	</cffunction>

	<cffunction name="getAuctionHouse" returntype="struct" access="public" output="false">
		<cfargument name="realm" type="string" required="true" />

		<cfreturn variables.factory.getRequest('AuctionHouse', arguments).getResult() />
	</cffunction>

	<cffunction name="getItem" returntype="struct" access="public" output="false">
		<cfargument name="itemId" type="numeric" requird="true" />

		<cfreturn variables.factory.getRequest('Item', arguments).getResult() />
	</cffunction>
	
	<cffunction name="getArenaInfo" returntype="struct" access="public" output="false">
		<cfargument name="battlegroup" type="string" required="true" />
		<cfargument name="team_type" type="string" required="true" />
		<cfargument name="size" type="numeric" required="false" hint="how many teams to return (50 by default)" />

		<cfreturn variables.factory.getRequest('ArenaInfo', arguments).getResult() />	
	</cffunction>
	
	<cffunction name="getQuestInfo" returntype="struct" access="public" output="false">
		<cfargument name="questId" type="numeric" required="true" />

		<cfreturn variables.factory.getRequest('QuestInfo', arguments).getResult() />	
	</cffunction>	
	
	<cffunction name="getRecipe" returntype="struct" access="public" output="false">
		<cfargument name="recipeId" type="numeric" required="true" />
	
		<cfreturn variables.factory.getRequest('Recipe', arguments).getResult() />
	</cffunction>
	
	<!--- UTILITY (LOOKUP) METHODS --->	

	<cffunction name="getCharacterRaces" returntype="struct" access="public" output="false">

		<cfreturn variables.factory.getRequest('CharacterRaces', arguments).getResult() />	
	</cffunction>
	
	<cffunction name="getCharacterClasses" returntype="struct" access="public" output="false">

		<cfreturn variables.factory.getRequest('CharacterClasses', arguments).getResult() />	
	</cffunction>	

	<cffunction name="getGuildRewards" returntype="struct" access="public" output="false">

		<cfreturn variables.factory.getRequest('GuildRewards', arguments).getResult() />
	</cffunction>

	<cffunction name="getGuildPerks" returntype="struct" access="public" output="false">

		<cfreturn variables.factory.getRequest('GuildPerks', arguments).getResult() />
	</cffunction>
	
	<cffunction name="getBattlegroups" returntype="struct" access="public" output="false">

		<cfreturn variables.factory.getRequest('Battlegroups', arguments).getResult() />
	</cffunction>
	
	<cffunction name="getCharacterAchievements" returntype="struct" access="public" output="false">

		<cfreturn variables.factory.getRequest('CharacterAchievements', arguments).getResult() />
	</cffunction>
	
	<cffunction name="getGuildAchievements" returntype="struct" access="public" output="false">

		<cfreturn variables.factory.getRequest('GuildAchievements', arguments).getResult() />		
	</cffunction>	
	
	<!--- DEBUG --->
	
	<!--- <cffunction name="dumpCache" returntype="any" access="public" output="false">
	
		<cfreturn variables.cache.dump() />
	</cffunction> --->

</cfcomponent>