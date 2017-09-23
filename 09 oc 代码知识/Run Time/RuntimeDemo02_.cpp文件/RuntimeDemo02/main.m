//
//  main.m
//  RuntimeDemo02
//
//  Created by JQ on 2017/9/21.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *p = [[Person alloc] init];
    }
    return 0;
}

/**
 怎么生成 main.pp 文件
 1. cd 文件的到终端
 2. ls 查看在该目录下是否有 main.m文件
 3. clang -rewrite-objc main.m  ，（输入该命令，会弹出很多乱七八糟的东西，不出意外应该就是成功了，在main.m所在的路径在查看是否生产main.pp文件 ）
 4. 打开
 
 */


//打开main.pp 文件 在这底部
//int main(int argc, const char * argv[]) {
//    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool;

//        Person *p = ((Person *(*)(id, SEL))(void *)objc_msgSend)((id)((Person *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("Person"), sel_registerName("alloc")), sel_registerName("init"));

//    }
//    return 0;
//}

/**
 //底层实现： 运行时代码
 Person *p = ((Person *(*)(id, SEL))(void *)objc_msgSend)((id)((Person *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("Person"), sel_registerName("alloc")), sel_registerName("init"));
 
 1. (Person *(*)(id, SEL))(void *) 类型转换
 对比之前的
  Person *p = objc_msgSend(objc_msgSend(objc_getClass("Person"), sel_registerName("alloc")), sel_registerName("init"));

 */

