//
//  AViewController.swift
//  TransitionAnimationDemo
//
//  Created by roni on 2017/6/26.
//  Copyright © 2017年 wqrr. All rights reserved.
//

import UIKit

class AViewController: UIViewController {
    
    var animations: [HeroDefaultAnimationType] = [
        .push(direction: .left),
        .pull(direction: .left),
        .slide(direction: .left),
        .zoomSlide(direction: .left),
        .cover(direction: .up),
        .uncover(direction: .up),
        .pageIn(direction: .left),
        .pageOut(direction: .left),
        .fade,
        .zoom,
        .zoomOut,
        .none
    ]

    
    lazy var customTransitionDelegate: InteractivityTransitionDelegate = InteractivityTransitionDelegate()
    lazy var interactiveTransitionRecognizer: UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(interactiveTransitionRecognizerAction(sender:)))

    
    lazy var btn: UIButton = {
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 100, y: 200, width: 100, height: 40)
        btn.setTitle("跳转到 B", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(skipAction), for: .touchUpInside)
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "A VC"
        
        view.backgroundColor = UIColor.red
        
        view.addSubview(btn)
        
        interactiveTransitionRecognizer.edges = .right
        view.addGestureRecognizer(interactiveTransitionRecognizer)
        
        self.navigationController?.delegate = self
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: - event response


extension AViewController {
    
    func skipAction(sender: AnyObject) {
        
        let bVC = BViewController()
     //   bVC.transitioningDelegate = self
        self.navigationController?.pushViewController(bVC, animated: true)
        
//        if sender.isKind(of: UIGestureRecognizer.self) {
//            customTransitionDelegate.gestureRecognizer = interactiveTransitionRecognizer
//            customTransitionDelegate.targetEdge = .right
//        }else{
//            customTransitionDelegate.gestureRecognizer = nil
//        }
//        
//        let cVC = CViewController()
//        cVC.modalPresentationStyle = .fullScreen
//        cVC.transitioningDelegate = customTransitionDelegate
//        self.present(cVC, animated: true) { 
//            //
//        }
        
    }
    
    func interactiveTransitionRecognizerAction(sender: UIScreenEdgePanGestureRecognizer){
        if sender.state == .began {
            
            self.skipAction(sender: sender)
        }
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension AViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HalfWaySpringAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CrossDissolveAnimator()
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension AViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return HalfWaySpringAnimator()
        }
        
        if operation == .pop {
            
            return CrossDissolveAnimator()
        }
        
        return nil
    }
}
