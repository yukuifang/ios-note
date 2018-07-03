//
//  ViewController.swift
//  CellBoxer-CoreText
//
//  Created by fangyukui on 2018/7/3.
//  Copyright © 2018年 fangyukui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let drawView = DrawView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        drawView.backgroundColor = UIColor.white
        view.addSubview(drawView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

