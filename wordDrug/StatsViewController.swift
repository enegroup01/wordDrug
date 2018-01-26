//
//  StatsViewController.swift
//  wordDrug
//
//  Created by Ethan on 2017/12/15.
//  Copyright © 2017年 playplay. All rights reserved.
//

import UIKit

//選擇所使用的寵物
var pet : [String:Any]?
var petOriginal : [String:Any]?

class StatsViewController: UIViewController {
    
    @IBOutlet weak var statsBg: UIImageView!
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petHpLabel: UILabel!
    @IBOutlet weak var petAttLabel: UILabel!
    @IBOutlet weak var petDefLabel: UILabel!
    @IBOutlet weak var petHitLabel: UILabel!
    @IBOutlet weak var petHealLabel: UILabel!
    @IBOutlet weak var petMagLabel: UILabel!
    @IBOutlet weak var petAva: UIImageView!
    @IBOutlet weak var classTitleLabel: UILabel!
    @IBOutlet weak var petLevLabel: UILabel!
    @IBOutlet weak var wordsAmountLabel: UILabel!
    @IBOutlet weak var wordsFinishedAmountLabel: UILabel!
    @IBOutlet weak var wordsFinishedPerLabel: UILabel!
    @IBOutlet weak var wordsWrongAmountLabel: UILabel!
    @IBOutlet weak var wordsFavAmountLabel: UILabel!
    
    //螢幕觸碰位置
    var location = CGPoint()
    
    
    //獲得寵物背景
    var darkBg = UIImageView()
    //提示OK按鈕
    var hintButton = UIButton()
    //光束
    let movingLight = UIImageView()
    let movingLight2 = UIImageView()


    //partOne所有寵物
    let partOnePets:[[String:Any]] = [["petId":"1-1-0","petName":"幼龍","petHp":110,"petAtt":40,"petDef":10,"petHit":20,"petHeal":0,"petType":"","petImg":"1-1-0","petMag":0], ["petId":"1-1-10","petName":"球球","petHp":120,"petAtt":50,"petDef":15,"petHit":25,"petHeal":0,"petType":"","petImg":"1-1-10","petMag":0], ["petId":"1-2-10","petName":"螳螂拳","petHp":130,"petAtt":60,"petDef":15,"petHit":15,"petHeal":0,"petType":"","petImg":"1-2-10","petMag":0],["petId":"1-3-10","petName":"蘑菇怪","petHp":165,"petAtt":60,"petDef":15,"petHit":23,"petHeal":0,"petType":"","petImg":"1-3-10","petMag":0], ["petId":"1-4-10","petName":"劇毒狼","petHp":140,"petAtt":70,"petDef":20,"petHit":25,"petHeal":0,"petType":"","petImg":"1-4-10","petMag":0], ["petId":"1-6-10","petName":"銀翼飛馬","petHp":150,"petAtt":70,"petDef":20,"petHit":20,"petHeal":0,"petType":"","petImg":"1-6-10","petMag":0], ["petId":"1-7-10","petName":"恐龍博士","petHp":180,"petAtt":75,"petDef":22.5,"petHit":28,"petHeal":0,"petType":"","petImg":"1-7-10","petMag":0], ["petId":"1-8-10","petName":"冰雪犀牛","petHp":160,"petAtt":80,"petDef":25,"petHit":25,"petHeal":0,"petType":"","petImg":"1-8-10","petMag":0], ["petId":"1-9-10","petName":"美洲豹","petHp":195,"petAtt":90,"petDef":22.5,"petHit":18,"petHeal":0,"petType":"","petImg":"1-9-10","petMag":0], ["petId":"1-11-10","petName":"治癒菇神","petHp":170,"petAtt":90,"petDef":25,"petHit":20,"petHeal":0,"petType":"","petImg":"1-11-10","petMag":0], ["petId":"1-12-10","petName":"眼鏡蛇王","petHp":180,"petAtt":100,"petDef":30,"petHit":15,"petHeal":0,"petType":"","petImg":"1-12-10","petMag":0], ["petId":"1-13-10","petName":"被感染的劇毒狼","petHp":210,"petAtt":105,"petDef":30,"petHit":28,"petHeal":0,"petType":"","petImg":"1-13-10","petMag":0]]
    

    //有抓到的元素資訊儲存於此
    var allGetElements = [String]()
    var allGetElemsInfo = [[String:String]()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //抓userDefault判定目前是哪個探索點
        let decodedObject = UserDefaults.standard.object(forKey: "gamePassed") as? NSData
        
        if let decoded = decodedObject {
            gamePassed = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int : Int]
        }

        //自由設定
        //gamePassed = [7:6]
        
        //抓本機曾經儲存的寵物
        pet = UserDefaults.standard.object(forKey: "pet") as? [String : Any]
        
        print(pet)
        
        //先做好背景後隱藏
        darkBg.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        darkBg.image = UIImage(named: "darkBg.png")
        darkBg.isHidden = true
        view.addSubview(darkBg)
        //做好光束後隱藏
        movingLight.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.width)
        movingLight.image = UIImage(named: "movingLight.png")
        darkBg.addSubview(movingLight)
        
        movingLight2.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.width)
        movingLight2.image = UIImage(named: "movingLight.png")
        darkBg.addSubview(movingLight2)
        
        
        //檢查有沒有寵物
        if pet != nil {
            
            
            //抓該寵物原始數值存放到petOriginal裡
            let originalPetId = pet!["petId"] as! String
            for i in 0 ..< partOnePets.count{
                
                if let id = partOnePets[i]["petId"] as? String{
                    
                    if originalPetId == id {
                        
                        petOriginal = partOnePets[i]
                        
                    }
                    
                }
            }

            
            print("has pet")
            //有的話就顯示之前預選的寵物
            showPetInfo()
            
        } else {
            //送第一隻pet, 並指定好pet的資訊

            print("no pet")
            
            //指定第一隻
        
            //指定好第一隻送的寵物
            pet = partOnePets[0]
            petOriginal = partOnePets[0]
            
            //儲存本機已選擇的寵物
            UserDefaults.standard.set(pet, forKey: "pet")
        
            //儲存的變數
            let petId = pet!["petId"] as! String
            let id = user?["id"] as! String
            
            //抓user所擁有的pet, 避免重複getPet
            let petsOwned = user?["petsOwned"] as! String
            var petsOwnedArray = petsOwned.components(separatedBy: ";")
            petsOwnedArray.removeLast()
            

            if !petsOwnedArray.contains(petId){
                //儲存到後端
                getPet(id: id, petId: petId)
            }
            
            //開始動畫
            darkBg.isHidden = false
            
            //獲得寵物字樣
            
            let getPetTitle = UILabel()
            getPetTitle.textColor = .yellow
            getPetTitle.textAlignment = .center
            getPetTitle.font = UIFont(name: "Helvetica Bold", size: 36)
            getPetTitle.text = "獲得寵物"
            getPetTitle.backgroundColor = .clear
            getPetTitle.frame = CGRect(x: 110, y: 383, width: 150, height: 60)
            darkBg.addSubview(getPetTitle)
            
            //閃光動畫
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = 0.0
            rotateAnimation.toValue = CGFloat(.pi * 2.0)
            rotateAnimation.duration = 100.0
            
            rotateAnimation.repeatCount = Float.infinity

            let rotateAnimation2 = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation2.fromValue = 0.0
            rotateAnimation2.toValue = CGFloat(.pi * -2.0)
            rotateAnimation2.duration = 120.0
            rotateAnimation2.repeatCount = Float.infinity
            
            
            //緩一點點做光束動畫
            let when = DispatchTime.now() + 0.1
            DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                self!.movingLight.layer.add(rotateAnimation, forKey: nil)
                self!.movingLight2.layer.add(rotateAnimation2, forKey: nil)
      
            })


            //顯示寵物圖片名字
            let petAvaImg = pet?["petImg"] as! String
            let petName = pet?["petName"] as! String

            //暫時獲得的Ava圖
            let tempPetAva = UIImageView()
            tempPetAva.frame = CGRect(x: 81, y: 190, width: 200, height: 200)
            tempPetAva.image = UIImage(named: petAvaImg)
            darkBg.addSubview(tempPetAva)
            
            //暫時的寵物title
            let tempPetTitle = UILabel()
            tempPetTitle.frame = CGRect(x: 110, y: 420, width: 150, height: 60)
            tempPetTitle.textColor = .white
            tempPetTitle.font = UIFont(name: "Helvetica Bold", size: 30)
            tempPetTitle.textAlignment = .center
            tempPetTitle.text = petName
            darkBg.addSubview(tempPetTitle)
            
            //恭喜Label
            let congratsImg = UIImageView()
            congratsImg.frame = CGRect(x: 40, y: 120, width: 300, height: 142)
            congratsImg.image = UIImage(named: "congrat.png")
            darkBg.addSubview(congratsImg)
            

            //做按鈕
            hintButton = UIButton(type: .system)
            hintButton.frame = CGRect(x: 130, y: 510, width: 100, height: 30)
            hintButton.setTitle("知道了", for: .normal)
            hintButton.backgroundColor = .brown

            hintButton.tintColor = .white
            hintButton.addTarget(self, action: #selector(StatsViewController.removeDarkBg), for: .touchUpInside)
            hintButton.layer.cornerRadius = hintButton.frame.width / 20
            
            self.view.addSubview(hintButton)
            
        }

    }
    
    //上傳得到的寵物
    func getPet(id:String,petId:String){
        
        // url to access our php file
        let url = URL(string: "http://ec2-52-199-122-149.ap-northeast-1.compute.amazonaws.com/wordDrug/getPet.php")!
        
        // request url
        var request = URLRequest(url: url)
        
        // method to pass data POST - cause it is secured
        request.httpMethod = "POST"
        
        // body gonna be appended to url
        let body = "userID=\(id)&getPet=\(petId)"
        
        // append body to our request that gonna be sent
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {[weak self] data, response, error in
            // no error
            if error == nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    guard let parseJSON = json else {
                        print("Error while parsing")
                        //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                        return
                    }
                    
                    //再次儲存使用者資訊
                    UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                    user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                                        
                    
                } catch{
                    
                    print("catch error")
                    
                    
                }
            } else {
                
                print("urlsession has error")
                
            }
        }).resume()
        
    }
    
    
    @objc func removeDarkBg(){
        
        darkBg.removeFromSuperview()
        hintButton.removeFromSuperview()
        
        showPetInfo()

    }
    
    func showPetInfo(){
        
        //抓所有寵物資訊
        let petAvaImg = pet!["petImg"] as! String
        let petHpValue = pet!["petHp"] as! Int
        let petAttValue = pet!["petAtt"] as! Int
        //let petDefValue = pet!["petDef"] as! Int
        
        if let petDefValue = pet!["petDef"] {
        
        petDefLabel.text = String(describing: petDefValue)
        }
        
        let petHealValue = pet!["petHeal"] as! Int
        let petTypeValue = pet!["petType"] as! String
        let petHitValue = pet!["petHit"] as! Int
        let petName = pet!["petName"] as! String
        let petMagValue = pet!["petMag"] as! Int
        
        petHealLabel.textColor = .white
        petAttLabel.textColor = .white
        petDefLabel.textColor = .white
        petHealLabel.textColor = .white
        petHpLabel.textColor = .white
        petHitLabel.textColor = .white
        petMagLabel.textColor = .white
        
        //顯示出來
        petAva.image = UIImage(named: petAvaImg)
        petHpLabel.text = String(petHpValue)
        petAttLabel.text = String(petAttValue)
        petHealLabel.text = String(petHealValue)
        petNameLabel.text = petName
        petHitLabel.text = String(petHitValue)
        petMagLabel.text = String(describing: petMagValue)
        

        //寵物上下動的動畫
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat,.autoreverse], animations: { [weak self] in
            
            self!.petAva.frame.origin.y = 87

        }, completion: nil)
        
         getPetValue()
        
    }
    
    
    @IBAction func enterMapClick(_ sender: Any) {
        
        performSegue(withIdentifier: "toMap", sender: self)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            location = touch.location(in: self.view)
            
            if petAva.frame.contains(location){
                
                performSegue(withIdentifier: "toAllPetsVc", sender: self)
            }
            
            
        }
        
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //即時更新寵物資訊
        
        //有的話就顯示之前預選的寵物
        showPetInfo()
        
    }
    
    
    
    //計算寵物數值的func
    func getPetValue(){
        
        //抓數值, 之後這個數值要從一個可以固定及升級改數值的地方抓數字過來.
        //寵物資訊重置
        //pet = petOriginal
        
        let petHpValue = pet!["petHp"] as! Int
        let petAttValue = pet!["petAtt"] as! Int
      
        if let petDefValue = pet!["petDef"] {
            
            petDefLabel.text = String(describing: petDefValue)
        }
     
        let petHealValue = pet!["petHeal"] as! Int
        //let petTypeValue = pet!["petType"] as! String
        let petHitValue = pet!["petHit"] as! Int
        let petMagValue = pet!["petMag"] as! Int
        
        /*
         let petCure = pet?["petHeal"] as! Int
         let petLife = pet?["petLife"] as! Int
         let petAttack = pet?["petAttack"] as! Int
         let petDefense = pet?["petDefense"] as! Int
         let petDouble = pet?["petDoubleAttack"] as! Int
         let petExtra = pet?["petExtraAttack"] as! Int
         */
        petHealLabel.text = String(describing: petHealValue)
        petHpLabel.text = String(describing: petHpValue)
        petAttLabel.text = String(describing: petAttValue)
        petHitLabel.text = String(describing: petHitValue) + "%"
        petMagLabel.text = String(describing: petMagValue)
        
        //顏色先重置白色
        petHpLabel.textColor = .white
        petAttLabel.textColor = .white
        petDefLabel.textColor = .white
        petMagLabel.textColor = .white
        petHitLabel.textColor = .white
        petHealLabel.textColor = .white
        //還有元素圖未寫
        
        
        // 機制: 這裡的數字不改, 每一次都check selOccupied有沒有任何值會影響
        
        //抓數字
        /*
        for s in 0 ..< elemSaved!.count{
            
            //加數值上去
            if elemSaved![s] > -1 {
                
                let index = elemSaved![s]
                let selElem = allGetElemsInfo[index]
                
                if let function = selElem["f"] as String?{
                    
                    switch function{
                        
                    case "hp":
                        
                        petHpLabel.textColor = .green
                        petHpLabel.text = String(petHpValue + Int(selElem["v"]!)!)
                        pet?["petHp"] = Int(petHpValue + Int(selElem["v"]!)!)
                        
                        
                    case "att":
                        petAttLabel.textColor = .green
                        petAttLabel.text = String(petAttValue + Int(selElem["v"]!)!)
                        pet?["petAtt"] = Int(petAttValue + Int(selElem["v"]!)!)
                        
                    case "def":
                        petDefLabel.textColor = .green
                        petDefLabel.text = String(petDefValue + Int(selElem["v"]!)!)
                        pet?["petDef"] = Int(petDefValue + Int(selElem["v"]!)!)
                        
                        
                    case "hit":
                        petHitLabel.textColor = .green
                        petHitLabel.text = String(petHitValue + Int(selElem["v"]!)!) + "%"
                        pet?["petHit"] = Int(petHitValue + Int(selElem["v"]!)!)
                        
                        
                    case "heal":
                        petHealLabel.textColor = .green
                        petHealLabel.text = String(petHealValue + Int(selElem["v"]!)!)
                        pet?["petHeal"] = Int(petHealValue + Int(selElem["v"]!)!)
                        
                    case "wood":
                        
                        petMagLabel.textColor = .green
                        petMagLabel.text = String(petMagValue + Int(selElem["v"]!)!)
                        pet?["petMag"] = Int(petMagValue + Int(selElem["v"]!)!)
                        
                        pet?["petType"] = "wood"
                        
                        //petTypeImg.image = UIImage(named: "wood.png")
                        
                        
                    case "earth":
                        
                        petMagLabel.textColor = .green
                        petMagLabel.text = String(petMagValue + Int(selElem["v"]!)!)
                        pet?["petMag"] = Int(petMagValue + Int(selElem["v"]!)!)
                        pet?["petType"] = "earth"
                        
                        //petTypeImg.image = UIImage(named: "earth.png")
                        
                        
                    case "water":
                        
                        
                        petMagLabel.textColor = .green
                        petMagLabel.text = String(petMagValue + Int(selElem["v"]!)!)
                        pet?["petMag"] = Int(petMagValue + Int(selElem["v"]!)!)
                        pet?["petType"] = "water"
                        
                        //petTypeImg.image = UIImage(named: "water.png")
                        
                    case "fire":
                        
                        
                        
                        petMagLabel.textColor = .green
                        petMagLabel.text = String(petMagValue + Int(selElem["v"]!)!)
                        pet?["petMag"] = Int(petMagValue + Int(selElem["v"]!)!)
                        pet?["petType"] = "fire"
                        //petTypeImg.image = UIImage(named: "fire.png")
                        
                        
                    case "metal":
                        
                        
                        petMagLabel.textColor = .green
                        petMagLabel.text = String(petMagValue + Int(selElem["v"]!)!)

                        pet?["petMag"] = Int(petMagValue + Int(selElem["v"]!)!)
                        pet?["petType"] = "metal"
                        
                        //petTypeImg.image = UIImage(named: "metal.png")
                        
                        
                    case "upgrade":
                        break
                    default:
                        break
                        
                        
                    }
                    
                }
                
            }
            
        }
        */
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
