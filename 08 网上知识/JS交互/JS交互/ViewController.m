//
//  ViewController.m
//  JS交互
//
//  Created by cfzq on 2017/8/15.
//  Copyright © 2017年 cfzq. All rights reserved.
//

#import "ViewController.h"
#import "WKWebViewJavascriptBridge.h"
#import "WebViewJavascriptBridge.h"
#define IS_IPHONE_6PLUS (IS_IPHONE && [[UIScreen mainScreen] scale] == 3.0f)
/**
 * 屏幕的宽高
 */
#define KScreen_Width  [UIScreen mainScreen].bounds.size.width
#define KScreen_Height [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UIScrollViewDelegate,UIWebViewDelegate,WKNavigationDelegate>
@property (nonatomic,strong) WebViewJavascriptBridge *bridge;
@property (nonatomic,strong) WKWebViewJavascriptBridge* wkBridge;

@property(nonatomic,strong)NSDictionary *dic;


@end

@implementation ViewController


- (NSDictionary *)dic{
    if (_dic == nil) {
        _dic = [[NSDictionary alloc]init];
        
    }
    
    return _dic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dic = @{@"loginResult":@"loginOK"};
    
    [self jsMutually];
    
    [_wkBridge send: self.dic responseCallback:^(id responseData) {
    }]; ////发送成功回调
    
}


- (void)jsMutually
{
    if (_wkBridge) { return; }
    WKWebView* webView = [[NSClassFromString(@"WKWebView") alloc] initWithFrame:CGRectMake(0, 64, KScreen_Width, KScreen_Height - 64 )];
    webView.navigationDelegate = self;
    webView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:webView];
    [WKWebViewJavascriptBridge enableLogging];
    _wkBridge = [WKWebViewJavascriptBridge bridgeForWebView:webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *result = data;
        [self dealWithSomething:result];//点击做出处理
    }];
    [_wkBridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
    }];
    [_wkBridge callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" }];
    [self loadKkExamplePage:webView];
        
}

#pragma mark - 点击webView 回调
- (void)dealWithSomething:(NSDictionary *)dic {


}

- (void)webViewDidStartLoad:(UIWebView *)webView {
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
}

- (void)loadExamplePage:(UIWebView*)webView {
    NSString *detailURL = [NSString stringWithFormat:@"%@",self.detailURL];
    NSString *strUrl = [detailURL stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
    [webView loadRequest:request];
}


- (void)loadKkExamplePage:(WKWebView*)webView {
    NSString *detailURL = [NSString stringWithFormat:@"%@",self.detailURL];
    NSString *strUrl = [detailURL stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
    [webView loadRequest:request];
}
@end
