//
//  StageViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/2/21.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class StageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
      let orangeColor = UIColor.init(red: 232/255, green: 98/255, blue: 61/255, alpha: 1)
    
    //此兩數字要做動態
    var stageCount = 5
    var elemWordsMax:[Int] = [450,450,450,450,450,450,450]
    
    var courseReceived = Int()
    
    var mapNumToPass = Int()
  
    var eachCellMyWordsCount:[Int] = [0,0,0,0,0,0,0]

    
    var wordCounts = Int()
    
    //上方單字總計label
    @IBOutlet weak var topWordsNumberLabel: UILabel!
    
    @IBOutlet weak var stageTopImg: UIImageView!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var locks:[Int] = [1,1,1,1,1,1,1]
    
    var alertBg = UIImageView()
    var alertText = UILabel()
    var iknowBtn = UIButton()
    var ghostBtn = UIButton()
    var ghost2Btn = UIButton()
    
    var isClassAllPassed = false
    @IBOutlet weak var alreadyLearnedLabel: UILabel!
    
    @IBOutlet weak var wordCountsLabel: UILabel!
    @IBOutlet weak var classTitle: UIImageView!
    var dif = CGFloat()
    var yDif = CGFloat()
    var xDif = CGFloat()
    var alertY = CGFloat()
    var iknowY = CGFloat()
    override func viewDidLoad() {
        super.viewDidLoad()

   
        
        switch height {
        case 812:
            
            dif = 1.15
            yDif = 10
            xDif = 0
            
            alertY = 560
            iknowY  = 5
        case 736:
            
            dif = 1.1
            yDif = 0
            xDif = 0
            alertY = 580
            iknowY  = 0
        case 667:
            
            dif = 1
            yDif = 0
            xDif = 0
            alertY = 562
            iknowY  = 0
        case 568:
            
            dif = 0.9
            yDif = 0
            xDif = 10
            alertY = 480
            iknowY  = -5
            
        default:
            dif = 0.9
            yDif = 0
            xDif = 0
            alertY = 580
            iknowY  = 0
        }

        // Do any additional setup after loading the view.
        
        var bgColor = UIColor()
        var titleImg = String()
        
        
        
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
        default:
            break
            
            
        }
        
        
        
        
        collectionView.backgroundColor = bgColor
        collectionView.delegate = self
       
        //layOut

        stageTopImg.frame = CGRect(x: 0, y: 0, width: width, height: height * 3.8 / 19)
    
        
        
        collectionView.frame = CGRect(x: 0, y: stageTopImg.frame.maxY, width: width, height: height - stageTopImg.frame.height)
        
        
        let lightGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.58)
        ghost2Btn.frame = CGRect(x: 0, y: 0, width: width, height: stageTopImg.frame.height)
        ghost2Btn.backgroundColor = lightGray
        stageTopImg.addSubview(ghost2Btn)
        
        
        ghostBtn.frame = CGRect(x: 0, y: 0, width: width, height: height * 1.5)
        ghostBtn.backgroundColor = lightGray
        alertBg.frame = CGRect(x: (width - 237 * dif) / 2, y: height * 1 / 5, width: 237 * dif, height: 156 * dif)
        alertBg.image = UIImage(named: "reviewQuitBg2.png")

        alertText.frame = CGRect(x: 5 * dif , y: 5 * dif, width: alertBg.frame.width - 5 * dif * 2, height: alertBg.frame.height / 2)
        alertText.font = UIFont(name: "Helvetica Neue Bold", size: 26)
        alertText.textColor = .white
        alertText.text = ""
        alertText.numberOfLines = 0
        alertText.textAlignment = .center
        alertText.adjustsFontSizeToFitWidth = true
        
        alertBg.addSubview(alertText)

        //let darkRed = UIColor.init(red: 192/255, green: 40/255, blue: 75/255, alpha: 1)
        iknowBtn.frame = CGRect(x: (width - 210 * dif) / 2, y: height * 1.83 / 5, width: 210 * dif, height: 40 * dif)
        
        

        //iknowBtn.setBackgroundImage(UIImage(named:"noClassOkBtn.png"), for: .normal)
        //iknowBtn.backgroundColor = .red
        iknowBtn.titleLabel?.font = UIFont(name: "Helvetica", size: 18)
        iknowBtn.setTitle("我知道了", for: .normal)
        iknowBtn.setTitleColor(orangeColor, for: .normal)
        iknowBtn.addTarget(self, action: #selector(StageViewController.iKnowClicked), for: .touchUpInside)
        collectionView.addSubview(ghostBtn)
        collectionView.addSubview(iknowBtn)
        collectionView.addSubview(alertBg)
        collectionView.bringSubview(toFront: iknowBtn)
        
        backBtn.frame = CGRect(x: width / 20, y: height / 13 + yDif, width: 19, height: 31)
        classTitle.frame = CGRect(x: width / 5, y: height / 20 + yDif, width: 73 * dif, height: 78 * dif)
        classTitle.image = UIImage(named: titleImg)
 
        alreadyLearnedLabel.frame = CGRect(x: width / 2 - xDif, y: classTitle.frame.minY, width: 169, height: 28)
        wordCountsLabel.frame = CGRect(x: width / 2 - xDif, y: alreadyLearnedLabel.frame.maxY + 5, width: 169, height: 55)
        
        
        
        //wordCountsLabel.backgroundColor = .red
        
        removeBtns()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func iKnowClicked(){
        
        print("clicked")
        removeBtns()
    }
    
    func removeBtns(){
        backBtn.isEnabled = true
        ghost2Btn.isHidden = true
        alertBg.isHidden = true
        iknowBtn.isHidden = true
        ghostBtn.isHidden = true
        alertText.text = ""
        iknowBtn.isEnabled = false
        
        alertBg.frame.origin.y = height * 1 / 5
        iknowBtn.frame.origin.y = height * 1.83 / 5 - iknowY
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
        print("courseReceived:\(courseReceived)")
        isClassAllPassed = false
        
        //抓所有學習單字字數

        switch courseReceived {
        case 0:
            stageCount = 5
            elemWordsMax = [450,450,450,450,450]
            gamePassedDic = gamePassed!
            mapPassedInt = mapPassed!
            
        case 1:
            print("1")

            stageCount = 6
            elemWordsMax = [450,450,450,450,450,450]
            gamePassedDic = gamePassed2!
            mapPassedInt = mapPassed2!
            
            print(gamePassedDic)
            print(mapPassedInt)
            
            
        case 2:
            print("2")
            
            stageCount = 7
            elemWordsMax = [450,450,450,450,450,450,450]
            gamePassedDic = gamePassed3!
            mapPassedInt = mapPassed3!
            
            print(gamePassedDic)
            print(mapPassedInt)
        default:
            break
        }
        
        
        //mapPassed = 4
        
        for (s,u) in gamePassedDic!{
            print("2")
            
            wordCounts = s * 30 + u * 3
            
        }
        
            //下方450的數字
            switch mapPassedInt{
                
            case 0:
                eachCellMyWordsCount[0] = wordCounts
            case 1:
                print("3")
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

            default:
                break
            }
        
        locks = [1,1,1,1,1,1,1]
        
        
        if mapPassedInt == 7 {
            
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
        
        //topWordsNumberLabel.text = "\(totalWordsLearned)/2250"
            
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
                withReuseIdentifier: "stageCell", for: indexPath as IndexPath)
        

        let lockImg = cell.viewWithTag(3) as! UIImageView
        if locks[indexPath.row] == 0 {
            
            lockImg.isHidden = true
        } else {
            
            lockImg.isHidden = false
        }


        let stageLabel = cell.viewWithTag(1) as! UILabel
        stageLabel.text = String(indexPath.row + 1)
        
        let wordCountLabel = cell.viewWithTag(2) as! UILabel
        wordCountLabel.adjustsFontSizeToFitWidth = true
        
        
        //stageLabel.frame = CGRect(x: cell.frame.midX, y: cell.frame.midY, width: cell.frame.width / 4, height: cell.frame.height / 3)
        
        let wordCounts = eachCellMyWordsCount[indexPath.row]
        wordCountLabel.text = "\(wordCounts) / \(elemWordsMax[indexPath.row])"
        
       var p1Color = UIColor()
        var p2Color = UIColor()
        var p3Color = UIColor()
        var p4Color = UIColor()
        var p5Color = UIColor()
        var p6Color = UIColor()
        var p7Color = UIColor()
        var p8Color = UIColor()
        var colors = [UIColor]()
        
        //設定cell的顏色
        
        switch courseReceived{
            
        case 0:
            print("英檢初")
            p1Color = UIColor.init(red: 123/255, green: 177/255, blue: 247/255, alpha: 1)
            p2Color = UIColor.init(red: 83/255, green: 153/255, blue: 243/255, alpha: 1)
            p3Color = UIColor.init(red: 44/255, green: 124/255, blue: 216/255, alpha: 1)
            p4Color = UIColor.init(red: 47/255, green: 99/255, blue: 165/255, alpha: 1)
            p5Color = UIColor.init(red: 19/255, green: 61/255, blue: 113/255, alpha: 1)
            p6Color = UIColor.init(red: 22/255, green: 51/255, blue: 87/255, alpha: 1)
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color]
        case 1:
            print("英檢中")
            p1Color = UIColor.init(red: 147/255, green: 152/255, blue: 194/255, alpha: 1)
            p2Color = UIColor.init(red: 98/255, green: 104/255, blue: 152/255, alpha: 1)
            p3Color = UIColor.init(red: 87/255, green: 91/255, blue: 127/255, alpha: 1)
            p4Color = UIColor.init(red: 72/255, green: 79/255, blue: 129/255, alpha: 1)
            p5Color = UIColor.init(red: 52/255, green: 59/255, blue: 111/255, alpha: 1)
            p6Color = UIColor.init(red: 30/255, green: 36/255, blue: 83/255, alpha: 1)
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color]
        case 2:
            print("多益滿")
            p1Color = UIColor.init(red: 247/255, green: 128/255, blue: 176/255, alpha: 1)
            p2Color = UIColor.init(red: 230/255, green: 88/255, blue: 145/255, alpha: 1)
            p3Color = UIColor.init(red: 196/255, green: 63/255, blue: 116/255, alpha: 1)
            p4Color = UIColor.init(red: 189/255, green: 39/255, blue: 99/255, alpha: 1)
            p5Color = UIColor.init(red: 195/255, green: 20/255, blue: 90/255, alpha: 1)
            p6Color = UIColor.init(red: 146/255, green: 0/255, blue: 59/255, alpha: 1)
            p7Color = UIColor.init(red: 88/255, green: 2/255, blue: 37/255, alpha: 1)
            p8Color = UIColor.init(red: 59/255, green: 5/255, blue: 27/255, alpha: 1)
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color, p7Color, p8Color]
        default:
            break
        }
        
        /*
        let p1Color = UIColor.init(red: 246/255, green: 217/255, blue: 218/255, alpha: 1)
        
        let p2Color = UIColor.init(red: 248/255, green: 195/255, blue: 193/255, alpha: 1)
        
        let p3Color = UIColor.init(red: 248/255, green: 146/255, blue: 150/255, alpha: 1)
        
        let p4Color = UIColor.init(red: 248/255, green: 120/255, blue: 125/255, alpha: 1)
      
        let p5Color = UIColor.init(red: 220/255, green: 82/255, blue: 82/255, alpha: 1)
        
        let p6Color = UIColor.init(red: 179/255, green: 78/255, blue: 81/255, alpha: 1)
        
        let colors:[UIColor] = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color]
        */
        
       
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
        //mapPassed = 2
        print("mapPassed in stage:\(mapPassedInt)")
        //有過地圖才能進關卡
        if mapPassedInt == indexPath.row {
    
            performSegue(withIdentifier: "toLessonVc", sender: self)
        } else if mapPassedInt > indexPath.row{
            
            //show已過關訊息
            
            isClassAllPassed = true
            //openAlert(text: "此單元已全部學習完成，請選擇未完成的單元！")
            
             performSegue(withIdentifier: "toLessonVc", sender: self)
            
            
        } else if mapPassedInt < indexPath.row{
            
            openAlert(text: "此單元尚未解鎖，請加油！")
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
    
    func openAlert(text:String){
        backBtn.isEnabled = false
        alertBg.isHidden = false
        ghost2Btn.isHidden = false
        iknowBtn.isHidden = false
        ghostBtn.isHidden = false
        alertText.text = text
        iknowBtn.isEnabled = true
        

        
        let visibleCells = collectionView.visibleCells
        print(visibleCells)
        
        for cell in visibleCells {
            
            let yPos = cell.frame.origin.y
            
            
            if yPos >= CGFloat(alertY) {
                
                print("需要調整位置")
                
                if visibleCells.count == 5 {
                    
                    print("條很大")
                    alertBg.frame.origin.y  += CGFloat(200)
                    iknowBtn.frame.origin.y += CGFloat(200)
                    
                } else {
                    
                    print("小調整")
                    alertBg.frame.origin.y  += CGFloat(100)
                    iknowBtn.frame.origin.y += CGFloat(100)
                }
                
                
            }
            
            
            
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
