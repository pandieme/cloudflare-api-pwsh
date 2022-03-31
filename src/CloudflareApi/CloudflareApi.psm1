@(
    "$PSScriptRoot/public"
    "$PSScriptRoot/private"
) | ForEach-Object {
    if (Test-Path -Path $_) {
        Get-ChildItem -Path $_ -Filter "*.ps1" | `
            ForEach-Object {
            . $_.FullName
        }
    }
}
