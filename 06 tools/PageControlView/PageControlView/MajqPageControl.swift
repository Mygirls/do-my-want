//
//  MajqPageControl.swift
//  PageControlView
//
//  Created by cfzq on 2017/7/11.
//  Copyright © 2017年 cfzq. All rights reserved.
//

import UIKit
///PageControlView的类型（仿系统的、自定义的）
enum MajqPageControlViewStyle {
    case normal, initSelf
}

///PageControlView 的位置
enum MajqPageControlViewAlignment  {
    case left, center, right
}

class MajqPageControl: UIControl {
    let spacingBetweenDots: CGFloat = 8
    var dotColor: UIColor = UIColor.orange
    fileprivate var dotViews: [UIView] = []
    fileprivate var currentDotView: MajqPageControlView?
    open var dotSize = CGSize(width: 2, height: 2)

    
    fileprivate var numberOfPages: Int = 0// default is 0
    
    fileprivate var currentPage: Int = 0 // default is 0. value pinned to 0..numberOfPages-1
    
    fileprivate var hidesForSinglePage: Bool = false // hide the the indicator if there is only one page. default is NO
    
    fileprivate var pageIndicatorTintColor: UIColor = UIColor.black
    
    fileprivate var currentPageIndicatorTintColor: UIColor = UIColor.red
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpInitConfigs()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpInitConfigs() {
        
    }

}

extension MajqPageControl {
   
    
    fileprivate func resetDotViews() {
        for dotView in dotViews {
            dotView.removeFromSuperview()
        }
        
        dotViews.removeAll()
        
        updateDots()
    
    }
    
    private func updateDots() {
    
        if numberOfPages == 0 {
            return
        }
        
        for i in 0 ..< numberOfPages {
            
            var dotView: UIView
            if i < dotViews.count {
                dotView = dotViews[i]
            } else {
                dotView = generateDotView()
            }
            
            //更新frame
            updateDotFrame(dotView: dotView, atIndex: i)
        }
        //当前的
        let dotView: MajqPageControlView = dotViews[0] as! MajqPageControlView
        currentDotView = dotView
        hideForSinglePage() //当只有一个点时候，判断是否隐藏
    }
    
    //创建dotView
    private func generateDotView() -> UIView {
        let dotView: MajqPageControlView = MajqPageControlView(frame: CGRect(x: 0, y: 0, width: dotSize.width, height: dotSize.height))
        dotView.settingDotColor(dotColor)
        
        self.addSubview(dotView)
        dotViews.append(dotView)
        
        return dotView
    }
    
    //更新每一个dotView 的frame
    private func updateDotFrame(dotView: UIView, atIndex index: NSInteger) {
        
        let temWidth: CGFloat = sizeForNumberOfPages(pageCount: numberOfPages).width
        
        let x: CGFloat = (dotSize.width + spacingBetweenDots) * CGFloat(index) + (( self.frame.size.width - temWidth) * 0.5)
        let y: CGFloat = (self.frame.size.height - dotSize.height) * 0.5
        dotView.frame = CGRect(x: x, y: y, width: dotSize.width, height: dotSize.height)
    }
    
    //设置pageControl size
    private func sizeForNumberOfPages(pageCount: NSInteger) -> CGSize {
        return CGSize(width: (dotSize.width + spacingBetweenDots) * CGFloat(pageCount) - spacingBetweenDots, height: dotSize.height)
    }
    
    private func hideForSinglePage() {
        if dotViews.count == 1 && hidesForSinglePage == true {
            self.isHidden = true
        } else {
            self.isHidden = false
        }
    }
}

//MARK: ***设置属性
extension MajqPageControl {
    
    func setPageControlNumberOfPages(_ numberOfPages: Int) {
        self.numberOfPages = numberOfPages
         resetDotViews()
    }
    
    func setPageControlCurrentPage(_ currentPage: Int) {
        
        if numberOfPages == 0 || currentPage == self.currentPage {
            self.currentPage = currentPage
            return
        }
        
      

        
        changeActivity(active: true, index: currentPage)
    }
    
    func setPageControlHidesForSinglePage(_ hidesForSinglePage: Bool) {
        self.hidesForSinglePage = hidesForSinglePage
        
    }
    
    func setPageControlPageIndicatorTintColor(_ pageIndicatorTintColor: UIColor) {
        self.pageIndicatorTintColor = pageIndicatorTintColor
    }
    
    func setPageControlCurrentPageIndicatorTintColor(_ currentPageIndicatorTintColor: UIColor) {
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor

    }
}

extension MajqPageControl {
    fileprivate func changeActivity(active: Bool,index: NSInteger) {
        
        //临时的
        guard let temCurrentDotView  = currentDotView else {
            return
        }
        
        temCurrentDotView.settingCurrentPageColor(pageIndicatorTintColor)

        //当前的
        let dotView: MajqPageControlView = dotViews[index] as! MajqPageControlView
        currentDotView = dotView
        
       
        dotView.settingCurrentPageColor(currentPageIndicatorTintColor)
    }
}


