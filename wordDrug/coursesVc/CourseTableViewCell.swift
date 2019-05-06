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
    
    let courseVC_enterClassBtnText = NSLocalizedString("courseVC_enterClassBtnText", comment: "")
    let courseVC_enterBookBtnText = NSLocalizedString("courseVC_enterBookBtnText", comment: "")
    let courseVC_wordUnit = NSLocalizedString("courseVC_wordUnit", comment: "")
    
    
    var indexPath: IndexPath!
    
    var delegate: CourseTableViewCellDelegate?
    
    @IBOutlet weak var enterClassBtnOutlet: UIButton!
    
    @IBOutlet weak var courseTitleImg: UIImageView!
    @IBOutlet weak var wordCountOutlet: UILabel!
    @IBOutlet weak var enterBookBtnOutlet: UIButton!
    
    @IBOutlet weak var wordUnitLabel: UILabel!
    
    //layOut
    let height = UIScreen.main.bounds.height
    let width = UIScreen.main.bounds.width
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        enterBookBtnOutlet.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        enterClassBtnOutlet.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
        var fontSize: CGFloat!
        var dynamicHeight: CGFloat!
        var cornerRadiusValue: CGFloat!
        var btnFontSize: CGFloat!
        var wordUnitFontSize: CGFloat!
        var iPadDif: CGFloat!
        var dif:CGFloat!
        
        switch height {
        case 1366, 1336:
           // print("iPad pro 2nd generation")
            
            dif = 1
            iPadDif = 2
            fontSize = 110
            cornerRadiusValue = 15
            dynamicHeight = 250
            btnFontSize = 40
            wordUnitFontSize = 25

            
         case 1024, 1194, 1112:
          //  print("ipad pro 12.9")

            dif = 1
            iPadDif = 1.5
            fontSize = 90
            cornerRadiusValue = 15
            dynamicHeight = 180
            btnFontSize = 30
            wordUnitFontSize = 20

        case 812:
          //  print("iPhone X")
            
            
            dif = 1
            iPadDif = 1
            dynamicHeight = 120
            fontSize = 55
            cornerRadiusValue = 20
            btnFontSize = 15
            wordUnitFontSize = 15


        case 736:
            
            dif = 1
            iPadDif = 1
            dynamicHeight = 120
            fontSize = 55
            cornerRadiusValue = 20
            btnFontSize = 15
            wordUnitFontSize = 15
        
        case 667:
            
            dif = 1
            iPadDif = 1
            dynamicHeight = 110
            fontSize = 50
            cornerRadiusValue = 20
            btnFontSize = 15
            wordUnitFontSize = 15
       
            
        case 568:
            
            dif = 0.8
            iPadDif = 1
            dynamicHeight = 90
            cornerRadiusValue = 20
            fontSize = 40
            btnFontSize = 15
            wordUnitFontSize = 12
        
            
        default:
            dif = 1
            iPadDif = 1
            dynamicHeight = 120
            fontSize = 55
            cornerRadiusValue = 20
            btnFontSize = 15
            wordUnitFontSize = 15
            break
         
        }
        
        courseTitleImg.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: (dynamicHeight - (90 * iPadDif * dif)) / 2, left: 20 * iPadDif * dif, bottom: 0, right: 0), size: .init(width: 90 * iPadDif * dif, height: 90 * iPadDif * dif))
        

        wordUnitLabel.textAlignment = .left
        wordUnitLabel.font = wordUnitLabel.font.withSize(wordUnitFontSize)
        wordUnitLabel.anchor(top: self.topAnchor, leading: nil, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 35 * iPadDif * dif, left: 0, bottom: 0, right: -5 * iPadDif * dif), size: .init(width: 25 * iPadDif * dif, height: 50 * iPadDif * dif))
        wordUnitLabel.text = courseVC_wordUnit
        
        wordCountOutlet.font = wordCountOutlet.font.withSize(fontSize)
        wordCountOutlet.adjustsFontSizeToFitWidth = true

        wordCountOutlet.textAlignment = .center
        wordCountOutlet.anchor(top: self.topAnchor, leading: nil, bottom: nil, trailing: wordUnitLabel.leadingAnchor, padding: .init(top: 5 * iPadDif * dif, left: 0, bottom: 0, right: 0), size: .init(width: 125 * iPadDif * dif, height: 60 * iPadDif * dif))
        
        
        enterBookBtnOutlet.anchor(top: wordCountOutlet.bottomAnchor, leading: nil, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 5 * iPadDif * dif, left: 0, bottom: 0, right: -5 * iPadDif * dif), size: .init(width: width / 4, height: dynamicHeight - 60 * iPadDif * dif - dynamicHeight / 6))

       

        enterClassBtnOutlet.anchor(top: wordCountOutlet.bottomAnchor, leading: nil, bottom: nil, trailing: enterBookBtnOutlet.leadingAnchor, padding: .init(top: 5 * iPadDif * dif, left: 0, bottom: 0, right: -10 * iPadDif * dif))
        enterClassBtnOutlet.anchorSize(to: enterBookBtnOutlet)
     
        enterClassBtnOutlet.setTitle(courseVC_enterClassBtnText, for: .normal)
        
        

        enterBookBtnOutlet.titleLabel?.font = enterBookBtnOutlet.titleLabel?.font.withSize(btnFontSize)
        
        enterBookBtnOutlet.setTitle(courseVC_enterBookBtnText, for: .normal)
        enterClassBtnOutlet.titleLabel?.font = enterClassBtnOutlet.titleLabel?.font.withSize(btnFontSize)
        
        
        
        
        enterBookBtnOutlet.layer.cornerRadius = enterBookBtnOutlet.frame.width / cornerRadiusValue
        enterClassBtnOutlet.layer.cornerRadius = enterClassBtnOutlet.frame.width / cornerRadiusValue
        
        
        
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
