//
//  MajqPageScrollView.h
//  MajqPageView
//
//  Created by JQ on 2017/9/16.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MajqPageScrollView : UIScrollView

@property (nonatomic, strong) void(^didEndScrollView)(NSInteger);


- (void)addController: (NSArray *)childVC;

- (void)setCurrentIndex:(NSInteger)index;

@end
