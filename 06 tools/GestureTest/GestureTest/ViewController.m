//
//  ViewController.m
//  GestureTest
//
//  Created by cfzq on 2017/6/28.
//  Copyright © 2017年 cfzq. All rights reserved.
//

#import "ViewController.h"
#import "FSLockGestureView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setPassword];

    //[self yanzhengPassword];
    
   
}


- (void)setPassword{
    FSLockGestureView *lockGestureView = [[FSLockGestureView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height )];
    //保存block
    [self.view addSubview:lockGestureView ];
    
    BOOL hasPwd = [lockGestureView hasPwd];
    hasPwd = NO;
    if(hasPwd){
        NSLog(@"已经设置过密码了，你可以验证或者修改密码");
    }else{
        [lockGestureView showSettingLockViewsuccessBlock:^(FSLockGestureView *lockVCiew, NSString *pwd) {
            NSLog(@"----- %@",pwd);
        }];
        
    }

}

- (void)yanzhengPassword{
    FSLockGestureView *lockGestureView = [[FSLockGestureView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height )];
    //保存block
    [self.view addSubview:lockGestureView ];
    
    BOOL hasPwd = [lockGestureView hasPwd];
    
    if(!hasPwd){
        NSLog(@"你还没有设置密码，请先设置密码");
    }else{
        [lockGestureView showVerifyLockViewForgetPwdBlock:^{
            
        } successBlock:^(FSLockGestureView *lockVCiew, NSString *pwd) {
            NSLog(@"----- %@",pwd);

        }];
        
    }

}


- (void)xiugai{
    FSLockGestureView *lockGestureView = [[FSLockGestureView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height )];
    //保存block
    [self.view addSubview:lockGestureView ];
    BOOL hasPwd = [lockGestureView hasPwd];
    if(!hasPwd){
        NSLog(@"你还没有设置密码，请先设置密码");
    }else{
        [lockGestureView showModifyLockLockViewFSuccessBlock:^(FSLockGestureView *lockVCiew, NSString *pwd) {
            
        }];
    }
}



@end
