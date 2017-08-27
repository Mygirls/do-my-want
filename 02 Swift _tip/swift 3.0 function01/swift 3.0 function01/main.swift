//
//  main.swift
//  swift 3.0 function01
//
//  Created by JQ on 2017/8/27.
//  Copyright © 2017年 majq. All rights reserved.
//

import Foundation

print("Hello, World!")



func greet(_ person: String) -> String {
    let greeting = "Hello," + person + "!"
    return greeting
}

//无参数函数
func sayHelloWorld() -> String {
    return "hello world"
}

//多参数函数
func greet(_ person: String,alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return "已经打过招呼了"
    } else {
        return ""
    }
}

//无返回值函数:严格上来说，虽然没有返回值被定义，greet(person:) 函数依然返回了值。没有定义返回类型的函数会返回一 个特殊的 Void 值。它其实是一个空的元组(tuple)，没有任何元素，可以写成()。 官方定义： public typealias Void = ()
func greet(_ person: String)  {
    
}

//多重返回值函数：用元组(tuple)类型让多个值作为一个复合值从函数中返回
func minMax(_ array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        } }
    return (currentMin, currentMax)
}
