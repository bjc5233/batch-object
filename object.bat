@echo off& call loadF.bat _checkObjParams _errorMsg
::说明
::  batch-object对象
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
::  date       2018-01-03 19:21:34
::  face       ●︿●
::  weather    小雨转中雨 9℃/6℃ 东北风
set functions=new type readObject writeObject
if "%1"=="" goto :EOF
goto :%1>nul 2>nul& (call %_errorMsg% %0 "method[%1] NOT DEFINED")


:help
echo available method: [%functions%]
pause>nul& goto :EOF


:new
::[new] [objectName]
(call %_checkObjParams% 1 %*)
set %2._field_object_type=object& set %2._functions=%functions%
for %%i in (%functions%) do set "%2.%%i=call object %%i %2"
goto :EOF


:type
::打印对象的类型 [type] [objectName]
(call %_checkObjParams% 1 %*)
if defined %2._field_object_type (call echo %%%2._field_object_type%%) else (echo UNKNOW TYPE)
goto :EOF


:writeObject
::对象持久化 [writeObject] [objectName] [objectPath]
(call %_checkObjParams% 2 %*)
setlocal enabledelayedexpansion
(
    echo objectName=%2
	echo _field_size=!%2._field_size!
	echo _field_object_type=!%2._field_object_type!
	echo _functions=!%2._functions!
	for %%i in (!%2._functions!) do echo %%i=call !%2._field_object_type! %%i
	for /f "tokens=2* delims=.=" %%i in ('set %2._data_') do echo %%i=%%j
)>"%~3"& endlocal & goto :EOF



:readObject
::读取持久化的对象 [readObject] [objectName] [objectPath]
(call %_checkObjParams% 1 %*)
for /f "tokens=1* delims==" %%i in (%~3) do (
    for /f "tokens=1 delims= " %%k in ("%%j") do (
        if "%%k"=="call" (set %2.%%i=%%j %2) else (set %2.%%i=%%j)
    )
)
goto :EOF