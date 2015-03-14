//
//  StatusView.swift
//  myTicTacToe
//
//  Created by 郑虎 on 15 年 3. 14..
//  Copyright (c) 2015年 郑虎. All rights reserved.
//

import UIKit

class StatusView : UIView {
    
    var side : Side = Side.Black {
        didSet {
            label.text = "\(side) Side"
        }
    }
    
    let provider = AppearanceProvider()
    
    let defaultFrame = CGRectMake(0, 0, 140, 40)
    var label: UILabel
    var piece: PieceView
    
    init(backgroundColor bgcolor: UIColor, textColor tcolor: UIColor, font: UIFont, radius r: CGFloat) {
        var pieceWidth : CGFloat
        var piecePadding : CGFloat
        var cornerRadius : CGFloat
        pieceWidth = 30
        piecePadding = 3
        cornerRadius = 3
        let (row, col) = (1, 1)
        let x = piecePadding + CGFloat(col)*(pieceWidth + piecePadding)
        let y = piecePadding + CGFloat(row)*(pieceWidth + piecePadding)
        let tilePopStartScale: CGFloat = 0.1
        let r = (cornerRadius >= 2) ? cornerRadius - 2 : 0
        self.piece = PieceView(position: CGPointMake(x, y), width: pieceWidth, side: side, radius: r, delegate: provider)
        self.piece.layer.setAffineTransform(CGAffineTransformMakeScale(tilePopStartScale, tilePopStartScale))
        
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
        side = s
        self.piece.side = s
    }
    
}
