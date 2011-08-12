<cfcomponent output="false" extends="com.blizzard.decorator.RequestDecorator">

	<cffunction name="init" returntype="AchievementCleaner" access="public" output="false">
		<cfargument name="decorated" type="com.blizzard.request.AbstractRequest" required="true" />
	
		<cfset setDecorated(arguments.decorated) />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setResponseData" returntype="void" access="public" output="false">
		<cfargument name="data" type="any" required="true" />

		<!--- Rules:
		
		1. the data coming in is already ruined. 
		2. We cannot touch the JSON set via setJSON() -- we need it to remain as it arrived via bnet if we're chaining decorators (line 46) --->
		
		<cfset var bad_data = arguments.data />
		<cfset var json = getDecorated().getJSON() />
		
		<!--- clean it --->
		<cfset var cleaned = DeserializeJSON(cleanJSON(json)) />
		
		<!--- replace achievement dates on the munged data --->
		<cfset bad_data['achievements']['achievementsCompletedTimestamp'] = cleaned['achievements']['achievementsCompletedTimestamp'] />
		<cfset bad_data['achievements']['criteriaCreated'] = cleaned['achievements']['criteriaCreated'] />
		<cfset bad_data['achievements']['criteriaTimestamp'] = cleaned['achievements']['criteriaTimestamp'] />		

		<!--- and we store that new fixed data --->
		<cfset getDecorated().setResponseData(bad_data) />	
	</cffunction>

	<cffunction name="cleanJSON" returntype="string" access="private" output="false">
		<cfargument name="json" type="string" required="true" />

		<cfset var data = 0 />
		<cfset var i = 0 />
		<cfset var unique = CreateUUID() />

		<!--- PRE-PROCESS --->
		<cfset var achievementsTSCompleted = ReReplace(arguments.json,'.*"achievementsCompletedTimestamp":\[([^\]]+)\].*','\1','ONE') />
		<cfset var criteriaCreated = ReReplace(arguments.json,'.*"criteriaCreated":\[([^\]]+)\].*','\1','ONE') />
		<cfset var criteriaTS = ReReplace(arguments.json,'.*"criteriaTimestamp":\[([^\]]+)\].*','\1','ONE') />
		
		<cfset data = DeserializeJSON(arguments.json) />
				
		<!--- POST-PROCESS --->

		<cfthread action="run" name="t1_#unique#" act_list="#achievementsTSCompleted#">
			<cfset var i = 0 />
			<cfset THREAD.act_results = ArrayNew(1) />
			<cfloop list="#act_list#" index="i">
				<cfset ArrayAppend(THREAD.act_results, EpochTimeToLocalDate(i)) />
			</cfloop>	
		</cfthread>
		<cfthread action="run" name="t2_#unique#" cc_list="#criteriaCreated#">
			<cfset var i = 0 />
			<cfset THREAD.cc_results = ArrayNew(1) />
			<cfloop list="#cc_list#" index="i">
				<cfset ArrayAppend(THREAD.cc_results, EpochTimeToLocalDate(i)) />
			</cfloop>
		</cfthread>
		<cfthread action="run" name="t3_#unique#" ct_list="#criteriaTS#">
			<cfset var i = 0 />
			<cfset THREAD.ct_results = ArrayNew(1) />
			<cfloop list="#ct_list#" index="i">
				<cfset ArrayAppend(THREAD.ct_results, EpochTimeToLocalDate(i)) />
			</cfloop>
		</cfthread>

		<cfthread action="join" name="t1_#unique#,t2_#unique#,t3_#unique#" timeout="15000" />

		<cfset data['achievements']['achievementsCompletedTimestamp'] = CFTHREAD['t1_#unique#'].act_results />
		<cfset data['achievements']['criteriaCreated'] = CFTHREAD['t2_#unique#'].cc_results />
		<cfset data['achievements']['criteriaTimestamp'] = CFTHREAD['t3_#unique#'].ct_results />
		
		<cfreturn SerializeJSON(data) />
	</cffunction>

</cfcomponent>