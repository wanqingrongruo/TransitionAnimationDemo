//
//  InteractivityTransitionAnimator.swift
//  TransitionAnimationDemo
//
//  Created by roni on 2017/6/26.
//  Copyright © 2017年 wqrr. All rights reserved.
//

import UIKit

class InteractivityTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let targetEdge: UIRectEdge

    init(targetEdge: UIRectEdge) {
        self.targetEdge = targetEdge
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
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
        
        // 用来判断当前是 present 还是 dismiss
        let isPresenting = (toViewController?.presentingViewController == fromViewController)
        let fromFrame = transitionContext.initialFrame(for: fromViewController!)
        let toFrame = transitionContext.finalFrame(for: toViewController!)
        
        var offset: CGVector = CGVector(dx: 0, dy: 0) // 用于计算 toView 的位置
        switch self.targetEdge {
        case UIRectEdge.top:
            offset = CGVector(dx: 0, dy: 1)
        case UIRectEdge.bottom:
            offset = CGVector(dx: 0, dy: -1)
        case UIRectEdge.left:
            offset = CGVector(dx: 1, dy: 0)
        case UIRectEdge.right:
            offset = CGVector(dx: -1, dy: 0)
        default:
            break
        }
        
        // 根据当前是 present 还是 dismiss,横屏还是竖屏, 计算好 toView 的初始位置已经结束位置
        if isPresenting {
            fromView?.frame = fromFrame
            toView?.frame = toFrame.offsetBy(dx: toFrame.size.width * offset.dx * -1, dy: toFrame.size.height * offset.dy * -1)
            containerView.addSubview(toView!)
        }else{
            
            fromView?.frame = fromFrame
            toView?.frame = toFrame
            containerView.insertSubview(toView!, belowSubview: fromView!)
        }
        
               
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { 
            if isPresenting {
                toView?.frame = toFrame
            }else{
                fromView?.frame = fromFrame.offsetBy(dx: fromFrame.size.width * offset.dx, dy: fromFrame.size.height * offset.dy)
            }
        }) { (finished) in
            let wasCanceled = transitionContext.transitionWasCancelled
            if wasCanceled {toView?.removeFromSuperview()}
            transitionContext.completeTransition(!wasCanceled) // 动画结束后一定要调用completeTransition方法

        }
    }
}
