//
//  LineView.swift
//  test
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class LineView: UIView {

    let labelTitle = ["关注","文章","文集","图片","问题"]
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        context?.setLineWidth(0.5)
        
        for i in 1...4 {
            context?.move(to: CGPoint(x: (CGFloat)(i)*rect.width/5, y: 10))
            context?.addLine(to: CGPoint(x: (CGFloat)(i)*rect.width/5, y: rect.height-10))
        }
        
        context?.move(to: CGPoint(x: 0, y: 5))
        context?.addLine(to: CGPoint(x: rect.width, y: 5))
        
        context?.move(to: CGPoint(x: 0, y: rect.height - 5))
        context?.addLine(to: CGPoint(x: rect.width , y: rect.height - 5))
        
        context?.strokePath()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        for i in 0...4 {
            let label = UILabel(frame: CGRect(x: (CGFloat)(i)*frame.width/5, y: frame.height/3, width: frame.width/5, height: frame.height/3*2))
            label.text = labelTitle[i]
            label.font = UIFont.systemFont(ofSize: 13)
            label.textColor = UIColor.gray
            label.textAlignment = .center
            self.addSubview(label)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
