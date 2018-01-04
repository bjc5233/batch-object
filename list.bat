@echo off& call loadF.bat _checkObjParams _true _false _ifOr _errorMsg
(call %_true%)& (call %_false%)
::˵��
::  batch-list����
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
::  date       2018-01-03 14:08:44
::  face       (���令)
::  weather    С��ת���� 9��/5�� ������
set functions=help new add addAt isEmpty size sizePrint contains get getPrint indexOf indexOfPrint remove removeAt toString clear set
if "%1"=="" goto :EOF
goto :%1>nul 2>nul& (call %_errorMsg% %0 "method[%1] NOT DEFINED")


:help
echo available method: [%functions%]
pause>nul& goto :EOF

:new
::[new] [listObj]
(call %_checkObjParams% 1 %*)
set %2._field_size=0& set %2._field_object_type=list& set %2._functions=%functions%
for %%i in (%functions%) do set "%2.%%i=call %~f0 %%i %2"
goto :EOF


:add   
::[add] [listObj] [element]
(call %_checkObjParams% 2 %*)
call set %2._data_%%%2._field_size%%=%~3
set /a %2._field_size+=1
goto :EOF


:addAt
::[addAt] [listObj] [index] [element]
(call %_checkObjParams% 3 %*)
call set _list_field_size=%%%2._field_size%%
set /a _list_max_index=_list_field_size-1
(set or1=%3 GTR %_list_max_index%& set or2=%3 LSS 0& call %_ifOr% _list_flag 2)
(%_list_flag%) && (call %_errorMsg% %0 "method[%1]: index MUST BE BETWEEN 0 AND %_list_max_index%")

set /a _list_add_index=%3+1
setlocal enabledelayedexpansion
for /l %%i in (%_list_field_size%,-1,%_list_add_index%) do (
	set /a _list_add_index=%%i-1
    for %%a in (!_list_add_index!) do for /f "delims=" %%b in ("!%2._data_%%a!") do endlocal& set %2._data_%%i=%%b& setlocal enabledelayedexpansion
)
endlocal
set %2._data_%3=%~4
set /a %2._field_size+=1
set _list_field_size=& set _list_max_index=& set _list_flag=& set _list_add_index=
goto :EOF


:isEmpty
::[isEmpty] [listObj] [flag]
(call %_checkObjParams% 2 %*)
call set _list_field_size=%%%2._field_size%%
(set or1="%_list_field_size%"==""& set or2=%_list_field_size%==0& call %_ifOr% _empty_flag 2)
(%_empty_flag%) && (set "%3=%_true%") || (set "%3=%_false%")
goto :EOF


:size
::[size] [listObj] [holder]
(call %_checkObjParams% 2 %*)
goto :_size
:sizePrint
::[size] [listObj]
(call %_checkObjParams% 1 %*)
call :_size %* holder
echo [sizePrint]: %holder%& set holder=& goto :EOF
:_size
call set %3=%%%2._field_size%%
goto :EOF



:contains
::[contains] [listObj] [element] [flag]
(call %_checkObjParams% 3 %*)
setlocal enabledelayedexpansion
set /a _list_max_index=%2._field_size-1
for /l %%i in (0,1,!_list_max_index!) do (
	if "!%2._data_%%i!"=="%3" (endlocal& set "%4=%_true%")& goto :EOF
)
endlocal& set "%4=%_false%"& goto :EOF


:get
::[get] [listObj] [index] [holder]
(call %_checkObjParams% 3 %*)
goto :_get
:getPrint
::[getPrint] [listObj] [index]
(call %_checkObjParams% 2 %*)
call :_get %* holder
echo [getPrint]: %holder%& set holder=& goto :EOF
:_get
if defined %2._data_%3 (call set "%4=%%%2._data_%3%%") else (set %4=NULL)
goto :EOF


:indexOf
::[indexOf] [listObj] [element] [index]
(call %_checkObjParams% 3 %*)
goto :_indexOf
:indexOfPrint
::[indexOfPrint] [listObj] [element]
(call %_checkObjParams% 2 %*)
call :_indexOf %* holder
echo [getPrint]: %holder%& set holder=& goto :EOF
:_indexOf
setlocal enabledelayedexpansion
set /a _list_max_index=%2._field_size-1
for /l %%i in (0,1,!_list_max_index!) do (
	if "!%2._data_%%i!"=="%3" (endlocal& set "%4=%%i")& goto :EOF
)
endlocal& set "%4=NULL"& goto :EOF


:remove
::[remove] [listObj]
(call %_checkObjParams% 1 %*)
set /a _list_max_index=%2._field_size-1
call set _list_max_index=%%%2._field_size%%
set %2._data_%_list_max_index%=
set /a %2._field_size-=1
set _list_max_index=
goto :EOF


:removeAt
::[removeAt] [listObj] [index]
(call %_checkObjParams% 2 %*)
if not defined %2._data_%3 goto :EOF
set /a _list_max_index=%2._field_size-1, _list_remove_index=%3+1
setlocal enabledelayedexpansion
for /l %%i in (%_list_remove_index%,1,%_list_max_index%) do (
    set /a _list_remove_index=%%i-1
    for %%a in (!_list_remove_index!) do for /f "delims=" %%b in ("!%2._data_%%i!") do endlocal& set %2._data_%%a=%%b& setlocal enabledelayedexpansion
)
endlocal& set %2._data_%_list_max_index%=& set /a %2._field_size-=1
goto :EOF


:clear
::[clear] [listObj]
(call %_checkObjParams% 1 %*)
for /f "tokens=1 delims==" %%i in ('set %2. 2^>nul') do set %%i=
goto :EOF


:set
::[set] [listObj] [index] [newValue]
(call %_checkObjParams% 3 %*)
if defined %2._data_%3 set %2._data_%3=%~4& goto :EOF


:toString
::[toString] [listObj]
(call %_checkObjParams% 1 %*)
echo %2:
echo {
call echo     size:%%%2._field_size%%
call echo     objectType:%%%2._field_object_type%%
echo     [
set /a maxIndex=%2._field_size-1
for /l %%i in (0,1,%maxIndex%) do call echo         %%%2._data_%%i%%
echo     ]
echo }
goto :EOF