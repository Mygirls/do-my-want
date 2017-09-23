//
//  NSObject+KVO.m
//  RunTimeDemo_KVO
//
//  Created by JQ on 2017/9/21.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/message.h>


@implementation NSObject (KVO)

- (void)FF_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context
{
    /**
         1. 动态添加一个类
         2.
     */
    NSLog(@"%@",self);
    
    NSString *oldClassName = NSStringFromClass([self class]);
    NSString *newClassName = [@"FFKVO" stringByAppendingString:oldClassName];
    const char *newClass = [newClassName UTF8String];
    
    //定义一个类
    Class myClass = objc_allocateClassPair([self class], newClass, 0);
    
    //重写setAge
    class_addMethod(myClass, @selector(setAge:), (IMP)setAge, "");
    
    //注册这个类
    objc_registerClassPair(myClass);
    
    //改变isa 指针
    object_setClass(self, myClass);

    //
    
    
}

//默认参数！！
void setAge(id self,SEL _cmd ,int age) {
    
    //12保存一下自己
    id class = [self class];
    
    //2.让自己指向父类
    object_setClass(self, class_getSuperclass([self class]));
   
    //3.
    objc_msgSend(self,@selector(setAge:),age);
   
    //4.改回来 针对 3
    object_setClass(self, class);
    NSLog(@"来了");
}




@end
