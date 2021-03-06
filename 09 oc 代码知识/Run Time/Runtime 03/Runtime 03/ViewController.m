//
//  ViewController.m
//  Runtime 03
//
//  Created by JQ on 2017/9/19.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpConfig];
}


- (void)setUpConfig
{
    [self example];
}

#pragma mark - -------------------方法与消息-------------------
//基础数据类型

//MARK: - 1. SEL
/**
 SEL又叫选择器，是表示一个方法的selector的指针，其定义如下：
 
 typedef struct objc_selector *SEL;
 
 
 bjc_selector结构体的详细定义没有在<objc/runtime.h>头文件中找到。
 方法的selector用于表示运行时方法的名字。
 Objective-C在编译时，会依据每一个方法的名字、参数序列，生成一个唯一的整型标识(Int类型的地址)，这个标识就是SEL。如下代码所示
 */

- (void)example {

    SEL sel1 = @selector(method1);
    NSLog(@"sel1 = %p",sel1 );  // sel1 = 0x10f417c2a
    
    SEL sel2 = @selector(method1);
    NSLog(@"sel2 = %p",sel2 );  // sel2 = 0x10f417c2a
    
    /**
     
     两个类之间，不管它们是父类与子类的关系，还是之间没有这种关系，只要方法名相同，那么方法的SEL就是一样的。
     每一个方法都对应着一个SEL。所以在Objective-C同一个类(及类的继承体系)中，不能存在2个同名的方法，即使参数类型不同也不行。相同的方法只能对应一个SEL。这也就导致Objective-C在处理相同方法名且参数个数相同但类型不同的方法方面的能力很差。如在某个类中定义以下两个方法：
     
     
     - (void)setWidth:(int)width;
     - (void)setWidth:(double)width;

     
     这样的定义被认为是一种编译错误，所以我们不能像C++, C#那样。而是需要像下面这样来声明：
     
     当然，不同的类可以拥有相同的selector，这个没有问题。
     不同类的实例对象执行相同的selector时，会在各自的方法列表中去根据selector去寻找自己对应的IMP。
     IMP implement的简写,俗称方法实现,看源码得知它就是一个函数指针:
        typedef void (*IMP)(void  );  // id, SEL, ...
     http://blog.csdn.net/yujianxiang666/article/details/46740133
      objc/runtime中SEL、IMP和method动态定义
     */
    
    /**
     工程中的所有的SEL组成一个Set集合，Set的特点就是唯一，因此SEL是唯一的。
     因此，如果我们想到这个方法集合中查找某个方法时，只需要去找到这个方法对应的SEL就行了，SEL实际上就是根据方法名hash化了的一个字符串，而对于字符串的比较仅仅需要比较他们的地址就可以了，可以说速度上无语伦比！！但是，有一个问题，就是数量增多会增大hash冲突而导致的性能下降（或是没有冲突，因为也可能用的是perfect hash）。
     但是不管使用什么样的方法加速，如果能够将总量减少（多个方法可能对应同一个SEL），那将是最犀利的方法。那么，我们就不难理解，为什么SEL仅仅是函数名了。
     
     */
    
    //本质上，SEL只是一个指向方法的指针（准确的说，只是一个根据方法名hash化了的KEY值，能唯一代表一个方法），它的存在只是为了加快方法的查询速度。这个查找过程我们将在下面讨论。
    
    //我们可以在运行时添加新的selector，也可以在运行时获取已存在的selector，我们可以通过下面三种方法来获取SEL:
    
    /**
     sel_registerName函数
     Objective-C编译器提供的@selector()
     NSSelectorFromString()方法

     */
    
}

- (void) method1
{

}

//MARK: - 2. IMP
/**
 IMP实际上是一个函数指针，指向方法实现的首地址。其定义如下：

 /// A pointer to the function of a method implementation.
 #if !OBJC_OLD_DISPATCH_PROTOTYPES
 
    typedef void (*IMP)(void );
 
 #else
 
    typedef id (*IMP)(id, SEL, ...);
 
 #endif


 */

/**
 这个函数使用当前CPU架构实现的标准的C调用约定。第一个参数是指向self的指针(如果是实例方法，则是类实例的内存地址；如果是类方法，则是指向元类的指针)，第二个参数是方法选择器(selector)，接下来是方法的实际参数列表。
 
 前面介绍过的SEL就是为了查找方法的最终实现IMP的。由于每个方法对应唯一的SEL，因此我们可以通过SEL方便快速准确地获得它所对应的IMP，查找过程将在下面讨论。取得IMP后，我们就获得了执行这个方法代码的入口点，此时，我们就可以像调用普通的C语言函数一样来使用这个函数指针了。
 
 通过取得IMP，我们可以跳过Runtime的消息传递机制，直接执行IMP指向的函数实现，这样省去了Runtime消息传递过程中所做的一系列查找操作，会比直接向对象发送消息高效一些。
 */

//MARK: - 3. Method
//Method
/**
 typedef struct objc_method *Method;
 
 struct objc_method {
     SEL method_name          OBJC2_UNAVAILABLE;    // 方法名
     char *method_types       OBJC2_UNAVAILABLE;
     IMP method_imp           OBJC2_UNAVAILABLE;    // 方法实现
 }
 
 该结构体中包含一个SEL和IMP，实际上相当于在SEL和IMP之间作了一个映射。有了SEL，我们便可以找到对应的IMP，从而调用方法的实现代码。
 */

//objc_method_description

//struct objc_method_description { SEL name; char *types; };

/**
 // 调用指定方法的实现
 id method_invoke ( id receiver, Method m, ... );
 // 调用返回一个数据结构的方法的实现
 void method_invoke_stret ( id receiver, Method m, ... );
 // 获取方法名
 SEL method_getName ( Method m );
 // 返回方法的实现
 IMP method_getImplementation ( Method m );
 // 获取描述方法参数和返回值类型的字符串
 const char * method_getTypeEncoding ( Method m );
 // 获取方法的返回值类型的字符串
 char * method_copyReturnType ( Method m );
 // 获取方法的指定位置参数的类型字符串
 char * method_copyArgumentType ( Method m, unsigned int index );
 // 通过引用返回方法的返回值类型字符串
 void method_getReturnType ( Method m, char *dst, size_t dst_len );
 // 返回方法的参数的个数
 unsigned int method_getNumberOfArguments ( Method m );
 // 通过引用返回方法指定位置参数的类型字符串
 void method_getArgumentType ( Method m, unsigned int index, char *dst, size_t dst_len );
 // 返回指定方法的方法描述结构体
 struct objc_method_description * method_getDescription ( Method m );
 // 设置方法的实现
 IMP method_setImplementation ( Method m, IMP imp );
 // 交换两个方法的实现
 void method_exchangeImplementations ( Method m1, Method m2 );
 
 */















@end
