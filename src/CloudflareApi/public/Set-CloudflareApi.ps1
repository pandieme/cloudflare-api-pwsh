function Set-CloudflareApi(
    [Parameter()]
    [string]$ApiToken,

    [Parameter()]
    [string]$BaseUri
) {
    <#
    .SYNOPSIS
    Set CloudflareApi Configuration
    .DESCRIPTION
    Create config file in user profile if it doens't exist, or update it with updated values
    #>
    $ConfigPath = "~\.pwsh\CloudflareApi.json"

    try {
        if (!(Test-Path -Path $ConfigPath)) {
            New-Item -Path $ConfigPath -ItemType File -Force | Out-Null
            $CloudflareApi = [pscustomobject]@{
                BaseUri  = $BaseUri ? $BaseUri : "https://api.cloudflare.com/client/v4"
                ApiToken = $ApiToken ? $ApiToken : $null
            }
        }
        else {
            $CloudflareApi = Get-Content -Path $ConfigPath -Raw | ConvertFrom-Json
            $CloudflareApi = [pscustomobject]@{
                BaseUri  = $BaseUri ? $BaseUri : $CloudflareApi.BaseUri
                ApiToken = $ApiToken ? $ApiToken : $CloudflareApi.ApiToken
            }
        }
        $CloudflareApi | ConvertTo-Json | Out-File -FilePath $ConfigPath -Force
    }
    catch {
        throw
    }
    return $CloudflareApi
}
