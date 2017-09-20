//
//  PHGredientCycle.m
//  MajqFramework
//
//  Created by JQ on 2017/9/20.
//  Copyright © 2017年 cfzq. All rights reserved.
//

#import "PHGredientCycle.h"
#import "UIViewExt.h"
#define radians(degrees)  (degrees)*M_PI/180.0f  

@implementation PHGredientCycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
//    //支持retina高分截屏的关键
//    if(&UIGraphicsBeginImageContextWithOptions != NULL){
//        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
//    } else {
//        UIGraphicsBeginImageContext(self.frame.size);
//    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawMultipleColorGradient:context];
    
    //设置矩形填充颜色：红色
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
    //设置画笔颜色：黑色
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    //设置画笔线条粗细
    CGContextSetLineWidth(context, 0.6);
    
    //扇形参数
    double radius=40;        //半径
    int startX=50;           //圆心x坐标
    int startY=100;          //圆心y坐标
    double pieStart=0;       //起始的角度
    double pieCapacity=60;   //角度增量值
    int clockwise=0;         //0＝顺时针,1＝逆时针
    
    //顺时针画扇形
    CGContextMoveToPoint(context, startX, startY);
    CGContextAddArc(context, startX, startY, radius, radians(pieStart), radians(pieStart+pieCapacity), clockwise);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
    //扇形参数
    startX=200;             //圆心x坐标
    startY=100;             //圆心y坐标
    pieStart=0;             //起始的角度
    pieCapacity=60;         //角度增量值
    clockwise=1;            //0＝顺时针,1＝逆时针
    
    //逆时针画扇形
    CGContextMoveToPoint(context, startX, startY);
    CGContextAddArc(context, startX, startY, radius, radians(pieStart), radians(pieStart+pieCapacity), clockwise);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
//    //生成图片  
//    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();  
//    UIGraphicsEndImageContext();
}

- (void)drawMultipleColorGradient:(CGContextRef) ctx
{
    
    /**
     *  方法2.CGGradientRef
     */
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
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
