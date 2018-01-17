@echo off
::说明
::  batch对象自动配置函数, 在_init方法中调用
::参数
::  objName className classPath
::      objName - 对象名称
::      className - 类名称
::      classPath - 类路径
::external
::  date       2018-01-18  1:41:45
::  face       *_*
::  weather    多云转阴 11℃/7℃ 风
call set _objFunctionsTemp=%%_%2_functions%%
set %1._functions=%_objFunctionsTemp%
for %%i in (%_objFunctionsTemp%) do set %1.%%i=call "%~3" %%i %1