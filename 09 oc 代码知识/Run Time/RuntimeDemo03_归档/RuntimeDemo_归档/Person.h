//
//  Person.h
//  RuntimeDemo_归档
//
//  Created by JQ on 2017/9/21.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Person : NSObject<NSCoding>  //必须执行这个协议才能归档

@property(nonatomic,copy) NSString *name;

@property(nonatomic,assign) int age;

@property(nonatomic,assign) int age1;
@property(nonatomic,assign) int age2;
@property(nonatomic,assign) int age3;
@property(nonatomic,assign) int age4;





@end
