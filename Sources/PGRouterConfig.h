//
//  PGRouterConfig.h
//  Peregrine
//
//  Created by Rake Yang on 2019/5/13.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>

static  NSString * _Nonnull const PGRouterKeyURL = @"url";
static  NSString * _Nonnull const PGRouterKeyClass = @"class";
static  NSString * _Nonnull const PGRouterKeySelector = @"selector";
static  NSString * _Nonnull const PGRouterKeySwift = @"swift";

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (Peregrine)

+ (instancetype)pg_SafeURLWithString:(NSString *)URLString;

@end

@interface PGRouterConfig : NSObject

@property (nonatomic, copy) NSURL *URL;
@property (nonatomic, copy, nullable) NSDictionary<NSString *,NSString *> *parameters;
@property (nonatomic, assign, nullable) Class targetClass;
@property (nonatomic, assign, nullable) SEL selector;

/// 是否是swift中定义，默认为NO
@property (nonatomic, assign) BOOL swift;


- (NSString *)actionName;

/**
 Create a instance

 @param keyValues {"url": "ap://tlbb/wyy", "class": "TestTarget", ...}
 @return instancetype
 */
- (instancetype)initWithDictionary:(NSDictionary<NSString *, NSString *> *)keyValues;

@end

NS_ASSUME_NONNULL_END
