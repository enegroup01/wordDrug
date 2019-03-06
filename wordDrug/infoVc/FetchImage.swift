//
//  FetchImage.swift
//  wordDrug
//
//  Created by Ethan on 2019/2/25.
//  Copyright © 2019年 playplay. All rights reserved.
//

import Foundation
import UIKit

class FetchImage {
    
    static let shared = FetchImage()
    
    func fetchAvatar(stagePassed:[Int], completion: @escaping([Avatar]) -> ()) {
        
        var avatarArray = [Avatar]()
        var avatarImage = UIImage()
        var avatarImage2 = UIImage()
        var avatar:Avatar?
        var avatar2:Avatar?
        
        for i in 0 ..< 36 {
            
             let level = i / 4
            
            if stagePassed[level] == 0 {
                
                avatarImage = saturatedImage(imageName: "m" + String(i + 1) + ".png")
                avatar = Avatar(image:avatarImage, level: "Level " + String(level + 1), imageName:"m" + String(i + 1))
                avatarImage2 = saturatedImage(imageName: "f" + String(i + 1) + ".png")
                avatar2 = Avatar(image:avatarImage2, level: "Level " + String(level + 1), imageName: "f" + String(i + 1))
                
            } else if stagePassed[level] == 1{
                
                avatarImage = UIImage(named: "m" + String(i + 1) + ".png")!
                avatar = Avatar(image:avatarImage, level: "Level " + String(level + 1), imageName: "m" + String(i + 1))
                avatarImage2 = UIImage(named: "f" + String(i + 1) + ".png")!
                avatar2 = Avatar(image:avatarImage2, level: "Level " + String(level + 1), imageName:  "f" + String(i + 1))
                
            }
            avatarArray.append(avatar!)
            avatarArray.append(avatar2!)
            
        }

        completion(avatarArray)
        
    }
    
    private func saturatedImage(imageName:String) -> UIImage{
        
        var imageToReturn = UIImage(named: imageName)
            //change image saturation
            let ciimage = CIImage.init(cgImage: imageToReturn!.cgImage!)
            let filter = CIFilter.init(name: "CIColorControls")
            filter?.setValue(ciimage, forKey: kCIInputImageKey)
            filter?.setValue(0.0, forKey: kCIInputSaturationKey)
            let result = filter?.value(forKey: kCIOutputImageKey) as! CIImage
            let cgimage = CIContext.init(options: nil).createCGImage(result, from: result.extent)
            imageToReturn = UIImage.init(cgImage: cgimage!)
        return imageToReturn!
        
    }

}

