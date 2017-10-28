//
//  ViewController.m
//  BlockTest
//
//  Created by JQ on 2017/10/16.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "ViewController.h"
typedef void (^Block_t)() ;


@interface ViewController ()
{
    int  _temA ;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _temA = 10;

    [self setUpConfig];
}

- (void)setUpConfig
{
    
    //[self test01];
    
    //[self test02];
    
    //[self test03];

    //[self test04];
    [self test05];
    [self test06];
    [self test07];
}

/**
 捕获自动变量值
 如下： test01，test02
 block所在函数中的，捕获自动变量。但是不能修改它，不然就是“编译错误”。但是可以改变全局变量、静态变量、全局静态变量。其实这两个特点不难理解：
 ● 不能修改自动变量的值是因为：block捕获的是自动变量的const值，名字一样，不能修改
 ● 可以修改静态变量的值：静态变量属于类的，不是某一个变量。由于block内部不用调用self指针。所以block可以调用。
 解决block不能修改自动变量的值，这一问题的另外一个办法是使用__block修饰符
 
 */
- (void)test01 {
    
    //1.如果变量要在block 里面修改，需要 __block 修饰
    __block int x = 121;
    void (^PrintXAndY)(int) = ^(int y) {
        x = x + y;
        NSLog(@" %d %d",x,y);
        
    };
    
    PrintXAndY(2);
    
    //2.全局变量可以在 block 里面修改，以及（全局变量、静态变量、全局静态变量。）
    void(^MyBlock)(int) = ^(int a) {
        _temA = _temA + a;
        NSLog(@"%d",_temA);
    };
    
    MyBlock(3);
    
}


- (void)test02 {
    //1.用__block 修饰
    __block int i = 10;
    void(^MyBlock)(void) = ^() {
        NSLog(@"i = %d",i);
    };
    
    i = 2;
    MyBlock();  //输出 i = 2
    
    //2.不用 __block 修饰
    int j = 10;
    void(^MyBlock02)(void) = ^() {
        NSLog(@"j = %d",j);
    };
    
    j = 2;
    MyBlock02();  //输出 j = 10
    
}

/**
 Block存储区域
 ● _NSStackBlock 位于栈内存
 ● __NSGlobalBlock
 ● __NSMallocBlock 位于堆内存
 
 */
- (void)test03 {
    typedef int(^MyBlock)(int);
    for (int i = 0 ; i < 3; i ++) {
        MyBlock block = ^(int a) {
            return a;
        };
        NSLog(@"%@",block); // <__NSGlobalBlock__: 0x10c7c8168> 输出的地址一样。这个block在循环内，但是blk的地址总是不变的。说明这个block在全局段
        //注：针对没有捕获自动变量的block来说（Xcode9.0），虽然用clang的rewrite-objc转化后的代码中仍显示_NSConcretStackBlock(如图： block01.png)，但是实际上不是这样的（根据控制台输出__NSGlobalBlock__，两个不一样，到底是如何， 我不知道这个block 是全局的还是 在栈区的，没验证）。

    }
}

- (void)test04 {
    Block_t b = [self returnBlock];
    NSLog(@"b = %@",b);
    b();
    NSLog(@"b = %@",b);//b = <__NSMallocBlock__: 0x600000257ca0>

    Block_t b2 = [self returnBlock2];
    NSLog(@"b2 = %@",b2);
    b2();
    NSLog(@"b2 = %@",b2);//b2 = <__NSMallocBlock__: 0x60000044dbf0>
}

-(Block_t)returnBlock{
    __block int add=10;
    return ^{
        NSLog(@"add = %d",++add);   //add = 11
    };
}

-(Block_t)returnBlock2{
    __block int add2 =10;
    Block_t b = ^{
        NSLog(@"add2 = %d",++add2); //add2 = 11
    };
    return b;
}

- (void)test05 {
    
    NSArray *obj = [self getBlockArray];
    
    typedef void(^MyBlock)(void);
    for (int i = 0 ; i < obj.count; i ++) {
        NSLog(@"%@",[obj objectAtIndex:i]); //当执行i= 1时，崩溃，断点发现： obj 有2个元素，第一个为__NSMallocBlock__，第二个为_NSStackBlock，也许是执行完i= 1时，栈区的block 销毁了，然后去调用才会崩溃的吧（不确定）
        MyBlock b = [obj objectAtIndex:i];
        NSLog(@"b = %@",b);

        b();
        NSLog(@"b = %@",b);
    }
    
}

-(NSArray *) getBlockArray{
    int val =10;
    return [NSArray arrayWithObjects:
            ^{NSLog(@"blk0:%d",val);},
            ^{NSLog(@"blk1:%d",val);},nil];
    
//    这个是不会崩溃的
//    return [NSArray arrayWithObjects:
//            ^{NSLog(@"blk0:%d",val);},nil];
}

- (void)test06 {
    
    
}

- (void)test07 {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
