//
//  WordBookTableViewCell.swift
//  wordDrug
//
//  Created by Ethan on 2018/1/30.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class WordBookTableViewCell: UITableViewCell {

    @IBOutlet weak var likeImg: UIImageView!
    
    var tapAction: ((UITableViewCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        likeImg.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(WordBookTableViewCell.likeClicked))
        likeImg.addGestureRecognizer(gesture)
    }

    @objc func likeClicked(){
    
        print("touched")
        tapAction?(self)

        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
