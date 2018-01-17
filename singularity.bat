@echo off& call loadF.bat _objParams _objHelp _objFunctions _errorMsg
::说明
::  batch-singularity奇点对象
::  目前所有对象的顶级类, 没有实际意义, 主要用于模拟多层级继承
::  后续type方法会移动到object类中
::external
::  date       2018-01-17  3:20:23
::  face       ≥﹏≤
::  weather    多云 14℃/6℃ 风
set _parent=NULL
set _%~n0_functions=help type
if "%1"=="" goto :EOF
if "%1"=="help" (call %_objHelp% %~n0 %~f0& goto :EOF)
goto :%1>nul 2>nul& (call %_errorMsg% %0 "method[%1] NOT DEFINED")



:_init
::[_init] [objectName]
(call %_objParams% 1 %*)
set %2._field_type=singularity
call %_objFunctions% %2 %~n0 %~f0
goto :EOF



:type
::打印对象的类型 [type] [objectName]
(call %_objParams% 1 %*)
if defined %2._field_type (call echo %%%2._field_type%%) else (echo UNKNOW TYPE)
goto :EOF