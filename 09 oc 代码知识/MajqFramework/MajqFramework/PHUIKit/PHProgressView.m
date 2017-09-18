//
//  PHProgressView.m
//  MajqFramework
//
//  Created by JQ on 2017/9/6.
//  Copyright © 2017年 majq. All rights reserved.
//

#import "PHProgressView.h"
#import "UIViewExt.h"

#define GradientColor_defalut1 [UIColor colorWithRed:249/255.0 green:138/255.0 blue:83/255.0 alpha:1]
#define GradientColor_defalut2 [UIColor colorWithRed:255/255.0 green:73/255.0 blue:37/255.0 alpha:1]
#define ProgressColor_defalut  [UIColor colorWithRed:229/255.0 green:47/255.0 blue:47/255.0 alpha:1]


@interface PHProgressView ()
@property(nonatomic,strong)PHGradientView *gradientView;
@property(nonatomic,strong)UIView *progressBgView;

@property(nonatomic,strong)UIImageView *thumbImgView;

@end


@implementation PHProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _progressViewType =ProgressViewAllGradient;
        _progressPercentage = 0;
        _progressHeight = 2;
        _currentThumbImg = [UIImage imageNamed:@"thumbImgView1"];
        _progressColors = @[(__bridge id)GradientColor_defalut1.CGColor,(__bridge id)GradientColor_defalut2.CGColor];
      
        [self addSubview:self.progressBgView];
        [self addSubview:self.gradientView];
        [self addSubview:self.thumbImgView];
        
        
    }
    return self;
}


- (void)progressShow
{
    switch (self.progressViewType) {
            case ProgressViewAllGradient: {
                [self progressViewIsGradient];

                 break;
            }
           
            case ProgressViewNotAllGradient: {
                [self progressProgressNotAllGradient];

                break;
            }
    }
}

- (void)progressViewIsGradient
{
    CGSize imgSize =  self.currentThumbImg.size;
    CGFloat realWidth = self.width - imgSize.width;
    
    self.gradientView.frame = CGRectMake(imgSize.width * 0.5, (self.height - self.progressHeight) * 0.5, realWidth, self.progressHeight );
    if (self.progressColors.count > 0) {
        self.gradientView.gradientcolors = self.progressColors;
        
    }
    [self.gradientView drawGradient];
    
    self.thumbImgView.frame = CGRectMake(realWidth * self.progressPercentage, 0, self.height, self.height );
    self.thumbImgView.image = self.currentThumbImg;

}

- (void)progressProgressNotAllGradient
{
    CGSize imgSize =  self.currentThumbImg.size;
    CGFloat realWidth = self.width - imgSize.width;
    
    self.progressBgView.frame = CGRectMake(imgSize.width * 0.5, (self.height - self.progressHeight) * 0.5, realWidth , self.progressHeight );
    self.progressBgView.hidden = NO;
    
    self.gradientView.frame = CGRectMake(imgSize.width * 0.5, (self.height - self.progressHeight) * 0.5, realWidth * self.progressPercentage, self.progressHeight );
    if (self.progressColors.count > 0) {
        self.gradientView.gradientcolors = self.progressColors;
    }
    [self.gradientView drawGradient];
    
    self.thumbImgView.frame = CGRectMake(self.gradientView.right - imgSize.width * 0.5 , 0, self.height, self.height );
    self.thumbImgView.image = self.currentThumbImg;
    


}

//MARK: - 懒加载
- (PHGradientView *)gradientView
{
    if (_gradientView == nil) {
        _gradientView = [[ PHGradientView alloc] initWithFrame: CGRectMake(0, (self.height - 2) * 0.5, self.width, 2)];
    }

    return _gradientView;
}

- (UIImageView *)thumbImgView
{
    if (_thumbImgView == nil) {
        _thumbImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.height, self.height)];
    }
    
    return _thumbImgView;
}

- (UIView *)progressBgView
{
    if (_progressBgView == nil) {
        _progressBgView = [[ UIView alloc] initWithFrame:CGRectZero];
        _progressBgView.hidden = YES;
        _progressBgView.backgroundColor = ProgressColor_defalut;
    }
    
    return _progressBgView;
}

//MARK: - set 方法
- (void)setProgressPercentage:(CGFloat)progressPercentage
{
    _progressPercentage = progressPercentage;
}

- (void)setProgressHeight:(CGFloat)progressHeight
{
    _progressHeight = progressHeight;
    if (_progressHeight >= self.height) {
        _progressHeight = self.height;
    }
}

- (void)setCurrentThumbImg:(UIImage *)currentThumbImg
{
    _currentThumbImg = currentThumbImg;
}

- (void)setProgressColors:(NSArray *)progressColors
{
    _progressColors = progressColors;
}

- (void)setProgressViewType:(PHProgressViewType)progressViewType
{
    _progressViewType = progressViewType;

}
@end
