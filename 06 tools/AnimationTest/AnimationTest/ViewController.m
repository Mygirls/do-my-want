//
//  ViewController.m
//  AnimationTest
//
//  Created by cfzq /Users/cfzq/Documents/我的文档/知识学习/06 tools/AnimationTest/AnimationTeston 2017/7/21.
//  Copyright © 2017年 cfzq. All rights reserved.
//

#import "ViewController.h"
#import "FViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *_loadingView = [[UIImageView alloc]initWithFrame:CGRectMake(110, 110, 50, 50)];
    _loadingView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_loadingView];
//    _loadingView.image = [UIImage imageNamed:@"4-01"];
    
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1000;
    rotationAnimation.removedOnCompletion = NO;

    [_loadingView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [self presentViewController:[FViewController new] animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
