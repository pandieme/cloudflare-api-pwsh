function Get-CloudflareApi(
    [Parameter()]
    [string]
    $ConfigPath = "~\.pwsh\CloudflareApi.json"
) {
    <#
        .SYNOPSIS
        Get Cloudflare API configuration
    #>

    $ErrorActionPreference = "Stop"

    try {
        $CloudflareApi = Get-Content -Path $ConfigPath -Raw | ConvertFrom-Json
    }
    catch [System.Management.Automation.ItemNotFoundException] {
        # File was not found
        return $null
    }
    catch {
        throw
    }
    return $CloudflareApi
}
