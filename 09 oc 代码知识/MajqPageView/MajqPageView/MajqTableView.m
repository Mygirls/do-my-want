//
//  MajqTableView.m
//  MajqPageView
//
//  Created by JQ on 2017/9/16.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "MajqTableView.h"

@implementation MajqTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
