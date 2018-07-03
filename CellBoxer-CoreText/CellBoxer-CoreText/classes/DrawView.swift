//
//  DrawView.swift
//  CellBoxer-CoreText
//
//  Created by fangyukui on 2018/7/3.
//  Copyright © 2018年 fangyukui. All rights reserved.
//

import UIKit
import CoreText
import CoreGraphics

class DrawView: UIView {

    override func draw(_ rect: CGRect) {
        //得到当前绘制画布的上下文，用于将后续内容绘制在画布上
        let context = UIGraphicsGetCurrentContext()
        
        //将坐标系上下翻转。对于底层的绘制引擎来说，屏幕的左下角是坐标原点（0，0），而对于上层的UIKit来说，屏幕的左上角是坐标原点，为了之后的坐标系按UIKit来做，在这里做了坐标系的上下翻转，这样底层和上层的（0，0）坐标就是重合的了
        context?.textMatrix = CGAffineTransform.identity
        context?.translateBy(x: 0, y: self.bounds.height)
        context?.scaleBy(x: 1, y: -1)
        
        //创建绘制的区域,这里将UIView的bounds作为绘制区域
        let path = CGMutablePath()
        path.addRect(self.bounds, transform: CGAffineTransform.identity)
        
        //设置字体
        let attString = NSMutableAttributedString(string: "海洋生物学家在太平洋里发现了一条与众不同的鲸。一般蓝鲸的“歌唱”频率在十五到二十五赫兹，长须鲸子啊二十赫兹左右，而它的频率在五十二赫兹左右。")
        
        attString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 0, length: 5))
        attString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 13), range: NSRange(location: 6, length: 2))
        attString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 38), range: NSRange(location: 8, length: attString.length-8))
        
        //设置文字颜色
        attString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length:11))
        attString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSRange(location: 11, length:attString.length-11))
        
        var imageName = "read"
        
        var callbacks = CTRunDelegateCallbacks(version: kCTRunDelegateVersion1, dealloc:{
            (refCon) -> Void in
            NSLog("RunDelegate dealloc")
        } , getAscent: {
            ( refCon) -> CGFloat in
            let imageName = "read"
//            refCon.initializeMemory(as: <#T##T.Type#>, to: <#T##T#>)
            
            let image = UIImage(named: imageName)
            return image!.size.height
        }, getDescent: {
            (refCon) -> CGFloat in
            return 0
        }, getWidth: {
            (refCon) -> CGFloat in
            let imageName = String("read")
            let image = UIImage(named: imageName)
            return image!.size.width
        })
        
        //设置CTRun的代理
        let runDelegate = CTRunDelegateCreate(&callbacks, &imageName)
        
        //空格用于给图片留位置
        let imageAttributedString = NSMutableAttributedString(string: " ");
        
        imageAttributedString.addAttribute(kCTRunDelegateAttributeName as NSAttributedStringKey, value: runDelegate!, range: NSRange(location: 0, length: 1))
        
       //添加属性，在CTRun中可以识别出这个字符是图片
      imageAttributedString.addAttribute(NSAttributedStringKey(rawValue: "imageName"), value: imageName, range: NSMakeRange(0, 1))
        
        attString.insert(imageAttributedString, at: 1)
        
        //根据AttributedString生成CTFramesetterRef
        let framesetter = CTFramesetterCreateWithAttributedString(attString)
        let ctFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attString.length),path, nil)
        
        //绘制除图片以外的部分
        CTFrameDraw(ctFrame, context!)
        
        
        //处理绘制图片逻辑
        
        //存取frame中的ctlines
        let lines = CTFrameGetLines(ctFrame) as NSArray
        
        // Use NSArray to bridge to Array
        let nsLinesArray: NSArray = CTFrameGetLines(ctFrame)
        let ctLinesArray = nsLinesArray as Array
        
        var originsArray = [CGPoint](repeating: CGPoint.zero, count:ctLinesArray.count)
        
        CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0),&originsArray)
        
        //把ctFrame里每一行的初始坐标写到数组里
        CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), &originsArray);
        
        // 7.3遍历CTRun找出图片所在的CTRun并进行绘制,每一行可能有多个
        for i in 0..<lines.count{
            //遍历每一行CTLine
            let line = lines[i]
            var lineAscent = CGFloat()
            var lineDescent = CGFloat()
            var lineLeading = CGFloat()
            CTLineGetTypographicBounds(line as! CTLine, &lineAscent, &lineDescent, &lineLeading)
            let runs = CTLineGetGlyphRuns(line as! CTLine) as NSArray
            for j in 0..<runs.count{
                // 遍历每一个CTRun
                var  runAscent = CGFloat()
                var  runDescent = CGFloat()
                let  lineOrigin = originsArray[i]// 获取该行的初始坐标
        
                let run = runs[j] // 获取当前的CTRun
                let attributes = CTRunGetAttributes(run as! CTRun) as NSDictionary
                let width =  CGFloat( CTRunGetTypographicBounds(run as! CTRun, CFRangeMake(0,0), &runAscent, &runDescent, nil))
                //                runRect.size.width = CGFloat( CTRunGetTypographicBounds(run as! CTRun, CFRangeMake(0,0), &runAscent, &runDescent, nil))
                // 这一段可参考Nimbus的NIAttributedLabel
                
                let  runRect  = CGRect(x: lineOrigin.x + CTLineGetOffsetForStringIndex(line as! CTLine, CTRunGetStringRange(run as! CTRun).location, nil), y: lineOrigin.y - runDescent, width: width, height: runAscent + runDescent)
                let  imageNames = attributes.object(forKey: "imageName")
                
                if imageNames is NSString {
                    let image = UIImage(named: imageName as String)
                    let  imageDrawRect = CGRect(x:runRect.origin.x,y: lineOrigin.y, width:(image?.size.width)!, height:(image?.size.height)!)
                    print(imageDrawRect)
                    context?.draw((image?.cgImage)!, in: imageDrawRect)
                    
        
                }
        
            }
        
        }
        
        
        
        
        
        
        
        
        
        
        
        
        

        
        
        
        
        
        
        
     
        
       
       
        

 
        
        
        
    }

}
