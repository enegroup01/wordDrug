//
//  InfoAvatarViewCell.swift
//  wordDrug
//
//  Created by Ethan on 2019/2/21.
//  Copyright © 2019年 playplay. All rights reserved.
//

import UIKit

protocol InfoAvatarViewCellDelegate {
    func didTapAvatar(indexPath: IndexPath)
}


class InfoAvatarViewCell: UICollectionViewCell {
    
    var delegate: InfoAvatarViewCellDelegate?
    
    @IBOutlet weak var avatarFrame: UIImageView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var avatarBanner: UIImageView!
    @IBOutlet weak var avatarLevelLabel: UILabel!
    @IBOutlet weak var avatarCheck: UIImageView!
    var indexPath: IndexPath!
    
    var avatar: Avatar?{
        
        didSet{
            
            guard let avatar = avatar else {return}
            
            avatarImage.image = avatar.image
            avatarLevelLabel.text = avatar.level
            
        }
        
    }
    
    override var isSelected: Bool{
        
        didSet{
            
        
            if self.isSelected{

                self.avatarCheck.isHidden = false
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.contentView.backgroundColor = UIColor.lightGray
                self.contentView.layer.cornerRadius = self.contentView.frame.width / 5
                self.contentView.clipsToBounds = true
                
                //delegate!.didTapAvatar(indexPath: indexPath)

                
            } else {
                //print("deselected")
                self.avatarCheck.isHidden = true
                self.transform = CGAffineTransform.identity
                self.contentView.backgroundColor = UIColor.clear
                self.contentView.layer.cornerRadius = self.contentView.frame.width / 5
                self.contentView.clipsToBounds = true


            }
            
        }
        
    }
    
    func generateCell(indexPath: IndexPath){
        self.indexPath = indexPath
        
    }
    
    override func awakeFromNib() {
             super.awakeFromNib()
        


        avatarFrame.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
        
        avatarImage.contentMode = .scaleAspectFit
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.widthAnchor.constraint(equalToConstant: self.frame.width * 0.9).isActive = true
        avatarImage.heightAnchor.constraint(equalToConstant: self.frame.height * 0.9).isActive = true
        avatarImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        avatarImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        avatarBanner.translatesAutoresizingMaskIntoConstraints = false
        avatarBanner.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        avatarBanner.heightAnchor.constraint(equalToConstant: self.frame.height / 4).isActive = true
        avatarBanner.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        avatarBanner.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        avatarLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarLevelLabel.centerXAnchor.constraint(equalTo: avatarBanner.centerXAnchor).isActive = true
        avatarLevelLabel.centerYAnchor.constraint(equalTo: avatarBanner.centerYAnchor).isActive = true
        avatarLevelLabel.widthAnchor.constraint(equalToConstant: avatarBanner.frame.width * 0.9).isActive = true
        avatarLevelLabel.heightAnchor.constraint(equalToConstant: avatarBanner.frame.height * 0.9).isActive = true
        avatarLevelLabel.adjustsFontSizeToFitWidth = true
        
        
        avatarCheck.translatesAutoresizingMaskIntoConstraints = false
        avatarCheck.widthAnchor.constraint(equalToConstant: self.frame.width / 3).isActive = true
        avatarCheck.heightAnchor.constraint(equalToConstant: self.frame.height / 3).isActive = true
        avatarCheck.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        avatarCheck.isHidden = true
//        avatarCheck.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
    
    func didTapAvatar(){
        delegate!.didTapAvatar(indexPath: indexPath)
    }
    
}
