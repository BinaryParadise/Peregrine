//
//  FPWebViewViewController.m
//  Peregrine_Example
//
//  Created by Rake Yang on 2019/10/28.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "FPWebViewViewController.h"
#import <WebKit/WebKit.h>
#import <Peregrine/Peregrine.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol FPJSExportProtocol <JSExport>

- (NSString *)callFromJS:(NSString *)data;

@end

@interface FPJSExportObj : NSObject <FPJSExportProtocol>

@end

@implementation FPJSExportObj

- (NSString *)callFromJS:(NSString *)data {
    return data;
}

@end

@interface FPWebViewViewController () <WKNavigationDelegate, UIWebViewDelegate, WKScriptMessageHandler, WKUIDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation FPWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"webview.html" ofType:nil];
    if (self.webkit) {
        //属性设置
        WKWebViewConfiguration *webViewConfig = [[WKWebViewConfiguration alloc] init];
        webViewConfig.preferences = [WKPreferences new];
        webViewConfig.preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        webViewConfig.preferences.javaScriptCanOpenWindowsAutomatically = YES;
        
        //注册自定义脚本
        WKUserScript *userScript = [[WKUserScript alloc] initWithSource:@"" injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [webViewConfig.userContentController addUserScript:userScript];
        [webViewConfig.userContentController addScriptMessageHandler:self name:@"objc"];
        
        self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:webViewConfig];
        self.wkWebView.navigationDelegate = self;
        self.wkWebView.UIDelegate = self;
        [self.view addSubview:self.wkWebView];
        [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]]];
    } else {
        self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        self.webView.delegate = self;
        [self.view addSubview:self.webView];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]]];
    }
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(onCancel:)];
}

- (void)onCancel:(UIButton *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIWebView

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType API_DEPRECATED("No longer supported.", ios(2.0, 12.0)) {
    if ([PGRouterManager dryRun:request.URL.absoluteString]) {
        [PGRouterManager openURL:request.URL.absoluteString completion:^(BOOL ret, id object) {
            [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"callJSFunc('%@')", [object stringByRemovingPercentEncoding]]];
        }];
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView API_DEPRECATED("No longer supported.", ios(2.0, 12.0)) {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView API_DEPRECATED("No longer supported.", ios(2.0, 12.0)) {
    [webView stringByEvaluatingJavaScriptFromString:@"disableWKWebView()"];
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"exportoc"] = [[FPJSExportObj alloc] init];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error API_DEPRECATED("No longer supported.", ios(2.0, 12.0)) {
    
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView evaluateJavaScript:@"disableUIWebBtn()" completionHandler:^(id _Nullable ret, NSError * _Nullable error) {
        
    }];
}

#pragma mark - WKUIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (completionHandler) {
            completionHandler();
        }
    }]];
    [self presentViewController:alertVC animated:YES completion:^{
        
    }];
//    [PGRouterManager openURL:ap_tlbb_ym completion:nil];
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary *dict = message.body;
    if ([PGRouterManager dryRun:dict[@"url"]]) {
        [PGRouterManager openURL:dict[@"url"] completion:^(BOOL ret, id object) {
            if (dict[@"callback"]) {             
                [message.webView evaluateJavaScript:[NSString stringWithFormat:@"%@('%@')",dict[@"callback"], [object stringByRemovingPercentEncoding]] completionHandler:^(id _Nullable ret, NSError * _Nullable error) {
                    
                }];
            }
        }];
    }
}

- (void)dealloc {
    [self.wkWebView.configuration.userContentController removeAllUserScripts];
}

@end
