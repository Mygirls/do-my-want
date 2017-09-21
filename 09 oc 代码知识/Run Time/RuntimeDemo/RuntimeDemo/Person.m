//
//  Person.m
//  RuntimeDemo
//
//  Created by JQ on 2017/9/20.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)eat {
    NSLog(@"吃了");
    
}

- (void)eat: (NSString *) food {
    NSLog(@"吃 %@",food);
    
}
@end
