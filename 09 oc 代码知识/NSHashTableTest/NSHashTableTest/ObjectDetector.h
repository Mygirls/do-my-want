//
//  ObjectDetector.h
//  NSHashTableTest
//
//  Created by JQ on 2017/10/16.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectDetector : NSObject

+ (void)startWatch;
+ (void)addToWatch:(id)object;
+ (NSArray *)allObjects;


@end
