//
//  StageViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/2/21.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class StageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let stageCount = 5
    var mapNumToPass = Int()
    
    //上方單字總計label
    @IBOutlet weak var topWordsNumberLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.backgroundColor = UIColor.init(red: 179/255, green: 78/255, blue: 81/255, alpha: 1)
        collectionView.delegate = self
        
        topWordsNumberLabel.text = "1073/2100"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        

        return stageCount
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
        wordCountLabel.text = "0 / 420"
        
       
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //傳送地圖數字
        mapNumToPass = indexPath.row + 1
        
        //在此先暫時預設mapPassed...之後要寫在過關時做儲存
        mapPassed = 4
        
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
