//
//  ViewController.swift
//  Draw
//
//  Created by fangyukui on 2018/5/30.
//  Copyright © 2018年 fangyukui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let containerView = ContainerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height))
        containerView.backgroundColor = .blue
        view = containerView
        
        let redView = RedView(frame: CGRect(x: 0, y: 0, width: 375, height: 150))

        view.addSubview(redView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("ViewController:" + #function)
    }
    
    
    


}

