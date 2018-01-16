@echo off& call loadF.bat _objParams _errorMsg
::说明
::  batch-object对象
::规则
::  基础
::    1.函数前缀_表示该函数是内部函数; 不能通过[%listObj._new%]方式调用; 应只由系统调用
::    2.属性前缀_field_; 数据前缀_data_
::    3.size是原始函数, 需要增加额外的holder输出参数; sizePrint是简化的打印函数
::  继承相关
::    1.类级别定义[_parent]为父类文件路径
::    2.创建对象必须通过[call _new list listObj]才能继承到父类方法
::    3.目前已知继承关系
::        list\map --> object --> singularity
::            list\map      集合类
::            object        拥有[writeObject readObject]
::            singularity   拥有[type]
::注意
::  对于flag型函数, 调用者判断方式(%flag%) && (echo 存在) || (echo 不存在)
::external
::  date       2018-01-03 19:21:34
::  face       ●︿●
::  weather    小雨转中雨 9℃/6℃ 东北风
set _parent=C:\path\bat\object\singularity.bat
set _object_functions=help readObject writeObject
if "%1"=="" goto :EOF
goto :%1>nul 2>nul& (call %_errorMsg% %0 "method[%1] NOT DEFINED")


:help
echo available method: [%_object_functions%]
pause>nul& goto :EOF


:_init
::[_init] [objectName]
set %2._field_object_type=object
set %2._functions=%_object_functions%
for %%i in (%_object_functions%) do set "%2.%%i=call %~f0 %%i %2"
goto :EOF



:writeObject
::对象持久化 [writeObject] [objectName] [objectPath]
(call %_objParams% 2 %*)
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
(call %_objParams% 1 %*)
for /f "tokens=1* delims==" %%i in (%~3) do (
    for /f "tokens=1 delims= " %%k in ("%%j") do (
        if "%%k"=="call" (set %2.%%i=%%j %2) else (set %2.%%i=%%j)
    )
)
goto :EOF