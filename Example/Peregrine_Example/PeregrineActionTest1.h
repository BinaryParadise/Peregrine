//
//  PeregrineActionTest1.h
//  Peregrine_Example
//
//  Created by Rake Yang on 2019/5/6.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RouteDefine.h"

@interface PeregrineActionTest1 : NSObject

RouteDefine(verification1, "ap://tlbb/wyy?c=王语嫣1&result=%d");

RouteDefine(verification2, "ap://tlbb/yangmi?c=杨幂22");

RouteDefine(webview, "ap://webview/UIWebView");

@end
