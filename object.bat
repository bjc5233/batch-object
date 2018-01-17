@echo off& call loadF.bat _objParams _objHelp _objFunctions _errorMsg
::˵��
::  batch-object����
::����
::  ����
::    1.����ǰ׺_��ʾ�ú������ڲ�����; ���ܵ���[%listObj._init%]����; Ӧֻ��ϵͳ����
::    2.����ǰ׺_field_; ����ǰ׺_data_
::    3.size��ԭʼ����, ��Ҫ���Ӷ����holder�������; sizePrint�Ǽ򻯵Ĵ�ӡ����
::    4.��������Ӧ����д��������, �Լ������б�. ��Щ��Ϣ���ڵ���[object help]ʱ��ӡ
::    5._init�����е���[call %_objFunctions% %2 %~n0 %~f0]�����_functions����[%listObj.help%]...��ݷ���
::  �̳����
::    1.�༶����[_parent]Ϊ�����ļ�·��
::    2.�����������ͨ��[call _objNew list listObj]���ܼ̳е����෽��
::    3.������д�븸����ͬ������, �ᱻ��д, ����ʱ�����ӵ�����ķ���
::    4.Ŀǰ��֪�̳й�ϵ
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
set _%~n0_functions=help readObject writeObject
if "%1"=="" goto :EOF
if "%1"=="help" (call %_objHelp% %~n0 %~f0& goto :EOF)
goto :%1>nul 2>nul& (call %_errorMsg% %0 "method[%1] NOT DEFINED")



:_init
::[_init] [objectName]
(call %_objParams% 1 %*)
set %2._field_type=object
call %_objFunctions% %2 %~n0 %~f0
goto :EOF



:writeObject
::����־û� [writeObject] [objectName] [objectPath]
(call %_objParams% 2 %*)
setlocal enabledelayedexpansion
(
    echo objectName=%2
	echo _field_size=!%2._field_size!
	echo _field_type=!%2._field_type!
	echo _functions=!%2._functions!
	for %%i in (!%2._functions!) do echo %%i=call !%2._field_type! %%i
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