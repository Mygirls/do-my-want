//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


class control: UIViewController
{
    
    
}


 let a  = control()
let classStr = NSStringFromClass(type(of:a))
print(classStr)

 let c = a.self

 let d = class_getName(type(of: a))
    print(d)
//let classStr = NSStringFromClass(type(of: a))

let b = object_getClassName(a)


print(classStr)
print("deinit: \(object_getClassName(a))")




