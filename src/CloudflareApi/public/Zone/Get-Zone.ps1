function Get-Zone(
    [Parameter(Mandatory)]
    [string]
    $Name,

    [Parameter()]
    [string]
    $BaseUri = $CloudflareApi.BaseUri,

    [Parameter()]
    [string]
    $ApiToken = $CloudflareApi.ApiToken
) {
    <#
    .SYNOPSIS
    Get Cloudflare Zone
#>
    $Headers = @{
        'Authorization' = "Bearer $ApiToken"
        'Content-Type'  = "application/json"
    }

    $Query = @(
        "name=$Name"
    ) | Join-String -Property $_ -Separator "&" -OutputPrefix "?"

    $Uri = $BaseUri + "/zones$Query"

    try {
        $Result = Invoke-RestMethod `
            -Method Get `
            -Uri $Uri `
            -Headers $Headers
    }
    catch {
        throw
    }
    return $Result.result
}