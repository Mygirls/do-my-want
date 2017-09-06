//
//  ViewController.m
//  MajqFramework
//
//  Created by JQ on 2017/9/3.
//  Copyright © 2017年 majq. All rights reserved.
//

#import "ViewController.h"
#import "AFNetRequest.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setUpConfig];
}


- (void)setUpConfig {

    self.view.backgroundColor = [UIColor orangeColor];
    
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    NSString *str = [NSString stringWithFormat:  @"{\"authorization\":\"%@\"}",@""];
    [params setObject:str forKey:@"parameters"];
    [AFNetRequest requestWithURL:@"loadIndex" params:params httpMethod:@"POST" block:^(id result) {
        
        NSLog(@"result = %@",result);
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
