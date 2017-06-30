//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*
 Variable length unicodeVariable length unicode
 如今的unicode采用的是可变长度编码方案。而所谓的“可变长度”包含了两个意思：
    *“编码单位（code unit）”的长度是可变的
    * 构成同一个字符的“编码单位”组合也是可变的
 
 什么是code unit呢？简单来说，code unit和ASCI码的形式是非常类似的，它们是一个个具体的数值。不同的是，它可以由多种长度单位的数字构成：
 
 第一种是用多个连续的8-bit数字表示一个unicode，这就是我们熟知的UTF-8编码。这种编码方式可以很好的对ASCII编码实现兼容。例如，人民币符号¥的UTF-8编码是：C2 A5；
 
 第二种是用一个16-bit数字表示一个unicode，这种编码方式叫做UTF-16。例如，¥的UTF-16编码是：00A5；
 
 最后，当然就是UTF-32编码，¥的UTF-32编码是：000000A5，你应该不难理解它的含义
 
 当然，无论我们用什么编码来表示字符，和ASCII编码一样，每一个可变长unicode字符最终也会对应一个数字来表示它的编码值，这个值叫做code point。现如今，这个值的的范围是[0, 0x10FFFF]，而我们只用了还不到12%的空间。因此，还有大量的空间允许我们添加诸如emoji这样的符号。
 
 理解Surrogate pair
 
 看到这里，你可能会想，如果我们使用UTF-16编码，根本无法全部表示上面定义的code point啊。为了解决这个问题，unicode标准保留了UTF-16编码空间中的一些值，它们永远不会被定义成字符，而是和其它UTF-16的编码值组合在一起，表示一个unicode字符。
 */

//Unicode grapheme clusters
let cafe = "Caf\u{00e9}"

//为了表示这个字符é，除了使用它的unicode scalar外，我们可以用两个其它的unicode字符拼起来：

//英文字母e，它的unicode scalar是U0065，name是LATIN SMALL LETTER E；
//声调字符'，它的unicode scalar是U0301，name是COMBINING ACUTE ACCENT；
//let cafee01 = "\u{0065}"
//let cafee02 = "\u{0301}"

let cafee = "caf\u{0065}\u{0301}"

//Swift String

cafe.characters.count
cafee.characters.count

cafe.utf8.count
cafee.utf8.count

/*
 
 对于cafe来说，é的UTF-8编码是C3 A9，加上前面Caf的编码是43 61 66，因此cafe的UTF-8编码个数是5；
 
 对于cafee来说，声调字符'的UTF-8编码是CC 81，加上前面Cafe的UTF-8编码是43 61 66 65，因此是6个，它相当于Cafe'；
 
 */
cafe.utf16.count
cafee.utf16.count

cafe == cafee

let nsCafe =
    NSString(characters: [0x43, 0x61, 0x66, 0xe9], length: 4)
nsCafe.length
let nsCafee =
    NSString(characters: [0x43, 0x61, 0x66, 0x65, 0x0301], length: 5)
nsCafee.length

nsCafe == nsCafee


//==对NSString来说，并没有执行canonically equivalent的语义。为了在不同的NSString对象之间进行语义比较，我们只能这样：
let result = nsCafe.compare(nsCafee as String)
result == ComparisonResult.orderedSame

//除了这个视频里提到了用两个code unit组合来实现一个字符之外，我们还可以使用多个code unit组合成一个“字符”，例如：给é外围再套个圈：
let circleCafee = cafee + "\u{20dd}"
circleCafee.characters.count

"👰🏻".characters.count
"👨‍👩‍👦‍👦".characters.count
//一个亚洲姑娘的字符数是2，而一群小伙伴的字符个数是4。为什么会这样呢？其实它们和字符é构成的原理是类似的。都是通过多个code unit组合而成的字符。但是，它们的字符计算方式却和我们之前看到的不太一样。

//如果String是一个Collection类型...
//它通过extension遵从Collection protocol就好了：
extension String: Collection  {

}

var swift = "swift is fun"
swift.dropFirst(9)

let f = "👨‍👩‍👦‍👦"
f.dropFirst(1)
//这看上去不很好么？我们似乎更有理由相信，把String理解为一个Collection是没问题的。那么，为什么Swift 3中，String不是一个Collection呢？

//因为一旦如此，所有在Collection中定义的算法用在String对象的时候，我们都会默认它们是正确的。但实际上，我们很难同时做到算法的逻辑正确和unicode语义正确。尽管在上面的例子中，我们看到了String.Character类型已经尽可能在逻辑层面上忽略掉unicode的各种细节，但有些问题，仍旧难以处理，例如：

cafee.dropFirst(4)
//cafee.dropLast(1)   //runtime error !!!
//这就是把String作为一个集合类型带来的问题：面对unicode复杂的组合规则，我们很难保证所有的集合算法都是安全并且语义正确的。


let numbers = [11,12,13,14,15]
numbers.dropFirst(2)//返回一个包含所有给定初始数的子序列。
numbers.dropLast(1) //返回一个包含除指定的final数之外的所有子序列


//***********************
//还得让String用起来像一个集合...
/**
    尽管前面我们说了这么一大堆，但不可否认的一个事实就是，我们对字符串的操作仍旧和集合是非常类似的，因为字符串看上去就一个一连串单个字符的组合。所以，Swift的开发者还是决定让这个类型用起来像一个集合类型
 
 unicodeScalar：按照字符串中每一个字符的unicode scalar来形成集合；
 utf8：按照字符串中每一个字符的UTF-8编码来形成集合；
 utf16：按照字符串中每一个字符的UTF-16编码来形成集合；

 
 */

cafee.unicodeScalars.forEach { print($0) }
print("--------")
cafee.utf8.forEach { print($0) }
print("--------")

cafee.utf16.forEach { print($0) }

//cafee.characters
//characters ： 他是一个 String.CharacterView类型的属性 其实也就是一个结构体,String 类型也是一个结构体: 这个“view”是按照unicode grapheme clusters计算字符串的字符个数，也就是最接近我们肉眼看到的字符的view

//因此String.characters形式上就可以理解为“由我们看到的字符构成的字符数组”。一个最简单直接的例子就是我们之前用过的统计字符个数：
let cafee02 = "caf\u{0065}\u{0301}"
cafee02.characters.count // 4

//String.characters还提供了两个索引位置：
cafee02.characters.startIndex // 0
cafee02.characters.endIndex   // 5



