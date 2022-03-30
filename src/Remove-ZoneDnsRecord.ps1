function Remove-ZoneDnsRecord(
    [Parameter(Mandatory)]
    [string]$ApiToken,

    [Parameter(Mandatory)]
    [string]$ZoneId,

    [Parameter(Mandatory)]
    [string]$Name
) {
    <#
    .SYNOPSIS
    Delete a DNS record within a zone
    #>

    $Headers = @{
        'Authorization' = "Bearer $ApiToken"
        'Content-Type'  = "application/json"
    }

    try {
        $DnsRecord = Get-ZoneDnsRecord `
            -ApiToken $ApiToken `
            -ZoneId $ZoneId `
            -Name $Name

        if (!$DnsRecord) {
            $Result = [pscustomobject] @{
                Message = "Record does not exist. No action taken."
                Content = [pscustomobject] @{
                    Name = $Name
                }
            }
        }
        else {
            $Uri = $Config.RootUri + "/zones/$ZoneId/dns_records/" + $DnsRecord.id

            $Response = Invoke-RestMethod `
                -Method Delete `
                -Uri $Uri `
                -Headers $Headers `

            $Result = [pscustomobject] @{
                Message = "Record deleted!"
                Content = $Response
            }
        }
    }
    catch {
        throw
    }

    return $Result
}
