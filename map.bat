@echo off& call loadF.bat _objParams _objHelp _true _false _errorMsg
(call %_true%)& (call %_false%)
::说明
::  batch-map对象
::规则
::  参考object类
::external
::  date       2018-01-03 19:00:57
::  face       ←_←
::  weather    小雨转中雨 9℃/6℃ 东南风
set _parent=C:\path\bat\object\object.bat
set _%~n0_functions=help put get getPrint size sizePrint containsKey containsKeyPrint toString clear containsValue containsValuePrint remove
if "%1"=="" goto :EOF
if "%1"=="help" (call %_objHelp% %~n0 %~f0& goto :EOF)
goto :%1>nul 2>nul& (call %_errorMsg% %0 "method[%1] NOT DEFINED")


:_init
::[_init] [mapObj]
(call %_objParams% 1 %*)
set %2._field_size=0
set %2._field_object_type=map
set %2._functions=%_map_functions%
for %%i in (%_map_functions%) do set "%2.%%i=call %~f0 %%i %2"
goto :EOF


:put
::[put] [mapObj] [key] [value]
(call %_objParams% 3 %*)
set %2._data_%3=%~4& set /a %2._field_size+=1& goto :EOF


:get
::[get] [mapObj] [key] [holder]
(call %_objParams% 3 %*)
goto :_get
:getPrint
::[getPrint] [mapObj] [key]
(call %_objParams% 2 %*)
call :_get %* holder
echo [getPrint]: %holder%& set holder=& goto :EOF
:_get
if defined %2._data_%3 (call set "%4=%%%2._data_%3%%") else (set %4=NULL)
goto :EOF


:size
::[size] [mapObj] [holder]
(call %_objParams% 2 %*)
goto :_size
:sizePrint
::[size] [mapObj]
(call %_objParams% 1 %*)
call :_size %* holder
echo [sizePrint]: %holder%& set holder=& goto :EOF
:_size
if defined %2._field_size (call set "%3=%%%2._field_size%%") else (set %3=NULL)
goto :EOF



:containsKey
::[containsKey] [mapObj] [key] [holder]
(call %_objParams% 3 %*)
goto :_containsKey
:containsKeyPrint
::[containsKeyPrint] [mapObj] [key]
(call %_objParams% 2 %*)
call :_containsKey %* holder
(%holder%) && (echo [sizePrint]: 存在) || (echo [sizePrint]: 不存在)
set holder=& goto :EOF
:_containsKey
if defined %2._data_%3 (set "%4=%_true%") else (set "%4=%_false%")
goto :EOF


:containsValue
::[containsValue] [mapObj] [value] [holder]
(call %_objParams% 3 %*)
goto :_containsValue
:containsValuePrint
::[containsValuePrint] [mapObj] [value]
(call %_objParams% 2 %*)
call :_containsValue %* holder
(%holder%) && (echo [sizePrint]: 存在) || (echo [sizePrint]: 不存在)
set holder=& goto :EOF
:_containsValue
for /f "tokens=1* delims==" %%i in ('set %2._data_') do (
	if "%3"=="%%j" endlocal& set "%4=%_true%"& goto :EOF
)
endlocal& set "%4=%_false%"& goto :EOF


:remove
::[remove] [mapObj] [key]
(call %_objParams% 2 %*)
set %2._data_%3=& set /a %2._field_size-=1& goto :EOF


:clear
::[clear] [mapObj]
(call %_objParams% 1 %*)
for /f "tokens=1 delims==" %%i in ('set %2. 2^>nul') do set %%i=
goto :EOF


:toString
::[toString] [mapObj]
(call %_objParams% 1 %*)
echo %2:
echo {
call echo     size:%%%2._field_size%%
call echo     objectType:%%%2._field_object_type%%
echo     {
setlocal enabledelayedexpansion
for /f "tokens=2* delims=.=" %%i in ('set %2._data_ 2^>nul') do set key=%%i& echo         !key:~6!:%%j
endlocal
echo     }
echo }
goto :EOF