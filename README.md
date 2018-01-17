# batch-object

## 说明
> 探索batch下构建对象的方式. 目前构建了[list map object singularity]四个类，通过一些trick使得方法调用方式接近Java风格

## 定义规则
#### 基础
    1.函数前缀_表示该函数是内部函数; 不能调用[%listObj._init%]方法; 应只由系统调用
    2.属性前缀_field_; 数据前缀_data_
    3.size是原始函数, 需要增加额外的holder输出参数; sizePrint是简化的打印函数
    4.函数名下应该书写函数描述, 以及参数列表. 这些信息会在调用[object help]时打印
#### 继承相关
    1.类级别定义[_parent]为父类文件路径
    2.创建对象必须通过[call _objNew list listObj]才能继承到父类方法
    3.子类书写与父类中同名方法, 会被重写, 调用时会链接到子类的方法
    4.目前已知继承关系
        list\map --> object --> singularity
            list\map      集合类
            object        拥有[writeObject readObject]
            singularity   拥有[type]

            
## 更新
* 2018-01-17 15:04:01 增加统一的打印函数注释信息_objHelp
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