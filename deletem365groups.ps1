# Path to the input Excel file
$InputFilePath = "C:\Input\GroupsToDelete.xlsx"

# Authenticate to Microsoft Graph
Connect-MgGraph -Scopes "Group.ReadWrite.All"

# Read the Excel file
$GroupsToDelete = Import-Excel -Path $InputFilePath

if (-not $GroupsToDelete) {
    Write-Host "No data found in the Excel file. Ensure it has a 'GroupEmail' column." -ForegroundColor Yellow
    exit
}

Write-Host "Resolving group email addresses to IDs and deleting groups..." -ForegroundColor Cyan

foreach ($Group in $GroupsToDelete) {
    $GroupEmail = $Group.GroupEmail

    if ([string]::IsNullOrWhiteSpace($GroupEmail)) {
        Write-Host "Skipping entry with empty GroupEmail." -ForegroundColor Yellow
        continue
    }

    try {
        # Get the group by email
        $GroupDetails = Get-MgGroup -Filter "mail eq '$GroupEmail'" -ErrorAction Stop
        $GroupId = $GroupDetails.Id

        if ($GroupId) {
            # Delete the group
            Remove-MgGroup -GroupId $GroupId -Confirm:$false
            Write-Host "Successfully deleted group with email: $GroupEmail (ID: $GroupId)" -ForegroundColor Green
        } else {
            Write-Host "No group found for email: $GroupEmail" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "Failed to delete group with email: $GroupEmail. Error: $_" -ForegroundColor Red
    }
}

Write-Host "Group deletion process completed." -ForegroundColor Cyan
