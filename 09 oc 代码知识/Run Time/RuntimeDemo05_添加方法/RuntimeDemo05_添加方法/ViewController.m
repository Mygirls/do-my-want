//
//  ViewController.m
//  RuntimeDemo05_添加方法
//
//  Created by JQ on 2017/9/23.
//  Copyright © 2017年 Majq. All rights reserved.
//
/**
 1.调用的方法的时候去添加一个方法
 
 */
#import "ViewController.h"
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Person *p = [[Person alloc] init];
    
    //调用eat 的方法 没参数
//    [p performSelector:@selector(eat)];
    
    //调用eat 的方法 有参数
    [p performSelector:@selector(eat:) withObject:@"鸡腿饭"];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
