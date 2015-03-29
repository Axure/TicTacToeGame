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
    func sideChanged(side : Side)
    func win(side : Side, point : (Int, Int), direction: Direction)
}



class GameModel : NSObject {
    
    
    let dimension : Int
    let threshold : Int
    

    
    var finished = false
    
    var side : Side {
        didSet {
            delegate.sideChanged(side)
        }
    }
    
    
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
        side = Side.Black
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
                default:
                    break
                }
            }
        }
        return buffer
    }
    
    
    func performMove(location : (Int, Int), side : Side) -> Bool {
        
        if !finished {
            let (x, y) = location
            switch gameboard[x, y] {
            case PieceObject.Empty:
                gameboard[x, y] = PieceObject.Piece(side)
                delegate.placeAPiece(location, side: side)
                self.side.alt()
                switch self.side {
                case Side.Black:
                    println("Black!")
                default:
                    println("White!")
                }
                println(sideHasWon(side))
                return true
            default:
                return false
            }
        }
        
        return false
        
        
    }
    
    // This is the very first, brutal and primitive version
    // Further versions should contain analysis of the situation
    // The model should be upgraded.
    
    // It's actually KMP isn't it..
    
    // Maybe we should invent a new data structure for this simple and specific problem
    // The points should record more things I think...
    // Maybe a new algorithm for updating and inserting..
    // Maybe we should put it off
    
    
    
    func win(side : Side, point : (Int, Int), direction: Direction) {
        delegate.win(side, point: point, direction: direction)
    }
    
    func sideHasWon(side : Side) -> (result: Bool, point: (Int, Int), direction: Direction) {
//        for i in 0..<dimension {
        // We need a scan algorithm...
        // We need ALGORITHM!
        
        var point : (Int ,Int)
        
        for i in 0..<dimension - threshold + 1 {
            
            for j in 0..<dimension - threshold + 1 {
                // ba jindu chaoqian gangan caishi weiyi zhengtu...
                // zhenglu, zhengdao!
                
                
            }
        }
        
//        var result : Bool
        
        let a = aPointHasWon(side, point: (0, 0), direction: Direction.Skew)
        if (a.result) {
            return a
        }
        
        let b = aPointHasWon(side, point: (dimension - 1, 0), direction: Direction.Subskew)
        if (b.result) {
            return b
        }
        
        
            
        for i in 0..<dimension {
            for j in 0..<dimension - threshold + 1 {
                
                let a = aPointHasWon(side, point: (i, j), direction: Direction.Horizontal)
                if (a.result) {
                    return a
                }
            }
        }
        
        for i in 0..<dimension - threshold + 1 {
            for j in 0..<dimension {
                
                let a = aPointHasWon(side, point: (i, j), direction: Direction.Vertical)
                if (a.result) {
                    return a
                }
            }
        }

        
        // Scan vertically
        
        
        
        return (false, (-1, -1), Direction.Skew)
    }
    
    func aPointHasWon(side: Side, point: (x: Int, y: Int), direction: Direction) -> (result: Bool, point: (Int, Int), direction: Direction) {
        
        var (x, y) = point
        var _result: Bool
        

        
        for i in 0..<threshold {
            
            switch(gameboard[x, y]) {
            case .Piece(Side.Black):
                if side != Side.Black {
                    return (false, (-1, -1), Direction.Skew)
                }
            case .Piece(Side.White):
                if side != Side.White {
                    return (false, (-1, -1), Direction.Skew)
                }
            default:
                return (false, (-1, -1), Direction.Skew)
            }
            
            switch(direction) {
            case Direction.Horizontal:
                y++
            case Direction.Vertical:
                x++
            case Direction.Skew:
                x++
                y++
            case Direction.Subskew:
                x--
                y++
            }
        }
        
        return (true, point, direction)

        
        
    }
    // How to highlight the pieces leading to victory?
    // It is more about knowledge and less about intelligence.
    // Diligence and will
    
    
    
    
    // A new function for winning
    
    // After a winner is detected, the gameboard is frozen and an action is fired
    // We need to display the animation for winner, for only once
    // After the board is frozen, any further moves will be banned.
    
    
    
    
}
