@echo off
title Instalador Links HETO
echo ========================================
echo   INSTALADOR AUTOMATICO - LINKS HETO
echo ========================================
echo.

:: ============================================
:: 1. VERIFICA/INSTALA PYTHON
:: ============================================
python --version >nul 2>&1
if errorlevel 1 (
    echo [INFO] Python nao encontrado. Baixando e instalando...
    echo.
    
    curl -o python_installer.exe https://www.python.org/ftp/python/3.11.8/python-3.11.8-amd64.exe
    echo Instalando Python (isso pode levar alguns minutos)...
    start /wait python_installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
    del python_installer.exe
    echo Python instalado com sucesso!
    echo.
) else (
    echo [OK] Python ja instalado!
    echo.
)

:: ============================================
:: 2. CRIA PASTA E COPIA ARQUIVOS
:: ============================================
set INSTALL_DIR=%USERPROFILE%\LinksHETO
echo [1] Criando pasta: %INSTALL_DIR%
mkdir "%INSTALL_DIR%" 2>nul

echo [2] Copiando arquivos...
xcopy /E /I /Y "%CD%" "%INSTALL_DIR%" >nul
cd /d "%INSTALL_DIR%"

:: ============================================
:: 3. CRIA VENV E INSTALA FLASK
:: ============================================
echo [3] Criando ambiente virtual...
python -m venv venv

echo [4] Instalando Flask no venv...
call venv\Scripts\activate
pip install flask
deactivate

:: ============================================
:: 4. CRIA ARQUIVO PARA INICIAR
:: ============================================
echo [5] Configurando inicializacao automatica...

(
echo @echo off
echo cd /d "%INSTALL_DIR%"
echo call venv\Scripts\activate
echo start python app.py
echo exit
) > "%INSTALL_DIR%\iniciar.bat"

:: ============================================
:: 5. ADICIONA AO STARTUP DO WINDOWS
:: ============================================
set STARTUP_DIR=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup

(
echo Set WshShell = CreateObject("WScript.Shell")
echo Set oShellLink = WshShell.CreateShortcut("%STARTUP_DIR%\LinksHETO.lnk")
echo oShellLink.TargetPath = "%INSTALL_DIR%\iniciar.bat"
echo oShellLink.WindowStyle = 7
echo oShellLink.Save
) > "%TEMP%\criar_atalho.vbs"

cscript "%TEMP%\criar_atalho.vbs"
del "%TEMP%\criar_atalho.vbs"

:: ============================================
:: 6. FINALIZA
:: ============================================
echo.
echo ========================================
echo   INSTALADO COM SUCESSO!
echo ========================================
echo.
echo Pasta: %INSTALL_DIR%
echo O programa vai iniciar com o Windows.
echo.
echo Para iniciar agora, execute:
echo %INSTALL_DIR%\iniciar.bat
echo.
pause