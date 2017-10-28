//
//  RootViewController.m
//  NSHashTableTest
//
//  Created by JQ on 2017/10/16.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "RootViewController.h"
#import "SecondViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title               = @"任重而道远";
    UIButton *button         = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    button.center            = self.view.center;
    button.layer.borderWidth = 1.f;
    button.titleLabel.font   = [UIFont fontWithName:@"HelveticaNeue-UltraLight"
                                               size:20.f];
    [button setTitle:@"YouXianMing" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(buttonEvent:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonEvent:(UIButton *)button
{
    [self.navigationController pushViewController:[SecondViewController new]
                                         animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
