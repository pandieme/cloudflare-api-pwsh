$PublicFunctions = @()
@(
    "$PSScriptRoot/public"
    "$PSScriptRoot/private"
) | ForEach-Object {
    if (Test-Path -Path $_) {
        Get-ChildItem -Path $_ -Filter "*.ps1" -Recurse | `
            ForEach-Object {
            if ($_ -match 'public') {
                $PublicFunctions += $_.BaseName
            }
            . $_.FullName
        }
    }
}

$CloudflareApi = Set-CloudflareApi

Export-ModuleMember -Function $PublicFunctions -Variable "CloudflareApi"
