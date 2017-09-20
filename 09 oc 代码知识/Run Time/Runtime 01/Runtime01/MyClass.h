//
//  MyClass.h
//  Runtime01
//
//  Created by JQ on 2017/9/19.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass : NSObject<NSCopying,NSCoding>
{
    NSDictionary * _dic;

}
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, copy) NSString *string;
- (void)method1;
- (void)method2;
+ (void)classMethod1;


@end
