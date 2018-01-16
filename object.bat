@echo off& call loadF.bat _objParams _errorMsg
::˵��
::  batch-object����
::����
::  ����
::    1.����ǰ׺_��ʾ�ú������ڲ�����; ����ͨ��[%listObj._new%]��ʽ����; Ӧֻ��ϵͳ����
::    2.����ǰ׺_field_; ����ǰ׺_data_
::    3.size��ԭʼ����, ��Ҫ���Ӷ����holder�������; sizePrint�Ǽ򻯵Ĵ�ӡ����
::  �̳����
::    1.�༶����[_parent]Ϊ�����ļ�·��
::    2.�����������ͨ��[call _new list listObj]���ܼ̳е����෽��
::    3.Ŀǰ��֪�̳й�ϵ
::        list\map --> object --> singularity
::            list\map      ������
::            object        ӵ��[writeObject readObject]
::            singularity   ӵ��[type]
::ע��
::  ����flag�ͺ���, �������жϷ�ʽ(%flag%) && (echo ����) || (echo ������)
::external
::  date       2018-01-03 19:21:34
::  face       ����
::  weather    С��ת���� 9��/6�� ������
set _parent=C:\path\bat\object\singularity.bat
set _object_functions=help readObject writeObject
if "%1"=="" goto :EOF
goto :%1>nul 2>nul& (call %_errorMsg% %0 "method[%1] NOT DEFINED")


:help
echo available method: [%_object_functions%]
pause>nul& goto :EOF


:_init
::[_init] [objectName]
set %2._field_object_type=object
set %2._functions=%_object_functions%
for %%i in (%_object_functions%) do set "%2.%%i=call %~f0 %%i %2"
goto :EOF



:writeObject
::����־û� [writeObject] [objectName] [objectPath]
(call %_objParams% 2 %*)
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
(call %_objParams% 1 %*)
for /f "tokens=1* delims==" %%i in (%~3) do (
    for /f "tokens=1 delims= " %%k in ("%%j") do (
        if "%%k"=="call" (set %2.%%i=%%j %2) else (set %2.%%i=%%j)
    )
)
goto :EOF