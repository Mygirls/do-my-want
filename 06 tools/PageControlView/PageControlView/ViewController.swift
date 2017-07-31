//
//  ViewController.swift
//  PageControlView
//
//  Created by cfzq on 2017/7/11.
//  Copyright © 2017年 cfzq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let control: MajqPageControl = MajqPageControl(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
    var index: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        control.setPageControlNumberOfPages(5)
        control.setPageControlCurrentPage(2)

        control.backgroundColor = UIColor.green
        self.view.addSubview(control)
        
        
        var btn: UIButton = UIButton(frame: CGRect(x: 200, y: 200, width: 10, height: 10))
        self.view.addSubview(btn)
        btn.backgroundColor = UIColor.gray  
        btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
    }

    func btnAction(_ btn: UIButton) {
        if index <= 5 {
            if index == 5 {
                index = 0
            }
            index = index + 1
        }
        control.setPageControlCurrentPage(index)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

