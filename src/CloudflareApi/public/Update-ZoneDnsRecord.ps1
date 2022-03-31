function Update-ZoneDnsRecord(
    [Parameter(Mandatory)]
    [string]$BaseUri,
    
    [Parameter(Mandatory)]
    [string]$ApiToken,

    [Parameter(Mandatory)]
    [string]$ZoneId,

    [Parameter(Mandatory)]
    [string]$Name,

    [Parameter(Mandatory)]
    [ValidateSet('A', 'CNAME')]
    [string]$Type,

    [Parameter(Mandatory)]
    [string]$Content,

    [switch]$Proxied
) {
    <#
    .SYNOPSIS
    Change or create a DNS record within a zone
    #>

    $Parameters = @{
        BaseUri  = $BaseUri
        ApiToken = $ApiToken
        ZoneId   = $ZoneId
        Name     = $Name
        Type     = $Type
        Content  = $Content
    }
    if ($Proxied) { $Parameters.Add('Proxied', $true) }

    try {
        $DnsRecord = Get-ZoneDnsRecord `
            -BaseUri $BaseUri `
            -ApiToken $ApiToken `
            -ZoneId $ZoneId `
            -Name $Name
    
        if (!$DnsRecord) {
            $Result = New-ZoneDnsRecord @Parameters
        }
        else {
            $Result = Set-ZoneDnsRecord -Id $DnsRecord.id @Parameters
        }
    }
    catch {
        throw
    }

    return $Result
}
