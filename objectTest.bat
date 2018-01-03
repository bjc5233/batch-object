@echo off
call object new obj
%obj.fun1% 参数1
%obj.fun2% 参数2
pause>nul& goto :EOF