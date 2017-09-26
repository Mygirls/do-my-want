//
//  ViewController.m
//  RuntimeDemo07_KVO-2
//
//  Created by JQ on 2017/9/23.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+KVO.h"
@interface ViewController ()
@property(nonatomic,strong) Person *p;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _p = [[Person alloc] init];
    
    NSLog(@"%@",_p);
    
    /**
     kvo
     https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html#//apple_ref/doc/uid/10000177-BCICJDHA
     
     kvc
     https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/KeyValueCoding/Articles/KeyValueCoding.html#//apple_ref/doc/uid/10000107i
     
     1. command + Q 关闭工程项目
     2. 在次运行项目，在Person 创建对象之后加上一个断点
     3. 在 控制台可以看出 _p 目录下 NSObject ——> isa 又个isa 指针，指向（class）Person
     4. 调用 [_p FF_addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil] 之后
     5. 在 控制台可以看出 _p 目录下 NSObject ——> isa 又个isa 指针，指向（class）FFKVOPerson
     (self->_p->isa:NSKVONotifying_Person)，
     6. 监听属性的值age 是否被修改，其实是在NSKVONotifying_Person类里面重写了set 方法，一旦改变，就是通知父类做一系列操作
     7. 当我 用成员变量_name 时候，无法监听，所以证明只能观察重写的 set 方法
     
     [self willChangeValueForKey:@"age"];
     [self didChangeValueForKey:@"age"];    //并把得到的结果分别当成old value和new value，以告知观察者。
     //做了很事情
     //...
     //
     
     */
    //系统添加观察者
//    [_p addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
//    [_p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    //自己用 runtime 写一个kvo
    [_p FF_addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil  ];
    
    
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%@",change);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    static int i = 100;
    i ++;
    _p.age = i;   //访问set 方法
    
    _p->_name = @"";    //直接访问成员变量
}

- (void)dealloc
{
    
    [self removeObserver:_p forKeyPath:@"age"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
