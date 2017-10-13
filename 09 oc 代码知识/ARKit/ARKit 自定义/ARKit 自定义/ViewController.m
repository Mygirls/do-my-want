//
//  ViewController.m
//  ARKit 自定义
//
//  Created by JQ on 2017/10/10.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "ViewController.h"
#import "ARSCNViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//开启AR
- (IBAction)startButtonClick:(id)sender {
    ARSCNViewController *vc = [[ARSCNViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
