@echo off
::˵��
::  batch����help��������ӡ����ǰ��֧�ֵķ���
::����
::  className classPath
::      className - ������
::      classPath - ��·��
::external
::  date       2018-01-17 14:30:54
::  face       ^��^
::  weather    ���� 14��/5�� ��
echo available method[%1]:
call set _objHelpFunctions=%%_%1_functions%%
setlocal enabledelayedexpansion
set _flag=0
for /f "delims=" %%i in (%2) do (
    set curLine=%%i
    ::����ע�ʹ�
    if !_flag!==1 if "!curLine:~0,2!"=="::" (echo !curLine!) else (set _flag=0& echo.)
    ::��������
    if "!curLine:~0,1!"==":" if not "!curLine:~1,1!"==":" (
        set _curFunctionName=!curLine:~1!
        for %%j in (%_objHelpFunctions%) do (
            ::ֻ�е�����_functions���ж���ʱ�Ŵ�ӡ
            if "!_curFunctionName!"=="%%j" set _flag=1& echo !_curFunctionName!
        )
    )
)
endlocal