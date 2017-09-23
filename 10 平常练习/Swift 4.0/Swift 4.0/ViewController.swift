//
//  ViewController.swift
//  Swift 4.0
//
//  Created by JQ on 2017/9/20.
//  Copyright © 2017年 Majq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        let a =  UIScreen.main.bounds.size.height
        let b =  UIScreen.main.bounds.size.width

        print("a = \(a), b = \(b)")
        
        //a = 736.0, b = 414.0 8plus
        
        //a = 812.0, b = 375.0  iponeX

        //a = 667.0, b = 375.0 iphone8

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

