@echo off
::说明
::  batch对象help函数，打印出当前类支持的方法
::参数
::  className classPath
::      className - 类名称
::      classPath - 类路径
::external
::  date       2018-01-17 14:30:54
::  face       ^ω^
::  weather    多云 14℃/5℃ 风
echo available method[%1]:
call set _objHelpFunctions=%%_%1_functions%%
setlocal enabledelayedexpansion
set _flag=0
for /f "delims=" %%i in (%2) do (
    set curLine=%%i
    ::函数注释处
    if !_flag!==1 if "!curLine:~0,2!"=="::" (echo !curLine!) else (set _flag=0& echo.)
    ::函数名处
    if "!curLine:~0,1!"==":" if not "!curLine:~1,1!"==":" (
        set _curFunctionName=!curLine:~1!
        for %%j in (%_objHelpFunctions%) do (
            ::只有当在类_functions中有定义时才打印
            if "!_curFunctionName!"=="%%j" set _flag=1& echo !_curFunctionName!
        )
    )
)
endlocal