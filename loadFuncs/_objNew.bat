@echo off
::说明
::  batch创建对象函数
::执行顺序
::  获得当前类_parent -> 进入parentClass -> 获得parentClass的_parent-> .... -> 到达基类_parent=NULL ↓
::  调用当前类的_init方法 <------- 调用parentClass的_init方法  <-------- .... <-调用基类_init方法  ←↓
::参数
::  classPath objName
::      classPath - 类路径
::      objName - 对象名
::external
::  date       2018-01-17  2:18:32
::  face       Σ( ° △ °|||)︴
::  weather    多云 14℃/6℃ 风
(call %~d0%~p0_objParams 1 %*)
set _tree=
set _treeIndex=0
set _parent=%1
:_newLoop
set _tree[%_treeIndex%]=%_parent%
call %_parent%
set /a _treeIndex+=1
if /i "%_parent%" NEQ "NULL" (goto :_newLoop)

:_newLoop2
set /a _treeIndex-=1
call %%_tree[%_treeIndex%]%% _init %2
set _tree[%_treeIndex%]=
if %_treeIndex% NEQ 0 (goto :_newLoop2)
set _treeIndex=