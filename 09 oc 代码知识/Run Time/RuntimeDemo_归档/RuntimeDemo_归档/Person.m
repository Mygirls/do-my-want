//
//  Person.m
//  RuntimeDemo_归档
//
//  Created by JQ on 2017/9/21.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "Person.h"

@implementation Person

#pragma mark - 属性比较少时
////告诉系统归档哪些属性
//- (void)encodeWithCoder:(NSCoder *)coder
//{
//    //归档
//    [coder encodeObject:_name forKey:@"name"];
//    [coder encodeInt:_age forKey:@"age"];
//}
//
////告诉系统解档哪些属性
//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super init];
//    if (self) {
//        //解档
//        _name = [coder decodeObjectForKey:@"name"];
//        _age = [coder decodeIntForKey:@"age"];
//    }
//    return self;
//}

#pragma mark - 当属性过多的时候
//告诉系统归档哪些属性
- (void)encodeWithCoder:(NSCoder *)coder
{
    //归档
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeInt:_age forKey:@"age"];
}

//告诉系统解档哪些属性
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        //解档
        _name = [coder decodeObjectForKey:@"name"];
        _age = [coder decodeIntForKey:@"age"];
    }
    return self;
}

@end
