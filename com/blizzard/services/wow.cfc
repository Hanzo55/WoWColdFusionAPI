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
			
			// CACHE
			variables.cache = arguments.cache;
			
			// UTIL
			variables.util = CreateObject('component','com.hanzo.util.bnet');
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
	
	<cffunction name="getAuthenticationSettings" returntype="struct" access="public" output="false">
	
		<cfset var settings = StructNew() />
		
		<cfset settings.cache = variables.cache />
		
		<cfif Len(getPublicKey())>
			<cfset settings.publicKey = getPublicKey() />
		</cfif>
		
		<cfif Len(getPrivateKey())>
			<cfset settings.privateKey = getPrivateKey() />
		</cfif>
	
		<cfreturn settings />
	</cffunction>	
	
	<cffunction name="setUseSSL" returntype="void" access="public" output="false">
		<cfargument name="ssl" type="boolean" required="true" />
	
		<cfset variables.useSSL = arguments.ssl />
	</cffunction>
	
	<cffunction name="getUseSSL" returntype="boolean" access="public" output="false">
		
		<cfreturn variables.useSSL />
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

		<cfset var args = arguments />
		<cfset var arg = '' / >
		<cfset var fields = '' />
		<cfset var baseUrl = '' />
		<cfset var baseEndpoint = '' />
		
		<cfset var character = CreateObject('component','com.blizzard.request.CharacterRequest').init(argumentCollection=getAuthenticationSettings()) />
		<cfset character = CreateObject('component','com.blizzard.decorator.LastModifiedCleaner').init(character) />

		<cfset baseUrl = character.getEndpoint() & '/' & variables.util.nameToSlug(arguments.realm) & '/' & arguments.name />
		<cfset baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />

		<cfset StructDelete(args,'realm') />
		<cfset StructDelete(args,'name') />

		<cfloop collection="#args#" item="arg">
			<cfif StructKeyExists(arguments, arg) AND (arguments[arg])>
				<cfset fields = ListAppend(fields, LCase(arg)) />
				<!--- decorate further if achievements are involved --->
				<cfif NOT CompareNoCase(LCase(arg), 'achievements')>
					<cfset character = CreateObject('component','com.blizzard.decorator.AchievementCleaner').init(character) />
				</cfif>
			</cfif>
		</cfloop>

		<cfif Len(fields)>
			<cfset baseEndpoint = baseEndpoint & '?fields=' & fields />		
		</cfif>
		
		<cfset character.send(baseEndpoint) />
		
		<cfreturn character.getResponse() />
	</cffunction>

	<cffunction name="getRealms" returntype="struct" access="public" output="false">
		<cfargument name="name" type="string" required="false" default="" />

		<cfset var thisRealm = '' />
		<cfset var realmList = '' />	
		<cfset var realms = CreateObject('component','com.blizzard.request.RealmRequest').init(argumentCollection=getAuthenticationSettings()) />

		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & realms.getEndpoint() />

		<cfif StructKeyExists(arguments,'name') AND Len(arguments.name)>
			<cfloop list="#arguments.name#" index="thisRealm">
				<cfset realmList = ListAppend(realmList, variables.util.nameToSlug(Trim(thisRealm))) />
			</cfloop>

			<cfset baseEndpoint = baseEndpoint & '?realms=' & realmList />
		</cfif>
		
		<cfset realms.send(baseEndpoint) />
		
		<cfreturn realms.getResponse() />
	</cffunction>

	<cffunction name="getGuild" returntype="struct" access="public" output="false">
		<cfargument name="realm" type="string" required="true" />
		<cfargument name="name" type="string" required="true" />
		<cfargument name="members" type="boolean" required="false" />		
		<cfargument name="achievements" type="boolean" required="false" />

		<cfset var args = arguments />
		<cfset var arg = '' / >
		<cfset var fields = '' />
		<cfset var baseUrl = '' />
		<cfset var baseEndpoint = '' />

		<cfset var guild = CreateObject('component','com.blizzard.request.GuildRequest').init(argumentCollection=getAuthenticationSettings()) />
		<cfset guild = CreateObject('component','com.blizzard.decorator.LastModifiedCleaner').init(guild) />
		
		<cfset baseUrl = guild.getEndpoint() & '/' & variables.util.nameToSlug(arguments.realm) & '/' & UrlEncodedFormat(arguments.name) />
		<cfset baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />		

		<cfset StructDelete(args,'realm') />
		<cfset StructDelete(args,'name') />

		<cfloop collection="#args#" item="arg">
			<cfif StructKeyExists(arguments, arg) AND (arguments[arg])>
				<cfset fields = ListAppend(fields, LCase(arg)) />
				<!--- decorate further if achievements are involved --->
				<cfif NOT CompareNoCase(LCase(arg), 'achievements')>
					<cfset guild = CreateObject('component','com.blizzard.decorator.AchievementCleaner').init(guild) />
				</cfif>				
			</cfif>
		</cfloop>

		<cfif Len(fields)>
			<cfset baseEndpoint = baseEndpoint & '?fields=' & fields />		
		</cfif>
		
		<cfset guild.send(baseEndpoint) />
		
		<cfreturn guild.getResponse() />
	</cffunction>

	<cffunction name="getAuctionHouse" returntype="struct" access="public" output="false">
		<cfargument name="realm" type="string" required="true" />

		<cfset var auctionHouse = CreateObject('component','com.blizzard.request.AuctionHouseRequest').init(argumentCollection=getAuthenticationSettings()) />
		<cfset var baseUrl = auctionHouse.getEndpoint() & '/' & variables.util.nameToSlug(arguments.realm) />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />
		
		<cfset auctionHouse.send(baseEndpoint) />
		
		<cfreturn auctionHouse.getResponse() />
	</cffunction>

	<cffunction name="getItem" returntype="struct" access="public" output="false">
		<cfargument name="itemId" type="numeric" requird="true" />

		<cfset var item = CreateObject('component','com.blizzard.request.ItemRequest').init(argumentCollection=getAuthenticationSettings()) />
		<cfset var baseUrl = item.getEndpoint() & '/' & arguments.itemId />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />

		<cfset item.send(baseEndpoint) />
		
		<cfreturn item.getResponse() />
	</cffunction>
	
	<cffunction name="getArenaInfo" returntype="struct" access="public" output="false">
		<cfargument name="battlegroup" type="string" required="true" />
		<cfargument name="team_type" type="string" required="true" />
		<cfargument name="size" type="numeric" required="false" hint="how many teams to return (50 by default)" />

		<cfset var arena_info = CreateObject('component','com.blizzard.request.ArenaInfoRequest').init(argumentCollection=getAuthenticationSettings()) />
		<cfset var baseUrl = arena_info.getEndpoint() & '/' & variables.util.nameToSlug(arguments.battlegroup) & '/' & (arguments.team_type) />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />
		
		<cfif StructKeyExists(arguments,'size') AND (arguments.size)>
			<cfset baseEndpoint = baseEndpoint & '?size=' & size />		
		</cfif>			
		
		<cfset arena_info.send(baseEndpoint) />
		
		<cfreturn arena_info.getResponse() />
	</cffunction>
	
	<cffunction name="getQuestInfo" returntype="struct" access="public" output="false">
		<cfargument name="questId" type="numeric" required="true" />

		<cfset var quest_info = CreateObject('component','com.blizzard.request.QuestInfoRequest').init(argumentCollection=getAuthenticationSettings()) />
		<cfset var baseUrl = quest_info.getEndpoint() & '/' & (arguments.questId) />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />
		
		<cfset quest_info.send(baseEndpoint) />
		
		<cfreturn quest_info.getResponse() />
	</cffunction>	
	
	<!--- UTILITY (LOOKUP) METHODS --->	

	<cffunction name="getCharacterRaces" returntype="struct" access="public" output="false">

		<cfset var char_races = CreateObject('component','com.blizzard.request.CharacterRacesRequest').init(argumentCollection=getAuthenticationSettings()) />
		<cfset var baseUrl = char_races.getEndpoint() />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />	

		<cfset char_races.send(baseEndpoint) />
		
		<cfreturn char_races.getResponse() />
	</cffunction>
	
	<cffunction name="getCharacterClasses" returntype="struct" access="public" output="false">

		<cfset var char_classes = CreateObject('component','com.blizzard.request.CharacterClassesRequest').init(argumentCollection=getAuthenticationSettings()) />
		<cfset var baseUrl = char_classes.getEndpoint() />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />	

		<cfset char_classes.send(baseEndpoint) />
		
		<cfreturn char_classes.getResponse() />	
	</cffunction>	

	<cffunction name="getGuildRewards" returntype="struct" access="public" output="false">

		<cfset var guild_rw = CreateObject('component','com.blizzard.request.GuildRewardsRequest').init(argumentCollection=getAuthenticationSettings()) />
		<cfset var baseUrl = guild_rw.getEndpoint() />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />	

		<cfset guild_rw.send(baseEndpoint) />
		
		<cfreturn guild_rw.getResponse() />
	</cffunction>

	<cffunction name="getGuildPerks" returntype="struct" access="public" output="false">

		<cfset var guild_perk = CreateObject('component','com.blizzard.request.GuildPerksRequest').init(argumentCollection=getAuthenticationSettings()) />
		<cfset var baseUrl = guild_perk.getEndpoint() />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />	

		<cfset guild_perk.send(baseEndpoint) />
		
		<cfreturn guild_perk.getResponse() />
	</cffunction>
	
	<cffunction name="getBattlegroups" returntype="struct" access="public" output="false">

		<cfset var battlegroups = CreateObject('component','com.blizzard.request.BattlegroupsRequest').init(argumentCollection=getAuthenticationSettings()) />
		<cfset var baseUrl = battlegroups.getEndpoint() />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />	

		<cfset battlegroups.send(baseEndpoint) />
		
		<cfreturn battlegroups.getResponse() />
	</cffunction>
	
	<cffunction name="getCharacterAchievements" returntype="struct" access="public" output="false">

		<cfset var ca = CreateObject('component','com.blizzard.request.CharacterAchievementsRequest').init(argumentCollection=getAuthenticationSettings()) />
		<cfset var baseUrl = ca.getEndpoint() />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />	

		<cfset ca.send(baseEndpoint) />
		
		<cfreturn ca.getResponse() />
	</cffunction>
	
	<cffunction name="getGuildAchievements" returntype="struct" access="public" output="false">

		<cfset var ga = CreateObject('component','com.blizzard.request.GuildAchievementsRequest').init(argumentCollection=getAuthenticationSettings()) />
		<cfset var baseUrl = ga.getEndpoint() />
		<cfset var baseEndpoint = getBnetProtocol() & getBnetHost() & baseUrl />	

		<cfset ga.send(baseEndpoint) />
		
		<cfreturn ga.getResponse() />
	</cffunction>	

	<!--- DEBUG --->
	
	<cffunction name="dumpCache" returntype="any" access="public" output="false">
	
		<cfreturn variables.cache.dump() />
	</cffunction>

</cfcomponent>