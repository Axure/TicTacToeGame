//
//  GameboardView.swift
//  myTicTacToe
//
//  Created by 郑虎 on 15 年 3. 11..
//  Copyright (c) 2015年 郑虎. All rights reserved.
//

import UIKit

class GameboardView : UIView {
    
    
    
    var dimension : Int
    var pieceWidth : CGFloat
    var piecePadding : CGFloat
    var cornerRadius : CGFloat
    
    
    
    
    var pieces : Dictionary<NSIndexPath, PieceView>
    
    let provider = AppearanceProvider()
    
    let tilePopStartScale: CGFloat = 0.1
    let tilePopMaxScale: CGFloat = 1.1
    let tilePopDelay: NSTimeInterval = 0.05
    let tileExpandTime: NSTimeInterval = 0.18
    let tileContractTime: NSTimeInterval = 0.08
    
    let tileMergeStartScale: CGFloat = 1.0
    let tileMergeExpandTime: NSTimeInterval = 0.08
    let tileMergeContractTime: NSTimeInterval = 0.08
    
    let perSquareSlideDuration: NSTimeInterval = 0.08
    
    init(dimension d: Int, pieceWidth width: CGFloat, piecePadding padding: CGFloat, cornerRadius radius: CGFloat, backgroundColor: UIColor, foregroundColor: UIColor) {
        assert(d > 0)
        dimension = d
        pieceWidth = width
        piecePadding = padding
        cornerRadius = radius
        pieces = Dictionary()
        let sideLength = padding + CGFloat(dimension)*(width + padding)
        super.init(frame: CGRectMake(0, 0, sideLength, sideLength))
        layer.cornerRadius = radius
        setupBackground(backgroundColor: backgroundColor, tileColor: foregroundColor)
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    func setupBackground(backgroundColor bgColor: UIColor, tileColor: UIColor) {
        backgroundColor = bgColor
        var xCursor = piecePadding
        var yCursor: CGFloat
        let bgRadius = (cornerRadius >= 2) ? cornerRadius - 2 : 0
        for i in 0..<dimension {
            yCursor = piecePadding
            for j in 0..<dimension {
                
                
                let background = UIView(frame: CGRectMake(xCursor, yCursor, pieceWidth, pieceWidth))
                background.layer.cornerRadius = bgRadius
                background.backgroundColor = tileColor
                addSubview(background)
                yCursor += piecePadding + pieceWidth
            }
            xCursor += piecePadding + pieceWidth
        }
    }
    
    
    func abstractLocation(tapLocation : CGPoint) -> (x : Int, y : Int, isValid : Bool) {
        var x, y : Int
        x = -1
        y = -1
        var isValidX = false
        var isValidY = false
        
        var xCursor = piecePadding
        var yCursor = piecePadding
        
        for i in 0..<dimension {
            
            if (tapLocation.x > xCursor - piecePadding) && (tapLocation.x < xCursor) {
                return (-1, -1, false)
            }
            if (tapLocation.x >= xCursor) && (tapLocation.x <= xCursor + pieceWidth) {
                x = i
                isValidX = true
                break
            }
            xCursor += piecePadding + pieceWidth
        }
        
        for j in 0..<dimension {
            if (tapLocation.y > yCursor - piecePadding) && (tapLocation.y < yCursor) {
                return (-1, -1, false)
            }
            if (tapLocation.y >= yCursor) && (tapLocation.y <= yCursor + pieceWidth) {
                y = j
                isValidY = true
                break
            }
            yCursor += piecePadding + pieceWidth
        }
        return (y, x, isValidX && isValidY)
    }
    
    func positionIsValid(pos: (Int, Int)) -> Bool {
        let (x, y) = pos
        return (x >= 0 && x < dimension && y >= 0 && y < dimension)
    }
    
    
    func reset() {
        for (key, piece) in pieces {
            piece.removeFromSuperview()
        }
        pieces.removeAll(keepCapacity: true)
    }
    
    func placeAPiece(location: (Int, Int), side: Side) {
        
        let (row, col) = location
        let x = piecePadding + CGFloat(col)*(pieceWidth + piecePadding)
        let y = piecePadding + CGFloat(row)*(pieceWidth + piecePadding)
        let r = (cornerRadius >= 2) ? cornerRadius - 2 : 0
        let piece = PieceView(position: CGPointMake(x, y), width: pieceWidth, side: side, radius: r, delegate: provider)
        piece.layer.setAffineTransform(CGAffineTransformMakeScale(tilePopStartScale, tilePopStartScale))
        
        addSubview(piece)
        bringSubviewToFront(piece)
        pieces[NSIndexPath(forRow: row, inSection: col)] = piece
        
        // Add to board
        UIView.animateWithDuration(tileExpandTime, delay: tilePopDelay, options: UIViewAnimationOptions.TransitionNone,
            animations: { () -> Void in
                // Make the tile 'pop'
                piece.layer.setAffineTransform(CGAffineTransformMakeScale(self.tilePopMaxScale, self.tilePopMaxScale))
            },
            completion: { (finished: Bool) -> Void in
                // Shrink the tile after it 'pops'
                UIView.animateWithDuration(self.tileContractTime, animations: { () -> Void in
                    piece.layer.setAffineTransform(CGAffineTransformIdentity)
                })
        })
    }
        
    
    
    
}



// Insert a tile


// This is only the view part...