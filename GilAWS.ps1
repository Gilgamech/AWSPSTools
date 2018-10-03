




function Compare-IAMPolicy {
	param(
		$FirstPolicyName,
		$SecondPolicyName
	);	
	
	$FirstPolicy = Decode-IAMPolicy $FirstPolicyName
	$SecondPolicy = Decode-IAMPolicy $SecondPolicyName
	
	$Diff = diff $FirstPolicy.action $SecondPolicy.action -includeequal
	
	$Compare = "" | select FirstPolicy,SecondPolicy,BothPolicies
	
	try {
	$Compare.FirstPolicy = ConvertFrom-Csv ($Diff|where{$_.SideIndicator -eq "=>"}).InputObject -delimiter : -Header "Service","Permission" | group service | select count,name,@{n="Services";e={$_.group.permission}} | sort name
	} catch {}
	try {
	$Compare.SecondPolicy = ConvertFrom-Csv ($Diff|where{$_.SideIndicator -eq "<="}).InputObject -delimiter : -Header "Service","Permission" | group service | select count,name,@{n="Services";e={$_.group.permission}} | sort name
	} catch {}
	try {
	$Compare.BothPolicies = ConvertFrom-Csv ($Diff|where{$_.SideIndicator -eq "=="}).InputObject -delimiter : -Header "Service","Permission" | group service | select count,name,@{n="Services";e={$_.group.permission}} | sort name
	} catch {}
	
	$Compare
}

function Decode-IAMPolicy {
	param(
		$PolicyName,
		$IAMPolicyList = (Get-IAMPolicyList)
	);	
	$PolicyData = $IAMPolicyList | where {$PolicyName -eq ($_.arn -split "/")[1]}
	
	$Policy = ([System.Web.HttpUtility]::UrlDecode((Get-IAMPolicyVersion -PolicyArn $PolicyData[0].arn -VersionId $PolicyData[0].DefaultVersionId).Document) | ConvertFrom-Json).statement
	$Policy
}



<#
For Resume

Planning, story creation, etc.
Provide server info and schedules for patching.
Participate in change management processes. 
Coordinate AWS maintenance. 
Peer Review scripts written by coworkers.
Audit reporting and support.
Support newly-released AWS services.
PMP support and upgrades
Migrate S3-SFTP services.
Migrate from AWS logins to AzureAD SSO.
Update AWS settings to secure servers.
Migrate from Proxy to Checkpoint firewalls. Proxy removal.


#>

