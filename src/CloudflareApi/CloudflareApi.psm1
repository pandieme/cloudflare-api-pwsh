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

$ConfigPath = "~\.pwsh\CloudflareApi.json"

if (!(Test-Path -Path $ConfigPath)) {
    $CloudflareApi = Set-CloudflareApi
}
else {
    $CloudflareApi = Get-Content -Path $ConfigPath -Raw | ConvertFrom-Json
}

Export-ModuleMember -Function $PublicFunctions -Variable "CloudflareApi"
