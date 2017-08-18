//
//  ViewController.m
//  JS
//
//  Created by cfzq on 2017/8/15.
//  Copyright © 2017年 cfzq. All rights reserved.
//

#import "ViewController.h"
#import "ExampleWKWebViewController.h"
#import "ExampleUIWebViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *callbackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [callbackButton setTitle:@"Call handler" forState:UIControlStateNormal];
    [callbackButton addTarget:self action:@selector(callHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:callbackButton];
    callbackButton.frame = CGRectMake(10, 400, 100, 35);
    
//    UIButton* reloadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [reloadButton setTitle:@"Reload webview" forState:UIControlStateNormal];
//    [reloadButton addTarget:webView action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
//    [self.view insertSubview:reloadButton aboveSubview:webView];
//    reloadButton.frame = CGRectMake(110, 400, 100, 35);
//    reloadButton.titleLabel.font = font;

    
}


- (void)callHandler:(id)sender {
    
    ExampleUIWebViewController *vc = [[ExampleUIWebViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
