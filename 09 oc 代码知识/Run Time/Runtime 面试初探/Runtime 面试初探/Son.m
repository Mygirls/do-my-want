//
//  Son.m
//  Runtime 面试初探
//
//  Created by JQ on 2017/10/11.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "Son.h"

@implementation Son


+ (void)load
{
    NSLog(@"《Son 类》load 方法调用了");
}



+ (void)initialize
{
    if (self == [Person class]) {
        NSLog(@"《%@ 类》initialize 方法调用了",self);

    }
}

@end
