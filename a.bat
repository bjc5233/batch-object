
@echo off
call list.bat new listObj
::���û���object�ж϶�������
call object.bat type listObj
::����add�������Ԫ��
%listObj.add% 123
%listObj.add% ���
::����toString������ӡ����
%listObj.toString%
pause>nul