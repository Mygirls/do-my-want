//
//  SecondViewController.swift
//  Block_delagete
//
//  Created by cfzq on 2017/6/22.
//  Copyright © 2017年 cfzq. All rights reserved.
//

import UIKit

//MARK: *** 1.1>定义 protocol
protocol TestDelegate: NSObjectProtocol {
    
    //传一个date 参数： 测试传值耗时 方便比较block
    func majqOptionTestDelegate(_ date: Date)
    
    func majqTestRequestDelegate(_ date: Date)
    
}

extension TestDelegate {
    func majqOptionTestDelegate(_ date: Date) {
        print("默认可以实现")
    }
}

@objc  protocol TestOptionalDelegate  {
    @objc optional func majqTestOptionalDelegate(_ date: Date)
}

//MARK: *** 1.2>定义 block
typealias TestBlock  = (Date) -> Void
typealias TestClosure  = () -> ()

//MARK: *** 1.3>测试 block 循环引用问题
class TestBlockCircularReference {
    let name: String
//    lazy var printName:() -> () = { [weak  self ] in
//        if let strongSelf = self {
//            print("the name is \(strongSelf.name)")
//            
//        }
//        
//    }
    init(personName: String) {
        name = personName
    }
    
    func testMethod() {
        print("测试循环引用")
    }
    deinit {
        print("对象销毁了，没有引用")
    }
    
    func testBlock(block: @escaping (String) -> Void)  {
        block("测试")
    }
}


//MARK: *** 2.SecondViewController

class SecondViewController: UIViewController {
    var blockBtn: UIButton = UIButton(type: .custom)
    var delegateBtn: UIButton = UIButton(type: .custom)
    var optionalDelegateBtn: UIButton = UIButton(type: .custom)

    weak var delegate:TestDelegate?
    weak var optonalDelegate:TestOptionalDelegate?

    var testBlock: TestBlock?
    var testClosure: TestClosure?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        // Do any additional setup after loading the view.
        initConfig() 
    }

    private func initConfig() {
        setUpBlockBtn()
        setUpDelegateBtn()
        setUpOptionalDelegateBtn()
    }
    
    deinit {
        print("控制器销毁了")

    }
    
}

//MARK: *** 3.SecondViewController 测试block

extension SecondViewController {
    fileprivate func setUpBlockBtn() {
        blockBtn.frame = CGRect(x: 50, y: 50, width: 200, height: 50)
        blockBtn.setTitle("secondVC_blockBtn", for: .normal)
        blockBtn.addTarget(self , action: #selector(blockBtnAction(_:)), for: .touchUpInside)
        blockBtn.backgroundColor = UIColor.orange
        self.view.addSubview(blockBtn)
        
        configBlock()   //测试block
    }
    
    func blockBtnAction(_ btn: UIButton) {
        
        guard let block = testBlock else {
            return
        }
        let date = Date()
        block(date)
        
        
        testBlockMothod { (v) in
            print("v = \(v)")   //调用方法testBlockMothod(block: @escaping TestBlock )，当方法里面的闭包有传递 闭包的时候，会输出这里面的闭包的值
        }
        //testBlockMothod(block: block) // 传递闭包
        self.dismiss(animated: true, completion: nil)
    }
    
    
    fileprivate func configBlock() {
        testBlock01()
        testBlock02()
        declarationdefinitionClosure()
        testBlock03()
    }
    
    private func testBlockMothod(block: @escaping TestBlock ) {
        print("测试-----")
        let date = Date()
        block(date)
    }
    
    private func testBlock01 () {
        let array: [String] = ["1","2","3"]
        //将 block 简单分类，有三种情形
        //临时性的，只用在栈当中，不会存储起来。比如数组的 foreach 遍历，这个遍历用到的 block 是临时的，不会存储起来
        array.forEach { (value) in
            print(value)
        }
    
        //需要存储起来，但只会调用一次，或者有一个完成时期:比如一个 UIView 的动画，动画完成之后，需要使用 block 通知外面，一旦调用 block 之后，这个 block 就可以删掉。
        UIView.animate(withDuration: 1) { 
            
        }
        
        UIView.animate(withDuration: 1, animations: { 
            
        }) { (valueBool) in

        }
        
        //需要存储起来，可能会调用多次。比如按钮的点击事件，假如采用 block 实现，这种 block 就需要长期存储，并且会调用多次。调用之后，block 也不可以删除，可能还有下一次按钮的点击
        
        /*
         *** 对于临时性的，只在栈中使用的 block, 没有循环引用问题，block 会自动释放。
         *** 而只调用一次的 block，需要看内部的实现，正确的实现应该是 block 调用之后，马上赋值为空，这样 block 也会释放，同样不会循环引用。
         *** 而多次调用时，block 需要长期存储，就很容易出现循环引用问题。Cocoa 中的 API 设计也是这样的，临时性的，只会调用一次的，采用 block。而多次调用的，并不会使用 block。比如按钮事件，就使用 target-action。有些库将按钮事件从 target-action 封装成 block 接口, 反而容易出问题。
 
         */
    }
    
    private func testBlock02() {
        //当 此方法执行结束 后，会调用testMethod 中的deinit
        let testObj: TestBlockCircularReference = TestBlockCircularReference(personName: "666")
        testObj.testMethod()
        testObj.testBlock { (value) in
            self.testBlock01()
            print("value = \(value)")
        }

    }
    
    private func testBlock03() {
        guard let closure = testClosure else { return  }
        closure()
    }
    
    private func declarationdefinitionClosure() {
        self.testClosure = { [weak self] in
            self?.testBlock01()
            print("闭包调用了")
        }
        
        //循环引用就是当self 拥有一个block的时候，在block 又调用self的方法。形成你中有我，我中有你，谁都无法将谁释放的困局。
//        self.testClosure = {
//            self.testBlock01()
//            print("闭包调用了")
//        }
    }
    
    
}



//MARK: *** 4.SecondViewController 测试delegate
extension SecondViewController {
    fileprivate func setUpDelegateBtn() {
        delegateBtn.frame = CGRect(x: 50, y: 150, width: 200, height: 50)
        delegateBtn.setTitle("secondVC_delegateBtn", for: .normal)
        delegateBtn.addTarget(self , action: #selector(delegateBtnAction(btn:)), for: .touchUpInside)
        delegateBtn.backgroundColor = UIColor.orange
        self.view.addSubview(delegateBtn)
    }
    
    func delegateBtnAction(btn: UIButton) {
        guard let myDelegate = delegate else {
            return
        }
        
        let date = Date()        
        myDelegate.majqTestRequestDelegate(date)
        myDelegate.majqOptionTestDelegate(date)
        self.dismiss(animated: true, completion: nil)

    }
    
}

//MARK: *** 5.SecondViewController 测试 可选delegate
extension SecondViewController {
    fileprivate func setUpOptionalDelegateBtn() {
        optionalDelegateBtn.frame = CGRect(x: 50, y: 250, width: 200, height: 50)
        optionalDelegateBtn.setTitle("secondVC_optionaDelegateBtn", for: .normal)
        optionalDelegateBtn.addTarget(self , action: #selector(optionalDelegateBtnAction(btn:)), for: .touchUpInside)
        optionalDelegateBtn.backgroundColor = UIColor.orange
        self.view.addSubview(optionalDelegateBtn)
    }
    
    func optionalDelegateBtnAction(btn: UIButton) {
        guard let myDelegate = optonalDelegate else {
            return
        }
        let date = Date()
        myDelegate.majqTestOptionalDelegate?(date)

        self.dismiss(animated: true, completion: nil)
    }
    

}
