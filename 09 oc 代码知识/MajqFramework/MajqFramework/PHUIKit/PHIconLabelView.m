//
//  PHIconLabelView.m
//  MajqFramework
//
//  Created by JQ on 2017/9/6.
//  Copyright © 2017年 majq. All rights reserved.
//

#import "PHIconLabelView.h"
#import "UIViewExt.h"
@interface PHIconLabelView ()

@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIImageView *imgView;

@property(nonatomic,assign)CGSize imgSize;
@end


@implementation PHIconLabelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.label];
        [self addSubview:self.imgView];
        
    }
    return self;
}

- (void)viewShow:(PHIconLabelViewType)type
              up:(CGFloat)y
          middle:(CGFloat)m
{
    switch (type) {
            case labelUp:
            self.imgView.frame = CGRectMake(y, (self.width - self.imgSize.width) * 0.5, self.imgSize.width, self.imgSize.height);
            self.label.frame = CGRectMake(0, 0, self.imgSize.width, 0);

            
            break;
            
            case lableRight:
            break;
    }
    
}



//MARK: - setUp Views
- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc]initWithFrame:CGRectZero];
        _label.backgroundColor = [UIColor clearColor];
    }
    
    return _label;
}


- (UIImageView *)imgView
{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imgView.backgroundColor = [UIColor clearColor];
    }
    
    return _imgView;
}

//MARK: - set 方法
- (void)setImgName:(NSString *)imgName
{
    _imgName = imgName;
    
    CGSize size = [UIImage imageNamed:imgName].size;
    self.imgSize = size;
    
}

- (void)setLabelTitle:(NSString *)labelTitle
{
    _labelTitle = labelTitle;
}

@end
