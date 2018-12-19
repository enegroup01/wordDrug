//
//  StageViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/2/21.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit
import ProgressHUD

class StageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    let orangeColor = UIColor.init(red: 232/255, green: 98/255, blue: 61/255, alpha: 1)
    
    //此兩數字要做動態
    //MARK: must update
    var stageCount = 5
    var elemWordsMax:[Int] = [450,450,450,450,450,450,450,450,450]
    

    
    
    var courseReceived = Int()
    
    var mapNumToPass = Int()
  //MARK: must update
    var eachCellMyWordsCount:[Int] = [0,0,0,0,0,0,0,0,0]

    var wordCounts = Int()
    
    //上方單字總計label
    @IBOutlet weak var topWordsNumberLabel: UILabel!
    
    
    @IBOutlet weak var backBtn: UIButton!

    @IBOutlet weak var collectionView: UICollectionView!
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    //MARK: must update
    //MARK: simVer 這裡要看最多有多少map
    var locks:[Int] = [1,1,1,1,1,1,1,1,1]
    
    var alertBg = UIImageView()
    var alertText = UILabel()
    var iknowBtn = UIButton()
    var isClassAllPassed = false
    
    @IBOutlet weak var alreadyLearnedLabel: UILabel!
    @IBOutlet weak var wordCountsLabel: UILabel!
    @IBOutlet weak var classTitle: UIImageView!
    var lan:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let array = Bundle.main.preferredLocalizations
        lan = array.first

        var iPadDif:CGFloat!
        var wordCountTitleLabelFontSize: CGFloat!
        var wordCountLabelFontSize: CGFloat!
        var dif = CGFloat()

        
   
        switch height {
            
        case 1366, 1336, 1112:
            print("big iPad")

            dif = 1
            iPadDif = 2
            

        
            wordCountTitleLabelFontSize = 30
            wordCountLabelFontSize = 80
   
        case 1024:
            
            print("small iPad")

            dif = 1
            iPadDif = 1.5

      
            wordCountTitleLabelFontSize = 25
            wordCountLabelFontSize = 60
           
        case 812:
            
            dif = 1.1
            iPadDif = 1
         
            wordCountTitleLabelFontSize = 20
            wordCountLabelFontSize = 45
            
        case 736:
            
            dif = 1.1
            iPadDif = 1
            
            wordCountTitleLabelFontSize = 20
            wordCountLabelFontSize = 45
  
        case 667:
            
            dif = 1
            iPadDif = 1
            
            wordCountTitleLabelFontSize = 20
            wordCountLabelFontSize = 45
       
        case 568:
            
            dif = 0.9
            iPadDif = 1
            
            wordCountTitleLabelFontSize = 20
            wordCountLabelFontSize = 45
      
        default:
            
            dif = 1.1
            iPadDif = 1
            
            wordCountTitleLabelFontSize = 20
            wordCountLabelFontSize = 45
            break
            
        }

        // Do any additional setup after loading the view.
        
        var bgColor = UIColor()
        var titleImg = String()
        
        
        //MARK: must update
        switch courseReceived{
        case 0:
          
            bgColor = UIColor.init(red: 22/255, green: 51/255, blue: 87/255, alpha: 1)
            titleImg = "block0Title.png"
        case 1:
             bgColor = UIColor.init(red: 30/255, green: 36/255, blue: 83/255, alpha: 1)
            titleImg = "block1Title.png"
        case 2:
             bgColor = UIColor.init(red: 59/255, green: 5/255, blue: 27/255, alpha: 1)
            titleImg = "block2Title.png"
        case 3:
            //color literal
            bgColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            titleImg = "block3Title.png"
        case 4:
            bgColor = #colorLiteral(red: 0.07085690866, green: 0.1181558561, blue: 0.03652065598, alpha: 1)
            titleImg = "block4Title.png"
            
        default:
            break
            
            
        }
        
  
        collectionView.backgroundColor = bgColor
        collectionView.delegate = self
       
        //MARK: layOut
        
        backBtn.anchor(top: view.safeTopAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: nil, padding: .init(top: 35 * iPadDif * dif, left: 25 * iPadDif * dif, bottom: 0, right: 0), size: .init(width: 19 * iPadDif * dif, height: 31 * iPadDif * dif))
        

        
        let topView = UIView()
        topView.backgroundColor = #colorLiteral(red: 0.1260408759, green: 0.101865299, blue: 0.1016356722, alpha: 1)
        
        self.view.addSubview(topView)
        topView.anchor(top: view.topAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: view.safeRightAnchor, size: .init(width: width, height: height / 5))
        
        

        collectionView.anchor(top: view.topAnchor, leading: view.safeLeftAnchor, bottom: view.bottomAnchor, trailing: view.safeRightAnchor, padding: .init(top: height / 5, left: 0, bottom: 0, right: 0))
        
        
        classTitle.image = UIImage(named: titleImg)
        classTitle.contentMode = .scaleAspectFill
    
        classTitle.anchor(top: view.safeTopAnchor, leading: backBtn.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15 * dif * iPadDif, left: 50 * dif * iPadDif, bottom: 0, right: 0), size: .init(width: 73 * dif * iPadDif, height: 78 * dif * iPadDif))
 
        
        alreadyLearnedLabel.font = alreadyLearnedLabel.font.withSize(wordCountTitleLabelFontSize)
        
        alreadyLearnedLabel.anchor(top: view.safeTopAnchor, leading: nil, bottom: nil, trailing: view.safeRightAnchor, padding: .init(top: 15 * dif * iPadDif, left: 0, bottom: 0, right: -20 * dif * iPadDif), size: .init(width: 100 * dif * iPadDif, height: 28 * dif * iPadDif))
        
        
        

        //wordCountsLabel.backgroundColor = .red
        wordCountsLabel.font = wordCountsLabel.font.withSize(wordCountLabelFontSize)
        wordCountsLabel.anchor(top: alreadyLearnedLabel.bottomAnchor, leading: nil, bottom: nil, trailing: view.safeRightAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -20 * dif * iPadDif), size: .init(width: 150 * dif * iPadDif, height: 55 * dif * iPadDif))
        wordCountsLabel.adjustsFontSizeToFitWidth = true
        
        self.view.bringSubview(toFront: alreadyLearnedLabel)
        self.view.bringSubview(toFront: wordCountsLabel)
        self.view.bringSubview(toFront: backBtn)
        self.view.bringSubview(toFront: classTitle)
     

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        

        return stageCount
    }
    
    //即時更新學習單字字數
    
    var gamePassedDic:[Int:Int]?
    var mapPassedInt = Int()
    
    override func viewWillAppear(_ animated: Bool) {

        var totalWordsLearned = Int()

        isClassAllPassed = false
        
        //抓所有學習單字字數


        
        //MARK: must update
        //就算user == nil, gamePassed & mapPasse都已經設定初始值了
        switch courseReceived {
        case 0:
            
            //MARK: simVersion 共有幾個關卡
            
            if lan == "zh-Hans"{
                //檢體中文
                  stageCount = 3
                 elemWordsMax = [330,330,330]
                print("檢體中文關卡數")
                
            } else {
                //其餘語言
                print("繁體中文關卡數")
                
                stageCount = 5
                elemWordsMax = [450,450,450,450,450]

            }
      
            
            gamePassedDic = gamePassed!
            mapPassedInt = mapPassed!
            
        
            
        case 1:
     

            stageCount = 6
            elemWordsMax = [450,450,450,450,450,450]
            gamePassedDic = gamePassed2!
            mapPassedInt = mapPassed2!

            
            
        case 2:
       
            
            stageCount = 7
            elemWordsMax = [450,450,450,450,450,450,450]
            gamePassedDic = gamePassed3!
            mapPassedInt = mapPassed3!
            
        case 3:
            
            
            stageCount = 9
            elemWordsMax = [450,450,450,450,450,450,450,450,450]
            gamePassedDic = gamePassed4!
            mapPassedInt = mapPassed4!
            
        case 4:
            
            
            stageCount = 8
            elemWordsMax = [450,450,450,450,450,450,450,450]
            gamePassedDic = gamePassed5!
            mapPassedInt = mapPassed5!
            
 
        default:
            break
        }
        
 
        for (s,u) in gamePassedDic!{
          
            wordCounts = s * 30 + u * 3
            
        }
        
            //下方450的數字
            switch mapPassedInt{
                
            case 0:
                eachCellMyWordsCount[0] = wordCounts
            case 1:
            
                eachCellMyWordsCount[0] = elemWordsMax[0]
                eachCellMyWordsCount[1] = wordCounts
              
            case 2:
                eachCellMyWordsCount[0] = elemWordsMax[0]
                eachCellMyWordsCount[1] = elemWordsMax[0]
                eachCellMyWordsCount[2] = wordCounts
            case 3:
                eachCellMyWordsCount[0] = elemWordsMax[0]
                eachCellMyWordsCount[1] = elemWordsMax[0]
                eachCellMyWordsCount[2] = elemWordsMax[0]
                eachCellMyWordsCount[3] = wordCounts
            case 4:
                eachCellMyWordsCount[0] = elemWordsMax[0]
                eachCellMyWordsCount[1] = elemWordsMax[0]
                eachCellMyWordsCount[2] = elemWordsMax[0]
                eachCellMyWordsCount[3] = elemWordsMax[0]
                eachCellMyWordsCount[4] = wordCounts
       
            case 5:
                eachCellMyWordsCount[0] = elemWordsMax[0]
                eachCellMyWordsCount[1] = elemWordsMax[0]
                eachCellMyWordsCount[2] = elemWordsMax[0]
                eachCellMyWordsCount[3] = elemWordsMax[0]
                eachCellMyWordsCount[4] = elemWordsMax[0]
                eachCellMyWordsCount[5] = wordCounts
            case 6:
                eachCellMyWordsCount[0] = elemWordsMax[0]
                eachCellMyWordsCount[1] = elemWordsMax[0]
                eachCellMyWordsCount[2] = elemWordsMax[0]
                eachCellMyWordsCount[3] = elemWordsMax[0]
                eachCellMyWordsCount[4] = elemWordsMax[0]
                eachCellMyWordsCount[5] = elemWordsMax[0]
                eachCellMyWordsCount[6] = wordCounts

            case 7:
                eachCellMyWordsCount[0] = elemWordsMax[0]
                eachCellMyWordsCount[1] = elemWordsMax[0]
                eachCellMyWordsCount[2] = elemWordsMax[0]
                eachCellMyWordsCount[3] = elemWordsMax[0]
                eachCellMyWordsCount[4] = elemWordsMax[0]
                eachCellMyWordsCount[5] = elemWordsMax[0]
                eachCellMyWordsCount[6] = elemWordsMax[0]
                eachCellMyWordsCount[7] = wordCounts

            case 8:
                eachCellMyWordsCount[0] = elemWordsMax[0]
                eachCellMyWordsCount[1] = elemWordsMax[0]
                eachCellMyWordsCount[2] = elemWordsMax[0]
                eachCellMyWordsCount[3] = elemWordsMax[0]
                eachCellMyWordsCount[4] = elemWordsMax[0]
                eachCellMyWordsCount[5] = elemWordsMax[0]
                eachCellMyWordsCount[6] = elemWordsMax[0]
                eachCellMyWordsCount[7] = elemWordsMax[0]
                eachCellMyWordsCount[8] = wordCounts
             

            case 9:
                eachCellMyWordsCount[0] = elemWordsMax[0]
                eachCellMyWordsCount[1] = elemWordsMax[0]
                eachCellMyWordsCount[2] = elemWordsMax[0]
                eachCellMyWordsCount[3] = elemWordsMax[0]
                eachCellMyWordsCount[4] = elemWordsMax[0]
                eachCellMyWordsCount[5] = elemWordsMax[0]
                eachCellMyWordsCount[6] = elemWordsMax[0]
                eachCellMyWordsCount[7] = elemWordsMax[0]
                eachCellMyWordsCount[8] = elemWordsMax[0]
                
                //只有最後一張地圖需要補滿數字, 其餘的地圖都用wordCounts去抓

            default:
                break
            }
        
        locks = [1,1,1,1,1,1,1,1,1]
        
        
        //test: 所有關卡的最大值, 這裡要修成 9 ..
        //MARK: simVer這裡要看簡體版最大值是什麼要做動態修改
        
        if mapPassedInt == 9 {
            
            for i in 0 ..< mapPassedInt{
                
                locks[i] = 0
                
            }
            
        } else {
        
        for i in 0 ..< mapPassedInt + 1{
            
            locks[i] = 0
            
        }
        }
        
        for c in eachCellMyWordsCount{
            totalWordsLearned += c
        }
        
        wordCountsLabel.text = String(totalWordsLearned)
        collectionView.reloadData()

    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: "stageCell", for: indexPath as IndexPath) as! StageCollectionViewCell

        let lockImg = cell.viewWithTag(3) as! UIImageView
        if locks[indexPath.row] == 0 {
            
            lockImg.isHidden = true
        } else {
            
            lockImg.isHidden = false
        }



        cell.stageLabel.text = String(indexPath.row + 1)

        //cell.wordCountLabel.adjustsFontSizeToFitWidth = true
        

        
        let wordCounts = eachCellMyWordsCount[indexPath.row]
        
        cell.wordCountLabel.text = "\(wordCounts) / \(elemWordsMax[indexPath.row])"
        
        //MARK: simVer 這裡要看課程最大值
        
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
        var colors = [UIColor]()
        
        //設定cell的顏色
        
        
        //MARK: must update
        switch courseReceived{
            
        case 0:
        
            p1Color = UIColor.init(red: 123/255, green: 177/255, blue: 247/255, alpha: 1)
            p2Color = UIColor.init(red: 83/255, green: 153/255, blue: 243/255, alpha: 1)
            p3Color = UIColor.init(red: 44/255, green: 124/255, blue: 216/255, alpha: 1)
            p4Color = UIColor.init(red: 47/255, green: 99/255, blue: 165/255, alpha: 1)
            p5Color = UIColor.init(red: 19/255, green: 61/255, blue: 113/255, alpha: 1)
            p6Color = UIColor.init(red: 22/255, green: 51/255, blue: 87/255, alpha: 1)
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color]
        case 1:

            p1Color = UIColor.init(red: 147/255, green: 152/255, blue: 194/255, alpha: 1)
            p2Color = UIColor.init(red: 98/255, green: 104/255, blue: 152/255, alpha: 1)
            p3Color = UIColor.init(red: 87/255, green: 91/255, blue: 127/255, alpha: 1)
            p4Color = UIColor.init(red: 72/255, green: 79/255, blue: 129/255, alpha: 1)
            p5Color = UIColor.init(red: 52/255, green: 59/255, blue: 111/255, alpha: 1)
            p6Color = UIColor.init(red: 30/255, green: 36/255, blue: 83/255, alpha: 1)
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color]
        case 2:
          
            p1Color = UIColor.init(red: 247/255, green: 128/255, blue: 176/255, alpha: 1)
            p2Color = UIColor.init(red: 230/255, green: 88/255, blue: 145/255, alpha: 1)
            p3Color = UIColor.init(red: 196/255, green: 63/255, blue: 116/255, alpha: 1)
            p4Color = UIColor.init(red: 189/255, green: 39/255, blue: 99/255, alpha: 1)
            p5Color = UIColor.init(red: 195/255, green: 20/255, blue: 90/255, alpha: 1)
            p6Color = UIColor.init(red: 146/255, green: 0/255, blue: 59/255, alpha: 1)
            p7Color = UIColor.init(red: 88/255, green: 2/255, blue: 37/255, alpha: 1)
            p8Color = UIColor.init(red: 59/255, green: 5/255, blue: 27/255, alpha: 1)
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
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color, p7Color, p8Color, p9Color, p10Color]
            
        case 4:
            
            p1Color = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            p2Color = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            p3Color = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            p4Color = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            p5Color = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            p6Color = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
            p7Color = #colorLiteral(red: 0.1044694025, green: 0.1742056197, blue: 0.05384501217, alpha: 1)
            p8Color = #colorLiteral(red: 0.05588630746, green: 0.09319196429, blue: 0.02880459573, alpha: 1)
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color, p7Color, p8Color]
        default:
            break
        }
        cell.backgroundColor = colors[indexPath.row % colors.count]
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: width / 2, height: width / 2)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //傳送地圖數字
        mapNumToPass = indexPath.row
        
        //在此先暫時預設mapPassed...之後要寫在過關時做儲存
     
        //有過地圖才能進關卡
        if mapPassedInt == indexPath.row {
    
            performSegue(withIdentifier: "toLessonVc", sender: self)
            
        } else if mapPassedInt > indexPath.row{
            
            //show已過關訊息
            
            isClassAllPassed = true
            
             performSegue(withIdentifier: "toLessonVc", sender: self)
            
            
        } else if mapPassedInt < indexPath.row{
     
             ProgressHUD.showError("要先學完前面的單元喔，請加油！")
    
          
        }
    
        
    }
    


    //重送地圖編號
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toLessonVc"{
            let destinationVC = segue.destination as! LessonViewController
            
            destinationVC.courseReceived = courseReceived
             destinationVC.mapNumToReceive = mapNumToPass
            
            
            destinationVC.isClassAllPassed = isClassAllPassed

        }
    }
    
    
   

}
