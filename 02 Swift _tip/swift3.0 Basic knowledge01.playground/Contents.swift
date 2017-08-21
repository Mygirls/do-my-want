//: Playground - noun: a place where people can play

import UIKit

var str = "swift 3.0"

var s1: String = "Hello"
let s2: String = "World"

//1.Keyword 'self' cannot be used as an identifier here: 可以使用 (``) 如果你需要使用与Swift保留关键字相同的名称作为常量或者变量名，你可以使用反引号(`)将关键字包围的方 式将其作为名字使用。无论如何，你应当避免使用关键字作为常量或变量名，除非你别无选择。
//let self: String = "world"
let `self`: String = "world"

//2.Swift 字符串插值:把常量名或者变量名当做占位符加入到长字符串中，Swift 会用当前常量或变量的值替换这些占位符。将常量或变量名放入圆括号中，并在开括号前使用反斜杠将其转义
let s3: String = s1 + s2
let s4: String = "Hello + \(s2)"


//3.分号：有一种情况下必须要用分号，即你打算在同一行内写多条独立的语句:
let s5: String = s1 + s2 ; print(s5)


//4.整数:Swift 提供了8，16，32和64位的有符号和无符号整数类型
let minValue = UInt8.min    //0
let maxValue = UInt8.max    //255
let minValue_int8 = Int8.min    //-128
let maxValue_int8 = Int8.max    //127

//5.类型别名type aliases
typealias AudioSample = UInt16
var maxAudioSample = AudioSample.max

//6.元组 tuples
let http404Errol = (404,"Not Found")
let (statusCode,statusMeg) = http404Errol
statusCode
statusMeg

http404Errol.0
http404Errol.1

let http200Status = (statusCode: 200,description: "info")
http200Status.statusCode
http200Status.description


//7.断言 assertion：来结束代码运行并通过调试来找到值缺失的原因
//当代码使用优化编译的时候，断言将会被禁用，例如在 Xcode 中，使用默认的 target Release 配置选项来 bu ild 时，断言会被禁用
let age = 3
assert(age > 0, "A person's age cannot be less than zero")

//8.三目运算符
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)   //注意空格

//9.空合运算符:空合运算符( a ?? b )将对可选类型 a 进行空判断，如果 a 包含一个值就进行解封，否则就返回一个默认值 b 。表达式 a 必须是 Optional 类型。默认值 b 的类型必须要和 a 存储值的类型保持一致(其实是对： a != nil ? a! : b  的简化)

let defaultColorName = "red"
var userDefinedColorName: String?
var colorNameToUse = userDefinedColorName ?? defaultColorName //??注意空格： 如果没有?? 前后没有空格时候，会报错

userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName


//10.字符串
var emptyString = ""
var anotherEmptyString = String()

if emptyString.isEmpty {
    print(" 空字符串")
}

if anotherEmptyString.isEmpty {
    print(" 空字符串")
}

//11.字符串是 值类型
var s6 = "123"
var s7 = "456"
s7 = "789"

print(s6)
print(s7)

for c in "dog !".characters {
    print(c)
}







