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
let pauseKey = "pause"
let stopLimitTimerKey = "stopLimitTimer"
let playEndingMusicKey = "playEndingMusic"
let removePronounceBtnKey = "removePlaySoundBtn"

class NewGameScene: SKScene {

    var syllableSets = [[String]()]
    
    //集合所有音節在一起
    //var allSyllables = [String]()
    
    //特殊顏色
    let lightGreen = UIColor.init(red: 196/255, green: 255/255, blue: 137/255, alpha: 1)
    let darkWordColor = UIColor.init(red: 104/255, green: 129/255, blue: 130/255, alpha: 1)
    let lightPink = UIColor.init(red: 255/255, green: 217/255, blue: 239/255, alpha: 100)
    let selectWordDarkColor = UIColor.init(red: 62/255, green: 60/255, blue: 61/255, alpha: 1)
    //分數顏色
    let pinkColor = UIColor.init(red: 1, green: 153/255, blue: 212/255, alpha: 1)
    let hintWordBlue = UIColor.init(red: 52/255, green: 136/255, blue: 182/255, alpha: 1)
    let specialYellow = UIColor.init(red: 239/255, green: 196/255, blue: 92/255, alpha: 1)
    
    
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
    //要抓全+殘的全部單字
    var allWordSets = [[String]]()

    //暫時使用的句子
    var sentenceSets = [String]()
    
    //此元素頁面裡所有的音節
    var syllables = [String]()
    
    //被設定好的頁數
    var spotNumber = Int()
    var unitNumber = Int()
    var gameMode = Int()
    var mapNumber = Int()
    
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
    var firstSyllablesWithoutDigit = String()
    var secondSyllablesWithoutDigit = String()
    var thirdSyllablesWithoutDigit = String()
    
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
    
    var popQuizThreeChiWords = [String]()
    var popQuizThreeEngWords = [String]()

    //控制是否為第二次聽考
    var isBackToSpell = false
    
    var countScoreTimer = Timer()
    var answerTime = 0
    
    //紀錄已加過的分數
    var scoreAdded = Int()
    var isFinalGetPoint = false
    
    //紀錄三個字的正確與否
    var correctResults = ["0","0","0"]
    var wrongChinese = ["0","0","0"]
    
    //記錄我的最愛以及錯誤單字
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var allUnitSpotNums = [[Int]]()
    
    var randomSpots = [Int]()
    var randomUnits = [Int]()
    
    var popQuizTimer = Timer()
    
    var isChangeYPos = false
    
    var isPopQuiz = false
    
    var allPopQuizEngWords = [String]()
    var allPopQuizChiWords = [String]()
    var randomNums = [0,1,2,3,4,5]
    var engRandomNums = [Int]()
    
    var popQuizSeq = 0
    
    var sparkle:SKEmitterNode?
    var sparkle1:SKEmitterNode?
    var sparkle2:SKEmitterNode?
    
    var gamePassedDic:[Int:Int]?
    var mapPassedInt = Int()
    var increaseNum = Int()
    var courseReceived = Int()
    
    var popQuizRight = -1
    
    var wordReviewCount = Int()
    
    
    var maxSpotNum = Int()
    var maxMapNum = Int()
    
    var isFinalPopCorrect = false
    
    
    var rightSound = SKAction()
    var wrongSound = SKAction()
    var endSound = SKAction()

    let purpleColor = UIColor.init(red: 212/255, green: 141/255, blue: 249/255, alpha: 1)

   
    let orangeColor = UIColor.init(red: 232/255, green: 98/255, blue: 61/255, alpha: 1)
    
  
    
    override func didMove(to view: SKView) {
        
         makeLabelNode(x: 0, y: -290, alignMent: .center, fontColor: .white, fontSize: 40, text: "", zPosition: 3, name: "showHint", fontName: "Helvetica Bold", isHidden: true, alpha: 1)
        
        
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
        
        //啟動顯示tagView
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyOnlyPracticeSentence), name: NSNotification.Name("onlyPracticeSentence"), object: nil)

        //重新開始練習句子
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyStopReview), name: NSNotification.Name("stopReview"), object: nil)
        
        //暫停
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyPause), name: NSNotification.Name("pause"), object: nil)
        
        //接收再度倒數
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.restartCounting), name: NSNotification.Name("restartCounting"), object: nil)
        
        
        //接收再度倒數
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyStopLimitTimer), name: NSNotification.Name("stopLimitTimer"), object: nil)
        
        //接收再度倒數
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.playEndingMusic), name: NSNotification.Name("playEndingMusic"), object: nil)
        
        //移除發音符號
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyRemovePronounceBtn), name:  NSNotification.Name("removePlaySoundBtn"), object: nil)

        
        //接收再度倒數

        //先解決算出wordSequence之後再來讀取所有的字
        
        
        rightSound = SKAction.playSoundFileNamed("correct.wav", waitForCompletion: false)
        wrongSound = SKAction.playSoundFileNamed("wrong30.mp3", waitForCompletion: false)
        endSound = SKAction.playSoundFileNamed("ending30.mp3", waitForCompletion: false)
       

        //MARK: must update variables
        
        //讀目前課程數字數量
        switch courseReceived {
            
        case 0:
            
            gamePassedDic = gamePassed!
            mapPassedInt = mapPassed!
            increaseNum = 0
            maxMapNum = 5
            maxSpotNum = 14
            
        case 1:
            
            gamePassedDic = gamePassed2!
            mapPassedInt = mapPassed2!
            increaseNum = 5
            maxMapNum = 6
            maxSpotNum = 14
            
        case 2:
            
            gamePassedDic = gamePassed3!
            mapPassedInt = mapPassed3!
            increaseNum = 11
            maxMapNum = 7
            maxSpotNum = 14
            
        case 3:
            
            gamePassedDic = gamePassed4!
            mapPassedInt = mapPassed4!
            increaseNum = 18
            maxMapNum = 9
            maxSpotNum = 14
            
        default:
            break
            
        }

        
        if gameMode == 2 {
        
           
            //進入純粹練習句子的func
            
            //在此的func都只會執行一次
            //載入各種字
            loadAllKindsOfWord()
            
            currentWordSequence = 0
          
            //只做句子練習畫面
            setUpSentenceScreen()
            
        } else if gameMode == 1 {
            
       
            //做所有亂數可能性的array
            
            //隨機單字
                //在此抓測驗單字的亂數順序
            
            var tempGamePassedDic:[Int:Int]?
            
        //    if mapPassedInt == maxMapNum {
                //如果已破關
            if mapNumber < mapPassedInt{
                
                tempGamePassedDic = [maxSpotNum:9]
                
                
            } else {
                
                tempGamePassedDic = gamePassedDic
            }
            
                
                for (s,u) in tempGamePassedDic!{
                    
                    //1. 填入spot上限供亂數選擇
           
                    //填入全部
                    if s > 0 {
                        
                        allUnitSpotNums = [Array<Any>](repeating: [Int](), count: s + 1) as! [[Int]]
                        
                        for i in 0 ..< (s) {
                            
                            for n in 0 ..< 30{
                                
                                allUnitSpotNums[i].append(n)
                                
                            }
                            
                        }
                        
                        //填入殘值
                        if u > 0 {
                            
                            for i in 0 ..< u * 3 {
                                
                                allUnitSpotNums[allUnitSpotNums.count - 1].append(i)
                                
                            }
                            
                        } else {
                            
                            
                            allUnitSpotNums.remove(at: allUnitSpotNums.count - 1)
                            
                        }

                    
                        
                    } else {
                        
                        allUnitSpotNums = [Array<Any>](repeating: [Int](), count: 1) as! [[Int]]
                        //填入殘值
                        if u > 0 {
                            
                            for i in 0 ..< u * 3 {
                                
                                allUnitSpotNums[0].append(i)
                                
                            }
                        }
                    }
                    
                }
            
            //在此確認是否有字可以複習沒有就跳出alert
             //   if allUnitSpotNums != [[Int]()]{

            
            /*
            if mapNumber < mapPassedInt{
                //手動加三個
                
                allUnitSpotNums[allUnitSpotNums.count - 1].append(27)
                allUnitSpotNums[allUnitSpotNums.count - 1].append(28)
                allUnitSpotNums[allUnitSpotNums.count - 1].append(29)
                
                
                
            }
            */
            
            print(allUnitSpotNums)
            //載入各種字
            loadAllKindsOfWord()
            //設定畫面
            setUpScreen()
     
                /*
                } else {
                    
                    
                    print("can't practice")
                    
            }
            */
        } else if gameMode == 0{
        
            //載入各種字
            loadAllKindsOfWord()
            //設定畫面
            setUpScreen()
            
            
            //提示timer
            //hintTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NewGameScene.showHint), userInfo: nil, repeats: true)
            
            
            
            
        }
        //避免多次按
        self.view?.isMultipleTouchEnabled = false
        
        makeImageNode(name: "popUpBlock", image: "popUpBlock2", x: 0, y: -1334 / 2 + 228 * 1.5, width: 750, height: 228, z: 7, alpha: 0, isAnchoring: false)
        makeLabelNode(x: 0, y: -1380 / 2 + 228 * 1.5, alignMent: .center, fontColor: .white, fontSize: 70, text: "", zPosition: 8, name: "popUpLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        makeImageNode(name: "popDownBlock", image: "popDownBlock2", x: 0, y: -1334 / 2 + 114, width: 750, height: 228, z: 7, alpha: 0, isAnchoring: false)
        makeLabelNode(x: 0, y: -1380 / 2 + 114, alignMent: .center, fontColor: .white, fontSize: 70, text: "", zPosition: 8, name: "popDownLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
   
    
    
   
    
    
    }
    
    //載入各種字, 這裡面的load word要換位置避免浪費資源
    func loadAllKindsOfWord(){
        
        //抓三個random, 抓完之後移除, 然後再抓三個, 為了配合原本的機制
        if gameMode == 1 {
            
            allWordSets.removeAll(keepingCapacity: false)
            randomSpots.removeAll(keepingCapacity: false)
            randomUnits.removeAll(keepingCapacity: false)
            
            
    
            for _ in 0 ..< 3 {
                
                
                //新增目前能選擇的spotIndex
                let spotIndex = Int(arc4random_uniform(UInt32(allUnitSpotNums.count)))
                randomSpots.append(spotIndex)
                
                //從目前能選的spotIndex中選擇能選的unitIndex
                let unitCount = allUnitSpotNums[spotIndex].count
                let unitIndex = Int(arc4random_uniform(UInt32(unitCount)))
                randomUnits.append(allUnitSpotNums[spotIndex][unitIndex])
                
                
                //移除
                
                allUnitSpotNums[spotIndex].remove(at: unitIndex)
                
                if allUnitSpotNums[spotIndex].count == 0 {
                    
                    allUnitSpotNums.remove(at: spotIndex)
                }

            }
            
            print("randomSpots\(randomSpots)")
            print("randomUnits\(randomUnits)")
       
        }
        
        //讀取所有錯誤的字供比對

        if let myWrongWordsString = user?["wrongWords"] as! String?{
            myWrongWords = myWrongWordsString.components(separatedBy: ";")
        //    print("myWrongWords:\(myWrongWords)")
        }
        
      //  print("unitNumber:\(unitNumber)")
     //   print("spotNumber:\(spotNumber)")
       
        //測試用
        
        
        /*
         spotNumber = 0
         unitNumber = 1
 */

        
        //抓正確的音節
        //MARK: must update syl variables
        //設定地圖的音節
        


        switch mapNumber + increaseNum {
        case 0:
            syllableSets = map1SyllableSets
        case 1:
            syllableSets = map2SyllableSets
        case 2:
            syllableSets = map3SyllableSets
        case 3:
            syllableSets = map4SyllableSets
        case 4:
            syllableSets = map5SyllableSets
        case 5:
            syllableSets = map6SyllableSets
        case 6:
            syllableSets = map7SyllableSets
        case 7:
            syllableSets = map8SyllableSets
            
        case 8:
            syllableSets = map9SyllableSets
        case 9:
            syllableSets = map10SyllableSets
        case 10:
            syllableSets = map11SyllableSets
        case 11:
            syllableSets = map12SyllableSets
        case 12:
            syllableSets = map13SyllableSets
        case 13:
            syllableSets = map14SyllableSets
        case 14:
            syllableSets = map15SyllableSets
        case 15:
            syllableSets = map16SyllableSets
        case 16:
            syllableSets = map17SyllableSets
        case 17:
            syllableSets = map18SyllableSets
        case 18:
            syllableSets = map19SyllableSets
        case 19:
            syllableSets = map20SyllableSets
        case 20:
            syllableSets = map21SyllableSets
        case 21:
            syllableSets = map22SyllableSets
        case 22:
            syllableSets = map23SyllableSets
        case 23:
            syllableSets = map24SyllableSets
        case 24:
            syllableSets = map25SyllableSets
        case 25:
            syllableSets = map26SyllableSets
        case 26:
            syllableSets = map27SyllableSets
            
            
        default:
            break
        }
        
        //在此設定gameMode0的指定音標, gameMode1的分別音標在makeword裡面
        syllables = syllableSets[spotNumber]
        
        
        if gameMode == 0 {
            
            //抓正確unit
            currentWordSequence = 3 * unitNumber
            firstSequence = currentWordSequence
            
        //讀取Bundle裡的文字檔
        var wordFile:String?
        
        let name = String(mapNumber + increaseNum + 1) + "-" + String(spotNumber + 1)
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
            
        } else if gameMode == 1 {
            
            var tempGamePassDic:[Int:Int]?
            
            if mapPassedInt == maxMapNum {
                //假如mapPassInt等於最大map數, 那就mapPassInt 不加1, gamePassedDic以最大值

                
                mapPassedInt += increaseNum - 1
                tempGamePassDic = [maxSpotNum:9]
                
                
            } else if mapNumber < mapPassedInt{
                
                mapPassedInt += increaseNum
                   tempGamePassDic = [maxSpotNum:9]
                
                
                
            } else {
            
            //抓目前map數值的正確檔案名稱
            mapPassedInt += increaseNum
                tempGamePassDic = gamePassedDic
            }
            
            for (s,_) in tempGamePassDic!{
                
                //讀取已完整的所有字集
                
                for i in 0 ..< (s + 1){
                    
                    var wordFile:String?
                    //前面的1代表第一張地圖
                    let name = String(describing: mapPassedInt + 1) + "-" + String(i + 1)
                    
                    //抓字
                    if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
                        do {
                            wordFile = try String(contentsOfFile: filepath)
                            let words = wordFile?.components(separatedBy: "; ")
                            
                            //把字讀取到wordSets裡
                            allWordSets.append(words!)
                            //print(contents)
                            
                        } catch {
                            // contents could not be loaded
                        }
                    } else {
                        // example.txt not found!
                    }
                    
                }
                
                
            }

            
            
        }
        
        //print(allWordSets)
        
    }
    
    
    var hintSec = Int()
    
    
    /*
    @objc func showHint(){
        
        hintSec += 1
        
        
    }
    */
    
    
    
    @objc func notifyRemovePronounceBtn(){
        
        print("notify remove pronounce btn")
    }
    
    
    
    @objc func playEndingMusic(){
        
        self.run(endSound)
        
    }
    
    @objc func notifyOnlyPracticeSentence(){
        
    }
    
    @objc func notifyPause(){
        
    }
    
    @objc func restartCounting(){
     
        let lineNode = findImageNode(name: "countDownLine")
        
        if lineNode.isPaused && !lineNode.alpha.isZero{
            print("resume count down")
            lineNode.isPaused = false
        }

    }
    
    
    //只做句子練習畫面
    func setUpSentenceScreen(){
        
        var chiBtnDif = CGFloat()
      //  var iPadDif = CGFloat()
        
        switch  height {
        case 812:
            chiBtnDif = 0.8
            iPadDif = 1
   
        case 736:
            chiBtnDif = 1
            iPadDif = 1

        case 667:
            chiBtnDif = 0.95
            iPadDif = 1
        case 568:
            chiBtnDif = 0.9
            iPadDif = 1
        default:
            chiBtnDif = 0.9
            iPadDif = 1.2
        }
        
        //背景
        makeImageNode(name: "gameBg", image: "newGameBg2", x: 0, y: 0, width: 754, height: 1334, z: 0, alpha: 1, isAnchoring: false)
        
        makeImageNode(name: "recogWordsBg", image: "recogWordsBg", x: 0, y: 0, width: 750, height: 228, z: 10, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "countDownLine", image: "countDownLine", x: -375, y: -114, width: 750, height: 5, z: 11, alpha: 0, isAnchoring: true)
        
        
      
        makeImageNode(name: "pause", image: "pauseBtn", x: -330 * chiBtnDif, y: 550 / iPadDif, width: 39, height: 64, z: 2, alpha: 1, isAnchoring: false)

        //單字量Label, 這部分是新的
        makeLabelNode(x: 350 * chiBtnDif, y: 550 / iPadDif, alignMent: .right, fontColor: .clear, fontSize: 35, text: "0", zPosition: 1, name: "scoreLabel", fontName: "Helvetica Neue", isHidden: false, alpha: 1)
    
        //提示字
        makeLabelNode(x: -425, y: 0, alignMent: .center, fontColor: .white, fontSize: 50, text: "", zPosition: 1, name: "hintLeftLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        makeLabelNode(x: 425, y: 0, alignMent: .center, fontColor: .white, fontSize: 50, text: "", zPosition: 1, name: "hintRightLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        
        
        
        //send Nc
        
         let wordSequence:[String:Int] = ["wordSequence":currentWordSequence]
        
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "onlyPracticeSentence"), object: nil, userInfo: wordSequence)

    }
    
    //載入畫面
    
    var engFontSize = CGFloat()
 
    func setUpScreen(){
        
        findLabelNode(name: "showHint").text = "請連線拼字"
        
        var chiBtnDif = CGFloat()
        var dif = CGFloat()

    
        
        switch  height {
        case 812:
            chiBtnDif = 0.8
            dif = 0.9
            iPadDif = 1
            engFontSize = 65
        case 736:
            chiBtnDif = 1
            dif = 0.9
            iPadDif = 1
            engFontSize = 65
        case 667:
            chiBtnDif = 0.95
            dif = 1
            iPadDif = 1
            engFontSize = 60
        case 568:
            chiBtnDif = 0.9
            dif = 0.9
            iPadDif = 1
            engFontSize = 50
        default:
            chiBtnDif = 0.9
            dif = 0.9
            iPadDif = 1.2
            engFontSize = 65
        }
        
        //背景
        var bgImgString = String()
       
        
        
        var lightImg = "lightSel"
        var darkImg = "darkSel"
        var pauseImg = String()
        
        var textColor = UIColor()
        switch gameMode{
        case 0:
            
            bgImgString = "newGameBg"
            lightImg = "lightSel"
            darkImg = "darkSel"
            pauseImg  = "pauseBtn"
            textColor = pinkColor
            
        case 1:
            bgImgString = "newGameBg2"
            lightImg = "lightSel2"
            darkImg = "darkSel2"
            pauseImg  = "pauseBtn2"
            textColor = UIColor.clear
            
        default:
            break
            
        }
        
        
        //暫時測試用
        makeImageNode(name: "gameBg", image: bgImgString, x: 0, y: 0, width: 754, height: 1334, z: 0, alpha: 1, isAnchoring: false)
        
        //makeImageNode(name: "gameBg", image: "popQuizBg", x: 0, y: 0, width: 754, height: 1334, z: 0, alpha: 1, isAnchoring: false)
        
        
        makeImageNode(name: "pause", image: pauseImg, x: -330 * chiBtnDif, y: 550 / iPadDif, width: 39, height: 64, z: 2, alpha: 1, isAnchoring: false)
        
        // 製作TimerBg & timer label
        
        makeLabelNode(x: 0, y: height * 3 / 5 * dif, alignMent: .center, fontColor: specialYellow, fontSize: 50, text: "限時挑戰", zPosition: 2, name: "quizTitle", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        
        makeImageNode(name: "timerBg", image: "timerBg", x: 0, y: height * 2 / 5 * dif, width: 277 * dif, height: 185 * dif, z: 1, alpha: 0, isAnchoring: false)
        
        makeLabelNode(x: -65 * dif, y: height * 1.4 / 5 * dif, alignMent: .center, fontColor: .white, fontSize: 130, text: "0", zPosition: 2, name: "bigNumber", fontName: "Helvetica Neue", isHidden: false, alpha: 0)
        
        makeLabelNode(x: 65 * dif, y: height * 1.4 / 5 * dif, alignMent: .center, fontColor: .white, fontSize: 130, text: "3", zPosition: 2, name: "smallNumber", fontName: "Helvetica Neue", isHidden: false, alpha: 0)

        makeLabelNode(x: 0, y: -50 * dif, alignMent: .center, fontColor: .white, fontSize: 110, text: "", zPosition: 1, name: "bigChineseLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        
        makeImageNode(name: "recogWordsBg", image: "recogWordsBg", x: 0, y: 0, width: 750, height: 228, z: 10, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "countDownLine", image: "countDownLine", x: -375, y: -114, width: 750, height: 5, z: 11, alpha: 0, isAnchoring: true)
        

        //分數Label, 這部分是新的
         makeLabelNode(x: 350 * chiBtnDif, y: 550 / iPadDif, alignMent: .right, fontColor: textColor, fontSize: 35, text: "0", zPosition: 1, name: "scoreLabel", fontName: "Helvetica Neue", isHidden: false, alpha: 1)
        
        
        
        //測試用看星星的位置
        makeImageNode(name: "star0", image: "emptyStar", x: 210 * chiBtnDif, y: 520, width: 50, height: 48, z: 2, alpha: 0, isAnchoring: false)
         makeImageNode(name: "star1", image: "emptyStar", x: 280 * chiBtnDif, y: 520, width: 50, height: 48, z: 2, alpha: 0, isAnchoring: false)
         makeImageNode(name: "star2", image: "emptyStar", x: 350 * chiBtnDif, y: 520, width: 50, height: 48, z: 2, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "star3", image: "filledStar", x: 210 * chiBtnDif, y: 480, width: 50, height: 48, z: 2, alpha: 0, isAnchoring: false)
        makeImageNode(name: "star4", image: "filledStar", x: 280 * chiBtnDif, y: 480, width: 50, height: 48, z: 2, alpha: 0, isAnchoring: false)
        makeImageNode(name: "star5", image: "filledStar", x: 350 * chiBtnDif, y: 480, width: 50, height: 48, z: 20, alpha: 0, isAnchoring: false)
        
        
        //測試星星移動
        /*
        let wait = SKAction.wait(forDuration: 1)
        let pointsPosition = CGPoint(x: 250, y: 400)
        let rotate = SKAction.rotate(toAngle: 720, duration: 0.2)
        let moveTo = SKAction.move(to: pointsPosition, duration: 0.2)
        
        let groupAction = SKAction.group([rotate,moveTo])
        let sequence = SKAction.sequence([wait,groupAction])
        findImageNode(name: "star5").run(sequence)
 */
        
        sparkle = SKEmitterNode(fileNamed: "fire.sks")
        sparkle?.position = CGPoint(x: 210 * chiBtnDif, y: 520)
        sparkle?.name = "spark"
        sparkle?.isHidden = true
        
        self.addChild(sparkle!)

 
        sparkle1 = SKEmitterNode(fileNamed: "fire.sks")
        sparkle1?.position = CGPoint(x: 280 * chiBtnDif, y: 520)
        sparkle1?.name = "spark"
        sparkle1?.isHidden = true
        
        self.addChild(sparkle1!)
       
        sparkle2 = SKEmitterNode(fileNamed: "fire.sks")
        sparkle2?.position = CGPoint(x: 350 * chiBtnDif, y: 520)
        sparkle2?.name = "spark"
        sparkle2?.isHidden = true
        
        self.addChild(sparkle2!)


        
        
        //提示字
        makeLabelNode(x: -425, y: 0, alignMent: .center, fontColor: .white, fontSize: 50, text: "", zPosition: 1, name: "hintLeftLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        makeLabelNode(x: 425, y: 0, alignMent: .center, fontColor: .white, fontSize: 50, text: "", zPosition: 1, name: "hintRightLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        
        //製作按鈕
        let lightWidth:CGFloat = 150
        let lightHeight:CGFloat = 150
        let darkWidth:CGFloat = 150
        let darkHeight:CGFloat = 150

        let positions = [[-135,-500],[-230,-280],[135,-500],[230,-280],[0,-90]]
        
        //選項按鈕
        
        makeNode(name: "se0", color: .clear, x:CGFloat(positions[0][0]) , y: CGFloat(positions[0][1]) / iPadDif, width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se1", color: .clear, x:CGFloat(positions[1][0]) , y: CGFloat(positions[1][1]) / iPadDif, width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se2", color: .clear, x:CGFloat(positions[2][0]) , y: CGFloat(positions[2][1]) / iPadDif, width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se3", color: .clear, x:CGFloat(positions[3][0]) , y: CGFloat(positions[3][1]) / iPadDif, width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se4", color: .clear, x:CGFloat(positions[4][0]) , y: CGFloat(positions[4][1]) / iPadDif, width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        
        //填滿按鈕
        
        makeImageNode(name: "0filledButton", image: lightImg, x:CGFloat(positions[0][0]) , y: CGFloat(positions[0][1]) / iPadDif, width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "1filledButton", image: lightImg, x:CGFloat(positions[1][0]), y: CGFloat(positions[1][1]) / iPadDif, width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "2filledButton", image: lightImg, x:CGFloat(positions[2][0]) , y: CGFloat(positions[2][1]) / iPadDif, width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "3filledButton", image: lightImg, x:CGFloat(positions[3][0]) , y: CGFloat(positions[3][1]) / iPadDif, width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "4filledButton", image: lightImg, x:CGFloat(positions[4][0]) , y: CGFloat(positions[4][1]) / iPadDif, width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        
        
        //空的按鈕
        makeImageNode(name: "0emptyButton", image: darkImg, x:CGFloat(positions[0][0]) , y: CGFloat(positions[0][1]) / iPadDif, width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "1emptyButton", image: darkImg, x:CGFloat(positions[1][0]) , y: CGFloat(positions[1][1]) / iPadDif, width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "2emptyButton", image: darkImg, x:CGFloat(positions[2][0]) , y: CGFloat(positions[2][1]) / iPadDif, width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "3emptyButton", image: darkImg, x:CGFloat(positions[3][0]) , y: CGFloat(positions[3][1]) / iPadDif, width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "4emptyButton", image: darkImg, x:CGFloat(positions[4][0]) , y: CGFloat(positions[4][1]) / iPadDif, width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        

        //製作中文選項
        
        //暫時測試用
        
        var leftSqr = String()
        var rightSqr = String()
        
        switch gameMode{
            
        case 0:
        leftSqr = "leftRoundedSqr"
        rightSqr = "rightRoundedSqr"
            
        case 1:
            leftSqr = "leftRoundedSqr2"
            rightSqr = "rightRoundedSqr2"
        case 2:
            leftSqr = "leftRoundedSqr"
            rightSqr = "rightRoundedSqr"
            
        default:
            break
            
            
        }
        
        
        makeImageNode(name: "leftChiBtn", image: leftSqr, x: -187 * chiBtnDif, y: -365, width: 320 * chiBtnDif, height: 320 * chiBtnDif, z: 7, alpha: 0, isAnchoring: false)
        makeImageNode(name: "rightChiBtn", image: rightSqr, x: 187 * chiBtnDif, y: -365, width: 320 * chiBtnDif, height: 320 * chiBtnDif, z: 7, alpha: 0, isAnchoring: false)
        
        //makeImageNode(name: "leftChiBtn", image: "popQuizBlock", x: -187 * chiBtnDif, y: -365, width: 320 * chiBtnDif, height: 320 * chiBtnDif, z: 7, alpha: 1, isAnchoring: false)
        //makeImageNode(name: "rightChiBtn", image: "popQuizBlock", x: 187 * chiBtnDif, y: -365, width: 320 * chiBtnDif, height: 320 * chiBtnDif, z: 7, alpha: 1, isAnchoring: false)
        
        //加入中文字選項的node
        leftChiNode.position = CGPoint(x: -187 * chiBtnDif, y: -375 / iPadDif)
        leftChiNode.horizontalAlignmentMode = .center
        leftChiNode.fontSize = 60
        leftChiNode.fontColor = .white
        leftChiNode.zPosition = 8
        leftChiNode.name = "leftChi"
        leftChiNode.fontName = "Helvetica Bold"
        //leftChiNode.text = "age"

        adjustLabelFontSizeToFitRect(labelNode: leftChiNode, rect: findImageNode(name: "leftChiBtn").frame)

        addChild(leftChiNode)
        
        rightChiNode.position = CGPoint(x: 187 * chiBtnDif, y: -375 / iPadDif)
        rightChiNode.horizontalAlignmentMode = .center
      
        rightChiNode.fontSize = 60
        rightChiNode.fontColor = .white
        rightChiNode.zPosition = 8
        rightChiNode.name = "rightChi"
        rightChiNode.fontName = "Helvetica Bold"
        //rightChiNode.text = "congratulations"
        adjustLabelFontSizeToFitRect(labelNode: rightChiNode, rect: findImageNode(name: "rightChiBtn").frame)
        
        addChild(rightChiNode)
        
        
        
        //建立三個單字
        
        //firstEngWordLabel.frame = CGRect(x: 187.5 + 375, y: 110, width: 200, height: 80)
        firstEngWordLabel.frame = CGRect(x: (width - 200 * dif) / 2 + width, y: 110 * dif / iPadDif, width: 260 * dif, height: 80 * dif)
        
        //firstEngWordLabel.backgroundColor = .cyan
        firstEngWordLabel.textColor = darkWordColor
        firstEngWordLabel.textAlignment = .center
        firstEngWordLabel.adjustsFontSizeToFitWidth = true
        firstEngWordLabel.font = UIFont(name: "Helvetica Bold", size: engFontSize)
        firstEngWordLabel.text = ""
        self.view?.addSubview(firstEngWordLabel)
        
        //英文單字的Node
        //firstChiWordLabel.frame = CGRect(x: 187.5 + 375, y: 205, width: 90, height: 40)
        firstChiWordLabel.frame = CGRect(x: (width - 90 * dif) / 2 + width, y: 205 * dif / iPadDif, width: 260 * dif, height: 40 * dif)
        //firstChiWordLabel.backgroundColor = .green
        firstChiWordLabel.textColor = pinkColor
        firstChiWordLabel.textAlignment = .center
        firstChiWordLabel.adjustsFontSizeToFitWidth = true
        firstChiWordLabel.font = UIFont(name: "Helvetica Bold", size: 30)
        firstChiWordLabel.text = ""
        self.view?.addSubview(firstChiWordLabel)
        
        //popQuizTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NewGameScene.popQuizCountDown), userInfo: nil, repeats: true)
        
        //建立好畫面後開始動畫
        
        
       
        makeImageNode(name: "abort", image: "abortPng", x: 300 * chiBtnDif, y: 500 / iPadDif, width: 131, height: 46, z: 3, alpha: 0, isAnchoring: false)
        
        introAnimation()
        
    }
    
    func adjustLabelFontSizeToFitRect(labelNode:SKLabelNode, rect:CGRect) {
        
        // Determine the font scaling factor that should let the label text fit in the given rectangle.
        let scalingFactor = min(rect.width / labelNode.frame.width, rect.height / labelNode.frame.height)
        
        // Change the fontSize.
        
        labelNode.fontSize *= scalingFactor * 0.95
        
        
        
        if labelNode.fontSize > 80 {
            
            labelNode.fontSize = 80
        }
 
        print(labelNode.fontSize)
        // Optionally move the SKLabelNode to the center of the rectangle.
        labelNode.position = CGPoint(x: rect.midX, y: rect.midY - labelNode.frame.height / 2.0)
    }
    
    //Part 1. intro: 開始學習單字的提示字樣滑入, 飛出
    
    
    @objc func popQuizCountDown(){
        
        
        var bigNum = Int(findLabelNode(name: "bigNumber").text!)!
        var smallNum = Int(findLabelNode(name: "smallNumber").text!)!
        
        if smallNum > 1 {
            
            smallNum -= 1
            
            //smallNumBlink()
            findLabelNode(name: "bigNumber").text = String(bigNum)
            findLabelNode(name: "smallNumber").text = String(smallNum)
            
        } else if bigNum > 0 {
            
            bigNum -= 1
            smallNum = 9
            //smallNumBlink()
            //bigNumBlink()
            findLabelNode(name: "bigNumber").text = String(bigNum)
            findLabelNode(name: "smallNumber").text = String(smallNum)
            
        } else {
            

            //倒數停止
            //不能按鈕
            //顯示時間到
            //顯示正確打圈
            //秒數變紅色
            //暫停一秒後繼續下一題
            

            popQuizTimer.invalidate()
            
            isUserInteractionEnabled = false
            
            findLabelNode(name: "quizTitle").text = "時間到！"
            findLabelNode(name: "quizTitle").fontColor = .red
            findLabelNode(name: "bigNumber").fontColor = .red
            findLabelNode(name: "smallNumber").fontColor = .red
            findLabelNode(name: "bigNumber").text = "0"
            findLabelNode(name: "smallNumber").text = "0"
            
            let wait = SKAction.wait(forDuration: 1)
            
            self.run(wait) {[weak self] in
                self!.chooseChineseResult(isCorrect: false)
                
                self!.findLabelNode(name: "quizTitle").text = "限時挑戰"
                self!.findLabelNode(name: "quizTitle").fontColor = .white
                self!.findLabelNode(name: "bigNumber").fontColor = .white
                self!.findLabelNode(name: "smallNumber").fontColor = .white
                self!.findLabelNode(name: "smallNumber").text = "3"


            }
            
        }
        

        
    }
    
    func introAnimation(){
        
        hintSlideIn(leftText: "學習", rightText: "單字",waitTime: 1.3) {[weak self] in
            
            self!.makeWords()
            
        }
        
    }
    
    // 2. makeWords: 讀取所有的字, 造字
    func makeWords(){
        
        //這個engWords是尚未attr的, attr完的是
        var allThreeEngWordsArray = [[String]]()
    
        var engWord0 = [String]()
        var chiWord0 = String()
        var engWord1 = [String]()
        var chiWord1 = String()
        var engWord2 = [String]()
        var chiWord2 = String()
        
        
        //popQuiz使用
        var allThreePopQuizEngWordsArray = [[String]]()
        
        var engWord3 = [String]()
        var chiWord3 = String()
        var engWord4 = [String]()
        var chiWord4 = String()
        var engWord5 = [String]()
        var chiWord5 = String()
        
        
        let quarterCount = wordSets.count / 3
        
        print(quarterCount)
        
        if gameMode == 1 {
            
            //random unit兩個都要放入去抓, 要找正確的地方放
            
            print("count:\(allWordSets.count)")
            engWord0 = allWordSets[randomSpots[0]][randomUnits[0]].components(separatedBy: " ")
            chiWord0 = allWordSets[randomSpots[0]][randomUnits[0 + quarterCount]]
            engWord1 = allWordSets[randomSpots[1]][randomUnits[1]].components(separatedBy: " ")
            chiWord1 = allWordSets[randomSpots[1]][randomUnits[1 + quarterCount]]
            engWord2 = allWordSets[randomSpots[2]][randomUnits[2]].components(separatedBy: " ")
            chiWord2 = allWordSets[randomSpots[2]][randomUnits[2 + quarterCount]]
            
            print(engWord0)
            print(chiWord0)
            print(engWord1)
            print(chiWord1)
            print(engWord2)
            print(chiWord2)
            
            
        } else if gameMode == 0 {
            
        engWord0 = wordSets[currentWordSequence].components(separatedBy: " ")
        chiWord0 = wordSets[quarterCount +  currentWordSequence]
        engWord1 = wordSets[currentWordSequence + 1].components(separatedBy: " ")
        chiWord1 = wordSets [quarterCount +  currentWordSequence + 1]
        engWord2 = wordSets[currentWordSequence + 2].components(separatedBy: " ")
        chiWord2 = wordSets [quarterCount +  currentWordSequence + 2]
            
            
            if (unitNumber + 1) % 2 == 0{

            
        //popQuiz使用
            
            engWord3 = wordSets[currentWordSequence - 3].components(separatedBy: " ")
            chiWord3 = wordSets[quarterCount +  currentWordSequence - 3]
            engWord4 = wordSets[currentWordSequence - 2].components(separatedBy: " ")
            chiWord4 = wordSets[quarterCount +  currentWordSequence - 2]
            engWord5 = wordSets[currentWordSequence - 1].components(separatedBy: " ")
            chiWord5 = wordSets[quarterCount +  currentWordSequence - 1]
            
     
                allThreePopQuizEngWordsArray.append(engWord3)
                allThreePopQuizEngWordsArray.append(engWord4)
                allThreePopQuizEngWordsArray.append(engWord5)
                
                
                for i in 0 ..< allThreePopQuizEngWordsArray.count{
                    var word = String()
                    
                    for syl in allThreePopQuizEngWordsArray[i]{
                        
                        word = word + syl
                    }
                    
                    popQuizThreeEngWords.append(word)
                    
                }
                
                
                
                //append中文字
                popQuizThreeChiWords.append(chiWord3)
                popQuizThreeChiWords.append(chiWord4)
                popQuizThreeChiWords.append(chiWord5)
                
                print(popQuizThreeEngWords)
                print(popQuizThreeChiWords)
            }
            
        }
        
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
        let attrs0 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: engFontSize), NSAttributedStringKey.foregroundColor : UIColor.white]
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: engFontSize), NSAttributedStringKey.foregroundColor : UIColor.cyan]
        
        
        //先抓音節, 待寫gameMode==1的條件式
        
        var firstSyllablesToCheck = String()
        var secondSyllablesToCheck = String()
        var thirdSyllablesToCheck = String()
        
        //三個音節供去掉數字
        var threeSyllables = ["","",""]
        
        if gameMode == 0 {
        
            syllablesToCheck = syllables[unitNumber]
            threeSyllables = [syllablesToCheck,syllablesToCheck,syllablesToCheck]
       
      
        } else if gameMode == 1 {
            firstSyllablesToCheck = syllableSets[randomSpots[0]][randomUnits[0] / 3]
            secondSyllablesToCheck = syllableSets[randomSpots[1]][randomUnits[1] / 3]
            thirdSyllablesToCheck = syllableSets[randomSpots[2]][randomUnits[2] / 3]
          
            threeSyllables = [firstSyllablesToCheck,secondSyllablesToCheck,thirdSyllablesToCheck]
            
        }

        
        //去掉數字
        
        firstSyllablesWithoutDigit = (threeSyllables[0].components(separatedBy: NSCharacterSet.decimalDigits) as NSArray).componentsJoined(by: "")
        secondSyllablesWithoutDigit = (threeSyllables[1].components(separatedBy: NSCharacterSet.decimalDigits) as NSArray).componentsJoined(by: "")
        thirdSyllablesWithoutDigit = (threeSyllables[2].components(separatedBy: NSCharacterSet.decimalDigits) as NSArray).componentsJoined(by: "")

        
        //去掉數字後加入到group供辨認
        var syllablesGroup = [String]()
        
        syllablesGroup.append(firstSyllablesWithoutDigit)
        syllablesGroup.append(secondSyllablesWithoutDigit)
        syllablesGroup.append(thirdSyllablesWithoutDigit)
        
        
        var attrWords = [[NSMutableAttributedString](),[NSMutableAttributedString](),[NSMutableAttributedString]()]
        
        //以下為生成attr的步驟
        //1. 確認是否是specialE
        
        
        for sg in 0 ..< syllablesGroup.count {
        
        if syllablesGroup[sg].contains("_"){
            //specialE的作法
            
            var characters = [Character]()
            let vowels = ["a","e","i","o","u"]
            
            //每一個英文字節拆字母
          //  for w in 0 ..< allThreeEngWordsArray.count{
                
                for i in 0 ..< allThreeEngWordsArray[sg].count{
                    
                    characters.removeAll(keepingCapacity: false)
                    
                    for c in allThreeEngWordsArray[sg][i]{
                        
                        characters.append(c)
                    }
                    
                    if characters.count == 3{
                        if characters[2] == "e"{
                            
                            if vowels.contains(String(characters[0])){
                                
                                
                                //剛好是_e部首
                                let word = NSMutableAttributedString(string: String(characters[0]), attributes: attrs1)
                                attrWords[sg].append(word)
                                let word1 = NSMutableAttributedString(string: String(characters[1]), attributes: attrs0)
                                attrWords[sg].append(word1)
                                let word2 = NSMutableAttributedString(string: String(characters[2]), attributes: attrs1)
                                attrWords[sg].append(word2)
                                
                                
                            } else {
                                
                                for c in 0 ..< characters.count {
                                    
                                    let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs0)
                                    attrWords[sg].append(word)
                                }
                                
                            }
                            
                        } else {
                            
                            for c in 0 ..< characters.count {
                                
                                let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs0)
                                attrWords[sg].append(word)
                            }
                            
                        }
                        
                    } else {
                        
                        for c in 0 ..< characters.count {
                            
                            let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs0)
                            attrWords[sg].append(word)
                        }
                        
                        
                    }
                    
                    
                }
           // }
            
        } else {
            //非specialE的作法
            
            //抓三個字的array
         //   for w in 0 ..< allThreeEngWordsArray.count{
                
                //抓array的音節,  只抓一個字
                for i in 0 ..< allThreeEngWordsArray[sg].count{
                    
                    if let engWord = allThreeEngWordsArray[sg][i] as String?{
                        
                        if engWord == syllablesGroup[sg]{
                            //符合部首字
                            
                            let word = NSMutableAttributedString(string: engWord, attributes: attrs1)
                            attrWords[sg].append(word)
                            
                            
                        } else{
                            //一般字元
                            
                            let word = NSMutableAttributedString(string: engWord, attributes: attrs0)
                            
                            attrWords[sg].append(word)
                            
                        }
                    }
                    
                }
                
         //   }
            
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
        
        if gameMode == 1 {
            
            //隱藏上方的單字換成對話框
            firstEngWordLabel.isHidden = true
            firstChiWordLabel.isHidden = true

        }
        
        firstEngWordLabel.attributedText = words[0]
        firstChiWordLabel.text = chiWord0
        
        //造完字單字滑入 - 一次性動畫
        slideInAnimation()
        
    }
    
    
    
    //Part 3. slideIn: 單字滑進來
    func slideInAnimation(){
        
        UIView.animate(withDuration: 0.3, animations: {[weak self] in
            
            self!.firstEngWordLabel.center.x = self!.width / 2
            
        })
        
        UIView.animate(withDuration: 0.3, animations: {[weak self] in
            self!.firstChiWordLabel.center.x = self!.width / 2
            }, completion: { [weak self](finished:Bool) in
                if finished{
                    
                    //設定發音單字
                    if self!.gameMode == 0 {
                        
                        self!.wordsToPronounce = self!.wordSets[self!.currentWordSequence].replacingOccurrences(of: " ", with: "")
                        
                    } else if self!.gameMode == 1 {
                        
                        self!.wordsToPronounce = self!.allWordSets[self!.randomSpots[0]][self!.randomUnits[0]].replacingOccurrences(of: " ", with: "")
                        
                    }
                    

                    
                    if self!.gameMode == 1 {
                   
                        //reviewMode不發音 , 留到後方practice發音, 原因好像不明顯...
                     
                        self!.reviewWordMode()
                    
                    } else {
                    
                        self!.practice()
                        
                        let wordToPass:[String:Any] = ["wordToPass":self!.wordsToPronounce,"pronounceTime":1]
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pronounceWord"), object: nil, userInfo: wordToPass)
                    }
                 
                    
                    
                }
                
        })
        
        
    }
    
    @objc func notifyShowTag(){
        
    }
    
    var hintTime = 0
    @objc func readyToReadSentence(){
        
        
        if hintTime == 0 {
            
            hintSlideIn(leftText: "換你", rightText: "發音", waitTime: 1.3) {[weak self] in
                
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "readSentence"), object: nil, userInfo: nil)
                
                self!.hintTime += 1
                
            }
        } else {
            

                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: "readSentence"), object: nil, userInfo: nil)
            
        }
     
 
        
    
 
    }
    
    @objc func notifyReadSentence(){
        
                findImageNode(name: "recogWordsBg").alpha = 1
    }
    
    @objc func startCountDown(){
        //開始倒數tagQuestion
        
        //顯示放棄鈕
        

        if let abortKey = childNode(withName: "abort") as? SKSpriteNode{
            
            abortKey.alpha = 1
        }
        
        
        let lineNode = findImageNode(name: "countDownLine")
        lineNode.alpha = 1
    
        var sec = TimeInterval()
        
        switch courseReceived{
          
        case 0:
            sec = 20
        case 1:
            sec = 30
        case 2:
            sec = 40
        case 3:
            sec = 40

        default:
            break

        }
        
        
         let countDownAction = SKAction.resize(toWidth: 0, duration: sec)
        
        lineNode.run(countDownAction) {[weak self] in
            
            print("stop counting")
            
            self!.run(self!.wrongSound)
            
            
            //send Nc
            if self!.gameMode == 2 {
           
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopReview"), object: nil, userInfo: nil)
          
            } else if self!.gameMode == 0 {
                
                
                //timesUp
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "timesUp"), object: nil, userInfo: nil)
                
                self!.isFinalGetPoint = false
                
                
                //在此的功能為刪除倒數線
                self!.practiceNextWord()

            }
            

            
        }
        
        
    }
    
    @objc func notifyTimesUp(){
        
        
    }
    
    @objc func backToSpell(_ notification:NSNotification){
        
        
        
        
        //抓分數
        if let addScore = notification.userInfo?["addScore"] as? Int{
            if addScore != 0 {
                if gameMode == 0 {
                countScore(score: addScore)
                    
                  
                }
            }
            
        }
        
        isUserInteractionEnabled = false
        
        //隱藏上方的單字換成對話框
        firstEngWordLabel.isHidden = true
        firstChiWordLabel.isHidden = true
        
        //錄音字欄位
        findImageNode(name: "recogWordsBg").alpha = 0
        
        //建立說話圖示
        makeImageNode(name: "talkPng", image: "talkPng", x: 0, y: 380 / iPadDif, width: 256, height: 196, z: 1, alpha: 1, isAnchoring: false)
        
        
        //宣告此為第二次練習
        isBackToSpell = true
        
        //練習
        practice()
        
    }
    
    func reviewWordMode(){
        isUserInteractionEnabled = false
        
        
        //錄音字欄位
        findImageNode(name: "recogWordsBg").alpha = 0
        
        //建立說話圖示
        makeImageNode(name: "talkPng", image: "talkPng", x: 0, y: 380, width: 256, height: 196, z: 1, alpha: 1, isAnchoring: false)
        
        
        //宣告此為第二次練習
        isBackToSpell = true
        
        //練習
        practice()
        
    }
    

    
    @objc func addScore(_ notification:NSNotification){
        
        
        print("enter addScore")
        
        if let addScore = notification.userInfo?["addScore"] as? Int{
            if addScore != 0 {
                if gameMode == 0 {
       
                    countScore(score: addScore)
                }
        }
        }
        //有finalPoints就是要啟動倒數Timer
        if (notification.userInfo?["finalPoints"] as? Int) != nil{
                //tag倒數
                startCountDown()

        }
    
        
    }
    
    
    @objc func notifyPronounceWord(){
        
    }
    

    
    
    deinit {
        NotificationCenter.default.removeObserver(self)

        print("gamescene deinit")
    }
    
    
    //練習模式
    var iPadDif = CGFloat()
    
    func practice(){
        
        if isBackToSpell{
        
        hintSec = 0
        findLabelNode(name: "showHint").text = "請連線拼字"
        }
        

        switch  height {
        case 812:

            iPadDif = 1
        case 736:

            iPadDif = 1
        case 667:
     
            iPadDif = 1
        case 568:
     
            iPadDif = 1
        default:
    
            iPadDif = 1.2
        }
        
        hintSlideIn(leftText: "連線", rightText: "拼字",waitTime: 1) {[weak self] in
            
            //是否要發音, 判斷是不是第一個字
            var shouldPronounce = Bool()
            
            //暫時都不改變等待時間 var - let
            let waitTime = DispatchTime.now()
            
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
                    
                    //設定發不發音, gameMode1也被引導到這邊來
                    if self!.isBackToSpell{
                        
                        shouldPronounce = true
                   
                        
                        
                    } else {
                        shouldPronounce = false
                        //self!.isUserInteractionEnabled = true
                        //發音完後變色
                        self!.firstEngWordLabel.textColor = self!.darkWordColor

                    }
                    
                    //第二個字及第三個字
                    
                case 1...:

                    self?.firstEngWordLabel.attributedText = self!.words[self!.currentPracticeSequence]
                    self!.firstChiWordLabel.text = self!.allThreeChiWords[self!.currentPracticeSequence]
                    
                    if self!.gameMode == 0 {
                        
                        let moveBack = SKAction.moveTo(y: -290, duration: 0)
                        
                        self!.findLabelNode(name: "showHint").run(moveBack)

                        
                        self!.hintSec = 0
                        self!.findLabelNode(name: "showHint").text = "請連線拼字"
                    
                    self!.wordsToPronounce =  self!.wordSets[self!.currentWordSequence].replacingOccurrences(of: " ", with: "")
                    
                    } else if self!.gameMode == 1 {
                        
                         self!.wordsToPronounce =  self!.allWordSets[self!.randomSpots[self!.currentPracticeSequence]][self!.randomUnits[self!.currentPracticeSequence]].replacingOccurrences(of: " ", with: "")
                        
                    }
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
                        
                        if !self!.countScoreTimer.isValid {
                                self!.isUserInteractionEnabled = true
                            
                            
                         
                            
                        }
                    
                    })

                    
                }

            }
        }
        
        
        
        //抓目前單字
        
        var currentWord = String()
        if gameMode == 0 {
        
            currentWord = wordSets[currentWordSequence]
        
        } else if gameMode == 1{
            
            currentWord = allWordSets[randomSpots[currentPracticeSequence]][randomUnits[currentPracticeSequence]]
            
        }
        //分目前單字音節
        currentWordArray = currentWord.components(separatedBy: " ")
        
        //計算音節數
        let currentWordSyllableCounts = currentWordArray.count
        
        //抓部首以外的英文字
        var otherWords = [String]()
        
        if gameMode == 0 {
        
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
        } else if gameMode == 1 {
            
            for (s,_) in gamePassedDic!{
                
                let randomSpot = Int(arc4random_uniform(UInt32(s)))
                
                //在所有亂數spot英文字裡面, 如果音節沒有重複目前顯示的音節, 就把它加入到otherWords裡來做選項
                for i in 0 ..< allWordSets[randomSpot].count / 3{
                    
                    let word = allWordSets[randomSpot][i]
                    let sepWordArray = word.components(separatedBy: " ")
                    
                    for sw in sepWordArray{
                        
                        if !currentWordArray.contains(sw) {
                            otherWords.append(sw)
                            
                        }
                    }
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
        let positions = [[-135,-519],[-230,-299],[135,-519],[230,-299],[0,-109]]
        
        var waitMoreTime = DispatchTime.now()
        if isBackToSpell {
            waitMoreTime = DispatchTime.now() + 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: waitMoreTime) {[weak self] in
            
            //顯示空格子
            let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.3)
            
            for node in self!.children{
                
                //顯示選項罐子
                if (node.name?.contains("emptyButton"))!{
                    
                    node.run(fadeIn)
                }
            }

          
            for i in 0 ..< self!.shownWords.count{
                
               self!.makeLabelNode(x: CGFloat(positions[i][0]), y: CGFloat(positions[i][1])  / self!.iPadDif, alignMent: .center, fontColor: .white, fontSize: 50, text: self!.shownWords[i], zPosition: 5, name: self!.shownWords[i] + String(i) + "Sel", fontName: "Helvetica", isHidden: false, alpha: 1)
                
                
                //把建立的選項名稱放入array裡
                self!.selNodeNames.append(self!.shownWords[i] + String(i) + "Sel")
                
            }
            
            //可按按鍵
            //isUserInteractionEnabled = true
            
            //啟動連線功能
            self!.isDragAndPlayEnable = true
        }

        
    }

    
    func countScore(score:Int){
        
        isUserInteractionEnabled = false
        //isDragAndPlayEnable = false
        
        let scoreToPass:[String:Int] = ["Score":score]
        //print("score:\(score)")
        countScoreTimer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(NewGameScene.startCounting), userInfo: scoreToPass, repeats: true)
        
        
    }
    

    @objc func startCounting(){

       // print("1")
        if let userInfo = countScoreTimer.userInfo as? Dictionary<String, Int>{
            //print("2")
            if let scoreToAdd = userInfo["Score"]{
             //   print("3")
                
                let scoreLabel = findLabelNode(name: "scoreLabel")
              
                //let size = CGSize(width: 100, height: 100)
        
                //print("scoreAdded:\(scoreAdded) and score:\(scoreToAdd)")
                if scoreAdded < scoreToAdd {
               // print("4")
                
                scoreAdded += 10
                    scoreLabel.text = String(Int(scoreLabel.text!)! + 10)
                } else {
                 //   print("5")
                    scoreAdded = 0
                    countScoreTimer.invalidate()
        
                    isUserInteractionEnabled = true
                   // isDragAndPlayEnable = true
                    
                }
                
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        hintSec = 0

        
        for touch in touches{
            
            location = touch.location(in: self)
            
            let node : SKNode = self.atPoint(location)
            
            var chiBtnDif = CGFloat()
            //var dif = CGFloat()
            
            switch  height {
            case 812:
                chiBtnDif = 0.8
              //  dif = 1.15
            case 736:
                chiBtnDif = 1
              //  dif = 1.1
                
            case 667:
                chiBtnDif = 0.95
              //  dif = 1
                
            case 568:
                chiBtnDif = 0.9
              //  dif = 0.9
                
            default:
                
                chiBtnDif = 0.9
              //  dif = 0.9
                
            }
            
            
            
            //如果在popQuiz有按鈕就要暫停timer
            if !isPopQuiz && node.name == "pause" {
                
                //暫停counting
                
                let lineNode = findImageNode(name: "countDownLine")
                lineNode.isPaused = true
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pause"), object: nil, userInfo: nil)
                
            }
            
            //放棄func
            
            if node.name == "abort"{
                
                
                //放棄
                
                //timesUp
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "timesUp"), object: nil, userInfo: nil)
                
                isFinalGetPoint = false
                
                
                //在此的功能為刪除倒數線
                practiceNextWord()

                //findImageNode(name: "abort").alpha = 0
                
                
                
            }
            
            

            //之後要寫中文錯誤的機制
            //確認中文正確與否
            if node.name == "leftChiBtn" || node.name == "leftChi" || node.name == "popUpBlock" || node.name == "popUpLabel"{
                
                
                //重置hintSec
                
                
                //停止timer
                //數字歸位
                popQuizTimer.invalidate()
                findLabelNode(name: "bigNumber").text = "0"
                findLabelNode(name: "smallNumber").text = "3"
                
                if leftOrRight == 0 {
                    //答對
                          self.run(rightSound)
                    
                    changeImageAlfa(name: "leftChiBtn", toAlpha: 0, time: 0.1)
                    changeImageAlfa(name: "popUpBlock", toAlpha: 0, time: 0.1)
                    
                    
                    if isPopQuiz{
                        

                        makeImageNode(name: "mark", image: "rightCircle", x: 0, y: -1334 / 2 + 228 * 1.5, width: 220 * chiBtnDif, height: 220 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                        
                        makeImageNode(name: "mark", image: "wrongX", x: 0, y: -1334 / 2 + 114, width: 220 * chiBtnDif, height: 230 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                        
                    } else {
                    
                    makeImageNode(name: "mark", image: "rightCircle", x: -190 * chiBtnDif, y: -355, width: 275 * chiBtnDif, height: 275 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                    makeImageNode(name: "mark", image: "wrongX", x: 190 * chiBtnDif, y: -355, width: 202 * chiBtnDif, height: 214 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                    }
                    
                    let when = DispatchTime.now() + 0.3
                    DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                        self!.chooseChineseResult(isCorrect: true)
                    })
                    
                    
                }else{
                    //答錯
                    
                    self.run(wrongSound)
                    changeImageAlfa(name: "leftChiBtn", toAlpha: 0, time: 0.1)
                    changeImageAlfa(name: "popDownBlock", toAlpha: 0, time: 0.1)
                    
                    
                    if isPopQuiz{
                        
                        makeImageNode(name: "mark", image: "wrongX", x: 0, y: -1334 / 2 + 228 * 1.5, width: 220 * chiBtnDif, height: 220 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                        
                        makeImageNode(name: "mark", image: "rightCircle", x: 0, y: -1334 / 2 + 114, width: 220 * chiBtnDif, height: 230 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                        
                    } else {
                    makeImageNode(name: "mark", image: "rightCircle", x: 190 * chiBtnDif, y: -355, width: 275 * chiBtnDif, height: 275 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                    
                    makeImageNode(name: "mark", image: "wrongX", x: -190 * chiBtnDif, y: -355, width: 202 * chiBtnDif, height: 214 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                }
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
            
            if node.name == "rightChiBtn" || node.name == "rightChi" || node.name == "popDownBlock" || node.name == "popDownLabel"{
                
                
                //停止timer
                //數字歸位
                popQuizTimer.invalidate()
                findLabelNode(name: "bigNumber").text = "0"
                findLabelNode(name: "smallNumber").text = "3"
                if leftOrRight == 1 {
                    //答對
                    self.run(rightSound)

                    //removeSomeNodes(name: "ChiBtn")
                    changeImageAlfa(name: "popDownBlock", toAlpha: 0, time: 0.1)
                    changeImageAlfa(name: "rightChiBtn", toAlpha: 0, time: 0.1)
                    
                    if isPopQuiz{
                        
                        makeImageNode(name: "mark", image: "wrongX", x: 0, y: -1334 / 2 + 228 * 1.5, width: 228 * chiBtnDif, height: 228 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                        
                        makeImageNode(name: "mark", image: "rightCircle", x: 0, y: -1334 / 2 + 114, width: 228 * chiBtnDif, height: 238 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                        
                        
                    } else {
                    makeImageNode(name: "mark", image: "wrongX", x: -190 * chiBtnDif, y: -355, width: 202 * chiBtnDif, height: 214 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                    makeImageNode(name: "mark", image: "rightCircle", x: 190 * chiBtnDif, y: -355, width: 275 * chiBtnDif, height: 275 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                    }
                    
                    let when = DispatchTime.now() + 0.3
                    DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                        self!.chooseChineseResult(isCorrect: true)
                    })
                    
                }else{
                    //答錯
                    
                    self.run(wrongSound)

                    //答錯
                    changeImageAlfa(name: "popDownBlock", toAlpha: 0, time: 0.1)
                    changeImageAlfa(name: "rightChiBtn", toAlpha: 0, time: 0.1)
                    
                    if isPopQuiz{
                        
                        
                        makeImageNode(name: "mark", image: "rightCircle", x: 0, y: -1334 / 2 + 228 * 1.5, width: 228 * chiBtnDif, height: 228 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                        
                        makeImageNode(name: "mark", image: "wrongX", x: 0, y:-1334 / 2 + 114, width: 228 * chiBtnDif, height: 238 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                        
                    } else {
                    makeImageNode(name: "mark", image: "rightCircle", x: -190 * chiBtnDif, y: -355, width: 275 * chiBtnDif, height: 275 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)

                    makeImageNode(name: "mark", image: "wrongX", x: 190 * chiBtnDif, y: -355, width: 202 * chiBtnDif, height: 214 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                    }
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
                
                if gameMode == 0 {
                line?.strokeColor = lightPink
                } else if gameMode == 1 {
                    
                    line?.strokeColor = orangeColor
                }
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
                
                
                
                //重置hintSec
                hintSec = 0
                
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
        
        //重置
        hintSec = 0
        
        if touchTimes > 0{
            
   
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
                    
                    hintSec = 0
                    findLabelNode(name: "showHint").text = ""
                    
     
                    
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
                    
                         //直接轉換isBackToSpell
                    
                        //如果是聽考模式就跳到選中文, gameMode1也是跳到這裡
                        if isBackToSpell {
                            
                            //計分
                            var score = Int()
                            
                            if answerTime == 0 {
                                
                                score = 300
                                
                            } else if answerTime == 1 {
                                
                                score = 150
                                
                                answerTime = 0
                            }
                            if gameMode == 0 {
                            countScore(score: score)
                            } else {
                                isUserInteractionEnabled = true
                            }
                            //跳到中文練習
                            isDragAndPlayEnable = false
                            
                            //要卡這個
                            testChinese()
                            
                        } else {
                            
                            if gameMode == 0{
                                
                                print("play right Sound")
                                
                                self.run(rightSound)
                            }
                            
                         
                            //第一次練習, 非聽考模式
                            
                            /*
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pronounceWord"), object: nil, userInfo: nil)
                            */
                            //發音
                            
                            /*
                            let contents:[String:Int] = ["pronounceTime":1]
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pronounceWord"), object: nil, userInfo: contents)
*/
                            
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
                            
                            
                            if gameMode == 0 {
                            countScore(score: 100)
                            }
                            
                            //在此卡一個正確動畫
                            
                            hintSlideIn(leftText: "很棒", rightText: "喔！", waitTime: 1, finished: {[weak self] in
                                
                                
                                self!.hintSlideIn(leftText: "換你", rightText: "發音", waitTime: 1.5, finished: {
                                    
                                    //口試
                                    //self!.recognizeWord()
                                    //開始辨認單字NC
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startToRecognize"), object: nil, userInfo: nil)
                                    
                                    //顯示跳出node
                                    
                                    //self!.hintSec = 0
                                    //self!.findLabelNode(name: "showHint").text = "請按一下麥克風"
                                    
                                    //不能dragAndPlay
                                    self!.isDragAndPlayEnable = false
                                    
                                })
                                
                            })
                            
                           
                        }
                    
               
                } else {
                    
                    //答案錯誤的機制
                    
                    print("wrong answer")
                    
           
                        self.run(wrongSound)
                    

                    //再次練習打錯的話就跳走, 之後要做答錯提示畫面
                    if isBackToSpell{
                        
                        //如果是gameMode == 1, 錯一次就遊戲停止
                     
                        
                        
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
                                
                                
                                if self!.gameMode == 1 {
                                    
                                    
                                    let wordCount:[String:Int] = ["wordCount":self!.wordReviewCount]
                                    
                                    print(wordCount)
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopReview"), object: nil, userInfo: wordCount)

                                    
                                    
                                } else {
                                
                                
                                
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
                                
                            }
                            })

                            
                            
                        } else {
                            
                            
                            
                            findLabelNode(name: "showHint").text = ""
                            
                            answerTime = 0
                            //失去機會
                            
                            //準備進入中文選項, 不能拖拉 這個應該就是bug
                            isDragAndPlayEnable = false
                            
                            //紀錄錯誤單字
                            correctResults[currentPracticeSequence] = "1"
                            var wrongWord = String()
                            
                            if gameMode == 0 {
                                wrongWord = wordSets[currentWordSequence].replacingOccurrences(of: " ", with: "")
                            } else if gameMode == 1 {
                                
                                wrongWord = allWordSets[randomSpots[currentPracticeSequence]][randomUnits[currentPracticeSequence]].replacingOccurrences(of: " ", with: "")
                            }
                            wrongWords.append(wrongWord)
                            
                            
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
        
        
        hintSec = 0
        let moveUp = SKAction.moveTo(y: -150, duration: 0)
        
        findLabelNode(name: "showHint").run(moveUp)
        findLabelNode(name: "showHint").text = "請選擇正確中文"
        
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
        
        var allChiWords = [String]()
        var chiWord = String()
        
        if gameMode == 0 {
        
        //抓亂數中文
        let quarterCount = wordSets.count / 3
        let halfCount = wordSets.count / 3 * 2
        chiWord = wordSets[quarterCount +  currentWordSequence]
  
        for i in quarterCount ..< halfCount{
            allChiWords.append(wordSets[i])
        }
        
        allChiWords.remove(at: currentWordSequence)
       
        } else if gameMode == 1 {
            
            //抓亂數中文
            let quarterCount = allWordSets[randomSpots[currentPracticeSequence]].count / 3
            let halfCount = allWordSets[randomSpots[currentPracticeSequence]].count / 3 * 2

            
            chiWord = allWordSets[randomSpots[currentPracticeSequence]][randomUnits[currentPracticeSequence] + quarterCount]
            
            
            for i in quarterCount ..< halfCount{
                allChiWords.append(allWordSets[randomSpots[currentPracticeSequence]][i])
            }
          
            //移除掉正確答案
            allChiWords.remove(at: randomUnits[currentPracticeSequence])

        }
        
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
        
           adjustLabelFontSizeToFitRect(labelNode: leftChiNode, rect: findImageNode(name: "leftChiBtn").frame)
        
           adjustLabelFontSizeToFitRect(labelNode: rightChiNode, rect: findImageNode(name: "rightChiBtn").frame)
        //只修正一次Y的位置
        /*
        if isChangeYPos == false {
        leftChiNode.position.y = leftChiNode.frame.origin.y - leftChiNode.frame.height / 6
        rightChiNode.position.y = rightChiNode.frame.origin.y - rightChiNode.frame.height / 6
        isChangeYPos = true
        }
*/
        
        let leftChiBtn = findImageNode(name: "leftChiBtn")
        let rightChiBtn = findImageNode(name:"rightChiBtn")
        
        //let leftChiBtn = findLabelNode(name: "popUpBlock")
        //let rightChiBtn = findLabelNode(name: "popDownBlock")
        
        let showAlpha = SKAction.fadeAlpha(to: 1, duration: 0.1)
        leftChiBtn.run(showAlpha)
        
        rightChiBtn.run(showAlpha)
        /*
        rightChiBtn.run(showAlpha, completion: {[weak self] in
            
            //self!.isUserInteractionEnabled = true
            
        })
        */
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

        self.run(rightSound)
        //countScore
        if gameMode == 0 {
        countScore(score: 500)
        }
        practiceNextWord()
        isFinalGetPoint = true
        
    }
    
    //練習下個字或是結束本回合 / 進入popQuiz
    func practiceNextWord(){
        
        let lineNode = findImageNode(name: "countDownLine")
        //把倒數線回復並隱藏
        lineNode.removeAllActions()
        lineNode.size = CGSize(width: 750, height: 5)
        lineNode.alpha = 0
        hintTime = 0
        
        
        if let abortKey = childNode(withName: "abort") as? SKSpriteNode{
            
            abortKey.alpha = 0
        }
        
        
        
        if gameMode == 0 {
        
        if currentWordSequence < (unitNumber + 1) * 3 - 1{
            
            /*
            //把倒數線回復並隱藏
            lineNode.removeAllActions()
            lineNode.size = CGSize(width: 750, height: 5)
            lineNode.alpha = 0
            */
            
            //順序加一
            currentWordSequence += 1
            currentPracticeSequence += 1
            
            shownWords.removeAll(keepingCapacity: false)
            wordEntered.removeAll(keepingCapacity: false)
            
            
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
            
                firstEngWordLabel.isHidden = false
                firstChiWordLabel.isHidden = false
                practice()
            
            //沒練習完就繼續練習
            isFinalGetPoint = false
            
        } else {
            //三個字以練習完
            
            //不能暫停
            findImageNode(name: "pause").isHidden = true
            
            //在此確認是否為雙數結束
            
            if (unitNumber + 1) % 2 == 0{
                
                print("雙數結尾")
                

                //進入pop quiz
                
                isPopQuiz = true
                
                // 載入新背景
                // 刪除舊畫面
                findImageNode(name: "recogWordsBg").alpha = 0
                changeTexture(nodeName: "gameBg", newTexture: "popQuizBg2")
                
                findImageNode(name: "star0").alpha = 1
                findImageNode(name: "star1").alpha = 1
                findImageNode(name: "star2").alpha = 1
                
                
                hintSlideIn(leftText: "限時", rightText: "挑戰", waitTime: 1.2) {[weak self] in
                    
                    //把這些畫面包起來,少寫很多self!.
                    self!.setupPopQuizScreen()
                    self!.popQuiz()
                }
                
                /*
                print(randomNums)
                print(engRandomNums)
                print(allPopQuizChiWords)
                print(allPopQuizEngWords)
                */
                
                
            } else {
                
                print("單數結尾")
                
                
                //抓三個單字的狀態 + 分數
                //lineNode.removeAllActions()
               
                let scoreLabel = findLabelNode(name: "scoreLabel")
                
                var scoreToPass = scoreLabel.text!
                if isFinalGetPoint{
                  
                    scoreToPass = String(Int(scoreLabel.text!)! + 500)
                    
                }
                //應該不用在加500
               
                
                if user != nil {
                //這是連接後端的func
                addWrongWords()
                }
                
                let threeWords:[String:[String]] = ["engWords":allThreeEngWords,"chiWords":allThreeChiWords,"wrongWords":wrongWords,"score":[scoreToPass],"correctResults":correctResults,"popQuizRight":[String(popQuizRight)],"wrongChinese":wrongChinese]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "leaveGame"), object: nil, userInfo: threeWords)

                
            }
            
        }

            
        } else if gameMode == 1 {
            
            
            let moveBack = SKAction.moveTo(y: -290, duration: 0)
            
            findLabelNode(name: "showHint").run(moveBack)
            
            //以下為單純複習單字的機制
            //確認allunitspotnums有無用完
            if allUnitSpotNums.count == 0 {
                
            
                //練完的機制要先確認這次loadAllKindsOfWord的三個字是否已經用完
                if currentPracticeSequence == 2 {
                    
                    //之後要接續練完的畫面
                        print("練完了")
                    
                    
                    
                    let wordCount:[String:Int] = ["wordCount":wordReviewCount]
                    
                    print(wordCount)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopReview"), object: nil, userInfo: wordCount)
                    
                    
                    
                } else {
                    
                    print("檢查點繼續練")
                    
                    /*
                    //把倒數線回復並隱藏
                    lineNode.removeAllActions()
                    lineNode.size = CGSize(width: 750, height: 5)
                    lineNode.alpha = 0
                    */
                    //順序加一
                    
                    
                   // currentPracticeSequence += 1
                    
                    
                    if currentPracticeSequence == 2 {
                        
                        currentPracticeSequence = 0
                    } else {
                        
                        currentPracticeSequence += 1
                        
                    }
 
                    shownWords.removeAll(keepingCapacity: false)
                    wordEntered.removeAll(keepingCapacity: false)
                    
                    
                    //準備下一個字的練習, 這裡是否需要不一定
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
                    
                    if currentPracticeSequence == 0 {
                        //重新做三個字
                        loadAllKindsOfWord()
                        makeWords()
                        
                    } else {
                        
                        //直接複習下個字
                        reviewWordMode()
                  
                    }
                    
                }
                

            } else {
                print("繼續練")
                
                /*
                //把倒數線回復並隱藏
                lineNode.removeAllActions()
                lineNode.size = CGSize(width: 750, height: 5)
                lineNode.alpha = 0
                */
                
                
                //順序加一
                
                if currentPracticeSequence == 2 {
          
                currentPracticeSequence = 0
                } else {

                    currentPracticeSequence += 1
                    
                }
                shownWords.removeAll(keepingCapacity: false)
                wordEntered.removeAll(keepingCapacity: false)
                
                
                
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
                
                
                if currentPracticeSequence == 0 {
                    //重新做三個字
                    
                    //workAround -1 因為等等會+1
                    mapPassedInt -= increaseNum
                    
                    loadAllKindsOfWord()
                    makeWords()
                    
                } else {
                    
                    //直接複習下個字
                    reviewWordMode()
                }
            }
   
            
        } else if gameMode == 2 {
            //只練習句子
            
                print("practice next sentence")
                
            //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopReview"), object: nil, userInfo: nil)
            
            
            /*
                let wordSequence:[String:Int] = ["wordSequence":currentWordSequence]
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "onlyPracticeSentence"), object: nil, userInfo: wordSequence)
              */
 
            
        }
        
    }
    
    
    
    @objc func notifyStopLimitTimer(){
        
        
    }
    
    func setupPopQuizScreen(){
        
       
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopLimitTimer"), object: nil, userInfo: nil)
        
        //隱藏放棄鈕
        
        findLabelNode(name: "quizTitle").alpha = 1
        findImageNode(name: "timerBg").alpha = 1
        findLabelNode(name: "bigNumber").alpha = 1
        findLabelNode(name: "smallNumber").alpha = 1
        findLabelNode(name: "bigChineseLabel").alpha = 1
        //findImageNode(name: "leftChiBtn").alpha = 1
        //findImageNode(name: "rightChiBtn").alpha = 1
        //changeTexture(nodeName: "leftChiBtn", newTexture: "popQuizBlock")
        //changeTexture(nodeName: "rightChiBtn", newTexture: "popQuizBlock")
        
        adjustLabelFontSizeToFitRect(labelNode: findLabelNode(name: "bigChineseLabel"), rect: findLabelNode(name: "bigChineseLabel").frame)
        
        findImageNode(name: "popUpBlock").alpha = 1
        findImageNode(name: "popDownBlock").alpha = 1
        
        // 載入前二組單字
        
        
        for i in 0 ..< 3{
            
            allPopQuizEngWords.append(allThreeEngWords[i])
            allPopQuizEngWords.append(popQuizThreeEngWords[i])
            allPopQuizChiWords.append(allThreeChiWords[i])
            allPopQuizChiWords.append(popQuizThreeChiWords[i])
            
        }
        
        randomNums.shuffled()
        engRandomNums = randomNums
    }
    
    
    //製作popQuiz的字及答案
    func popQuiz(){
        
        //回復可以按鈕
        
        if !countScoreTimer.isValid{
            print("countscore timer not activated")
        isUserInteractionEnabled = true
        }
        
        
        if popQuizSeq > 2 {
            
            print("3 pop quizes over")
            
            //移除畫面
            //離開遊戲
            
            //以下function等同單數離開
            let scoreLabel = findLabelNode(name: "scoreLabel")
            
            var scoreToPass = scoreLabel.text!
            /*
            if isFinalGetPoint{
                 scoreToPass = String(Int(scoreLabel.text!)! + 500)
            }
           */
            
            if isFinalPopCorrect{
                
                scoreToPass = String(Int(scoreLabel.text!)! + 300)
            }
            
            //這是連接後端的func
            addWrongWords()
            
            
            let threeWords:[String:[String]] = ["engWords":allThreeEngWords,"chiWords":allThreeChiWords,"score":[scoreToPass],"correctResults":correctResults,"popQuizRight":[String(popQuizRight)],"wrongChinese":wrongChinese,"wrongWords":wrongWords]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "leaveGame"), object: nil, userInfo: threeWords)
            
        } else {
            
            //remove pronounceBtn
            print("trigger remove btn")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "removePlaySoundBtn"), object: nil, userInfo: nil)
            
            
            //啟動timer
            popQuizTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NewGameScene.popQuizCountDown), userInfo: nil, repeats: true)
        
            var twoEngAnswers = [String]()
       
            let chiQuestion = allPopQuizChiWords[randomNums[popQuizSeq]]
        
            let correctEng = allPopQuizEngWords[randomNums[popQuizSeq]]
        
            //抓另一個英文選項, 移除第一個位置, 因為數量一直遞減
            engRandomNums.remove(at: 0)
            
            let ran = Int(arc4random_uniform(UInt32(engRandomNums.count)))
            let wrongEng = allPopQuizEngWords[engRandomNums[ran]]

            //決定左或右是正確
            let rightRan = Int(arc4random_uniform(UInt32(2)))
            if rightRan == 0 {
                
                twoEngAnswers.append(correctEng)
                twoEngAnswers.append(wrongEng)
                leftOrRight = 0
                
            } else {
                twoEngAnswers.append(wrongEng)
                twoEngAnswers.append(correctEng)
                leftOrRight = 1
                
            }
            
     
            findLabelNode(name: "bigChineseLabel").text = chiQuestion
            
            findLabelNode(name: "popUpLabel").text = twoEngAnswers[0]
            findLabelNode(name: "popDownLabel").text = twoEngAnswers[1]
            
            //leftChiNode.text = twoEngAnswers[0]
            //rightChiNode.text = twoEngAnswers[1]
            
            adjustLabelFontSizeToFitRect(labelNode: findLabelNode(name: "popUpLabel"), rect: findLabelNode(name: "popUpLabel").frame)
            adjustLabelFontSizeToFitRect(labelNode: findLabelNode(name: "popDownLabel"), rect: findLabelNode(name: "popDownLabel").frame)
            
            //adjustLabelFontSizeToFitRect(labelNode: leftChiNode, rect: findImageNode(name: "leftChiBtn").frame)
            
            //adjustLabelFontSizeToFitRect(labelNode: rightChiNode, rect: findImageNode(name: "rightChiBtn").frame)
        
            popQuizSeq += 1
        
        }
        
    }
    
    @objc func notifyStopReview(){
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
        
        hintSec += 1
        
        if hintSec >  150{
            //都沒動就發動
            //print("需要提醒")
            findLabelNode(name: "showHint").isHidden = false
            
            
        } else {
            //print("x")
            findLabelNode(name: "showHint").isHidden = true
        }
        
        
        
        
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
            
            if self!.gameMode == 0 {
            
            selectedLabel.fontColor = self!.selectWordDarkColor
            }
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
        
        var correctWord = String()
           var countNum = Int()
        for word in currentWordArray{
            
            correctWord += word
            
        }
        if gameMode == 1 {
            findLabelNode(name: "tempWord").text = correctWord
            countNum = 3
            
        } else {
            
            countNum = 2
        }

        
        let wait = SKAction.wait(forDuration: 0.2)
        let redFontAction = SKAction.run({[weak self] in
            self!.findLabelNode(name: "tempWord").fontColor = .red
        })
        let whiteFontAction = SKAction.run({[weak self] in
            if self!.gameMode != 1 {

            self!.findLabelNode(name: "tempWord").fontColor = .white
            }
        })
        let sequence = SKAction.sequence([redFontAction,wait,whiteFontAction,wait])
     
        
        
        let repeatAction = SKAction.repeat(sequence, count: countNum)
        
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
    
    
    //popQuiz的計分邏輯還沒寫
    
    func chooseChineseResult(isCorrect:Bool){
        
        //正確
        
        //計分部分, 之後要寫複習的計分
        
        if isCorrect{
            
            
            if gameMode == 0 {
            countScore(score: 300)
                
                
                findLabelNode(name: "showHint").text = ""
                
                
            } else if gameMode == 1 {
                //update wordReviewCount
                
                wordReviewCount += 1
                
                practiceNextWord()
                
                //刪掉一些不該出現的
                notifyShowSentence()
                
                
                
            }
            
      
            
            if isPopQuiz{
            
                popQuizRight += 1
            let fadeIn = SKAction.fadeIn(withDuration: 0.1)
            let moveUp = SKAction.moveTo(y: 520, duration: 0.1)
            let groupAction = SKAction.group([fadeIn,moveUp])
            let wait = SKAction.wait(forDuration: 0.05)
            
                switch popQuizRight {
                case 0:
                    let sparkleAction = SKAction.run {[weak self] in
                        self!.sparkle?.isHidden = false
                        self!.sparkle?.resetSimulation()
                    }
                    let sequence = SKAction.sequence([wait,sparkleAction])
                    let groupAgain = SKAction.group([sequence,groupAction])
                    
                    findImageNode(name: "star3").run(groupAgain)
                case 1:
                    
                    let sparkleAction = SKAction.run {[weak self] in
                        self!.sparkle1?.isHidden = false
                        self!.sparkle1?.resetSimulation()
                    }
                    let sequence = SKAction.sequence([wait,sparkleAction])
                    let groupAgain = SKAction.group([sequence,groupAction])
                    
                    findImageNode(name: "star4").run(groupAgain)
                    
                    
                case 2:
                    let sparkleAction = SKAction.run {[weak self] in
                        self!.sparkle2?.isHidden = false
                        self!.sparkle2?.resetSimulation()
                    }
                    let sequence = SKAction.sequence([wait,sparkleAction])
                    let groupAgain = SKAction.group([sequence,groupAction])
                    
                    isFinalPopCorrect = true
                    findImageNode(name: "star5").run(groupAgain)
                    
                default:
                    break
                    
                    
                }
                
         
            }
            
            //如果是popQuiz就繼續挑戰
            if isPopQuiz {
                
                //findImageNode(name: "leftChiBtn").alpha = 1
                //findImageNode(name: "rightChiBtn").alpha = 1
                
                
                findImageNode(name: "popUpBlock").alpha = 1
                findImageNode(name: "popDownBlock").alpha = 1
                
                //leftChiNode.text = ""
                //rightChiNode.text = ""
                
                findLabelNode(name: "popUpLabel").text = ""
                findLabelNode(name: "popDownLabel").text = ""
                
                removeSomeNodes(name: "mark")
                
                popQuiz()
                
            } else {
                
                let wordSequenceToPass:[String:Any] = ["currentWordSequence":String(currentWordSequence),"pronounceTime":1]
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showSentence"), object: nil, userInfo: wordSequenceToPass)
            }
            
            
        } else {
            //錯誤的話
            correctResults[currentPracticeSequence] = "1"
            
            //紀錄中文錯誤
            wrongChinese[currentPracticeSequence] = "1"
            
            var wrongWord = String()
            
            if gameMode == 0 {
                
                findLabelNode(name: "showHint").text = ""
                
                
             wrongWord = wordSets[currentWordSequence].replacingOccurrences(of: " ", with: "")
                
                
                //send Nc
                //testing add here
                
                /*
                 let wordSequence:[String:Int] = ["wordSequence":currentWordSequence]
                 
                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: "onlyPracticeSentence"), object: nil, userInfo: wordSequence)
                 */
                
                
                //如果是popQuiz就繼續挑戰
                if isPopQuiz {
                    
        
                    
                    //findImageNode(name: "leftChiBtn").alpha = 1
                    //findImageNode(name: "rightChiBtn").alpha = 1
                    findImageNode(name: "popUpBlock").alpha = 1
                    findImageNode(name: "popDownBlock").alpha = 1
                    
                    
                    
                    //leftChiNode.text = ""
                    //rightChiNode.text = ""
                    findLabelNode(name: "popUpLabel").text = ""
                    findLabelNode(name: "popDownLabel").text = ""
                    
                    
                    removeSomeNodes(name: "mark")
                    
                    popQuiz()
                    
                } else {
                    
                    let wordSequenceToPass:[String:Any] = ["currentWordSequence":String(currentWordSequence),"pronounceTime":1]
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showSentence"), object: nil, userInfo: wordSequenceToPass)
                }

                
                if !wrongWords.contains(wrongWord){
                    wrongWords.append(wrongWord)
                }

                
                
                
                
                
            } else if gameMode == 1 {
                
                //應該不用指定wrongWord因為不需要update
                   // wrongWord = allWordSets[randomSpots[currentPracticeSequence]][randomUnits[currentPracticeSequence]].replacingOccurrences(of: " ", with: "")
                
                
                    let wordCount:[String:Int] = ["wordCount":wordReviewCount]
              
                print(wordCount)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopReview"), object: nil, userInfo: wordCount)

                
            }
            


        }
        
        
   
        
    }
    

    
    
    
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

