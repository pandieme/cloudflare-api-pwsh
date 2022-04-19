function Clear-ZoneCache(
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
    Purge cache for DNS zone
    #>

    $Headers = @{
        'Authorization' = "Bearer $ApiToken"
        'Content-Type'  = "application/json"
    }

    $Body = [pscustomobject]@{
        purge_everything = $true
    } | ConvertTo-Json

    $Uri = $BaseUri + "/zones/$ZoneId/purge_cache"

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
