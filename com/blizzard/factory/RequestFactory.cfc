<cfcomponent output="false">

	<cffunction name="init" returntype="RequestFactory" access="public" output="false">
		<cfargument name="bnet_host" type="string" required="true" />
		<cfargument name="bnet_protocol" type="string" required="true" />
		<cfargument name="publicKey" type="string" required="true" />
		<cfargument name="privateKey" type="string" required="true" />	
		<cfargument name="cache" type="struct" required="true" />	

		<cfset variables.bnet_host 			= arguments.bnet_host />
		<cfset variables.bnet_protocol 		= arguments.bnet_protocol />
		<cfset variables.publicKey 			= arguments.publicKey />
		<cfset variables.privateKey 		= arguments.privateKey />
		<cfset variables.cache 				= arguments.cache />

		<cfset variables.builder 			= StructNew() />

		<cfscript>
		// ADD BUILDERS
		addBuilder('com.blizzard.builder.CharacterRequestBuilder');
		addBuilder('com.blizzard.builder.RealmsRequestBuilder');
		addBuilder('com.blizzard.builder.GuildRequestBuilder');
		addBuilder('com.blizzard.builder.AuctionHouseRequestBuilder');
		addBuilder('com.blizzard.builder.AuctionHouseDataRequestBuilder');		
		addBuilder('com.blizzard.builder.ItemRequestBuilder');
		addBuilder('com.blizzard.builder.ArenaInfoRequestBuilder');
		addBuilder('com.blizzard.builder.QuestInfoRequestBuilder');
		addBuilder('com.blizzard.builder.CharacterRacesRequestBuilder');
		addBuilder('com.blizzard.builder.CharacterClassesRequestBuilder');			
		addBuilder('com.blizzard.builder.GuildRewardsRequestBuilder');			
		addBuilder('com.blizzard.builder.GuildPerksRequestBuilder');				
		addBuilder('com.blizzard.builder.BattlegroupsRequestBuilder');				
		addBuilder('com.blizzard.builder.CharacterAchievementsRequestBuilder');			
		addBuilder('com.blizzard.builder.GuildAchievementsRequestBuilder');
		
		// ADD. Circular Reference for AH Data
		getBuilder('AuctionHouseRequestBuilder').setDataFactory(this);
		</cfscript>		
	
		<cfreturn this />
	</cffunction>
	
	<cffunction name="addBuilder" returntype="void" access="public" output="false">
		<cfargument name="builder_name" type="string" required="true" />
	
		<cfset variables.builder['#ListLast(arguments.builder_name,'.')#'] = CreateObject('component','#arguments.builder_name#').init(
				variables.bnet_host, variables.bnet_protocol
			) />
		<cfset variables.builder['#ListLast(arguments.builder_name,'.')#'].addAuthenticationSettings(variables.publicKey, variables.privateKey) />
		<cfset variables.builder['#ListLast(arguments.builder_name,'.')#'].addCache(variables.cache) />
	</cffunction>

	<cffunction name="getBuilder" returntype="com.blizzard.builder.AbstractRequestBuilder" access="public" output="false">
		<cfargument name="builder_name" type="string" required="true" />

		<cfreturn variables.builder['#arguments.builder_name#'] />	
	</cffunction>

	<cffunction name="getRequest" returntype="com.blizzard.request.AbstractRequest" access="public" output="false">
		<cfargument name="builder_full_name" type="string" required="true" />
		<cfargument name="parameters" type="struct" required="true" />
		
		<cfset var builder_name = arguments.builder_full_name & 'RequestBuilder' />

		<cfset var requestObject = getBuilder(builder_name) />
		
		<cfreturn requestObject.constructRequestObject(argumentCollection=arguments.parameters) />
	</cffunction>

</cfcomponent>