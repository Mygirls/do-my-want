//
//  FirstViewController.h
//  MajqPageView
//
//  Created by JQ on 2017/9/16.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MajqBaseViewController.h"

@interface FirstViewController : MajqBaseViewController


- (void)tableViewIsScrollEnabled:(BOOL) isScrollEnabled;

- (instancetype)initWithCurrent: (NSString *)type;
@end
