@echo off
::˵��
::  batch�����Զ����ú���, ��_init�����е���
::����
::  objName className classPath
::      objName - ��������
::      className - ������
::      classPath - ��·��
::external
::  date       2018-01-18  1:41:45
::  face       *_*
::  weather    ����ת�� 11��/7�� ��
call set _objFunctionsTemp=%%_%2_functions%%
set %1._functions=%_objFunctionsTemp%
for %%i in (%_objFunctionsTemp%) do set %1.%%i=call "%~3" %%i %1