@echo off& call loadF.bat _checkObjParams _true _false _errorMsg
(call %_true%)& (call %_false%)
::说明
::  batch-map对象
::规则
::  函数前缀_表示该函数是内部函数
::  属性前缀_field_; 数据前缀_data_
::  size是原始函数, 需要增加额外的holder输出参数; sizePrint是简化的打印函数
::  readObject和writeObject是object级别函数
::        call object writeObject aa "C:\path\bat\batlearn\beta工厂\object\testListSaved.txt"
::        call object readObject bb "C:\path\bat\batlearn\beta工厂\object\testListSaved.txt"
::  checkParam函数需要在setlocal enabledelayedexpansion之前引用
::  对于flag型函数, 调用者判断方式(%flag%) && (echo 存在) || (echo 不存在)
::external
::  date       2018-01-03 19:00:57
::  face       ←_←
::  weather    小雨转中雨 9℃/6℃ 东南风
set functions=new put get getPrint size sizePrint containsKey containsKeyPrint toString clear containsValue containsValuePrint remove
if "%1"=="" goto :EOF
goto :%1>nul 2>nul& (call %_errorMsg% %0 "method[%1] NOT DEFINED")


:help
echo available method: [%functions%]
pause>nul& goto :EOF

:new
::[new] [mapObj]
(call %_checkObjParams% 1 %*)
set %2._field_size=0& set %2._field_object_type=map& set %2._functions=%functions%
for %%i in (%functions%) do set "%2.%%i=call %~f0 %%i %2"
goto :EOF


:put
::[put] [mapObj] [key] [value]
(call %_checkObjParams% 3 %*)
set %2._data_%3=%~4& set /a %2._field_size+=1& goto :EOF


:get
::[get] [mapObj] [key] [holder]
(call %_checkObjParams% 3 %*)
goto :_get
:getPrint
::[getPrint] [mapObj] [key]
(call %_checkObjParams% 2 %*)
call :_get %* holder
echo [getPrint]: %holder%& set holder=& goto :EOF
:_get
if defined %2._data_%3 (call set "%4=%%%2._data_%3%%") else (set %4=NULL)
goto :EOF


:size
::[size] [mapObj] [holder]
(call %_checkObjParams% 2 %*)
goto :_size
:sizePrint
::[size] [mapObj]
(call %_checkObjParams% 1 %*)
call :_size %* holder
echo [sizePrint]: %holder%& set holder=& goto :EOF
:_size
if defined %2._field_size (call set "%3=%%%2._field_size%%") else (set %3=NULL)
goto :EOF



:containsKey
::[containsKey] [mapObj] [key] [holder]
(call %_checkObjParams% 3 %*)
goto :_containsKey
:containsKeyPrint
::[containsKeyPrint] [mapObj] [key]
(call %_checkObjParams% 2 %*)
call :_containsKey %* holder
(%holder%) && (echo [sizePrint]: 存在) || (echo [sizePrint]: 不存在)
set holder=& goto :EOF
:_containsKey
if defined %2._data_%3 (set "%4=%_true%") else (set "%4=%_false%")
goto :EOF


:containsValue
::[containsValue] [mapObj] [value] [holder]
(call %_checkObjParams% 3 %*)
goto :_containsValue
:containsValuePrint
::[containsValuePrint] [mapObj] [value]
(call %_checkObjParams% 2 %*)
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
(call %_checkObjParams% 2 %*)
set %2._data_%3=& set /a %2._field_size-=1& goto :EOF


:clear
::[clear] [mapObj]
(call %_checkObjParams% 1 %*)
for /f "tokens=1 delims==" %%i in ('set %2. 2^>nul') do set %%i=
goto :EOF


:toString
::[toString] [mapObj]
(call %_checkObjParams% 1 %*)
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