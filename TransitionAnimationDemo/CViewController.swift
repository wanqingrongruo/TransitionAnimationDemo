//
//  CViewController.swift
//  TransitionAnimationDemo
//
//  Created by roni on 2017/6/26.
//  Copyright © 2017年 wqrr. All rights reserved.
//

import UIKit

class CViewController: UIViewController {
    
    lazy var interactiveTransitionRecognizer: UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(interactiveTransitionRecognizerAction(sender:)))
    
    lazy var btn: UIButton = {
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 100, y: 200, width: 100, height: 40)
        btn.setTitle("跳转到 A", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(skipAction), for: .touchUpInside)
        
        return btn
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "C VC"
        
        view.backgroundColor = UIColor.yellow

        view.addSubview(btn)
        
        interactiveTransitionRecognizer.edges = .left
        view.addGestureRecognizer(interactiveTransitionRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

// MARK: - event response

extension CViewController {
    
    func skipAction(sender: AnyObject) {
        
//        self.dismiss(animated: true) {
//            //
//        }
        if let transitionDelegate = self.transitioningDelegate as? InteractivityTransitionDelegate{
            
            if sender.isKind(of: UIGestureRecognizer.self) {
                transitionDelegate.gestureRecognizer = interactiveTransitionRecognizer 
               
            }else{
                transitionDelegate.gestureRecognizer = nil
            }
            
             transitionDelegate.targetEdge = .left
            
        }
     
        self.dismiss(animated: true) { 
            //
        }
    }
    
    func interactiveTransitionRecognizerAction(sender: UIScreenEdgePanGestureRecognizer){
        if sender.state == .began {
            
            self.skipAction(sender: sender)
        }
    }
}
