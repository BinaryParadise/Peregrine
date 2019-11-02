# Peregrine

[![CI Status](https://img.shields.io/travis/BinaryParadise/Peregrine.svg?style=flat)](https://travis-ci.org/BinaryParadise/Peregrine)
[![Version](https://img.shields.io/cocoapods/v/Peregrine.svg?style=flat)](https://cocoapods.org/pods/Peregrine)
[![Coverage Status](https://coveralls.io/repos/github/BinaryParadise/Peregrine/badge.svg?branch=master)](https://coveralls.io/github/BinaryParadise/Peregrine?branch=master)
[![Platform](https://img.shields.io/cocoapods/p/Peregrine.svg?style=flat)](https://cocoapods.org/pods/Peregrine)

## 原理

> llvm: git@github.com:llvm-mirror/llvm.git 2c4ca6832fa6b306ee6a7010bfb80a3f2596f824
> clang: git@github.com:BinaryParadise/clang.git 65acf43270ea2894dffa0d0b292b92402f80c8cb [查看源码](https://github.com/BinaryParadise/clang/tree/peregrine)

~~1. Plugin（不推荐）: 高效，在编译阶段就生成，得使用额外编译的clang，可能存在隐藏问题~~
  - 自定义clang的属性和插件
  - 生成AST时在插件中通过属性标识生成路由表，SDK读取路由表并注册，调用方即可使用指定路由~~
2. LibTooling: 独立工具，对项目无侵入，但是执行效率低，相当于重新编译项目
  - 原理同Plugin

通过brew安装已经编译好的`llvm`（预计`280M`），具体安装时间取决于你的网速

```ruby
brew tap binaryparadise/formula
brew install peregrine
```

## 安装

> 默认为插件模式

```ruby
pod 'Peregrine'
```

```ruby
pod install

or Enable Code Coverage

test=1 pod install
```

## 使用


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

## License

Peregrine is available under the MIT license. See the LICENSE file for more info.
