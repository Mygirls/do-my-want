//
//  ViewController.m
//  Runloop demo
//
//  Created by JQ on 2017/9/29.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MJQQRCodeGenerate.h"

typedef void(^RunloopBlock)(void);

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,strong)NSMutableArray *tasks;

@property(nonatomic,assign) NSUInteger maxQueueLength;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 60;
    
    [self.view addSubview:_tableView];
    
    _tasks = [NSMutableArray array];
    _maxQueueLength = 18;
    [self setUpConfig];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellid";

   UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
 

    [self addTask:^{
        [self setupcell:cell];

    }];
   
  
//    [self setupcell:cell];
//    [self setupcell:cell];
//
//    [self setupcell:cell];
//    
//    
//    [self setupcell:cell];
//    [self setupcell:cell];

    
    return cell;
}

- (void) setupcell: (UITableViewCell *) cell
{
    UIImageView *imgview = [[ UIImageView alloc] initWithFrame:CGRectMake(20 + 100, 0, 100, 50 )];
    [cell.contentView addSubview:imgview];
    CGRect rect = [UIScreen mainScreen].bounds;
    CGFloat w = rect.size.width;
    CGFloat h = w;
    CGFloat y = (rect.size.height - h) / 2;
    CGRect rect_target = CGRectMake(0, y, w, h);
    MJQQRCodeGenerate *qrCode = [[MJQQRCodeGenerate alloc]init];
    UIImage *myImage = [qrCode generateQuickResponseCodeWithFrame:rect_target dataString:@"https://www.baidu.com"];
    imgview.image =  myImage;
    
//     UIImageView *imgview = [[ UIImageView alloc] initWithFrame:CGRectMake(20 + 100, 0, 100, 50 )];
//    imgview.image = [UIImage imageNamed:@"112"];
//    [cell.contentView addSubview:imgview];
    
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

- (void)addTask: (RunloopBlock) task
{
    [self.tasks addObject:task];
    if (self.tasks.count > self.maxQueueLength) {
        [self.tasks removeObjectAtIndex:0]; //移除最开始的任务
    }
    
}

static void CallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    
    NSLog(@"个么来了");
    ViewController *vc = (__bridge ViewController *) info;
    if (vc.tasks.count == 0) {
        return;
    }
    RunloopBlock task = vc.tasks.firstObject;
    task();

    [vc.tasks removeObjectAtIndex:0];
    
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
    CFRunLoopAddObserver(runloop, defaultModeObserver, kCFRunLoopCommonModes);
    
    //释放
    CFRelease(defaultModeObserver);
 
    
}












@end
