//
//  TransitionInteractionController.swift
//  TransitionAnimationDemo
//
//  Created by roni on 2017/6/26.
//  Copyright © 2017年 wqrr. All rights reserved.
//

import UIKit

class TransitionInteractionController: UIPercentDrivenInteractiveTransition {

    var transitionContext: UIViewControllerContextTransitioning? = nil
    var gestureRecognizer: UIScreenEdgePanGestureRecognizer
    var edge: UIRectEdge
    
    init(gestureRecognizer: UIScreenEdgePanGestureRecognizer, edgeForDragging edge: UIRectEdge){
        
        assert(edge == .top || edge == .bottom || edge == .left || edge == .right,
               "edgeForDragging must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.")
        
        self.gestureRecognizer = gestureRecognizer
        self.edge = edge
        
        super.init()
        
        self.gestureRecognizer.addTarget(self, action: #selector(gestureRecognizeDidUpdate(gestureRecognizner:)))
        
    }
    
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        super.startInteractiveTransition(transitionContext)
    }
    
    
    // 滑动手势触发
    func gestureRecognizeDidUpdate(gestureRecognizner: UIScreenEdgePanGestureRecognizer){
        
        switch gestureRecognizer.state {
        case .began:
            break
        case .changed:
            self.update(self.percentForGesture(gesture: gestureRecognizner)) // 手势滑动更新百分比
            break
        case .ended:
            if self.percentForGesture(gesture: gestureRecognizner) >= 0.5{ // 滑动结束, 判断
                self.finish()
            }else{
                self.cancel()
            }
        default:
            self.cancel()
            break
        }
    }
    
    func percentForGesture(gesture: UIScreenEdgePanGestureRecognizer) -> CGFloat {
        
        let transitionContainerView = transitionContext?.containerView
        let locationInsourceView = gesture.location(in: transitionContainerView)
        
        let width = transitionContainerView?.bounds.width
        let height = transitionContainerView?.bounds.height
        
        switch self.edge {
        case UIRectEdge.right:
            return (width! - locationInsourceView.x)/width!
        case UIRectEdge.left:
            return locationInsourceView.x/width!
        case UIRectEdge.bottom:
            return (height! - locationInsourceView.y) / height!
        case UIRectEdge.top:
            return locationInsourceView.y / height!
            
        default:
            return 0
        }
    }
    
}
