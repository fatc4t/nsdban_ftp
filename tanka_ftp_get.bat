@echo off

SET BATLOGFILE=%~dp0log\tanka_ftp_get.log
SET BATLOGTEMP=%~dp0log\tanka_ftp_get_tmp.log
SET yyyyMMdd=%date:/=%
SET hhmmss=%time: =0%
SET hhmmss=%hhmmss:~0,2%%hhmmss:~3,2%%hhmmss:~6,2%

@rem ====================================
@rem 処理開始時間 定義
@rem ====================================
echo ------------------------------------ >> %BATLOGFILE% 2>&1
echo  %yyyyMMdd%_%hhmmss%処理開始         >> %BATLOGFILE% 2>&1

@rem ====================================
@rem 出力先フォルダ作成
@rem ====================================
mkdir %~dp0out\TNKINF\%yyyyMMdd%_%hhmmss%
cd    %~dp0out\TNKINF\%yyyyMMdd%_%hhmmss%

@rem ====================================
@rem FTP実行
@rem ====================================

set COMPCOUNT=0

ftp -s:..\..\..\conf\tanka_ftp_get.conf  > %BATLOGTEMP% 2>&1

for /f "delims=" %%a in (%BATLOGTEMP%) do (
  echo %%a >> %BATLOGFILE% 2>&1
  echo "%%a" | find "%200 COMPLETED.%" >NUL
  if not ERRORLEVEL 1 set /a COMPCOUNT=COMPCOUNT+1
)

copy ".\tanka.102" "..\..\..\ftp_recieve\"  >> %BATLOGFILE% 2>&1
  

@rem ====================================
@rem 処理終了時間 定義
@rem ====================================
SET yyyyMMdd=%date:/=%
SET hhmmss=%time: =0%
SET hhmmss=%hhmmss:~0,2%%hhmmss:~3,2%%hhmmss:~6,2%
echo %yyyyMMdd%_%hhmmss%処理終了 >> %BATLOGFILE% 2>&1
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