//
//  CourseTableViewCell.swift
//  wordDrug
//
//  Created by Ethan on 2018/8/16.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

protocol CourseTableViewCellDelegate {
    
    func didTapEnterClass(indexPath: IndexPath)
    func didTapEnterBook(indexPath: IndexPath)
}

class CourseTableViewCell: UITableViewCell {
    
    var indexPath: IndexPath!
    
    var delegate: CourseTableViewCellDelegate?

    @IBOutlet weak var enterClassBtnOutlet: UIButton!
    
    @IBOutlet weak var courseTitleImg: UIImageView!
    @IBOutlet weak var wordCountOutlet: UILabel!
    @IBOutlet weak var enterBookBtnOutlet: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        enterBookBtnOutlet.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        enterClassBtnOutlet.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
        enterBookBtnOutlet.layer.cornerRadius = enterBookBtnOutlet.frame.width / 20
        enterClassBtnOutlet.layer.cornerRadius = enterClassBtnOutlet.frame.width / 20
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func generateCell(indexPath: IndexPath){
        self.indexPath = indexPath
    
    }
    
    @IBAction func enterClassPressed(_ sender: Any) {
        delegate!.didTapEnterClass(indexPath: indexPath)
    }
    
    
    @IBAction func enterBookPressed(_ sender: Any) {
        delegate!.didTapEnterBook(indexPath: indexPath)
    }
    
    
}
