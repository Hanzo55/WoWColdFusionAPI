<cfcomponent output="false" extends="com.blizzard.factory.AbstractRequestFactory">

	<cffunction name="constructBuilders" returntype="void" access="public" output="false">

		<cfscript>
		// ADD BUILDERS
		addBuilder('com.blizzard.builder.CharacterRequestBuilder');
		addBuilder('com.blizzard.builder.RealmsRequestBuilder');
		addBuilder('com.blizzard.builder.GuildRequestBuilder');
		addBuilder('com.blizzard.builder.AuctionHouseRequestBuilder');
		addBuilder('com.blizzard.builder.AuctionHouseDataRequestBuilder');
		addBuilder('com.blizzard.builder.wow.ItemRequestBuilder');
		addBuilder('com.blizzard.builder.ArenaInfoRequestBuilder');
		addBuilder('com.blizzard.builder.QuestInfoRequestBuilder');
		addBuilder('com.blizzard.builder.CharacterRacesRequestBuilder');
		addBuilder('com.blizzard.builder.CharacterClassesRequestBuilder');			
		addBuilder('com.blizzard.builder.GuildRewardsRequestBuilder');			
		addBuilder('com.blizzard.builder.GuildPerksRequestBuilder');				
		addBuilder('com.blizzard.builder.BattlegroupsRequestBuilder');				
		addBuilder('com.blizzard.builder.CharacterAchievementsRequestBuilder');			
		addBuilder('com.blizzard.builder.GuildAchievementsRequestBuilder');
		addBuilder('com.blizzard.builder.RecipeRequestBuilder');
		
		// ADD. Circular Reference for AH Data
		getBuilder('AuctionHouseRequestBuilder').setDataFactory(this);
		</cfscript>		
	</cffunction>

</cfcomponent>