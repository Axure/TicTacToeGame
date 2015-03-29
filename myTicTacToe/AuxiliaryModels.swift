//
//  AuxiliaryModels.swift
//  myTicTacToe
//
//  Created by 郑虎 on 15 年 3. 11..
//  Copyright (c) 2015年 郑虎. All rights reserved.
//

import Foundation

enum Side {
    case White
    case Black
    
    mutating func alt() {
        switch self {
        case White:
            self = Black
        case Black:
            self = White
        default:
            break
        }
    }
    
    func inverse() ->Side {
        switch self {
        case White:
            return Black
        case Black:
            return White
        default:
            break
        }
    }
}

enum Direction {
    case Vertical
    case Horizontal
    case Skew
    case Subskew
}

enum PieceObject {
    case Empty
    case Piece(Side)
}


struct PlaceCommand {
    var side : Side
    var location : (Int, Int)
    var completion : (Bool) -> ()
    
    init(s: Side, l: (Int, Int) ,c: (Bool) -> ()) {
        side = s
        location = l
        completion = c
    }
}



struct SquareGameboard<T> {
    let dimension : Int
    var boardArray : [T]
    
    
    
    init (dimension d : Int, initialValue : T) {
        dimension = d;
        boardArray = [T](count : d * d, repeatedValue : initialValue)
        
    }
    
    
    subscript(row: Int, col: Int) -> T {
        get {
            assert(row >= 0 && row < dimension)
            assert(col >= 0 && col < dimension)
            return boardArray[row*dimension + col]
        }
        set {
            assert(row >= 0 && row < dimension)
            assert(col >= 0 && col < dimension)
            boardArray[row*dimension + col] = newValue
        }
    }
    
    mutating func setAll(item: T) {
        for i in 0..<dimension {
            for j in 0..<dimension {
                self[i, j] = item
            }
        }
    }
    
}