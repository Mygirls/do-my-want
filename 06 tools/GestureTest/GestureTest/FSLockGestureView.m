//
//  FSLockGestureView.m
//  GestureTest
//
//  Created by cfzq on 2017/6/29.
//  Copyright © 2017年 cfzq. All rights reserved.
//

#import "FSLockGestureView.h"
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define tipLalbelOrignY 258 * 0.5
#define lockViewOrignY 284 * 0.5


@interface FSLockGestureView ()

@property(nonatomic,strong) CLLockView *lockView;
@property(nonatomic,strong)CLLockLabel *label;
@property(nonatomic,strong)CLLockInfoView *lockInfoView;

/** 操作成功：密码设置成功、密码验证成功 */
@property (nonatomic,copy) void (^successBlock)(FSLockGestureView *lockGestureView,NSString *pwd);
@property (nonatomic,copy) void (^forgetPwdBlock)();

@property (nonatomic,copy) NSString *modifyCurrentTitle;
@property (nonatomic,copy) NSString *msg;

/** 直接进入修改页面的 */
@property (nonatomic,assign) BOOL isDirectModify;

@end

@implementation FSLockGestureView


#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpConfig];
    }
    return self;
}

- (void)setUpConfig {
    
    [self addSubview:self.lockInfoView];
    [self addSubview:self.label];
    [self addSubview:self.lockView];
    
    [self.label showNormalMsg:@"请滑动输入手势密码"];
    //数据传输
    [self dataTransfer];
    
    [self event];
}

/*
 *  密码重设
 */
-(void)setPwdReset{
    
    [self.label showNormalMsg:CoreLockPWDTitleFirst];
    
    //通知视图重设
    [self.lockView resetPwd];
}

/*
 *  是否有本地密码缓存？即用户是否设置过初始密码？
 */
- (BOOL)hasPwd{
    
    NSString *pwd = [CoreArchive strForKey:CoreLockPWDKey];
    
    return pwd !=nil;
}


-(void)setType:(CoreLockType)type{
    
    _type = type;
    [self labelWithType];//根据type自动调整label文字
}



/*
 *  根据type自动调整label文字
 */
-(void)labelWithType{
    
    if(CoreLockTypeSetPwd == _type){//设置密码
        
        self.msg = CoreLockPWDTitleFirst;
        
    }else if (CoreLockTypeVeryfiPwd == _type){//验证密码
        
        self.msg = CoreLockVerifyNormalTitle;
        
    }else if (CoreLockTypeModifyPwd == _type){//修改密码
        
        self.msg = CoreLockModifyNormalTitle;
    }
}

/*
 *  数据传输
 */
-(void)dataTransfer{
    
    [self.label showNormalMsg:self.msg];
    
    //传递类型
    self.lockView.type = self.type;
}



#pragma mark - 初始化配置
//设置密码
- (void)showSettingLockViewsuccessBlock:(void(^)(FSLockGestureView *lockVCiew,NSString *pwd))successBlock{
    
    //设置类型
    self.type = CoreLockTypeSetPwd;
    //保存block
    self.successBlock = successBlock;
    
    [self dataTransfer];
}

//验证密码
- (void)showVerifyLockViewForgetPwdBlock:(void(^)())forgetPwdBlock successBlock:(void(^)(FSLockGestureView *lockVCiew, NSString *pwd))successBlock{
    //设置类型
    self.type = CoreLockTypeVeryfiPwd ;
    //保存block
    self.successBlock = successBlock;
    
    [self dataTransfer];

}

//修改密码
- (void)showModifyLockLockViewFSuccessBlock:(void(^)(FSLockGestureView *lockVCiew, NSString *pwd))successBlock{
    //设置类型
    self.type = CoreLockTypeModifyPwd;
    //保存block
    self.successBlock = successBlock;
    
    [self dataTransfer];

}

/*
 *  事件
 */
-(void)event{
    
    __weak typeof(self) weakSelf = self;
    /*
     *  设置密码
     */
    
    /** 开始输入：第一次 */
    self.lockView.setPWBeginBlock = ^(){
        
        [weakSelf.label showNormalMsg:CoreLockPWDTitleFirst];
    };
    
    /** 开始输入：确认 */
    self.lockView.setPWConfirmlock = ^(){
        
        [weakSelf.label showNormalMsg:CoreLockPWDTitleConfirm];
    };
    
    
    /** 密码长度不够 */
    self.lockView.setPWSErrorLengthTooShortBlock = ^(NSUInteger currentCount){
        
        [weakSelf.label showWarnMsg:[NSString stringWithFormat:@"请连接至少%@个点",@(CoreLockMinItemCount)]];
    };
    
    /** 两次密码不一致 */
    self.lockView.setPWSErrorTwiceDiffBlock = ^(NSString *pwd1,NSString *pwdNow){
        
        [weakSelf.label showWarnMsg:CoreLockPWDDiffTitle];
        

    };
    
    /** 第一次输入密码：正确 */
    self.lockView.setPWFirstRightBlock = ^(NSString *pwd){
        
        weakSelf.lockInfoView.password = pwd;
        [weakSelf.label showNormalMsg:CoreLockPWDTitleConfirm];
    };
    
    /** 再次输入密码一致 */
    self.lockView.setPWTwiceSameBlock = ^(NSString *pwd){
        
        [weakSelf.lockInfoView clearDotView];
        
        [weakSelf.label showNormalMsg:CoreLockPWSuccessTitle];
        
        //TODO: 存储密码
        [CoreArchive setStr:pwd key:CoreLockPWDKey];
        
        if(_successBlock != nil) {
             weakSelf.successBlock(weakSelf,pwd);
        }
        if(CoreLockTypeModifyPwd == _type){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            });
        }
    };
    
    
    
    /*
     *  验证密码
     */
    
    /** 开始 */
    self.lockView.verifyPWBeginBlock = ^(){
        
        [weakSelf.label showNormalMsg:CoreLockVerifyNormalTitle];
    };
    
    
    
    /** 验证 */
    self.lockView.verifyPwdBlock = ^(NSString *pwd){
        
        //取出本地密码
        NSString *pwdLocal = [CoreArchive strForKey:CoreLockPWDKey];
        
        BOOL res = [pwdLocal isEqualToString:pwd];
        
        if(res){//密码一致
            
            [weakSelf.label showNormalMsg:CoreLockVerifySuccesslTitle];
            
            if(CoreLockTypeVeryfiPwd == _type){
                
                //禁用交互
                
            }else if (CoreLockTypeModifyPwd == _type){//修改密码
                
                [weakSelf.label showNormalMsg:CoreLockPWDTitleFirst];
                
                weakSelf.modifyCurrentTitle = CoreLockPWDTitleFirst;
            }
            
            if(CoreLockTypeVeryfiPwd == _type) {
                if(_successBlock != nil){
                    weakSelf.successBlock(weakSelf,pwd);
                }
            }
            
        }else{//密码不一致
            
            [weakSelf.label showWarnMsg:CoreLockVerifyErrorPwdTitle];
            
        }
        
        return res;
       
    };
    /*
     *  修改
     */
    
    /** 开始 */
    weakSelf.lockView.modifyPwdBlock =^(){
        
        [weakSelf.label showNormalMsg:weakSelf.modifyCurrentTitle];
    };
    
    /** 实时监听密码 **/
    self.lockView.setPWMonitoBlock = ^(NSString *pwd){
        
        weakSelf.lockInfoView.password = pwd;
        NSLog(@"------------------------%@",pwd);
    };
    
    
    
}


#pragma mark - 创建视图对象
- (CLLockInfoView *)lockInfoView {
    if (_lockInfoView == nil) {
        _lockInfoView = [[CLLockInfoView alloc] initWithFrame:CGRectMake((KScreenWidth - 112 * 0.5) * 0.5, 112 * 0.5, 12 * 3 + 6 * 2 ,12 * 3 + 6 * 2)];
    }
    return _lockInfoView;
}

- (CLLockLabel *)label {
    if (_label == nil) {
        _label = [[CLLockLabel alloc] initWithFrame:CGRectMake(20, tipLalbelOrignY, [UIScreen mainScreen].bounds.size.width - 40 ,13)];
    }
    return _label;
}

- (CLLockView *)lockView {
    if (_lockView == nil) {
        _lockView = [[CLLockView alloc] initWithFrame:CGRectMake(0, lockViewOrignY, KScreenWidth, KScreenWidth )];
    }
    return _lockView;
}



@end
