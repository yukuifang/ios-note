//
//  YellowView.swift
//  Draw
//
//  Created by fangyukui on 2018/5/30.
//  Copyright © 2018年 fangyukui. All rights reserved.
//

import UIKit

class YellowView: UIView {

    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        UIColor.yellow.setFill()
        UIRectFill(rect)
        print("yellow:" + #function)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("yellow:" + #function)
        
    }

}
