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
        case Side.White:
            return UIColor(red: 238.0/255.0, green: 228.0/255.0, blue: 218.0/255.0, alpha: 1.0)
        case Side.Black:
            return UIColor(red: 238.0/255.0, green: 228.0/255.0, blue: 218.0/255.0, alpha: 1.0)
        default:
            return UIColor.whiteColor()
        }
        
    }
}
