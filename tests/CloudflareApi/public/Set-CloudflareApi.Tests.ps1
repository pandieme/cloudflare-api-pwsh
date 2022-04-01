BeforeAll {
    . $PSCommandPath.Replace(".Tests.ps1", ".ps1").Replace("tests", "src")
}

Describe -Name 'Set-CloudflareApi' {
    BeforeAll {
        $ConfigPath = "TestDrive:\.pwsh\CloudflareApi.json"
        $BaseUri = "https://api.cloudflare.com/client/v4"
        Set-CloudflareApi -ConfigPath $ConfigPath
    }

    It -Name 'Contain BaseUri' {
        $ConfigPath | Should -FileContentMatch "`"BaseUri`": `"$BaseUri`""
    }

    It -Name 'Contains null ZoneId' {
        $ConfigPath | Should -FileContentMatch "`"ZoneId`": null"
    }

    It -Name "Contains null ApiToken" {
        $ConfigPath | Should -FileContentMatch "`"ApiToken`": null"
    }

    AfterAll {
        Set-CloudflareApi
    }
}