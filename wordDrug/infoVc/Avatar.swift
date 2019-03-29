//
//  Avatar.swift
//  wordDrug
//
//  Created by Ethan on 2019/2/25.
//  Copyright © 2019年 playplay. All rights reserved.
//

import Foundation
import UIKit

class Avatar{
    
    var image: UIImage!
    var level: String!
    var imageName: String!

    
    init(image:UIImage, level:String, imageName:String) {
        self.image = image
        self.level = level
        self.imageName = imageName
    }
    
}

