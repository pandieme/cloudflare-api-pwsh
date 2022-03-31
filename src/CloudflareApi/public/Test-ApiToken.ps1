function Test-ApiToken(
    [Parameter()]
    [string]$BaseUri = $CloudflareApi.BaseUri,

    [Parameter()]
    [string]$ApiToken = $CloudflareApi.ApiToken
) {
    <#
    .SYNOPSIS
    Test that a supplied API token is valid
    #>

    $Headers = @{
        'Authorization' = "Bearer $ApiToken"
        'Content-Type'  = "application/json"
    }

    $Uri = $BaseUri + "/user/tokens/verify"

    try {
        $Result = (Invoke-RestMethod -Method Get -Uri $Uri -Headers $Headers).success
    }
    catch {
        $Result = $false
    }
    return $Result
}
