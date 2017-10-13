//
//  Person.m
//  Runtime 面试初探
//
//  Created by JQ on 2017/10/11.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "Person.h"

@implementation Person


+ (void)load
{
    
    NSLog(@"《Person 类》load 方法调用了");
}


//+ (void)initialize
//{
//    if (self == [super class]) {
//        NSLog(@"《%@ 类》initialize 方法调用了",self);
//
//    }
//}
@end
