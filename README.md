# Peregrine

[![CI Status](https://img.shields.io/travis/BinaryParadise/Peregrine.svg?style=flat)](https://travis-ci.org/BinaryParadise/Peregrine)
[![Version](https://img.shields.io/cocoapods/v/Peregrine.svg?style=flat)](https://cocoapods.org/pods/Peregrine)
[![Coverage Status](https://coveralls.io/repos/github/BinaryParadise/Peregrine/badge.svg)](https://coveralls.io/github/BinaryParadise/Peregrine)
[![Platform](https://img.shields.io/cocoapods/p/Peregrine.svg?style=flat)](https://cocoapods.org/pods/Peregrine)

## 原理

> llvm: git@github.com:llvm-mirror/llvm.git 8cc3221f7770718b0416cec1c2592731b080166f
> clang: git@github.com:BinaryParadise/clang.git 6c72a67631d1ac338630c4670218959f4ab682d2 [查看源码](https://github.com/BinaryParadise/clang/tree/peregrine)

1. Plugin: 高效，在编译阶段就生成，得使用额外编译的clang，可能存在隐藏问题
  - 自定义clang的属性和插件
  - 生成AST时在插件中通过属性标识生成路由表，SDK读取路由表并注册，调用方即可使用指定路由
2. LibTooling: 独立工具，对项目无侵入，但是执行效率低，相当于重新编译项目
  - 原理同Plugin

下载已经编译好的`llvm`（`280M`），具体安装时间取决于你的网速

```ruby
brew tap binaryparadise/formula
brew install peregrine
```

## 安装

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
+ (void)method:(PGRouterContext *)context PGTarget("ap://tlbb/wyy") {
  //TOOD: do something
}

```
### 打开路由

```objc
[PGRouterManager<NSNumber *> openURL:@"ap://tlbb/wyy?result=1" completion:^(BOOL ret, NSNumber * _Nonnull object) {
  //TOOD: do something
}];
```

## 常见问题

1. Plugin方式启用Code Coverage时会出现以下编译错误?

```ruby
ld: file not found: /usr/local/Cellar/peregrine/0.2.3/lib/clang/9.0.0/lib/darwin/libclang_rt.profile_iossim.a
clang-9: error: linker command failed with exit code 1 (use -v to see invocation)
Command /usr/local/bin/clang failed with exit code 1
```

需要执行`test=1 pod install`才能正确启用单测覆盖率，但是路由表将不能自动生成

## License

Peregrine is available under the MIT license. See the LICENSE file for more info.
