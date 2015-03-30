//
//  PieceView.swift
//  myTicTacToe
//
//  Created by 郑虎 on 15 年 3. 11..
//  Copyright (c) 2015年 郑虎. All rights reserved.
//

import UIKit


//class PieceView : UIView {
//    
//    
//    
//    var delegate : AppearanceProviderProtocol
//    var side: Side = Side.Black {
//        didSet {
//            backgroundColor = delegate.pieceColor(side)
//        }
//        // Understanding and applying such kind of codes
//    }
//    
//    required init(coder: NSCoder) {
//        fatalError("NSCoding not supported")
//    }
//    
//    init (position : CGPoint, width : CGFloat, side : Side, radius : CGFloat, delegate d : AppearanceProviderProtocol) {
//        
//        delegate = d;
//        
//        switch(side) {
//        case Side.Black:
//            super.init(frame: CGRectMake(position.x, position.y, width, width));
//            
//        case Side.White:
////            super.init(frame: CGRectMake(position.x + width/4, position.y + width/4, width/2, width/2));
//            super.init(frame: CircleView(CGRectMake(position.x + width/4, position.y + width/4, width/2, width/2), color: UIColor.clearColor()))
//            
//        }
//        
//        // Maybe we need to write a class for the circle inherited from a rectangle and override the CGRectMake method?
//        
//        
//        self.side = side
//        backgroundColor = delegate.pieceColor(side)
//        println(backgroundColor)
//        
//    }
//    
//}

class PieceView : CrossView {
    
    // How to inherit from two different classes and choose the respective ones to run? In other words, how to merge to classes with an option to switch?
    
    var delegate : AppearanceProviderProtocol
    var side: Side = Side.Black {
        didSet {
//            backgroundColor = delegate.pieceColor(side)
            self.color = delegate.pieceColor(side)
            // This should be problematic and pointless...
        }
        // Understanding and applying such kind of codes
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init (position : CGPoint, width : CGFloat, side : Side, radius : CGFloat, delegate d : AppearanceProviderProtocol) {
        
        delegate = d;
        
        super.init(frame: CGRectMake(position.x, position.y, width, width), color: delegate.pieceColor(side))
        
        // Maybe we need to write a class for the circle inherited from a rectangle and override the CGRectMake method?
        
        
        self.side = side
//        backgroundColor = delegate.pieceColor(side)
        println(backgroundColor)
        
    }
    
}

class CircleView : UIView {
    
    var color : UIColor
    
    init(frame: CGRect, color: UIColor) {
        self.color = color
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override func drawRect(rect: CGRect) {
        let lineWidth : CGFloat = 5.0
        var context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, lineWidth);
        color.set()
        CGContextAddArc(context, (frame.size.width)/2 - lineWidth/2, frame.size.height/2 - lineWidth/2, (frame.size.width - 10)/2 - lineWidth, 0.0, CGFloat(M_PI * 2.0), 1)
        // Dig deeper into the layout design!
        CGContextStrokePath(context)
    }
    
}

class CrossView : UIView {
    
    var color : UIColor
    
    init(frame: CGRect, color: UIColor) {
        self.color = color
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override func drawRect(rect: CGRect) {
        let lineWidth : CGFloat = 5.0
        var context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, lineWidth);
        color.set()
        
        var startPoint, endPoint : CGPoint
        startPoint = CGPointMake(0.0 + lineWidth, 0.0 + lineWidth)
        endPoint = CGPointMake(frame.size.width - lineWidth, frame.size.height - lineWidth)
        CGContextAddLines(context, [startPoint, endPoint], 2)
        
        startPoint = CGPointMake(0.0 + lineWidth, frame.size.height - lineWidth)
        endPoint = CGPointMake(frame.size.width - lineWidth, 0 + lineWidth)
        CGContextAddLines(context, [startPoint, endPoint], 2)
        
        // Dig deeper into the layout design!
        CGContextStrokePath(context)
        CGContextFillPath(context);
    }
    
    
}