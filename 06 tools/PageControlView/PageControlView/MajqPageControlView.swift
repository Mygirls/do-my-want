//
//  MajqPageControlView.swift
//  PageControlView
//
//  Created by cfzq on 2017/7/11.
//  Copyright © 2017年 cfzq. All rights reserved.
//
/**
 
 
 open var numberOfPages: Int // default is 0
 
 open var currentPage: Int // default is 0. value pinned to 0..numberOfPages-1
 
 
 open var hidesForSinglePage: Bool // hide the the indicator if there is only one page. default is NO
 
 
 open var defersCurrentPageDisplay: Bool // if set, clicking to a new page won't update the currently displayed page until -updateCurrentPageDisplay is called. default is NO
 
 open func updateCurrentPageDisplay() // update page display to match the currentPage. ignored if defersCurrentPageDisplay is NO. setting the page value directly will update immediately
 
 
 open func size(forNumberOfPages pageCount: Int) -> CGSize // returns minimum size required to display dots for given page count. can be used to size control if page count could change
 
 
 @available(iOS 6.0, *)
 open var pageIndicatorTintColor: UIColor?
 
 @available(iOS 6.0, *)
 open var currentPageIndicatorTintColor: UIColor?

 
 
 */
import UIKit


class MajqPageControlView: UIView {

    var dotColor: UIColor?
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
        dotColor = UIColor.white
        backgroundColor = UIColor.clear
        layer.cornerRadius = self.frame.width / 2;
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
    }
    
    func animateToActiveState() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: -20, options: .curveLinear, animations: {
            
            self.backgroundColor = UIColor.red 
            self.transform = CGAffineTransform(scaleX: 1.4, y: 1.4);
            
        }, completion: nil)
    
    }
}

extension MajqPageControlView {
    func settingDotColor(_ color: UIColor)  {
        dotColor = color
        self.layer.borderColor = color.cgColor
    }
    
    func settingCurrentPageColor(_ color: UIColor) {
        dotColor = color
        self.layer.borderColor = color.cgColor

    }
}












