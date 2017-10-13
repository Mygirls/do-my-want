//
//  ViewController.swift
//  Codable01
//
//  Created by JQ on 2017/10/9.
//  Copyright © 2017年 Majq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpConfig()
    }

    
    private func setUpConfig() {
        
        let jsonDic = ["name":"beer", "brewery":"100","abv":10.0,"style":"ipa"] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted)
        let decode = JSONDecoder()
        do {
            let beer = try decode.decode(Beer.self, from: jsonData)
            print("解析成功:\(beer)")
            print("\(beer.name) 、\(beer.brewery)、\(beer.abv)、\(beer.style)")
        } catch  {
            print("解析失败:\(error)")
        }

        
    }

}

enum BeerStyle: String, Codable {
    case ipa
    case stout
    case kolsch
}

class Wine: Codable {
    var abv: Float?
}

class Beer: Wine {
    var name: String?
    var brewery: String?
    var style: BeerStyle?
}
