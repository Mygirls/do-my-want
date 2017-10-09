//
//  Person.m
//  编程思想01
//
//  Created by JQ on 2017/9/25.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "Person.h"

@implementation Person

//作为参数
- (void)eat:(void(^)(void))block
{
    block();
    
}

//作为返回值
- (void(^)(void))play
{
    return ^{
        NSLog(@"block作为返回值");
    };
    
}

- (void(^)(int)) see
{
    return ^(int i) {
        NSLog(@"block作为返回值 %d",i);
    };  
}

- (int(^)(int)) work
{
    return ^(int i){
        
        return 8;
    };
    
}

- (Person * (^)(int)) sleep {
    
    return ^(int i) {
        NSLog(@"block作为返回值 链式编程思想 sleep %d 小时",i);
        
        return self;
    };
}

@end
