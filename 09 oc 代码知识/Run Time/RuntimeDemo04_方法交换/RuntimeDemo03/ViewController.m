//
//  ViewController.m
//  RuntimeDemo03
//
//  Created by JQ on 2017/9/21.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "ViewController.h"
#import "NSURL+url.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/中文"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"%@",url);   //有中文的时候 输出为 null
    
//    NSURL *url2 = [NSURL HK_URLWSTR:@"http://www.baidu.com/中文"];
//    NSLog(@"%@",url2);   

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
