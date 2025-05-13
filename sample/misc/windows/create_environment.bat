@echo off
setlocal enabledelayedexpansion

REM create_environment.bat の親ディレクトリに移動する
for %%i in (.) do set "CURRENT_DIR=%%~fi"
for %%i in ("%~dp0.") do set "SCRIPT_DIR=%%~fi"

echo "%CURRENT_DIR%" == "%ENVIRONMENT_DIR%"
if not "%CURRENT_DIR%" == "%ENVIRONMENT_DIR%" (
    echo $'\n'"***" MOVE CURRENT DIR : %CURRENT_DIR% -> %ENVIRONMENT_DIR%"***"$'\n'
    cd %ENVIRONMENT_DIR%
)


@REM REM Pythonがインストールされているかどうか確認する
@REM where python > nul
@REM if %errorlevel% neq 0 (
@REM   echo Python is not installed. Please install Python and try again.
@REM   exit /b 1
@REM )


@REM REM Pythonの場所を自動的に取得する
@REM for /f "usebackq tokens=*" %%i in (`where python`) do (
@REM     for %%a in (%%i\..) do (
@REM         if not "%%~na" == "WindowsApps" (
@REM             set "PYTHON_PATH=%%~i"
@REM             goto :PythonPathFound
@REM         )
@REM     )
@REM )
@REM :PythonPathFound

@REM REM Pythonのバージョンを確認する
@REM %PYTHON_PATH% -c "import sys; sys.exit(1 if sys.version_info.major < 3 else 0)"

@REM REM pip を最新のものに更新する
@REM %PYTHON_PATH% -m pip install --upgrade pip

@REM REM requirement.txtが存在するかどうか確認する
@REM set "REQUIREMENT_FILE=%cd%\requirements.txt"
@REM if not exist "%REQUIREMENT_FILE%" (
@REM   echo %REQUIREMENT_FILE% not found. Please create requirement.txt and try again.
@REM   exit /b 2
@REM )

@REM REM Pythonのバージョンに関してのエラーレベルを取得する
@REM if %ERRORLEVEL% == 0 (
@REM   REM Python 3.xの場合の処理
@REM   set "VENV_DIR=%cd%\myenv"
@REM   %PYTHON_PATH% -m venv %VENV_DIR%
@REM   call %VENV_DIR%\Scripts\activate.bat
@REM   pip install -r %REQUIREMENT_FILE%
@REM   deactivate
@REM ) else (
@REM   REM Python 2.xの場合の処理
@REM   set "VENV_DIR=%cd%\myenv"
@REM   %PYTHON_PATH% -m pip install virtualenv
@REM   virtualenv %VENV_DIR%
@REM   call %VENV_DIR%\Scripts\activate.bat
@REM   pip install -r %REQUIREMENT_FILE%
@REM   deactivate
@REM )
