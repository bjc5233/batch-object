@echo off
::˵��
::  У��batch�����������
::����
::  [paramCount] [objMethod] [realParam...]
::      paramCount - ��������
::      objMethod - ���󷽷���
::      realParam - ���󷽷����������
::external
::  date       2018-01-03 16:35:21
::  face       (>_<)
::  weather    С��ת���� 9��/5�� ������
if "%1"=="" (call :errorMsg "paramCount NOT DEFINED") else (set paramCount=%1)
if "%2"=="" (call :errorMsg "objMethod NOT DEFINED") else (set objMethod=%2)
(shift /1)& (shift /1)
(if %paramCount% GEQ 1 if "%~1"=="" call :errorMsg "objMethod[%objMethod%]: param%paramCount% NOT DEFINED")
(if %paramCount% GEQ 2 if "%~2"=="" call :errorMsg "objMethod[%objMethod%]: param%paramCount% NOT DEFINED")
(if %paramCount% GEQ 3 if "%~3"=="" call :errorMsg "objMethod[%objMethod%]: param%paramCount% NOT DEFINED")
(if %paramCount% GEQ 4 if "%~4"=="" call :errorMsg "objMethod[%objMethod%]: param%paramCount% NOT DEFINED")
(if %paramCount% GEQ 5 if "%~5"=="" call :errorMsg "objMethod[%objMethod%]: param%paramCount% NOT DEFINED")
(if %paramCount% GEQ 6 if "%~6"=="" call :errorMsg "objMethod[%objMethod%]: param%paramCount% NOT DEFINED")
(if %paramCount% GEQ 7 if "%~7"=="" call :errorMsg "objMethod[%objMethod%]: param%paramCount% NOT DEFINED")
(if %paramCount% GEQ 8 if "%~8"=="" call :errorMsg "objMethod[%objMethod%]: param%paramCount% NOT DEFINED")
(if %paramCount% GEQ 9 if "%~9"=="" call :errorMsg "objMethod[%objMethod%]: param%paramCount% NOT DEFINED")
goto :EOF


:errorMsg
echo errorMsg:& echo     %~1& pause>nul& exit