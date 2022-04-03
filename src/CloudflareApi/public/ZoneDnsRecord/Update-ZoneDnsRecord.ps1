function Update-ZoneDnsRecord(
    [Parameter(Mandatory)]
    [string]$Name,

    [Parameter(Mandatory)]
    [ValidateSet('A', 'CNAME')]
    [string]$Type,

    [Parameter(Mandatory)]
    [string]$Content,

    [Parameter()]
    [switch]$Proxied,

    [Parameter()]
    [string]$BaseUri = $CloudflareApi.BaseUri,
    
    [Parameter()]
    [string]$ApiToken = $CloudflareApi.ApiToken,

    [Parameter()]
    [string]$ZoneId = $CloudflareApi.ZoneId
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
