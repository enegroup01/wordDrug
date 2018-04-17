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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.backgroundColor = UIColor.init(red: 179/255, green: 78/255, blue: 81/255, alpha: 1)
        collectionView.delegate = self
       
        //layOut

        stageTopImg.frame = CGRect(x: 0, y: 0, width: width, height: height * 3.8 / 19)
    
        backBtn.frame = CGRect(x: 0, y: 0, width: stageTopImg.frame.height, height: stageTopImg.frame.height)
        
        collectionView.frame = CGRect(x: 0, y: stageTopImg.frame.maxY, width: width, height: height - stageTopImg.frame.height)
        
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
        mapNumToPass = indexPath.row + 1
        
        //在此先暫時預設mapPassed...之後要寫在過關時做儲存
        //mapPassed = 4
        print("mapPassed in stage:\(mapPassed)")
        //有過地圖才能進關卡
        if mapPassed! >= indexPath.row {
    
            performSegue(withIdentifier: "toPageVc", sender: self)
        }
    
        
    }
    

    //重送地圖編號
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toPageVc"{
            let destinationVC = segue.destination as! PageViewController
             destinationVC.mapNumToReceive = mapNumToPass
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
