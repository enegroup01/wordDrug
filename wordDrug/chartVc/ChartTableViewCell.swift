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
        
        var rankFontSize:CGFloat!
        var nameFontSize:CGFloat!
        var scoreFontSize:CGFloat!
        var wordCountTitleFontSize:CGFloat!
        var wordCountFontSize:CGFloat!
        var iPhoneXDif:CGFloat!
        
        switch height {
        case 1366, 1336:
            
            dif = 1.5
            iPadDif = 1
 
            rankFontSize = 45
            nameFontSize = 45
            scoreFontSize = 40
            wordCountTitleFontSize = 30
            wordCountFontSize = 40
            iPhoneXDif = 1
        case 1024, 1194, 1112:
            dif = 1.1
            iPadDif = 0.8
            rankFontSize = 42
            nameFontSize = 40
            scoreFontSize = 36
            wordCountTitleFontSize = 28
            wordCountFontSize = 36
            iPhoneXDif = 1
        case 812:
            
            //iPhoneX
            
            dif = 1.1
            iPadDif = 0.4
            rankFontSize = 25
            nameFontSize = 25
            scoreFontSize = 20
            wordCountTitleFontSize = 15
            wordCountFontSize = 20
            iPhoneXDif = 1.5
            
        case 736:
            
            dif = 1
         iPadDif = 0.5
            rankFontSize = 25
            nameFontSize = 25
            scoreFontSize = 20
            wordCountTitleFontSize = 15
            wordCountFontSize = 20
            iPhoneXDif = 1.1
        case 667:
            
            dif = 1
            iPadDif = 0.45
            rankFontSize = 25
            nameFontSize = 22
            scoreFontSize = 20
            wordCountTitleFontSize = 15
            wordCountFontSize = 20
            iPhoneXDif = 1.2
        case 568:
            
            
            dif = 1
            iPadDif = 0.3
            rankFontSize = 20
            nameFontSize = 20
            scoreFontSize = 15
            wordCountTitleFontSize = 12
            wordCountFontSize = 15
            iPhoneXDif = 1.4
        default:
            dif = 1.1
            iPadDif = 0.4
            rankFontSize = 25
            nameFontSize = 25
            scoreFontSize = 20
            wordCountTitleFontSize = 15
            wordCountFontSize = 20
            iPhoneXDif = 1.5
            
            break
           
            
        }
        seperatorLine.frame = CGRect(x: 0, y: height / 8 - 6 * dif, width: width, height: 6)
        
        rankLabel.adjustsFontSizeToFitWidth = true

        rankLabel.textAlignment = .center
        
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        rankLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        rankLabel.widthAnchor.constraint(equalToConstant: 100 * iPadDif).isActive = true
        rankLabel.heightAnchor.constraint(equalToConstant: 100 * iPadDif).isActive = true
        rankLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15 * iPadDif).isActive = true
        rankLabel.font = rankLabel.font.withSize(rankFontSize)


        
        avaImg.translatesAutoresizingMaskIntoConstraints = false
        avaImg.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        avaImg.widthAnchor.constraint(equalToConstant: 120 * iPadDif * iPhoneXDif).isActive = true
        avaImg.heightAnchor.constraint(equalToConstant: 120 * iPadDif * iPhoneXDif).isActive = true
        avaImg.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 15 * iPadDif).isActive = true
        avaImg.contentMode = .scaleAspectFit
        avaImg.layer.cornerRadius = 120 * iPadDif * iPhoneXDif / 2
        
        
        

        usernameLabel.font = usernameLabel.font.withSize(fontSize)
        usernameLabel.adjustsFontSizeToFitWidth = true
        usernameLabel.anchor(top: self.topAnchor, leading: avaImg.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20 * iPadDif * iPhoneXDif, left: 20 * iPadDif, bottom: 0, right: 0), size: CGSize(width: 400 * iPadDif, height: 60 * iPadDif * iPhoneXDif))
        usernameLabel.font = usernameLabel.font.withSize(nameFontSize)
        

        totalScoreLabel.font = totalScoreLabel.font.withSize(fontSize)
        totalScoreLabel.adjustsFontSizeToFitWidth = true
        
        totalScoreLabel.anchor(top: usernameLabel.bottomAnchor, leading: avaImg.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20 * iPadDif, bottom: 0, right: 0), size: CGSize(width: 400 * iPadDif, height: 60 * iPadDif * iPhoneXDif))
        
        totalScoreLabel.font = totalScoreLabel.font.withSize(scoreFontSize)
        
        
 
        wordCountTitleLabel.adjustsFontSizeToFitWidth = true
        wordCountTitleLabel.anchor(top: self.topAnchor, leading: usernameLabel.trailingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 20 * iPadDif * iPhoneXDif, left: 0, bottom: 0, right: -20 * iPadDif), size: CGSize(width: 0, height: 60 * iPadDif * iPhoneXDif))

        wordCountTitleLabel.font = wordCountTitleLabel.font.withSize(wordCountTitleFontSize)
        
        

        wordCountLabel.adjustsFontSizeToFitWidth = true
        wordCountLabel.anchor(top: wordCountTitleLabel.bottomAnchor, leading: totalScoreLabel.trailingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: -20 * iPadDif), size: CGSize(width: 0, height: 60 * iPadDif * iPhoneXDif))
        wordCountLabel.font = wordCountLabel.font.withSize(wordCountFontSize)
        

        /*
        wordCountLabel.backgroundColor = .brown
        wordCountTitleLabel.backgroundColor = .blue
        totalScoreLabel.backgroundColor = .gray
        usernameLabel.backgroundColor = .green
        rankLabel.backgroundColor = .red
        */
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
