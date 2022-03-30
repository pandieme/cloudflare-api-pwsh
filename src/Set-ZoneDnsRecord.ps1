function Set-ZoneDnsRecord(
    [Parameter(Mandatory)]
    [string]$ApiToken,

    [Parameter(Mandatory)]
    [string]$ZoneId,

    [Parameter(Mandatory)]
    [string]$Id,

    [string]$Name,

    [ValidateSet('A', 'CNAME')]
    [string]$Type,

    [string]$Content,

    [bool]$Proxied
) {
    <#
    .SYNOPSIS
    Change a DNS record within a zone
    #>

    $Headers = @{
        'Authorization' = "Bearer $ApiToken"
        'Content-Type'  = "application/json"
    }

    $Uri = $Config.RootUri + "/zones/$ZoneId/dns_records/$Id"

    $Body = [pscustomobject]@{
        type    = $Type ? $Type : $null
        name    = $Name ? $Name : $null
        content = $Content ? $Content : $null
        proxied = $Proxied ? $Proxied : $null
    } | ConvertTo-Json

    try {
        $Result = Invoke-RestMethod `
            -Method Patch `
            -Uri $Uri `
            -Headers $Headers `
            -Body $Body
    }
    catch {
        throw
    }
    return $Result.result
}
