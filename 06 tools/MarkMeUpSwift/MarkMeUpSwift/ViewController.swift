//
//  ViewController.swift
//  MarkMeUpSwift
//
//  Created by cfzq on 2017/6/27.
//  Copyright © 2017年 cfzq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /// 测试
    var test:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     - parameters:
      - paramA: The cubes available for allocation
      - paramB: The people that require cubes
     */

    func parametersExample(paramA: String, paramB: Int) -> Bool {
        return true
    }

    /**
     Another description
     
     - important: Make sure you read this
     - returns: a Llama spotter rating between 0 and 1 as a Float
     - parameter totalLlamas: The number of Llamas spotted on the trip
     
     More description
     */

    func totalLlamasSpoted(totalLlamas: Int) -> Int {
        return 0
    }
    
    //Single Line Elements
    
    //显示一行格式为标题的文本。
    //语法：
    //使用数字符号（＃）来指定最多三个标题级别。 数字符号和标题字符串之间至少有一个空格。
    //或者，使用下划线字符串创建第1级和第2级标题。
    
    /**
     An example of using a number sign (`#`) for a *heading*
     # This is a Heading 1
     
     ## This is a Heading 2
     
     ### This is a Heading 3
     
     
     
     */
    func headingExample() {
    
    }
    
    /**
     An example of using a character underline for a *heading*
     
     This is a Heading 1
     ===================
     
     This is a Heading 2
     -------------------
     
    
     */
    func headingExample2() {
        
    }
    
    //Link Elements
    /**
    链接元素定义链接名和链接目标。
     链接名称在开口方括号（[）和闭合方括号（[）之间输入。
     资产链接以感叹号开头（！）开方括号前。
     链接元素的目标规范通常在一个开括号（（）和结束圆括号（））之间。
     链接参考分隔符用冒号（：）其次是不是括号中指定的目标。
     
     optional link type character + [link name] + (link target  + link target options)
            第一部分                    第二部分        第三部分             第四部分
    
     链接元素遵循以下规则：
        链接元素可以出现在一行的任何位置。
        分隔符和所有的内容都是在一行由换行符终止。
     
     */
    
}

extension ViewController {

    /** A Simple Bulleted List
     
     * item 1
     * item 2
     
     */
    func testFunc ()  {
        
    }
    
    /**
     
     * A bullet item
     
     With two paragraphs
     
     * The next bullet item
     
     */
    func paragraphExample() {
        
    }
    
    /**  Nesting Delimiters嵌套的分隔符
     
     1. Level 1, Item 1
        1. Level 2, Item 1
     
            func emptyFunc() {
            }
        - - -
        1. Level 2, Item 2
     1. Level 1, Item 2
     
     */
    func testNesting()  {
        
    }
    
    /// This markup renders as one *line
    /// of text*
    func testFunc02() {
        
    }
}




