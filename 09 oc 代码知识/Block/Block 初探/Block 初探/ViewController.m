//
//  ViewController.m
//  Block 初探
//
//  Created by JQ on 2017/10/17.
//  Copyright © 2017年 Majq. All rights reserved.
//  http://www.cnblogs.com/dahe007/p/6067591.html


#import "ViewController.h"

//typedef <#returnType#>(^<#name#>)(<#arguments#>);
@interface ViewController ()

@end

@implementation ViewController

typedef void(^CaptureObjBlock)(NSObject *);
CaptureObjBlock captureBlock;

typedef void(^CaptureObjBlock02)(void);
CaptureObjBlock02 captureBlock02;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self test01];
    [self test02];

}

//MARK: - 初探一
- (void)test01{
    
    //[self captureObject];
    [self captureObject02];
    
    captureBlock([[NSObject alloc] init]);
    captureBlock([[NSObject alloc] init]);
    captureBlock([[NSObject alloc] init]);
    NSLog(@"captureBlock = %@",captureBlock);//captureBlock = <__NSMallocBlock__: 0x604000456ec0>
    /**
     为什么局部变量muArray出了作用域 还能存在？
     
     captureBlk为默认的__strong类型(block  为引用类型)，当block被赋值给__strong类型的对象或者block的成员变量时，编译器会自动调用block的copy方法。
     
     执行copy方法，block拷贝到堆上，mutArray变量赋值给block的成员变量。所以打印的结果就为1，2，3。
     
     如果把上面代码中的mutArray改为weak类型，那么打印的就都是0了。因为当出去作用域的时候，mutArray就已经被释放了
     */
}

- (void) captureObject {
    
    NSMutableArray *mutArray = [[NSMutableArray alloc] init];
    captureBlock = ^(NSObject *obj) {
        [mutArray addObject:obj];
        NSLog(@"mutArray 元素的个数： %ld",mutArray.count);
    };
    
    /**
     2017-10-17 09:52:20.542324+0800 Block 初探[3563:77674] mutArray 元素的个数： 1
     2017-10-17 09:52:20.542481+0800 Block 初探[3563:77674] mutArray 元素的个数： 2
     2017-10-17 09:52:20.542573+0800 Block 初探[3563:77674] mutArray 元素的个数： 3
     */
}


- (void) captureObject02 {
     NSMutableArray __weak *mutArray = [[NSMutableArray alloc] init];
    captureBlock = ^(NSObject *obj) {
        [mutArray addObject:obj];
        NSLog(@"mutArray 元素的个数： %ld",mutArray.count);
    };
    /**
     2017-10-17 09:52:20.542324+0800 Block 初探[3563:77674] mutArray 元素的个数： 0
     2017-10-17 09:52:20.542481+0800 Block 初探[3563:77674] mutArray 元素的个数： 0
     2017-10-17 09:52:20.542573+0800 Block 初探[3563:77674] mutArray 元素的个数： 0
     */
}

//MARK: - 初探二
- (void)test02 {
    
    //[self captureObject03];
    [self captureObject04];

    captureBlock02();
    
    
}

- (void)captureObject03 {
    int a = 2;
    captureBlock02 = ^() {
        NSLog(@"a = %d",a); //a = 2
    };
    
    a = 3;
}

- (void)captureObject04 {
    __block int a = 2;
    captureBlock02 = ^() {
        NSLog(@"a = %d",a); //a = 3
    };
    
    a = 3;
}

//MARK: - 总结
/**
 在MRC下block定义的属性都要加上copy，ARC的时候block定义copy或strong都是可以的，因为ARC下strong类型的block会自动完成copy的操作。
 

 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
