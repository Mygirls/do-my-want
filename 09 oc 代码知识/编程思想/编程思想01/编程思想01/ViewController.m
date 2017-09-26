//
//  ViewController.m
//  编程思想01
//
//  Created by JQ on 2017/9/25.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+add.h"
@interface ViewController ()

@property(nonatomic,strong)Person *p;
@property(nonatomic,strong)NSMutableString *name;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setUpConfig];
}


- (void)setUpConfig
{
    [self testBlock01];
    
    [self testBlock02];
    
    [self testBlock03];
    
    [self testBlock04];
    
    [self testBlock05];
    
}

#pragma mark - 链式编程思想前言： Block 回顾
/**
 //输入 inlineBlock 会自动提示
 //标准的block 格式
 //    <#returnType#>(^<#blockName#>)(<#parameterTypes#>) = ^(<#parameters#>) {
 //        <#statements#>
 //    };
 
 
 //完整的block 格式 ，注意 ^id
 //    id(^testBlock)(int a, int b) = ^ id (int a, int b) {
 //
 //        return nil;
 //    };
 
 */
//作为属性
- (void)testBlock01 {
    _p = [[Person alloc] init];
    _p.myBlock = ^{
        NSLog(@"block 作为属性");
    };
    
    _p.myBlock();
}

- (void)testMemory
{
    
    NSLog(@"测试内存泄漏");
}

//作为参数
- (void)testBlock02 {
    
    [_p eat:^{
        NSLog(@"block 作为参数");
    }];
    
}

//作为返回值
- (void)testBlock03 {
    
    _p.play();
    
    _p.see(5);
    
    
}


#pragma mark - 链式编程思想： 返回值是函数的调用者
- (void)testBlock04 {
    _p.sleep(2).sleep(3);
    
}

- (void)testBlock05
{
//    [NSObject majq_Add:^(AddManager *manage) {
//
//        [manage add:8];
//        
//    }];
//    
//    [NSObject majq_Add:^(AddManager *manage) {
//        
//        manage.add(8);
//        
//    }];

    [NSObject majq_Add:^(AddManager *manage) {
       manage.add(1).add(3).add(5);
        NSLog(@"%d",manage.sum);
    }];
    
}

@end
