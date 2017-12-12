//
//  PetViewController.swift
//  wordDrug
//
//  Created by Ethan on 2017/11/27.
//  Copyright © 2017年 playplay. All rights reserved.
//

import UIKit

var pet : NSMutableDictionary?
var petElems : NSMutableDictionary?
var elemSaved : [Int]?


class PetViewController: UIViewController {
    
    @IBOutlet weak var petAva: UIImageView!
    @IBOutlet weak var selElem1Img: UIImageView!
    @IBOutlet weak var selElem2Img: UIImageView!
    @IBOutlet weak var selElem3Img: UIImageView!
    @IBOutlet weak var petInfoBg: UIImageView!
    @IBOutlet weak var petTitle: UILabel!
    @IBOutlet weak var petLevelLabel: UILabel!
    @IBOutlet weak var petLifeLabel: UILabel!
    @IBOutlet weak var petAttackLabel: UILabel!
    @IBOutlet weak var petExtraAttackLabel: UILabel!
    @IBOutlet weak var petDoubleAttackLabel: UILabel!
    @IBOutlet weak var petDefenseLabel: UILabel!
    @IBOutlet weak var petCureLabel: UILabel!
    @IBOutlet weak var elementBg: UIImageView!
    @IBOutlet weak var elem1: UIImageView!
    @IBOutlet weak var elem2: UIImageView!
    @IBOutlet weak var elem3: UIImageView!
    @IBOutlet weak var elem4: UIImageView!
    @IBOutlet weak var elem5: UIImageView!
    @IBOutlet weak var elem6: UIImageView!
    @IBOutlet weak var elem7: UIImageView!
    @IBOutlet weak var elem8: UIImageView!
    @IBOutlet weak var elem9: UIImageView!
    @IBOutlet weak var elem10: UIImageView!
    @IBOutlet weak var elem11: UIImageView!
    @IBOutlet weak var elem12: UIImageView!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var petTypeImg: UIImageView!
    
    @IBOutlet weak var playNowBtn: UIButton!
    
    @IBOutlet weak var hintBtn: UIButton!
    
    var location = CGPoint()
    //畫面上所有元素
    var elems = [UIImageView]()
    //記憶所有元素的原始位置
    var elemCgPoints = [CGPoint]()
    //碰觸到的元素
    var touchedElem = UIImageView()
    //記憶碰觸到元素的原始位置
    var originalPosition = CGPoint()
    //畫面上選項的元素
    var selElems = [UIView]()
    //暫時抓正確位置
    var selElemsCgs = [[35,258],[100.5,258],[164.5,258]]
    
    //目前選到的元素Index
    var currentElemIndex = -1
    //紀錄三個選項元素的數字
    var selOccupiedByElemIndex = [-1,-1,-1]
    
    //元素註解
    let elemInfoBg = UIView()
    let elemInfoAva = UIImageView()
    let elemTitleLabel = UILabel()
    let elemInfoLabel = UILabel()
    
    //元素屬性數值
    let elements = [["n":"ab1","f":"hp","v":"50"],["n":"ac1","f":"att","v":"20"],["n":"ad1","f":"def","v":"5"],["n":"a_e1","f":"hit","v":"2"],["n":"af1","f":"heal","v":"10"],["n":"ai1","f":"wood","v":"10"],["n":"al1","f":"earth","v":"10"],["n":"am1","f":"water","v":"10"],["n":"an1","f":"fire","v":"10"],["n":"any1","f":"upgrade","v":"101"]]
    
    //有抓到的元素資訊儲存於此
    var allGetElements = [String]()
    var allGetElemsInfo = [[String:String]()]
    
    var functionChinese = [String]()
    var titleChinese = [String]()
    var values = [String]()
    
    //接收spot&unitNumber來判斷怪的屬性
    var spotNumber = Int()
    var unitNumber = Int()
    
    //暫時使用的單字
    var wordSets = [String]()
    
    //怪物資訊
    var monsters = [["id":101,"name":"毛毛蟲","hp":100,"att":35,"def":10,"magic":0,"type":"wood"],
                    ["id":201,"name":"蘑菇怪","hp":100,"att":40,"def":10,"magic":0,"type":"earth"],
                    ["id":301,"name":"球球","hp":100,"att":40,"def":10,"magic":0,"type":"water"],
                    ["id":401,"name":"史帝奇","hp":150,"att":50,"def":15,"magic":0,"type":"fire"],
                    ["id":501,"name":"青螳螂","hp":150,"att":50,"def":15,"magic":0,"type":"metal"],
                    ["id":601,"name":"被污染的鹿","hp":150,"att":50,"def":15,"magic":0,"type":"wood"],
                    ["id":701,"name":"田鼠","hp":200,"att":60,"def":20,"magic":0,"type":"earth"],
                    ["id":801,"name":"涡蝙蝠","hp":200,"att":60,"def":20,"magic":0,"type":"water"],
                    ["id":901,"name":"鬍狗","hp":200,"att":60,"def":20,"magic":0,"type":"fire"],
                    ["id":1001,"name":"鋼牙鯊","hp":300,"att":70,"def":30,"magic":10,"type":"metal"]]
    var monsterHp = Int()
    var monsterAtt = Int()
    var monsterDef = Int()
    var monsterMagic = Int()
    var monsterType = String()
    
    //提示怪物屬性畫面
    let hintView = UIView()
    let ghostButton = UIButton()
    
    
    //目前單字的順位
    var currentWordSequence = 0
    
    //是否要準備進入比賽
    var isReadyToEnterBattle = Bool()
    
    //是否可以按元素
    var isElementTouchable = Bool()
    
    var hintText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //寵物大頭照
        petAva.image = UIImage(named: "401.png")
        
        //使用的元素
        let selElemImage = UIImage(named: "selElem.png")
        selElem1Img.image = selElemImage
        selElem2Img.image = selElemImage
        selElem3Img.image = selElemImage
        
        //寵物資訊背景
        petInfoBg.image = UIImage(named: "petInfoBg.png")
        
        //抓使用者得到的元素
        let getElemets = user?["getElement"] as! String
        
        //做成新的array
        allGetElements = getElemets.components(separatedBy: ";")
        
        //移除最後一個空白值, 以目前寫法來說會分出一個空的""
        allGetElements.removeLast()
        
        //元素列表背景
        elementBg.image = UIImage(named: "elemBg.png")
        
        //加入元素
        elems.append(elem1)
        elems.append(elem2)
        elems.append(elem3)
        elems.append(elem4)
        elems.append(elem5)
        elems.append(elem6)
        elems.append(elem7)
        elems.append(elem8)
        elems.append(elem9)
        elems.append(elem10)
        elems.append(elem11)
        elems.append(elem12)
        
        //抓有得到的元素, append他們的資訊
        for i in 0 ..< allGetElements.count{
            if let name = allGetElements[i] as String?{
                
                //直接拿元素來做圖片
                elems[i].image = makeImage(name: name)
                
                for e in 0 ..< elements.count{
                    if let n = elements[e]["n"] as String?{
                        if n == name{
                            
                            allGetElemsInfo.append(elements[e])
                            
                        }
                        
                    }
                    
                }
                
            }
        }
        
        allGetElemsInfo.remove(at: 0)
        print(allGetElemsInfo)
        
        
        //加入元素位置, 固定原本位置使用
        elemCgPoints.append(elem1.center)
        elemCgPoints.append(elem2.center)
        elemCgPoints.append(elem3.center)
        elemCgPoints.append(elem4.center)
        elemCgPoints.append(elem5.center)
        elemCgPoints.append(elem6.center)
        elemCgPoints.append(elem7.center)
        elemCgPoints.append(elem8.center)
        elemCgPoints.append(elem9.center)
        elemCgPoints.append(elem10.center)
        elemCgPoints.append(elem11.center)
        elemCgPoints.append(elem12.center)
        
        //加入選項元素UIView為了彌補位置錯誤
        
        let sel1 = UIView()
        sel1.frame.size = CGSize(width: 55, height: 55)
        sel1.center = CGPoint(x: 35, y: 258)
        self.view.addSubview(sel1)
        
        let sel2 = UIView()
        sel2.frame.size = CGSize(width: 55, height: 55)
        sel2.center = CGPoint(x: 100.5, y: 258)
        self.view.addSubview(sel2)
        
        let sel3 = UIView()
        sel3.frame.size = CGSize(width: 55, height: 55)
        sel3.center = CGPoint(x: 164.5, y: 258)
        self.view.addSubview(sel3)
        
        selElems.append(sel1)
        selElems.append(sel2)
        selElems.append(sel3)
        
        //做註解View
        elemInfoBg.backgroundColor = .black
        elemInfoBg.alpha = 0
        elemInfoBg.frame = CGRect(x: 100, y: 90, width: 200, height: 100)
        elemInfoBg.layer.cornerRadius = elemInfoBg.frame.width / 50
        self.view.addSubview(elemInfoBg)
        
        //註解裡元素圖
        elemInfoAva.frame = CGRect(x: 10, y: 10, width: 80, height: 80)
        elemInfoBg.addSubview(elemInfoAva)
        
        //註解title
        elemTitleLabel.textColor = .cyan
        elemTitleLabel.font = UIFont(name: "Helvetica Bold", size: 15)
        elemTitleLabel.text = ""
        elemTitleLabel.frame = CGRect(x: 90, y: 3, width: 100, height: 50)
        elemInfoBg.addSubview(elemTitleLabel)
        
        //註解Info
        elemInfoLabel.textColor = .white
        elemInfoLabel.font = UIFont(name: "Helvetica Bold", size: 15)
        elemInfoLabel.text = ""
        elemInfoLabel.frame = CGRect(x: 90, y: 25, width: 120, height: 50)
        elemInfoLabel.adjustsFontSizeToFitWidth = true
        elemInfoBg.addSubview(elemInfoLabel)
        
        //設定寵物資訊
        /*
         petCureLabel.text = "0"
         petLifeLabel.text = "100"
         petAttackLabel.text = "40"
         petDefenseLabel.text = "10"
         petDoubleAttackLabel.text = "20%"
         petExtraAttackLabel.text = "0"
         */
        
        //設定寵物數值
        pet = ["petLife":100,"petAttack":40,"petDefense":10,"petDoubleAttack":20,"petExtraAttack":0,"petHeal":0,"petType":""]
        
        fetchElementInfo()
        
        //指定之前所存檔的使用元素
        if elemSaved == nil {
            
            elemSaved = selOccupiedByElemIndex
            
        } else {
            
            selOccupiedByElemIndex = elemSaved!
        }
        
        //顯示
        let when = DispatchTime.now() + 0.1
        
        DispatchQueue.main.asyncAfter(deadline: when) {[weak self] in
            for s in 0 ..< self!.selOccupiedByElemIndex.count{
                
                if self!.selOccupiedByElemIndex[s] != -1 {
                    
                    //固定元素在選項裡
                    
                    self!.elems[self!.selOccupiedByElemIndex[s]].frame.size = CGSize(width: 60, height: 60)
                    self!.elems[self!.selOccupiedByElemIndex[s]].center = CGPoint(x: self!.selElemsCgs[s][0], y: self!.selElemsCgs[s][1])
                    
                }
                
            }
        }
        //計算寵物數值
        calculatePetValue()
        
        playNowBtn.isHidden = true
        hintBtn.isHidden = true
        
        if isReadyToEnterBattle{
        showHint()
        }
    }
    
    //快速抓圖片
    func makeImage(name:String) ->UIImage{
        let image = UIImage(named: name + ".png")
        return image!
    }
    
    
    
    @objc func dismissHintButton(){
        
        hintView.removeFromSuperview()
        ghostButton.removeFromSuperview()
        
        //開啟元素按鍵
        isElementTouchable = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playNowClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toGame", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toGame" {
            
            let destinationVC = segue.destination as! GameViewController
            destinationVC.spotNumber = spotNumber
            destinationVC.unitNumber = unitNumber
        }
        
    }
    

    
    func showHint(){

            
            playNowBtn.isHidden = false
            hintBtn.isHidden = false
            
            //建立不可按鍵蓋背景
            
            ghostButton.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            ghostButton.backgroundColor = .black
            ghostButton.alpha = 0.5
            self.view.addSubview(ghostButton)
            
            
            //建立提示對話框
            hintView.frame = CGRect(x: 80, y: 300, width: 200, height: 130)
            hintView.backgroundColor = .black
            hintView.alpha = 1
            hintView.layer.zPosition = 6
            
            self.view.addSubview(hintView)
            
            
            //建立提示標題
            let hintTitle = UILabel()
            hintTitle.font = UIFont(name: "Helvetica Bold", size: 20)
            hintTitle.adjustsFontSizeToFitWidth = true
            hintTitle.text = "[ 提示 ]"
            hintTitle.textColor = .cyan
            hintTitle.frame = CGRect(x: 10, y: -20, width: 180, height: 80)
            hintTitle.textAlignment = .center
            hintView.addSubview(hintTitle)
            
            let coverPurple = UIColor.init(red: 98/255, green: 44/255, blue: 85/255, alpha: 1)
            
            //建立提示按鈕
            let hintButton = UIButton(type: .system)
            hintButton.frame = CGRect(x: 80, y: 90, width:40, height: 20)
            hintButton.backgroundColor = coverPurple
            hintButton.setTitle("OK", for: .normal)
            hintButton.addTarget(self, action: #selector(PetViewController.dismissHintButton), for: .touchUpInside)
            hintButton.tintColor = .white
            hintButton.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 14)
            hintView.addSubview(hintButton)
            
            //抓正確unit
            currentWordSequence = 3 * unitNumber
            
            //讀取Bundle裡的文字檔, 為了抓怪物的屬性
            var wordFile:String?
            
            let name = "1-" + String(spotNumber + 1)
            
            if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
                do {
                    wordFile = try String(contentsOfFile: filepath)
                    let words = wordFile?.components(separatedBy: "; ")
                    
                    //把字讀取到wordSets裡
                    wordSets = words!
                    //print(contents)
                    
                    //找目前sequence的英文+中文字
                    let halfCount = wordSets.count / 2
                    let monsterId = wordSets[halfCount + currentWordSequence]
                    let monsterIdInt = Int(monsterId)
                    var monsterName = String()
                    
                    
                    //抓monster資訊
                    for monster in monsters{
                        
                        if monsterIdInt == monster["id"] as! Int{
                            monsterName = monster["name"] as! String
                            monsterType = monster["type"] as! String
                            monsterHp = monster["hp"] as! Int
                            monsterAtt = monster["att"] as! Int
                            monsterMagic = monster["magic"] as! Int
                            
                            
                            var elementSuggest = String()
                            var fontColorSuggest = UIColor()
                            
                            
                            //再做一個判斷怪屬性攻擊倍數的switch
                            switch monsterType{
                                
                            case "wood":
                                elementSuggest = "metal"
                                fontColorSuggest = .yellow
                                
                            case "earth":
                                
                                elementSuggest = "wood"
                                fontColorSuggest = .orange
                                
                            case "water":
                                
                                elementSuggest = "earth"
                                fontColorSuggest = .brown
                                
                            case "fire":
                                elementSuggest = "water"
                                fontColorSuggest = .blue
                                
                                
                            case "metal":
                                
                                elementSuggest = "fire"
                                fontColorSuggest = .red
                                
                            default:
                                break
                                
                            }
                            
                            //建立提示文字
                            let hintText = UILabel()
                            hintText.font = UIFont(name: "Helvetica Bold", size: 14)
                            hintText.adjustsFontSizeToFitWidth = true
                            hintText.text = "此元素怪物為\(monsterType)屬性，建議裝備\(elementSuggest)元素"
                            hintText.textColor = .white
                            hintText.frame = CGRect(x: 10, y: 15, width: 180, height: 80)
                            hintText.textAlignment = .center
                            hintText.numberOfLines = 2
                            hintView.addSubview(hintText)
                            
                            
                            
                        }
                    }
                    
                } catch {
                    // contents could not be loaded
                }
            } else {
                // example.txt not found!
            }
        
        
        
        
    }
    
    @IBAction func hintClicked(_ sender: Any) {
        
        showHint()
        //關閉元素按鍵
        isElementTouchable = false
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            location = touch.location(in: self.view)
            
            //都沒碰到元素的話就隱藏info
            elemInfoBg.alpha = 0
            
            if isElementTouchable{
                
                //跑所有元素
                for e in  0 ..< elems.count{
                    
                    if elems[e].image != nil {
                        
                        //有碰到元素的話
                        if elems[e].frame.contains(location){
                            
                            //抓title
                            let title = titleChinese[e]
                            elemTitleLabel.text = "Lv1 " + title
                            
                            //抓能力值
                            let function = functionChinese[e]
                            
                            //讓爆擊率＋%
                            if function == "爆擊率" {
                                elemInfoLabel.text = function + " +\(values[e])%"
                            } else {
                                elemInfoLabel.text = function + " +\(values[e])"
                                
                            }
                            
                            //顯示元素照片
                            let elemAva = elems[e].image
                            elemInfoAva.image = elemAva
                            elemInfoBg.alpha = 0.8
                            
                            //確認e是否為occupied當中的index, 是的話把數字還原-1,讓其可以繼續填入其他元素
                            //解釋：確認所按到的元素是不是已經在使用當中的, 是的話就移除index
                            switch e {
                            case selOccupiedByElemIndex[0]:
                                selOccupiedByElemIndex[0] = -1
                                elemSaved![0] = -1
                                
                            case selOccupiedByElemIndex[1]:
                                selOccupiedByElemIndex[1] = -1
                                elemSaved![1] = -1
                                
                            case selOccupiedByElemIndex[2]:
                                selOccupiedByElemIndex[2] = -1
                                elemSaved![2] = -1
                                
                            default:
                                break
                            }
                            
                            //指定該元素的原始位置
                            originalPosition = elemCgPoints[e]
                            //移動
                            //elems[e].center = location
                            //指定該元素
                            touchedElem = elems[e]
                            //指定該元素Index
                            currentElemIndex = e
                            
                            //假如按兩次就回原位
                            //基本上只要有回原位就要計算寵物數值
                            if touch.tapCount == 2{
                                
                                touchedElem.frame.size = CGSize(width: 80, height: 80)
                                touchedElem.center = originalPosition
                                elemInfoBg.alpha = 0
                                
                                //計算寵物數值
                                calculatePetValue()
                                
                            }
                            
                        }
                    }
                }
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            location = touch.location(in: self.view)
            //移動元素
            touchedElem.center = location
            
        }
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            location = touch.location(in: self.view)
            
            //Part 1. 首先先讓元素回原位
            touchedElem.frame.size = CGSize(width: 80, height: 80)
            touchedElem.center = originalPosition
            
            //放掉手指就不顯示info
            elemInfoBg.alpha = 0
            
            //計算寵物數值
            calculatePetValue()
            
            //Part 2. 下方假如元素有碰到選項, 就移至選項位置
            
            if touch.tapCount < 2{
                
                //跑所有的選項元素
                for s in 0 ..< selElems.count{
                    
                    //假如碰到了其中之一
                    if selElems[s].frame.contains(location){
                        
                        //***假如選項上有元素的話才啟動以下改變及計分機制***
                        if touchedElem.image != nil{
                            
                            //先檢查有沒有任何元素
                            if selOccupiedByElemIndex[s] != -1 {
                                
                                //之前的元素回原位
                                let preElem = elems[selOccupiedByElemIndex[s]]
                                preElem.frame.size = CGSize(width: 80, height: 80)
                                preElem.center = elemCgPoints[selOccupiedByElemIndex[s]]
                                
                                //要回到-1
                                selOccupiedByElemIndex[s] = -1
                                elemSaved![s] = -1
                                
                            }
                            //沒有的話固定元素在選項裡
                            touchedElem.frame.size = CGSize(width: 60, height: 60)
                            touchedElem.center = CGPoint(x: selElemsCgs[s][0], y: selElemsCgs[s][1])
                            
                            //因為有碰到所以設定數字
                            
                            selOccupiedByElemIndex[s] = currentElemIndex
                            
                            elemSaved![s] = currentElemIndex
                            
                            //計算寵物數值
                            calculatePetValue()
                            
                        }
                    }
                }
                
            }
            
            //初始化剛指定的element
            touchedElem = UIImageView()
        }
    }
    
    //抓取元素資訊
    func fetchElementInfo(){
        
        //準備元素資訊供顯示
        for i in 0 ..< allGetElemsInfo.count{
            
            if let functions = allGetElemsInfo[i]["f"] as String?{
                
                switch functions{
                    
                case "hp":
                    titleChinese.append("魔法元素")
                    functionChinese.append("血量")
                case "att":
                    titleChinese.append("魔法元素")
                    functionChinese.append("攻擊力")
                case "def":
                    titleChinese.append("魔法元素")
                    functionChinese.append("防禦力")
                case "hit":
                    titleChinese.append("魔法元素")
                    functionChinese.append("爆擊率")
                case "heal":
                    titleChinese.append("魔法元素")
                    functionChinese.append("治癒")
                case "wood":
                    titleChinese.append("屬性元素")
                    functionChinese.append("木屬性魔攻")
                case "earth":
                    titleChinese.append("屬性元素")
                    functionChinese.append("土屬性魔攻")
                case "water":
                    titleChinese.append("屬性元素")
                    functionChinese.append("水屬性魔攻")
                case "fire":
                    titleChinese.append("屬性元素")
                    functionChinese.append("火屬性魔攻")
                case "upgrade":
                    titleChinese.append("合併元素")
                    functionChinese.append("需搭配any1,ba1,ca2")
                    
                default:
                    break
                    
                }
                
            }
            
            //新增數值供info顯示
            if let value = allGetElemsInfo[i]["v"] as String?{
                values.append(value)
                
            }
            
        }
        
    }
    
    //計算寵物數值的func
    func calculatePetValue(){
        
        
        print(selOccupiedByElemIndex)
        //抓數值, 之後這個數值要從一個可以固定及升級改數值的地方抓數字過來.
        //寵物資訊重置
        pet = ["petLife":100,"petAttack":40,"petDefense":10,"petDoubleAttack":20,"petExtraAttack":0,"petHeal":0,"petType":""]
        
        let petCure = pet?["petHeal"] as! Int
        let petLife = pet?["petLife"] as! Int
        let petAttack = pet?["petAttack"] as! Int
        let petDefense = pet?["petDefense"] as! Int
        let petDouble = pet?["petDoubleAttack"] as! Int
        let petExtra = pet?["petExtraAttack"] as! Int
        
        petCureLabel.text = String(describing: petCure)
        petLifeLabel.text = String(describing: petLife)
        petAttackLabel.text = String(describing: petAttack)
        petDefenseLabel.text = String(describing: petDefense)
        petDoubleAttackLabel.text = String(describing: petDouble) + "%"
        petExtraAttackLabel.text = String(describing: petExtra)
        
        //顏色先重置白色
        petLifeLabel.textColor = .white
        petAttackLabel.textColor = .white
        petDefenseLabel.textColor = .white
        petExtraAttackLabel.textColor = .white
        petDoubleAttackLabel.textColor = .white
        petCureLabel.textColor = .white
        petTypeImg.image = UIImage()
        
        
        // 機制: 這裡的數字不改, 每一次都check selOccupied有沒有任何值會影響
        
        //抓數字
        for s in 0 ..< selOccupiedByElemIndex.count{
            
            //加數值上去
            if selOccupiedByElemIndex[s] > -1 {
                
                let index = selOccupiedByElemIndex[s]
                let selElem = allGetElemsInfo[index]
                
                if let function = selElem["f"] as String?{
                    
                    switch function{
                        
                    case "hp":
                        
                        petLifeLabel.textColor = .green
                        petLifeLabel.text = String(petLife + Int(selElem["v"]!)!)
                        pet?["petLife"] = Int(petLife + Int(selElem["v"]!)!)
                        
                        
                    case "att":
                        petAttackLabel.textColor = .green
                        petAttackLabel.text = String(petAttack + Int(selElem["v"]!)!)
                        pet?["petAttack"] = Int(petAttack + Int(selElem["v"]!)!)
                        
                    case "def":
                        petDefenseLabel.textColor = .green
                        petDefenseLabel.text = String(petDefense + Int(selElem["v"]!)!)
                        pet?["petDefense"] = Int(petDefense + Int(selElem["v"]!)!)
                        
                        
                    case "hit":
                        petDoubleAttackLabel.textColor = .green
                        petDoubleAttackLabel.text = String(petDouble + Int(selElem["v"]!)!) + "%"
                        pet?["petDouble"] = Int(petDouble + Int(selElem["v"]!)!)
                        
                        
                    case "heal":
                        petCureLabel.textColor = .green
                        petCureLabel.text = String(petCure + Int(selElem["v"]!)!)
                        pet?["petHeal"] = Int(petCure + Int(selElem["v"]!)!)
                        
                    case "wood":
                            
                            petExtraAttackLabel.textColor = .green
                            petExtraAttackLabel.text = String(petExtra + Int(selElem["v"]!)!)
                            pet?["petExtraAttack"] = Int(petExtra + Int(selElem["v"]!)!)
                            
                            pet?["petType"] = "wood"
                            
                            petTypeImg.image = UIImage(named: "wood.png")
                            
                  
                    case "earth":
                       
                            
                            petExtraAttackLabel.textColor = .green
                            petExtraAttackLabel.text = String(petExtra + Int(selElem["v"]!)!)
                            pet?["petExtraAttack"] = Int(petExtra + Int(selElem["v"]!)!)
                            pet?["petType"] = "earth"
                            
                            petTypeImg.image = UIImage(named: "earth.png")
                            
                 
                    case "water":
                        

                            petExtraAttackLabel.textColor = .green
                            petExtraAttackLabel.text = String(petExtra + Int(selElem["v"]!)!)
                            pet?["petExtraAttack"] = Int(petExtra + Int(selElem["v"]!)!)
                            pet?["petType"] = "water"
                            
                            petTypeImg.image = UIImage(named: "water.png")
                            
                    case "fire":
                        
                       
                            
                            petExtraAttackLabel.textColor = .green
                            petExtraAttackLabel.text = String(petExtra + Int(selElem["v"]!)!)
                            pet?["petExtraAttack"] = Int(petExtra + Int(selElem["v"]!)!)
                            pet?["petType"] = "fire"
                            petTypeImg.image = UIImage(named: "fire.png")
                            
     
                              case "metal":
                                
                     
                            petExtraAttackLabel.textColor = .green
                            petExtraAttackLabel.text = String(petExtra + Int(selElem["v"]!)!)
                            pet?["petExtraAttack"] = Int(petExtra + Int(selElem["v"]!)!)
                            pet?["petType"] = "metal"
                            
                            petTypeImg.image = UIImage(named: "metal.png")
                            
     
                    case "upgrade":
                        break
                    default:
                        break
                        
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    
    @IBAction func backToMapClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func prevButtonClick(_ sender: Any) {
    }
    
    @IBAction func nextButtonClick(_ sender: Any) {
    }
    
}
