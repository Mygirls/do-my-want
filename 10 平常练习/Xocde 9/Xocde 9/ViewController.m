//
//  ViewController.m
//  Xocde 9
//
//  Created by JQ on 2017/9/21.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    int a ;
    
    int *p = &a;
    
    *p = 3;
   
    
    NSLog(@"%d",a);
    
    int b1 = 2;
    int b2 = 3;
    
    swapT(&b1, &b2);
    
    NSLog(@"%d %d",b1,b2);
    
}

void swapT(int *a, int *b) {
    int t = *a;
    
    *a = *b;
    
   * b = t;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
