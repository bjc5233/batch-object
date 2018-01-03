# batch-object

## 说明
> 探索batch下构建对象的方式. 目前构建了object、list、map三个，通过一些trick使得方法调用方式接近Java风格


## 调用方式
* 细节参考xxxTest.bat文件写法
```batch
::创建list对象
call list.bat new listObj
::调用基类object判断对象类型
call object.bat type listObj
::调用add方法添加元素
%listObj.add% 123
%listObj.add% 你好
::调用toString方法打印对象
%listObj.toString%
```