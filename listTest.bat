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
echo add ���
%listObj.add% ���
echo ==================================
echo addAt 1 ������
%listObj.addAt% 1 ������
echo ==================================
echo toString
%listObj.toString%
echo ==================================
echo isEmpty flag
%listObj.isEmpty% flag
(%flag%) && (echo Ϊ��) || (echo ��Ϊ��)
echo ==================================
echo size holder
%listObj.size% holder
echo %holder%
%listObj.size_%
echo ==================================
echo contains 123 flag
%listObj.contains% 123 flag
(%flag%) && (echo ����) || (echo ������)

echo contains 456 flag
%listObj.contains% 456 flag
(%flag%) && (echo ����) || (echo ������)
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
echo indexOf ������ index
%listObj.indexOf% ������ index
echo.%index%

echo indexOf xxx index
%listObj.indexOf% xxx index
echo.%index%

echo indexOfPrint ������
%listObj.indexOfPrint% ������
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




















