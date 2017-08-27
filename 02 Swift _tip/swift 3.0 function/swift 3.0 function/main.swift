//
//  main.swift
//  swift 3.0 function
//
//  Created by JQ on 2017/8/25.
//  Copyright © 2017年 majq. All rights reserved.
//

class FunctionTest {
    
    func greet(person: String) -> String {
        let greeting = "Hello," + person + "!"
        return greeting
    }
    
    //无参数函数
    func sayHelloWorld() -> String {
        return "hello world"
    }
    
    //多参数函数
    func greet(person: String,alreadyGreeted: Bool) -> String {
        if alreadyGreeted {
            return "已经打过招呼了"
        } else {
            return greet(person: person)
        }
    }
    
    //无返回值函数:严格上来说，虽然没有返回值被定义，greet(person:) 函数依然返回了值。没有定义返回类型的函数会返回一 个特殊的 Void 值。它其实是一个空的元组(tuple)，没有任何元素，可以写成()。 官方定义： public typealias Void = ()
    func greet(person: String)  {
        
    }
    
    //
    
    
}


import Foundation

print("Hello, World!")
let f = FunctionTest()

let s1 = f.greet(person: "Jon")
print(s1)







