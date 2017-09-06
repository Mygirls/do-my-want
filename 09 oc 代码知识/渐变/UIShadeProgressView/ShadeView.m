//
//  ShadeView.m
//  UIShadeProgressView
//
//  Created by JQ on 2017/9/6.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "ShadeView.h"

@implementation ShadeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        //[self gradentWith:frame];
        
        
    }
    return self;
}
- (void)gradentWith:(CGRect)frame{
    
    // 创建path
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 添加路径[1条点(100,100)到点(200,100)的线段]到path
    
    [path moveToPoint:CGPointMake(10 , 100)];
    
    [path addLineToPoint:CGPointMake(90, 100)];
    
    // 将path绘制出来
    
    [path stroke];
    
    //遮罩层
    
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor = [[UIColor clearColor] CGColor];
    _progressLayer.strokeColor=[UIColor redColor].CGColor;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.lineWidth = 20;
    
    //渐变图层
    
    CALayer * grain = [CALayer layer];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    UIColor * fixColor = [UIColor blueColor];
    UIColor * preColor = [UIColor whiteColor];
    gradientLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[preColor CGColor],(id)[fixColor CGColor], nil]];
    
    // 设置颜色的分割点
    [gradientLayer setLocations:@[@0.01,@1]];
    
    // 开始点
    [gradientLayer setStartPoint:CGPointMake(0, 0)];
    
    // 结束点
    [gradientLayer setEndPoint:CGPointMake(1, 1)];
    [grain addSublayer:gradientLayer];
    [grain setMask:_progressLayer];
    [self.layer addSublayer:grain];
    
    //增加动画
//    
//    CABasicAnimation *pathAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    
//    pathAnimation.duration = 6;
//    
//    pathAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    
//    pathAnimation.fromValue=[NSNumber numberWithFloat:0.0f];
//    
//    pathAnimation.toValue=[NSNumber numberWithFloat:1.0f];
//    
//    pathAnimation.autoreverses=NO;
//    
//    pathAnimation.repeatCount = INFINITY;
//    
//    [_progressLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    _progressLayer.path=path.CGPath;
    
}

- (void)drawRect:(CGRect)rect {
    
    /**
     *  1.通过CAGradientLayer 设置渐变的背景。
     */
    CAGradientLayer *layer = [CAGradientLayer new];
    //colors存放渐变的颜色的数组
    layer.colors=@[(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor whiteColor].CGColor];
    /**
     * 起点和终点表示的坐标系位置，(0,0)表示左上角，(1,1)表示右下角
     */
    layer.startPoint = CGPointMake(0.5, 0);
    layer.endPoint = CGPointMake(0.5, 1);
    layer.frame = self.bounds;
    [self.layer addSublayer:layer];
    
    /**
     *  方法2.CGGradientRef
     */
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    /*指定渐变色
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
    CGFloat compoents[12]={
        0,0,0,1,
        0.8,0.1,0.5,1.0,
        1.0,1.0,1.0,1.0
    };
    
    //设置渐变的位置
    CGFloat locations[3]={0,0.3,1.0};
    //创建梯度上下文
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    
    /*绘制线性渐变
     context:图形上下文
     gradient:渐变色
     startPoint:起始位置
     endPoint:终止位置
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，到结束点之后继续填充
     
     startPoint endPoint 不同与上一种方法，指的是真正的坐标
     */
    CGContextDrawLinearGradient(ctx, gradient, CGPointMake(self.frame.size.width/2, 0), CGPointMake(self.frame.size.width/2,self.frame.size.height), kCGGradientDrawsAfterEndLocation);
    
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
}


@end
