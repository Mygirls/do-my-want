//
//  MajqPageScrollView.m
//  MajqPageView
//
//  Created by JQ on 2017/9/16.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "MajqPageScrollView.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#define majqScreenW  [UIScreen mainScreen].bounds.size.width
#define majqScreenH  [UIScreen mainScreen].bounds.size.height

@interface MajqPageScrollView ()<UIScrollViewDelegate>


@property(nonatomic,strong) NSArray *childVCs;
@end


@implementation MajqPageScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpScrollViewConfig];
        
    }
    return self;
}

- (void)setUpScrollViewConfig
{
    self.backgroundColor = [UIColor grayColor];
    self.pagingEnabled = YES;
    self.delegate = self;
    
}

- (void)addController: (NSArray *)childVC
{
    self.contentSize = CGSizeMake(majqScreenW * childVC.count, majqScreenH - 45);
    self.childVCs = childVC;
}

- (void)setCurrentIndex:(NSInteger)index {
    UIViewController *VC = self.childVCs[index];
    
    VC.view.frame = (CGRect){index * majqScreenW, 0, majqScreenW, majqScreenH - 45};
    [self addSubview:VC.view];
    
    [self setContentOffset:CGPointMake(index * majqScreenW, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
// 滚动完成的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 0.当前偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 1.当前页码
    NSInteger i = offsetX / majqScreenW;
    
    [self setCurrentIndex:i];
    
    !self.didEndScrollView ? : self.didEndScrollView(i);
}



@end
