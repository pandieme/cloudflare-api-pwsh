function Format-Query(
    [Parameter(Mandatory)]
    [hashtable]
    $Table
) {
    <#
        .SYNOPSIS
        Format URI query
        .DESCRIPTION
        Take a hashtable and format as a URI query string
    #>
    $Query = @()
    $Table.GetEnumerator() | ForEach-Object {
        $Query += ($_.Key + "=" + $_.Value)
    }
    return $Query | Join-String -Property $_ -Separator "&" -OutputPrefix "?"
}
