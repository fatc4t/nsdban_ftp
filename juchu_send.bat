::---------------------------------------------
:: NSDVAN 受注データ送信
::
::　開発者： KARL(2022/12)
::
::---------------------------------------------

@echo off
@echo off

::SET LOGFILE & LOGPATH
SET BATLOGFILE=%~dp0log\juchu_send.log
SET BATLOGTEMP=%~dp0log\juchu_send_tmp.log
SET yyyyMMdd=%date:/=%
SET hhmmss=%time: =0%
SET hhmmss=%hhmmss:~0,2%%hhmmss:~3,2%%hhmmss:~6,2%

@rem ====================================
rem Notice start
@rem ====================================



rem ----------------------------------------------------------------------------------
rem IP host 疎通OKの場合(ファイル存在確認)
rem ----------------------------------------------------------------------------------
if not exist %~dp0\send\JUCHU.102 (
echo -----NO FILE
goto error2
)


@rem ====================================
@rem 処理開始時間 定義
@rem ====================================
echo ------------------------------------ >> %BATLOGFILE% 2>&1
echo  %yyyyMMdd%_%hhmmss%処理開始         >> %BATLOGFILE% 2>&1

@rem ====================================
@rem FTP実行
@rem ====================================

set COMPCOUNT=0
rem pause
:: CONFファイルをアクセスする

ftp -s:%~dp0conf\juchu_send.conf  > %BATLOGTEMP% 2>&1

rem pause


for /f "delims=" %%a in (%BATLOGTEMP%) do (
  echo %%a >> %BATLOGFILE% 2>&1
  echo "%%a" | find "%200 COMPLETED.%" >NUL
  if not ERRORLEVEL 1 set /a COMPCOUNT=COMPCOUNT+1
)

@rem ====================================
@rem 送信ファイルを履歴フォルダへ移動
@rem ====================================
echo %COMPCOUNT%



@rem ファイルコピー
mkdir %~dp0juchu_send_filelog\%yyyyMMdd%_%hhmmss%
move  %~dp0send\JUCHU.102 %~dp0juchu_send_filelog\%yyyyMMdd%_%hhmmss%\
  


@rem ====================================
@rem 処理終了時間 定義
@rem ====================================
rem pause

SET yyyyMMdd=%date:/=%
SET hhmmss=%time: =0%
SET hhmmss=%hhmmss:~0,2%%hhmmss:~3,2%%hhmmss:~6,2%
echo %yyyyMMdd%_%hhmmss%処理終了          >> %BATLOGFILE% 2>&1
echo ------------------------------------ >> %BATLOGFILE% 2>&1
rem pause

@rem ====================================
@rem 終了
@rem ====================================
EXIT


rem ----------------------------------------------------------------------------------
rem IP host 疎通NGの場合
rem ----------------------------------------------------------------------------------
:errorout
EXIT

rem ----------------------------------------------------------------------------------
rem ファイルが存在しない場合
rem ----------------------------------------------------------------------------------
:error2
EXIT