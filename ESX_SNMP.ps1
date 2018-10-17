# Connect to vCenter
Write-Host "Connecting to VI Server"
$global:DefaultVIServer

$newServer = "false"
if ($global:DefaultVIServer) {
    $viserver = $global:DefaultVIServer.Name
    Write-Host "$VIServer is connected." -ForegroundColor green -BackgroundColor blue
    $in = Read-Host "If you want to connect again/another vCenter? Yes[Y] or No[N](Default: N)"
	if($in -eq "Y"){
	$newServer = "true"
	}
	if ($newServer -eq "true") {
    Disconnect-VIServer -Server "$viserver" -Confirm:$False
	$VCServer = Read-Host "Enter the vCenter server name" 
	$viserver = Connect-VIServer $VCServer  
		if ($VIServer -eq ""){
		Write-Host
		Write-Host "Please input a valid credential"
		Write-Host
		exit
		}	
    }
}else{
	$VCServer = Read-Host "Enter the vCenter server name" 
	$VIServer = Connect-VIServer $VCServer  
	if ($VIServer -eq ""){
		Write-Host
		Write-Host "Please input a valid credential"
		Write-Host
		exit
	}
}
$VMCluster = Read-Host "Enter the cluster name to set up SNMP"
$vmhosts = Get-cluster $vmcluster | Get-VMHost
foreach ($vmhost in $vmhosts)
{$esxcli = Get-EsxCli -VMhost $vmhost
	$esxcli.system.snmp.set('SHA1',$null,$true,$null,$null,$null,$null,$null,$null,'AES128',$null,$null,$null,$null,$null,'ServerUserRO/authhash/privhash/priv',$null)	}