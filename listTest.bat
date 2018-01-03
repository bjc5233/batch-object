@echo off
call list new listObj
call object type listObj
echo ==================================
echo add 123
%listObj.add% 123
echo add hello
%listObj.add% hello
echo add 123
%listObj.add% 123
echo add ÄãºÃ
%listObj.add% ÄãºÃ
echo ==================================
echo addAt 1 ¹þ¹þ¹þ
%listObj.addAt% 1 ¹þ¹þ¹þ
echo ==================================
echo toString
%listObj.toString%
echo ==================================
echo isEmpty flag
%listObj.isEmpty% flag
(%flag%) && (echo Îª¿Õ) || (echo ²»Îª¿Õ)
echo ==================================
echo size holder
%listObj.size% holder
echo %holder%
%listObj.size_%
echo ==================================
echo contains 123 flag
%listObj.contains% 123 flag
(%flag%) && (echo ´æÔÚ) || (echo ²»´æÔÚ)

echo contains 456 flag
%listObj.contains% 456 flag
(%flag%) && (echo ´æÔÚ) || (echo ²»´æÔÚ)
echo ==================================
echo get 1 element
%listObj.get% 1 element
echo %element%

echo get 10 element
%listObj.get% 10 element
echo.%element%

echo getPrint 1
%listObj.getPrint% 1
echo ==================================
echo indexOf ¹þ¹þ¹þ index
%listObj.indexOf% ¹þ¹þ¹þ index
echo.%index%

echo indexOf xxx index
%listObj.indexOf% xxx index
echo.%index%

echo indexOfPrint ¹þ¹þ¹þ
%listObj.indexOfPrint% ¹þ¹þ¹þ
echo ==================================
echo removeAt 1
%listObj.removeAt% 1
%listObj.toString% listObj
echo ==================================
echo set 0 456
%listObj.set% 0 456
%listObj.toString% listObj

echo ==================================
set base=


echo writeObject "%~d0%~p0listSaved.txt"
call object writeObject listObj "%~d0%~p0listSaved.txt"
echo ==================================
pause>nul& goto :EOF




















