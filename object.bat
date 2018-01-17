@echo off& call loadF.bat _objParams _objHelp _objFunctions _errorMsg
::说明
::  batch-object对象
::规则
::  基础
::    1.函数前缀_表示该函数是内部函数; 不能调用[%listObj._init%]方法; 应只由系统调用
::    2.属性前缀_field_; 数据前缀_data_
::    3.size是原始函数, 需要增加额外的holder输出参数; sizePrint是简化的打印函数
::    4.函数名下应该书写函数描述, 以及参数列表. 这些信息会在调用[object help]时打印
::    5._init方法中调用[call %_objFunctions% %2 %~n0 %~f0]会根据_functions创建[%listObj.help%]...快捷方法
::  继承相关
::    1.类级别定义[_parent]为父类文件路径
::    2.创建对象必须通过[call _objNew list listObj]才能继承到父类方法
::    3.子类书写与父类中同名方法, 会被重写, 调用时会链接到子类的方法
::    4.目前已知继承关系
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
set _%~n0_functions=help readObject writeObject
if "%1"=="" goto :EOF
if "%1"=="help" (call %_objHelp% %~n0 %~f0& goto :EOF)
goto :%1>nul 2>nul& (call %_errorMsg% %0 "method[%1] NOT DEFINED")



:_init
::[_init] [objectName]
(call %_objParams% 1 %*)
set %2._field_type=object
call %_objFunctions% %2 %~n0 %~f0
goto :EOF



:writeObject
::对象持久化 [writeObject] [objectName] [objectPath]
(call %_objParams% 2 %*)
setlocal enabledelayedexpansion
(
    echo objectName=%2
	echo _field_size=!%2._field_size!
	echo _field_type=!%2._field_type!
	echo _functions=!%2._functions!
	for %%i in (!%2._functions!) do echo %%i=call !%2._field_type! %%i
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