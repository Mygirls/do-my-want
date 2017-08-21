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









