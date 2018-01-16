@echo off& call loadF.bat _objNew
call %_objNew% object obj
%obj.type%
pause>nul& goto :EOF