//
//  GameModel.swift
//  myTicTacToe
//
//  Created by 郑虎 on 15 年 3. 11..
//  Copyright (c) 2015年 郑虎. All rights reserved.
//

import UIKit


protocol GameModelProtocal : class {
    
    func placeAPiece(location : (Int, Int), value : Int)
    
}



class GameModel : NSObject {
    
    
    let dimension : Int
    let threshold : Int
    
    
    var gameboard : SquareGameboard<PieceObject>
    
    let delegate : GameModelProtocal
    
    var queue : [MoveCommand]
    var timer : NSTimer
    
    let maxCommands = 5
    let queueDelay = 0.1
    
    init(dimension d: Int, threshold t: Int, delegate: GameModelProtocol) {
        
        dimension = d
        threshold = t
        
        self.delegate = delegate
        
        queue = [PlaceCommand]()
        timer = NSTimer()
        
        gameboard = SquareGameboard(dimension: d, initialValue: .Empty)
        
        super.init()
    }
    
    func reset() {
        gameboard.setAll(.Empty)
        queue.removeAll(keepCapacity: true)
        timer.invalidate()
    }
    
    func queueMove(location : (Int, Int), completion : (Bool) -> ()) {
        if queue.count > maxCommands {
            return
        }
        
        let command = PlaceCommand(s : side, c : completion)
        queue.append(command)
        
        if (!timer.valid) {
            timerFired(timer)
        }
    }
    
    
    
    func timerFired(timer: NSTimer) {
        if queue.count == 0 {
            return
        }
        // Go through the queue until a valid command is run or the queue is empty
        var changed = false
        while queue.count > 0 {
            let command = queue[0]
            queue.removeAtIndex(0)
            changed = performMove(command.direction)
            command.completion(changed)
            if changed {
                // If the command doesn't change anything, we immediately run the next one
                break
            }
        }
        if changed {
            self.timer = NSTimer.scheduledTimerWithTimeInterval(queueDelay,
                target: self,
                selector:
                Selector("timerFired:"),
                userInfo: nil,
                repeats: false)
        }
    }
    
    func insertPiece(location : (Int, Int), side : Side) {
        let (x, y) = location
        switch gameboard[x, y] {
        case .Empty:
            gameboard[x, y] = PieceObject.Piece(side)
            delegate.insertPiece(location, side: side)
        default:
            break
            
        }
    }
    
    func sideHasWon(Side side) {
//        for i in 0..<dimension {
        
        return false
    }
    
    
    
    
}
