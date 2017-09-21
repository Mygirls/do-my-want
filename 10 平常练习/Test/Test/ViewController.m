//
//  ViewController.m
//  Test
//
//  Created by JQ on 2017/9/20.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "ViewController.h"
#import "Test.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Class lc = [self class];
    /**
     首先我们需要知道的是super与self不同。self是类的一个隐藏参数，每个方法的实现的第一个参数即为self。
     而super并不是隐藏参数，它实际上只是一个”编译器标示符”，它负责告诉编译器，当调用viewDidLoad方法时，去调用父类的方法，而不是本类中的方法。而它实际上与self指向的是相同的消息接收者。为了理解这一点，我们先来看看super的定义：
     
     struct objc_super { id receiver; Class superClass; };
     
     这个结构体有两个成员：
     
     receiver：即消息的实际接收者
     superClass：指针当前类的父类
     当我们使用super来接收消息时，编译器会生成一个objc_super结构体。就上面的例子而言，这个结构体的receiver就是MyViewController对象，与self相同；superClass指向MyViewController的父类UIViewController。
     
     接下来，发送消息时，不是调用objc_msgSend函数，而是调用objc_msgSendSuper函数，其声明如下：
     该函数第一个参数即为前面生成的objc_super结构体，第二个参数是方法的selector。该函数实际的操作是：从objc_super结构体指向的superClass的方法列表开始查找viewDidLoad的selector，找到后以objc->receiver去调用这个selector，而此时的操作流程就是如下方式了
     
     objc_msgSend(objc_super->receiver, @selector(viewDidLoad))
     由于objc_super->receiver就是self本身，所以该方法实际与下面这个调用是相同的：
     
     objc_msgSend(self, @selector(viewDidLoad))

     */
    Test *t = [[Test alloc] init];
    [t test];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
