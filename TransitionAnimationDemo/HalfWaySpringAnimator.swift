//
//  HalfWaySpringAnimator.swift
//  TransitionAnimationDemo
//
//  Created by roni on 2017/6/26.
//  Copyright © 2017年 wqrr. All rights reserved.
//

import UIKit

class HalfWaySpringAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    /// 动画时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    /// 设置动画的进行方式
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toViewController = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView
        
        var fromView = fromViewController?.view
        var toView = toViewController?.view
        
        // iOS8引入, 尽可能使用这个方法而不是直接访问 controller 的 view 属性
        if transitionContext.responds(to: #selector(UIViewControllerTransitionCoordinatorContext.view(forKey:))) {
            fromView = transitionContext.view(forKey: .from)
            toView = transitionContext.view(forKey: .to)
        }
        
       // 我们让toview的origin.y在屏幕的一半处，这样它从屏幕的中间位置弹起而不是从屏幕底部弹起，弹起过程中逐渐变为不透明
        toView?.frame = CGRect(x: fromView!.frame.origin.x, y: fromView!.frame.maxY/2, width: fromView!.frame.width, height: fromView!.frame.height)
        toView?.alpha = 0.0
        
        // present 和 dismiss时, 必须将 toView 添加到视图层次中
        containerView.addSubview(toView!)
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: transitionDuration, delay: 0, options: .curveLinear, animations: { 
            toView!.alpha = 1.0 // 逐渐变为不透明
            toView?.frame = transitionContext.finalFrame(for: toViewController!) // 移动到指定位置
            
        }) { (finished) in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled) // 动画结束后一定要调用completeTransition方法
        }
    }
}
