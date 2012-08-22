<!---
Copyright (c) 2012 Shawn Holmes

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
<cfcomponent output="false" extends="com.blizzard.services.community_platform">

	<!--- PRIVATE METHODS --->
	
	<cffunction name="getApiUri" returntype="string" access="private" output="false">
	
		<cfreturn super.getApiUri() & '/d3' />
	</cffunction>
	
	<!--- PUBLIC METHODS --->
	
	<cffunction name="getCareer" returntype="struct" access="public" output="false">
		<!--- HANZO: TODO: all explicit args --->

		<cfreturn variables.factory.getRequest('Career', arguments).getResult() />	
	</cffunction>

	<cffunction name="getHero" returntype="struct" access="public" output="false">
		<!--- HANZO: TODO: all explicit args --->	
	
		<cfreturn variables.factory.getRequest('Hero', arguments).getResult() />	
	</cffunction>
	
	<cffunction name="getItem" returntype="struct" access="public" output="false">
		<cfargument name="itemId" type="string" requird="true" />
	
		<cfreturn variables.factory.getRequest('Item', arguments).getResult() />	
	</cffunction>
	
	<cffunction name="getFollower" returntype="struct" access="public" output="false">
		<!--- HANZO: TODO: all explicit args --->
	
		<cfreturn variables.factory.getRequest('Follower', arguments).getResult() />	
	</cffunction>	
	
	<cffunction name="getArtisan" returntype="struct" access="public" output="false">
		<!--- HANZO: TODO: all explicit args --->
	
		<cfreturn variables.factory.getRequest('Artisan', arguments).getResult() />	
	</cffunction>	
	
</cfcomponent>