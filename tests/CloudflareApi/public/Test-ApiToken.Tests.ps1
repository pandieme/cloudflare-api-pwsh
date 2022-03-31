BeforeAll {
    . $PSCommandPath.Replace(".Tests.ps1", ".ps1").Replace("tests", "src")
}

Describe -Name 'Test-ApiToken' {
    It -Name 'Valid token' {
        Test-ApiToken | Should -Be $true
    }

    It -Name 'Invalid token' {
        Test-ApiToken -ApiToken 'randomgibberish' | Should -Be $false
    }
}