//
//  StageViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/2/21.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class StageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let stageCount = 5
    var mapNumToPass = Int()
    var elemWordsMax = [450,450,450,450,450]
    var eachCellMyWordsCount = [0,0,0,0,0]
    var totalWordsLearned = Int()
    
    var wordCounts = Int()
    
    //上方單字總計label
    @IBOutlet weak var topWordsNumberLabel: UILabel!
    
    @IBOutlet weak var stageTopImg: UIImageView!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var locks = [1,1,1,1,1]
    
    var alertBg = UIImageView()
    var alertText = UILabel()
    var iknowBtn = UIButton()
    var ghostBtn = UIButton()
    var ghost2Btn = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        var dif = CGFloat()
        
        switch height {
        case 812:
            
            dif = 1.15
            
        case 736:
            
            dif = 1.1
            
            
        case 667:
            
            dif = 1
            
            
        case 568:
            
            dif = 0.9
            
            
        default:
            break
            
        }

        // Do any additional setup after loading the view.
        collectionView.backgroundColor = UIColor.init(red: 179/255, green: 78/255, blue: 81/255, alpha: 1)
        collectionView.delegate = self
       
        //layOut

        stageTopImg.frame = CGRect(x: 0, y: 0, width: width, height: height * 3.8 / 19)
    
        backBtn.frame = CGRect(x: 0, y: 0, width: stageTopImg.frame.height, height: stageTopImg.frame.height)
        
        collectionView.frame = CGRect(x: 0, y: stageTopImg.frame.maxY, width: width, height: height - stageTopImg.frame.height)
        
        
        let lightGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.58)
        ghost2Btn.frame = CGRect(x: 0, y: 0, width: width, height: stageTopImg.frame.height)
        ghost2Btn.backgroundColor = lightGray
        stageTopImg.addSubview(ghost2Btn)
        
        
        
        ghostBtn.frame = CGRect(x: 0, y: 0, width: width, height: height)
        ghostBtn.backgroundColor = lightGray
        alertBg.frame = CGRect(x: (width - 237 * dif) / 2, y: height * 1 / 5, width: 237 * dif, height: 156 * dif)
        alertBg.image = UIImage(named: "noClassAlertBg.png")

        alertText.frame = CGRect(x: 5 * dif , y: 5 * dif, width: alertBg.frame.width - 5 * dif * 2, height: alertBg.frame.height / 2)
        alertText.font = UIFont(name: "Helvetica Neue Bold", size: 26)
        alertText.textColor = .white
        alertText.text = ""
        alertText.numberOfLines = 0
        alertText.textAlignment = .center
        alertText.adjustsFontSizeToFitWidth = true
        
        alertBg.addSubview(alertText)

             let darkRed = UIColor.init(red: 192/255, green: 40/255, blue: 75/255, alpha: 1)
        iknowBtn.frame = CGRect(x: (width - 150 * dif) / 2, y: height * 1.75 / 5, width: 150 * dif, height: 36 * dif)
        iknowBtn.setBackgroundImage(UIImage(named:"noClassOkBtn.png"), for: .normal)
        iknowBtn.setTitle("我知道了", for: .normal)
        iknowBtn.setTitleColor(darkRed, for: .normal)
        iknowBtn.addTarget(self, action: #selector(StageViewController.iKnowClicked), for: .touchUpInside)
        collectionView.addSubview(ghostBtn)
        collectionView.addSubview(iknowBtn)
        collectionView.addSubview(alertBg)
        collectionView.bringSubview(toFront: iknowBtn)
 
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
        
        
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        

        return stageCount
    }
    
    //即時更新學習單字字數
    override func viewWillAppear(_ animated: Bool) {
        
        //抓所有學習單字字數

        


        //mapPassed = 4
        
        for (s,u) in gamePassed!{
            
            wordCounts = s * 30 + u * 3
            
        }
        
        
            
            switch mapPassed!{
                
            case 0:
                eachCellMyWordsCount[0] = wordCounts
            case 1:
                eachCellMyWordsCount[0] = 450
                eachCellMyWordsCount[1] = wordCounts
              
            case 2:
                eachCellMyWordsCount[0] = 450
                eachCellMyWordsCount[1] = 450
                eachCellMyWordsCount[2] = wordCounts
            case 3:
                eachCellMyWordsCount[0] = 450
                eachCellMyWordsCount[1] = 450
                eachCellMyWordsCount[2] = 450
                eachCellMyWordsCount[3] = wordCounts
            case 4:
                eachCellMyWordsCount[0] = 450
                eachCellMyWordsCount[1] = 450
                eachCellMyWordsCount[2] = 450
                eachCellMyWordsCount[3] = 450
                eachCellMyWordsCount[4] = wordCounts
       
            default:
                break
            }
        
        locks = [1,1,1,1,1]
        
        for i in 0 ..< mapPassed! + 1{
            
            locks[i] = 0
            
        }
        
        for c in eachCellMyWordsCount{
            totalWordsLearned += c
            
        }
        
        topWordsNumberLabel.text = "\(totalWordsLearned)/2250"
            
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
        wordCountLabel.text = "\(wordCounts) / 450"
        
       
        //設定cell的顏色
         let p1Color = UIColor.init(red: 246/255, green: 217/255, blue: 218/255, alpha: 1)
          let p2Color = UIColor.init(red: 248/255, green: 195/255, blue: 193/255, alpha: 1)
          let p3Color = UIColor.init(red: 248/255, green: 146/255, blue: 150/255, alpha: 1)
          let p4Color = UIColor.init(red: 248/255, green: 120/255, blue: 125/255, alpha: 1)
          let p5Color = UIColor.init(red: 220/255, green: 82/255, blue: 82/255, alpha: 1)
          let p6Color = UIColor.init(red: 179/255, green: 78/255, blue: 81/255, alpha: 1)
         let colors:[UIColor] = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color]
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
        print("mapPassed in stage:\(mapPassed)")
        //有過地圖才能進關卡
        if mapPassed! == indexPath.row {
    
            performSegue(withIdentifier: "toLessonVc", sender: self)
        } else if mapPassed! > indexPath.row{
            
            //show已過關訊息
            
            openAlert(text: "此單元已全部學習完成，請選擇未完成的單元！")
            
            
        } else if mapPassed! < indexPath.row{
            
            openAlert(text: "此單元尚未解鎖，請加油！")
        }
    
        
    }
    

    //重送地圖編號
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toLessonVc"{
            let destinationVC = segue.destination as! LessonViewController
            
            
             destinationVC.mapNumToReceive = mapNumToPass
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
