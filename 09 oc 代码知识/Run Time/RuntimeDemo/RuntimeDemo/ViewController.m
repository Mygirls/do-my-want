//
//  ViewController.m
//  RuntimeDemo
//
//  Created by JQ on 2017/9/20.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

#import <objc/message.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self setUpTest01];
    
    //[self setUpTest02];

    //[self setUpTest03];
    
    //[self setUpTest04];
    
    //[self setUpTest05];
    
    [self setUpTest06];

}

//第一步
- (void) setUpTest01 {
    Person *p = [[Person alloc] init];
    [p eat];
}

//第二步
- (void)setUpTest02 {
    
    Person *p = [Person alloc];
    
    p = [p init];
    
    //[p eat];
    
    [p performSelector:@selector(eat)];
}

//消息机制
- (void)setUpTest03 {
    //Person *p = [Person alloc];
    //类方法 其实类也是一个对象，oc 表示类 类型，swift 表示元 类型
    Person *p = objc_msgSend([Person class], @selector(alloc));
    
    //p = [p init];
    p = objc_msgSend(p, @selector(init));

    //objc_msgSend(p,@selector(eat))    //编译报错
    /**
         1. target -> build setting ,搜索 msg
         2. Enable Strict Cheaking of objc_msgSend Calls 设置为No
         、设置以后就不会编译错误了，因为oc 不推荐使用底层去实现
     */
 
    objc_msgSend(p,@selector(eat));
    //objc_msgSend(<#id  _Nullable self#>, <#SEL  _Nonnull op, ...#>) //... 可扩展参数
}


- (void)setUpTest04 {
    //Person *p = [Person alloc];
    //类方法 其实类也是一个对象，oc 表示类 类型，swift 表示元 类型
    //Person *p = objc_msgSend(objc_getClass("Person"), @selector(alloc));
    Person *p = objc_msgSend(objc_getClass("Person"), sel_registerName("alloc"));

    //p = objc_msgSend(p, @selector(init));
    p = objc_msgSend(p, sel_registerName("init"));
    
   // objc_msgSend(p,@selector(eat));
    objc_msgSend(p,sel_registerName("eat"));
}

//不带参数
- (void)setUpTest05 {
    //Person *p = [Person alloc];
    //类方法 其实类也是一个对象，oc 表示类 类型，swift 表示元 类型
    //Person *p = objc_msgSend(objc_getClass("Person"), @selector(alloc));
    Person *p = objc_msgSend(objc_msgSend(objc_getClass("Person"), sel_registerName("alloc")), sel_registerName("init"));
    objc_msgSend(p,sel_registerName("eat"));
}

//带参数
- (void)setUpTest06 {
    Person *p = objc_msgSend(objc_msgSend(objc_getClass("Person"), sel_registerName("alloc")), sel_registerName("init"));
    objc_msgSend(p,sel_registerName("eat:"),@"香蕉"); //记得 冒号:
    //objc_msgSend(<#id  _Nullable self#>, <#SEL  _Nonnull op, ...#>)
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
