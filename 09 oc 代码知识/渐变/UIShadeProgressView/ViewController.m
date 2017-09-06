//
//  ViewController.m
//  UIShadeProgressView
//
//  Created by JQ on 2017/9/6.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "ViewController.h"
#import "ShadeView.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ShadeView *shadeView = [[ShadeView alloc]initWithFrame:CGRectMake(100, 100, 100, 300)];
    
    shadeView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:shadeView];
    
}



@end
