//
//  InfoTableViewCell.swift
//  wordDrug
//
//  Created by Ethan on 2018/5/18.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    @IBOutlet weak var infoTitle: UILabel!
    
    @IBOutlet weak var rankBtn: UIButton!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rankTitle: UILabel!
    @IBOutlet weak var totalRate: UILabel!
    @IBOutlet weak var ringView: MKRingProgressView!
    @IBOutlet weak var sub2Rate: UILabel!
    @IBOutlet weak var sub2Title: UILabel!
    @IBOutlet weak var sub1Rate: UILabel!
    @IBOutlet weak var sub1Title: UILabel!
    @IBOutlet weak var infoCellBg: UIView!
    let lightGrayShadow = UIColor.init(red: 211/255, green: 211/255, blue: 211/255, alpha: 0.5)
    
    let darkColor = UIColor.init(red: 41/255, green: 56/255, blue: 87/255, alpha: 1)
    let midColor = UIColor.init(red: 138/255, green: 152/255, blue: 170/255, alpha: 1)
    let lightColor = UIColor.init(red: 196/255, green: 203/255, blue: 213/255, alpha: 1)
    let yellowColor = UIColor.init(red: 255/255, green: 182/255, blue: 13/255, alpha: 1)
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.height)
        
        infoCellBg.backgroundColor = .white
        infoCellBg.frame = CGRect(x: self.frame.width * 1 / 12, y: self.frame.height * 1 / 12, width: self.frame.width * 5 / 6, height: self.frame.height * 7 / 8)
        
        //infoCellBg.frame = CGRect(x: width * 1 / 12, y: height * 1 / 20, width: width * 5 / 6, height: height * 1 / 3.7)
        infoCellBg.layer.cornerRadius = infoCellBg.frame.width / 35
        let shadowCg = lightGrayShadow.cgColor
        infoCellBg.layer.shadowColor = shadowCg
        infoCellBg.layer.shadowOffset = CGSize.zero
        infoCellBg.layer.shadowOpacity = 1
        infoCellBg.layer.shadowRadius = 2
        
        infoTitle.textColor = midColor
        sub1Title.textColor = lightColor
        sub1Rate.textColor = lightColor
        sub2Title.textColor = lightColor
        sub2Rate.textColor = lightColor
        totalRate.textColor = darkColor
        rankTitle.textColor = midColor
        rankLabel.textColor = lightColor
        rankBtn.setTitleColor(yellowColor, for: .normal)
        
        
        //infoTitle.backgroundColor = .blue
        infoTitle.frame = CGRect(x: self.frame.width / 25, y: self.frame.height / 10, width: self.frame.width / 3.5, height: self.frame.height / 8)
        infoTitle.font = UIFont(name: "Helvetica Bold", size: 20)
        infoTitle.textAlignment = .left
        
        //sub1Title.backgroundColor = .red
        sub1Title.frame = CGRect(x: 0, y: infoTitle.frame.maxY * 1.2, width: self.frame.width / 3.5, height: self.frame.height / 9)
        sub1Title.textAlignment = .center
                sub1Title.font = UIFont(name: "Helvetica Neue", size: 12)
        
        //sub1Rate.backgroundColor = .blue
        sub1Rate.frame = CGRect(x: 0, y: sub1Title.frame.maxY, width: self.frame.width / 3.5, height: self.frame.height / 9)
        sub1Rate.textAlignment = .center
        sub1Rate.font = UIFont(name: "Helvetica Neue", size: 12)
        
        
        //sub2Title.backgroundColor = .red
        sub2Title.frame = CGRect(x: 0, y: sub1Rate.frame.maxY, width: self.frame.width / 3.5, height: self.frame.height / 9)
        sub2Title.textAlignment = .center
        sub2Title.font = UIFont(name: "Helvetica Neue", size: 12)
        
        //sub2Rate.backgroundColor = .blue
        sub2Rate.frame = CGRect(x: 0, y: sub2Title.frame.maxY, width: self.frame.width / 3.5, height: self.frame.height / 9)
        sub2Rate.textAlignment = .center
        sub2Rate.font = UIFont(name: "Helvetica Neue", size: 12)

        

        ringView.frame = CGRect(x: self.frame.width / 3.3, y: self.frame.height / 8, width: self.frame.width / 3.3, height: self.frame.width / 3.3)
        
        //rankTitle.backgroundColor = .green
        rankTitle.textAlignment = .center
        rankTitle.frame = CGRect(x: ringView.frame.maxX * 1.05, y: infoTitle.frame.minY, width: self.frame.width / 7, height: self.frame.height / 8)

        rankTitle.font = UIFont(name: "Helvetica Bold", size: 20)
        
        
        //rankLabel.backgroundColor = .purple
        rankLabel.textAlignment = .center

        rankLabel.font = UIFont(name: "Helvetica Bold", size: 48)
                rankLabel.adjustsFontSizeToFitWidth = true
        rankLabel.frame = CGRect(x: rankTitle.frame.minX, y: rankTitle.frame.maxY * 1.3, width: rankTitle.frame.width, height: rankTitle.frame.width)
        
        rankBtn.frame = CGRect(x: rankTitle.frame.minX, y: rankLabel.frame.maxY * 1.1, width: rankTitle.frame.width, height: rankTitle.frame.height)
        
        
        //totalRate.backgroundColor = .purple
        totalRate.textAlignment = .center
        totalRate.font = UIFont(name: "Helvetica Bold", size: 20)
        totalRate.textColor = darkColor
        totalRate.frame = CGRect(x: 0, y: ringView.frame.height / 2.8, width: ringView.frame.width, height: ringView.frame.height / 4)
        
        
        


        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
