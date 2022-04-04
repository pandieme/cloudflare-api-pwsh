function Set-ZoneDnsRecord(
    [Parameter(Mandatory)]
    [string]
    $Id,

    [Parameter()]
    [string]
    $Name,

    [Parameter()]
    [ValidateSet('A', 'CNAME')]
    [string]
    $Type,

    [Parameter()]
    [string]
    $Content,

    [Parameter()]
    [bool]
    $Proxied,
    
    [Parameter()]
    [string]
    $BaseUri = $CloudflareApi.BaseUri,

    [Parameter()]
    [string]
    $ApiToken = $CloudflareApi.ApiToken,

    [Parameter()]
    [string]
    $ZoneId = $CloudflareApi.ZoneId
) {
    <#
    .SYNOPSIS
    Change a DNS record within a zone
    #>

    $Headers = @{
        'Authorization' = "Bearer $ApiToken"
        'Content-Type'  = "application/json"
    }

    $Uri = $BaseUri + "/zones/$ZoneId/dns_records/$Id"

    $Body = [pscustomobject]@{
        type    = $Type ? $Type : $null
        name    = $Name ? $Name : $null
        content = $Content ? $Content : $null
        proxied = $Proxied ? $Proxied : $null
    } | ConvertTo-Json

    try {
        $Result = Invoke-RestMethod `
            -Method Patch `
            -Uri $Uri `
            -Headers $Headers `
            -Body $Body
    }
    catch {
        throw
    }
    return $Result.result
}
