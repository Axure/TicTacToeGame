//
//  AppearanceProvider.swift
//  myTicTacToe
//
//  Created by 郑虎 on 15 年 3. 11..
//  Copyright (c) 2015年 郑虎. All rights reserved.
//

import UIKit

protocol AppearanceProviderProtocol : class {
    func pieceColor(side : Side) -> UIColor
    
}


class AppearanceProvider: AppearanceProviderProtocol {
    
    func pieceColor(side: Side) -> UIColor {
        
        switch side {
        case Side.Black:
            println("Chose color Black!")
            return UIColor(red: 38.0/255.0, green: 28.0/255.0, blue: 18.0/255.0, alpha: 1.0)
        case Side.White:
            println("Chose color White!")
            return UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1.0)
        default:
            
            println("Chose color exception!")
            return UIColor.whiteColor()
        }
        
    }
}
