//
//  BookTableViewCell.swift
//  wordDrug
//
//  Created by Ethan on 2018/4/20.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var chiWordLabel: UILabel!
    @IBOutlet weak var engWordLabel: UILabel!
    
    let width =  UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    @IBOutlet weak var chiSenLabel: UILabel!
    @IBOutlet weak var engSenLabel: UILabel!
    @IBOutlet weak var syllableLabel: UILabel!
    
    @IBOutlet weak var partOfSpeechLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        var dif = CGFloat()
        
        switch height {
        case 812:
            

            dif = 1.2
     
            
        case 736:

            dif = 1.2
        
            
        case 667:
            
           dif = 1.1
            
        case 568:


      
            dif = 1
        default:
            break
            
        }

        
       
        engWordLabel.frame = CGRect(x: 52 , y: 3, width: 250 * dif, height: 35)
        partOfSpeechLabel.frame = CGRect(x: engWordLabel.frame.minX, y: engWordLabel.frame.maxY, width: 30 * dif, height: 20)
        engSenLabel.frame = CGRect(x: engWordLabel.frame.minX, y: partOfSpeechLabel.frame.maxY, width: 250 * dif, height: 35)
        chiSenLabel.frame = CGRect(x: engWordLabel.frame.minX, y: engSenLabel.frame.maxY, width: 200 * dif, height: 30)
        
        chiWordLabel.frame = CGRect(x: partOfSpeechLabel.frame.maxX, y: engWordLabel.frame.maxY, width: 200 * dif, height: 20)
        
        /*
        engWordLabel.backgroundColor = .red
        chiWordLabel.backgroundColor = .green
        partOfSpeechLabel.backgroundColor = .purple
        engSenLabel.backgroundColor = .blue
        chiSenLabel.backgroundColor = .yellow
        syllableLabel.backgroundColor = .white
        */
    
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
