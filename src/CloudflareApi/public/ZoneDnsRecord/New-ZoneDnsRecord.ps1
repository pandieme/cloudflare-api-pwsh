function New-ZoneDnsRecord(
    [Parameter(Mandatory)]
    [string]
    $Name,

    [Parameter(Mandatory)]
    [ValidateSet('A', 'CNAME')]
    [string]
    $Type,

    [Parameter(Mandatory)]
    [string]
    $Content,

    [Parameter()]
    [switch]
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
    Create a new DNS record within a zone
    #>

    $Headers = @{
        'Authorization' = "Bearer $ApiToken"
        'Content-Type'  = "application/json"
    }

    $Uri = $BaseUri + "/zones/$ZoneId/dns_records"

    $Body = [pscustomobject]@{
        type    = $Type
        name    = $Name
        content = $Content
        proxied = $Proxied ? $true : $false
    } | ConvertTo-Json

    try {
        $Result = Invoke-RestMethod `
            -Method Post `
            -Uri $Uri `
            -Headers $Headers `
            -Body $Body
    }
    catch {
        throw
    }
    return $Result.result
}
