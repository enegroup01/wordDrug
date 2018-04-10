//
//  NewGameScene.swift
//  wordDrug
//
//  Created by Ethan on 2018/2/1.
//  Copyright © 2018年 playplay. All rights reserved.
//

import SpriteKit
import GameplayKit

let leaveGameKey = "leaveGame"
let startToRecognizeKey = "startToRecognize"
let pronounceWordKey = "pronounceWord"
let addScoreKey = "addScore"

class NewGameScene: SKScene {

    
        var syllableSets = [[String]()]
    
    //以下為各地圖的音節
    let map1SyllableSets = [["ab1","ac1","ad1","a_e1","af1","ai1","al1","am1","an1","any1"],
                            ["ap1","ar1","as1","at1","au1","aw1","ay1","ba1","be1","bi1"],
                            ["bit1","bl1","bo1","br1","bu1","by1","ce1","ch1","ci1","ble1"],
                            ["ck1","cl1","co1","com1","con1","di1","cr1","ct1","de1","cian1"],
                            ["do1","dr1","dy1","dis1","ea1","ee1","el1","en1","er1","em1"],
                            ["et1","ew1","ex1","ey1","fi1","fl1","fo1","fr1","ft1","ful1"],
                            ["ge1","gi1","gl1","go1","gr1","he1","hi1","id1","ie1","igh1"],
                            ["il1","im1","in1","ing1","ir1","is1","ject1","le1","li1","kn1"],
                            ["ly1","mi1","nd1","no1","oa1","ob1","o_e1","of1","oi1","nt1"],
                            ["old1","on1","ong1","oo1","op1","or1","ot1","ou1","ow1","oy1"],
                            ["ph1","pi1","pl1","pr1","cop1","ro1","ry1","sh1","si1","re1"],
                            ["sk1","so1","st1","sion1","th1","ti1","tion1","tive1","tle1","sp1"],
                            ["to1","tr1","ty1","ub1","u_e1","ui1","um1","un1","up1","ture1"],
                            ["ur1","ut1","war1","wh1","ab2","ac2","ad2","a_e2","ai2","af2"],
                            ["er34","er35","er36","ea34","ea35","ble4","ble5","fr3","at4","ple2"]]
    
    let map2SyllableSets = [["al2","am2","an2","ar2","as2","at2","au2","aw2","ay2","be2"],
                            ["bo2","bu2","ce2","ch2","ck2","cl2","co2","com2","cr2", "con2"],
                            ["di2","do2","dr2","ea2","ee2","el2","en2","er2","et2", "em2"],
                            ["ew2","ex2","ey2","fi2","fr2","gr2","hi2","ie2","igh2","ge2"],
                            ["il2","im2","in2","ing2","ir2","is2","ly2","oa2","o_e2", "nd2"],
                            ["oi2","on2","ong2","oo2","op2","or2","ot2","ou2","ow2","ph2"],
                            ["pr2","ness1","re2","ry2","sh2","sk2","st2","th2","tion2","tr2"],
                            ["ture2","u_e2","i_e1","i_e2","ue1","ue2","ui2","um2","un2","ty2"],
                            ["up2","ur2","wh2","a_e3","ai3","al3","am3","an3","ac3","ad3"],
                            ["ar3","at3","aw3","ay3","be3","ce3","ch3","ck3","cl3","au3"],
                            ["ea3","ee3","el3","em3","en3","er3","et3","ex3","ey3","con3"],
                            ["i_e3","igh3","im3","in3","ing3","ir3","o_e3","oa3","oi3", "ge3"],
                            ["on3","ong3","oo3","op3","or3","ot3","ou3","ow3","pr3","gar1"],
                            ["re3","sh3","st3","th3","tion3","tr3","ty3","u_e3","ui3","ry3"],
                            ["er37","er38","er39","er40","er41","er42","er43","er44","er45","er46"]]
    
    let map3SyllableSets = [["un3","ur3","wh3","a_e4","ad4","ai4","al4","am4","an4","um3"],
                            ["ar4","au4","ay4","ce4","ch4","ck4","ea4","ee4","el4","em4"],
                            ["en4","er4","ex4","ge4","i_e4","igh4","im4","in4","ing4","ir4"],
                            ["o_e4","oa4","on4","oo4","or4","ot4","ou4","ow4","mo1","pr4"],
                            ["re4","sh4","st4","th4","ui4","um4","un4","ur4","a_e5","tion4"],
                            ["ad5","ai5","al5","am5","an5","ar5","au5","ay5","ce5","ch5"],
                            ["ck5","ea5","ee5","el5","en5","er5","ge5","i_e5","in5","im5"],
                            ["ing5","ir5","o_e5","oa5","oo5","or5","ou5","ow5","go2","pr5"],
                            ["sh5","st5","th5","tion5","un5","ur5","a_e6","ai6","al6","am6"],
                            ["an6","ar6","ay6","ce6","ch6","ck6","ea6","ee6","el6","en6"],
                            ["er6","i_e6","in6","ing6","o_e6","oo6","or6","ou6","ow6","oa6"],
                            ["pr6","buy1","sh6","st6","th6","un6","ur6","a_e7","ai7","tion6"],
                            ["al7","am7","an7","ar7","ay7","ch7","ea7","ee7","el7","ce7"],
                            ["en7","er7","i_e7","in7","ing7","oo7","or7","ou7","ow7","gy1"],
                            ["er47","er48","er49","er50","er51","er52","ea36","ea37","ea38","ce9"]]
    
    let map4SyllableSets = [["sh7","st7","th7","a_e8","ai8","al8","am8","an8","ar8","ay8"],
                            ["ce8","ea8","ee8","el8","en8","er8","i_e8","in8","ing8","ch8"],
                            ["oo8","or8","ou8","ow8","nic1","st8","th8","a_e9","ai9","sh8"],
                            ["al9","an9","ar9","ay9","ea9","ee9","el9","er9","i_e9","en9"],
                            ["in9","oo9","or9","ou9","ow9","ple1","st9","th9","a_e10","ai10"],
                            ["al10","an10","ar10","ea10","ee10","el10","en10","er10","i_e10","ay10"],
                            ["in10","oo10","or10","ou10","ow10","vil1","st10","a_e11","ai11","al11"],
                            ["an11","ar11","ay11","ea11","ee11","el11","en11","er11","i_e11","in11"],
                            ["oo11","or11","ow11","ju1","st11","a_e12","al12","an12","ar12","ai12"],
                            ["ou11","ea12","ee12","el12","en12","er12","i_e12","in12","or12","oo12"],
                            ["ou12","ow12","que1","sc1","sent1","sic1","so2","st12","stle1","ult1"],
                            ["zle1","a_e13","ai13","al13","ame1","an13","ar13","bed1","ble2","bt1"],
                            ["by2","cle1","cus1","dis2","ea13","ee13","el13","en13","er13","cian2"],
                            ["ge6","gh1","gi2","gn1","gu1","i_e13","in13","lar1","mb1","mid1"],
                            ["st17","an21","ng1","ge7","ou22","str1","pi2","ca1","ax1","ax2"]]
    
    let map5SyllableSets = [["mi2","mi3","mud1","na1","nd3","ny1","olf1","oo13","ood1","or13"],
                            ["ou13","st13","sw1","tle2","a_e14","al14","an14","ar14","ea14","sym1"],
                            ["ee14","en14","er14","i_e14","in14","oo14","or14","ou14","st14","a_e15"],
                            ["al15","an15","ar15","ea15","ee15","en15","er15","i_e15","in15","oo15"],
                            ["or15","ou15","st15","al16","an16","ea16","ee16","en16","er16","ar16"],
                            ["oo16","or16","ou16","st16","al17","an17","ar17","ea17","ee17","in16"],
                            ["en17","er17","in17","oo17","or17","ou17","al18","an18","ea18","ar18"],
                            ["ee18","en18","er18","in18","or18","ou18","an19","ea19","ee19","al19"],
                            ["en19","er19","or19","ou19","al20","ea20","ee20","en20","er20","an20"],
                            ["or20","ou20","ea21","ee21","en21","er21","or21","ou21","ea22","al21"],
                            ["ee22","en22","er22","or22","ea23","ee23","en23","er23","or23","ee24"],
                            ["ea24","en24","er24","or24","en25","er25","ea25","ea26","en26","or25"],
                            ["er26","ea27","en27","er27","ea28","en28","er28","ea29","en29","er29"],
                            ["ea30","en30","er30","ea31","er31","ea32","er32","ea33","er33","en31"],
                            ["bet1","a_e16","ba2","ban1","bar1","bl2","br2","br3","br4","ble3"]]
    
    //特殊顏色
    let lightGreen = UIColor.init(red: 196/255, green: 255/255, blue: 137/255, alpha: 1)
    let darkWordColor = UIColor.init(red: 104/255, green: 129/255, blue: 130/255, alpha: 1)
    let lightPink = UIColor.init(red: 255/255, green: 217/255, blue: 239/255, alpha: 100)
    let selectWordDarkColor = UIColor.init(red: 62/255, green: 60/255, blue: 61/255, alpha: 1)
    //分數顏色
    let pinkColor = UIColor.init(red: 1, green: 153/255, blue: 212/255, alpha: 1)
    let hintWordBlue = UIColor.init(red: 52/255, green: 136/255, blue: 182/255, alpha: 1)
    
    
    
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
    
    //暫時使用的句子
    var sentenceSets = [String]()
    
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
    
    //var words = NSMutableAttributedString()
    
    //發音單字
    var wordsToPronounce = String()
    
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
    
    //存放三個中文字
    var allThreeChiWords = [String]()
    var allThreeEngWords = [String]()

    var mapNumber = Int()
    
    //控制是否為第二次聽考
    var isBackToSpell = false
    
    var countScoreTimer = Timer()
    var answerTime = 0
    

    
    //紀錄已加過的分數
    var scoreAdded = Int()
    var isFinalGetPoint = false
    
    //紀錄三個字的正確與否
    var correctResults = ["0","0","0"]
    
    //記錄我的最愛以及錯誤單字
    
    override func didMove(to view: SKView) {
        
    
        
        //啟動離開遊戲
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyLeaveGame), name: NSNotification.Name("leaveGame"), object: nil)
        
        
        //口試Nc (單字 + 句子)
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyStartToRecognize), name: NSNotification.Name("startToRecognize"), object: nil)
        
        
        //接收聽考Nc
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.backToSpell), name: NSNotification.Name("backToSpell"), object: nil)
        
        
        //啟動造句子Nc
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyShowSentence), name: NSNotification.Name("showSentence"), object: nil)
        
        
        
        //接收下個單字
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.receiveCorrectPracticeNextWord), name: NSNotification.Name("practiceNextWord"), object: nil)
        
        
        
        //重新寫NC
        //1. 啟動發音
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyPronounceWord), name: NSNotification.Name("pronounceWord"), object: nil)
        
        
        //計分
                NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.addScore), name: NSNotification.Name("addScore"), object: nil)
        
      //接受倒數
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.startCountDown), name: NSNotification.Name("startCountDown"), object: nil)
        
        
        //啟動時間到
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyTimesUp), name: NSNotification.Name("timesUp"), object: nil)

        
        //啟動顯示tagView
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyShowTag), name: NSNotification.Name("showTag"), object: nil)
        
        
        //啟動顯示tagView
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.readyToReadSentence), name: NSNotification.Name("readyToReadSentence"), object: nil)
        
        //啟動顯示tagView
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyReadSentence), name: NSNotification.Name("readSentence"), object: nil)

        
        //載入各種字
        loadAllKindsOfWord()
        
        //設定畫面
        setUpScreen()
        
        //避免多次按
        self.view?.isMultipleTouchEnabled = false
    }
    
    //載入各種字
    func loadAllKindsOfWord(){
        

        
        //讀取所有錯誤的字供比對
        if let myWrongWordsString = user!["wrongWords"] as! String?{
            myWrongWords = myWrongWordsString.components(separatedBy: ";")
            print("myWrongWords:\(myWrongWords)")
        }
        
        print("unitNumber:\(unitNumber)")
        print("spotNumber:\(spotNumber)")
        //測試用
        /*
         spotNumber = 13
         unitNumber = 7
         */
        //抓正確unit
        currentWordSequence = 3 * unitNumber
        firstSequence = currentWordSequence
        
        //抓正確的音節
        
        //設定地圖的音節
        switch mapNumber {
        case 1:
            syllableSets = map1SyllableSets
        case 2:
            syllableSets = map2SyllableSets
        case 3:
            syllableSets = map3SyllableSets
        case 4:
            syllableSets = map4SyllableSets
        case 5:
            syllableSets = map5SyllableSets
        default:
            break
        }
        
        
        syllables = syllableSets[spotNumber]
        
        //讀取Bundle裡的文字檔
        var wordFile:String?
        
        let name = String(mapNumber) + "-" + String(spotNumber + 1)
        print("name:\(name)")
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
        
        
        /*
         //讀取Bundle裡的文字檔
         var sentenceFile:String?
         
         let sentenceName = "s" + String(mapNumber) + "-" + String(spotNumber + 1)
         
         if let filepath = Bundle.main.path(forResource: sentenceName, ofType: "txt") {
         do {
         sentenceFile = try String(contentsOfFile: filepath)
         let sentences = sentenceFile?.components(separatedBy: "; ")
         
         //把字讀取到wordSets裡
         sentenceSets = sentences!
         //print(contents)
         } catch {
         // contents could not be loaded
         }
         } else {
         // example.txt not found!
         }
         */
        //print(sentenceSets)
        
        //print(wordSets)
        
    }
    
    
    //載入畫面
    func setUpScreen(){
        
        //背景
        makeImageNode(name: "gameBg", image: "newGameBg", x: 0, y: 0, width: 754, height: 1334, z: 0, alpha: 1, isAnchoring: false)
        
        makeImageNode(name: "recogWordsBg", image: "recogWordsBg", x: 0, y: 0, width: 750, height: 228, z: 10, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "countDownLine", image: "countDownLine", x: -375, y: -114, width: 750, height: 5, z: 11, alpha: 0, isAnchoring: true)
        
        
        //單字元素, 這部分是新的
        //makeImageNode(name: "elementToShow", image: "elemExample", x: -290, y: 590, width: 80, height: 80, z: 1, alpha: 1, isAnchoring: false)
        
        //單字等級label
        //makeLabelNode(x: 0, y: 600, alignMent: .center, fontColor: lightGreen, fontSize: 40, text: "英檢初級", zPosition: 1, name: "levelTitle", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        
        //單字量Label, 這部分是新的
        makeLabelNode(x: 350, y: 550, alignMent: .right, fontColor: pinkColor, fontSize: 35, text: "0", zPosition: 1, name: "scoreLabel", fontName: "Helvetica Neue", isHidden: false, alpha: 1)
        
        //得分Label, 這部分是新的
        //makeLabelNode(x: 330, y: 555, alignMent: .right, fontColor: .white, fontSize: 40, text: "0", zPosition: 1, name: "scoreLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        
        //提示字
        makeLabelNode(x: -425, y: 0, alignMent: .center, fontColor: .white, fontSize: 50, text: "", zPosition: 1, name: "hintLeftLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        makeLabelNode(x: 425, y: 0, alignMent: .center, fontColor: .white, fontSize: 50, text: "", zPosition: 1, name: "hintRightLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        
        //製作按鈕
        let lightWidth:CGFloat = 150
        let lightHeight:CGFloat = 150
        let darkWidth:CGFloat = 150
        let darkHeight:CGFloat = 150
        let lightImg:String = "lightSelBtn"
        let darkImg:String = "darkSelBtn"
        let positions = [[-135,-500],[-230,-280],[135,-500],[230,-280],[0,-90]]
        
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
        makeImageNode(name: "leftChiBtn", image: "leftRoundedSqr", x: -187, y: -365, width: 320, height: 320, z: 7, alpha: 0, isAnchoring: false)
        makeImageNode(name: "rightChiBtn", image: "rightRoundedSqr", x: 187, y: -365, width: 320, height: 320, z: 7, alpha: 0, isAnchoring: false)
        
        //加入中文字選項的node
        leftChiNode.position = CGPoint(x: -187, y: -375)
        leftChiNode.horizontalAlignmentMode = .center
        leftChiNode.fontSize = 60
        leftChiNode.fontColor = .white
        leftChiNode.zPosition = 8
        leftChiNode.name = "leftChi"
        leftChiNode.fontName = "Helvetica Bold"
        
        addChild(leftChiNode)
        
        rightChiNode.position = CGPoint(x: 187, y: -375)
        rightChiNode.horizontalAlignmentMode = .center
        rightChiNode.fontSize = 60
        rightChiNode.fontColor = .white
        rightChiNode.zPosition = 8
        rightChiNode.name = "rightChi"
        rightChiNode.fontName = "Helvetica Bold"
        
        addChild(rightChiNode)
        
        
        //建立三個單字
        
        firstEngWordLabel.frame = CGRect(x: 187.5 + 375, y: 110, width: 200, height: 80)
        //firstEngWordLabel.backgroundColor = .cyan
        firstEngWordLabel.textColor = darkWordColor
        firstEngWordLabel.textAlignment = .center
        firstEngWordLabel.adjustsFontSizeToFitWidth = true
        firstEngWordLabel.font = UIFont(name: "Helvetica Bold", size: 70)
        firstEngWordLabel.text = ""
        self.view?.addSubview(firstEngWordLabel)
        
        //英文單字的Node
        firstChiWordLabel.frame = CGRect(x: 187.5 + 375, y: 205, width: 90, height: 40)
        //firstChiWordLabel.backgroundColor = .green
        firstChiWordLabel.textColor = pinkColor
        firstChiWordLabel.textAlignment = .center
        firstChiWordLabel.adjustsFontSizeToFitWidth = true
        firstChiWordLabel.font = UIFont(name: "Helvetica Bold", size: 30)
        firstChiWordLabel.text = ""
        self.view?.addSubview(firstChiWordLabel)
        
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
        
        //這個engWords是尚未attr的, attr完的是
        var allThreeEngWordsArray = [[String]]()
        
        
        let quarterCount = wordSets.count / 3
        let engWord0 = wordSets[currentWordSequence].components(separatedBy: " ")
        let chiWord0 = wordSets[quarterCount +  currentWordSequence]
        let engWord1 = wordSets[currentWordSequence + 1].components(separatedBy: " ")
        let chiWord1 = wordSets [quarterCount +  currentWordSequence + 1]
        let engWord2 = wordSets[currentWordSequence + 2].components(separatedBy: " ")
        let chiWord2 = wordSets [quarterCount +  currentWordSequence + 2]
        
        
        allThreeEngWordsArray.append(engWord0)
        allThreeEngWordsArray.append(engWord1)
        allThreeEngWordsArray.append(engWord2)
        
        for i in 0 ..< allThreeEngWordsArray.count{
            var word = String()
            
            for syl in allThreeEngWordsArray[i]{
                
                word = word + syl
            }
            
            
            allThreeEngWords.append(word)
        }
        
        
        //append中文字
        allThreeChiWords.append(chiWord0)
        allThreeChiWords.append(chiWord1)
        allThreeChiWords.append(chiWord2)
        
        //字型顏色
        let attrs0 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 70), NSAttributedStringKey.foregroundColor : UIColor.white]
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 70), NSAttributedStringKey.foregroundColor : UIColor.cyan]
        
        
        //先抓音節
        syllablesToCheck = syllables[unitNumber]
        //去掉數字
        syllablesWithoutDigit = (syllablesToCheck.components(separatedBy: NSCharacterSet.decimalDigits) as NSArray).componentsJoined(by: "")
        
        
        var attrWords = [[NSMutableAttributedString](),[NSMutableAttributedString](),[NSMutableAttributedString]()]
        
        //以下為生成attr的步驟
        //1. 確認是否是specialE
        
        if syllablesWithoutDigit.contains("_"){
            //specialE的作法
            
            var characters = [Character]()
            let vowels = ["a","e","i","o","u"]
            
            //每一個英文字節拆字母
            for w in 0 ..< allThreeEngWordsArray.count{
                
                for i in 0 ..< allThreeEngWordsArray[w].count{
                    
                    characters.removeAll(keepingCapacity: false)
                    
                    for c in allThreeEngWordsArray[w][i]{
                        
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
            for w in 0 ..< allThreeEngWordsArray.count{
                
                //抓array的音節,  只抓一個字
                for i in 0 ..< allThreeEngWordsArray[w].count{
                    
                    if let engWord = allThreeEngWordsArray[w][i] as String?{
                        
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
        
        
        //*** 以下為共同的造字func, 把字造到words裡
        
        for w in 0 ..< attrWords.count {
            
            for i in 0 ..< attrWords[w].count { //[w]
                
                if i == 0 {
                    words[w] = attrWords[w][i] //[w]
                    
                } else {
                    words[w].append(attrWords[w][i]) //[w]
                }
            }
        }
        
        
        //造完字後顯示出英文部分
        firstEngWordLabel.attributedText = words[0]
        
        
        //顯示中文字
        firstChiWordLabel.text = chiWord0
        
        
        //造完字單字滑入 - 一次性動畫
        slideInAnimation()
        
    }
    
    
    
    //Part 3. slideIn: 單字滑進來
    func slideInAnimation(){
        
        UIView.animate(withDuration: 0.3, animations: {[weak self] in
            
            self!.firstEngWordLabel.center.x = 187.5
            
        })
        
        UIView.animate(withDuration: 0.3, animations: {[weak self] in
            self!.firstChiWordLabel.center.x = 187.5
            }, completion: { [weak self](finished:Bool) in
                if finished{
                    
                    //設定發音單字
                    self!.wordsToPronounce = self!.wordSets[self!.currentWordSequence].replacingOccurrences(of: " ", with: "")
                    
                    
                    //發音NC
                    /*
                    let wordToPass:[String:String] = ["wordToPass":self!.wordsToPronounce]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pronounceWord"), object: nil, userInfo: wordToPass)
                    */
                    
                    let wordToPass:[String:Any] = ["wordToPass":self!.wordsToPronounce,"pronounceTime":1]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pronounceWord"), object: nil, userInfo: wordToPass)
                    
                    
                    self!.practice()
                    
                 
                    
                    
                }
                
        })
        
        
    }
    
    @objc func notifyShowTag(){
        
    }
    
    @objc func readyToReadSentence(){
        
        hintSlideIn(leftText: "換你", rightText: "發音", waitTime: 1.3) {
            
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "readSentence"), object: nil, userInfo: nil)
            
        }
    }
    
    @objc func notifyReadSentence(){
        
                findImageNode(name: "recogWordsBg").alpha = 1
    }
    
    @objc func startCountDown(){
        //開始倒數tagQuestion
        
        let lineNode = findImageNode(name: "countDownLine")
        lineNode.alpha = 1
    
        
         let countDownAction = SKAction.resize(toWidth: 0, duration: 10)
        
        lineNode.run(countDownAction) {[weak self] in
            
            print("stop counting")
                //timesUp
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "timesUp"), object: nil, userInfo: nil)
            
                self!.practiceNextWord()

            
        }
        
        
    }
    
    @objc func notifyTimesUp(){
        
        
    }
    
    @objc func backToSpell(_ notification:NSNotification){
        
        //抓分數
        if let addScore = notification.userInfo?["addScore"] as? Int{
            
            countScore(score: addScore)
        }
        
        isUserInteractionEnabled = false
        
        //隱藏上方的單字換成對話框
        firstEngWordLabel.isHidden = true
        firstChiWordLabel.isHidden = true
        
        //錄音字欄位
        findImageNode(name: "recogWordsBg").alpha = 0
        
        //建立說話圖示
        makeImageNode(name: "talkPng", image: "talkPng", x: 0, y: 380, width: 256, height: 210, z: 1, alpha: 1, isAnchoring: false)
        
        
        //宣告此為第二次練習
        isBackToSpell = true
        
        //練習
        practice()
        
    }
    
    /*
    @objc func addScore(_ notification:NSNotification){
        
        if let addScore = notification.userInfo?["addScore"] as? Int{
            
            countScore(score: addScore)
        }
        
        
    }
    */
    
    @objc func addScore(_ notification:NSNotification){
        
        if let addScore = notification.userInfo?["addScore"] as? Int{
            
            countScore(score: addScore)
        }
        
        //有finalPoints就是要繼續tagPressed
        if let finalPoints = notification.userInfo?["finalPoints"] as? Int{
            
            //顯示得分比例, 然後再倒數tag Question
            
            var color = String()
            switch finalPoints{
            case ..<70:
                color = "red"
            case 70...:
                
                color = "green"
            default:
                break
            }
            
            
                //顯示tag畫面
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showTag"), object: nil, userInfo: nil)
                
                //發音句子
                
                let contents:[String:Int] = ["pronounceTime":1]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pronounceWord"), object: nil, userInfo: contents)
                
                //tag倒數
                startCountDown()
            
            
            
            
        }
    
        
    }
    
    
    @objc func notifyPronounceWord(){
        
    }
    

    
    
    deinit {
        print("deinit")
        NotificationCenter.default.removeObserver(self)
    }
    //練習模式
    func practice(){
        
        hintSlideIn(leftText: "連線", rightText: "拼字",waitTime: 1) {[weak self] in
            
            
            //是否要發音, 判斷是不是第一個字
            var shouldPronounce = Bool()
            
            //暫時都不改變等待時間 var - let
            let waitTime = DispatchTime.now() + 0.6
            
            //等待發音練完後再進入練習
            /*
            if self!.currentPracticeSequence != 0 {
                waitTime = DispatchTime.now() + 0.6
            }
*/
            //首先指定好上方中英文的label
            
            
            DispatchQueue.main.asyncAfter(deadline: waitTime) {[weak self] in
                
                switch self!.currentPracticeSequence{
                    
                case 0:
                    
                    //設定不發音
                    if self!.isBackToSpell{
                        
                        shouldPronounce = true
                        
                    } else {
                        shouldPronounce = false
                        self!.isUserInteractionEnabled = true
                        //發音完後變色
                        self!.firstEngWordLabel.textColor = self!.darkWordColor

                    }
                    
                    
                case 1...:

                    self?.firstEngWordLabel.attributedText = self!.words[self!.currentPracticeSequence]
                    self!.firstChiWordLabel.text = self!.allThreeChiWords[self!.currentPracticeSequence]
                    
                    self!.wordsToPronounce =  self!.wordSets[self!.currentWordSequence].replacingOccurrences(of: " ", with: "")
                    shouldPronounce = true

                default:
                    break
                }
                
                
                if shouldPronounce{
                    
                    
                    //發音, 用再seq > 0, backToSpell, practiceNextWord
                    
                    //目前都只念一次, 暫時保留
                    var speakTime = Int()
                    if self!.isBackToSpell{
                        speakTime = 1
                        
                    } else {
                        //2改成1
                        speakTime = 1
                    }
                    
                    
                    
                    let wordToPass:[String:Any] = ["wordToPass":self!.wordsToPronounce,"pronounceTime":speakTime]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pronounceWord"), object: nil, userInfo: wordToPass)
                    
                    //發音後等一下再變黑
                    let when = DispatchTime.now() + 0.3
                    
                    DispatchQueue.main.asyncAfter(deadline: when, execute: {
                        self!.firstEngWordLabel.textColor = self!.darkWordColor
                        self!.isUserInteractionEnabled = true
                    })

                    
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
        for i in 0 ..< wordSets.count / 3{
            
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
        let positions = [[-135,-515],[-230,-295],[135,-515],[230,-295],[0,-105]]
        
        
        for i in 0 ..< shownWords.count{
            
            makeLabelNode(x: CGFloat(positions[i][0]), y: CGFloat(positions[i][1]), alignMent: .center, fontColor: .white, fontSize: 50, text: shownWords[i], zPosition: 5, name: shownWords[i] + String(i) + "Sel", fontName: "Helvetica", isHidden: false, alpha: 1)
            
            
            //把建立的選項名稱放入array裡
            selNodeNames.append(shownWords[i] + String(i) + "Sel")
            
        }
        
        //可按按鍵
        isUserInteractionEnabled = true
        
        //啟動連線功能
        isDragAndPlayEnable = true
        
    }

    
    func countScore(score:Int){
        
        let scoreToPass:[String:Int] = ["Score":score]

        countScoreTimer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(NewGameScene.startCounting), userInfo: scoreToPass, repeats: true)
        
        
    }
    

    @objc func startCounting(){

        
        if let userInfo = countScoreTimer.userInfo as? Dictionary<String, Int>{
            if let scoreToAdd = userInfo["Score"]{
                let scoreLabel = findLabelNode(name: "scoreLabel")
              
                let size = CGSize(width: 100, height: 100)
        
                
                if scoreAdded < scoreToAdd {
                
                scoreAdded += 10
                    scoreLabel.text = String(Int(scoreLabel.text!)! + 10)
                } else {
                    
                    scoreAdded = 0
                    countScoreTimer.invalidate()
                    
                }
                
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            
            location = touch.location(in: self)
            
            let node : SKNode = self.atPoint(location)
            
            
            
            //之後要寫中文錯誤的機制
            //確認中文正確與否
            if node.name == "leftChiBtn" || node.name == "leftChi"{
                if leftOrRight == 0 {
                    //答對
                    
                    changeImageAlfa(name: "leftChiBtn", toAlpha: 0, time: 0.1)
                    //changeImageAlfa(name: "rightChiBtn", toAlpha: 0, time: 0.1)
                    
                    makeImageNode(name: "mark", image: "rightCircle", x: -190, y: -355, width: 275, height: 275, z: 9, alpha: 1, isAnchoring: false)
                    makeImageNode(name: "mark", image: "wrongX", x: 190, y: -355, width: 202, height: 214, z: 9, alpha: 1, isAnchoring: false)
                    
                    let when = DispatchTime.now() + 0.3
                    DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                        self!.chooseChineseResult(isCorrect: true)
                    })
                    
                    
                }else{
                    //答錯
                    changeImageAlfa(name: "leftChiBtn", toAlpha: 0, time: 0.1)
                    //changeImageAlfa(name: "rightChiBtn", toAlpha: 0, time: 0.1)
                    makeImageNode(name: "mark", image: "rightCircle", x: 190, y: -355, width: 275, height: 275, z: 9, alpha: 1, isAnchoring: false)
                    
                    makeImageNode(name: "mark", image: "wrongX", x: -190, y: -355, width: 202, height: 214, z: 9, alpha: 1, isAnchoring: false)
                    
                    /*
                     findLabelNode(name: "tempWord").text = "答錯"
                     findLabelNode(name: "tempWord").fontColor = lightPink
                     findLabelNode(name: "tempWord").fontSize = 60
                     */
                    let time = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: time, execute: {[weak self] in
                        
                        self!.chooseChineseResult(isCorrect: false)
                        
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
                    
                    
                    let when = DispatchTime.now() + 0.3
                    DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                        self!.chooseChineseResult(isCorrect: true)
                    })
                    
                }else{
                    //答錯
                    
                    //答錯
                    //changeImageAlfa(name: "leftChiBtn", toAlpha: 0, time: 0.1)
                    changeImageAlfa(name: "rightChiBtn", toAlpha: 0, time: 0.1)
                    makeImageNode(name: "mark", image: "rightCircle", x: -190, y: -355, width: 275, height: 275, z: 9, alpha: 1, isAnchoring: false)
                    
                    
                    makeImageNode(name: "mark", image: "wrongX", x: 190, y: -355, width: 202, height: 214, z: 9, alpha: 1, isAnchoring: false)
                    /*
                     findLabelNode(name: "tempWord").text = "答錯"
                     findLabelNode(name: "tempWord").fontColor = lightPink
                     findLabelNode(name: "tempWord").fontSize = 60
                     */
                    let time = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: time, execute: {[weak self] in
                        self!.chooseChineseResult(isCorrect: false)
                    })
                    
                    
                }
                
            }
            
            //**** 開始拖拉遊戲 dragAndPlay ***
            if isDragAndPlayEnable {
                
                print("began dragAndPlay")
                
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
                            
                           
                            
                            //移除選項
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
            
            
            print(touchTimes)
            if isDragAndPlayEnable{
                print("dragAndPlay")
                
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
                
                //初始化
                //isFirstTouch = false
                touchTimes = 0
                isTouched = false
                nodesTouched.removeAll(keepingCapacity: false)
                
                //假如答案正確
                if wordEntered == currentWordArray{
                    
                    print("right answer")

                        //練習模式
                        //1. 把顯示的輸入字得分, 往上飄的動畫
                        rightScore()
                    
           
                    
                        //以下兩兩個是聽考模式的協助功能
                        //移除talk圖示
                        removeSomeNodes(name: "talkPng")
                    
                        //顯示英文字
                        firstEngWordLabel.isHidden = false
                    
                        //2. 顯示原本有音節變色的字
                        firstEngWordLabel.attributedText = words[currentPracticeSequence]
                    
                        //不能按畫面
                        self.isUserInteractionEnabled = false
                    
                    
                        //如果是聽考模式就跳到選中文
                        if isBackToSpell {
                            
                            //計分
                            var score = Int()
                            
                            if answerTime == 0 {
                                
                                score = 300
                                
                            } else if answerTime == 1 {
                                
                                score = 150
                                
                                answerTime = 0
                            }
                            
                            countScore(score: score)
                            
                            //跳到中文練習
                            testChinese()
                            
                        } else {
                            
                         
                            //第一次練習, 非聽考模式
                            
                            /*
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pronounceWord"), object: nil, userInfo: nil)
                            */
                            //發音
                            let contents:[String:Int] = ["pronounceTime":1]
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pronounceWord"), object: nil, userInfo: contents)

                            
                            //初始化
                            shownWords.removeAll(keepingCapacity: false)
                            wordEntered.removeAll(keepingCapacity: false)
                            
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
                            
                            
                           
                            countScore(score: 100)
                            
                            
                            //在此卡一個正確動畫
                            
                            hintSlideIn(leftText: "很棒", rightText: "喔！", waitTime: 1, finished: {[weak self] in
                                
                                
                                self!.hintSlideIn(leftText: "換你", rightText: "發音", waitTime: 1.5, finished: {
                                    
                                    //口試
                                    //self!.recognizeWord()
                                    //開始辨認單字NC
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startToRecognize"), object: nil, userInfo: nil)
                                    
                                    //不能dragAndPlay
                                    self!.isDragAndPlayEnable = false
                                    
                                })
                                
                            })
                            
                           
        
                            
                            
                    
                            
                           
                        }
                    
    
                    
                } else {
                    
                    //答案錯誤的機制
                    
                    print("wrong answer")

                    //再次練習打錯的話就跳走, 之後要做答錯提示畫面
                    if isBackToSpell{
                        
                        
                        if answerTime < 1 {
                            answerTime += 1
                            //再次練習
                            
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

                            
                            
                        } else {
                            answerTime = 0
                            //失去機會
                            
                            //紀錄錯誤單字
                            correctResults[currentPracticeSequence] = "1"
                            let wrongWord = wordSets[currentWordSequence].replacingOccurrences(of: " ", with: "")
                            wrongWords.append(wrongWord)
                            print(wrongWords)
                            
                            
                            //以下兩兩個是聽考模式的協助功能
                            //移除talk圖示
                            removeSomeNodes(name: "talkPng")
                            
                            //顯示英文字
                            firstEngWordLabel.isHidden = false
                            
                            //2. 顯示原本有音節變色的字
                            firstEngWordLabel.attributedText = words[currentPracticeSequence]
                            
                            //把輸入字刪除
                            findLabelNode(name: "tempWord").text = ""
                            
                               testChinese()
                            
                            
                        }
                        
                     
                        

                    }else {
                    
                    
                      print("wrong Answer action")
                        
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
    
    
    //辨識單字
    func recognizeWord(){
        
        //隱藏不需要的東西

        
      
        
        
    }
    
    func testChinese(){
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
        let quarterCount = wordSets.count / 3
        let halfCount = wordSets.count / 3 * 2
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
        
        
    }
    
    
    //show句子
    @objc func notifyShowSentence(){
        
        //字隱藏
        
        firstEngWordLabel.text = ""
        firstChiWordLabel.text = ""
        firstEngWordLabel.isHidden = true
        firstChiWordLabel.isHidden = true
        findImageNode(name: "leftChiBtn").alpha = 0
        findImageNode(name: "rightChiBtn").alpha = 0
        leftChiNode.text = ""
        rightChiNode.text = ""
        removeSomeNodes(name: "mark")
        
    }
    
    
    @objc func receiveCorrectPracticeNextWord(){

        //countScore
        countScore(score: 500)
        
        practiceNextWord()
        isFinalGetPoint = true
        
    }
    
    func practiceNextWord(){
        
        
        let lineNode = findImageNode(name: "countDownLine")
        
        
        if currentWordSequence < (unitNumber + 1) * 3 - 1{
            
            
            //把倒數線回復並隱藏
            lineNode.removeAllActions()
            lineNode.size = CGSize(width: 750, height: 5)
            lineNode.alpha = 0
            
            currentWordSequence += 1
            currentPracticeSequence += 1
            
            shownWords.removeAll(keepingCapacity: false)
            wordEntered.removeAll(keepingCapacity: false)
            firstEngWordLabel.isHidden = false
            firstChiWordLabel.isHidden = false
            
            
            //準備下一個字的練習
            isBackToSpell = false
            
            findImageNode(name: "recogWordsBg").alpha = 0
            
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
            
            isFinalGetPoint = false
            
        } else {
            
            //抓三個單字的狀態 + 分數
            lineNode.removeAllActions()
            let scoreLabel = findLabelNode(name: "scoreLabel")
            
            var scoreToPass = scoreLabel.text!
            if isFinalGetPoint{
                scoreToPass = String(Int(scoreLabel.text!)! + 500)
            }
            
            
            addWrongWords()
            
            let threeWords:[String:[String]] = ["engWords":allThreeEngWords,"chiWords":allThreeChiWords,"score":[scoreToPass],"correctResults":correctResults]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "leaveGame"), object: nil, userInfo: threeWords)
            
            
            
        }

        
    }
    
    

    
    override func update(_ currentTime: TimeInterval) {
        
        
    }
    
    //*** 以下皆為一些自己建立的func 或是extension ***
    
    
    
    //新增錯誤單字
    
    func addWrongWords(){
        
        print("final wrongWords\(wrongWords)")
        if wrongWords.count > 0 {
            //確認有錯字
            
            for word in wrongWords{
                
                //避免重複
                if !myWrongWords.contains(word){
                    
                    print("wrongword:\(word)")
                    
                    let id = user?["id"] as! String
                    
                    // url to access our php file
                    let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/addWrongWord.php")!
                    
                    // request url
                    var request = URLRequest(url: url)
                    
                    // method to pass data POST - cause it is secured
                    request.httpMethod = "POST"
                    
                    // body gonna be appended to url
                    let body = "userID=\(id)&wrongWord=\(word)"
                    
                    // append body to our request that gonna be sent
                    request.httpBody = body.data(using: .utf8)
                    
                    URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
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
                                print(user!)
                                
                            } catch{
                                
                                print("catch error")
                                
                            }
                        } else {
                            
                            print("urlsession has error")
                            
                        }
                    }).resume()
                    
                }
            }
        }
        
    }
    
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
        
        
        if #available(iOS 11, *) {
            node.numberOfLines = 0
            
        } else {
            // Fallback on earlier versions
            
        }
        
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
    
    //暫時用不到
    
    @objc func stopPlayAudio(){
        
        SKAction.stop()
        
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
        
        let cgPoint = CGPoint(x: 0, y: firstEngWordLabel.frame.origin.y)
        let flyUp = SKAction.move(to: cgPoint, duration: 0.3)
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.3)
        
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
    
    func chooseChineseResult(isCorrect:Bool){
        
        //正確
        if isCorrect{
            
            countScore(score: 300)
        } else {
            //錯誤的話
            correctResults[currentPracticeSequence] = "1"
            let wrongWord = wordSets[currentWordSequence].replacingOccurrences(of: " ", with: "")
            
            if !wrongWords.contains(wrongWord){
                 wrongWords.append(wrongWord)
            }


        }
        
        let wordSequenceToPass:[String:Any] = ["currentWordSequence":String(currentWordSequence),"pronounceTime":1]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showSentence"), object: nil, userInfo: wordSequenceToPass)
        
        //不能拖拉
        isDragAndPlayEnable = false
        
    }
    
/*
     //抖動功能
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
*/
    
    func battleModeWrong(){
        print("wrong")
    }
    
    @objc func notifyStartToRecognize(){
        
        //顯示錄音文字背景
        findImageNode(name: "recogWordsBg").alpha = 1
    }
    
    @objc func notifyLeaveGame(){
        
        print("notified")
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

