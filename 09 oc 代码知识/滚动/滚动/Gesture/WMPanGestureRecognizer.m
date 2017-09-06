//
//  WMPanGestureRecognizer.m
//  ViewFrameDemo
//
//  Created by Mark on 2016/12/13.
//  Copyright © 2016年 Wecan Studio. All rights reserved.
//

#import "WMPanGestureRecognizer.h"

@interface WMPanGestureRecognizer () <UIGestureRecognizerDelegate>

@end

@implementation WMPanGestureRecognizer

- (instancetype)initWithTarget:(id)target action:(SEL)action {
    if (self = [super initWithTarget:target action:action]) {
        self.delegate = self;
    }
    return self;
}

#pragma mark - Gesture Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //NSLog(@"---------------%@",otherGestureRecognizer.view);
    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"WMScrollView")]) {
        return NO;
    }
    return YES;
}

@end
