//
//  ViewController.m
//  MajqFramework
//
//  Created by JQ on 2017/9/3.
//  Copyright © 2017年 majq. All rights reserved.
//

#import "ViewController.h"
#import "AFNetRequest.h"

#import "PHGradientView.h"
#import "PHProgressView.h"

#import "PHColorConfigure.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setUpConfig];
    
    CGSize size = [UIImage imageNamed:@"thumbImgView33"].size;
    
}


- (void)setUpConfig {

    
    
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    NSString *str = [NSString stringWithFormat:  @"{\"authorization\":\"%@\"}",@""];
    [params setObject:str forKey:@"parameters"];
    [AFNetRequest requestWithURL:@"loadIndex" params:params httpMethod:@"POST" block:^(id result) {
        
        NSLog(@"result = %@",result);
    }];
    
    
//    PHGradientView *g = [[PHGradientView alloc]initWithFrame:CGRectMake(30, 30, 200, 300)];
//    g.gradientcolor = [UIColor redColor];
//    [self.view addSubview:g];
//    [g drawGradient];
    
  
    
    PHProgressView *p = [[PHProgressView alloc]initWithFrame:CGRectMake(30, 300, 200, 26)];
//    p.backgroundColor = [UIColor grayColor];
    [self.view addSubview: p];
    p.progressPercentage = 0.5;
    p.progressHeight = 5;
    p.progressViewType = ProgressViewNotAllGradient;
    [p progressShow];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
