//
//  ViewController.m
//  Runtime 02
//
//  Created by JQ on 2017/9/19.
//  Copyright © 2017年 Majq. All rights reserved.
//
//http://southpeak.github.io/2014/10/25/objective-c-runtime-1/
//http://www.jianshu.com/p/6b905584f536
//http://www.cnblogs.com/HermitCarb/p/4740803.html

#import "ViewController.h"
#import <objc/runtime.h>

void TestMetaClass(id self, SEL _cmd) {
    NSLog(@"This objcet is %p", self);
    NSLog(@"Class is %@, super class is %@", [self class], [self superclass]);
    
    Class currentClass = [self class];
    for (int i = 0; i < 4; i++) {
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        currentClass = objc_getClass((__bridge void *)currentClass);
    }
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p", objc_getClass((__bridge void *)[NSObject class]));
}


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self setUpConfig];
}


- (void)setUpConfig {
    
    [self typeEncoding];

}

#pragma mark - _______________成员变量与属性_______________

#pragma mark - 1. 类型编码(Type Encoding)
/**
 
 作为对Runtime的补充，编译器将每个方法的返回值和参数类型编码为一个字符串，并将其与方法的selector关联在一起。
 这种编码方案在其它情况下也是非常有用的，因此我们可以使用 @ encode编译器指令来获取它。
 当给定一个类型时，@ encode返回这个类型的字符串编码。这些类型可以是诸如int、指针这样的基本类型，也可以是结构体、类等类型。
 事实上，任何可以作为sizeof()操作参数的类型都可以用于@ encode()。
 

Objective-C Runtime Programming Guide中的Type Encoding一节中(https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1)
 
 */

- (void)typeEncoding
{
    float a[] = {1.0, 2.0, 3.0};
    NSLog(@"array encoding type: %s", @encode(typeof(a)));
    //array encoding type: [3f]


}

#pragma mark - 2. 成员变量、属性
/**
 Runtime中关于成员变量和属性的相关数据结构并不多，只有三个，并且都很简单。不过还有个非常实用但可能经常被忽视的特性，即关联对象，我们将在这小节中详细讨论。
 */

//2.1   基础数据类型
//Ivar
//Ivar是表示实例变量的类型，其实际是一个指向objc_ivar结构体的指针，其定义如下：
/*
    typedef struct objc_ivar *Ivar;


    struct objc_ivar {
        char *ivar_name     OBJC2_UNAVAILABLE;  // 变量名
        char *ivar_type     OBJC2_UNAVAILABLE;  // 变量类型
        int ivar_offset     OBJC2_UNAVAILABLE;  // 基地址偏移字节
    #ifdef __LP64__
        int space   OBJC2_UNAVAILABLE;
    #endif
    }

*/

//objc_property_t
/**
 objc_property_t是表示Objective-C声明的属性的类型，其实际是指向objc_property结构体的指针，其定义如下：
 
 */
//typedef struct objc_property *objc_property_t;

//objc_property_attribute_t
/**
 objc_property_attribute_t定义了属性的特性(attribute)，它是一个结构体，定义如下：

 */
//    /// Defines a property attribute
//    typedef struct {
//        const char *name;           /**< The name of the attribute(特性名) */
//        const char *value;          /**< The value of the attribute (usually empty) 特性值 */
//    } objc_property_attribute_t;


//2.2   关联对象(Associated Object)
/**
 关联对象是Runtime中一个非常实用的特性，不过可能很容易被忽视。
 
 关联对象类似于成员变量，不过是在运行时添加的。我们通常会把成员变量(Ivar)放在类声明的头文件中，或者放在类实现的@implementation后面。但这有一个缺点，我们不能在分类中添加成员变量。如果我们尝试在分类中添加新的成员变量，编译器会报错。
 
 我们可能希望通过使用(甚至是滥用)全局变量来解决这个问题。但这些都不是Ivar，因为他们不会连接到一个单独的实例。因此，这种方法很少使用。
 
 Objective-C针对这一问题，提供了一个解决方案：即关联对象(Associated Object)。
 
 我们可以把关联对象想象成一个Objective-C对象(如字典)，这个对象通过给定的key连接到类的一个实例上。不过由于使用的是C接口，所以key是一个void指针(const void *)。我们还需要指定一个内存管理策略，以告诉Runtime如何管理这个对象的内存。这个内存管理的策略可以由以下值指定：
 
 OBJC_ASSOCIATION_ASSIGN
 OBJC_ASSOCIATION_RETAIN_NONATOMIC
 OBJC_ASSOCIATION_COPY_NONATOMIC
 OBJC_ASSOCIATION_RETAIN
 OBJC_ASSOCIATION_COPY
 
 当宿主对象被释放时，会根据指定的内存管理策略来处理关联对象。如果指定的策略是assign，则宿主释放时，关联对象不会被释放；而如果指定的是retain或者是copy，则宿主释放时，关联对象会被释放。我们甚至可以选择是否是自动retain/copy。当我们需要在多个线程中处理访问关联对象的多线程代码时，这就非常有用了。
 
 我们将一个对象连接到其它对象所需要做的就是下面两行代码：
 
 static char myKey;
 objc_setAssociatedObject(self, &myKey, anObject, OBJC_ASSOCIATION_RETAIN);

 在这种情况下，self对象将获取一个新的关联的对象anObject，且内存管理策略是自动retain关联对象，当self对象释放时，会自动release关联对象。另外，如果我们使用同一个key来关联另外一个对象时，也会自动释放之前关联的对象，这种情况下，先前的关联对象会被妥善地处理掉，并且新的对象会使用它的内存。
 
 id anObject = objc_getAssociatedObject(self, &myKey);

 我们可以使用objc_removeAssociatedObjects函数来移除一个关联对象，或者使用objc_setAssociatedObject函数将key指定的关联对象设置为nil。
 
 我们下面来用实例演示一下关联对象的使用方法。
 
 假定我们想要动态地将一个Tap手势操作连接到任何UIView中，并且根据需要指定点击后的实际操作。
 这时候我们就可以将一个手势对象及操作的block对象关联到我们的UIView对象中。
 这项任务分两部分。首先，如果需要，我们要创建一个手势识别对象并将它及block做为关联对象。如下代码所示：
 
 */

- (void)setTapActionWithBlock:(void (^)(void))block
{
    static char kDTActionHandlerTapGestureKey;

    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
    
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForTapGesture:)];
        [self.view addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    static char kDTActionHandlerTapBlockKey;

    objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

//```
//这段代码检测了手势识别的关联对象。如果没有，则创建并建立关联关系。同时，将传入的块对象连接到指定的key上。注意`block`对象的关联内存管理策略。
//手势识别对象需要一个`target`和`action`，所以接下来我们定义处理方法：
//```objc
- (void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
    
    static char kDTActionHandlerTapBlockKey;

    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);
        if (action)
        {
            action();
        }
    }
}














@end
