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
}

enum PieceObject {
    case Empty
    case Piece(Side)
}


struct PlaceCommand {
    var side : Side
    var completion : (Bool) -> ()
    
    init(s: Side, c: (Bool) -> ()) {
        side = s
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