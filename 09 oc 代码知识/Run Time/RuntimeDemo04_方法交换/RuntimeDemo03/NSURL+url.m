//
//  NSURL+url.m
//  RuntimeDemo03
//
//  Created by JQ on 2017/9/21.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "NSURL+url.h"
#import <objc/message.h>

@implementation NSURL (url)

//1.重写系统的方法 ，不推荐，因为覆盖了系统的内部实现的方法，而内部如何实现我们不清楚，可能会引发一个未知的错误
// 这是一个category，整个项目的都重写了
//+ (instancetype)URLWithString:(NSString *)URLString
//{
//    NSURL *url = [[NSURL alloc] initWithString:URLString];
//    if (!url) {
//        NSLog(@"url 为nil");
//    }
//
//    return url;
//
//}


//2.这种方法可行，但是蛮烦，每次都要调用这个方法
//+ (instancetype)HK_URLWSTR:(NSString *)str  {
//    NSURL *url = [NSURL URLWithString:str]; //创建url
//
//    if (!url) {
//        NSLog(@"url 为nil");
//    }
//    return url;
//}

//3. runtime
//Hook方法： 拿到原来的方法，然后给它添加代码（不改变原来的任何功能）
/**
 步骤：
 1. 利用润 time的方法实现交换来做
 
 交换实现
 method_exchangeImplementations(<#Method  _Nonnull m1#>, <#Method  _Nonnull m2#>)
 
 //获取类方法
 class_getClassMethod(<#Class  _Nullable __unsafe_unretained cls#>, <#SEL  _Nonnull name#>)
 
 //获取实例方法
 class_getInstanceMethod(<#Class  _Nullable __unsafe_unretained cls#>, <#SEL  _Nonnull name#>)

 2.
 
 */

+ (void)load
{
    Method  URLWithStr = class_getClassMethod([self class], @selector(URLWithString:));
    Method HookURLSTR = class_getClassMethod([self class], @selector(HK_URLWSTR:));
    
    //交换
    method_exchangeImplementations(URLWithStr, HookURLSTR);
}

#pragma mark - 看起来就是死循环的代码
+ (instancetype)HK_URLWSTR:(NSString *)str  {
    
    //NSURL *url = [NSURL URLWithString:str]; //创建url: 死循环
    /**
     1. runtime 交换了两个方法的实现 method_exchangeImplementations
     2. 调用 URLWithString方法 其实是调用了 HK_URLWSTR 方法的实现，所以死循环
     
     3. 调用 HK_URLWSTR方法 其实是调用了 URLWithString 方法的实现

     */
    
    //看起来就是死循环的代码
    NSURL *url = [NSURL HK_URLWSTR:str]; //走系统的方法实现，相当于调用系统的URLWithString，因为他们两个方法的实现交换了
    /**
     NSURL *url2 = [NSURL HK_URLWSTR:@"http://www.baidu.com/中文"];

     */
    
    if (!url) {
        NSLog(@"url 为nil");
    }
    return url;
}


@end
