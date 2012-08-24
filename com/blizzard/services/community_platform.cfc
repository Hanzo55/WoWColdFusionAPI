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
<cfcomponent output="false">

	<!--- INIT --->
	
	<cffunction name="init" returntype="community_platform" access="public" output="false">
		<cfargument name="cache" type="any" required="true" />
		<cfargument name="region" type="string" required="false" default="us" />
		<cfargument name="locale" type="string" required="false" default="en_US" />		
		<cfargument name="publicKey" type="string" required="false" default="" />
		<cfargument name="privateKey" type="string" required="false" default="" />
		<cfargument name="useSSL" type="boolean" required="false" default="#iif((Len(arguments.publicKey) GT 0 AND Len(arguments.privateKey) GT 0),de('true'),de('false'))#" />
		
		<cfscript>
			variables.factory 	= StructNew();
			
			// BASIC PROPERTIES
			setRegion(arguments.region);
			setLocalization(arguments.locale);
			setPublicKey(arguments.publicKey);
			setPrivateKey(arguments.privateKey);
			setUseSSL(arguments.useSSL);
			setBnetProtocol( iif(useBnetSSL(),de('https://'),de('http://')) );	//we'll use the value of useSSL() to default it, but user can change later if needed
			
			constructFactory();
		</cfscript>
		
		<cfreturn this />
	</cffunction>

	<!--- GETTERS/SETTERS --->

	<cffunction name="setRegion" returntype="void" access="public" output="false">
		<cfargument name="region" type="string" required="true" />

		<cfswitch expression="#arguments.region#">

			<cfcase value="us,eu,kr,tw,cn">
				<cfset variables.region = arguments.region />
			</cfcase>

			<cfdefaultcase>
				<cfthrow type="RegionNotImplemented" message="The region #arguments.region# is unknown." detail="The parameter passed to setRegion() is unknown. Valid values are us, eu, kr, tw and cn." />
			</cfdefaultcase>

		</cfswitch>
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

		<cfswitch expression="#variables.region#">

			<cfcase value="us,eu,kr,tw">
				<cfreturn variables.region & ".battle.net" />
			</cfcase>

			<cfcase value="cn">
				<cfreturn "www.battlenet.com.cn" />
			</cfcase>

		</cfswitch>
	</cffunction>
	
	<cffunction name="setBnetProtocol" returntype="void" access="public" output="false">
		<cfargument name="protocol" type="string" required="true" />
	
		<cfset variables.bnet_protocol = arguments.protocol />
	</cffunction>
	
	<cffunction name="getBnetProtocol" returntype="string" access="public" output="false">
		
		<cfreturn variables.bnet_protocol />
	</cffunction>
	
	<cffunction name="setLocalization" returntype="void" access="public" output="false">
		<cfargument name="locale" type="string" required="true" />
		
		<cfswitch expression="#getRegion()#">

			<cfcase value="us">

				<cfswitch expression="#arguments.locale#">

					<cfcase value="en_US,es_MX,pt_BR">
						<cfset variables.locale = arguments.locale />
					</cfcase>

					<cfdefaultcase>
						<cfthrow type="LocaleUnknown" message="Unknown Locale" detail="the parameter passed to setLocalization(), #arguments.locale#, is invalid for the #getRegion()# region. Valid values are #getValidRegionValues(getRegion())#." />
					</cfdefaultcase>

				</cfswitch>

			</cfcase>

			<cfcase value="eu">

				<cfswitch expression="#arguments.locale#">

					<cfcase value="en_GB,es_ES,fr_FR,ru_RU,de_DE,pt_PT">
						<cfset variables.locale = arguments.locale />
					</cfcase>

					<cfdefaultcase>
						<cfthrow type="LocaleUnknown" message="Unknown Locale" detail="the parameter passed to setLocalization(), #arguments.locale#, is invalid for the #getRegion()# region. Valid values are #getValidRegionValues(getRegion())#." />
					</cfdefaultcase>

				</cfswitch>

			</cfcase>

			<cfcase value="kr">

				<cfswitch expression="#arguments.locale#">

					<cfcase value="ko_KR">
						<cfset variables.locale = arguments.locale />
					</cfcase>

					<cfdefaultcase>
						<cfthrow type="LocaleUnknown" message="Unknown Locale" detail="the parameter passed to setLocalization(), #arguments.locale#, is invalid for the #getRegion()# region. Valid values are #getValidRegionValues(getRegion())#." />
					</cfdefaultcase>

				</cfswitch>

			</cfcase>

			<cfcase value="tw">

				<cfswitch expression="#arguments.locale#">

					<cfcase value="zh_TW">
						<cfset variables.locale = arguments.locale />
					</cfcase>

					<cfdefaultcase>
						<cfthrow type="LocaleUnknown" message="Unknown Locale" detail="the parameter passed to setLocalization(), #arguments.locale#, is invalid for the #getRegion()# region. Valid values are #getValidRegionValues(getRegion())#." />
					</cfdefaultcase>

				</cfswitch>

			</cfcase>

			<cfcase value="cn">

				<cfswitch expression="#arguments.locale#">

					<cfcase value="zh_CN">
						<cfset variables.locale = arguments.locale />
					</cfcase>

					<cfdefaultcase>
						<cfthrow type="LocaleUnknown" message="Unknown Locale" detail="the parameter passed to setLocalization(), #arguments.locale#, is invalid for the #getRegion()# region. Valid values are #getValidRegionValues(getRegion())#." />
					</cfdefaultcase>

				</cfswitch>

			</cfcase>

		</cfswitch>
	</cffunction>

	<cffunction name="getLocalization" returntype="string" access="public" output="false">
		
		<cfreturn variables.locale />
	</cffunction>

	<!--- PRIVATE METHODS --->
	
	<cffunction name="getValidRegionValues" returntype="string" access="private" output="false">
		<cfargument name="region" type="string" required="true" />
		
		<cfswitch expression="#arguments.region#">

			<cfcase value="us">
				<cfreturn "en_US,es_MX,pt_BR" />
			</cfcase>
			
			<cfcase value="eu">
				<cfreturn "en_GB,es_ES,fr_FR,ru_RU,de_DE,pt_PT" />
			</cfcase>

			<cfcase value="kr">
				<cfreturn "ko_KR" />
			</cfcase>

			<cfcase value="tw">
				<cfreturn "zh_TW" />
			</cfcase>

			<cfcase value="cn">
				<cfreturn "zh_CN" />
			</cfcase>

		</cfswitch>
	</cffunction>
	
	<cffunction name="constructFactory" returntype="void" access="private" output="false">
	
		<cfthrow type="MethodNotImplemented" message="Not Implemented" detail="constructFactory() is not implemented. This method must be implemented in a subclass." />			
	</cffunction>
	
	<cffunction name="getApiUri" returntype="string" access="private" output="false">
	
		<cfreturn '/api' />
	</cffunction>
	
	<cffunction name="getFactoryInitializer" returntype="struct" access="private" output="false">
		<cfargument name="cache" type="any" required="true" />
	
		<cfset var settings 			= StructNew() />

		<cfset settings.publicKey		= getPublicKey() />
		<cfset settings.privateKey 		= getPrivateKey() />
		<cfset settings.bnet_host 		= getBnetHost() />
		<cfset settings.bnet_protocol 	= getBnetProtocol() />
		<cfset settings.endpoint		= getApiUri() />
		
		<cfset settings.cache 			= arguments.cache />		
	
		<cfreturn settings />
	</cffunction>
	
	<cffunction name="useBnetSSL" returntype="boolean" access="private" output="false">
	
		<cfreturn getUseSSL() />
	</cffunction>	

</cfcomponent>