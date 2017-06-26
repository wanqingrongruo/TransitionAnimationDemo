//
//  BViewController.swift
//  TransitionAnimationDemo
//
//  Created by roni on 2017/6/26.
//  Copyright © 2017年 wqrr. All rights reserved.
//

import UIKit

class BViewController: UIViewController {
    
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
        
        title = "B VC"
        
        view.backgroundColor = UIColor.blue
        
        view.addSubview(btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

// MARK: - event response


extension BViewController {
    
    func skipAction() {
        
        if let nav = self.navigationController, nav.viewControllers.first != self {
            nav.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: { 
                //
            })
        }
    }
}
