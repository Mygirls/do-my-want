//
//  ViewController.swift
//  swift 3.0
//
//  Created by JQ on 2017/8/29.
//  Copyright © 2017年 majq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//MARK: - 枚举
extension ViewController {

    enum CompassPoint {
        case north
        case south
        case east
        case west
    }
    
}

