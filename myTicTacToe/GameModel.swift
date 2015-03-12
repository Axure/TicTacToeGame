//
//  GameModel.swift
//  myTicTacToe
//
//  Created by 郑虎 on 15 年 3. 11..
//  Copyright (c) 2015年 郑虎. All rights reserved.
//

import UIKit


protocol GameModelProtocol : class {
    
    func placeAPiece(location : (Int, Int), side : Side)
}



class GameModel : NSObject {
    
    
    let dimension : Int
    let threshold : Int
    let side : Side
    
    
    var gameboard : SquareGameboard<PieceObject>
    
    let delegate : GameModelProtocol
    
    var queue : [PlaceCommand]
    var timer : NSTimer
    
    let maxCommands = 5
    let queueDelay = 0.1
    
    init(dimension d: Int, threshold t: Int, delegate: GameModelProtocol) {
        
        dimension = d
        threshold = t
        side = Side.Black
        
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
    
    func queueMove(side : Side, location : (Int, Int), completion : (Bool) -> ()) {
        if queue.count > maxCommands {
            return
        }
        
        let command = PlaceCommand(s : side, l : location ,c : completion)
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
            changed = performMove(command.location, side: command.side)
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
    
    func placeAPiece(location : (Int, Int), side : Side) {
        let (x, y) = location
        switch gameboard[x, y] {
        case .Empty:
            gameboard[x, y] = PieceObject.Piece(side)
            delegate.placeAPiece(location, side : side)
        default:
            break
            
        }
    }
    
    func insertTileAtRandomLocation(value: Int) {
        let openSpots = gameboardEmptySpots()
        if openSpots.count == 0 {
            // No more open spots; don't even bother
            return
        }
        // Randomly select an open spot, and put a new tile there
        let idx = Int(arc4random_uniform(UInt32(openSpots.count-1)))
        let (x, y) = openSpots[idx]
        placeAPiece((x, y), side: side)
    }
    
    func gameboardEmptySpots() -> [(Int, Int)] {
        var buffer = Array<(Int, Int)>()
        for i in 0..<dimension {
            for j in 0..<dimension {
                switch gameboard[i, j] {
                case .Empty:
                    buffer += [(i, j)]
                case .Tile:
                    break
                }
            }
        }
        return buffer
    }
    
    
    func performMove(location : (Int, Int), side : Side) -> Bool {
        
        
        
        return false
    }
    
    func sideHasWon(side : Side) -> Bool {
//        for i in 0..<dimension {
        
        return false
    }
    
    
    
    
}
