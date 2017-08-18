//
//  ExampleWKWebViewController.m
//  ExampleApp-iOS
//
//  Created by Marcus Westin on 1/13/14.
//  Copyright (c) 2014 Marcus Westin. All rights reserved.
//

#import "ExampleWKWebViewController.h"
#import "WebViewJavascriptBridge.h"

@interface ExampleWKWebViewController ()

@property WebViewJavascriptBridge* bridge;

@end

@implementation ExampleWKWebViewController

- (void)viewWillAppear:(BOOL)animated {
    if (_bridge) { return; }
    
    WKWebView* webView = [[NSClassFromString(@"WKWebView") alloc] initWithFrame:self.view.bounds];
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    [_bridge setWebViewDelegate:self];
    
    //登记在objc的处理程序，并调用JS handler
    
    [_bridge registerHandler:@"ljj_copyText" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        responseCallback(@"Response from testObjcCallback");
    }];
    
    
    //调用名为handlerName的javascript处理程序。 如果给定了一个responseCallback块，则javascript处理程序可以响应。
    [_bridge callHandler:@"ljj_getUserInfo" data:@{ @"foo":@"before ready" }];
    
    //不安全的。 通过禁用setTimeout安全检查来加速桥接消息传递。 如果不调用任何javascript弹出框功能（警报，确认和提示），则禁用此安全检查是安全的。 如果您从桥接的JavaScript代码中调用这些函数，则应用程序将挂起。
    //[_bridge disableJavscriptAlertBoxSafetyTimeout];
    
    
    [self renderButtons:webView];
    [self loadExamplePage:webView];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"webViewDidStartLoad");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"webViewDidFinishLoad");
}

- (void)renderButtons:(WKWebView*)webView {
    UIFont* font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];
    
    UIButton *callbackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [callbackButton setTitle:@"Call handler" forState:UIControlStateNormal];
    [callbackButton addTarget:self action:@selector(callHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:callbackButton aboveSubview:webView];
    callbackButton.frame = CGRectMake(10, 400, 100, 35);
    callbackButton.titleLabel.font = font;
    
    UIButton* reloadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [reloadButton setTitle:@"Reload webview" forState:UIControlStateNormal];
    [reloadButton addTarget:webView action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:reloadButton aboveSubview:webView];
    reloadButton.frame = CGRectMake(110, 400, 100, 35);
    reloadButton.titleLabel.font = font;
}

- (void)callHandler:(id)sender {
    id data = @{ @"greetingFromObjC": @"Hi there, JS!" };
    
    //调用名为handlerName的javascript处理程序。 如果给定了一个responseCallback块，则javascript处理程序可以响应。
    [_bridge callHandler:@"ljj_getUserInfo" data:data responseCallback:^(id response) {
        NSLog(@"testJavascriptHandler responded: %@", response);
    }];
}

- (void)loadExamplePage:(WKWebView*)webView {
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [webView loadHTMLString:appHtml baseURL:baseURL];
}

/**
 * 复制链接
 */
- (void)copylinkBtnClick {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"这是要复制的测试内容";
    
    
    
//    /*通过名称获取粘贴板并且移除*/
//    + (void)removePasteboardWithName:(NSString *)pasteboardName;
//    
//    /*从粘贴板中获取数据，pasteboardType是自定义的，说明app可以处理哪种类型的数据*/
//    - (nullable NSData *)dataForPasteboardType:(NSString *)pasteboardType;
//    
//    /*data类型的数据放在粘贴板中，pasteboardType同上*/
//    - (void)setData:(NSData *)data forPasteboardType:(NSString *)pasteboardType;
//    
//    /*从粘贴板中取出data*/
//    - (nullable NSData *)dataForPasteboardType:(NSString *)pasteboardType;
}



@end
