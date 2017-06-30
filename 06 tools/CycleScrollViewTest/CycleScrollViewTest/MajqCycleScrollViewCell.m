//
//  MajqCycleScrollViewCell.m
//  CycleScrollViewTest
//
//  Created by cfzq on 2017/6/30.
//  Copyright © 2017年 cfzq. All rights reserved.
//

#import "MajqCycleScrollViewCell.h"

@implementation MajqCycleScrollViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
    }
    
    return self;
}


- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    [self.contentView addSubview:imageView];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    
}


@end
