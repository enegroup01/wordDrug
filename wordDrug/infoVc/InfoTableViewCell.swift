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
    
    @IBOutlet weak var totalRate: UILabel!
    @IBOutlet weak var ringView: MKRingProgressView!
    @IBOutlet weak var sub2Rate: UILabel!
    
    @IBOutlet weak var sub2Title: UILabel!
   
    @IBOutlet weak var sub1Rate: UILabel!
    
    @IBOutlet weak var sub1Title: UILabel!
    
    
    @IBOutlet weak var infoCellBg: UIView!
    let lightGrayShadow = UIColor.init(red: 211/255, green: 211/255, blue: 211/255, alpha: 0.5)
    let orangeColor = UIColor.init(red: 232/255, green: 98/255, blue: 61/255, alpha: 1)
    
    let darkColor = UIColor.init(red: 41/255, green: 56/255, blue: 87/255, alpha: 1)
    let midColor = UIColor.init(red: 138/255, green: 152/255, blue: 170/255, alpha: 1)
    let lightColor = UIColor.init(red: 196/255, green: 203/255, blue: 213/255, alpha: 1)
    let yellowColor = UIColor.init(red: 255/255, green: 182/255, blue: 13/255, alpha: 1)
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    
    @IBOutlet weak var bigCountLabel: UILabel!
    
    @IBOutlet weak var countUnitLabel: UILabel!

    //var indexPath:IndexPath?
    var value:Value? {
        
        didSet{
            
            guard let value = value else {return}
            
            infoTitle.text = value.infoTitle
            sub1Title.text = value.sub1Title
            sub1Rate.text = value.sub1Value
            sub2Title.text = value.sub2Title
            sub2Rate.text = value.sub2Value
            totalRate.text = value.avgValue
            bigCountLabel.text = value.bigCountValue
            countUnitLabel.text = value.bigCountUnit
            
            let progressString = value.avgValue
            let progressInt = progressString?.replacingOccurrences(of: "%", with: "")
            
         
            if progressInt != "" {
                
                ringView.progress = 0.0
                CATransaction.setCompletionBlock {[weak self] in
                CATransaction.begin()
                CATransaction.setAnimationDuration(2)
                self!.ringView.progress = Double(progressInt!)! / Double(100)
                CATransaction.commit()
                
            
                }
            
      
            }
        }
        
    }
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        var iPadDif = CGFloat()
        var cellBgHeight: CGFloat!
        var infoTitleFontSize:CGFloat!
        var subTitleFontSize:CGFloat!
        var subValueFontSize:CGFloat!
        var ringSizeDif:CGFloat!
        var bigCountLabelFontSize:CGFloat!
        var wordCountUnitFontSize:CGFloat!
        var infoHeightDif:CGFloat!
        var iPhoneXInfoTitleYDif:CGFloat!
        
        switch height {
            
        case 1366, 1336, 1112:
     
            iPadDif = 1.5
            cellBgHeight = 300
            infoTitleFontSize = 35
            subTitleFontSize = 30
            subValueFontSize = 25
            ringSizeDif = 2
            bigCountLabelFontSize = 80
            wordCountUnitFontSize = 40
            infoHeightDif = 3.5
            iPhoneXInfoTitleYDif = 1
            
            
        case 1024:
            
              iPadDif = 1
            cellBgHeight = 220
            infoTitleFontSize = 25
              subTitleFontSize = 20
              subValueFontSize = 18
            ringSizeDif = 1.5
              bigCountLabelFontSize = 70
              wordCountUnitFontSize = 30
            infoHeightDif = 4.5
            iPhoneXInfoTitleYDif = 1
        case 812:
            
            //iPhoneX
 
            iPadDif = 1
            cellBgHeight = 180
            infoTitleFontSize = 18
            subTitleFontSize = 14
            subValueFontSize = 12
            ringSizeDif = 0.9
            bigCountLabelFontSize = 60
            wordCountUnitFontSize = 20
            infoHeightDif = 8
            iPhoneXInfoTitleYDif = 1.6
            
        case 736:
            //plus
             iPadDif = 1
             cellBgHeight = 150
            infoTitleFontSize = 18
             subTitleFontSize = 14
             subValueFontSize = 12
            ringSizeDif = 1
             bigCountLabelFontSize = 50
             wordCountUnitFontSize = 18
            infoHeightDif = 8
            iPhoneXInfoTitleYDif = 0.8
            
        case 667:
            
            iPadDif = 1
            cellBgHeight = 150
            infoTitleFontSize = 18
            subTitleFontSize = 14
            subValueFontSize = 12
            ringSizeDif = 1
            bigCountLabelFontSize = 50
            wordCountUnitFontSize = 16
            infoHeightDif = 8
            iPhoneXInfoTitleYDif = 1
            
        case 568:
            
          iPadDif = 1
            cellBgHeight = 120
            infoTitleFontSize = 14
          subTitleFontSize = 12
          subValueFontSize = 12
            ringSizeDif = 0.75
          bigCountLabelFontSize = 40
          wordCountUnitFontSize = 16
            infoHeightDif = 8
            iPhoneXInfoTitleYDif = 1
            
        default:
            
            iPadDif = 1
            cellBgHeight = 180
            infoTitleFontSize = 18
            subTitleFontSize = 14
            subValueFontSize = 12
            ringSizeDif = 0.9
            bigCountLabelFontSize = 60
            wordCountUnitFontSize = 20
            infoHeightDif = 8
            iPhoneXInfoTitleYDif = 1.6
          break
    
        }
        
        
        self.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.height)
        
        //infoCellBg.backgroundColor = .red
        infoCellBg.frame = CGRect(x: self.frame.width * 1 / 12, y: self.frame.height * 1 / 12, width: self.frame.width * 5 / 6, height: cellBgHeight)
        
        
        //infoCellBg.frame = CGRect(x: width * 1 / 12, y: height * 1 / 20, width: width * 5 / 6, height: height * 1 / 3.7)
        infoCellBg.layer.cornerRadius = infoCellBg.frame.width / 35
        let shadowCg = lightGrayShadow.cgColor
        infoCellBg.layer.shadowColor = shadowCg
        infoCellBg.layer.shadowOffset = CGSize.zero
        infoCellBg.layer.shadowOpacity = 1
        infoCellBg.layer.shadowRadius = 2
        
        infoTitle.textColor = darkColor
        sub1Title.textColor = midColor
        sub1Rate.textColor = midColor
        sub2Title.textColor = midColor
        sub2Rate.textColor = midColor
        totalRate.textColor = darkColor
        //rankTitle.textColor = midColor
        //rankLabel.textColor = lightColor
        //rankBtn.setTitleColor(yellowColor, for: .normal)
        
        
      
        //infoTitle.frame = CGRect(x: self.frame.width / 25, y: self.frame.height / 10, width: self.frame.width / 3.5, height: self.frame.height / 8)
        infoTitle.font = UIFont(name: "Helvetica Bold", size: infoTitleFontSize)
        infoTitle.textAlignment = .center
        infoTitle.adjustsFontSizeToFitWidth = true
        infoTitle.anchor(top: infoCellBg.topAnchor, leading: infoCellBg.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10 * iPhoneXInfoTitleYDif, left: 0, bottom: 0, right: 0), size: CGSize(width: infoCellBg.frame.width / 3, height: self.frame.height / infoHeightDif))
        
     
        //sub1Title.frame = CGRect(x: 0, y: infoTitle.frame.maxY * 1.2, width: self.frame.width / 3.5, height: self.frame.height / 9)
        
        sub1Title.anchor(top: infoTitle.bottomAnchor, leading: infoCellBg.leadingAnchor, bottom: nil, trailing: nil)
        sub1Title.anchorSize(to: infoTitle)
        
        sub1Title.textAlignment = .center
                sub1Title.font = UIFont(name: "Helvetica Neue", size: subTitleFontSize)
        
       
        //sub1Rate.frame = CGRect(x: 0, y: sub1Title.frame.maxY, width: self.frame.width / 3.5, height: self.frame.height / 9)
        
        sub1Rate.anchor(top: sub1Title.bottomAnchor, leading: infoCellBg.leadingAnchor, bottom: nil, trailing: nil)
        sub1Rate.anchorSize(to: sub1Title)
        sub1Rate.adjustsFontSizeToFitWidth = true
        sub1Rate.textAlignment = .center
        sub1Rate.font = UIFont(name: "Helvetica Neue", size: subValueFontSize)
        
        
   
        //sub2Title.frame = CGRect(x: 0, y: sub1Rate.frame.maxY, width: self.frame.width / 3.5, height: self.frame.height / 9)
        sub2Title.anchor(top: sub1Rate.bottomAnchor, leading: infoCellBg.leadingAnchor, bottom: nil, trailing: nil)
        sub2Title.anchorSize(to: sub1Rate)
        
        
        sub2Title.textAlignment = .center
        sub2Title.font = UIFont(name: "Helvetica Neue", size: subTitleFontSize)
        
        //sub2Rate.frame = CGRect(x: 0, y: sub2Title.frame.maxY, width: self.frame.width / 3.5, height: self.frame.height / 9)
        
        sub2Rate.anchor(top: sub2Title.bottomAnchor, leading: infoCellBg.leadingAnchor, bottom: nil, trailing: nil)
        sub2Rate.anchorSize(to: sub2Title)
        sub2Rate.adjustsFontSizeToFitWidth = true
        sub2Rate.textAlignment = .center
        sub2Rate.font = UIFont(name: "Helvetica Neue", size: subValueFontSize)

        

        //ringView.frame = CGRect(x: self.frame.width / 3.3, y: self.frame.height / 8, width: self.frame.width / 3.3 * iPadDif * iPadDif, height: self.frame.width / 3.3 * iPadDif * iPadDif)
        
        ringView.translatesAutoresizingMaskIntoConstraints = false
        ringView.widthAnchor.constraint(equalToConstant: 120 * ringSizeDif).isActive = true
        ringView.heightAnchor.constraint(equalToConstant: 120 * ringSizeDif).isActive = true
        ringView.centerXAnchor.constraint(equalTo: infoCellBg.centerXAnchor).isActive = true
        ringView.centerYAnchor.constraint(equalTo: infoCellBg.centerYAnchor).isActive = true
        
        
  
        totalRate.textAlignment = .center
        totalRate.font = UIFont(name: "Helvetica Bold", size: infoTitleFontSize)
        totalRate.textColor = darkColor
        //totalRate.frame = CGRect(x: 0, y: ringView.frame.height / 2.8, width: ringView.frame.width, height: ringView.frame.height / 4)
        
        totalRate.translatesAutoresizingMaskIntoConstraints = false
        totalRate.widthAnchor.constraint(equalToConstant: 80 * ringSizeDif).isActive = true
        totalRate.heightAnchor.constraint(equalToConstant: 30 * ringSizeDif).isActive = true
        totalRate.centerXAnchor.constraint(equalTo: infoCellBg.centerXAnchor).isActive = true
        totalRate.centerYAnchor.constraint(equalTo: infoCellBg.centerYAnchor).isActive = true
        
        
        bigCountLabel.textAlignment = .center
        //bigCountLabel.frame = CGRect(x: ringView.frame.minX, y: ringView.frame.minY, width: ringView.frame.width, height: ringView.frame.height)
        bigCountLabel.adjustsFontSizeToFitWidth = true
        bigCountLabel.textColor = yellowColor
        
        
        bigCountLabel.translatesAutoresizingMaskIntoConstraints = false
        bigCountLabel.widthAnchor.constraint(equalToConstant: 100 * ringSizeDif).isActive = true
        bigCountLabel.heightAnchor.constraint(equalToConstant: 50 * ringSizeDif).isActive = true
        bigCountLabel.centerXAnchor.constraint(equalTo: infoCellBg.centerXAnchor).isActive = true
        bigCountLabel.centerYAnchor.constraint(equalTo: infoCellBg.centerYAnchor).isActive = true
        bigCountLabel.font = bigCountLabel.font.withSize(bigCountLabelFontSize)
        
        
        
        //countUnitLabel.frame = CGRect(x: bigCountLabel.frame.maxX, y: bigCountLabel.frame.maxY - 28 * 1.5, width: 38 , height:28)
        countUnitLabel.textColor = darkColor

        countUnitLabel.anchor(top: nil, leading: bigCountLabel.trailingAnchor, bottom: bigCountLabel.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 10 * iPadDif, right: 0), size: CGSize(width: 38 * iPadDif, height: 28 * iPadDif))
        countUnitLabel.font = countUnitLabel.font.withSize(wordCountUnitFontSize)

        
        /*
         countUnitLabel.backgroundColor = .red
         bigCountLabel.backgroundColor = .blue
         totalRate.backgroundColor = .purple
         sub2Rate.backgroundColor = .blue
         sub2Title.backgroundColor = .red
         sub1Rate.backgroundColor = .blue
         sub1Title.backgroundColor = .red
         infoTitle.backgroundColor = .yellow
        */
 
        
        
        
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

