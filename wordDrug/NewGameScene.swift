//
//  NewGameScene.swift
//  wordDrug
//
//  Created by Ethan on 2018/2/1.
//  Copyright © 2018年 playplay. All rights reserved.
//

import SpriteKit
import GameplayKit


class NewGameScene: SKScene {
    let syllableSets = [["ab1","ac1","ad1","a_e1","af1","ai1","al1","am1","an1","any1"],
                        ["ap1","ar1","as1","at1","au1","aw1","ay1","ba1","be1","bi1"],
                        ["bit1","bl1","bo1","br1","bu1","by1","ce1","ch1","ci1","ble1"],
                        ["ck1","cl1","co1","com1","con1","cian1","cr1","ct1","de1","di1"],
                        ["do1","dr1","dy1","dis1","ea1","ee1","el1","em1","en1","er1"],
                        ["et1","ew1","ex1","ey1","fi1","fl1","fo1","fr1","ft1","ful1"],
                        ["ge1","gi1","gl1","go1","gr1","he1","hi1","id1","ie1","igh1"],
                        ["il1","im1","in1","ing1","ir1","is1","ject1","kn1","le1","li1"],
                        ["ly1","mi1","nd1","no1","nt1","oa1","ob1","o_e1","of1","oi1"],
                        ["old1","on1","ong1","oo1","op1","or1","ot1","ou1","ow1","oy1"],
                        ["ph1","pi1","pl1","pr1","cop1","re1","ro1","ry1","sh1","si1"],
                        ["sk1","so1","sp1","st1","sion1","th1","ti1","tion1","tive1","tle1"],
                        ["to1","tr1","ture1","ty1","ub1","u_e1","ui1","um1","un1","up1"],
                        ["ur1","ut1","war1","wh1","ab2","ac2","ad2","a_e2","af2","ai2"]]
    
    //特殊顏色
    let lightGreen = UIColor.init(red: 196/255, green: 255/255, blue: 137/255, alpha: 1)
    let darkWordColor = UIColor.init(red: 104/255, green: 129/255, blue: 130/255, alpha: 1)
    let lightPink = UIColor.init(red: 255/255, green: 217/255, blue: 239/255, alpha: 100)
    let selectWordDarkColor = UIColor.init(red: 62/255, green: 60/255, blue: 61/255, alpha: 1)
    
    //中文字左右對錯
    var leftOrRight = Int()
    let leftChiNode = SKLabelNode()
    let rightChiNode = SKLabelNode()
    
    //目前單字的順位
    var currentWordSequence = 0
    
    //目前練習順序
    var currentPracticeSequence = 0
    
    //暫時使用的單字
    var wordSets = [String]()
    
    //此元素頁面裡所有的音節
    var syllables = [String]()
    
    //被設定好的頁數
    var spotNumber = Int()
    var unitNumber = Int()
    
    //紀錄第一個sequence
    var firstSequence = Int()
    
    //做三個字的label
    var firstEngWordLabel = UILabel()
    var secondEngWordLabel = UILabel()
    var thirdEngWordLabel = UILabel()
    
    var firstChiWordLabel = UILabel()
    var secondChiWordLabel = UILabel()
    var thirdChiWordLabel = UILabel()
    
    //造字時的當下音節
    var syllablesToCheck = String()
    var syllablesWithoutDigit = String()
    
    
    //紀錄單字有沒有加入最愛
    var wordsLoved = [0,0,0]
    var myWords = [String]()
    var firstEngWord = String()
    var secondEngWord = String()
    var thirdEngWord = String()
    var wrongWords = [String]()
    var myWrongWords = [String]()
    
    //是否能按功能button
    var isButtonEnable = false
    
    //紀錄按到了幾次node
    var touchTimes = 0
    
    //做三個字
    var words = [NSMutableAttributedString(),NSMutableAttributedString(),NSMutableAttributedString()]
    
    //發音單字
    var wordsToPronounce = String()
    
    //是否為戰鬥模式
    var isBattleMode = false
    
    //正確的答案
    var currentWordArray = [String]()
    
    //選項單字
    var shownWords = [String]()
    
    //是否能作答
    var isDragAndPlayEnable = false
    
    //所有node的名稱
    var selNodeNames = ["se0","se1","se2","se3","se4"]
    
    //紀錄手指位置
    var location = CGPoint()
    
    //dragAndPlay需要變數
    //線條
    var line:SKShapeNode?
    
    //路徑
    var path:CGMutablePath = CGMutablePath()
    
    //第一點
    var firstTouch = CGPoint()
    
    //未確認的點
    var movingTouch = CGPoint()
    
    //確認點
    var fixedSecondTouch = CGPoint()
    var fixedThirdTouch = CGPoint()
    var fixedFourthTouch = CGPoint()
    var fixedFifthTouch = CGPoint()
    
    //紀錄已經按到的node
    var nodesTouched = [SKSpriteNode]()
    
    //輸入的答案
    var wordEntered = [String]()
    
    //有沒有按畫面
    var isTouched = false
    //結束有沒有在node上
    var isEndOnNode = false
    //node有沒有移除
    var isRemoved = false
    
    //指定目前的label
    var currentEngWordLabel = UILabel()
    var currentChiWordLabel = UILabel()
    
    //是否是遊戲模式
    var isGameMode = false
    
    //建立所有x,y選項
    var allPossibilities = [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2],[3,0],[3,1],[3,2],[4,0],[4,1],[4,2]]
    
    //產生15組字節
    var allBlockSyls = [String]()
    
    //產生15組顏色, 要跟著x,y選項一起變化位置
    var allColorSets = [Int]()
    
    //已選擇的顏色
    var colorsSelected = [Int]()
    //已選擇的xy選項
    var alreadySelected = [[Int]]()
    
    //設定好的方塊顏色
    let colorFrames = ["blueFrame","greenFrame","lightBlueFrame","pinkFrame","purpleFrame","redFrame","yellowFrame"]
    
    
    //隨機爆破的Timer
    var openTimer = Timer()
      var openTimes = 0
    
    var blockAngle = CGFloat()
    var scoresToAdd = Int()
    var countScoreTimer = Timer()
    var addedScore = 0
    
    override func didMove(to view: SKView) {
        
        //載入各種字
        loadAllKindsOfWord()
        //設定畫面
        setUpScreen()
        //避免多次按
        self.view?.isMultipleTouchEnabled = false
    }
    
    //載入各種字
    func loadAllKindsOfWord(){
        
        //載入我的最愛單字
        if let myWordsString = user!["myWords"] as! String?{
            myWords = myWordsString.components(separatedBy: ";")
            
        }
        
        //讀取所有錯誤的字供比對
        if let myWrongWordsString = user!["wrongWords"] as! String?{
            myWrongWords = myWrongWordsString.components(separatedBy: ";")
        }
        
        print("unitNumber:\(unitNumber)")
        print("spotNumber:\(spotNumber)")
        //測試用
        spotNumber = 13
        unitNumber = 7
        
        //抓正確unit
        currentWordSequence = 3 * unitNumber
        firstSequence = currentWordSequence
        
        //抓正確的音節
        syllables = syllableSets[spotNumber]
        
        //讀取Bundle裡的文字檔
        var wordFile:String?
        
        let name = "1-" + String(spotNumber + 1)
        
        if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
            do {
                wordFile = try String(contentsOfFile: filepath)
                let words = wordFile?.components(separatedBy: "; ")
                
                //把字讀取到wordSets裡
                wordSets = words!
                //print(contents)
            } catch {
                // contents could not be loaded
            }
        } else {
            // example.txt not found!
        }
        
    }
    
    
    //載入畫面
    func setUpScreen(){
        
        //背景
        makeImageNode(name: "gameBg", image: "newGameBg", x: 0, y: 0, width: 754, height: 1334, z: 0, alpha: 1, isAnchoring: false)
        
        //做三個字的背景
        makeImageNode(name: "threeWordBg", image: "threeWordBg", x: 0, y: 309, width: 750, height: 438, z: 2, alpha: 1, isAnchoring: false)
        
        //單字元素, 這部分是新的
        makeImageNode(name: "elementToShow", image: "elemExample", x: -290, y: 590, width: 80, height: 80, z: 1, alpha: 1, isAnchoring: false)
        
        //單字等級label
        makeLabelNode(x: 0, y: 600, alignMent: .center, fontColor: lightGreen, fontSize: 40, text: "英檢初級", zPosition: 1, name: "levelTitle", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        
        //單字量Label, 這部分是新的
        makeLabelNode(x: 0, y: 550, alignMent: .center, fontColor: .lightGray, fontSize: 30, text: "175/2100", zPosition: 1, name: "wordAmount", fontName: "Helvetica Neue", isHidden: false, alpha: 1)
        
        //得分Label, 這部分是新的
        makeLabelNode(x: 330, y: 555, alignMent: .right, fontColor: .white, fontSize: 40, text: "0", zPosition: 1, name: "scoreLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        
        //三個點點
        makeImageNode(name: "whiteDot0", image: "whiteDot", x: -300, y: 450, width: 20, height: 20, z: 1, alpha: 0, isAnchoring: false)
        makeImageNode(name: "whiteDot1", image: "whiteDot", x: -300, y: 300, width: 20, height: 20, z: 1, alpha: 0, isAnchoring: false)
        makeImageNode(name: "whiteDot2", image: "whiteDot", x: -300, y: 150, width: 20, height: 20, z: 1, alpha: 0, isAnchoring: false)
        
        makeLabelNode(x: -425, y: 0, alignMent: .center, fontColor: .white, fontSize: 50, text: "", zPosition: 1, name: "hintLeftLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        makeLabelNode(x: 425, y: 0, alignMent: .center, fontColor: .white, fontSize: 50, text: "", zPosition: 1, name: "hintRightLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        
        //三個星星
        /*
         makeImageNode(name: "star0", image: "starLight", x: -330, y: -100, width: 45, height: 45, z: 1, alpha: 1, isAnchoring: false)
         makeImageNode(name: "star1", image: "starLight", x: -280, y: -100, width: 45, height: 45, z: 1, alpha: 1, isAnchoring: false)
         makeImageNode(name: "star2", image: "starDark", x: -235, y: -100, width: 45, height: 45, z: 1, alpha: 1, isAnchoring: false)
         */
        //製作按鈕
        let lightWidth:CGFloat = 150
        let lightHeight:CGFloat = 150
        let darkWidth:CGFloat = 150
        let darkHeight:CGFloat = 150
        let lightImg:String = "lightSelBtn"
        let darkImg:String = "darkSelBtn"
        let positions = [[-135,-570],[-230,-350],[135,-570],[230,-350],[0,-190]]
        
        //選項按鈕
        
        makeNode(name: "se0", color: .clear, x:CGFloat(positions[0][0]) , y: CGFloat(positions[0][1]), width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se1", color: .clear, x:CGFloat(positions[1][0]) , y: CGFloat(positions[1][1]), width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se2", color: .clear, x:CGFloat(positions[2][0]) , y: CGFloat(positions[2][1]), width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se3", color: .clear, x:CGFloat(positions[3][0]) , y: CGFloat(positions[3][1]), width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se4", color: .clear, x:CGFloat(positions[4][0]) , y: CGFloat(positions[4][1]), width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        
        //填滿按鈕
        
        makeImageNode(name: "0filledButton", image: lightImg, x:CGFloat(positions[0][0]) , y: CGFloat(positions[0][1]), width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "1filledButton", image: lightImg, x:CGFloat(positions[1][0]), y: CGFloat(positions[1][1]), width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "2filledButton", image: lightImg, x:CGFloat(positions[2][0]) , y: CGFloat(positions[2][1]), width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "3filledButton", image: lightImg, x:CGFloat(positions[3][0]) , y: CGFloat(positions[3][1]), width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "4filledButton", image: lightImg, x:CGFloat(positions[4][0]) , y: CGFloat(positions[4][1]), width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        
        
        //空的按鈕
        makeImageNode(name: "0emptyButton", image: darkImg, x:CGFloat(positions[0][0]) , y: CGFloat(positions[0][1]), width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "1emptyButton", image: darkImg, x:CGFloat(positions[1][0]) , y: CGFloat(positions[1][1]), width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "2emptyButton", image: darkImg, x:CGFloat(positions[2][0]) , y: CGFloat(positions[2][1]), width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "3emptyButton", image: darkImg, x:CGFloat(positions[3][0]) , y: CGFloat(positions[3][1]), width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "4emptyButton", image: darkImg, x:CGFloat(positions[4][0]) , y: CGFloat(positions[4][1]), width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        
        
        //製作中文選項
        makeImageNode(name: "leftChiBtn", image: "leftChiBtn", x: -187, y: -365, width: 376, height: 606, z: 7, alpha: 0, isAnchoring: false)
        makeImageNode(name: "rightChiBtn", image: "rightChiBtn", x: 187, y: -365, width: 376, height: 606, z: 7, alpha: 0, isAnchoring: false)
        
        //加入中文字選項的node
        leftChiNode.position = CGPoint(x: -187, y: -375)
        leftChiNode.horizontalAlignmentMode = .center
        leftChiNode.fontSize = 60
        leftChiNode.fontColor = .white
        leftChiNode.zPosition = 8
        leftChiNode.name = "leftChi"
        leftChiNode.fontName = "Helvetica Bold"
        
        addChild(leftChiNode)
        //findImageNode(name: "leftChiBtn").addChild(leftChiNode)
        
        rightChiNode.position = CGPoint(x: 187, y: -375)
        rightChiNode.horizontalAlignmentMode = .center
        rightChiNode.fontSize = 60
        rightChiNode.fontColor = .white
        rightChiNode.zPosition = 8
        rightChiNode.name = "rightChi"
        rightChiNode.fontName = "Helvetica Bold"
        
        addChild(rightChiNode)
        //findImageNode(name: "rightChiBtn").addChild(rightChiNode)
        
        //建立三個單字
        
        firstEngWordLabel.frame = CGRect(x: 60 + 375, y: 85, width: 200, height: 40)
        //firstWordLabel.backgroundColor = .cyan
        firstEngWordLabel.textColor = darkWordColor
        firstEngWordLabel.textAlignment = .left
        firstEngWordLabel.adjustsFontSizeToFitWidth = true
        firstEngWordLabel.font = UIFont(name: "Helvetica Bold", size: 30)
        firstEngWordLabel.text = ""
        self.view?.addSubview(firstEngWordLabel)
        
        secondEngWordLabel.frame = CGRect(x: 60 + 375, y: 160, width: 200, height: 40)
        
        secondEngWordLabel.textColor = darkWordColor
        secondEngWordLabel.textAlignment = .left
        secondEngWordLabel.adjustsFontSizeToFitWidth = true
        secondEngWordLabel.font = UIFont(name: "Helvetica Bold", size: 30)
        secondEngWordLabel.text = ""
        self.view?.addSubview(secondEngWordLabel)
        
        thirdEngWordLabel.frame = CGRect(x: 60 + 375, y: 235, width: 200, height: 40)
        
        thirdEngWordLabel.textColor = darkWordColor
        thirdEngWordLabel.textAlignment = .left
        thirdEngWordLabel.adjustsFontSizeToFitWidth = true
        thirdEngWordLabel.font = UIFont(name: "Helvetica Bold", size: 30)
        thirdEngWordLabel.text = ""
        self.view?.addSubview(thirdEngWordLabel)
        
        //建立三個單字
        firstChiWordLabel.frame = CGRect(x: 270 + 375, y: 85, width: 90, height: 40)
        //firstChiWordLabel.backgroundColor = .green
        firstChiWordLabel.textColor = darkWordColor
        firstChiWordLabel.textAlignment = .right
        firstChiWordLabel.adjustsFontSizeToFitWidth = true
        firstChiWordLabel.font = UIFont(name: "Helvetica Neue", size: 20)
        firstChiWordLabel.text = ""
        self.view?.addSubview(firstChiWordLabel)
        
        secondChiWordLabel.frame = CGRect(x: 270 + 375, y: 160, width: 90, height: 40)
        //firstChiWordLabel.backgroundColor = .green
        secondChiWordLabel.textColor = darkWordColor
        secondChiWordLabel.textAlignment = .right
        secondChiWordLabel.adjustsFontSizeToFitWidth = true
        secondChiWordLabel.font = UIFont(name: "Helvetica Neue", size: 20)
        secondChiWordLabel.text = ""
        self.view?.addSubview(secondChiWordLabel)
        
        thirdChiWordLabel.frame = CGRect(x: 270 + 375 , y: 235, width: 90, height: 40)
        //firstChiWordLabel.backgroundColor = .green
        thirdChiWordLabel.textColor = darkWordColor
        thirdChiWordLabel.textAlignment = .right
        thirdChiWordLabel.adjustsFontSizeToFitWidth = true
        thirdChiWordLabel.font = UIFont(name: "Helvetica Neue", size: 20)
        thirdChiWordLabel.text = ""
        self.view?.addSubview(thirdChiWordLabel)
        
        //建立好畫面後開始動畫
        introAnimation()
        
    }
    
    //Part 1. intro: 開始學習單字的提示字樣滑入, 飛出
    
    func introAnimation(){
        
        hintSlideIn(leftText: "學習", rightText: "單字",waitTime: 1.3) {[weak self] in
            
            self!.makeWords()
            
        }
        
    }
    
    // 2. makeWords: 讀取所有的字, 造字
    func makeWords(){
        
        //找目前sequence的英文+中文字
        var allThreeEngWords = [[String]]()
        let quarterCount = wordSets.count / 4
        let engWord0 = wordSets[currentWordSequence].components(separatedBy: " ")
        let chiWord0 = wordSets[quarterCount +  currentWordSequence]
        let engWord1 = wordSets[currentWordSequence + 1].components(separatedBy: " ")
        let chiWord1 = wordSets [quarterCount +  currentWordSequence + 1]
        let engWord2 = wordSets[currentWordSequence + 2].components(separatedBy: " ")
        let chiWord2 = wordSets [quarterCount +  currentWordSequence + 2]
        
        allThreeEngWords.append(engWord0)
        allThreeEngWords.append(engWord1)
        allThreeEngWords.append(engWord2)
        
        //英文字要用attr
        //firstWordLabel.text = engWord0
        firstChiWordLabel.text = chiWord0
        //secondWordLabel.text = engWord1
        secondChiWordLabel.text = chiWord1
        //thirdWordLabel.text = engWord2
        thirdChiWordLabel.text = chiWord2
        
        //字型顏色
        let attrs0 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 30), NSAttributedStringKey.foregroundColor : UIColor.white]
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 30), NSAttributedStringKey.foregroundColor : UIColor.cyan]
         let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 30), NSAttributedStringKey.foregroundColor : UIColor.orange]
        
        //先抓音節
        syllablesToCheck = syllables[unitNumber]
        //去掉數字
        syllablesWithoutDigit = (syllablesToCheck.components(separatedBy: NSCharacterSet.decimalDigits) as NSArray).componentsJoined(by: "")
        
        
        var attrWords = [[NSMutableAttributedString](),[NSMutableAttributedString](),[NSMutableAttributedString]()]
        
        //確認是否是specialE
        
        if syllablesWithoutDigit.contains("_"){
            //specialE的作法
            
            var characters = [Character]()
            let vowels = ["a","e","i","o","u"]
            
            //var attrWords = [NSMutableAttributedString]()
            
            //每一個英文字節拆字母
            print(allThreeEngWords)
            
            for w in 0 ..< allThreeEngWords.count{
                
                for i in 0 ..< allThreeEngWords[w].count{
                    
                    characters.removeAll(keepingCapacity: false)

                    for c in allThreeEngWords[w][i]{
                        
                        characters.append(c)
                    }
                    
                    if characters.count == 3{
                        if characters[2] == "e"{
                            
                            if vowels.contains(String(characters[0])){
                                
                                
                                //剛好是_e部首
                                let word = NSMutableAttributedString(string: String(characters[0]), attributes: attrs1)
                                attrWords[w].append(word)
                                let word1 = NSMutableAttributedString(string: String(characters[1]), attributes: attrs0)
                                attrWords[w].append(word1)
                                let word2 = NSMutableAttributedString(string: String(characters[2]), attributes: attrs1)
                                attrWords[w].append(word2)
                                
                            
                            } else {
                                
                                for c in 0 ..< characters.count {
                                    
                                    let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs0)
                                    attrWords[w].append(word)
                                }

                            }
                            
                        } else {
                            
                            for c in 0 ..< characters.count {
                                
                                let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs0)
                                attrWords[w].append(word)
                            }
                            
                        }
                        
                    } else {
                        
                        for c in 0 ..< characters.count {
                            
                            let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs0)
                            attrWords[w].append(word)
                        }
                        
                        
                    }
                    
                    
                }
            }
            
        } else {
            //非specialE的作法

            //抓三個字的array
            for w in 0 ..< allThreeEngWords.count{
                
                //抓每個array的音節
                for i in 0 ..< allThreeEngWords[w].count{
                    
                    if let engWord = allThreeEngWords[w][i] as String?{
                        
                        if engWord == syllablesWithoutDigit{
                            //符合部首字
                            
                            let word = NSMutableAttributedString(string: engWord, attributes: attrs1)
                            attrWords[w].append(word)
                            
                            
                        } else{
                            //一般字元
                            
                            let word = NSMutableAttributedString(string: engWord, attributes: attrs0)
                            
                            attrWords[w].append(word)
                            
                        }
                    }
                    
                }
                
            }
            
        }
        
        
        //*** 以下為共同的造字func
        
        for w in 0 ..< attrWords.count {
            
            for i in 0 ..< attrWords[w].count {
                
                if i == 0 {
                    words[w] = attrWords[w][i]
                    
                } else {
                    words[w].append(attrWords[w][i])
                }
            }
        }
        
        firstEngWordLabel.attributedText = words[0]
        secondEngWordLabel.attributedText = words[1]
        thirdEngWordLabel.attributedText = words[2]
        
        
        firstEngWordLabel.textColor = darkWordColor
        secondEngWordLabel.textColor = darkWordColor
        thirdEngWordLabel.textColor = darkWordColor
        
        //造完字單字滑入 - 一次性動畫
        slideInAnimation()
        
    }
    
    //Part 3. slideIn: 單字滑進來
    func slideInAnimation(){
        print("slide")
        UIView.animate(withDuration: 0.3, animations: {[weak self] in
            self!.firstEngWordLabel.frame.origin.x = 60
            self!.firstChiWordLabel.frame.origin.x = 270
        })
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveLinear, animations: {[weak self] in
            
            self!.secondEngWordLabel.frame.origin.x = 60
            self!.secondChiWordLabel.frame.origin.x = 270
        })
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveLinear, animations: {[weak self] in
            
            self!.thirdEngWordLabel.frame.origin.x = 60
            self!.thirdChiWordLabel.frame.origin.x = 270
            
        }) {[weak self] (finished:Bool) in
            
            if finished{
                
                //設定第一個練習單字
                
                self!.changeImageAlfa(name: "whiteDot0", toAlpha: 1, time: 0.3)
                self!.firstEngWordLabel.attributedText = self!.words[0]
                self!.firstChiWordLabel.textColor = .white
                self!.wordsToPronounce = self!.wordSets[self!.currentWordSequence].replacingOccurrences(of: " ", with: "")
                self!.currentPracticeSequence += 1
                
                self!.pronounce(finished: {
                    //開始練習
                    self!.practice()
                })
                
            }
        }
        
        
        
    }
    
    func practice(){
        
        //練習模式的話
        if isGameMode == false {
            
            hintSlideIn(leftText: "連線", rightText: "拼字",waitTime: 1.3) {[weak self] in
                self!.isDragAndPlayEnable = true
                //是否要發音
                var shouldPronounce = Bool()
                
                //等待發音練完後再進入練習
                let time = DispatchTime.now() + 1.5 //這部分的等待要分兩種...第一次或非第一次的, 之後再修改
                
                //首先指定好上方中英文的label
                DispatchQueue.main.asyncAfter(deadline: time) {[weak self] in
                    
                    switch self!.currentPracticeSequence{
                        
                    case 1:
                        print("1")
                        self!.currentEngWordLabel = self!.firstEngWordLabel
                        self!.currentChiWordLabel = self!.firstChiWordLabel
                        shouldPronounce = false
                        
                    case 2:
                        print("2")
                        self!.currentEngWordLabel = self!.secondEngWordLabel
                        self!.currentChiWordLabel = self!.secondChiWordLabel
                        
                        
                        self!.changeImageAlfa(name: "whiteDot0", toAlpha: 0, time: 0.1)
                        self!.firstEngWordLabel.textColor = self!.darkWordColor
                        self!.firstChiWordLabel.textColor = self!.darkWordColor
                        self!.changeImageAlfa(name: "whiteDot1", toAlpha: 1, time: 0.3)
                        self!.secondEngWordLabel.attributedText = self!.words[1]
                        self!.secondChiWordLabel.textColor = .white
                        
                        self!.wordsToPronounce = self!.wordSets[self!.currentWordSequence].replacingOccurrences(of: " ", with: "")
                        shouldPronounce = true
                        
                    case 3:
                        print("3")
                        self!.currentEngWordLabel = self!.thirdEngWordLabel
                        self!.currentChiWordLabel = self!.thirdChiWordLabel
                        
                        self!.changeImageAlfa(name: "whiteDot1", toAlpha: 0, time: 0.1)
                        self!.secondEngWordLabel.textColor = self!.darkWordColor
                        self!.secondChiWordLabel.textColor = self!.darkWordColor
                        self!.changeImageAlfa(name: "whiteDot2", toAlpha: 1, time: 0.3)
                        self!.thirdEngWordLabel.attributedText = self!.words[2]
                        self!.thirdChiWordLabel.textColor = .white
                        
                        self!.wordsToPronounce = self!.wordSets[self!.currentWordSequence].replacingOccurrences(of: " ", with: "")
                        
                        shouldPronounce = true
                        
                    default:
                        break
                    }
                    
                    if shouldPronounce{
                        self!.pronounce {
                            print("pronounce")
                            
                            
                        }
                    }
                    self!.currentEngWordLabel.textColor = self!.darkWordColor
                    self!.isUserInteractionEnabled = true
                }
            }
        }
        
        
        
        
        //顯示空格子
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.3)
        
        for node in children{
            
            //顯示選項罐子
            if (node.name?.contains("emptyButton"))!{
                
                node.run(fadeIn)
            }
        }
        
        
        //抓目前單字
        let currentWord = wordSets[currentWordSequence]
        
        //分目前單字音節
        currentWordArray = currentWord.components(separatedBy: " ")
        
        //計算音節數
        let currentWordSyllableCounts = currentWordArray.count
        
        //抓部首以外的英文字
        var otherWords = [String]()
        
        //在所有英文字裡面, 如果音節沒有重複目前顯示的音節, 就把它加入到otherWords裡
        for i in 0 ..< wordSets.count / 4{
            
            let word = wordSets[i]
            let sepWordArray = word.components(separatedBy: " ")
            
            for s in sepWordArray{
                
                if !currentWordArray.contains(s) {
                    otherWords.append(s)
                    
                }
            }
        }
        
        //去除array裡重複的字
        let otherWordsOrderSets = otherWords.orderedSet
        
        //產生[0,1,2...]用來移除前一亂數
        var countArray = [Int]()
        
        var randomNumbers = Int()
        
        for i in 0 ..< otherWordsOrderSets.count{
            
            countArray.append(i)
        }
        
        //產生真正來顯示用的多餘單字
        var extraWords = [String]()
        
        
        //補不足的選項
        switch currentWordSyllableCounts {
            
        case 1:
            
            for _ in 0 ..< 4 {
                randomNumbers = Int(arc4random_uniform(UInt32(countArray.count)))
                extraWords.append(otherWordsOrderSets[countArray[randomNumbers]])
                countArray.remove(at: randomNumbers)
                
            }
            
        case 2:
            
            for _ in 0 ..< 3 {
                randomNumbers = Int(arc4random_uniform(UInt32(countArray.count)))
                extraWords.append(otherWordsOrderSets[countArray[randomNumbers]])
                countArray.remove(at: randomNumbers)
                
            }
            
        case 3:
            
            for _ in 0 ..< 2 {
                
                randomNumbers = Int(arc4random_uniform(UInt32(countArray.count)))
                extraWords.append(otherWordsOrderSets[countArray[randomNumbers]])
                countArray.remove(at: randomNumbers)
            }
            
        case 4:
            randomNumbers = Int(arc4random_uniform(UInt32(countArray.count)))
            extraWords.append(otherWordsOrderSets[countArray[randomNumbers]])
            countArray.remove(at: randomNumbers)
            
            
        default:
            break
        }
        
        
        //先把該單字音節填入
        for word in currentWordArray{
            
            shownWords.append(word)
            
        }
        
        //假如有多餘選項字, 填入
        if extraWords.count > 0 {
            for extraWord in extraWords {
                
                shownWords.append(extraWord)
                
            }
        }
        
        //改變字的順序順序
        shownWords.shuffled()
        
        //建立所有單字選項
        //設定5格的位置
        let positions = [[-135,-580],[-230,-360],[135,-580],[230,-360],[0,-200]]
        
        for i in 0 ..< shownWords.count{
            
            makeLabelNode(x: CGFloat(positions[i][0]), y: CGFloat(positions[i][1]), alignMent: .center, fontColor: .white, fontSize: 50, text: shownWords[i], zPosition: 5, name: shownWords[i] + String(i) + "Sel", fontName: "Helvetica", isHidden: false, alpha: 1)
            
            //可按按鍵
            isUserInteractionEnabled = true
            
            //把建立的選項名稱放入array裡
            selNodeNames.append(shownWords[i] + String(i) + "Sel")
            
        }
        
        isDragAndPlayEnable = true
        
    }
    
    
    //*** 所有touch的事件***
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            
            location = touch.location(in: self)
            
            let node : SKNode = self.atPoint(location)
            
            //確認中文正確與否
            if node.name == "leftChiBtn" || node.name == "leftChi"{
                if leftOrRight == 0 {
                    //答對
                    
                    changeImageAlfa(name: "leftChiBtn", toAlpha: 0, time: 0.1)
                    //changeImageAlfa(name: "rightChiBtn", toAlpha: 0, time: 0.1)
              
                    makeImageNode(name: "mark", image: "rightCircle", x: -190, y: -355, width: 275, height: 275, z: 9, alpha: 1, isAnchoring: false)
                         makeImageNode(name: "mark", image: "wrongX", x: 190, y: -355, width: 202, height: 214, z: 9, alpha: 1, isAnchoring: false)
                    
                    battleModeRight()
                    
                }else{
                    //答錯
                    changeImageAlfa(name: "leftChiBtn", toAlpha: 0, time: 0.1)
                    //changeImageAlfa(name: "rightChiBtn", toAlpha: 0, time: 0.1)
           makeImageNode(name: "mark", image: "rightCircle", x: 190, y: -355, width: 275, height: 275, z: 9, alpha: 1, isAnchoring: false)
                    
                    makeImageNode(name: "mark", image: "wrongX", x: -190, y: -355, width: 202, height: 214, z: 9, alpha: 1, isAnchoring: false)

                    findLabelNode(name: "tempWord").text = "答錯"
                    findLabelNode(name: "tempWord").fontColor = lightPink
                    findLabelNode(name: "tempWord").fontSize = 60
                    
                    let time = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: time, execute: {[weak self] in
                        self!.nextBattle()
                    })
                    
                }
            }
            
            if node.name == "rightChiBtn" || node.name == "rightChi"{
                if leftOrRight == 1 {
                    //答對
                    
                    //removeSomeNodes(name: "ChiBtn")
                    //changeImageAlfa(name: "leftChiBtn", toAlpha: 0, time: 0.1)
                    changeImageAlfa(name: "rightChiBtn", toAlpha: 0, time: 0.1)
       
                     makeImageNode(name: "mark", image: "wrongX", x: -190, y: -355, width: 202, height: 214, z: 9, alpha: 1, isAnchoring: false)
                    makeImageNode(name: "mark", image: "rightCircle", x: 190, y: -355, width: 275, height: 275, z: 9, alpha: 1, isAnchoring: false)

                    
                    battleModeRight()
                    
                }else{
                    //答錯
                    
                    //答錯
                    //changeImageAlfa(name: "leftChiBtn", toAlpha: 0, time: 0.1)
                    changeImageAlfa(name: "rightChiBtn", toAlpha: 0, time: 0.1)
                    makeImageNode(name: "mark", image: "rightCircle", x: -190, y: -355, width: 275, height: 275, z: 9, alpha: 1, isAnchoring: false)

                    
                     makeImageNode(name: "mark", image: "wrongX", x: 190, y: -355, width: 202, height: 214, z: 9, alpha: 1, isAnchoring: false)
                    
                    findLabelNode(name: "tempWord").text = "答錯"
                    findLabelNode(name: "tempWord").fontColor = lightPink
                    findLabelNode(name: "tempWord").fontSize = 60
                    
                    let time = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: time, execute: {[weak self] in
                        self!.nextBattle()
                    })
                    
                    
                }
                
            }

            //**** 開始拖拉遊戲 dragAndPlay ***
            if isDragAndPlayEnable {
                
                //在建立一條新的線
                line = SKShapeNode()
                line?.strokeColor = lightPink
                line?.lineWidth = 8
                line?.name = "line"
                line?.zPosition = 4
                line?.glowWidth = 2
                
                addChild(line!)
                
                //指定好第一下的位置
                firstTouch = touch.location(in: self)
                
                let node : SKNode = self.atPoint(firstTouch)
                
                //假設有選項單字
                if shownWords.count > 0 {
                    
                    //抓選項方塊
                    for i in 0 ..< selNodeNames.count{
                        
                        //按到任何按鈕
                        if node.name == "se" + String(i){
                            
                            //必須獨立使用touchTimes +=1 才偵測的正確...
                            self.touchTimes += 1
                            
                            let wordChosen = shownWords[i]
                            
                            let name = node.name!
                            
                            //從名稱當中移除該node
                            if let idx = selNodeNames.index(of:name) {
                                selNodeNames.remove(at: idx)
                            }
                            
                            //建立一個透明覆蓋Node
                            makeNode(name: "new" + name, color: .clear, x: node.position.x, y: node.position.y, width: node.frame.width, height: node.frame.height, z: node.zPosition + 1, isAnchoring: false, alpha: 1)
                            
                            //新增到已經按到的node裡
                            nodesTouched.append(findImageNode(name: "new" + name))
                            
                            //建立暫時顯示單字
                            showEnterWords(word: wordChosen)
                            
                            //選項功能
                            selectBall(word: wordChosen, poisonNumber: i)
                            
                            //假如是遊戲模式的話, 要開始隨機開上方方塊
                            if isGameMode{
                                
                                if allPossibilities.count > 0 {
                                    let randomNum = Int(arc4random_uniform(UInt32(allPossibilities.count)))
                                    let randomXY = allPossibilities[randomNum]
                                    alreadySelected.append(randomXY)
                                    
                                    allPossibilities.remove(at: randomNum)
                                    
                                    let color = colorFrames[allColorSets[randomNum]]
                                    colorsSelected.append(allColorSets[randomNum])
                                    
                                    let node = findImageNode(name: "\(randomXY[0])-\(randomXY[1])")
                                    let blockLabel = findLabelNode(name: "\(randomXY[0])-\(randomXY[1])BL")
                                    blockLabel.alpha = 1
                                    
                                    changeTexture(nodeName: node.name!, newTexture: color)
                                    
                                    allColorSets.remove(at: randomNum)

                                    trembelBlock()
                                    
                                }
                            }
                        }
                    }
                }
            }
            
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        
        //確認有按到任何選項單字才會開始偵測move動作
        if touchTimes > 0{
            
            for touch in touches{
                
                isEndOnNode = true
                
                //設定正在移動中的位置
                movingTouch = touch.location(in: self)
                
                let node : SKNode = self.atPoint(movingTouch)
                
                //畫線
                drawLine()
                
                //移除上一個node的功能
                //避免重複移除
                if isRemoved == false {
                    
                    let nodesTouchedCount = nodesTouched.count
                    
                    //假如按到兩個以上的node, 才會移除
                    if nodesTouchedCount > 1 {
                        
                        //假如碰到的node是前一個
                        if node.name == nodesTouched[nodesTouchedCount - 2].name {
                            
                            //假如是遊戲模式的話,要回復一個
                            if isGameMode{
                                
                                if allPossibilities.count > 0 {
                                    
                                    
                                    //重複到上一個就刪除
                                    //抓最後一個XY
                                    let reuseXY = alreadySelected[alreadySelected.count - 1]
                                    let reuseColor = colorsSelected[colorsSelected.count - 1]
                                    //把他加回所有可能
                                    allPossibilities.append(reuseXY)
                                    allColorSets.append(reuseColor)
                                    
                                    //蓋起來
                                    let node = findImageNode(name: "\(reuseXY[0])-\(reuseXY[1])")
                                    changeTexture(nodeName: node.name!, newTexture: "grayFrame")
                                    
                                    let blockLabel = findLabelNode(name: "\(reuseXY[0])-\(reuseXY[1])BL")
                                    blockLabel.alpha = 0

                                    
                                    //移除一個選項
                                    alreadySelected.remove(at: alreadySelected.count - 1)
                                    colorsSelected.remove(at: colorsSelected.count  - 1)
                                    
                                    stopTremble()
                                }
                                
                                
                            }
                            
                            
                            //移除藥水
                            //取得數字順序
                            let idx = nodesTouchedCount - 1
                            let node = nodesTouched[idx]
                            let nameToRemove = node.name
                            let seq = Int((nameToRemove?.replacingOccurrences(of: "newse", with: ""))!)
                            let word = shownWords[seq!]
                            removeBall(word: word, poisonNumber: seq!)
                            
                            //阻擋重複移除
                            isRemoved = true
                            
                            //移除掉目前這個的發亮node
                            let nextNode = nodesTouched[nodesTouchedCount - 1]
                            nextNode.removeFromParent()
                            
                            //記錄裡也要刪掉
                            nodesTouched.remove(at: nodesTouchedCount - 1)
                            
                            //按到次數少1
                            touchTimes -= 1
                            
                            //然後畫線
                            drawLine()
                            
                            //移除上一個輸入的答案
                            wordEntered.removeLast()
                            
                            //抓所有輸入的答案連成一串字
                            var fullText = String()
                            for i in wordEntered {
                                fullText += i
                                
                            }
                            
                            //更改輸入字
                            findLabelNode(name: "tempWord").text = fullText
                            
                        }
                        
                    }
                    
                }
                
                //移動中遇到其它4個node
                if node.name == selNodeNames[0] || node.name == selNodeNames[1] || node.name == selNodeNames[2] || node.name == selNodeNames[3]{
                    print("touch new")
                    
                    
                    //假如是遊戲模式的話, 要開始隨機開上方方塊
                    if isGameMode{
                        
                        if allPossibilities.count > 0 {
                            
                            //抓隨機XY
                            let randomNum = Int(arc4random_uniform(UInt32(allPossibilities.count)))
                            let randomXY = allPossibilities[randomNum]
                            //加入到已選擇
                            alreadySelected.append(randomXY)
                            
                            //可能性移除一個
                            allPossibilities.remove(at: randomNum)
                            
                            //改變那一個的顏色
                            
                            let color = colorFrames[allColorSets[randomNum]]
                            colorsSelected.append(allColorSets[randomNum])
                            
                            let node = findImageNode(name: "\(randomXY[0])-\(randomXY[1])")
                            changeTexture(nodeName: node.name!, newTexture: color)
                            
                            let blockLabel = findLabelNode(name: "\(randomXY[0])-\(randomXY[1])BL")
                            blockLabel.alpha = 1
          
                            allColorSets.remove(at: randomNum)
                            
     
                            trembelBlock()
                        }
                        
                    }
                    
                    
                    //取得數字順序
                    let name = node.name!
                    let index = Int(name.replacingOccurrences(of: "se", with: ""))
                    
                    //避免連續加node
                    if isTouched == false{
                        
                        //阻擋連續加node
                        isTouched = true
                        
                        touchTimes += 1
                        
                        //產生覆蓋的透明node
                        makeNode(name: "new" + name, color: .clear, x: node.position.x, y: node.position.y, width: node.frame.width, height: node.frame.height, z: node.zPosition + 1, isAnchoring: false, alpha: 1)
                        
                        nodesTouched.append(findImageNode(name: "new" + name))
                        
                        //找出選擇的單字
                        let wordChosen = shownWords[index!]
                        
                        //畫面上show出單字
                        showEnterWords(word: wordChosen)
                        
                        //藥水動畫
                        selectBall(word: wordChosen, poisonNumber: index!)
                        
                        
                    }
                    
                    //檢查已經增加第幾個node, 然後做固定轉折點
                    switch touchTimes {
                        
                    case 2:
                        
                        fixedSecondTouch = getCgPoint(name: name)
                        
                    case 3:
                        
                        fixedThirdTouch = getCgPoint(name: name)
                        
                    case 4:
                        
                        fixedFourthTouch = getCgPoint(name: name)
                        
                    case 5:
                        
                        fixedFifthTouch = getCgPoint(name: name)
                        
                    default:
                        break
                    }
                    
                    //轉折點設置好後畫線
                    drawLine()
                    
                    
                } else {
                    
                    //手指離開方塊時
                    
                    //避免一直重複執行
                    isTouched = false
                    
                    isRemoved = false
                    
                }
                
            }
        }
        
    }
    
    
    
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if touchTimes > 0{
            
            if isDragAndPlayEnable{
                
                
                    // Part 通用模式
                    
                    //移除上一次的發亮按鈕
                    removeSomeNodes(name: "new")
                    //移除上一次的線
                    removeSomeNodes(name: "line")
                    
                    //初始化
                    selNodeNames = ["se0","se1","se2","se3","se4"]
                    
                    for touch in touches{
                        let lastTouch = touch.location(in: self)
                        
                        let node : SKNode = self.atPoint(lastTouch)
                        
                        //是否修改線
                        if node.name == selNodeNames[0] || node.name == selNodeNames[1] || node.name == selNodeNames[2] || node.name == selNodeNames[3] || node.name == selNodeNames[4]{
                            
                            //最後有碰到node, 不修改線
                            
                        } else {
                            //最後一個沒碰到node的話, 一放開縮短線
                            
                            isEndOnNode = false
                            
                            drawLine()
                            
                        }
                        
                    }
                    
                    /*
                     //固定線
                     line = SKShapeNode()
                     line?.strokeColor = diamondGreen
                     line?.lineWidth = 8
                     line?.name = "line"
                     line?.zPosition = 4
                     line?.glowWidth = 2
                     addChild(line!)
                     */
                    
                    //初始化
                    //isFirstTouch = false
                    touchTimes = 0
                    isTouched = false
                    nodesTouched.removeAll(keepingCapacity: false)
                    
                    //假如答案正確
                    if wordEntered == currentWordArray{
                        
                        print("right answer")
                        
                        
                        //戰鬥模式
                        if isBattleMode{
                            
                            //  Part 0.先發音
                            pronounce(finished: { 
                                
                            })
                            
                            //Part 1. 選項顏色變淡+移除選項字
                            //Part 2. 建立兩個選項
                            //Part 3. 亂數顯示中文
                            //Part 4. 判定正確與否

                            for node in children{
                                
                                if (node.name?.contains("filledButton"))!{
                                    changeImageAlfa(name: node.name!, toAlpha: 0, time: 0.1)
                                }
                                
                                if (node.name?.contains("emptyButton"))!{
                                    changeImageAlfa(name: node.name!, toAlpha: 0, time: 0.1)
                                }
                                
                                if (node.name?.contains("Sel"))!{
                                    node.removeFromParent()
                                }
                                
                                
                            }
                            //顯示中文選項
                            
                            
                            
                            //抓亂數中文
                            let quarterCount = wordSets.count / 4
                            let halfCount = wordSets.count / 2
                            let chiWord = wordSets[quarterCount +  currentWordSequence]
                            var allChiWords = [String]()
                            for i in quarterCount ..< halfCount{
                                allChiWords.append(wordSets[i])
                            }
                            
                            allChiWords.remove(at: currentWordSequence)
                            
                            //亂數
                            let randomNumber = Int(arc4random_uniform(UInt32(allChiWords.count)))
                            let randomChi = allChiWords[randomNumber]
                            var selChiWords = [String]()
                            
                            selChiWords.append(chiWord)
                            selChiWords.append(randomChi)
                            
                            let randomL = Int(arc4random_uniform(UInt32(2)))
                            var randomR = Int()
                            if randomL == 0 {
                                //左對
                                randomR = 1
                                leftOrRight = 0
                            } else {
                                //右對
                                randomR = 0
                                leftOrRight = 1
                            }
                            
                            leftChiNode.text = selChiWords[randomL]
                            rightChiNode.text = selChiWords[randomR]
                            
                            let leftChiBtn = findImageNode(name: "leftChiBtn")
                            let rightChiBtn = findImageNode(name:"rightChiBtn")
                            
                            let showAlpha = SKAction.fadeAlpha(to: 1, duration: 0.1)
                            leftChiBtn.run(showAlpha)
                            rightChiBtn.run(showAlpha, completion: {[weak self] in
                                
                                self!.isUserInteractionEnabled = true
                                
                            })
                            
                            
                            
                            
                            
                        }else {
                            //練習模式
                            //1. 把顯示的輸入字得分
                            rightScore()
                            
                            //2. 顯示原本有音節變色的字
                            currentEngWordLabel.attributedText = words[currentPracticeSequence - 1]
                            
                            
                            //不能按畫面
                            self.isUserInteractionEnabled = false
                            
                            
                            //播放單字完之後準備 1. 下個單字 2. 進入比賽模式
                            self.pronounce(finished: {[weak self] in
                                
                                //初始化
                                self!.shownWords.removeAll(keepingCapacity: false)
                                self!.wordEntered.removeAll(keepingCapacity: false)
                                
                                
                                
                                //把順序+1
                                
                                
                                //if self!.currentWordSequence < self!.wordSets.count / 4 - 1{
                                
                                if self!.currentWordSequence < (self!.unitNumber + 1) * 3 - 1{
                                    
                                    self!.currentWordSequence += 1
                                    self!.currentPracticeSequence += 1
                                    
                                    //解除practiceMode
                                    //self!.isPracticeMode = false
                                    
                                    //練習下個字
                                    self!.practiceNextWord()
                                    
                                    //不能dragAndPlay
                                    self!.isDragAndPlayEnable = false
                                    
                                } else {
                                    //
                                    //self!.currentWordSequence = 0
                                    
                                    //三個字學完後把字回第一個
                                    self!.currentWordSequence  = self!.unitNumber * 3
                                    
                                    //這個應該不需要
                                    //self!.currentPracticeSequence = self!.unitNumber * 3
                                    
                                    self!.isGameMode = true
                                    //進入battleMode
                                    self!.battleMode()
                                    print("準備開始比賽")
                                    
                                }
                                
                                
                                
                                
                            })
                            
                            //輸入正確音節數歸零
                            //alreadyCorrectsyllables = 0

                            
                        }
                        
                    } else {
                        
                        //答案錯誤的機制
                    
                        print("wrong answer")
                    
                        
                        if isBattleMode{
                            //遊戲的時候
                            
                            //***暫時複製跟下方練習時候一樣的func
                            
                            //不能按畫面
                            self.isUserInteractionEnabled = false
                            
                            //把輸入過的答案移除
                            wordEntered.removeAll(keepingCapacity: false)
                            
                            
                            findLabelNode(name: "tempWord").run(wrongAnswerAction(), completion: {[weak self] in
                                
                                //能按畫面
                                self!.isUserInteractionEnabled = true
                                
                                //選項顏色變淡+移除選項字
                                for node in self!.children{
                                    
                                    if (node.name?.contains("filledButton"))!{
                                        self!.changeImageAlfa(name: node.name!, toAlpha: 0, time: 0)
                                    }
                                    
                                    //把選項字回復成白色
                                    if (node.name?.contains("Sel"))!{
                                        
                                        if let node = node as? SKLabelNode{
                                            
                                            node.fontColor = .white
                                            
                                        }
                                        
                                        //把輸入字刪除
                                        
                                        self!.findLabelNode(name: "tempWord").text = ""
                                        
                                        //停止格子動畫
                                        self!.stopTremble()
                                        
                                       //重置上方格子
                                        self!.reloadBlocks()

                                    }
                                    
                                }
                                
                                
                            })

                            
                            
                            
                            
                            
                            
                        } else {
                            //練習的時候
                            
                            //不能按畫面
                            self.isUserInteractionEnabled = false
                            
                            //把輸入過的答案移除
                            wordEntered.removeAll(keepingCapacity: false)
                            
                            
                            findLabelNode(name: "tempWord").run(wrongAnswerAction(), completion: {[weak self] in
                                
                                //能按畫面
                                self!.isUserInteractionEnabled = true
                                
                                //選項顏色變淡+移除選項字
                                for node in self!.children{
                                    
                                    if (node.name?.contains("filledButton"))!{
                                        self!.changeImageAlfa(name: node.name!, toAlpha: 0, time: 0)
                                    }
                                    
                                    //把選項字回復成白色
                                    if (node.name?.contains("Sel"))!{
                                        
                                        if let node = node as? SKLabelNode{
                                            
                                            node.fontColor = .white
                                            
                                        }
                                        
                                        //把輸入字刪除
                                        
                                        self!.findLabelNode(name: "tempWord").text = ""
                                        
                                    }
                                    
                                }
                                
                                
                            })

                            
                        }
                        
                        
                    }
                    
                    
                
            }
        }
        
    }
    
    func reloadBlocks(){
        
        //把上方蓋起來的做法
        //Part 1. 所有可能性重置
        //Part 2. 所有顏色回復灰色
        //Part 3. 所有已選擇顏色及方塊紀錄都重置
        //Part 4. 所有顏色重新亂數
        //Part 5. blockLabel文字隱藏
        
        allPossibilities = [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2],[3,0],[3,1],[3,2],[4,0],[4,1],[4,2]]
        
        for i in 0 ..< alreadySelected.count{
            
            let colorNode = findImageNode(name: "\(alreadySelected[i][0])-\(alreadySelected[i][1])")
            changeTexture(nodeName: colorNode.name!, newTexture: "grayFrame")
            
            let blockNode = findLabelNode(name:  "\(alreadySelected[i][0])-\(alreadySelected[i][1])BL")
            blockNode.alpha = 0
            
        }
        
        allColorSets = [Int]()
        for _ in 0 ..< 15{
            //在此建立好每格的顏色
            let colorRandomNum = Int(arc4random_uniform(UInt32(colorFrames.count)))
            allColorSets.append(colorRandomNum)
        }
        
        alreadySelected = [[Int]]()
        colorsSelected = [Int]()
        
    }
    
    func practiceNextWord(){
        
        //選項alpha變淡+移除選項字
        for node in children{
            
            if (node.name?.contains("filledButton"))!{
                changeImageAlfa(name: node.name!, toAlpha: 0, time: 0.3)
                
            }
            
            if (node.name?.contains("emptyButton"))!{
                changeImageAlfa(name: node.name!, toAlpha: 0, time: 0.3)
            }
            
            if (node.name?.contains("Sel"))!{
                node.removeFromParent()
            }
            
        }
        
        
        
        practice()
        
    }
    
    func battleMode(){
        
        
        isBattleMode = true
        
        //選項alpha變淡+移除選項字
        for node in children{
            
            if (node.name?.contains("filledButton"))!{
                changeImageAlfa(name: node.name!, toAlpha: 0, time: 0.3)
                
            }
            
            if (node.name?.contains("emptyButton"))!{
                changeImageAlfa(name: node.name!, toAlpha: 0, time: 0.3)
            }
            
            if (node.name?.contains("Sel"))!{
                node.removeFromParent()
            }
            
        }
        //遊戲開始提示滑入
        hintSlideIn(leftText: "開始", rightText: "遊戲",waitTime: 2) {[weak self] in
            //移除點點
            
           self!.findImageNode(name: "whiteDot2").removeFromParent()
       
  
            //移除上方的label及背景
            UIView.animate(withDuration: 0.2, animations: {[weak self] in
                self!.firstEngWordLabel.frame.origin.x = 60 + 375
                self!.firstChiWordLabel.frame.origin.x = 270 + 375
            })
            
            UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {[weak self] in
                
                self!.secondEngWordLabel.frame.origin.x = 60 + 375
                self!.secondChiWordLabel.frame.origin.x = 270 + 375
            })
            
            UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveLinear, animations: {
                self!.thirdEngWordLabel.frame.origin.x = 60 + 375
                self!.thirdChiWordLabel.frame.origin.x = 270 + 375
            }, completion: { (finished:Bool) in
                if finished{
                    
                    
                    self?.findImageNode(name: "threeWordBg").removeFromParent()
                    
                    self!.setUpGameScreen()
                    
                }
                
                
                
            })
            
            
            
            
        }
        
        
        
        
        
        
    }
    
    //建立遊戲畫面
    func setUpGameScreen(){
        //makeImageNode(name: "gamePuzzleBg", image: "gamePuzzleBg", x: 0, y: 320, width: 638, height: 388, z: 1, alpha: 1, isAnchoring: false)

        //重置以下數據
        removeSomeNodes(name: "-")
        removeSomeNodes(name: "mark")
        
        openTimes = 0
        
        allPossibilities = [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2],[3,0],[3,1],[3,2],[4,0],[4,1],[4,2]]
        //產生15組字節
        allBlockSyls = [String]()
        //產生15組顏色, 要跟著x,y選項一起變化位置
        allColorSets = [Int]()
        //已選擇的顏色
        colorsSelected = [Int]()
        //已選擇的xy選項
        alreadySelected = [[Int]]()
        leftChiNode.text = ""
        rightChiNode.text = ""
        changeImageAlfa(name: "leftChiBtn", toAlpha: 0, time: 0.1)
        changeImageAlfa(name: "rightChiBtn", toAlpha: 0, time: 0.1)
        shownWords.removeAll(keepingCapacity: false)
        wordEntered.removeAll(keepingCapacity: false)
        addedScore = 0
        
        //15個遊戲格子
        makeImageNode(name: "0-0", image: "grayFrame", x: -280, y: 460, width: 115, height: 115, z: 1, alpha: 1, isAnchoring: false)
        makeImageNode(name: "0-1", image: "grayFrame", x: -280, y: 320, width: 115, height: 115, z: 1, alpha: 1, isAnchoring: false)
      
        
        makeImageNode(name: "0-2", image: "grayFrame", x: -280, y: 180, width: 115, height: 115, z: 1, alpha: 1, isAnchoring: false)
        
        
        makeImageNode(name: "1-0", image: "grayFrame", x: -140, y: 460, width: 115, height: 115, z: 1, alpha: 1, isAnchoring: false)
        
        
        makeImageNode(name: "1-1", image: "grayFrame", x: -140, y: 320, width: 115, height: 115, z: 1, alpha: 1, isAnchoring: false)
        
        
  
        
        makeImageNode(name: "1-2", image: "grayFrame", x: -140, y: 180, width: 115, height: 115, z: 1, alpha: 1, isAnchoring: false)
        
        
        
        makeImageNode(name: "2-0", image: "grayFrame", x: 0, y: 460, width: 115, height: 115, z: 1, alpha: 1, isAnchoring: false)
        
       
        
        makeImageNode(name: "2-1", image: "grayFrame", x: 0, y: 320, width: 115, height: 115, z: 1, alpha: 1, isAnchoring: false)
        
        
        makeImageNode(name: "2-2", image: "grayFrame", x: 0, y: 180, width: 115, height: 115, z: 1, alpha: 1, isAnchoring: false)
        makeImageNode(name: "3-0", image: "grayFrame", x: 140, y: 460, width: 115, height: 115, z: 1, alpha: 1, isAnchoring: false)
        

        makeImageNode(name: "3-1", image: "grayFrame", x: 140, y: 320, width: 115, height: 115, z: 1, alpha: 1, isAnchoring: false)
        

        makeImageNode(name: "3-2", image: "grayFrame", x: 140, y: 180, width: 115, height: 115, z: 1, alpha: 1, isAnchoring: false)
        

        
        makeImageNode(name: "4-0", image: "grayFrame", x: 280, y: 460, width: 115, height: 115, z: 1, alpha: 1, isAnchoring: false)
        

        
        
        makeImageNode(name: "4-1", image: "grayFrame", x: 280, y: 320, width: 115, height: 115, z: 1, alpha: 1, isAnchoring: false)
        
        
        makeImageNode(name: "4-2", image: "grayFrame", x: 280, y: 180, width: 115, height: 115, z: 1, alpha: 1, isAnchoring: false)
        
        blockAngle = findImageNode(name: "0-0").zRotation

        //開始遊戲
        startGame()
    }
    
    
    func startGame(){
        
        //建立好亂數的字節
        //Part1. 抓正確字節
        let currentWordSyls = wordSets[currentWordSequence].components(separatedBy: " ")
        
        //Part 2. 抓30個字的所有音節
        var allSyls = [String]()
        for i in 0 ..< 30 {
            
            let wordSyl = wordSets[i].components(separatedBy: " ")
            for s in wordSyl{
                
                allSyls.append(s)
            }
            
        }
        
        
        //打亂
        allSyls.shuffled()
        var afterDeleteAllSyls = [String]()
        for i in 0 ..< allSyls.count{
            
            if !currentWordSyls.contains(allSyls[i]){
                
                
                afterDeleteAllSyls.append(allSyls[i])
            }
            
        }
        
        
        //Part 3. 填入選項, 按照正確字節數
        let currentWordCount = currentWordSyls.count
        switch currentWordCount {
        case 1:
            for _ in 0 ..< 8{
                for syl in currentWordSyls{
                    
                    allBlockSyls.append(syl)
                }
                
            }
            for i in 0 ..< 7{
                
                allBlockSyls.append(afterDeleteAllSyls[i])
                
            }
            
        case 2:
            for _ in 0 ..< 4{
                for syl in currentWordSyls{
                    
                    allBlockSyls.append(syl)
                }
                
            }
            for i in 0 ..< 7{
                
                allBlockSyls.append(afterDeleteAllSyls[i])
                
            }
            
            
        case 3:
            
            for _ in 0 ..< 3{
                for syl in currentWordSyls{
                    
                    allBlockSyls.append(syl)
                }
                
            }
            for i in 0 ..< 6{
                
                allBlockSyls.append(afterDeleteAllSyls[i])
                
            }
            
        case 4:
            for _ in 0 ..< 2{
                for syl in currentWordSyls{
                    
                    allBlockSyls.append(syl)
                }
                
            }
            for i in 0 ..< 7{
                
                allBlockSyls.append(afterDeleteAllSyls[i])
                
            }
            
        case 5:
            for _ in 0 ..< 2{
                for syl in currentWordSyls{
                    
                    allBlockSyls.append(syl)
                }
                
            }
            
            for i in 0 ..< 5{
                
                allBlockSyls.append(afterDeleteAllSyls[i])
                
            }
            
        default:
            break
        }
        
        //再次亂數
        allBlockSyls.shuffled()
     makeLabelNode(x: -280, y: 445, alignMent: .center, fontColor: .white, fontSize: 50, text: allBlockSyls[0], zPosition: 2, name: "0-0BL", fontName: "Helvetica Neue", isHidden: false, alpha: 0)
         makeLabelNode(x: -280, y: 305, alignMent: .center, fontColor: .white, fontSize: 50, text: allBlockSyls[1], zPosition: 2, name: "0-1BL", fontName: "Helvetica Neue", isHidden: false, alpha: 0)
        makeLabelNode(x: -280, y: 165, alignMent: .center, fontColor: .white, fontSize: 50, text: allBlockSyls[2], zPosition: 2, name: "0-2BL", fontName: "Helvetica Neue", isHidden: false, alpha: 0)
        makeLabelNode(x: -140, y: 445, alignMent: .center, fontColor: .white, fontSize: 50, text: allBlockSyls[3], zPosition: 2, name: "1-0BL", fontName: "Helvetica Neue", isHidden: false, alpha: 0)
        
              makeLabelNode(x: -140, y: 305, alignMent: .center, fontColor: .white, fontSize: 50, text: allBlockSyls[4], zPosition: 2, name: "1-1BL", fontName: "Helvetica Neue", isHidden: false, alpha: 0)
     makeLabelNode(x: -140, y: 165, alignMent: .center, fontColor: .white, fontSize: 50, text: allBlockSyls[5], zPosition: 2, name: "1-2BL", fontName: "Helvetica Neue", isHidden: false, alpha: 0)
        
         makeLabelNode(x: 0, y: 445, alignMent: .center, fontColor: .white, fontSize: 50, text: allBlockSyls[6], zPosition: 2, name: "2-0BL", fontName: "Helvetica Neue", isHidden: false, alpha: 0)
        makeLabelNode(x: 0, y: 305, alignMent: .center, fontColor: .white, fontSize: 50, text: allBlockSyls[7], zPosition: 2, name: "2-1BL", fontName: "Helvetica Neue", isHidden: false, alpha: 0)
        makeLabelNode(x: 0, y: 165, alignMent: .center, fontColor: .white, fontSize: 50, text: allBlockSyls[8], zPosition: 2, name: "2-2BL", fontName: "Helvetica Neue", isHidden: false, alpha: 0)

                makeLabelNode(x: 140, y: 445, alignMent: .center, fontColor: .white, fontSize: 50, text: allBlockSyls[9], zPosition: 2, name: "3-0BL", fontName: "Helvetica Neue", isHidden: false, alpha: 0)
        
                makeLabelNode(x: 140, y: 305, alignMent: .center, fontColor: .white, fontSize: 50, text: allBlockSyls[10], zPosition: 2, name: "3-1BL", fontName: "Helvetica Neue", isHidden: false, alpha: 0)
        
                makeLabelNode(x: 140, y: 165, alignMent: .center, fontColor: .white, fontSize: 50, text: allBlockSyls[11], zPosition: 2, name: "3-2BL", fontName: "Helvetica Neue", isHidden: false, alpha: 0)
        
        
                makeLabelNode(x: 280, y: 445, alignMent: .center, fontColor: .white, fontSize: 50, text: allBlockSyls[12], zPosition: 2, name: "4-0BL", fontName: "Helvetica Neue", isHidden: false, alpha: 0)
        
        makeLabelNode(x: 280, y: 305, alignMent: .center, fontColor: .white, fontSize: 50, text: allBlockSyls[13], zPosition: 2, name: "4-1BL", fontName: "Helvetica Neue", isHidden: false, alpha: 0)
        
        makeLabelNode(x: 280, y: 165, alignMent: .center, fontColor: .white, fontSize: 50, text: allBlockSyls[14], zPosition: 2, name: "4-2BL", fontName: "Helvetica Neue", isHidden: false, alpha: 0)

        
        for _ in 0 ..< 15{
            //在此建立好每格的顏色
            let colorRandomNum = Int(arc4random_uniform(UInt32(colorFrames.count)))
            allColorSets.append(colorRandomNum)
        }
        //設定發音字
        wordsToPronounce = wordSets[currentWordSequence].replacingOccurrences(of: " ", with: "")
        //提示單字
        hintSlideIn(leftText: "遊戲", rightText: "開始", waitTime: 1.3) {[weak self] in
            self!.pronounce(finished: {
                self!.practice()
            })
        }
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
       
    }
    
    //*** 以下皆為一些自己建立的func 或是extension ***
    
    //換圖片
    func changeTexture(nodeName:String,newTexture:String){
        
        if let node = childNode(withName: nodeName) as? SKSpriteNode{
            if let bundlePath = Bundle.main.path(forResource: newTexture, ofType: "png"){
                let imageFile = UIImage(contentsOfFile: bundlePath)
                let texture = SKTexture(image: imageFile!)
                node.texture = texture
                
            }
            
        }
        
    }
    
    //製作image的skspriteNode
    func makeImageNode(name:String, image:String, x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat, z:CGFloat, alpha:CGFloat, isAnchoring:Bool){
        
        if let bundlePath = Bundle.main.path(forResource: image, ofType: "png"){
            let imageFile = UIImage(contentsOfFile: bundlePath)
            let texture = SKTexture(image: imageFile!)
            let node = SKSpriteNode()
            
            node.size = CGSize(width: width, height: height)
            node.name = name
            node.texture = texture
            node.position = CGPoint(x: x, y: y)
            node.zPosition = z
            node.alpha = alpha
            
            if isAnchoring{
                
                node.anchorPoint = CGPoint(x: 0, y: 0)
            }
            
            addChild(node)
            
        }
        
        
    }
    
    
    
    
    //製作一般labelNode
    func makeLabelNode(x:CGFloat,y:CGFloat,alignMent:SKLabelHorizontalAlignmentMode,fontColor:UIColor,fontSize:CGFloat,text:String,zPosition:CGFloat,name:String,fontName:String, isHidden:Bool, alpha:CGFloat){
        
        let node = SKLabelNode()
        node.position = CGPoint(x: x, y: y)
        node.horizontalAlignmentMode = alignMent
        node.fontSize = fontSize
        node.text = text
        node.fontColor = fontColor
        node.zPosition = zPosition
        node.name = name
        node.fontName = fontName
        node.isHidden = isHidden
        node.alpha = alpha
        
        
        addChild(node)
        
    }
    
    //製作SKNode
    func makeNode(name:String, color:UIColor, x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat, z:CGFloat, isAnchoring:Bool, alpha: CGFloat){
        
        let size = CGSize(width: width, height: height)
        let node = SKSpriteNode(color: color, size: size)
        node.alpha = alpha
        node.name = name
        node.position = CGPoint(x: x, y: y)
        node.zPosition = z
        
        if isAnchoring{
            
            node.anchorPoint = CGPoint(x: 0, y: 0)
        }
        
        addChild(node)
        
    }
    
    //找IMAGE的skspritenode
    func findImageNode(name:String) -> SKSpriteNode{
        var node:SKSpriteNode?
        if let nodeFound = childNode(withName: name) as? SKSpriteNode{
            node = nodeFound
        }
        return node!
        
    }
    
    //找labelNode
    func findLabelNode(name:String) -> SKLabelNode{
        
        var node:SKLabelNode?
        if let nodeFound = childNode(withName: name) as? SKLabelNode{
            node = nodeFound
        }
        return node!
        
    }
    
    
    func changeImageAlfa(name:String, toAlpha:CGFloat, time:TimeInterval){
        
        if let node = childNode(withName: name) as? SKSpriteNode{
            let alphaAction = SKAction.fadeAlpha(to: toAlpha, duration: time)
            node.run(alphaAction)
            
        }
        
    }
    
    func changeLabelAlfa(name:String, toAlpha:CGFloat, time:TimeInterval){
        
        if let node = childNode(withName: name) as? SKLabelNode{
            let alphaAction = SKAction.fadeAlpha(to: toAlpha, duration: time)
            node.run(alphaAction)
            
        }
        
    }
    
    //單純造方塊字Label的功能
    func makeBlockLabel(x:Int,y:Int){
        let node = SKLabelNode()
        node.position = CGPoint(x: 0, y: 0)
        node.horizontalAlignmentMode = .center
        node.fontSize = 20
        node.text = ""
        node.fontColor = .white
        node.zPosition = 2
        node.name = "\(x)-\(y)BlockLabel"
        node.fontName = "Helvetica Neue"
        node.isHidden = false
        node.alpha = 1
        
        if let parentNode = findImageNode(name: "\(x)-\(y)") as SKSpriteNode?{
            parentNode.addChild(node)
            
        }
    }
    
    
    //單純發音功能
    func pronounce(finished: @escaping () -> Void){
        let pronounceAction = SKAction.playSoundFileNamed(wordsToPronounce + ".mp3", waitForCompletion: true)
        run(pronounceAction)
        
        finished()
    }
    
    //show單字在畫面上
    func showEnterWords(word:String){
        
        //填入array
        wordEntered.append(word)
        
        //建立labelNode, 有的話就改text內容
        if let tempNode = childNode(withName: "tempWord") as? SKLabelNode {
            
            //appendText
            var fullText = String()
            for i in wordEntered {
                
                //製作完整文字
                fullText += i
                tempNode.text = fullText
                
            }
            
        } else {
            
            //沒有的話就建立labelNode
            makeLabelNode(x: 0, y: 0, alignMent: .center, fontColor: .white, fontSize: 80, text: word, zPosition: 3, name: "tempWord", fontName: "Helvetica", isHidden: false, alpha: 1)
            
            
        }
    }
    
    
    func selectBall(word:String, poisonNumber:Int){
        
        //找選項正確音節
        let selectedLabel = findLabelNode(name: word + String(poisonNumber) + "Sel")
        
        //改變label fontColor
        let changeTextColor = SKAction.run {[weak self] in
            selectedLabel.fontColor = self!.selectWordDarkColor
        }
        run(changeTextColor)
        
        
        //按鈕發亮, 要設置為0秒完成, 否則會異常
        let buttonName =  String(poisonNumber) + "filledButton"
        changeImageAlfa(name: buttonName, toAlpha: 1, time: 0)
        
    }
    
    
    //抓node的位置func
    func getCgPoint(name:String) -> CGPoint{
        
        let node = childNode(withName: name) as! SKSpriteNode
        let xPos = node.frame.midX
        let yPos = node.frame.midY
        let position = CGPoint(x: xPos, y: yPos)
        return position
    }
    
    //畫線功能
    func drawLine(){
        
        path = CGMutablePath()
        
        switch touchTimes {
            
        case 1:
            
            path.move(to: firstTouch)
            
            if isEndOnNode{
                path.addLine(to: movingTouch)
            } else {
                removeSomeNodes(name: "new")
            }
        case 2:
            
            path.move(to: firstTouch)
            path.addLine(to: fixedSecondTouch)
            if isEndOnNode{
                path.addLine(to: movingTouch)
            }
        case 3:
            
            path.move(to: firstTouch)
            path.addLine(to: fixedSecondTouch)
            path.addLine(to: fixedThirdTouch)
            
            if isEndOnNode{
                path.addLine(to: movingTouch)
            }
        case 4:
            
            path.move(to: firstTouch)
            path.addLine(to: fixedSecondTouch)
            path.addLine(to: fixedThirdTouch)
            path.addLine(to: fixedFourthTouch)
            
            if isEndOnNode{
                path.addLine(to: movingTouch)
                
            }
            
        case 5:
            
            path.move(to: firstTouch)
            path.addLine(to: fixedSecondTouch)
            path.addLine(to: fixedThirdTouch)
            path.addLine(to: fixedFourthTouch)
            path.addLine(to: fixedFifthTouch)
            
            if isEndOnNode{
                path.addLine(to: movingTouch)
                
            }
            
        default:
            break
        }
        
        line!.path = path
        
    }
    
    func removeBall(word:String, poisonNumber:Int){
        
        
        //找選項正確音節
        let selectedLabel = findLabelNode(name: word + String(poisonNumber) + "Sel")
        
        
        //改變label fontColor
        let changeTextColor = SKAction.run {
            selectedLabel.fontColor = .white
        }
        run(changeTextColor)
        
        
        //解除選項
        let buttonName =  String(poisonNumber) + "filledButton"
        changeImageAlfa(name: buttonName, toAlpha: 0, time: 0)
        
        
        
    }
    
    //移除node的func
    func removeSomeNodes(name:String){
        
        for node in children{
            
            if (node.name?.contains(name))!{
                
                node.isHidden = true
                node.removeFromParent()
            }
        }
    }
    
    //答對得分機制
    func rightScore(){
        
        let cgPoint = CGPoint(x: 0, y: 70)
        let flyUp = SKAction.move(to: cgPoint, duration: 0.3)
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.2)
        
        let combine = SKAction.group([flyUp,fadeOut])
        
        findLabelNode(name: "tempWord").run(combine) {[weak self] in
            
            self!.findLabelNode(name: "tempWord").removeFromParent()
            
        }
        
        
        
    }
    
    func wrongAnswerAction() -> SKAction{
        //閃紅字動畫
        let wait = SKAction.wait(forDuration: 0.2)
        let redFontAction = SKAction.run({[weak self] in
            self!.findLabelNode(name: "tempWord").fontColor = .red
        })
        let whiteFontAction = SKAction.run({[weak self] in
            self!.findLabelNode(name: "tempWord").fontColor = .white
        })
        let sequence = SKAction.sequence([redFontAction,wait,whiteFontAction,wait])
        let repeatAction = SKAction.repeat(sequence, count: 2)
        
        return repeatAction
    }
    
    func hintSlideIn(leftText:String,rightText:String,waitTime:TimeInterval,finished: @escaping () -> Void){
        
        
        let toRight = SKAction.moveTo(x: -50, duration: 0.3)
        let toLeft = SKAction.moveTo(x: 50, duration: 0.3)
        let disToRight = SKAction.moveTo(x: 425, duration: 0.05)
        let disToLeft = SKAction.moveTo(x: -425, duration: 0.05)
        let wait = SKAction.wait(forDuration: waitTime)
        
        findLabelNode(name: "hintLeftLabel").text = leftText
        findLabelNode(name: "hintRightLabel").text = rightText
        
        findLabelNode(name: "hintLeftLabel").run(toRight)
        findLabelNode(name: "hintRightLabel").run(toLeft)
        
        self.run(wait) {[weak self] in
            
            let combine = SKAction.run({
                self!.findLabelNode(name: "hintLeftLabel").run(disToLeft)
                self!.findLabelNode(name: "hintRightLabel").run(disToRight)
            })
            
            self!.run(combine, completion: {
                finished()
            })
            
        }

    }
    
    func battleModeRight(){
        print("right")
        
        //隨機爆破五個
        openTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(NewGameScene.openBlock), userInfo: nil, repeats: true)

    }
    
    @objc func openBlock(){
      
        if openTimes < 5 {
            openTimes += 1
        let randomNum = Int(arc4random_uniform(UInt32(allPossibilities.count)))
        let randomXY = allPossibilities[randomNum]
        alreadySelected.append(randomXY)
        
        allPossibilities.remove(at: randomNum)
        
        let color = colorFrames[allColorSets[randomNum]]
        colorsSelected.append(allColorSets[randomNum])
        
        let node = findImageNode(name: "\(randomXY[0])-\(randomXY[1])")
        let blockLabel = findLabelNode(name: "\(randomXY[0])-\(randomXY[1])BL")
        blockLabel.alpha = 1
        
        changeTexture(nodeName: node.name!, newTexture: color)
       
            trembelBlock()
        
        allColorSets.remove(at: randomNum)
        } else {
            
            openTimer.invalidate()
            
            //爆破完後再計分才正確
            countScore()

        
        }
    }
    
    func trembelBlock(){
        
            for i in 0 ..< alreadySelected.count{
                let x = alreadySelected[i][0]
                let y = alreadySelected[i][1]
               
                
                let blockLabel = findLabelNode(name: "\(x)-\(y)BL")
                let currentWordSyls = wordSets[currentWordSequence].components(separatedBy: " ")
                
                if currentWordSyls.contains(blockLabel.text!){
                    
                    
                    let trembleLeft = SKAction.rotate(toAngle: CGFloat(Double.pi / 36), duration: 0.2)
                    let trembleRight = SKAction.rotate(toAngle: CGFloat(Double.pi / -36), duration: 0.2)
                    
                    let sequence = SKAction.sequence([trembleLeft,trembleRight])
                  
                    let block = findImageNode(name: "\(x)-\(y)")
                    let repeatAction = SKAction.repeatForever(sequence)
                    block.run(repeatAction)
                    
                }
            }
        
    }
    
    func stopTremble(){
        for i in 0 ..< allPossibilities.count{
            let x = allPossibilities[i][0]
            let y = allPossibilities[i][1]
            let block = findImageNode(name: "\(x)-\(y)")
            let rotateBack = SKAction.rotate(toAngle: blockAngle, duration: 0.1)
            block.removeAllActions()
            block.run(rotateBack)
            
        }

    }
    
    func battleModeWrong(){
        print("wrong")
    }

    
    func countScore(){
        let scoreLabel = findLabelNode(name: "scoreLabel")
        let scoreNumber = scoreLabel.text
        var rightWordsCount = 0

        for i in 0 ..< alreadySelected.count{
            let x = alreadySelected[i][0]
            let y = alreadySelected[i][1]
            let blockLabel = findLabelNode(name: "\(x)-\(y)BL")
            let block = findImageNode(name: "\(x)-\(y)")
            let currentWordSyls = wordSets[currentWordSequence].components(separatedBy: " ")
            if currentWordSyls.contains(blockLabel.text!){
             
                rightWordsCount += 1
                
                let cgPoint = findLabelNode(name: "scoreLabel").frame.origin
                let blockWidth = block.frame.width
                let blockHeight = block.frame.height
                let flyAction = SKAction.move(to: cgPoint, duration: 0.3)
                let becomeSmall = SKAction.resize(toWidth: blockWidth / 3, height: blockHeight / 3, duration: 0.3)
                let fadeOut = SKAction.fadeOut(withDuration: 0.3)
                let groupAction = SKAction.group([flyAction,becomeSmall,fadeOut])
                blockLabel.run(groupAction)
                block.run(groupAction)
                
            }

        }

        scoresToAdd = rightWordsCount * 30
        
        countScoreTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(NewGameScene.scoreAnimation), userInfo: nil, repeats: true)
        
        countScoreTimer.fire()
        
    }
    
    @objc func scoreAnimation(){
        
        let scoreLabel = findLabelNode(name: "scoreLabel")
        var scoreNumber = scoreLabel.text
        if addedScore < scoresToAdd{
            addedScore += 10
            scoreLabel.text = String(Int(scoreNumber!)! + 10)

        } else {
            countScoreTimer.invalidate()
            
            //分數算完後接著判定是否下一場比賽
            nextBattle()
            
            
        }
    }
    
    
    func nextBattle(){
        
        findLabelNode(name: "tempWord").fontColor = .white
        findLabelNode(name: "tempWord").text = ""
        findLabelNode(name: "tempWord").fontSize = 80
        
        if currentWordSequence < (unitNumber + 1) * 3 - 1{
            
            currentWordSequence += 1
            
            //開始戰鬥, 建立下一個單字
            
            setUpGameScreen()
        } else {
            
            //回合結束
            
        }
        
    }
    
}

extension Array where Element: Hashable {
    var orderedSet: Array {
        return NSOrderedSet(array: self).array as? Array ?? []
    }
}

extension Array {
    mutating func shuffled() {
        for _ in self {
            // generate random indexes that will be swapped
            var (a, b) = (Int(arc4random_uniform(UInt32(self.count - 1))), Int(arc4random_uniform(UInt32(self.count - 1))))
            if a == b { // if the same indexes are generated swap the first and last
                a = 0
                b = self.count - 1
            }
            self.swapAt(a, b)
        }
    }
}

