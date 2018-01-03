@echo off
echo readObject newMapObj "%~d0%~p0mapSaved.txt"
call object readObject newMapObj "%~d0%~p0mapSaved.txt"
echo ==================================
%newMapObj.get% 1 holder
echo get(1)=%holder%
%newMapObj.get% aa holder
echo get(aa)=%holder%
echo ==================================
echo toString
%newMapObj.toString%
echo ==================================
pause>nul& goto :EOF
