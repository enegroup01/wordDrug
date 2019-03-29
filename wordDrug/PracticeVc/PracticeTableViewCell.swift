//
//  PracticeTableViewCell.swift
//  wordDrug
//
//  Created by Ethan on 2019/3/7.
//  Copyright © 2019年 playplay. All rights reserved.
//

import UIKit



class PracticeTableViewCell: UITableViewCell {
    

    var indexPath: IndexPath!
    
    var bgView = UIView()
    let bgColor = UIColor.init(red: 64/255, green: 68/255, blue: 77/255, alpha: 1)
    let checkSpot = UIView()
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected{

            } else {
         
            }

        }
    }
    
    var word:Word? {
        
        didSet{
            guard let word = word else {return}
            
            engWordLabel.text = word.engWord
            chiWordLabel.text = word.chiWord
            
        }
    }
    
    var engWordLabel:UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Helvetica Bold", size: 25)
        lb.textColor = .white

        return lb
    }()
    
    var chiWordLabel:UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Helvetica", size: 18)
        lb.textColor = .lightGray
        
        return lb
    }()

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = .clear
        bgView.backgroundColor = bgColor
        bgView.frame = CGRect(x: 0, y: 10, width: self.frame.width, height: self.frame.height - 20)
        bgView.layer.cornerRadius = 5
        self.addSubview(bgView)
        bgView.addSubview(engWordLabel)
        bgView.addSubview(chiWordLabel)
        
        
        self.addSubview(checkSpot)
        checkSpot.translatesAutoresizingMaskIntoConstraints = false
        checkSpot.centerYAnchor.constraint(equalTo: bgView.centerYAnchor).isActive = true
        checkSpot.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -15).isActive = true
        checkSpot.widthAnchor.constraint(equalToConstant: 20).isActive = true
        checkSpot.heightAnchor.constraint(equalToConstant: 20).isActive = true
        checkSpot.layer.cornerRadius = 10
        checkSpot.clipsToBounds = true
        checkSpot.backgroundColor = .red
        
        engWordLabel.anchor(top: bgView.topAnchor, leading: bgView.leadingAnchor, bottom: bgView.bottomAnchor, trailing: checkSpot.leadingAnchor, padding: .init(top: 5, left: 5, bottom: -bgView.frame.height / 2, right: -5))
        chiWordLabel.anchor(top: engWordLabel.bottomAnchor, leading: bgView.leadingAnchor, bottom: bgView.bottomAnchor, trailing: checkSpot.leadingAnchor, padding: .init(top: 5, left: 5, bottom: -5, right: -5))

        
        
    }


    
}
