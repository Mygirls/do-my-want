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
      
       
        let p = Person(fullyName: "jack")
        print(p.fullyName)
        
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

protocol FullyName {
    var fullyName: String {get}
}

protocol Run {
    var run: String {set get}
    
}

struct Person: FullyName {
    var fullyName: String
    
    
    
}


