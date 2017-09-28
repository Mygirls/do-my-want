//
//  ViewController.m
//  Runloop
//
//  Created by JQ on 2017/9/27.
//  Copyright © 2017年 Majq. All rights reserved.
//
/**
 //http://www.cnblogs.com/azuo/archive/2016/10/26/5975479.html
 
 
 */
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self setUpConfig];
}


- (void)setUpConfig
{
    [self test01];
    
}

//runloop 初探
- (void)test01 {
    
    //创建一个定时器： 
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(timerMehtod)
                                                    userInfo:nil
                                                     repeats:YES];



}



- (void)timerMehtod {
    static int i = 10;
    i = i + 1;
    
    //主线程
    NSThread *thread = [NSThread currentThread];
    NSLog(@"currentThread = %@  i = %d",thread,i);  //currentThread = <NSThread: 0x6040002619c0>{number = 1, name = main}  i = 22
    
}



@end
