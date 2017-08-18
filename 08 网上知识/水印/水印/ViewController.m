//
//  ViewController.m
//  水印
//
//  Created by cfzq on 2017/8/14.
//  Copyright © 2017年 cfzq. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)UIImageView *waterImgView;
@end

@implementation ViewController


- (UIImageView *)waterImgView {
    if (_waterImgView == nil) {
        _waterImgView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
        _waterImgView.backgroundColor = [UIColor orangeColor];
    }

    return _waterImgView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.waterImgView];
    //UIImage *img = [self fixOrientation:[UIImage imageNamed:@"personaldata32@2x"]];
    
    UIImage *img = [self addWatemarkTextAfteriOS7_WithLogoImage:[UIImage imageNamed:@"banner2"] watemarkText:@"这是一个测试"];
    self.waterImgView.image = img;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 * 修正图片的转向
 *
 * @param aImage 原图片
 *
 * @return 修正后图片
 */
- (UIImage *)fixOrientation:(UIImage *)aImage {
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

/**
 * 加文字随意@param logoImage 需要加文字的图片@param watemarkText 文字描述@returns 加好文字的图片
 */
- (UIImage *)addWatemarkTextAfteriOS7_WithLogoImage:(UIImage *)logoImage watemarkText:(NSString *)watemarkText{
    int w = logoImage.size.width;
    int h = logoImage.size.height;
    UIGraphicsBeginImageContext(logoImage.size);
    [[UIColor whiteColor] set];
    [logoImage drawInRect:CGRectMake(0, 0, w, h)];
    UIFont * font = [UIFont systemFontOfSize:18.0];
    [watemarkText drawInRect:CGRectMake(10, 55, 130, 80) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



@end
