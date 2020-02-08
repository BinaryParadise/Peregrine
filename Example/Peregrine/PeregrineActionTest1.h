//
//  PeregrineActionTest1.h
//  Peregrine_Example
//
//  Created by Rake Yang on 2019/5/6.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeregrineActionTest1 : NSObject

PGMethod(verification1, "ap://tlbb/wyy?c=王语嫣1&result=%d");

PGMethod(verification2, "ap://tlbb/yangmi?c=杨幂22");

PGMethod(webview, "ap://webview/UIWebView");

PGMethodA(wkwebview, "ap://webview/WKWebView");

PGMethodA(jscalloc, "ap://webview/calloc");

@end
