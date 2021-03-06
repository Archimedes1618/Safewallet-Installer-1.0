
#define MyAppName "Safewallet"
#define MyAppVersion "VERSION_NR" 
; change with every new release
#define MyAppPublisher "Safecoin"
#define MyAppURL "https://www.safecoin.org/"
#define MyAppExeName "Safewallet.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{F7BEFFF8-F954-4F33-BD1E-EBA8FB838EF8}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
LicenseFile=
InfoBeforeFile=
InfoAfterFile=
OutputDir=OUTPUT_DIRECTORY
; set an output directory
OutputBaseFilename=Safewallet-Setup
SetupIconFile=APPICONFOLDER\safewallet_app_icon.ico
; set correct path for icon
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\SAFEWALLET_SOURCE_DIRECTORY\Safewallet.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\SAFEWALLET_SOURCE_DIRECTORY\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; Add the ISSkin DLL used for skinning Inno Setup installations. 
; download ISSkin here: http://isskin.codejock.com/
Source: C:\Program Files (x86)\Codejock Software\ISSkin\ISSkin.dll; DestDir: {app}; Flags: dontcopy

; Add the Visual Style resource contains resources used for skinning,
; you can also use Microsoft Visual Styles (*.msstyles) resources.
Source: C:\Program Files (x86)\Codejock Software\ISSkin\Styles\smpldrk.msstyles; DestDir: {tmp}; Flags: dontcopy
; Download smpldrk mini suite here: https://bernadinho.deviantart.com/art/smpldrk-mini-suite-67085228
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Code]
// Importing LoadSkin API from ISSkin.DLL
procedure LoadSkin(lpszPath: String; lpszIniFileName: String);
external 'LoadSkin@files:isskin.dll stdcall';

// Importing UnloadSkin API from ISSkin.DLL
procedure UnloadSkin();
external 'UnloadSkin@files:isskin.dll stdcall';

// Importing ShowWindow Windows API from User32.DLL
function ShowWindow(hWnd: Integer; uType: Integer): Integer;
external 'ShowWindow@user32.dll stdcall';

function InitializeSetup(): Boolean;
begin
  ExtractTemporaryFile('smpldrk.msstyles');
  LoadSkin(ExpandConstant('{tmp}\smpldrk.msstyles'), '');
  Result := True;
end; 

procedure DeinitializeSetup();
begin
  // Hide Window before unloading skin so user does not get
  // a glimpse of an unskinned window before it is closed.
  ShowWindow(StrToInt(ExpandConstant('{wizardhwnd}')), 0);
  UnloadSkin();
end; 
