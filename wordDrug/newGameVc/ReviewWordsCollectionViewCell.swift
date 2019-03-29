//
//  ReviewWordsCollectionViewCell.swift
//  wordDrug
//
//  Created by Ethan on 2019/3/22.
//  Copyright © 2019年 playplay. All rights reserved.
//

import UIKit

class ReviewWordsCollectionViewCell: UICollectionViewCell {
    
    
    let checkSpot = UIView()
    
    var word:Word? {
        
        didSet{
        guard let word = word else {return}
        engWordLabel.text = word.engWord
        chiWordLabel.text = word.chiWord
            
        }
    }

    
    var engWordLabel:UILabel = {
       var lb = UILabel()
        lb.font = UIFont(name: "Helvetica Bold", size: 20)
        lb.textColor = #colorLiteral(red: 0.1490196078, green: 0.01176470588, blue: 0.1215686275, alpha: 1)
        lb.adjustsFontSizeToFitWidth = true
       
        
        return lb
    }()
    
    var chiWordLabel:UILabel = {
        var lb = UILabel()
        lb.font = UIFont(name: "Helvetica SemiBold", size: 16)
        lb.textColor = #colorLiteral(red: 0.1490196078, green: 0.01176470588, blue: 0.1215686275, alpha: 1)
        lb.adjustsFontSizeToFitWidth = true

        
        return lb
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.layer.cornerRadius = 5
        
        self.addSubview(engWordLabel)
        engWordLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 1, left: 1, bottom: -self.frame.height / 2, right: -self.frame.width / 3))
        
        
        self.addSubview(chiWordLabel)
        chiWordLabel.anchor(top: engWordLabel.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: engWordLabel.trailingAnchor, padding: .init(top: 1, left: 1, bottom: -1, right:0))
        
        self.addSubview(checkSpot)
        checkSpot.translatesAutoresizingMaskIntoConstraints = false
        checkSpot.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        checkSpot.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        checkSpot.widthAnchor.constraint(equalToConstant: 14).isActive = true
        checkSpot.heightAnchor.constraint(equalToConstant: 14).isActive = true
        checkSpot.layer.cornerRadius = 7
        checkSpot.clipsToBounds = true
        checkSpot.backgroundColor = .clear
    }
    
    
    
}
