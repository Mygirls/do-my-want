//
//  Person.h
//  编程思想01
//
//  Created by JQ on 2017/9/25.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  void(^MyBlock)(void);

@interface Person : NSObject


//block作为属性
@property(nonatomic,strong) void(^myBlock)(void);
@property(nonatomic,strong) MyBlock block;

//作为参数
- (void)eat:(void(^)(void))block;

//作为返回值
- (void(^)(void)) play;

- (void(^)(int)) see;

- (int(^)(int)) work;


- (Person * (^)(int)) sleep;

@end
