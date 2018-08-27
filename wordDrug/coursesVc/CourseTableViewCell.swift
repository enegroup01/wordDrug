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

    
    //layOut
    let height = UIScreen.main.bounds.height

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        enterBookBtnOutlet.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        enterClassBtnOutlet.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
        enterBookBtnOutlet.layer.cornerRadius = enterBookBtnOutlet.frame.width / 20
        enterClassBtnOutlet.layer.cornerRadius = enterClassBtnOutlet.frame.width / 20
        
        var fontSize: CGFloat!
        var frameSize: CGFloat!
        var dynamicHeight: CGFloat!
        
        switch height {
            
        case 812:
dynamicHeight = 120
            fontSize = 55
            frameSize = 80
            
        case 736:
dynamicHeight = 120
              fontSize = 55
            
            frameSize = 80
        case 667:
            
  dynamicHeight = 110
            fontSize = 50
            frameSize = 75
            
        case 568:
dynamicHeight = 90
              fontSize = 36
            frameSize = 60
        default:
 
            dynamicHeight = 110
            fontSize = 55
            frameSize = 60
            

        }
        courseTitleImg.frame = CGRect(x: 15, y: (dynamicHeight - frameSize) / 2, width: frameSize, height: frameSize)
        wordCountOutlet.font = wordCountOutlet.font.withSize(fontSize)

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
