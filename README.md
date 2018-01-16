# batch-object

## 说明
> 探索batch下构建对象的方式. 目前构建了[list map object singularity]四个类，通过一些trick使得方法调用方式接近Java风格


## 更新
* 2018-01-17 增加多层继承，子类对象直接调用父类的父类的方法；简化继承写法_parent
* 2018-01-15 增加继承雏形，子类对象直接调用父类方法


## 调用方式
* 细节参考xxxTest.bat文件写法
```batch
@echo off& call loadF.bat _objNew
::创建list对象
call %_objNew% list listObj

::实际上是调用父类object的父类singularity来判断对象类型
%listObj.type% 

::调用add方法添加元素
%listObj.add% 123
%listObj.add% 你好

::调用toString方法打印对象
%listObj.toString%
::    ========>输出结果
::        list
::        listObj:
::        {
::            size:2
::            objectType:list
::            [
::                123
::                你好
::            ]
::        }
```