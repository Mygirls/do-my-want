//
//  ViewController.m
//  Runtime01
//
//  Created by JQ on 2017/9/19.
//  Copyright © 2017年 Majq. All rights reserved.
//
//http://southpeak.github.io/2014/10/25/objective-c-runtime-1/
//http://www.jianshu.com/p/6b905584f536
//http://www.cnblogs.com/HermitCarb/p/4740803.html

#import "ViewController.h"
#import "MyClass.h"


#include <objc/objc.h>
#import <objc/runtime.h>


//typedef struct objc_selector *SEL;

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

    [self testExercise];
    
    [self testExample];
    

}

/** 前言：
 1. Objective-C语言是一门动态语言，它将很多静态语言在编译和链接时期做的事放到了运行时来处理。这种动态语言的优势在于：我们写代码时更具灵活性，如我们可以把消息转发给我们想要的对象，或者随意交换一个方法的实现等。
 
 2. 这种特性意味着Objective-C不仅需要一个编译器，还需要一个运行时系统来执行编译的代码。
 
 3. 这个运行时系统即Objc Runtime。
 
 4. Runtime库主要做下面几件事：
 
    封装：在这个库中，对象可以用C语言中的结构体表示，而方法可以用C函数来实现，另外再加上了一些额外的特性。这些结构体和函数被runtime函数封装后，我们就可以在程序运行时创建，检查，修改类、对象和它们的方法了。
    找出方法的最终执行代码：当程序执行[object doSomething]时，会向消息接收者(object)发送一条消息(doSomething)，runtime会根据消息接收者是否能响应该消息而做出不同的反应。这将在后面详细介绍
 
 5. Objective-C runtime目前有两个版本：Modern runtime和Legacy runtime
 
 
 */


#pragma mark - 1.类与对象基础数据结构 - (Class)

/** Class
 1. Objective-C类是由Class类型来表示的，它实际上是一个指向objc_class结构体的指针
 
 2. 定义：
 
 /// An opaque type that represents an Objective-C class.(一个不透明的类型，表示一个Objective-C类)
 typedef struct objc_class *Class;
 
 
 3. 查看objc/runtime.h中objc_class结构体的定义如下：
 struct objc_class {
    Class isa  OBJC_ISA_AVAILABILITY;
 
 #if !__OBJC2__
     Class super_class                                        OBJC2_UNAVAILABLE;
     const char *name                                         OBJC2_UNAVAILABLE;
     long version                                             OBJC2_UNAVAILABLE;
     long info                                                OBJC2_UNAVAILABLE;
     long instance_size                                       OBJC2_UNAVAILABLE;
     struct objc_ivar_list *ivars                             OBJC2_UNAVAILABLE;
     struct objc_method_list **methodLists                    OBJC2_UNAVAILABLE;
     struct objc_cache *cache                                 OBJC2_UNAVAILABLE;
     struct objc_protocol_list *protocols                     OBJC2_UNAVAILABLE;
 #endif
 
 } OBJC2_UNAVAILABLE;


 4. 解释：
    4.1> 需要注意的是在Objective-C中，所有的类自身也是一个对象，这个对象的Class里面也有一个isa指针，它指向metaClass(元类)，我们会在后面介绍它。
    4.2> super_class：指向该类的父类，如果该类已经是最顶层的根类(如NSObject或NSProxy)，则super_class为NULL。
    4.3> cache：用于缓存最近使用的方法。一个接收者对象接收到一个消息时，它会根据isa指针去查找能够响应这个消息的对象。在实际使用中，这个对象只有一部分方法是常用的，很多方法其实很少用或者根本用不上。这种情况下，如果每次消息来时，我们都是methodLists中遍历一遍，性能势必很差。这时，cache就派上用场了。在我们每次调用过一个方法后，这个方法就会被缓存到cache列表中，下次调用的时候runtime就会优先去cache中查找，如果cache没有，才去methodLists中查找方法。这样，对于那些经常用到的方法的调用，但提高了调用的效率。
    4.4> version：我们可以使用这个字段来提供类的版本信息。这对于对象的序列化非常有用，它可是让我们识别出不同类定义版本中实例变量布局的改变。

    针对cache，我们用下面例子来说明其执行过程： 
        [self testRunTimeCache];
 
 */

//struct objc_class {
//    Class isa  OBJC_ISA_AVAILABILITY;
//
//#if !__OBJC2__
//    Class super_class                                        OBJC2_UNAVAILABLE;
//    const char *name                                         OBJC2_UNAVAILABLE;
//    long version                                             OBJC2_UNAVAILABLE;
//    long info                                                OBJC2_UNAVAILABLE;
//    long instance_size                                       OBJC2_UNAVAILABLE;
//    struct objc_ivar_list *ivars                             OBJC2_UNAVAILABLE;
//    struct objc_method_list **methodLists                    OBJC2_UNAVAILABLE;
//    struct objc_cache *cache                                 OBJC2_UNAVAILABLE;
//    struct objc_protocol_list *protocols                     OBJC2_UNAVAILABLE;
//#endif
//
//} OBJC2_UNAVAILABLE;



- (void)testRunTimeCache {
    NSArray *array = [[NSArray alloc] init];

    //...
    
    /**  其流程是：
     1. `[NSArray alloc]`先被执行。因为NSArray没有`+alloc`方法，于是去父类NSObject去查找。
     2. 检测NSObject是否响应`+alloc`方法，发现响应，于是检测NSArray类，并根据其所需的内存空间大小开始分配内存空间，然后把`isa`指针指向NSArray类。同时，`+alloc`也被加进cache列表里面。
     3. 接着，执行`-init`方法，如果NSArray响应该方法，则直接将其加入`cache`；如果不响应，则去父类查找。
     4. 在后期的操作中，如果再以`[[NSArray alloc] init]`这种方式来创建数组，则会直接从cache中取出相应的方法，直接调用。
     
     ### objc_object与id
     `objc_object`是表示一个类的实例的结构体，它的定义如下(`objc/objc.h`)：
     
     ```objc
     struct objc_object {
        Class isa  OBJC_ISA_AVAILABILITY;
     };
     
     typedef struct objc_object *id;
     
     
     
     5. 可以看到，这个结构体只有一个字体，即指向其类的isa指针。这样，当我们向一个Objective-C对象发送消息时，运行时库会根据实例对象的isa指针找到这个实例对象所属的类。Runtime库会在类的方法列表及父类的方法列表中去寻找与消息对应的selector指向的方法。找到后即运行这个方法。
     
     6. 当创建一个特定类的实例对象时，分配的内存包含一个objc_object数据结构，然后是类的实例变量的数据。NSObject类的alloc和allocWithZone:方法使用函数class_createInstance来创建objc_object数据结构。
     
     7. 另外还有我们常见的id，它是一个objc_object结构类型的指针。它的存在可以让我们实现类似于C++中泛型的一些操作。该类型的对象可以转换为任何一种对象，有点类似于C语言中void *指针类型的作用。
     

     */
    
    

}

///// Represents an instance of a class.（表示类的实例的结构体）
//struct objc_object {
//    Class isa  OBJC_ISA_AVAILABILITY;
//};
//
///// A pointer to an instance of a class.（指向类实例的指针）
//typedef struct objc_object *id;


#pragma mark - 2.类与对象基础数据结构 -（objc_cache）
/**
    上面提到了objc_class结构体中的cache字段，它用于缓存调用过的方法。这个字段是一个指向objc_cache结构体的指针，其定义如下：
        
    struct objc_cache *cache 
 
    结构体 如下：
 
 该结构体的字段描述如下：
 
 1. mask：一个整数，指定分配的缓存bucket的总数。在方法查找过程中，Objective-C runtime使用这个字段来确定开始线性查找数组的索引位置。指向方法selector的指针与该字段做一个AND位操作(index = (mask & selector))。这可以作为一个简单的hash散列算法。
 
 2. occupied：一个整数，指定实际占用的缓存bucket的总数。
 
 3. buckets：指向Method数据结构指针的数组。这个数组可能包含不超过mask+1个元素。需要注意的是，指针可能是NULL，表示这个缓存bucket没有被占用，另外被占用的bucket可能是不连续的。这个数组可能会随着时间而增长。
 /// An opaque type that represents a method in a class definition.（表示类定义中的方法的不透明类型）
 typedef struct objc_method *Method;
 
 */

//struct objc_cache {
//    unsigned int mask /* total = mask + 1 */                 OBJC2_UNAVAILABLE;
//    unsigned int occupied                                    OBJC2_UNAVAILABLE;
//    Method buckets[1]                                        OBJC2_UNAVAILABLE;
//};



#pragma mark - 元类(Meta Class)
/**
 
    在上面我们提到，所有的类自身也是一个对象，我们可以向这个对象发送消息(即调用类方法)。如
        [self testRunTimeMetaClass];
 
    这个例子中，+array消息发送给了NSArray类，而这个NSArray也是一个对象。既然是对象，那么它也是一个objc_object指针，它包含一个指向其类的一个isa指针。那么这些就有一个问题了，这个isa指针指向什么呢？为了调用+array方法，这个类的isa指针必须指向一个包含这些类方法的一个objc_class结构体。这就引出了meta-class的概念
 
        
    meta-class是一个类对象的类。
 
 当我们向一个对象发送消息时，runtime会在这个对象所属的这个类的方法列表中查找方法；而向一个类发送消息时，会在这个类的meta-class的方法列表中查找。
 
 meta-class之所以重要，是因为它存储着一个类的所有类方法。每个类都会有一个单独的meta-class，因为每个类的类方法基本不可能完全相同。
 
 再深入一下，meta-class也是一个类，也可以向它发送一个消息，那么它的isa又是指向什么呢？为了不让这种结构无限延伸下去，Objective-C的设计者让所有的meta-class的isa指向基类的meta-class，以此作为它们的所属类。即，任何NSObject继承体系下的meta-class都使用NSObject的meta-class作为自己的所属类，而基类的meta-class的isa指针是指向它自己。这样就形成了一个完美的闭环。
 
 */
- (void)testRunTimeMetaClass {
    NSArray *array = [NSArray array];
    
}

#pragma mark - 3.练习
- (void)testExercise {
    [self ex_registerClassPair];
    
    /**
        这个例子是在运行时创建了一个NSError的子类TestClass，然后为这个子类添加一个方法testMetaClass，这个方法的实现是TestMetaClass函数
     
        我们在for循环中，我们通过objc_getClass来获取对象的isa，并将其打印出来，依此一直回溯到NSObject的meta-class。分析打印结果，可以看到最后指针指向的地址是0x0，即NSObject的meta-class的类地址。
     
  
        这里需要注意的是：我们在一个类对象调用class方法是无法获取meta-class，它只是返回类而已。
     

     

     */
}

- (void)ex_registerClassPair {
    Class newClass = objc_allocateClassPair([NSError class], "TestClass", 0);
    class_addMethod(newClass, @selector(testMetaClass), (IMP)TestMetaClass, "v@:");//添加方法
    //class_addMethod(newClass, <#SEL name#>, <#IMP imp#>, <#const char *types#>)
    objc_registerClassPair(newClass);
    id instance = [[newClass alloc] initWithDomain:@"some domain" code:0 userInfo:nil];
    [instance performSelector:@selector(testMetaClass)];
}

#pragma mark - 4. 类与对象操作函数
/**
 runtime提供了大量的函数来操作类与对象。类的操作方法大部分是以class_为前缀的，而对象的操作方法大部分是以objc_或object_为前缀。下面我们将根据这些方法的用途来分类讨论这些方法的使用。
 */

#pragma mark - 5. 类相关操作函数
/**
 我们可以回过头去看看objc_class的定义，runtime提供的操作类的方法主要就是针对这个结构体中的各个字段的。下面我们分别介绍这一些的函数。并在最后以实例来演示这些函数的具体用法。
 */

- (void)testExample {
    NSLog(@"==========================================================");

    MyClass *myClass = [[MyClass alloc] init];
    unsigned int outCount = 0;
    Class cls = myClass.class;
    
    //MARK: - 类名(name)
    
    //1. 获取类的类名
    //const char * class_getName ( Class cls );
    //对于class_getName函数，如果传入的cls为Nil，则返回一个字字符串
    NSLog(@"class name: %s",class_getName(cls));    //class name: MyClass
    
    //2. 获取类的父类
    //Class class_getSuperclass ( Class cls );
    //class_getSuperclass函数，当cls为Nil或者cls为根类时，返回Nil。不过通常我们可以使用NSObject类的superclass方法来达到同样的目的。
    NSLog(@"super class name: %s",class_getName(class_getSuperclass(cls)));//super class name: NSObject
    
    //3. 判断给定的Class是否是一个元类
    //BOOL class_isMetaClass ( Class cls );
    NSLog(@"MyClass is %@ a meta-class", (class_isMetaClass(cls) ? @"" : @"not"));  //MyClass is not a meta-class

    Class meta_class = objc_getMetaClass(class_getName(cls));
    NSLog(@"%s's meta-class is %s", class_getName(cls), class_getName(meta_class)); // MyClass's meta-class is MyClass

    //4.实例变量大小(instance_size)
    //size_t class_getInstanceSize ( Class cls );
    //size_t class_getInstanceSize ( Class cls );
    NSLog(@"instance size: %zu",class_getInstanceSize(cls)); //48
   
    
    /**
     成员变量(ivars)及属性
     
     在objc_class中，所有的成员变量、属性的信息是放在链表ivars中的。ivars是一个数组，数组中每个元素是指向Ivar(变量信息)的指针。runtime提供了丰富的函数来操作这一字段。大体上可以分为以下几类：
     
     1>.成员变量操作函数，主要包含以下函数：
     
     // 获取类中指定名称实例成员变量的信息
     Ivar class_getInstanceVariable ( Class cls, const char *name );
     
     // 获取类成员变量的信息
     Ivar class_getClassVariable ( Class cls, const char *name );
     
     // 添加成员变量
     BOOL class_addIvar ( Class cls, const char *name, size_t size, uint8_t alignment, const char *types );
     
     // 获取整个成员变量列表
     Ivar * class_copyIvarList ( Class cls, unsigned int *outCount );

     
     class_getInstanceVariable函数，它返回一个指向包含name指定的成员变量信息的objc_ivar结构体的指针(Ivar)。
     
     class_getClassVariable函数，目前没有找到关于Objective-C中类变量的信息，一般认为Objective-C不支持类变量。注意，返回的列表不包含父类的成员变量和属性。
     
     Objective-C不支持往已存在的类中添加实例变量，因此不管是系统库提供的提供的类，还是我们自定义的类，都无法动态添加成员变量。但如果我们通过运行时来创建一个类的话，又应该如何给它添加成员变量呢？这时我们就可以使用class_addIvar函数了。不过需要注意的是，这个方法只能在objc_allocateClassPair函数与objc_registerClassPair之间调用。另外，这个类也不能是元类。成员变量的按字节最小对齐量是1<<alignment。这取决于ivar的类型和机器的架构。如果变量的类型是指针类型，则传递log2(sizeof(pointer_type))。
     
     class_copyIvarList函数，它返回一个指向成员变量信息的数组，数组中每个元素是指向该成员变量信息的objc_ivar结构体的指针。这个数组不包含在父类中声明的变量。outCount指针返回数组的大小。需要注意的是，我们必须使用free()来释放这个数组。
     
     
     2>.属性操作函数，主要包含以下函数：
     
     // 获取指定的属性
     objc_property_t class_getProperty ( Class cls, const char *name );
     
     // 获取属性列表
     objc_property_t * class_copyPropertyList ( Class cls, unsigned int *outCount );
     
     // 为类添加属性
     BOOL class_addProperty ( Class cls, const char *name, const objc_property_attribute_t *attributes, unsigned int attributeCount );
     
     // 替换类的属性
     void class_replaceProperty ( Class cls, const char *name, const objc_property_attribute_t *attributes, unsigned int attributeCount );
     
     */
    
    NSLog(@"------------成员变量------------");
    // 成员变量
    Ivar *ivars = class_copyIvarList(cls, &outCount);   //获取整个成员变量列表
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"instance variable's name: %s at index: %d", ivar_getName(ivar), i);
    }
    free(ivars);
    Ivar string = class_getInstanceVariable(cls, "_string");    //获取类中指定名称实例成员变量的信息

    NSLog(@"%p",string);
    if (string != NULL) {
        NSLog(@"instace variable %s", ivar_getName(string));
    }

    Ivar s = class_getClassVariable(cls, "_string");  //获取类成员变量的信息
    //函数，目前没有找到关于Objective-C中类变量的信息，一般认为Objective-C不支持类变量。注意，返回的列表不包含父类的成员变量和属性
    NSLog(@"%s", ivar_getName(s));
    
    // 属性操作
    NSLog(@"------------ 属性操作 ------------");
    objc_property_t * properties = class_copyPropertyList(cls, &outCount);  //获取属性列表
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSLog(@"property's name: %s", property_getName(property));
    }
    free(properties);
    objc_property_t array = class_getProperty(cls, "array");    //获取指定的属性
    if (array != NULL) {
        NSLog(@"property %s", property_getName(array));
    }


    // 方法操作
    Method *methods = class_copyMethodList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = methods[i];
        NSLog(@"method's signature: %s", method_getName(method));
    }
    free(methods);
    Method method1 = class_getInstanceMethod(cls, @selector(method1));
    if (method1 != NULL) {
        NSLog(@"method %s", method_getName(method1));
    }
    Method classMethod = class_getClassMethod(cls, @selector(classMethod1));
    if (classMethod != NULL) {
        NSLog(@"class method : %s", method_getName(classMethod));
    }
    
    //类实例是否响应指定的selector
    NSLog(@"MyClass is%@ responsd to selector: method3WithArg1:arg2:", class_respondsToSelector(cls, @selector(method3WithArg1:arg2:)) ? @"" : @" not");
    IMP imp = class_getMethodImplementation(cls, @selector(method1));
    imp();
    NSLog(@"==========================================================");
    // 协议
    Protocol * __unsafe_unretained * protocols = class_copyProtocolList(cls, &outCount);
    Protocol * protocol;
    for (int i = 0; i < outCount; i++) {
        protocol = protocols[i];
        NSLog(@"protocol name: %s", protocol_getName(protocol));
    }
    NSLog(@"MyClass is%@ responsed to protocol %s", class_conformsToProtocol(cls, protocol) ? @"" : @" not", protocol_getName(protocol));
    NSLog(@"===============");
          
          
}































@end
