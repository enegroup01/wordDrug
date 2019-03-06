//
//  Student.swift
//  wordDrug
//
//  Created by Ethan on 2019/2/25.
//  Copyright © 2019年 playplay. All rights reserved.
//

import Foundation
import UIKit

class Student{

    

    var avaImg: String!
    var nickName: String!
    var allWordsCount: Int!
    var score: String!
    var stagePassed: [Int]!

    
    
    init(avaImg: String, nickName: String, allWordsCount: Int, score:String, stagePassed: [Int] ) {
        
        self.avaImg = avaImg
        self.nickName = nickName
        self.allWordsCount = allWordsCount
        self.score = score
        self.stagePassed = stagePassed

    }
    

}
