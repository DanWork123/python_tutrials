@echo off
setlocal enabledelayedexpansion

REM Pythonがインストールされているかどうか確認する
where python > nul
if %errorlevel% neq 0 (
  echo Python is not installed. Please install Python and try again.
  exit /b 1
)


REM Pythonの場所を自動的に取得する
for /f "usebackq tokens=*" %%i in (`where python`) do (
    for %%a in (%%i\..) do (
        if not "%%~na" == "WindowsApps" (
            set "PYTHON_PATH=%%~i"
            goto :PythonPathFound
        )
    )
)
:PythonPathFound


REM Pythonのバージョンを確認する
%PYTHON_PATH% -c "import sys; sys.exit(1 if sys.version_info.major < 3 else 0)"

REM pip を最新のものに更新する
%PYTHON_PATH% -m pip install --upgrade pip

REM requirement.txtが存在するかどうか確認する
set "REQUIREMENT_FILE=%cd%\requirements.txt"
if not exist "%REQUIREMENT_FILE%" (
  echo %REQUIREMENT_FILE% not found. Please create requirement.txt and try again.
  exit /b 2
)

REM Pythonのバージョンに関してのエラーレベルを取得する
if %ERRORLEVEL% == 0 (
  REM Python 3.xの場合の処理
  set "VENV_DIR=%cd%\myenv"
  %PYTHON_PATH% -m venv %VENV_DIR%
  call %VENV_DIR%\Scripts\activate.bat
  pip install -r %REQUIREMENT_FILE%
  deactivate
) else (
  REM Python 2.xの場合の処理
  set "VENV_DIR=%cd%\myenv"
  %PYTHON_PATH% -m pip install virtualenv
  virtualenv %VENV_DIR%
  call %VENV_DIR%\Scripts\activate.bat
  pip install -r %REQUIREMENT_FILE%
  deactivate
)
