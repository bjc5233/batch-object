@echo off& call loadF.bat _objNew
call %_objNew% map mapObj
%mapObj.type%
echo ==================================
echo put(1,123)
%mapObj.put% 1 123
echo put(mapObj,helloworld)
%mapObj.put% mapObj helloworld
echo put(4,ÄãºÃ)
%mapObj.put% 4 ÄãºÃ
echo put(³Ô·¹,Ë¯¾õ´ò¶¹¶¹)
%mapObj.put% ³Ô·¹ Ë¯¾õ´ò¶¹¶¹
echo ==================================
echo getPrint(2)=
%mapObj.getPrint% 2
echo getPrint(mapObj)=
%mapObj.getPrint% mapObj
%mapObj.get% 4 holder
echo get(4)=%holder%
echo ==================================
echo toString
%mapObj.toString%
echo ==================================
%mapObj.size% holder
echo size=%holder%
echo ==================================
echo sizePrint=
%mapObj.sizePrint%
echo ==================================
echo writeObject "%~d0%~p0mapSaved.txt"
%mapObj.writeObject% "%~d0%~p0mapSaved.txt"
echo ==================================
pause>nul& goto :EOF
