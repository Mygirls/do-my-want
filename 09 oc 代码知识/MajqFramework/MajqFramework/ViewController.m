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

#import "PHIconLabelView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self setUpConfig];
    
    
    PHIconLabelView *v = [[PHIconLabelView alloc]initWithFrame:CGRectMake(20, 20, 100, 80)];
    v.backgroundColor = [UIColor orangeColor];
    v.imgName = @"thumbImgView1";
    v.labelTitle = @"thumbImgView1";
    v.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:v];
    [v viewShow:labelUp iconSize:CGSizeMake(26, 26) labelSize:CGSizeMake(100, 20) up:10 middle:10];
    
    
    PHIconLabelView *v2 = [[PHIconLabelView alloc]initWithFrame:CGRectMake(20, 220, 100, 80)];
    v2.backgroundColor = [UIColor orangeColor];
    v2.imgName = @"thumbImgView1";
    v2.labelTitle = @"thumbImgView1";
    v2.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:v2];
    [v2 viewShow:lableRight iconSize:CGSizeMake(26, 26) labelSize:CGSizeMake(100, 20) up:10 middle:10];
    

    PHProgressView *p = [[PHProgressView alloc]initWithFrame:CGRectMake(30, 20, 200, 26)];
    p.backgroundColor = [UIColor grayColor];
    [self.view addSubview: p];
    p.progressPercentage = 0;
    p.progressHeight = 5;
    p.progressViewType = ProgressViewAllGradient;
    [p progressShow];
    
    PHProgressView *p1 = [[PHProgressView alloc]initWithFrame:CGRectMake(30, 100, 200, 26)];
    p1.backgroundColor = [UIColor grayColor];
    [self.view addSubview: p1];
    p1.progressPercentage = 0.5;
    p1.progressHeight = 5;
    p1.progressViewType = ProgressViewAllGradient;
    [p1 progressShow];
    
    PHProgressView *p2 = [[PHProgressView alloc]initWithFrame:CGRectMake(30, 200, 200, 26)];
    p2.backgroundColor = [UIColor grayColor];
    [self.view addSubview: p2];
    p2.progressPercentage = 0.9;
    p2.progressHeight = 5;
    p2.progressViewType = ProgressViewAllGradient;
    p2.progressColors = @[(__bridge id)[UIColor blueColor].CGColor];
    [p2 progressShow];
    
    PHProgressView *p3 = [[PHProgressView alloc]initWithFrame:CGRectMake(30, 300, 200, 26)];
    p3.backgroundColor = [UIColor grayColor];
    [self.view addSubview: p3];
    p3.progressPercentage = 1;
    p3.progressHeight = 5;
    p3.progressViewType = ProgressViewAllGradient;
    [p3 progressShow];
    
    
//    PHProgressView *p1 = [[PHProgressView alloc]initWithFrame:CGRectMake(30, 100, 200, 26)];
//    p1.backgroundColor = [UIColor grayColor];
//    [self.view addSubview: p1];
//    p1.progressPercentage = 1;
//    p1.progressHeight = 5;
//    p1.progressViewType = ProgressViewAllGradient;
//    [p1 progressShow];

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
