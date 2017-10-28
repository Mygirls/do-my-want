//
//  Person.m
//  RuntimeDemo_归档
//
//  Created by JQ on 2017/9/21.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>

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
- (void)encodeWithCoder:(NSCoder *)coder {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([Person class], &count);
    for (int i = 0; i < count; i ++) {
        //取出每一个Ivar
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        
        //归档 kvo 取值
        [coder encodeObject:[self valueForKey:key] forKey:key];
    }
    //c语言里面，一旦遇到copy creat new 需要释放
    free(ivars);
}
//告诉系统解档哪些属性
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([Person class], &count);
        for (int i = 0; i < count; i ++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            
            //解档: kvo
            id value = [coder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}

@end
