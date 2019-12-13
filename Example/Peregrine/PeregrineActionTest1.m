//
//  PeregrineActionTest1.m
//  Peregrine_Example
//
//  Created by Rake Yang on 2019/5/6.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "PeregrineActionTest1.h"
#import "FPWebViewViewController.h"

@implementation PeregrineActionTest1

+ (void)verification1:(nullable PGRouterContext *)context {    
    NSAssert([context.config.actionName isEqualToString:@"wyy"], @"not the same");
    [context onDone:YES object:context.userInfo[@"result"]];
}

+ (void)verification2:(nullable PGRouterContext *)context {
    [context finished];
}

+ (void)webview:(PGRouterContext *)context {
    FPWebViewViewController *vc = [[FPWebViewViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
        [context finished];
    }];
}

+ (void)wkwebview:(PGRouterContext *)context {
    FPWebViewViewController *vc = [[FPWebViewViewController alloc] init];
    vc.webkit = YES;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
        [context finished];
    }];
}

+ (void)jscalloc:(PGRouterContext *)context {
    [context onDone:YES object:context.userInfo[@"c"]];
}

@end
