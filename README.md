# Peregrine

[![CI Status](https://img.shields.io/travis/BinaryParadise/Peregrine.svg?style=flat)](https://travis-ci.org/BinaryParadise/Peregrine)
[![Version](https://img.shields.io/cocoapods/v/Peregrine.svg?style=flat)](https://cocoapods.org/pods/Peregrine)
[![Coverage Status](https://coveralls.io/repos/github/BinaryParadise/Peregrine/badge.svg?branch=master)](https://coveralls.io/github/BinaryParadise/Peregrine?branch=master)
[![Platform](https://img.shields.io/cocoapods/p/Peregrine.svg?style=flat)](https://cocoapods.org/pods/Peregrine)



一个高效、灵活、使用方便的路由组件

## 原理

通过正则匹配出预定义的路由实现，生成路由表，应用启动后加载，通过路由地址匹配实现并打开

[~~LLVM模式待完善~~](LLVM.md)

## 集成到项目中(正则表达式)

### 一、添加依赖

> 示例会生成两个文件`PGRouteDefine.h`、`PGRouteDefine.m`，加入项目中

```ruby
pod 'Peregrine'

post_install do |installer|
  # 添加编译脚本，每次编译时都会重新收集路由表
  require_relative 'Pods/Peregrine/Peregrine/PGGenerator.rb'
    PGGenerator::configure_project(installer, {'expr' => true, 'name' => 'PGRouteDefine', 'path' => '${SRCROOT}/Peregrine'})
end
```

参数说明
| 名称 | 类型 | 说明 |
| --- | --- | --- |
| expr| boolean | 默认true，是否使用正则表达式模式 |
| name| string | 路由常量类名 |
| path | string | 路由常量类路径 |

### 二、导入头文件

##### Objective-C


```objc
#import <Peregrine/Peregrine.h>
```

Swift

```swif
import Peregrine
```



### 三、注册路由

#### Objective-C

可直接使用预定义宏

```objc

@interface TestRoute : NSObject

// 类方法路由
PGMethod(classMethod, "pg://test/m1?t=%@")

// 实例方法路由
PGInstanceMethod(instanceMethod, "pg://test/m2?t=%@")

@end

@implementation TestRoute

+ (void)classMethod:(PGRouterContext *)context {
    //context.userInfo：包含携带的参数
    //context.object: 表示传的对象类型参数
    [context onDone:YES object:[context.userInfo valueForKey:@"t"]];
}

- (void)instanceMethod:(PGRouterContext *)context {
    [context onDone:YES object:[context.userInfo valueForKey:@"t"]];
}

@end
```

#### Swift

```swift
//如果是外部调用需要设置为public
public class SwiftRoute {
  	//路由地址和方法名可修改，其它的方法定义必须和示例保持一致
  	//类方法实现
    @available(*, renamed: "route", message: "pg://test/m1?t=%@")
    @objc static func test1(context:PGRouterContext) -> Void {
        //TODO:do something
        context.onDone(true, object: "done")
    }
}
```

### 路由调用

#### Objective-C

​```objc
//调用类方法
[PGRouterManager<NSString *> openURL:[NSString stringWithFormat:pg_test_m1, @"m1"] completion:^(BOOL ret, NSString *object) {
  //TODO: do something
}];

//调用实例方法
TestRoute *test = [TestRoute new];
//路由地址可直接使用字符串（推荐导入PGRouteDefine.h使用常量定义）
[test pg_openURL:[NSString stringWithFormat:pg_test_m2, @"m2"] completion:^(BOOL ret, id object) {
  //TODO: do something
}];

```

#### Swift

```swift
PGRouterManager<AnyObject>.openURL("pg://test/m1?t=90812") { (ret, obj) in
    //TODO:do something                                          
}
```


## 常见问题

### Q. 编译不通过怎么办？

头文件的生成会有延迟或缓存，请尝试重新编译

## License

Peregrine 被许可在 MIT 协议下使用。查阅 LICENSE 文件来获得更多信息。
