//
//  Person.m
//  RuntimeDemo05_添加方法
//
//  Created by JQ on 2017/9/23.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>
@implementation Person

#pragma mark - 没有参数

//void eat() {
//
//    NSLog(@"吃了");
//}
////调用没有实现的实例方法
//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    NSLog(@"%@",NSStringFromSelector(sel)); //eat
//
//    //添加方法
//    if (sel == @selector(eat)) {
//        /**
//         IMP: 方法实现，就是一个函数指针！！
//         types: 返回值类型
//         */
//        class_addMethod([Person class], @selector(eat), (IMP)eat, "v");
//    }
//
//    return  [super resolveInstanceMethod:sel];
//
//}

#pragma mark - 有参数
//command + shift + 0 官方文档, 搜索 class_addMethod

//默认参数 id objc,SEL _cmd
void eat(id objc,SEL _cmd,id obj) {
    
    NSLog(@"objc： %@ 方法名：%@ 吃了 %@",objc,NSStringFromSelector(_cmd),obj);
}
//调用没有实现的实例方法
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSLog(@"%@",NSStringFromSelector(sel)); //eat
    
    //添加方法
    if (sel == @selector(eat:)) {
        /**
         func class_addMethod(_ cls: AnyClass?, _ name: Selector, _ imp: IMP, _ types: UnsafePointer<Int8>?) -> Bool
        
         cls: The class to which to add a method.
         name: A selector that specifies the name of the method being added.
         IMP: A function which is the implementation of the new method. The function must take at least two arguments—self and _cmd.  方法实现，就是一个函数指针！！
         types: 返回值类型(An array of characters that describe the types of the arguments to the method. For possible values, see Objective-C Runtime Programming Guide > Type Encodings. Since the function must take at least two arguments—self and _cmd, the second and third characters must be “@:” (the first character is the return type).)  如图： add01.png 、add02.png
         
         */
        class_addMethod([Person class], @selector(eat:), (IMP)eat, "v@:");
    }
    NSLog(@"---");
    return  [super resolveInstanceMethod:sel];
    
}


//调用一个没有实现的类方法
+ (BOOL)resolveClassMethod:(SEL)sel
{
    
    return YES;
}
@end
