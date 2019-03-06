//
//  InfoAvatarCollectionReusableView.swift
//  wordDrug
//
//  Created by Ethan on 2019/3/4.
//  Copyright © 2019年 playplay. All rights reserved.
//

import UIKit

class InfoAvatarCollectionReusableView: UICollectionReusableView {
   
    @IBOutlet weak var avatarColorBarImage: UIImageView!
    @IBOutlet weak var avatarScoreLabel: UILabel!

    var header:AvatarHeader?  {
        
        didSet {
            
            guard let header = header else {return}
            
            avatarScoreLabel.text = header.scoreString
            avatarColorBarImage.image = UIImage(named:"avatarColor" + String(header.colorIndex) + ".png")
           

            DispatchQueue.main.async {[weak self] in
                
                self!.avatarColorBarImage.frame.size.width = self!.frame.width * (self!.header?.barLength!)!
                
                
            }
        }
    
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarScoreLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
        avatarScoreLabel.adjustsFontSizeToFitWidth = true
        avatarScoreLabel.numberOfLines = 1
        avatarScoreLabel.textAlignment = .center
        avatarScoreLabel.font = avatarScoreLabel.font.withSize(30)
        
        avatarColorBarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarColorBarImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        avatarColorBarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        avatarColorBarImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

    }


}
