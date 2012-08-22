<cfcomponent output="false">

	<cffunction name="constructBuilders" returntype="void" access="public" output="false">

		<cfscript>
		// ADD BUILDERS
		addBuilder('com.blizzard.builder.CareerRequestBuilder');
		addBuilder('com.blizzard.builder.HeroRequestBuilder');
		addBuilder('com.blizzard.builder.ItemRequestBuilder');
		addBuilder('com.blizzard.builder.FollowerRequestBuilder');
		addBuilder('com.blizzard.builder.ArtisanRequestBuilder');
		</cfscript>		
	</cffunction>

</cfcomponent>