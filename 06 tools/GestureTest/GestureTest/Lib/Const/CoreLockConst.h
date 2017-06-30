//
//  CoreLockConst.h
//  CoreLock
//
//  Created by 成林 on 15/4/24.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#ifndef _CoreLockConst_H_
#define _CoreLockConst_H_

//**********************1.颜色设置**********************
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]


/*
 * 连线颜色：默认
 */
#define CoreLockViewLineColor rgba(253,91,120,1)

/*
 *  外环线条颜色：默认
 */
#define CoreLockCircleLineNormalColor rgba(253,91,120,1)


/*
 *  外环线条颜色：选中
 */
#define CoreLockCircleLineSelectedColor rgba(253,91,120,1)


/*
 *  实心圆
 */
#define CoreLockCircleLineSelectedCircleColor rgba(253,91,120,1)

/*
 *  提示文字颜色
 */
#define CoreLockErrorColor rgba(253,91,120,1)


//**********************2.其他设置**********************

#define CoreLockLineWidth 2.0f

/** 选中圆大小比例 */
extern const CGFloat CoreLockArcWHR;


/** 选中圆大小的线宽 */
extern const CGFloat CoreLockArcLineW;


/** 密码存储Key */
extern NSString *const CoreLockPWDKey;


/** 最低设置密码数目 */
extern const NSUInteger CoreLockMinItemCount;



//**********************3.提示语设置**********************
/** 设置密码提示文字：第一次 */
extern NSString *const CoreLockPWDTitleFirst;


/** 设置密码提示文字：确认 */
extern NSString *const CoreLockPWDTitleConfirm;


/** 设置密码提示文字：再次密码不一致 */
extern NSString *const CoreLockPWDDiffTitle;


/** 设置密码提示文字：设置成功 */
extern NSString *const CoreLockPWSuccessTitle;



/*
 *  验证密码
 */

/** 验证密码：普通提示文字 */
extern NSString *const CoreLockVerifyNormalTitle;


/** 验证密码：密码错误 */
extern NSString *const CoreLockVerifyErrorPwdTitle;



/** 验证密码：验证成功 */
extern NSString *const CoreLockVerifySuccesslTitle;



/*
 *  修改密码
 */
/** 修改密码：普通提示文字 */
extern NSString *const CoreLockModifyNormalTitle;

#endif
