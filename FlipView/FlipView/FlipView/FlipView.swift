//
//  FlipView.swift
//  FlipView
//
//  Created by 潘东 on 16/7/28.
//  Copyright © 2016年 潘东. All rights reserved.
//

import UIKit

class FlipView: UIView {

    var displayingPrimary = true
    var spinTimeInterval = 1.0
    // 此处可以将primaryView和secondaryView改写为需要的view子类，比如UILabel
    var primaryView = UIImageView()
    var secondaryView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setPrimaryView()
        setSecondaryView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPrimaryView() {
        self.addSubview(primaryView)
        primaryView.translatesAutoresizingMaskIntoConstraints = false
        
        // 使用autoLayout进行布局
        let constraint1 = NSLayoutConstraint(item: primaryView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        let constraint2 = NSLayoutConstraint(item: primaryView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0)
        let constraint3 = NSLayoutConstraint(item: primaryView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0)
        let constraint4 = NSLayoutConstraint(item: primaryView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        let array = [constraint1, constraint2, constraint3, constraint4]
        self.addConstraints(array)
        // 直接使用snapkit进行布局
//        primaryView.snp_makeConstraints { (make) in
//            make.edges.equalTo(self)
//        }
    }
    
    func setSecondaryView() {
        self.addSubview(secondaryView)
        secondaryView.translatesAutoresizingMaskIntoConstraints = false
        // 使用autoLayout进行布局
        let constraint1 = NSLayoutConstraint(item: secondaryView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        let constraint2 = NSLayoutConstraint(item: secondaryView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0)
        let constraint3 = NSLayoutConstraint(item: secondaryView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0)
        let constraint4 = NSLayoutConstraint(item: secondaryView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        let array = [constraint1, constraint2, constraint3, constraint4]
        self.addConstraints(array)
        
        // 直接使用snapkit进行布局
//        secondaryView.snp_makeConstraints { (make) in
//            make.edges.equalTo(self)
//        }
        self.sendSubviewToBack(secondaryView)
        secondaryView.hidden = true
    }
    
    func flip() {
        if (displayingPrimary == true) {
            secondaryView.hidden = false
        } else {
            secondaryView.hidden = true
        }
        
        // 使用UIView的 transitionFromView(fromView: UIView, toView: UIView, duration: NSTimeInterval, options: UIViewAnimationOptions, completion: ((Bool) -> Void)?)
        // 来设置动画效果，这里需要注意的是options这里，需要设置为ShowHideTransitionViews，这主要是因为这个方法会操作视图层级，并添加新的目的地视图，如果使用AutoLayout，动画结束后，视图就没有约束了，所以会显示错误
        UIView.transitionFromView(displayingPrimary ? primaryView : secondaryView,
                                  toView: displayingPrimary ? secondaryView : primaryView,
                                  duration: spinTimeInterval,
                                  options: [.TransitionFlipFromLeft, .ShowHideTransitionViews]) { (finish) in
                                    if finish {
                                        self.displayingPrimary = !self.displayingPrimary
                                        if self.displayingPrimary {
                                            self.secondaryView.hidden = true
                                        } else {
                                            self.secondaryView.hidden = false
                                        }
                                    }
        }
    }

}
