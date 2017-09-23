//
//  Person.h
//  RuntimeDemo07_KVO-2
//
//  Created by JQ on 2017/9/23.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
@public
    NSString *_name;
}

@property(nonatomic,assign)int age;

@end
