//
//  NSObject+add.m
//  编程思想01
//
//  Created by JQ on 2017/9/25.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "NSObject+add.h"

@implementation NSObject (add)

+ (void)majq_Add:(void(^)(AddManager *manage))add
{
    AddManager *m = [[AddManager alloc] init];
    add(m);
    
}


@end
