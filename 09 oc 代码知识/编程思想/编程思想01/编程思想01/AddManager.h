//
//  AddManager.h
//  编程思想01
//
//  Created by JQ on 2017/9/25.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddManager : NSObject

@property(nonatomic,assign) int sum;

//第一步： 给方法设置一个参数
//- (void)add:(int) i;

//第二步： block 作为返回值，用点语法去调用add，
//- (void(^)(int))add;

//第三步： block 的返回值是调用者本身
- (AddManager *(^)(int))add;


@end
