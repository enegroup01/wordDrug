//
//  StageCollectionViewCell.swift
//  wordDrug
//
//  Created by Ethan on 2018/8/30.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class StageColors {
    var p1Color = UIColor()
    var p2Color = UIColor()
    var p3Color = UIColor()
    var p4Color = UIColor()
    var p5Color = UIColor()
    var p6Color = UIColor()
    var p7Color = UIColor()
    var p8Color = UIColor()
    var p9Color = UIColor()
    var p10Color = UIColor()
    var p11Color = UIColor()
    var p12Color = UIColor()
    var p13Color = UIColor()
    var p14Color = UIColor()
    var p15Color = UIColor()
    var p16Color = UIColor()
    var p17Color = UIColor()
    var p18Color = UIColor()
    
    var courseReceived: Int
    
    init(courseReceived: Int) {
        self.courseReceived = courseReceived
    }
    
    
    func generateStageColors() -> [UIColor] {
        var colors: [UIColor] = []
        switch courseReceived{
            
        case 0:
            p1Color = #colorLiteral(red: 0.4835131168, green: 0.6959479451, blue: 0.9672678113, alpha: 1)
            p2Color = #colorLiteral(red: 0.3254264593, green: 0.5987953544, blue: 0.9520507455, alpha: 1)
            p3Color = #colorLiteral(red: 0.171677351, green: 0.485042274, blue: 0.8454945683, alpha: 1)
            p4Color = #colorLiteral(red: 0.1823357046, green: 0.3891383111, blue: 0.6465261579, alpha: 1)
            p5Color = #colorLiteral(red: 0.07535978407, green: 0.2388177216, blue: 0.4418726563, alpha: 1)
            p6Color = #colorLiteral(red: 0.08516461402, green: 0.1987694502, blue: 0.3399766684, alpha: 1)
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color]
        case 1:
            p1Color = #colorLiteral(red: 0.576782167, green: 0.5967310071, blue: 0.7621699572, alpha: 1)
            p2Color = #colorLiteral(red: 0.3836464286, green: 0.4086479545, blue: 0.5942692161, alpha: 1)
            p3Color = #colorLiteral(red: 0.3423787951, green: 0.3573511541, blue: 0.4969370961, alpha: 1)
            p4Color = #colorLiteral(red: 0.2806504071, green: 0.3107535243, blue: 0.5040093064, alpha: 1)
            p5Color = #colorLiteral(red: 0.2021175921, green: 0.2323105037, blue: 0.4331968129, alpha: 1)
            p6Color = #colorLiteral(red: 0.116706349, green: 0.1419489086, blue: 0.3253875375, alpha: 1)
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color]
        case 2:
            p1Color = #colorLiteral(red: 0.9708080888, green: 0.5004630685, blue: 0.6916761994, alpha: 1)
            p2Color = #colorLiteral(red: 0.900398314, green: 0.3433476985, blue: 0.5692580342, alpha: 1)
            p3Color = #colorLiteral(red: 0.7680305839, green: 0.247757107, blue: 0.4540854096, alpha: 1)
            p4Color = #colorLiteral(red: 0.7420365214, green: 0.1543829739, blue: 0.3897863626, alpha: 1)
            p5Color = #colorLiteral(red: 0.7652189732, green: 0.08062113076, blue: 0.3516367376, alpha: 1)
            p6Color = #colorLiteral(red: 0.5704482198, green: 0.003338656155, blue: 0.2327939868, alpha: 1)
            p7Color = #colorLiteral(red: 0.3448494077, green: 0.005877922289, blue: 0.1448908448, alpha: 1)
            p8Color = #colorLiteral(red: 0.233466655, green: 0.02080692723, blue: 0.1065781638, alpha: 1)
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color, p7Color, p8Color]
            
        case 3:
            p1Color = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            p2Color = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            p3Color = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            p4Color = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            p5Color = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
            p6Color = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            p7Color = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
            p8Color = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
            p9Color = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
            p10Color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            p11Color = #colorLiteral(red: 0.3137254902, green: 0.07450980392, blue: 0.03921568627, alpha: 1)
            p12Color = #colorLiteral(red: 0.3058823529, green: 0.2039215686, blue: 0.05882352941, alpha: 1)
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color, p7Color, p8Color, p9Color, p10Color, p11Color, p12Color]
        case 4:
            p1Color = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            p2Color = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            p3Color = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            p4Color = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            p5Color = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            p6Color = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
            p7Color = #colorLiteral(red: 0.1044694025, green: 0.1742056197, blue: 0.05384501217, alpha: 1)
            p8Color = #colorLiteral(red: 0.05588630746, green: 0.09319196429, blue: 0.02880459573, alpha: 1)
            p9Color = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            p10Color = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            p11Color = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            p12Color = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            p13Color = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            p14Color = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color, p7Color, p8Color, p9Color, p10Color, p11Color, p12Color, p13Color, p14Color]
        case 5:
            p1Color = #colorLiteral(red: 0.8, green: 0.8470588235, blue: 0.862745098, alpha: 1)
            p2Color = #colorLiteral(red: 0.7176470588, green: 0.7607843137, blue: 0.7764705882, alpha: 1)
            p3Color = #colorLiteral(red: 0.6392156863, green: 0.6745098039, blue: 0.6901960784, alpha: 1)
            p4Color = #colorLiteral(red: 0.5490196078, green: 0.5921568627, blue: 0.6039215686, alpha: 1)
            p5Color = #colorLiteral(red: 0.4784313725, green: 0.5058823529, blue: 0.5176470588, alpha: 1)
            p6Color = #colorLiteral(red: 0.4352941176, green: 0.5294117647, blue: 0.5411764706, alpha: 1)
            p7Color = #colorLiteral(red: 0.4117647059, green: 0.5882352941, blue: 0.6, alpha: 1)
            p8Color = #colorLiteral(red: 0.4235294118, green: 0.5490196078, blue: 0.6078431373, alpha: 1)
            p9Color = #colorLiteral(red: 0.4549019608, green: 0.4588235294, blue: 0.5647058824, alpha: 1)
            p10Color = #colorLiteral(red: 0.3254901961, green: 0.3764705882, blue: 0.4862745098, alpha: 1)
            p11Color = #colorLiteral(red: 0.6274509804, green: 0.6235294118, blue: 0.8392156863, alpha: 1)
            p12Color = #colorLiteral(red: 0.5921568627, green: 0.537254902, blue: 0.7725490196, alpha: 1)
            p13Color = #colorLiteral(red: 0.5843137255, green: 0.4509803922, blue: 0.6352941176, alpha: 1)
            p14Color = #colorLiteral(red: 0.5254901961, green: 0.2784313725, blue: 0.4745098039, alpha: 1)
            p15Color = #colorLiteral(red: 0.4588235294, green: 0.2156862745, blue: 0.3254901961, alpha: 1)
            p16Color = #colorLiteral(red: 0.3254901961, green: 0.2274509804, blue: 0.3921568627, alpha: 1)
            p17Color = #colorLiteral(red: 0.2392156863, green: 0.168627451, blue: 0.2862745098, alpha: 1)
            p18Color = #colorLiteral(red: 0.168627451, green: 0.1137254902, blue: 0.2, alpha: 1)
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color, p7Color, p8Color, p9Color, p10Color, p11Color, p12Color, p13Color, p14Color, p15Color, p16Color, p17Color, p18Color]
        case 6:
            p1Color = #colorLiteral(red: 0.6823529412, green: 0.8431372549, blue: 0.8862745098, alpha: 1)
            p2Color = #colorLiteral(red: 0.5960784314, green: 0.7921568627, blue: 0.8862745098, alpha: 1)
            p3Color = #colorLiteral(red: 0.5490196078, green: 0.662745098, blue: 0.8901960784, alpha: 1)
            p4Color = #colorLiteral(red: 0.5450980392, green: 0.5568627451, blue: 0.9215686275, alpha: 1)
            p5Color = #colorLiteral(red: 0.5490196078, green: 0.4745098039, blue: 0.8078431373, alpha: 1)
            p6Color = #colorLiteral(red: 0.6823529412, green: 0.5058823529, blue: 0.6509803922, alpha: 1)
            p7Color = #colorLiteral(red: 0.537254902, green: 0.3176470588, blue: 0.568627451, alpha: 1)
            p8Color = #colorLiteral(red: 0.4862745098, green: 0.2705882353, blue: 0.431372549, alpha: 1)
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color, p7Color, p8Color]
        case 7:
            p1Color = #colorLiteral(red: 0.3568627451, green: 0.8352941176, blue: 0.7764705882, alpha: 1)
            p2Color = #colorLiteral(red: 0.2941176471, green: 0.6705882353, blue: 0.7529411765, alpha: 1)
            p3Color = #colorLiteral(red: 0.3176470588, green: 0.4941176471, blue: 0.7333333333, alpha: 1)
            p4Color = #colorLiteral(red: 0.2666666667, green: 0.3098039216, blue: 0.7176470588, alpha: 1)
            p5Color = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.6274509804, alpha: 1)
            p6Color = #colorLiteral(red: 0.08235294118, green: 0.2549019608, blue: 0.8235294118, alpha: 1)
            p7Color = #colorLiteral(red: 0.05490196078, green: 0.2, blue: 0.6941176471, alpha: 1)
            p8Color = #colorLiteral(red: 0.05882352941, green: 0.1960784314, blue: 0.5450980392, alpha: 1)
            p9Color = #colorLiteral(red: 0.07843137255, green: 0.05490196078, blue: 0.4196078431, alpha: 1)
            p10Color = #colorLiteral(red: 0.02745098039, green: 0.05098039216, blue: 0.2745098039, alpha: 1)
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color, p7Color, p8Color, p9Color, p10Color]
        case 8:
            p1Color = #colorLiteral(red: 0.8235294118, green: 0.8, blue: 0.7882352941, alpha: 1)
            p2Color = #colorLiteral(red: 0.6941176471, green: 0.6901960784, blue: 0.6705882353, alpha: 1)
            p3Color = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
            p4Color = #colorLiteral(red: 0.6235294118, green: 0.4862745098, blue: 0.4196078431, alpha: 1)
            p5Color = #colorLiteral(red: 0.4784313725, green: 0.3215686275, blue: 0.3019607843, alpha: 1)
            p6Color = #colorLiteral(red: 0.3568627451, green: 0.231372549, blue: 0.2274509804, alpha: 1)
            p7Color = #colorLiteral(red: 0.2509803922, green: 0.1529411765, blue: 0.168627451, alpha: 1)
            p8Color = #colorLiteral(red: 0.1529411765, green: 0.09411764706, blue: 0.1098039216, alpha: 1)
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color, p7Color, p8Color]
        default:
            break
        }
        return colors
    }
}

class StageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var wordCountLabel: UILabel!
    
    @IBOutlet weak var stageLabel: UILabel!
    
    @IBOutlet weak var lockImg: UIImageView!
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    override func awakeFromNib() {
        
        var stageFontSize:CGFloat!
        var wordCountFontSize:CGFloat!
        var lockWidth:CGFloat!
        var lockHeight:CGFloat!
        var iPadDif:CGFloat!
        var dif:CGFloat!

        switch height {
            
        case 1366, 1336:
            //print("big iPad")

            stageFontSize = 180
            wordCountFontSize = 40
            lockWidth = 235.04
            lockHeight = 299.52
            iPadDif = 2
            dif = 1
           
            
        case 1024, 1194, 1112:
            //print("small iPad")
            
            stageFontSize = 160
            wordCountFontSize = 40
            lockWidth = 180.8
            lockHeight = 230.4
            iPadDif = 2
            dif = 1
      
            
        case 812:
            //print("iPhone X")

            stageFontSize = 80
            wordCountFontSize = 20
            lockWidth = 113
            lockHeight = 144
             iPadDif = 1
            dif = 1
   
        case 736:
            //print("iPhone plus")

            stageFontSize = 80
            wordCountFontSize = 20
            lockWidth = 113
            lockHeight = 144
           
            iPadDif = 1
            dif = 1
   
            
        case 667:
            //print("iPhone")

            stageFontSize = 80
            wordCountFontSize = 20
            lockWidth = 113
            lockHeight = 144
              iPadDif = 1
            dif = 1
      
        case 568:
            //print("iPhone SE")
            
            stageFontSize = 65
            wordCountFontSize = 20
            lockWidth = 101.7
            lockHeight = 129.6
            iPadDif = 1
            dif = 0.7
       
            
        default:
            
            
            stageFontSize = 80
            wordCountFontSize = 20
            lockWidth = 113
            lockHeight = 144
            iPadDif = 1
            dif = 1
            break
            
        }
        
        stageLabel.font = stageLabel.font.withSize(stageFontSize)
        stageLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: width / 6, left: width / 6, bottom: 0, right: 0), size: .init(width: width / 6, height: width / 5))
        

        wordCountLabel.font = wordCountLabel.font.withSize(wordCountFontSize)
        wordCountLabel.textAlignment = .center
        wordCountLabel.anchor(top: stageLabel.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: -7 * iPadDif * dif, left: width / 12, bottom: 0, right: 0), size: .init(width: width / 3, height: width / 20))
        //wordCountLabel.backgroundColor = .black
        wordCountLabel.adjustsFontSizeToFitWidth = true
  
        lockImg.translatesAutoresizingMaskIntoConstraints = false
        lockImg.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lockImg.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lockImg.widthAnchor.constraint(equalToConstant: lockWidth).isActive = true
        lockImg.heightAnchor.constraint(equalToConstant: lockHeight).isActive = true
        
    }
    
    func builCell(model: StageModel, indexPath: IndexPath) {
        let locks = model.locks
        let eachCellMyWordsCount = model.eachCellMyWordsCount
        let courseReceived = model.course.level.rawValue
        let elemWordsMax = model.elemWordsMax
        
        let lockImg = viewWithTag(3) as! UIImageView
//        if locks[indexPath.row] == 0 {
//            lockImg.isHidden = true
//        } else {
//            lockImg.isHidden = false
//        }
        lockImg.isHidden = locks[indexPath.row] == .unlocked
        stageLabel.adjustsFontSizeToFitWidth = true
        stageLabel.text = String(indexPath.row + 1)
        
        //cell.wordCountLabel.adjustsFontSizeToFitWidth = true

        let wordCounts = eachCellMyWordsCount[indexPath.row]
        wordCountLabel.text = "\(wordCounts) / \(elemWordsMax[indexPath.row])"

        let stageColors = StageColors(courseReceived: courseReceived)
        let colors: [UIColor] = stageColors.generateStageColors()
        backgroundColor = colors[indexPath.row % colors.count]
        
    }
    
}
