//
//  MajqBaseViewController.h
//  MajqPageView
//
//  Created by JQ on 2017/9/16.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MajqBaseViewController : UIViewController
@property(strong, nonatomic)UIScrollView *scrollView;
@property (nonatomic, assign) BOOL canScroll;
@end
