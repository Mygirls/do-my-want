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
    NSLog(@"%@",self);
    
    //1. 动态添加一个类
    NSString *oldClassName = NSStringFromClass([self class]);
    NSString *newClassName = [@"FFKVO" stringByAppendingString:oldClassName];
    const char *newClass = [newClassName UTF8String];
    
    //定义一个类
    Class myClass = objc_allocateClassPair([self class], newClass, 0);
    
    //重写setAge(添加一个set方法)
    class_addMethod(myClass, @selector(setAge:), (IMP)setAge, "v@:");
    
    //注册这个类
    objc_registerClassPair(myClass);
    
    //改变isa 指针的指向
    object_setClass(self, myClass);

    //关联对象
    objc_setAssociatedObject(self, (__bridge const void *)@"objc", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
}

//默认参数！！
void setAge(id self,SEL _cmd ,int age) {
    
    //1保存一下自己
    id class = [self class];
    
    //2.让自己指向父类
    object_setClass(self, class_getSuperclass([self class]));
   
    NSLog(@"修改完毕 %d",age);
    
   
    //3.
    objc_msgSend(self,@selector(setAge:),age);
   
    //取出观察者
    id observer = objc_getAssociatedObject(self, (__bridge const void *)@"objc");
    
    NSDictionary *dic = @{@"new": [NSNumber numberWithInt:age]};
    
    objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:),@"age",self,dic,nil);
    
    //4.改回类型 针对 3
    object_setClass(self, class);
    
    
}
















@end
