//
//  StatusView.swift
//  myTicTacToe
//
//  Created by 郑虎 on 15 年 3. 14..
//  Copyright (c) 2015年 郑虎. All rights reserved.
//

import UIKit

protocol StatusViewProtocol {
    func sideChanged(newSide s: Side)
}

class StatusView : UIView, StatusViewProtocol {
    
    var side : Side = Side.Black {
        didSet {
            switch side {
            case Side.Black:
                label.text = "Next: Black Side"
            default:
                label.text = "Next: White Side"
            }
            
            
            self.piece.side = side
        }
    }
    
    let provider = AppearanceProvider()
    
    let defaultFrame = CGRectMake(0, 0, 140, 40)
    var label: UILabel
    var piece: PieceView
    
    init(backgroundColor bgcolor: UIColor, textColor tcolor: UIColor, font: UIFont, radius r: CGFloat) {
        
        
        self.piece = PieceView(position: CGPointMake(0, 0), width: 200, side: side, radius: 25, delegate: provider)
        self.piece.layer.setAffineTransform(CGAffineTransformMakeScale(0.1, 0.1))
        
        label = UILabel(frame: defaultFrame)
        label.textAlignment = NSTextAlignment.Center
        super.init(frame: defaultFrame)
        backgroundColor = bgcolor
        label.textColor = tcolor
        label.font = font
        layer.cornerRadius = r
        self.addSubview(label)
        self.addSubview(piece)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    func sideChanged(newSide s: Side)  {
        self.side = s
    }
    
}
