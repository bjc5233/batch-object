@echo off
::˵��
::  batch����������
::ִ��˳��
::  ��õ�ǰ��_parent -> ����parentClass -> ���parentClass��_parent-> .... -> �������_parent=NULL ��
::  ���õ�ǰ���_init���� <------- ����parentClass��_init����  <-------- .... <-���û���_init����  ����
::����
::  classPath objName
::      classPath - ��·��
::      objName - ������
::external
::  date       2018-01-17  2:18:32
::  face       ��( �� �� ��|||)��
::  weather    ���� 14��/6�� ��
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