//
//  AddManager.m
//  编程思想01
//
//  Created by JQ on 2017/9/25.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "AddManager.h"

//static int sum = 0;
@implementation AddManager

//- (void)add:(int) i {
//
//
//}

//- (void(^)(int))add
//{
//    return ^(int i){
//        
//    };
//    
//}

- (AddManager *(^)(int))add
{
    return ^(int i) {
        _sum += i;
        return self;
    };
    
}
@end
