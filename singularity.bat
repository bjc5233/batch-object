@echo off& call loadF.bat _objParams _errorMsg
::˵��
::  batch-singularity������
::  Ŀǰ���ж���Ķ�����, û��ʵ������, ��Ҫ����ģ���㼶�̳�
::  ����type�������ƶ���object����
::external
::  date       2018-01-17  3:20:23
::  face       �ݩn��
::  weather    ���� 14��/6�� ��
set _parent=NULL
set _singularity_functions=type
if "%1"=="" goto :EOF
goto :%1>nul 2>nul& (call %_errorMsg% %0 "method[%1] NOT DEFINED")



:_init
::[_init] [objectName]
set %2._field_object_type=singularity
set %2._functions=%_singularity_functions%
for %%i in (%_singularity_functions%) do set "%2.%%i=call %~f0 %%i %2"
goto :EOF



:type
::��ӡ��������� [type] [objectName]
(call %_objParams% 1 %*)
if defined %2._field_object_type (call echo %%%2._field_object_type%%) else (echo UNKNOW TYPE)
goto :EOF