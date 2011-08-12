<cfscript>
// INIT (Region is US by default)
wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache);

// uncomment the line below to use your Blizzard Application ID (supply the publicKey and privateKey they give you)
//wow = CreateObject('component','com.blizzard.services.wow').init(cache=application.cache,region='us',publicKey='XXXX',privateKey='YYYY');

// example of an INIT as Europe
//wow_eu = CreateObject('component','com.blizzard.services.wow').init('eu');

// example of changing the region after init
//wow.setRegion('eu');

// Get all realms
wowquery = wow.getRealms();

// Make sure there's no comm. error
if (!wowquery.error) {

	// Show me the status of Deathwing-US
	WriteOutput('Deathwing-US is up: ' & wowquery.realms.deathwing.status & '<br/>' ); 
	
	// **NOTE**: from here on out, we'll assume additional queries do not error out; remember that ever call to getRealms() can potentially fail due to communication error, etc.
	// so be sure to check the 'error' key on the returned result.
	
	// Output the realms in JSON format (we'll use an HTML textarea for convenience)
	WriteOutput('<textarea rows="40" cols="80">' & SerializeJSON(wowquery.realms) & '</textarea><br/>');	

	// Get a custom list of realms
	my = wow.getRealms(name='Deathwing,Aerie Peak,Cho''gall'); // you use two single quotes to 'escape' a single quote in CF; doubling the char. is a typical escape sequence
	
	// Get a character
	a = wow.getCharacter(realm='Deathwing', name='Mature', guild=true); // for this call, name means the name of the player, so we use 'realm' to designate the server

	//WriteOutput('My character''s guild is: ' & a.character.guild.name & ' on ' & a.character.guild.realm & '<br/>');

	// Get a Guild
	//some = wow.getGuild(realm='Deathwing',name='Descendants of Draenor',members=true,achievements=true);
	//WriteOutput('The guild: ' & some.guild.name & ' has ' & ArrayLen(some.guild.members) & ' members in it.<br/>');
	//WriteOutput('<table border="1" borderColor="' & Right(some.guild.emblem.borderColor,6) & '"><tr><td bgcolor="' & Right(some.guild.emblem.backgroundColor,6) & '"><font color="' & Right(some.guild.emblem.iconColor,6) & '">ICON</font></td></table><br/>');
	
	// Get an Auction House dataset
	//auctionhouse = wow.getAuctionHouse(realm='Deathwing');
	
	//races = wow.getCharacterRaces();
	//classes = wow.getCharacterClasses();
	//gr = wow.getGuildRewards();
	//gp = wow.getGuildPerks();
	
	//item = wow.getItem(49623);
// Some kind of error happened, show it
} else {

	WriteOutput('Some sort of error occurred. ' & wowquery.errorDetail);
}
</cfscript>

<!--- hey! don't forget about the custom realms you requested! --->
<cfif NOT wowquery.error>
	
	<!--- <cfdump var=#wowquery#> ---> <!--- the first query we made, asking for all realms --->
	
	<!--- <cfdump var=#my#> ---> <!--- custom realms --->
	
	<!--- <cfdump var=#a#> ---> <!--- the character request --->
	
	<!--- <cfdump var=#some#> ---><!--- the guild request --->

	<!--- <cfdump var="#auctionHouse#" top="10"> ---> <!--- the AH dump (just show the first 10 auctions for each house, otherwise the dump will timeout) --->
	
	<!--- <cfdump var=#races# />
	<cfdump var=#classes# />
	<cfdump var=#gr# />
	<cfdump var=#gp# /> --->	
	
	<!--- <cfdump var=#wow.dumpCache()#> --->
</cfif>
