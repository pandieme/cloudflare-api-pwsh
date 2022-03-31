BeforeAll {
    . $PSCommandPath.Replace(".Tests.ps1", ".ps1").Replace("tests", "src")
}

Describe -Name 'Test-ApiToken' {
    BeforeAll {
        $ApiToken = 'wxnfS4gF3T1AO2YCcO6NShE4o3DT8Ix8dcDYXKVW'
        $BaseUri = 'https://api.cloudflare.com/client/v4'
    }

    It -Name 'Valid token' {
        Test-ApiToken -BaseUri $BaseUri -ApiToken $ApiToken | Should -Be $true
    }

    It -Name 'Invalid token' {
        Test-ApiToken -BaseUri $BaseUri -ApiToken 'randomgibberish' | Should -Be $false
    }
}