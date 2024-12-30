# Microsoft 365 Group Deletion Script

This PowerShell script automates the deletion of Microsoft 365 groups by reading group email addresses from an Excel file. It uses the Microsoft Graph PowerShell SDK to identify and delete groups, logging the results for each processed entry.

## Features

- **Bulk Group Deletion**:  
  Reads group email addresses from an Excel file and deletes the corresponding Microsoft 365 groups.

- **Error Handling and Logging**:  
  Provides color-coded console messages for successful deletions, warnings, and errors.

- **Non-Interactive Execution**:  
  Uses the `-Confirm:$false` parameter to delete groups without confirmation prompts.

## Prerequisites

1. Install the Microsoft Graph PowerShell SDK:
   ```powershell
   Install-Module -Name Microsoft.Graph -Scope CurrentUser
2. Install the ImportExcel module:
   ```powershell
   Install-Module -Name ImportExcel -Scope CurrentUser
