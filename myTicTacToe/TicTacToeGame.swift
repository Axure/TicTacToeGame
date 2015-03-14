//
//  TicTacToeGame.swift
//  myTicTacToe
//
//  Created by 郑虎 on 15 年 3. 11..
//  Copyright (c) 2015年 郑虎. All rights reserved.
//

import UIKit


// This is the main part of the game


class TicTacToeGameViewController : UIViewController, GameModelProtocol {
    
    
    
    var dimension : Int
    var threshold : Int
    
    
    var board : GameboardView?
    var model : GameModel?
    
    let boardWidth : CGFloat = 250.0
    
    let thinPadding: CGFloat = 3.0
    let thickPadding: CGFloat = 6.0
    
    let viewPadding: CGFloat = 10.0
    
    
    let verticalViewOffset: CGFloat = 0.0
    
    init(dimension d: Int, threshold t: Int) {
        
        dimension = d;
        threshold = t;
        
        super.init(nibName: nil, bundle: nil)
        
        model = GameModel(dimension: dimension, threshold: threshold, delegate: self)
        
        view.backgroundColor = UIColor.whiteColor()
        setupTapControls()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGame()
    }
    
    func setupTapControls() {
        
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("tap:"))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    
    func setupGame() {
        let vcHeight = view.bounds.size.height
        let vcWidth = view.bounds.size.width
        
        // This nested function provides the x-position for a component view
        func xPositionToCenterView(v: UIView) -> CGFloat {
            let viewWidth = v.bounds.size.width
            let tentativeX = 0.5*(vcWidth - viewWidth)
            return tentativeX >= 0 ? tentativeX : 0
        }
        // This nested function provides the y-position for a component view
        func yPositionForViewAtPosition(order: Int, views: [UIView]) -> CGFloat {
            assert(views.count > 0)
            assert(order >= 0 && order < views.count)
            let viewHeight = views[order].bounds.size.height
            let totalHeight = CGFloat(views.count - 1)*viewPadding + views.map({ $0.bounds.size.height }).reduce(verticalViewOffset, { $0 + $1 })
            let viewsTop = 0.5*(vcHeight - totalHeight) >= 0 ? 0.5*(vcHeight - totalHeight) : 0
            
            // Not sure how to slice an array yet
            var acc: CGFloat = 0
            for i in 0..<order {
                acc += viewPadding + views[i].bounds.size.height
            }
            return viewsTop + acc
        }
        
        
        
        // Create the gameboard
        let padding: CGFloat = dimension > 5 ? thinPadding : thickPadding
        let v1 = boardWidth - padding*(CGFloat(dimension + 1))
        let width: CGFloat = CGFloat(floorf(CFloat(v1)))/CGFloat(dimension)
        let gameboard = GameboardView(dimension: dimension,
            pieceWidth: width,
            piecePadding: padding,
            cornerRadius: 6,
            backgroundColor: UIColor.blackColor(),
            foregroundColor: UIColor.darkGrayColor())
        
        // Set up the frames
        let views = [gameboard]
        
        var f = gameboard.frame
        f.origin.x = xPositionToCenterView(gameboard)
        f.origin.y = yPositionForViewAtPosition(0, views)
        gameboard.frame = f
        
        
        // Add to game state
        view.addSubview(gameboard)
        board = gameboard
        
        
        assert(model != nil)
        let m = model!
        
    }
    
    @objc(tap:)
    func tapCommand(r: UIGestureRecognizer!) {
        let location = r.locationInView(board)
        println(location.x, location.y)
        println(board?.abstractLocation(location))
        let aLocation = board?.abstractLocation(location)
        if (aLocation!.isValid) {
            placeAPiece((aLocation!.x, aLocation!.y), side: Side.White)
        }
        println("Up!")
    }
    

    
    func placeAPiece(location: (Int, Int), side: Side) {
        assert(board != nil)
        let b = board!
        b.placeAPiece(location, side : side)
    }
    
}