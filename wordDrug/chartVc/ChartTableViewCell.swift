//
//  ChartTableViewCell.swift
//  wordDrug
//
//  Created by Ethan on 2018/5/23.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class ChartTableViewCell: UITableViewCell {

    @IBOutlet weak var rankLabel: UILabel!
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    
    @IBOutlet weak var avaImg: UIImageView!

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var wordCountTitleLabel: UILabel!
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var seperatorLine: UIImageView!
    
    var dif = CGFloat()
    var iPadDif = CGFloat()
    var fontSize = CGFloat()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        switch height {
        case 812:
            
            
            dif = 1.1
            iPadDif = 1
            fontSize = 25
            
        case 736:
            
            dif = 1
         iPadDif = 1
            fontSize = 25
            
        case 667:
            
            dif = 1
            iPadDif = 1
            fontSize = 25
        case 568:
            
            
            dif = 0.2
            iPadDif = 1
            fontSize = 25
        default:
            dif = 1
            iPadDif = 0.8
            fontSize = 18
           
            
        }
        seperatorLine.frame = CGRect(x: 0, y: height / 8 - 6 * dif, width: width, height: 6)
        
        rankLabel.frame = CGRect(x: width / 30, y: height / 36, width: 55, height: 50)
        //rankLabel.adjustsFontSizeToFitWidth = true
        //rankLabel.backgroundColor = .red
        rankLabel.textAlignment = .center
        
        avaImg.frame = CGRect(x: rankLabel.frame.maxX * 1.1, y: rankLabel.frame.minY, width: 50 * iPadDif, height: 50 * iPadDif)
        avaImg.layer.cornerRadius = avaImg.frame.width / 2
        
        usernameLabel.frame = CGRect(x: avaImg.frame.maxX * 1.2, y: avaImg.frame.minY - 4, width: width / 2.5 * iPadDif, height: 29 * iPadDif)
        //usernameLabel.backgroundColor = .green
        usernameLabel.font = usernameLabel.font.withSize(fontSize)
        usernameLabel.adjustsFontSizeToFitWidth = true
        
        totalScoreLabel.frame = CGRect(x: usernameLabel.frame.minX, y: usernameLabel.frame.maxY, width: usernameLabel.frame.width * iPadDif, height: 25 * iPadDif)
        //totalScoreLabel.backgroundColor = .gray
         totalScoreLabel.font = totalScoreLabel.font.withSize(fontSize)
        totalScoreLabel.adjustsFontSizeToFitWidth = true
        
        wordCountTitleLabel.frame = CGRect(x: usernameLabel.frame.maxX, y: usernameLabel.frame.minY, width: width - usernameLabel.frame.maxX * 1.05, height: 25)
        //wordCountTitleLabel.backgroundColor = .blue
        wordCountTitleLabel.adjustsFontSizeToFitWidth = true
        wordCountLabel.frame = CGRect(x: wordCountTitleLabel.frame.minX, y: wordCountTitleLabel.frame.maxY, width: wordCountTitleLabel.frame.width, height: 25)
        wordCountLabel.adjustsFontSizeToFitWidth = true
        //wordCountLabel.backgroundColor = .brown
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
