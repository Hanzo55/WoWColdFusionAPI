<cfcomponent output="false">
	
	<!--- Application name, should be unique --->
	<cfset this.name = Hash( GetCurrentTemplatePath() ) />
	
	<!--- How long application vars persist --->
	<cfset this.applicationTimeout = createTimeSpan(0,8,0,0) />
	
	<!--- Dev or Prod? --->
	<cfset this.isDev = false />
	
	<!--- Run when application starts up --->
	<cffunction name="onApplicationStart" returnType="boolean" output="false">

		<cfif (NOT IsDefined('application.cache')) OR (IsDefined('url.reinit'))>			
			
			<cflock name="cacheInit" type="exclusive" timeout="15">
				<cfset application.cache = CreateObject('component','com.hanzo.util.cache.SimpleCache').init() />
			</cflock>
		
			<cfif isdefined('url.reinit')>
				<cfobjectcache action="clear" />
			</cfif>
		</cfif>
		
		<cfreturn true />
	</cffunction>

	<!--- Run before the request is processed --->
	<cffunction name="onRequestStart" returnType="boolean" output="false">
		<cfargument name="thePage" type="string" required="true" />
		
		<cfif isdefined('url.reinit')>
			<cfset onApplicationStart() />
		</cfif>
		
		<cfreturn true />
	</cffunction>
	
</cfcomponent>