# Peregrine

[![CI Status](https://img.shields.io/travis/BinaryParadise/Peregrine.svg?style=flat)](https://travis-ci.org/BinaryParadise/Peregrine)
[![Version](https://img.shields.io/cocoapods/v/Peregrine.svg?style=flat)](https://cocoapods.org/pods/Peregrine)
[![Coverage Status](https://coveralls.io/repos/github/BinaryParadise/Peregrine/badge.svg)](https://coveralls.io/github/BinaryParadise/Peregrine)
[![Platform](https://img.shields.io/cocoapods/p/Peregrine.svg?style=flat)](https://cocoapods.org/pods/Peregrine)

## 原理

- 自定义clang的属性和插件[查看源码](https://github.com/BinaryParadise/clang/tree/peregrine)
- 生成AST时在插件中通过属性标识生成路由表，SDK读取路由表并注册，调用方即可使用指定路由

下载我已经编译好的`llvm`（`280M`），具体安装时间取决于你的网速

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

1.启用Code Coverage时会出现以下编译错误

```ruby
ld: file not found: /usr/local/Cellar/peregrine/0.2.3/lib/clang/9.0.0/lib/darwin/libclang_rt.profile_iossim.a
clang-9: error: linker command failed with exit code 1 (use -v to see invocation)
Command /usr/local/bin/clang failed with exit code 1
```

需要执行`test=1 pod install`才能正确启用单测覆盖率，但是路由表将不能自动生成

## License

Peregrine is available under the MIT license. See the LICENSE file for more info.
