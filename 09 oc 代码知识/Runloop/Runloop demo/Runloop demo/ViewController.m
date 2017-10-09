//
//  ViewController.m
//  Runloop demo
//
//  Created by JQ on 2017/9/29.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self setUpConfig];
}

/** CoreFoundation 源码中 CFRunLoop 关于 RunLoop 的有五个类：
 
 typedef struct CF_BRIDGED_MUTABLE_TYPE(id) __CFRunLoop * CFRunLoopRef;
 
 typedef struct CF_BRIDGED_MUTABLE_TYPE(id) __CFRunLoopSource * CFRunLoopSourceRef;
 
 typedef struct CF_BRIDGED_MUTABLE_TYPE(id) __CFRunLoopObserver * CFRunLoopObserverRef;
 
 typedef struct CF_BRIDGED_MUTABLE_TYPE(NSTimer) __CFRunLoopTimer * CFRunLoopTimerRef;

 我只找到4个 

 
 
 CF_EXPORT CFRunLoopRef CFRunLoopGetCurrent(void);
 CF_EXPORT CFRunLoopRef CFRunLoopGetMain(void
 
 
// Run Loop Observer Activities
//typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
//    kCFRunLoopEntry = (1UL << 0),
//    kCFRunLoopBeforeTimers = (1UL << 1),
//    kCFRunLoopBeforeSources = (1UL << 2),
//    kCFRunLoopBeforeWaiting = (1UL << 5),
//    kCFRunLoopAfterWaiting = (1UL << 6),
//    kCFRunLoopExit = (1UL << 7),
//    kCFRunLoopAllActivities = 0x0FFFFFFFU
//};

 */

#pragma mark - runloop < C 语言 >
- (void)setUpConfig
{
    [self addRunloopObserver];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
    
}

static void CallBack() {
    NSLog(@"个么来了");
    
}

- (void)timerMethod{
    
    
}

- (void)addRunloopObserver {
    // 获取当前runloop
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    
    //定义一个上下文
//    typedef struct {
//        CFIndex    version;
//        void *    info;
//        const void *(*retain)(const void *info);
//        void    (*release)(const void *info);
//        CFStringRef    (*copyDescription)(const void *info);
//    } CFRunLoopObserverContext;
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL
    };
    
    // 定义一个观察者 观察runloop
    static CFRunLoopObserverRef defaultModeObserver ;
    
    //创建一个观察者
    // CallBack 回调函数
    defaultModeObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopAfterWaiting, YES, 0, &CallBack, &context);
    
    //添加观察者
    CFRunLoopAddObserver(runloop, defaultModeObserver, kCFRunLoopDefaultMode);
    
    //释放
    CFRelease(defaultModeObserver);
 
    
}












@end
