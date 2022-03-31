function Get-ZoneDnsRecord(
    [Parameter(Mandatory)]
    [string]$Name,

    [Parameter()]
    [string]$BaseUri = $CloudflareApi.BaseUri,

    [Parameter()]
    [string]$ApiToken = $CloudflareApi.ApiToken,
    
    [Parameter()]
    [string]$ZoneId = $CloudflareApi.ZoneId
) {
    <#
    .SYNOPSIS
    Find a DNS record within a zone
    #>

    $Headers = @{
        'Authorization' = "Bearer $ApiToken"
        'Content-Type'  = "application/json"
    }

    $Query = @(
        "type=CNAME,A"
        "name=$Name"
    ) | Join-String -Property $_ -Separator "&" -OutputPrefix "?"

    $Uri = $BaseUri + "/zones/$ZoneId/dns_records$Query"

    try {
        $Result = Invoke-RestMethod `
            -Method Get `
            -Uri $Uri `
            -Headers $Headers `
            -Body $Body
    }
    catch {
        throw
    }
    return $Result.result
}
