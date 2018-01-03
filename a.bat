
@echo off
call list.bat new listObj
::调用基类object判断对象类型
call object.bat type listObj
::调用add方法添加元素
%listObj.add% 123
%listObj.add% 你好
::调用toString方法打印对象
%listObj.toString%
pause>nul