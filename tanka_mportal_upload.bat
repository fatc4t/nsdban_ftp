@echo off

SET BATLOGFILE=%~dp0log\tanka_mportal_upload.log
SET BATLOGTEMP=%~dp0log\tanka_mportal_upload_tmp.log
SET yyyyMMdd=%date:/=%
SET hhmmss=%time: =0%
SET hhmmss=%hhmmss:~0,2%%hhmmss:~3,2%%hhmmss:~6,2%

@rem ====================================
rem Notice start
@rem ====================================

rem ----------------------------------------------------------------------------------
rem IP host 疎通確認
rem ----------------------------------------------------------------------------------
set COUNT=0
:error
set /a COUNT=COUNT+1
if "%COUNT%" == "1200" goto errorout
echo %COUNT%
ping -n 1 -w 1 133.242.228.107 | find "ms TTL=" > NUL
if ERRORLEVEL 1 goto error


rem ----------------------------------------------------------------------------------
rem IP host 疎通OKの場合
rem ----------------------------------------------------------------------------------


@rem ====================================
@rem 処理開始時間 定義
@rem ====================================
echo ------------------------------------ >> %BATLOGFILE% 2>&1
echo  %yyyyMMdd%_%hhmmss%処理開始         >> %BATLOGFILE% 2>&1

@rem ====================================
@rem FTP実行
@rem ====================================
"C:\Users\81803\AppData\Local\Programs\WinSCP\WinSCP.com"  /console /script="C:\Users\81803\デスクトップ\nsdban_ftp\conf\tanka_mportal_upload.conf" >> %BATLOGFILE% 2>&1


@rem ====================================
@rem 処理終了時間 定義
@rem ====================================
SET yyyyMMdd=%date:/=%
SET hhmmss=%time: =0%
SET hhmmss=%hhmmss:~0,2%%hhmmss:~3,2%%hhmmss:~6,2%
echo %yyyyMMdd%_%hhmmss%処理終了          >> %BATLOGFILE% 2>&1
echo ------------------------------------ >> %BATLOGFILE% 2>&1

@rem ====================================
@rem 終了
@rem ====================================
EXIT


rem ----------------------------------------------------------------------------------
rem IP host 疎通NGの場合
rem ----------------------------------------------------------------------------------
:errorout
EXIT