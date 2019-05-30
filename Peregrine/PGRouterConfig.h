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

NS_ASSUME_NONNULL_BEGIN

@interface PGRouterConfig : NSObject

@property (nonatomic, copy) NSURL *URL;
@property (nonatomic, assign) Class targetClass;
@property (nonatomic, assign) SEL selector;

- (NSString *)actionName;

/**
 Create a instance

 @param keyValues {"url": "ap://tlbb/wyy", "class": "TestTarget", ...}
 @return instancetype
 */
- (instancetype)initWithDictionary:(NSDictionary<NSString *, NSString *> *)keyValues;

@end

NS_ASSUME_NONNULL_END
