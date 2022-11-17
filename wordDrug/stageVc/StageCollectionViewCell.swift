//
//  StageCollectionViewCell.swift
//  wordDrug
//
//  Created by Ethan on 2018/8/30.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class StageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var wordCountLabel: UILabel!
    
    @IBOutlet weak var stageLabel: UILabel!
    
    @IBOutlet weak var lockImg: UIImageView!
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    override func awakeFromNib() {
        
        var stageFontSize:CGFloat!
        var wordCountFontSize:CGFloat!
        var lockWidth:CGFloat!
        var lockHeight:CGFloat!
        var iPadDif:CGFloat!
        var dif:CGFloat!

        switch height {
            
        case 1366, 1336:
            //print("big iPad")

            stageFontSize = 180
            wordCountFontSize = 40
            lockWidth = 235.04
            lockHeight = 299.52
            iPadDif = 2
            dif = 1
           
            
        case 1024, 1194, 1112:
            //print("small iPad")
            
            stageFontSize = 160
            wordCountFontSize = 40
            lockWidth = 180.8
            lockHeight = 230.4
            iPadDif = 2
            dif = 1
      
            
        case 812:
            //print("iPhone X")

            stageFontSize = 80
            wordCountFontSize = 20
            lockWidth = 113
            lockHeight = 144
             iPadDif = 1
            dif = 1
   
        case 736:
            //print("iPhone plus")

            stageFontSize = 80
            wordCountFontSize = 20
            lockWidth = 113
            lockHeight = 144
           
            iPadDif = 1
            dif = 1
   
            
        case 667:
            //print("iPhone")

            stageFontSize = 80
            wordCountFontSize = 20
            lockWidth = 113
            lockHeight = 144
              iPadDif = 1
            dif = 1
      
        case 568:
            //print("iPhone SE")
            
            stageFontSize = 65
            wordCountFontSize = 20
            lockWidth = 101.7
            lockHeight = 129.6
            iPadDif = 1
            dif = 0.7
       
            
        default:
            
            
            stageFontSize = 80
            wordCountFontSize = 20
            lockWidth = 113
            lockHeight = 144
            iPadDif = 1
            dif = 1
            break
            
        }
        
        stageLabel.font = stageLabel.font.withSize(stageFontSize)
        stageLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: width / 6, left: width / 6, bottom: 0, right: 0), size: .init(width: width / 6, height: width / 5))
        

        wordCountLabel.font = wordCountLabel.font.withSize(wordCountFontSize)
        wordCountLabel.textAlignment = .center
        wordCountLabel.anchor(top: stageLabel.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: -7 * iPadDif * dif, left: width / 12, bottom: 0, right: 0), size: .init(width: width / 3, height: width / 20))
        //wordCountLabel.backgroundColor = .black
        wordCountLabel.adjustsFontSizeToFitWidth = true
  
        lockImg.translatesAutoresizingMaskIntoConstraints = false
        lockImg.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lockImg.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lockImg.widthAnchor.constraint(equalToConstant: lockWidth).isActive = true
        lockImg.heightAnchor.constraint(equalToConstant: lockHeight).isActive = true
        
    }
    
}
