//
//  PieceView.swift
//  myTicTacToe
//
//  Created by 郑虎 on 15 年 3. 11..
//  Copyright (c) 2015年 郑虎. All rights reserved.
//

import UIKit


class PieceView : UIView {
    
    
    
    var delegate : AppearanceProviderProtocol
    var side: Side = Side.Black {
        didSet {
            backgroundColor = delegate.pieceColor(side)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init (position : CGPoint, width : CGFloat, side : Side, radius : CGFloat, delegate d : AppearanceProviderProtocol) {
        
        delegate = d;
        
        super.init(frame: CGRectMake(position.x, position.y, width, width));
        
        self.side = side
        backgroundColor = delegate.pieceColor(side)
        
        
    }
    
}