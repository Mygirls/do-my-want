//
//  NSObject+add.h
//  编程思想01
//
//  Created by JQ on 2017/9/25.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddManager.h"
@interface NSObject (add)

+ (void)majq_Add:(void(^)(AddManager *manage))add;
@end
