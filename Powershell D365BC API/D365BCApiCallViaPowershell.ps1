Install-Module BurntToast

$user = 'YourD365BCUser';
$wsKey = 'YourD365BCWebServiceAccessKey';
$tenantID= 'YourTenantID';
$companyId = 'YourCompanyID';

$credentials = "$($user):$($wsKey)"
$encodedCredentials = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($credentials))
$headers = @{ Authorization = "Basic $encodedCredentials" }

$url = "https://api.businesscentral.dynamics.com/v2.0/" + $tenantID + "/production/api/v1.0/companies(" + $companyId + ")/customers";

$jsonResponse = Invoke-RestMethod -Uri $url -Method GET -Headers $headers | ConvertTo-Json | ConvertFrom-Json

$toastParams = @{
    Text = "Customers retrieved from Dynamics 365 Business Central and data saved on CSV file"
    Header = (New-BTHeader -Id 1 -Title "D365BC API Call from Powershell")
    AppLogo = "C:\YourLogo.PNG"
}


Write-Host "Number of Customers retrieved: " $jsonResponse.value.Count

foreach ($cust in $jsonResponse.value)
{
    Write-Host "$($cust.number) - $($cust.displayName)"    
}

#Save CSV file
$file = "C:\TEMP\data.csv"
$jsonResponse.value | Select number,displayName | ConvertTo-CSV -NoTypeInformation | Out-File $file

#Display a toast notification to the user
New-BurntToastNotification @toastParams