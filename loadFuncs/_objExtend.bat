@echo off
::说明
::  batch-object类继承
::参数
::  childObj parentClassPath
::      childObj - 子类对象
::      parentClassPath - 父类路径
::调用
::  在子类new方法校验参数方法之后调用
::  call %_objExtend% childObj parentClassPath
::TODO
::  目前在子类new方法中调用，一般意义上应该在类级别调用
::external
::  date       2018-01-03 16:35:21
::  face       (>_<)
::  weather    小雨转中雨 9℃/5℃ 东北风
call "%~2" new %1