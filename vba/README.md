# VBA Macro GPO Testing

This folder is for practical activities that test Microsoft Office macro controls using Windows Group Policy.

The lab scenario uses:

- a Windows Server domain controller to configure Group Policy
- a Windows client joined to the domain
- Microsoft Word or Excel on the Windows client
- VBA, which stands for Microsoft Visual Basic for Applications

The goal is to test how macro-related GPO settings affect Office documents in a controlled lab environment.

## Install Microsoft Office for Testing

Microsoft Office desktop applications are required for the practical activities. The commands below install Word and Excel using the Office Deployment Tool.

This is suitable for a temporary VM lab. The Office trial can be reset by reverting to a clean VM snapshot.

Run the following commands in PowerShell as Administrator on the Windows client:

```powershell
mkdir C:\OfficeInstall
cd C:\OfficeInstall

# Dynamically find the current Office Deployment Tool download URL from Microsoft.
$Page = Invoke-WebRequest -Uri "https://www.microsoft.com/en-us/download/details.aspx?id=49117" -UseBasicParsing
$Url = ($Page.Links | Where-Object { $_.href -match "officedeploymenttool.*\.exe" }).href

# Download and extract the Office Deployment Tool.
Invoke-WebRequest -Uri $Url -OutFile "odt.exe"
.\odt.exe /extract:C:\OfficeInstall /quiet

# Create a deployment configuration for Microsoft 365 Apps.
'<Configuration><Add OfficeClientEdition="64" Channel="Current"><Product ID="O365ProPlusRetail"><Language ID="en-us" /></Product></Add><Display Level="None" AcceptEULA="TRUE" /></Configuration>' | Out-File -FilePath .\configuration.xml -Encoding ascii

# Install Office in the background.
.\setup.exe /configure .\configuration.xml
```

## Installation Notes

- You can check installation progress in Task Manager by looking for `Microsoft Office Click-to-Run`.
- When Word or Excel first opens and shows a sign-in screen, press `Esc` to skip sign-in for the lab.
- If the Windows Server or Windows client VM restarts during installation because of the Windows evaluation period, the Office installation should resume automatically.

## Suggested GPO Test Flow

1. Configure the macro policy on the Windows Server domain controller.
2. Apply the policy to the Windows client using `gpupdate /force`.
3. Open Word or Excel on the Windows client.
4. Create or open a document containing a simple VBA macro.
5. Confirm whether the macro is blocked, allowed, or shown with a warning.
6. Record the policy setting and the observed Office behavior.
