@echo off
echo readObject newListObj "%~d0%~p0listSaved.txt"
call object readObject newListObj "%~d0%~p0listSaved.txt"
echo ==================================
%newListObj.get% 0 holder
echo get(0)=%holder%
%newListObj.get% 3 holder
echo get(3)=%holder%
echo ==================================
echo toString
%newListObj.toString%
echo ==================================
pause>nul& goto :EOF
