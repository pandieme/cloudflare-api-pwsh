$PublicFunctions = @()
@(
    "$PSScriptRoot/public"
    "$PSScriptRoot/private"
) | ForEach-Object {
    if (Test-Path -Path $_) {
        Get-ChildItem -Path $_ -Filter "*.ps1" | `
            ForEach-Object {
            if ($_ -match 'public') {
                $PublicFunctions += $_.BaseName
            }
            . $_.FullName
        }
    }
}

$CloudflareApi = [pscustomobject]@{
    BaseUri = "https://api.cloudflare.com/client/v4"
}

Export-ModuleMember -Function $PublicFunctions -Variable "CloudflareApi"
