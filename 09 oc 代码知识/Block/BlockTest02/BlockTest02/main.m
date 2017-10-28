//
//  main.m
//  BlockTest02
//
//  Created by JQ on 2017/10/16.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        typedef int(^MyBlock)(int);
        for (int i = 0 ; i < 3; i ++) {
            MyBlock block = ^(int a) {
                return a;
            };
            NSLog(@"%@",block);
            // <__NSGlobalBlock__: 0x10c7c8168> 输出的地址一样。这个block在循环内，但是blk的地址总是不变的。说明这个block在全局段
            
            
        }
    }
    return 0;
}




/*
int main(int argc, const char * argv[]) {
    { __AtAutoreleasePool __autoreleasepool;
        
        typedef int(*MyBlock)(int);
        for (int i = 0 ; i < 3; i ++) {
            MyBlock block = ((int (*)(int))&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA));
            NSLog((NSString *)&__NSConstantStringImpl__var_folders_2v_vdw38yx56_jcpgkhvhdcn0900000gp_T_main_ca83ef_mi_0,block);
            
            
            
        }
    }
    return 0;
}
*/

