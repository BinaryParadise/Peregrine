# Peregrine

[![CI Status](https://img.shields.io/travis/BinaryParadise/Peregrine.svg?style=flat)](https://travis-ci.org/BinaryParadise/Peregrine)
[![Version](https://img.shields.io/cocoapods/v/Peregrine.svg?style=flat)](https://cocoapods.org/pods/Peregrine)
[![Coverage Status](https://coveralls.io/repos/github/BinaryParadise/Peregrine/badge.svg?branch=master)](https://coveralls.io/github/BinaryParadise/Peregrine?branch=master)
[![Platform](https://img.shields.io/cocoapods/p/Peregrine.svg?style=flat)](https://cocoapods.org/pods/Peregrine)



一个高效、灵活、使用方便的路由组件

## 原理

### Clang模式

> llvm: git@github.com:llvm-mirror/llvm.git afd251138596045d02a43768d4b338432580f3bf
> clang: git@github.com:BinaryParadise/clang.git 2c4ca6832fa6b306ee6a7010bfb80a3f2596f824 [查看源码](https://github.com/BinaryParadise/clang/tree/clang11)

1. ~~Plugin【不推荐】: 高效，在编译阶段就生成，得使用额外编译的clang，可能存在隐藏问题~~

  - 自定义clang的属性和插件
  - 生成AST时在插件中通过属性标识生成路由表，SDK读取路由表并注册，调用方即可使用指定路由~~
2. LibTooling: 独立工具，对项目无侵入，可能会存在编译是头文件找不到的问题（待解决）
  - 原理同Plugin

**插件安装**

```ruby
# 通过brew安装已经编译好的`llvm`（预计`300M`），具体安装时间取决于你的网速
brew tap binaryparadise/formula
brew install peregrine
```

## 集成

> 默认为正则匹配模式

```ruby
pod 'Peregrine', '~> 0.6.0'

post_install do |installer|
  require_relative 'Pods/Peregrine/Peregrine/PGGenerator.rb'
  # 依赖库判断条件
  callback = proc { |name| name.index("Peregrine") == 0 }
  # true表示使用正则匹配模式
  PGGenerator::configure_project(installer, true, callback)
end
```

```ruby
pod install

or Enable Code Coverage

test=1 pod install
```

### 导入头文件


```objc
#import <Peregrine/Peregrine.h>
```

### 注册路由

```objc

@interface TestClass

PGMethod(method,"ap://tlbb/wyy")

@end

@implement TestClass

@end

// 实现路由
+ (void)method:(PGRouterContext *)context {
  //TOOD: do something
}

```
### 调用路由

```objc
[PGRouterManager<NSNumber *> openURL:@"ap://tlbb/wyy?result=1" completion:^(BOOL ret, NSNumber * _Nonnull object) {
  //TOOD: do something
}];

```

## 常见问题

### Q. Clang模式编译不通过怎么办？

目前遇到在使用PCH等一些场景下编译时找不到头文件的问题解决，推荐使用`正则匹配模式`，待以后解决

### Q. 正则模式编译不通过怎么办？

头文件的生成会有延迟，请尝试重新编译

## 协议

Peregrine 被许可在 MIT 协议下使用。查阅 LICENSE 文件来获得更多信息。