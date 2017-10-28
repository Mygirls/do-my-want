//
//  SecondViewController.m
//  NSHashTableTest
//
//  Created by JQ on 2017/10/16.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property(nonatomic,strong) UIView *v ;
@end

@implementation SecondViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title                = @"天道酬勤";
    
    [self.view addSubview:self.v];
    
    // 添加检测对象
    [ObjectDetector addToWatch:self.v];
}

- (UIView *)v
{
    if (_v == nil) {
        _v = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        
    }
    
    return _v;
    
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
