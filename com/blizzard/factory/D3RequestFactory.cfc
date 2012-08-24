<cfcomponent output="false" extends="com.blizzard.factory.AbstractRequestFactory">

	<cffunction name="constructBuilders" returntype="void" access="public" output="false">

		<cfscript>
		// ADD BUILDERS
		addBuilder('com.blizzard.builder.CareerRequestBuilder');
		addBuilder('com.blizzard.builder.HeroRequestBuilder');
		addBuilder('com.blizzard.builder.d3.ItemRequestBuilder');
		addBuilder('com.blizzard.builder.FollowerRequestBuilder');
		addBuilder('com.blizzard.builder.ArtisanRequestBuilder');
		</cfscript>		
	</cffunction>

</cfcomponent>