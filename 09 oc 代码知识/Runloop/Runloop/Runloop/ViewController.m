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
#import "MajqThread.h"
@interface ViewController ()

@property(nonatomic,assign) BOOL finished;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self setUpConfig];
}


- (void)setUpConfig
{
    //[self test01];
    
    //[self test02];
    
    //[self test03];

    //[self test04];
    
    //[self test05];
    
    //[self test06];
    
    //[self test07];
    
    [self test08];

}
#pragma mark - runloop 初探
- (void)test01 {
    
    //默认添加到runloop
    //创建一个定时器： 但是当UI 响应的时候，定时器就会停止了(这么处理不行)
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(timerMehtod)
                                                    userInfo:nil
                                                     repeats:YES];

    NSLog(@"timer = %@",timer);

}

- (void)test02 {
    //默认没有添加到runloop，需要手动加入
    //创建一个定时器： 但是当UI 响应的时候，定时器就会停止了(这么处理不行)
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerMehtod) userInfo:nil repeats:YES];
    
    //把timer 添加到线程里面，否则是无法运行定时器的
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)test03 {
    //默认没有添加到runloop，需要手动加入
    //创建一个定时器： 但是当UI 响应的时候，定时器就会 不会停止了(这么处理还是不行，请继续看)
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerMehtod) userInfo:nil repeats:YES];
    
    //把timer 添加到线程里面，否则是无法运行定时器的
    //模式：
    // NSDefaultRunLoopMode     在默认模式下调用 timerMehtod（只要有事件就处理）
    // UITrackingRunLoopMode    有限切换）在UI模式下才能调用timerMehtod，（这个模式是当UI事件交互的时候runloop 切换到的模式）
    // NSRunLoopCommonModes     在默认和UITracking下（占位符）
    //[[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    
    // NSRunLoopCommonModes 相当于 同时执行NSDefaultRunLoopMode、UITrackingRunLoopMode 两种模式
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    
}

- (void)timerMehtod {
    static int i = 10;
    i = i + 1;
    
    //主线程
    NSThread *thread = [NSThread currentThread];
    NSLog(@"currentThread = %@  i = %d",thread,i);  //currentThread = <NSThread: 0x6040002619c0>{number = 1, name = main}  i = 22
    
}

#pragma mark - 问题
- (void)test04 {

    //定时器会继续调用，但是当滑动UI的时候，会发生卡顿
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerMehtod2) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];

}

- (void)test05 {
    
    //定时器会继续调用，但是当滑动UI的时候，解决卡顿事件卡顿： 开启一个子线程，但是timerMehtod2 不调用？？
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
       
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerMehtod2) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        
        NSLog(@"已经运行到这里了");
    }];
    
    //开启现场
    [thread start];
    
}

- (void)test06 {
    
    //定时器会继续调用，但是当滑动UI的时候，解决卡顿事件卡顿： 开启一个子线程，
    MajqThread *thread = [[MajqThread alloc] initWithBlock:^{
        
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerMehtod2) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        
        NSLog(@"currentThread1 = %@",[NSThread currentThread]); //子线程
        
        ////会输出 销毁了  说明 对象 thread 销毁了
        //子线程 默认是不开启 runloop 循环，那么 是程序不退出，怎么办？？
        
        [[NSRunLoop currentRunLoop] run];

    }];
    
    //开启现场
    [thread start];
}
#pragma mark - runLoop  性能优化
- (void)test07 {
    
    _finished = NO;
    //定时器会继续调用，但是当滑动UI的时候，解决卡顿事件卡顿： 开启一个子线程，但是 这个线程一直在run 好性能，怎么破？？？
    MajqThread *thread = [[MajqThread alloc] initWithBlock:^{
        
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerMehtod2) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
      
        //[[NSRunLoop currentRunLoop] run]; //这个线程一直在run 好性能，怎么破？？？
        while (!_finished) {    //点击屏幕 设置_finished  是线程关闭
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
        }
        
    }];
    
    //开启现场
    [thread start];
    
}

- (void)timerMehtod2 {
    
    static int i = 10;
    i = i + 1;
    
    [NSThread sleepForTimeInterval:1];  //模拟耗时操作
    
    //主线程
    NSThread *thread = [NSThread currentThread];
    NSLog(@"currentThread = %@  i = %d",thread,i);  //currentThread = <NSThread: 0x6040002619c0>{number = 1, name = main}  i = 22
    
}

- (void)test08 {
    
    _finished = NO;
    //定时器会继续调用，但是当滑动UI的时候，解决卡顿事件卡顿： 开启一个子线程，但是 这个线程一直在run 好性能，怎么破？？？
    MajqThread *thread = [[MajqThread alloc] initWithBlock:^{
        
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerMehtod3) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        
        [[NSRunLoop currentRunLoop] run]; //这个线程一直在run 好性能，怎么破？？？
        
    }];
    
    //开启现场
    [thread start];
    
}


- (void)timerMehtod3 {
    
    static int j = 10;
    j = j + 1;
    
    if (j == 15) {
        NSLog(@"currentThread = %@  j = %d",[NSThread currentThread],j);
        [NSThread exit];
    }
    [NSThread sleepForTimeInterval:1];  //模拟耗时操作
    
    //主线程
    NSThread *thread = [NSThread currentThread];
    NSLog(@"currentThread = %@  i = %d",thread,j);
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"点击了");
    _finished = YES;
    
}




@end
