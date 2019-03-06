//
//  Values.swift
//  wordDrug
//
//  Created by Ethan on 2019/2/28.
//  Copyright © 2019年 playplay. All rights reserved.
//

import Foundation
import UIKit

class Value{

    var infoTitle:String!
    var sub1Title:String!
    var sub1Value:String!
    var sub2Title:String!
    var sub2Value:String!
    var avgValue:String!
    var bigCountValue:String!
    var bigCountUnit:String!
    
    init(infoTitle:String, sub1Title:String, sub1Value:String, sub2Title:String, sub2Value:String, avgValue:String, bigCountValue:String, bigCountUnit:String) {
        
        self.infoTitle = infoTitle
        self.sub1Title = sub1Title
        self.sub1Value = sub1Value
        self.sub2Title = sub2Title
        self.sub2Value = sub2Value
        self.avgValue = avgValue
        self.bigCountValue = bigCountValue
        self.bigCountUnit = bigCountUnit
        
    }
    
    
    
}
