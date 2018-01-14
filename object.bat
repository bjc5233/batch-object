@echo off& call loadF.bat _checkObjParams _errorMsg
::˵��
::  batch-object����
::����
::  ����ǰ׺_��ʾ�ú������ڲ�����
::  ����ǰ׺_field_; ����ǰ׺_data_
::  size��ԭʼ����, ��Ҫ���Ӷ����holder�������; sizePrint�Ǽ򻯵Ĵ�ӡ����
::  readObject��writeObject��object������
::        call object writeObject aa "C:\path\bat\batlearn\beta����\object\testListSaved.txt"
::        call object readObject bb "C:\path\bat\batlearn\beta����\object\testListSaved.txt"
::  checkParam������Ҫ��setlocal enabledelayedexpansion֮ǰ����
::  ����flag�ͺ���, �������жϷ�ʽ(%flag%) && (echo ����) || (echo ������)
::external
::  date       2018-01-03 19:21:34
::  face       ����
::  weather    С��ת���� 9��/6�� ������
set functions=new type readObject writeObject
if "%1"=="" goto :EOF
goto :%1>nul 2>nul& (call %_errorMsg% %0 "method[%1] NOT DEFINED")


:help
echo available method: [%functions%]
pause>nul& goto :EOF


:new
::[new] [objectName]
(call %_checkObjParams% 1 %*)
set %2._field_object_type=object& set %2._functions=%functions%
for %%i in (%functions%) do set "%2.%%i=call object %%i %2"
goto :EOF


:type
::��ӡ��������� [type] [objectName]
(call %_checkObjParams% 1 %*)
if defined %2._field_object_type (call echo %%%2._field_object_type%%) else (echo UNKNOW TYPE)
goto :EOF


:writeObject
::����־û� [writeObject] [objectName] [objectPath]
(call %_checkObjParams% 2 %*)
setlocal enabledelayedexpansion
(
    echo objectName=%2
	echo _field_size=!%2._field_size!
	echo _field_object_type=!%2._field_object_type!
	echo _functions=!%2._functions!
	for %%i in (!%2._functions!) do echo %%i=call !%2._field_object_type! %%i
	for /f "tokens=2* delims=.=" %%i in ('set %2._data_') do echo %%i=%%j
)>"%~3"& endlocal & goto :EOF



:readObject
::��ȡ�־û��Ķ��� [readObject] [objectName] [objectPath]
(call %_checkObjParams% 1 %*)
for /f "tokens=1* delims==" %%i in (%~3) do (
    for /f "tokens=1 delims= " %%k in ("%%j") do (
        if "%%k"=="call" (set %2.%%i=%%j %2) else (set %2.%%i=%%j)
    )
)
goto :EOF