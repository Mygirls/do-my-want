//
//  ViewController.swift
//  Block_delagete
//
//  Created by cfzq on 2017/6/22.
//  Copyright © 2017年 cfzq. All rights reserved.
//


/**
 block、delegate、NSNotification 使用区别
 https://www.zhihu.com/question/29023547
 
 
 */
import UIKit

class ViewController: UIViewController {

    var blockBtn: UIButton = UIButton(type: .custom)
    var delegateBtn: UIButton = UIButton(type: .custom)
    var optionalDelegateBtn: UIButton = UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initConfig()
    }

    private func initConfig() {
        setUpBlockBtn()
        setUpDelegateBtn()
        setUpOptionalDelegateBtn()
    }
    
}

extension ViewController {
    fileprivate func setUpBlockBtn() {
        blockBtn.frame = CGRect(x: 50, y: 50, width: 200, height: 50)
        blockBtn.setTitle("blockBtn", for: .normal)
        blockBtn.backgroundColor = UIColor.orange
        blockBtn.addTarget(self , action: #selector(blockBtnAction(_:)), for: .touchUpInside)
        self.view.addSubview(blockBtn)
    }
    
    func blockBtnAction(_ btn: UIButton) {
        let secondVC = SecondViewController()
        secondVC.testBlock = { (date) in
            print("测试TestBlock 通过")
            print(-date.timeIntervalSinceNow)
        }
        
        self.present(secondVC, animated: true, completion: nil)
    }


}


extension ViewController: TestDelegate{
    fileprivate func setUpDelegateBtn() {
        delegateBtn.frame = CGRect(x: 50, y: 150, width: 200, height: 50)
        delegateBtn.setTitle("delegateBtn", for: .normal)
        delegateBtn.addTarget(self , action: #selector(delegateBtnAction(btn:)), for: .touchUpInside)
        delegateBtn.backgroundColor = UIColor.orange
        self.view.addSubview(delegateBtn)
    }
    
    func delegateBtnAction(btn: UIButton) {
        let secondVC = SecondViewController()
        secondVC.delegate = self
        self.present(secondVC, animated: true, completion: nil)
    }
    
    //此TestDelegate协议 必须实现，否则编译抱错
    func majqTestRequestDelegate(_ date: Date) {
        print("测试TestDelegate 协议（必须实现的）通过")
        print(-date.timeIntervalSinceNow)

    }
    
    //此TestDelegate协议 在TestDelegate的extension中实现了，此时可以不实现也不会抱错，相对于 可选协议
    func majqOptionTestDelegate(_ date: Date) {
        print("测试TestDelegate 协议（可选的实现的）通过")
        print(-date.timeIntervalSinceNow)


    }

}

extension ViewController: TestOptionalDelegate {

    fileprivate func setUpOptionalDelegateBtn() {
        optionalDelegateBtn.frame = CGRect(x: 50, y: 250, width: 200, height: 50)
        optionalDelegateBtn.setTitle("secondVC_optionaDelegateBtn", for: .normal)
        optionalDelegateBtn.addTarget(self , action: #selector(optionalDelegateBtnAction(btn:)), for: .touchUpInside)
        optionalDelegateBtn.backgroundColor = UIColor.orange
        self.view.addSubview(optionalDelegateBtn)
    }
    
    func optionalDelegateBtnAction(btn: UIButton) {
        let secondVC = SecondViewController()
        secondVC.optonalDelegate = self
        self.present(secondVC, animated: true, completion: nil)
    }
    
    //可选协议： 不实现编译也不会抱错
    @objc func majqTestOptionalDelegate(_ date: Date) {
        print("测试TestOptionalDelegate 协议（可选实现的）通过")
        print(Date())

    }


}

class TestClass: TestOptionalDelegate {
    
}

//编译不会通过，TestOptionalDelegate 协议用 @obj option 修饰，只能被class实现，上面TestClass 就会编译通过
//struct TestStruct: TestOptionalDelegate {
//    
//}



