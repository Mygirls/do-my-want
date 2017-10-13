//
//  Book.m
//  Runtime 面试初探
//
//  Created by JQ on 2017/10/12.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "Book.h"

@implementation Book

+ (void)initialize
{
//    if (self == [Book class]) {
        NSLog(@"%s",__FUNCTION__);
//    }
}

//if (self == [super class]) {
//    NSLog(@"《%@ 类》initialize 方法调用了",self);
//}

@end
