//
//  NSObject+KVO.h
//  RunTimeDemo_KVO
//
//  Created by JQ on 2017/9/21.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KVO)

- (void)FF_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
@end
