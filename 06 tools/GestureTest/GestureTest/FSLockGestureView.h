//
//  FSLockGestureView.h
//  GestureTest
//
//  Created by cfzq on 2017/6/29.
//  Copyright © 2017年 cfzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLockConst.h"
#import "CoreArchive.h"
#import "CLLockNavVC.h"

#import "CLLockView.h"
#import "CLLockLabel.h"
#import "CLLockInfoView.h"

@interface FSLockGestureView : UIView


@property (nonatomic,assign) CoreLockType type;

/*
 *  是否有本地密码缓存？即用户是否设置过初始密码？
 */
- (BOOL)hasPwd;

- (void)showSettingLockViewsuccessBlock:(void(^)(FSLockGestureView *lockVCiew,NSString *pwd))successBlock;

- (void)showVerifyLockViewForgetPwdBlock:(void(^)())forgetPwdBlock successBlock:(void(^)(FSLockGestureView *lockVCiew, NSString *pwd))successBlock;

- (void)showModifyLockLockViewFSuccessBlock:(void(^)(FSLockGestureView *lockVCiew, NSString *pwd))successBlock;

@end
