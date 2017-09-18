//
//  ViewController.h
//  滚动
//
//  Created by JQ on 2017/9/5.
//  Copyright © 2017年 majq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMPageController.h"

static CGFloat const kWMHeaderViewHeight = 725;
static CGFloat const kNavigationBarHeight = 64;

@interface ViewController : WMPageController


@property (nonatomic, assign) CGFloat viewTop;


@end

