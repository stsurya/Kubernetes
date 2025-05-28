$var = Get-AzAutomationVariable -AutomationAccountName $automationAccountName `
    -ResourceGroupName $resourceGroup `
    -Name $environmentVariable  -ErrorAction SilentlyContinue
 
if ($null -eq $var) {
    New-AzAutomationVariable -AutomationAccountName $automationAccountName `
        -ResourceGroupName $resourceGroup `
        -Name $environmentVariable  `
        -Value $env  `
        -Encrypted $false
}
else {
    Set-AzAutomationVariable -AutomationAccountName $automationAccountName `
        -ResourceGroupName $resourceGroup `
        -Name $environmentVariable `
        -Value $env
}