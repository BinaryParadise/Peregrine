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

+ (void)verification1:(nullable RouteContext *)context {
    [context onDone:YES result:context.userInfo[@"result"]];
}

+ (void)verification2:(nullable RouteContext *)context {
    [context onDone:true result:context.userInfo];
}

+ (void)webview:(RouteContext *)context {
    FPWebViewViewController *vc = [[FPWebViewViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
        [context onFinished];
    }];
}

+ (void)wkwebview:(RouteContext *)context {
    FPWebViewViewController *vc = [[FPWebViewViewController alloc] init];
    vc.webkit = YES;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
        [context onFinished];
    }];
}

+ (void)jscalloc:(RouteContext *)context {
    [context onDone:YES result:context.userInfo[@"c"]];
}

@end
