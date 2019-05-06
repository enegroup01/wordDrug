//
//  BookTableViewCell.swift
//  wordDrug
//
//  Created by Ethan on 2018/4/20.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
      let bookVC_slideToLeft = NSLocalizedString("bookVC_slideToLeft", comment: "")

    @IBOutlet weak var chiWordLabel: UILabel!
    @IBOutlet weak var engWordLabel: UILabel!
    
    let width =  UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    @IBOutlet weak var chiSenLabel: UILabel!
    @IBOutlet weak var engSenLabel: UILabel!
    @IBOutlet weak var syllableLabel: UILabel!
    
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var partOfSpeechLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        var dif = CGFloat()
        var fontDif:CGFloat!
        var widthDif:CGFloat!
        var iPhoneXHeightDif:CGFloat!
        var hintLabelWidthDif: CGFloat!
        switch height {
            
            
        case 1366, 1336:

            dif = 2
            fontDif = 2
            widthDif = 1.5
            iPhoneXHeightDif = 1
            hintLabelWidthDif = 1
            
        case 1024, 1194, 1112:
            
            dif = 1.5
            fontDif = 1.5
            widthDif = 1.5
            iPhoneXHeightDif = 1
            hintLabelWidthDif = 1
        case 812:
            

            dif = 0.7
            fontDif = 1
            widthDif = 1.5
            iPhoneXHeightDif = 1.5
            hintLabelWidthDif = 1.3
     
            
        case 736:

            dif = 0.7
            fontDif = 1
            widthDif = 1.7
            iPhoneXHeightDif = 1.5
            hintLabelWidthDif = 1.3
        
            
        case 667:
            
         
            dif = 0.7
            fontDif = 1
            widthDif = 1.5
            iPhoneXHeightDif = 1.5
            hintLabelWidthDif = 1.3
            
        case 568:


      
            dif = 0.6
            fontDif = 1
            widthDif = 1.4
            iPhoneXHeightDif = 1.5
            hintLabelWidthDif = 1.3
        default:
            
            dif = 0.7
            fontDif = 1
            widthDif = 1.5
            iPhoneXHeightDif = 1.5
            hintLabelWidthDif = 1.3
            break
            
        }

        syllableLabel.translatesAutoresizingMaskIntoConstraints = false
        syllableLabel.widthAnchor.constraint(equalToConstant: 60 * dif).isActive = true
        syllableLabel.heightAnchor.constraint(equalToConstant: 20 * dif * iPhoneXHeightDif).isActive = true
        syllableLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        syllableLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        syllableLabel.font = syllableLabel.font.withSize(15 * fontDif)
        syllableLabel.textAlignment = .center
        syllableLabel.adjustsFontSizeToFitWidth = true
        
        
        engWordLabel.frame = CGRect(x: 75 * dif, y: 3, width: 250 * dif * widthDif, height: 35 * dif * iPhoneXHeightDif)

        partOfSpeechLabel.frame = CGRect(x: engWordLabel.frame.minX, y: engWordLabel.frame.maxY, width: 30 * dif * widthDif, height: 20 * dif * iPhoneXHeightDif)
        engSenLabel.frame = CGRect(x: engWordLabel.frame.minX, y: partOfSpeechLabel.frame.maxY, width: 250 * dif * widthDif, height: 35 * dif * iPhoneXHeightDif)
        chiSenLabel.frame = CGRect(x: engWordLabel.frame.minX, y: engSenLabel.frame.maxY, width: 200 * dif * widthDif, height: 30 * dif * iPhoneXHeightDif)
        chiSenLabel.numberOfLines = 0
        
        chiWordLabel.frame = CGRect(x: partOfSpeechLabel.frame.maxX, y: engWordLabel.frame.maxY, width: 200 * dif * widthDif, height: 20 * dif * iPhoneXHeightDif)
        //partOfSpeechLabel.backgroundColor = .red
        partOfSpeechLabel.adjustsFontSizeToFitWidth = true
        

        
        hintLabel.frame = CGRect(x: width - (80 * dif * hintLabelWidthDif), y: engWordLabel.frame.minY, width: 70 * dif * hintLabelWidthDif, height: 21 * dif * iPhoneXHeightDif)
        
        hintLabel.adjustsFontSizeToFitWidth = true
        hintLabel.text = bookVC_slideToLeft
        

        /*
        engWordLabel.backgroundColor = .red
        chiWordLabel.backgroundColor = .green
        partOfSpeechLabel.backgroundColor = .purple
        engSenLabel.backgroundColor = .blue
        chiSenLabel.backgroundColor = .yellow
        syllableLabel.backgroundColor = .green
        hintLabel.backgroundColor = .green
 */
    
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
