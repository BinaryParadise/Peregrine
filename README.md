# Peregrine

[![CI Status](https://img.shields.io/travis/BinaryParadise/Peregrine.svg?style=flat)](https://travis-ci.org/BinaryParadise/Peregrine)
[![Version](https://img.shields.io/cocoapods/v/Peregrine.svg?style=flat)](https://cocoapods.org/pods/Peregrine)
[![Coverage Status](https://coveralls.io/repos/github/BinaryParadise/Peregrine/badge.svg?branch=master)](https://coveralls.io/github/BinaryParadise/Peregrine?branch=master)
[![Platform](https://img.shields.io/cocoapods/p/Peregrine.svg?style=flat)](https://cocoapods.org/pods/Peregrine)



一个高效、灵活、使用方便的路由组件

自定义注册路由，按照规范实现后，组件自动生成路由表

## 原理

通过正则匹配出预定义的路由实现，生成路由表，应用启动后加载，通过路由地址匹配实现并打开

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

> - 推荐在对应的`业务类`中实现路由
>- 路由的回调由具体实现场景控制，默认不回调

#### Objective-C

直接使用预定义宏，保证定义的统一

例如需要实现一个用户登录的路由pg://test/login，可按如下示例定义，swift同理

```objc
//加入登录页面类是PGLoginViewController

//PGLoginViewController.h中定义路由
@interface PGLoginViewController.h : NSObject

// 类方法路由
PGMethod(login, "pg://test/login?t=%@")

// 实例方法路由
PGInstanceMethod(logout, "pg://test/logout?t=%@")

@end

//在PGLoginViewController.m中实现路由
@implementation TestRoute

+ (void)login:(PGRouterContext *)context {
    //context.userInfo：包含携带的参数
    //context.object: 表示传的对象类型参数
  	//跳转登录页逻辑
    [context onDone:YES object:[context.userInfo valueForKey:@"t"]];
}

- (void)logout:(PGRouterContext *)context {
  	//退出登录逻辑
    [context onDone:YES object:[context.userInfo valueForKey:@"t"]];
}

@end
```

#### Swift

```swift
//如果是外部调用需要设置为public
public class PGLoginViewController {
  	//路由地址和方法名可修改，其它的方法定义必须和示例保持一致，且只支持单行定义（方法实现无要求）
  	//类方法实现
    @available(*, renamed: "route", message: "pg://test/m1?t=%@")
    @objc static func login(context:PGRouterContext) -> Void {
        //TODO:跳转登录页逻辑
        context.onDone(true, object: "done")
    }
}
```

代码段（Snippet）

```swift
@available(*, renamed: "route", message: "<#path#>")
@objc static func <#function#>(context: PGRouterContext) -> Void {
    <#code#>
}
```

### 路由调用

#### Objective-C

```objc
//调用类方法
[PGRouterManager<NSString *> openURL:[NSString stringWithFormat:pg_test_login, @"m1"] completion:^(BOOL ret, NSString *object) {
  //TODO: do something
}];

//调用实例方法
TestRoute *test = [TestRoute new];
//路由地址可直接使用字符串（推荐导入PGRouteDefine.h使用常量定义）
[test pg_openURL:[NSString stringWithFormat:pg_test_logout, @"m2"] completion:^(BOOL ret, id object) {
  //TODO: do something
}];

```

#### Swift

```swift
PGRouterManager<AnyObject>.openURL("pg://test/login?t=90812") { (ret, obj) in
    //TODO:do something                                          
}
```

```


## 常见问题

### Q. 编译不通过怎么办？

头文件的生成会有延迟或缓存，请尝试重新编译

## License

Peregrine 被许可在 MIT 协议下使用。查阅 LICENSE 文件来获得更多信息。

```
