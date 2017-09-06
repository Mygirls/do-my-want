//
//  PHIconLabelView.h
//  MajqFramework
//
//  Created by JQ on 2017/9/6.
//  Copyright © 2017年 majq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    labelUp,
    lableRight,
    
} PHIconLabelViewType;

@interface PHIconLabelView : UIView

@property(nonatomic,copy) NSString *imgName;
@property(nonatomic,copy) NSString *labelTitle;

@end
