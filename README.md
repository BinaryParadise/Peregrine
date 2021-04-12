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

### 一、项目集成

> 示例会生成文件`PGRouteDefine.swift`、加入项目中

`Podfile增加以下代码`
```ruby
pod 'Peregrine'

post_install do |installer|
  # 添加编译脚本，每次编译时都会自动收集路由表
  require_relative 'Pods/Peregrine/Sources/Configuration.rb'
    PGGenerator::configure_project(installer, {'name' => 'PGRouteDefine', 'path' => '${SRCROOT}/Peregrine'})
end
```

参数说明
| 名称 | 类型 | 说明 |
| --- | --- | --- |
| name| string | 路由常量定义类名 |
| path | string | 路由常量类生成路径 |


### 二、注册路由

>- 路由的回调由具体业务场景控制，默认不回调

#### ObjC

使用宏定义创建路由，保证统一，不支持自定义

```objc
@import Peregrine;

//创建路由（必须，不允许修改，否则不能匹配路由表）
#define RouteDefine(func, _url) \
+ (void)func:(RouteContext *)context;
```

例如需要实现一个用户登录的路由pg://test/login，可按如下示例定义，swift同理

```objc
//登录页面Class: PGLoginViewController

//PGLoginViewController.h中定义路由
@interface PGLoginViewController.h : NSObject

// 发起登录
RouteDefine(login, "pg://test/login?t=%@")

// 退出登录
RouteDefine(logout, "pg://test/logout?t=%@")

@end

//在PGLoginViewController.m中实现路由

@implementation PGLoginViewController

+ (void)login:(RouteContext *)context {
    //context.userInfo：包含携带的参数
    //context.object: 表示传的对象类型参数
  	//跳转登录页逻辑...
    [context onDone:YES object:[context.userInfo valueForKey:@"t"]];
}

- (void)logout:(RouteContext *)context {
  	//退出登录逻辑
    [context onFinished];
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

添加代码段后通过代码段创建路由，防止手写失误

```swift
@available(*, renamed: "route", message: "<#url#>")
@objc static func <#function#>(context: RouteContext) -> Void {
    <#code#>
}
```

`示例`
```swift
@available(*, renamed: "route", message: "swift://test/auth1")
@objc static func test1(context: RouteContext) -> Void {
  print(#file+" "+#function)
  context.onDone(true, result: "done")
}
```

### 路由调用

#### ObjC

```objc
//使用字符串
[RouteManager openURL:@"pg://test/login" object:nil completion:^(BOOL ret, NSString *object) {
  //TODO: do something
}];

//使用常量
[RouteManager openURL:PGRouteDefine.pg_test_login object:nil completion:^(BOOL ret, NSString *object) {
  //TODO: do something
}];

```

#### Swift

```swift
//使用字符串
RouteManager.openURL("pg://test/login?t=90812") { (ret, obj) in
    //TODO:do something                                          
}

//验证路由是否可用
RouteManager.dryRun("pg://test/validation") > true or false
```

```

## 常见问题

### Q. 编译不通过怎么办？

头文件的生成会有延迟或缓存，请尝试重新编译

## License

Peregrine 被许可在 MIT 协议下使用。查阅 LICENSE 文件来获得更多信息。

```
