//
//  Person.h
//  RunTimeDemo_KVO
//
//  Created by JQ on 2017/9/21.
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
