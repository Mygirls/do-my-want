//
//  CLLockInfoView.m
//  CoreLock
//
//  Created by 成林 on 15/4/27.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CLLockInfoView.h"
#import "CoreLockConst.h"

#define dotViewTag 10
@interface CLLockInfoView ()

@property(nonatomic,strong)NSMutableArray *dotViewArray;
@end

@implementation CLLockInfoView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        self.backgroundColor = [UIColor clearColor];
        [self setUpDefaultSmallDot];
        [self setUpSmallDot];
    }
    
    return self;
}

- (NSMutableArray *)dotViewArray
{
    if (_dotViewArray == nil) {
        _dotViewArray = [NSMutableArray arrayWithCapacity:9];
    }
    return _dotViewArray;
}

- (void)setUpDefaultSmallDot {
    
    CGFloat marginV = 6.f;
    CGFloat padding = 1.0f;
    CGFloat rectWH = (self.frame.size.width - marginV * 2 - padding*2) / 3;
    
    for (int i = 0; i < 9; i++) {
        UIView *dotView = [[UIView alloc]init];
        [self addSubview:dotView];
        NSUInteger row = i % 3;
        NSUInteger col = i / 3;
        
        CGFloat rectX = (rectWH + marginV) * row + padding;
        CGFloat rectY = (rectWH + marginV) * col + padding;
        CGRect rect = CGRectMake(rectX, rectY, rectWH, rectWH);
        dotView.frame = rect;
        dotView.backgroundColor = [UIColor clearColor];
        dotView.layer.masksToBounds = true;
        dotView.layer.cornerRadius = 6;
        dotView.layer.borderColor = CoreLockCircleLineNormalColor.CGColor;
        dotView.layer.borderWidth = 1.0f;
    }
}


- (void)setUpSmallDot {
    
    CGFloat marginV = 6.f;
    CGFloat padding = 1.0f;
    CGFloat rectWH = (self.frame.size.width - marginV * 2 - padding*2) / 3;

    for (int i = 0; i < 9; i++) {
        UIView *dotView = [[UIView alloc]init];
        dotView.hidden = YES;
        dotView.layer.masksToBounds = true;
        dotView.layer.cornerRadius = 6;
        dotView.layer.borderColor = CoreLockCircleLineNormalColor.CGColor;
        dotView.layer.borderWidth = 1.0f;
        [self addSubview:dotView];
        [self.dotViewArray addObject:dotView];

        NSUInteger row = i % 3;
        NSUInteger col = i / 3;
        
        CGFloat rectX = (rectWH + marginV) * row + padding;
        
        CGFloat rectY = (rectWH + marginV) * col + padding;
        
        CGRect rect = CGRectMake(rectX, rectY, rectWH, rectWH);
        dotView.frame = rect;
        dotView.backgroundColor = CoreLockCircleLineNormalColor;
    }
}

- (void)setPassword:(NSString *)password {
    _password = password;
    if (password == nil) {
        return;
    }
    
    NSString *temp = nil;
    for(int i =0; i < [password length]; i++){
        temp = [password substringWithRange:NSMakeRange(i, 1)];
        int tag = [temp intValue];
        UIView *view = self.dotViewArray[tag];
        view.hidden = false;
    }
}

/**
 *  清除选中的 dot
 */
- (void)clearDotView {
    [self.dotViewArray removeAllObjects];
    
    for (UIView *view  in self.dotViewArray) {
        [view removeFromSuperview];
    }
    
    
}

//-(void)drawRect:(CGRect)rect{
//
//    //获取上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    [self setCircleDefault:ctx rect:rect];
//}

- (void)setCircleDefault:(CGContextRef)ctx rect:(CGRect)rect{
    //设置属性
    CGContextSetLineWidth(ctx, CoreLockArcLineW);
    
    //设置线条颜色
    [CoreLockCircleLineNormalColor set];
    
    //新建路径
    CGMutablePathRef pathM =CGPathCreateMutable();
    
    CGFloat marginV = 6.f;
    CGFloat padding = 1.0f;
    CGFloat rectWH = (rect.size.width - marginV * 2 - padding*2) / 3;
    
    //添加圆形路径
    for (NSUInteger i=0; i<9; i++) {
        
        NSUInteger row = i % 3;
        NSUInteger col = i / 3;
        
        CGFloat rectX = (rectWH + marginV) * row + padding;
        
        CGFloat rectY = (rectWH + marginV) * col + padding;
        
        CGRect rect = CGRectMake(rectX, rectY, rectWH, rectWH);
        
        CGPathAddEllipseInRect(pathM, NULL, rect);//这句话就是剪辑作用
    }
    
    //添加路径
    CGContextAddPath(ctx, pathM);
    
    //绘制路径
    CGContextStrokePath(ctx); //空心
    //CGContextFillPath(ctx);     //实心

    //释放路径
    CGPathRelease(pathM);

}

















@end
