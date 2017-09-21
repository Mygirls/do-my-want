//
//  ViewController.m
//  RuntimeDemo_归档
//
//  Created by JQ on 2017/9/21.
//  Copyright © 2017年 Majq. All rights reserved.
//
//https://v.qq.com/x/page/o0504kw4h33.html
#import "ViewController.h"
#import "Person.h"

//#import <objc/runtime.h>
#import <objc/message.h>    //这个头文件里面导入了 #import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

//command + shift + g  前往文件夹

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    NSString *temPath = NSTemporaryDirectory();
//    NSLog(@"%@",temPath);
    ///Users/jq/Library/Developer/CoreSimulator/Devices/B4BC0AA9-CB31-487B-93B3-E45E6CC9B48A/data/Containers/Data/Application/5DAADBBA-B3D5-44FC-BA0B-8988DC8D7611/tmp/
    [self setUpConfig];
}



- (void)setUpConfig
{
    //运行时
    /**
     Method: 成员方法
     IvarI: 成员变量
     
     */
    unsigned int count = 0;
    
    //c语言中，经常看到的传递基本数据类型的指针
    class_copyIvarList([Person class], &count);
    NSLog(@"%d",count);
    
    
}



//存
- (IBAction)save:(id)sender {
    //创建
    Person *p = [[Person alloc] init];
    p.name = @"hank";
    p.age = 18;
    
    NSString *temPath = NSTemporaryDirectory();
    NSString *filePath = [temPath stringByAppendingPathComponent:@"hank.hank"];
    
    //归档！！
    [NSKeyedArchiver archiveRootObject:p toFile:filePath];
    
}

//取
- (IBAction)read:(id)sender {
    NSString *temPath = NSTemporaryDirectory();
    NSString *filePath = [temPath stringByAppendingPathComponent:@"hank.hank"];
    
    //解档
    Person *p = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"name = %@ ,age = %d",p.name,p.age);
}
@end
