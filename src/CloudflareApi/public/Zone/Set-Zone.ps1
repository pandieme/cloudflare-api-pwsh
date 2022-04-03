function Set-Zone(
    [Parameter(Mandatory)]
    [string]
    $Name
) {
    <#
        .SYNOPSIS
        Set the active zone in module config
    #>
    try {
        if (!($ZoneRecord = Get-Zone -Name $Name))
        {
            return $null
        }

        $Response = Set-CloudflareApi -ZoneId $ZoneRecord.id
    }
    catch {
        throw
    }
    return $Response
}