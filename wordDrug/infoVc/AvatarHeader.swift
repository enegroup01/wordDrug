//
//  AvatarHeader.swift
//  wordDrug
//
//  Created by Ethan on 2019/3/4.
//  Copyright © 2019年 playplay. All rights reserved.
//

import Foundation
import UIKit

class AvatarHeader{
    var scoreString:String!
    var barLength:CGFloat!
    var colorIndex:Int!
    
    init(scoreString:String, barLength:CGFloat, colorIndex:Int) {
        self.scoreString = scoreString
        self.barLength = barLength
        self.colorIndex = colorIndex
        
    }
    
}
