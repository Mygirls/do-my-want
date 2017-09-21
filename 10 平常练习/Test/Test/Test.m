//
//  Test.m
//  Test
//
//  Created by JQ on 2017/9/20.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "Test.h"

@implementation Test

- (void)test {
    NSLog(@"self class: %@", self.class);
    NSLog(@"super class: %@", super.class);
    /**
     
     2017-09-20 22:01:55.445303+0800 Test[6981:108636] self class: Test
     2017-09-20 22:01:55.445470+0800 Test[6981:108636] super class: Tes
     
     */
}

@end
