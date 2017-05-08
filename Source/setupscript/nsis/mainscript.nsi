; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "VersionManagerTool"
!define PRODUCT_VERSION "1.0"
!define PRODUCT_PUBLISHER "GodimStudio"
!define PRODUCT_WEB_SITE "http://godimstudio.net"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\VersionManager.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor lzma

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE "..\..\..\..\lgpl-3.0.txt"
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\bin\VersionManager.exe"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\doc\Readme.txt"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; Reserve files
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "..\bin\VersionManagerTool.exe"
InstallDir "$PROGRAMFILES\VersionManagerTool"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "MainSection" SEC01
  SetOutPath "$INSTDIR\bin"
  SetOverwrite ifnewer
  File "..\..\..\bin\VersionManager.exe"
  CreateDirectory "$SMPROGRAMS\VersionManagerTool"
  CreateShortCut "$SMPROGRAMS\VersionManagerTool\VersionManagerTool.lnk" "$INSTDIR\bin\VersionManager.exe"
  CreateShortCut "$DESKTOP\VersionManagerTool.lnk" "$INSTDIR\bin\VersionManager.exe"
  SetOutPath "$INSTDIR\"
  File "output.folders\Readme.txt"
  File "output.folders\ChangeLog.txt"
  SetOutPath "$INSTDIR\doc"
  File "output.folders\doc\Readme.txt"
  SetOutPath "$INSTDIR\bin"
  File "..\..\..\..\..\dev\QT\5.0.0\msvc2010\5.0.0\msvc2010\bin\Qt5Gui.dll"
  File "..\..\..\..\..\dev\QT\5.0.0\msvc2010\5.0.0\msvc2010\bin\Qt5Core.dll"
SectionEnd

Section -AdditionalIcons
  SetOutPath $INSTDIR
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\VersionManagerTool\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\VersionManagerTool\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\bin\VersionManager.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\bin\VersionManager.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\bin\Qt5Core.dll"
  Delete "$INSTDIR\bin\Qt5Gui.dll"
  Delete "$INSTDIR\doc\Readme.txt"
  Delete "$INSTDIR\ChangeLog.txt"
  Delete "$INSTDIR\Readme.txt"
  Delete "$INSTDIR\bin\VersionManager.exe"

  Delete "$SMPROGRAMS\VersionManagerTool\Uninstall.lnk"
  Delete "$SMPROGRAMS\VersionManagerTool\Website.lnk"
  Delete "$DESKTOP\VersionManagerTool.lnk"
  Delete "$SMPROGRAMS\VersionManagerTool\VersionManagerTool.lnk"

  RMDir "$SMPROGRAMS\VersionManagerTool"
  RMDir "$INSTDIR\doc"
  RMDir "$INSTDIR\bin"
  RMDir "$INSTDIR\"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd