//
//  MyClass.m
//  BlockTest
//
//  Created by JQ on 2017/10/16.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "MyClass.h"

@interface MyClass ()
{
    NSObject* _instanceObj;

    
}
@end

@implementation MyClass

//
//NSObject* __globalObj = nil;
//
//
//- (id) init {
//    if (self = [super init]) {
//        _instanceObj = [[NSObject alloc] init];
//    }
//    return self;
//}
//
//- (void) test {
//    
//    static NSObject* __staticObj = nil;
//    __globalObj = [[NSObject alloc] init];
//    __staticObj = [[NSObject alloc] init];
//    
//    NSObject* localObj = [[NSObject alloc] init];
//    __block NSObject* blockObj = [[NSObject alloc] init];
//    
//    typedef void (^MyBlock)(void) ;
//    MyBlock aBlock = ^{
//        NSLog(@"%@", __globalObj);
//        NSLog(@"%@", __staticObj);
//        NSLog(@"%@", _instanceObj);
//        NSLog(@"%@", localObj);
//        NSLog(@"%@", blockObj);
//    };
//    aBlock = [[aBlock copy] autorelease];
//    aBlock();
//    
//    NSLog(@"%d", [__globalObj retainCount]);
//    NSLog(@"%d", [__staticObj retainCount]);
//    NSLog(@"%d", [_instanceObj retainCount]);
//    NSLog(@"%d", [localObj retainCount]);
//    NSLog(@"%d", [blockObj retainCount]);
//}

@end
