function Set-CloudflareApi(
    [Parameter()]
    [string]
    $ApiToken,

    [Parameter()]
    [string]
    $BaseUri,

    [Parameter()]
    [string]
    $ZoneId,

    [Parameter()]
    [string]
    $ConfigPath = "~\.pwsh\CloudflareApi.json"
) {
    <#
    .SYNOPSIS
    Set CloudflareApi Configuration
    .DESCRIPTION
    Create config file in user profile if it doens't exist, or update it with updated values
    #>
    try {
        if (!($CloudflareApi = Get-CloudflareApi -ConfigPath $ConfigPath)) {
            New-Item -Path $ConfigPath -ItemType File -Force | Out-Null
            $CloudflareApi = [pscustomobject]@{
                BaseUri  = $BaseUri ? $BaseUri : "https://api.cloudflare.com/client/v4"
                ApiToken = $ApiToken ? $ApiToken : $null
                ZoneId   = $ZoneId ? $ZoneId : $null
            }
        }
        else {
            $CloudflareApi = [pscustomobject]@{
                BaseUri  = $BaseUri ? $BaseUri : $CloudflareApi.BaseUri
                ApiToken = $ApiToken ? $ApiToken : $CloudflareApi.ApiToken
                ZoneId   = $ZoneId ? $ZoneId : $CloudflareApi.ZoneId
            }
            $global:CloudflareApi = $CloudflareApi
        }
        $CloudflareApi | ConvertTo-Json | Out-File -FilePath $ConfigPath -Force
    }
    catch {
        throw
    }
    return $CloudflareApi
}
