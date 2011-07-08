<cfscript>
// INIT (Region is US by default)
wow = CreateObject('component','com.blizzard.services.wow').init();

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
	
	// NOTE: from here on out, we'll assume additional queries do not error out; remember that ever call to getRealms() can potentially fail due to communication error, etc.
	
	// Get all pvp realms
	pvp = wow.getRealms(type='pvp');	
	
	// Count the number of pvp realms
	WriteOutput('There are ' & StructCount(pvp.realms) & ' pvp realms.<br/>');
	
	// Get realms by population
	medium = wow.getRealms(population='medium');
	
	// Output the realms in JSON format (we'll use an HTML textarea for convenience)
	WriteOutput('<textarea rows="40" cols="80">' & SerializeJSON(medium.realms) & '</textarea>');	

	// Get a custom list of realms
	my = wow.getRealms(name='Deathwing,Aerie Peak,Cho''gall'); // you use two single quotes to 'escape' a single quote in CF; doubling the char. is a typical escape sequence
	
	// Get a character
	a = wow.getCharacter(realm='Deathwing',name='Mature'); // for this call, name means the name of the player, so we use 'realm' to designate the server

// Some kind of error happened, show it
} else {

	WriteOutput('Some sort of error occurred. ' & wowquery.response);
}
</cfscript>

<!--- hey! don't forget about the custom realms you requested! --->
<cfif NOT wowquery.error>
	<!--- take a good ol' CFDUMP (on debrah's desk) --->
	<cfdump var=#my.realms# />
	
	<!--- here's the character you queried --->
	<cfdump var=#a.character# />
</cfif>
