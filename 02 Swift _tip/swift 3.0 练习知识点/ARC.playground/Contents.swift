//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


print("---------------自动引用计数的工作机制---------------")

    // 1.自动引用计数的工作机制
    
    /*
     
     1.1 当你每次创建一个类的新的实例的时候，ARC 会分配一块内存来储存该实例信息。内存中会包含实例的类型信 息，以及这个实例所有相关的存储型属性的值。
     
     1.2 此外，当实例不再被使用时，ARC 释放实例所占用的内存，并让释放的内存能挪作他用。这确保了不再被使用的 实例，不会一直占用内存空间。
     
     1.3 然而，当 ARC 收回和释放了正在被使用中的实例，该实例的属性和方法将不能再被访问和调用。实际上，如果你 试图访问这个实例，你的应用程序很可能会崩溃。
     
     1.4 为了使上述成为可能，无论你将实例赋值给属性、常量或变量，它们都会创建此实例的强引用。之所以称之为“强”引用，是因为它会将实例牢牢地保持住，只要强引用还在，实例是不允许被销毁的。
     */

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
        
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}


// 2. 自动引用计数实践
// 2.1 它们的值会被自动初始化为 nil ，目 前还不会引用到 Person 类的实例。
var reference1: Person?
var reference2: Person?
var reference3: Person?

//2.2 创建 Person 类的新实例，并且将它赋值给三个变量中的一个
reference1 = Person(name: "John Appleseed")
withUnsafePointer(to: &reference3) {
    print("\($0)")      //相比于oc：a、b的地址是一样，而swift： a、b的地址不一样
}

withUnsafeBytes(of: &reference1) { (p)  in
    print(p)
}

//由于 Person 类的新实例被赋值给了 reference1 变量，所以 reference1 到 Person 类的新实例之间建立了一个强 引用。正是因为这一个强引用，ARC 会保证 Person 实例被保持在内存中不被销毁。

//2.3 如果你将同一个 Person 实例也赋值给其他两个变量，该实例又会多出两个强引用:
reference2 = reference1
reference3 = reference1 //现在Person 实例已经有三个强引用了。

//2.4 给其中两个变量赋值 nil 的方式断开两个强引用
reference1 = nil
reference2 = nil

//2.3 给最后一个 变量赋值 nil 的方式断开强引用
reference3 = nil //此时出现： John Appleseed is being deinitialized 说明调用了deinit 方法，表明 对象 销毁了

print("---------------类实例之间的循环强引用---------------")

//3. 类实例之间的循环强引用
//3.1 在上面的例子中，ARC 会跟踪你所新创建的 Person 实例的引用数量，并且会在 Person 实例不再被需要时销毁 它
//3.2 如果两个类实例互相持有对方的强引 用，因而每个实例都让对方一直存在，就是这种情况。这就是所谓的循环强引用。

class Person2 {
    let name: String
    init(name: String) {
        self.name = name
    }
    
    var apartment: Apartment?
    deinit {
        print("\(name) is being deinitialized")
    }
}


class Apartment {

    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    
    //注意：
    var tenant: Person2?
    deinit {
        print("\(unit) is being deinitialized")
    }
}

//3.3 这两个变量都被初始化为 nil
var john: Person2?
var unit4A: Apartment?

//3.4 创建特定的 Person 和 Apartment 实例并将赋值给 john 和 unit4A 变量
john = Person2(name: "张三")  //hohn -> Person2
unit4A = Apartment(unit: "4A")// unit4A ->  Apartment

//3.5 将这两个实例关联在一起
john?.apartment = unit4A
unit4A?.tenant = john

//3.6 断开引用
john = nil
unit4A = nil    // 没有任何一个析构函数被调用

//3.7 存在问题： 应用程序中造成了内存泄漏


print("---------------解决实例之间的循环强引用---------------")
//4.解决实例之间的循环强引用
//4.1 Swift 提供了两种办法用来解决你在使用类的属性时所遇到的循环强引用问题:                 弱引用(weak reference)和无 主引用(unowned reference)。

//4.2 弱引用和无主引用允许循环引用中的一个实例引用 而另外一个实例不保持强引用。这样实例能够互相引用而不产生循环强引用

//4.3 当其他的实例有更短的生命周期时，使用弱引用，也就是说，当其他实例析构在先时

//4.4 弱引用
    /*
 
        4.4.1 弱引用不会对其引用的实例保持强引用，因而不会阻止 ARC 销毁被引用的实例。这个特性阻止了引用变为循环强引用。
        4.4.2 声明属性或者变量时，在前面加上 weak 关键字表明这是一个弱引用。
        4.4.3 因为弱引用不会保持所引用的实例，即使引用存在，实例也有可能被销毁。因此，ARC 会在引用的实例被销毁后 自动将其赋值为 nil 。并且因为弱引用可以允许它们的值在运行时被赋值为 nil ，所以它们会被定义为可选类型 变量，而不是常量。
 
        注意：
            当 ARC 设置弱引用为 nil 时，属性观察不会被触发。
 
    */


class Person3 {
    let name: String
    init(name: String) {
        self.name = name
    }
    
    //注意：
    var apartment: Apartment2?
    deinit {
        print("\(name) is being deinitialized")
    }
}


class Apartment2 {
    
    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    
    //注意： weak
    weak var tenant: Person3?
    deinit {
        print("\(unit) is being deinitialized")
    }
}

var john3: Person3?
var unit4A2: Apartment2?

john3 = Person3(name: "lisi")
unit4A2 = Apartment2(unit: "4A")

john3!.apartment = unit4A2
unit4A2!.tenant = john3

john3 = nil
unit4A2 = nil   //都调用了deinit 证明了引用循环被打破了
/*
 注意： 
 如果：只 unit4A2 = nil 那么都不会销毁，因为Person3 -> unit4A2 还有一个强引用
 
 在使用垃圾收 的系统里，弱指针有时用来实现简单的缓冲机制，因为没有强引用的对象只会在内存压力触发垃 圾收 时才被销毁。但是在 ARC 中，一旦值的最后一个强引用被移除，就会被立即销毁，这导致弱引用并不适 合上面的用途
 */


print("-------------------实例无主引用-------------------")
//5. 无主引用
/*
    5.1 和弱引用类似，无主引用不会牢牢保持住引用的实例。和弱引用不同的是，无主引用在其他实例有相同或者更长 的生命周期时使用。你可以在声明属性或者变量时，在前面加上关键字 unowned 表示这是一个无主引用。
 
 */

