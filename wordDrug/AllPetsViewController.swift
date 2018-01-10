//
//  AllPetsViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/1/8.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class AllPetsViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var allPetsView: UICollectionView!
    
    //partOne所有寵物
    let partOnePets:[[String:Any]] = [["petId":"1-1-0","petName":"幼龍","petHp":110,"petAtt":40,"petDef":10,"petHit":20,"petHeal":0,"petType":"","petImg":"1-1-0","petMag":0], ["petId":"1-1-10","petName":"球球","petHp":120,"petAtt":50,"petDef":15,"petHit":25,"petHeal":0,"petType":"","petImg":"1-1-10","petMag":0], ["petId":"1-2-10","petName":"螳螂拳","petHp":130,"petAtt":60,"petDef":15,"petHit":15,"petHeal":0,"petType":"","petImg":"1-2-10","petMag":0],["petId":"1-3-10","petName":"蘑菇怪","petHp":165,"petAtt":60,"petDef":15,"petHit":23,"petHeal":0,"petType":"","petImg":"1-3-10","petMag":0], ["petId":"1-4-10","petName":"劇毒狼","petHp":140,"petAtt":70,"petDef":20,"petHit":25,"petHeal":0,"petType":"","petImg":"1-4-10","petMag":0], ["petId":"1-6-10","petName":"銀翼飛馬","petHp":150,"petAtt":70,"petDef":20,"petHit":20,"petHeal":0,"petType":"","petImg":"1-6-10","petMag":0], ["petId":"1-7-10","petName":"恐龍博士","petHp":180,"petAtt":75,"petDef":22.5,"petHit":28,"petHeal":0,"petType":"","petImg":"1-7-10","petMag":0], ["petId":"1-8-10","petName":"冰雪犀牛","petHp":160,"petAtt":80,"petDef":25,"petHit":25,"petHeal":0,"petType":"","petImg":"1-8-10","petMag":0], ["petId":"1-9-10","petName":"美洲豹","petHp":195,"petAtt":90,"petDef":22.5,"petHit":18,"petHeal":0,"petType":"","petImg":"1-9-10","petMag":0], ["petId":"1-11-10","petName":"治癒菇神","petHp":170,"petAtt":90,"petDef":25,"petHit":20,"petHeal":0,"petType":"","petImg":"1-11-10","petMag":0], ["petId":"1-12-10","petName":"眼鏡蛇王","petHp":180,"petAtt":100,"petDef":30,"petHit":15,"petHeal":0,"petType":"","petImg":"1-12-10","petMag":0], ["petId":"1-13-10","petName":"被感染的劇毒狼","petHp":210,"petAtt":105,"petDef":30,"petHit":28,"petHeal":0,"petType":"","petImg":"1-13-10","petMag":0]]

    //所有擁有的寵物
    var owned = [Int]()
    //蓋住背景
    let ghost = UIButton()
    //對話視窗
    let dialogueView = UIView()
    
    let goldColor = UIColor.init(red: 254/255, green: 223/255, blue: 48/255, alpha: 1)
    
    //抓cell裡面的indexPath.row
    var buttonIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //底層 - 寵物 - cover - 上下黑banner - 字及按鈕
        
        //背景
        allPetsView.backgroundColor = .clear
        
        //  讀全部寵物, 以及玩家擁有的寵物, 然後在cellForRow裡做分類
        
        //抓user所擁有的pet, 避免重複getPet
        let petsOwned = user?["petsOwned"] as! String
        var petsOwnedArray = petsOwned.components(separatedBy: ";")
        petsOwnedArray.removeLast()
        
        
        for i in 0 ..< partOnePets.count{
            
            //先append每個位置
            owned.append(0)
            
            //檢查有或沒有, 有的給予值1
            if let petId = partOnePets[i]["petId"] as! String?{
                
                if petsOwnedArray.contains(petId){
                    
                    owned[i] = 1
                } else {
                    
                    owned[i] = 0

                }
                
            }
            
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return partOnePets.count
    }
    
    
    
    // 每個 cell 要顯示的內容
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            
            let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: "allPetsCell", for: indexPath as IndexPath)
            
            let petAva = cell.viewWithTag(1) as! UIImageView
            let coverBg = cell.viewWithTag(2) as! UIImageView
            let petNameLabel = cell.viewWithTag(3) as! UILabel
            let useBtn = cell.viewWithTag(4) as! UIButton
            
 
            //做Btn的tag來找正確的index
            useBtn.tag = indexPath.row
            useBtn.addTarget(self, action: #selector(AllPetsViewController.useBtnClicked), for: .touchUpInside)
            
            petAva.contentMode = .scaleAspectFit
            petNameLabel.adjustsFontSizeToFitWidth = true
            
            //顯示圖片及名字
            if let petImg = partOnePets[indexPath.row]["petImg"] as! String?{
                if let petName = partOnePets[indexPath.row]["petName"] as! String?{

                    //擁有的
                    if owned[indexPath.row] == 1 {
                    
                    petAva.image = UIImage(named: petImg)
                    
                    //尚未解鎖的
                    } else {
                        petAva.image = UIImage(named: "lockedPet.png")

                    }
                    petNameLabel.text = petName
                }
            }
            
            //確認是否有擁有此寵物
            
            if owned[indexPath.row] == 0 {
                //沒有的話
                useBtn.setImage(UIImage(named:"lockButton.png"), for: .normal)
                //useBtn.isUserInteractionEnabled = false
                coverBg.isHidden = false
                
            } else {
                //有的話
                useBtn.setImage(UIImage(named:"useButton.png"), for: .normal)
                useBtn.isUserInteractionEnabled = true
                coverBg.isHidden = true
            }


            return cell
    }
    

    
   @objc func useBtnClicked(sender:UIButton) {
    
    //抓按鈕的index
    buttonIndex = sender.tag

    //假如按的是有的
    if owned[buttonIndex] == 1 {

    //做一個檔selElem的ghost button
    ghost.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    ghost.backgroundColor = .darkGray
    ghost.alpha = 0.2
    self.view.addSubview(ghost)
    
    
    //跳出對話視窗
    dialogueView.frame = CGRect(x: 65, y: 200, width: 250, height: 230)
    dialogueView.backgroundColor = .black
    //dialogueView.alpha = 0.7
    self.view.addSubview(dialogueView)
    
    //做寵物的照片
    let petAvaUse = UIImageView()
    petAvaUse.frame = CGRect(x: 80, y: 10, width: 100, height: 100)
    petAvaUse.contentMode = .scaleAspectFit
    petAvaUse.alpha = 1
    if let petAva = partOnePets[buttonIndex]["petImg"] as! String?{
        
        petAvaUse.image = UIImage(named: petAva)
    }

    dialogueView.addSubview(petAvaUse)
    
    //做寵物的名字
    let petNameUse = UILabel()
    petNameUse.frame = CGRect(x: 50, y: 105, width: 150, height: 25)
    petNameUse.font = UIFont(name: "Helvetica Bold", size: 16)
    petNameUse.adjustsFontSizeToFitWidth = true
    petNameUse.textColor = .cyan
    petNameUse.textAlignment = .center

    if let petName = partOnePets[buttonIndex]["petName"] as! String?{
        
        petNameUse.text = petName
        
    }
    dialogueView.addSubview(petNameUse)
    
    //設定一些字的顏色
    let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor : goldColor]
    let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor : UIColor.white]
    let attrs3 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor : UIColor.red]
    let attrs4 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor : UIColor.green]
    
    //Hp
    let petHpUse = UILabel()
    petHpUse.frame = CGRect(x: 20, y: 130, width: 100, height: 20)
    petHpUse.font = UIFont(name: "Helvetica Bold", size: 14)
    petHpUse.adjustsFontSizeToFitWidth = true
    petHpUse.textAlignment = .left
    if let petHp = partOnePets[buttonIndex]["petHp"] as! Int?{
        let petHp1 = NSMutableAttributedString(string:"生命值: ", attributes:attrs1)
        let petHp2 = NSMutableAttributedString(string:  String(petHp), attributes:attrs2)
        petHp1.append(petHp2)
        petHpUse.attributedText = petHp1
    }
    dialogueView.addSubview(petHpUse)
   
    //Att
    let petAttUse = UILabel()
    petAttUse.frame = CGRect(x: 20, y: 150, width: 100, height: 20)
    petAttUse.font = UIFont(name: "Helvetica Bold", size: 14)
    petAttUse.adjustsFontSizeToFitWidth = true
    petAttUse.textAlignment = .left
    if let petAtt = partOnePets[buttonIndex]["petAtt"] as! Int?{

        let petAtt1 = NSMutableAttributedString(string:"攻擊力: ", attributes:attrs1)
        let petAtt2 = NSMutableAttributedString(string:  String(petAtt), attributes:attrs2)
        petAtt1.append(petAtt2)
        petAttUse.attributedText = petAtt1
        
    }
    dialogueView.addSubview(petAttUse)
    
    //def
    let petDefUse = UILabel()
    petDefUse.frame = CGRect(x: 20, y: 170, width: 100, height: 20)
    petDefUse.font = UIFont(name: "Helvetica Bold", size: 14)
    petDefUse.adjustsFontSizeToFitWidth = true
    petDefUse.textAlignment = .left
    if let petDef = partOnePets[buttonIndex]["petDef"]{

        let petDef1 = NSMutableAttributedString(string:"防禦力: ", attributes:attrs1)
        let petDef2 = NSMutableAttributedString(string:  String(describing: petDef), attributes:attrs2)
        petDef1.append(petDef2)
        petDefUse.attributedText = petDef1
    }
    dialogueView.addSubview(petDefUse)

    //hit
    let petHitUse = UILabel()
    petHitUse.frame = CGRect(x: 120, y: 130, width: 100, height: 20)
    petHitUse.font = UIFont(name: "Helvetica Bold", size: 14)
    petHitUse.adjustsFontSizeToFitWidth = true
    petHitUse.textAlignment = .left
    if let petHit = partOnePets[buttonIndex]["petHit"] as! Int?{
        
       
        let petHit1 = NSMutableAttributedString(string:"爆擊率: ", attributes:attrs3)
        let petHit2 = NSMutableAttributedString(string:  String(petHit), attributes:attrs2)
        let petHit3 = NSMutableAttributedString(string:"%", attributes: attrs2)
        petHit1.append(petHit2)
        petHit1.append(petHit3)
        petHitUse.attributedText = petHit1
        
    }
    dialogueView.addSubview(petHitUse)

    //heal
    let petHealUse = UILabel()
    petHealUse.frame = CGRect(x: 120, y: 150, width: 100, height: 20)
    petHealUse.font = UIFont(name: "Helvetica Bold", size: 14)
    petHealUse.adjustsFontSizeToFitWidth = true

    petHealUse.textAlignment = .left
    if let petHeal = partOnePets[buttonIndex]["petHeal"] as! Int?{
        
        let petHeal1 = NSMutableAttributedString(string:"治癒: ", attributes:attrs4)
        let petHeal2 = NSMutableAttributedString(string:  String(petHeal), attributes:attrs2)
        petHeal1.append(petHeal2)
        petHealUse.attributedText = petHeal1
        
    }
    dialogueView.addSubview(petHealUse)

    //ok按鈕
    let okBtn = UIButton(type: .system)
    okBtn.frame = CGRect(x: 130, y: 200, width: 70, height: 20)
    okBtn.setTitle("確定", for: .normal)
    okBtn.setTitleColor(.white, for: .normal)
    okBtn.backgroundColor = .purple
    okBtn.layer.cornerRadius = okBtn.frame.width / 20
    okBtn.addTarget(self, action: #selector(AllPetsViewController.okClicked), for: .touchUpInside)
    dialogueView.addSubview(okBtn)
    
    //取消按鈕
    let cancelBtn = UIButton(type: .system)
    cancelBtn.frame = CGRect(x: 55, y: 200, width: 70, height: 20)
    cancelBtn.setTitle("取消", for: .normal)
    cancelBtn.setTitleColor(.white, for: .normal)
    cancelBtn.backgroundColor = .darkGray
    cancelBtn.layer.cornerRadius = cancelBtn.frame.width / 20
    cancelBtn.addTarget(self, action: #selector(AllPetsViewController.cancelClicked), for: .touchUpInside)
    dialogueView.addSubview(cancelBtn)

    }else {
        
        
        //做一個檔selElem的ghost button
        ghost.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        ghost.backgroundColor = .darkGray
        ghost.alpha = 0.2
        self.view.addSubview(ghost)
        
        
        //跳出對話視窗
        dialogueView.frame = CGRect(x: 65, y: 200, width: 250, height: 230)
        dialogueView.backgroundColor = .black
        //dialogueView.alpha = 0.7
        self.view.addSubview(dialogueView)
        
        
        //做鎖定的怪畫面
        let petAvaUse = UIImageView()
        petAvaUse.frame = CGRect(x: 80, y: 10, width: 100, height: 100)
        petAvaUse.contentMode = .scaleAspectFit
        petAvaUse.alpha = 1
        petAvaUse.image = UIImage(named: "lockedPet.png")
        dialogueView.addSubview(petAvaUse)
        
        //訊息
        let petNameUse = UILabel()
        petNameUse.frame = CGRect(x: 50, y: 120, width: 150, height: 25)
        petNameUse.font = UIFont(name: "Helvetica Bold", size: 16)
        petNameUse.adjustsFontSizeToFitWidth = true
        petNameUse.textColor = .cyan
        petNameUse.textAlignment = .center
        petNameUse.text = "怪物尚未解鎖"
        dialogueView.addSubview(petNameUse)

        
        //取消按鈕
        let cancelBtn = UIButton(type: .system)
        cancelBtn.frame = CGRect(x: 90, y: 160, width: 70, height: 20)
        cancelBtn.setTitle("OK", for: .normal)
        cancelBtn.setTitleColor(.white, for: .normal)
        cancelBtn.backgroundColor = .darkGray
        cancelBtn.layer.cornerRadius = cancelBtn.frame.width / 20
        cancelBtn.addTarget(self, action: #selector(AllPetsViewController.cancelClicked), for: .touchUpInside)
        dialogueView.addSubview(cancelBtn)
        
        
    }
    }
    
    @objc func okClicked(){
        
        
        //儲存寵物, 跳回上頁
        pet = partOnePets[buttonIndex]
        petOriginal = pet
        UserDefaults.standard.set(pet, forKey: "pet")
        self.dismiss(animated: false, completion: nil)
        
        //把所有elem歸零, 比較合理
        exactElemSaved = [[-1:-1],[-1:-1],[-1:-1]]
        
        //儲存elemSaved
        let userDefaults = UserDefaults.standard
        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: exactElemSaved!)
        userDefaults.set(encodedObject, forKey: "exactElemSaved")
        userDefaults.synchronize()
    }
    
    @objc func cancelClicked(){
        
        //移除對話框
        ghost.removeFromSuperview()
        for subview in dialogueView.subviews{
            subview.removeFromSuperview()
        }
        dialogueView.removeFromSuperview()
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        //跳出不做任何事
        self.dismiss(animated: false, completion: nil)
    }
    
}
