# VBA Macro GPO Testing

This folder is for practical activities that test Microsoft Office macro controls using Windows Group Policy.

The lab scenario uses:

- a Windows Server domain controller to configure Group Policy
- a Windows client joined to the domain
- Microsoft Word or Excel on the Windows client
- VBA, which stands for Microsoft Visual Basic for Applications

The goal is to test how macro-related GPO settings affect Office documents in a controlled lab environment.

## 1. Install Office on the Windows Client
Microsoft Office desktop applications are required for the practical activities. The commands below install `Office 365 ProPlus` using the Office Deployment Tool; it will be a trial for 5 days if not activated.
This is suitable for a temporary VM lab. The Office trial can be reset by reverting to a clean VM snapshot.

Run PowerShell as Administrator:

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
'<Configuration><Add OfficeClientEdition="64" Channel="Current"><Product ID="O365ProPlusRetail"><Language ID="en-us" /></Product></Add><Display Level="Full" AcceptEULA="TRUE" /></Configuration>' | Out-File -FilePath .\configuration.xml -Encoding ascii

# Install Office in the background.
.\setup.exe /configure .\configuration.xml
```

You can check installation progress in Task Manager by looking for `Microsoft Office Click-to-Run`.

In a few seconds, the command launches the large Microsoft installation window directly in the center of your screen, and it also triggers that precise status notification popup down in the bottom right corner right next to your system clock.

When Word or Excel first opens, press `Esc` to skip sign-in.

## 2. Use the Excel Macro Test File

Use the test file located in the same folder as this README:

[VBA-Macro-GPO-Test.xlsm](./VBA-Macro-GPO-Test.xlsm)


1. Open `VBA-Macro-GPO-Test.xlsm` on the Windows client.
2. Click the macro test button.
3. Confirm the macro works before applying GPO.

## 3. Install Office ADMX Templates on the Server

1. Download Office Administrative Templates:

```text
https://www.microsoft.com/en-us/download/details.aspx?id=49030
```

2. Run the downloaded installer.
3. Extract the files, for example to:

```text
C:\New folder
```

4. Copy these files:

```text
C:\New folder\admx\*.admx
```

to:

```text
C:\Windows\PolicyDefinitions
```

5. Copy these files:

```text
C:\New folder\admx\en-US\*.adml
```

to:

```text
C:\Windows\PolicyDefinitions\en-US
```

6. Close and reopen Group Policy Management Editor.

## 4. Create and Link the GPO

1. On the server, open:

```text
Group Policy Management
```

2. Right-click the domain, for example:

```text
e8.lab
```

3. Click:

```text
Create a GPO in this domain, and Link it here
```

4. Name it:

```text
Office Macro Settings
```

5. If the GPO already exists under **Group Policy Objects**, right-click the domain and choose:

```text
Link an Existing GPO
```

6. Select:

```text
Office Macro Settings
```

7. Click **OK**.

## 5. Configure Excel Macro Blocking

1. Right-click the GPO:

```text
Office Macro Settings
```

2. Click:

```text
Edit
```

3. Go to:

```text
User Configuration > Policies > Administrative Templates > Microsoft Excel 2016 > Excel Options > Security > Trust Center
```

4. Open:

```text
Macro Notification Settings
```

5. Set it to:

```text
Enabled
```

6. Select:

```text
Disable VBA macros without notification
```

7. Leave these unticked:

```text
Enable Excel 4.0 macros when VBA macros are enabled
Require macros to be signed by a trusted publisher
Block certificates from trusted publishers that are only installed in the current user certificate store
Require Extended Key Usage (EKU) for certificates from trusted publishers
```

8. Click **Apply**.
9. Click **OK**.
10. Open:

```text
Block macros from running in Office files from the internet
```

11. Set it to:

```text
Enabled
```

12. Click **Apply**.
13. Click **OK**.
14. Open:

```text
Turn off trusted documents
```

15. Set it to:

```text
Enabled
```

16. Click **Apply**.
17. Click **OK**.
18. Open:

```text
Turn off Trusted Documents on the network
```

19. Set it to:

```text
Enabled
```

20. Click **Apply**.
21. Click **OK**.

## 6. Apply the GPO on the Client

Log in as the standard domain user and run:

```powershell
gpupdate /force
```

Then:

1. Sign out.
2. Sign back in.
3. Open the `.xlsm` test file.
4. Click the macro button.

Expected result:

```text
BLOCKED CONTENT
Cannot run the macro
```

The GPO is working if Excel blocks the macro.

## 7. Test Trusted Location Bypass and Block It

First, test how a user can bypass the macro block:

1. On the Windows client, open Excel.
2. Go to:

```text
File > Options > Trust Center > Trust Center Settings > Trusted Locations
```

3. Click:

```text
Add new location
```

4. Add the folder that contains:

```text
VBA-Macro-GPO-Test.xlsm
```

5. Click **OK**.
6. Reopen `VBA-Macro-GPO-Test.xlsm`.
7. Click the macro test button.

Expected result:

```text
The macro runs again.
```

To prevent this bypass, configure these GPO settings:

```text
User Configuration > Policies > Administrative Templates > Microsoft Excel 2016 > Excel Options > Security > Trust Center > Trusted Locations
```

Set:

```text
Disable all trusted locations = Enabled
Allow Trusted Locations on the network = Disabled
```

Then go to:

```text
User Configuration > Policies > Administrative Templates > Microsoft Excel 2016 > Excel Options > Security > Trust Center
```

Set:

```text
Turn off trusted documents = Enabled
Turn off Trusted Documents on the network = Enabled
```

On the client, run:

```powershell
gpupdate /force
```

Then:

1. Sign out.
2. Sign back in.
3. Open `VBA-Macro-GPO-Test.xlsm`.
4. Ask the student to try the macro again.
5. Ask the student to check Excel Trusted Locations.

Expected result:

```text
The macro is blocked.
Trusted Locations settings are grayed out.
Trusted Documents cannot be used to bypass the macro block.
```
