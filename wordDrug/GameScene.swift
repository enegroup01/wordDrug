//
//  GameScene.swift
//  wordDrug
//
//  Created by Ethan on 2017/10/18.
//  Copyright © 2017年 playplay. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //node按鈕位置
    var location = CGPoint()
    
    //特殊顏色
    let pinkColor = UIColor.init(red: 240/255, green: 31/255, blue: 249/255, alpha: 1)
    let lightBlue = UIColor.init(red: 151/255, green: 224/255, blue: 255/255, alpha: 1)
    let coverPurple = UIColor.init(red: 98/255, green: 44/255, blue: 85/255, alpha: 1)
    let lightPinkColor = UIColor.init(red: 251/255, green: 154/255, blue: 255/255, alpha: 1)
    let tiffanyColor = UIColor.init(red: 9/255, green: 255/255, blue: 218/255, alpha: 1)
    let diamondGreen = UIColor.init(red: 0/255, green: 215/255, blue: 58/255, alpha: 1)
    
    //暫時使用的單字
    var wordSets = [String]()
    
    //暫時設定的音節
    var syllables = ["ca","ac","ed","ad"]
    
    //下一個顯示單字的順序
    var nextWordSequence = Int()
    
    //目前單字的順位
    var currentWordSequence = 0
    
    //發音單字
    var wordsToPronounce = String()
    
    
    //避免重複發音
    var isScanning = true
    
    //選項單字
    var shownWords = [String]()
    
    //已經正確輸入的音節數
    var alreadyCorrectsyllables = 0
    //輸入的答案
    var wordEntered = [String]()
    //正確的答案
    var currentWordArray = [String]()
    
    //是否能作答
    var isDragAndPlayEnable = false
    
    //是否能按功能button
    var isButtonEnable = false
    
    
    //autoPlay使用變數
    var isPracticeMode = false
    var playSoundTime = 0
    var correctTime = 0
    
    //battleMode變數
    var isBattleMode = false
    //確認贏幾次來算combo
    var battleComboTime = 0
    
    //確認回合是否結束, 暫時用不到
    var isRoundEnd = false
    
    //動態怪物及玩家血
    var monsterBlood = CGFloat()
    var playerBlood = CGFloat()
    
    //怪物及玩家滿血
    var fullMonsterBlood = CGFloat()
    var fullPlayerBlood = CGFloat()
    
    //答案正確時的自我爆炸特效
    var explodeEmitter:SKEmitterNode?

    
    //怪物攻擊Emiiter特效
    var monsterExplode:SKEmitterNode?
    var monsterAttack:SKEmitterNode?
    
    //怪物變數
    var monsters = ["flatMonster1","flatMonster2","flatMonster3"]
    //輪流順序
    var monsterSequence = 0
    
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
    
    //紀錄已經按到的node
    var nodesTouched = [SKSpriteNode]()
    
    //紀錄按到了幾次node
    var touchTimes = 0
    
    //是否是按第一下
    var isFirstTouch = false
    //有沒有按畫面
    var isTouched = false
    //結束有沒有在node上
    var isEndOnNode = false
    //node有沒有移除
    var isRemoved = false
    
    //所有node的名稱
    var selNodeNames = ["se0","se1","se2","se3"]
    
    override func didMove(to view: SKView) {
        
        //建立整個背景
        makeImageNode(name: "bg", image: "bg", x: 0, y: 0, width: 750, height: 1334, z: 0, alpha: 1, isAnchoring: false)
        
        //建立任務版子
        makeImageNode(name: "questBoard", image: "questBoard4", x: 0, y: -120, width: 700, height: 0, z: 1, alpha: 1, isAnchoring: false)
        
        //建立任務標題
        makeLabelNode(x: -100, y:220, alignMent: .left, fontColor: diamondGreen, fontSize: 50, text: "", zPosition: 2, name: "questTitle", fontName: "Helvetica Bold", isHidden: false, alpha:1)
        
        //任務板子動畫 + 標題動畫
        openQuest()
        
        //建立怪物畫面背景
        makeImageNode(name: "screenBg", image: "screenBg", x: 0, y: 500, width: 750, height: 431, z: 1, alpha: 1, isAnchoring: false)
        
        //建立開啟按鈕
        makeNode(name: "button", color: .clear, x: 0, y: -575, width: 150, height: 150, z: 2, isAnchoring: false, alpha: 1)
        
        //讀取Bundle裡的文字檔
        var wordFile:String?
        
        if let filepath = Bundle.main.path(forResource: "ca2", ofType: "txt") {
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
        
        
        //製作按鈕
        
        let lightWidth:CGFloat = 215.8
        let lightHeight:CGFloat = 235.3
        let darkWidth:CGFloat = 162.5
        let darkHeight:CGFloat = 175.5
    
        
        //選項按鈕
        
        makeNode(name: "se0", color: .clear, x:-160 , y: -380, width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se1", color: .clear, x:-160 , y: -180, width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se2", color: .clear, x:160 , y: -380, width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se3", color: .clear, x:160 , y: -180, width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        
        //填滿按鈕

        
        makeImageNode(name: "0filledButton", image: "lightGreenD", x:-160 , y: -380, width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "1filledButton", image: "lightGreenD", x:-160 , y: -180, width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "2filledButton", image: "lightGreenD", x:160 , y: -380, width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "3filledButton", image: "lightGreenD", x:160 , y: -180, width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        
        //空的按鈕
        makeImageNode(name: "0emptyButton", image: "darkGreenD", x:-160 , y: -380, width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "1emptyButton", image: "darkGreenD", x:-160 , y: -180, width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "2emptyButton", image: "darkGreenD", x:160 , y: -380, width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "3emptyButton", image: "darkGreenD", x:160 , y: -180, width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        
        //建立三黑點+亮點, 並hidden
        makeImageNode(name: "bDot1", image: "bDot1", x: -70, y: -70, width: 60, height: 30, z: 2, alpha: 0, isAnchoring: false)
        makeImageNode(name: "bDot2", image: "bDot2", x: 0, y: -70, width: 60, height: 30, z: 2, alpha: 0, isAnchoring: false)
        makeImageNode(name: "bDot3", image: "bDot3", x: 70, y: -70, width: 60, height: 30, z: 2, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "lDot1", image: "lDot1", x: -70, y: -70, width: 105, height: 70, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "lDot2", image: "lDot2", x: 0, y: -70, width: 105, height: 70, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "lDot3", image: "lDot3", x: 70, y: -70, width: 105, height: 70, z: 3, alpha: 0, isAnchoring: false)
        
        //避免多次按
        self.view?.isMultipleTouchEnabled = false
        

        //自我爆炸explode
        explodeEmitter = SKEmitterNode(fileNamed: "explode.sks")
        explodeEmitter?.position = CGPoint(x: 0, y: 70)
        explodeEmitter?.zPosition = 4
        explodeEmitter?.name = "explodeEmitter"
        explodeEmitter?.isHidden = true
        addChild(explodeEmitter!)


        //怪物爆炸
        monsterExplode = SKEmitterNode(fileNamed: "monsterExplode.sks")
        monsterExplode?.position = CGPoint(x: 0, y: 455)
        monsterExplode?.zPosition = 4
        monsterExplode?.name = "mExplode"
        monsterExplode?.isHidden = true
        addChild(monsterExplode!)
        
        //怪物攻擊
        monsterAttack = SKEmitterNode(fileNamed: "monsterAttack.sks")
        monsterAttack?.position = CGPoint(x: 0, y: -50)
        monsterAttack?.zPosition = 4
        monsterAttack?.name = "mAttack"
        monsterAttack?.isHidden = true
        addChild(monsterAttack!)
        

        //連擊Label
        makeLabelNode(x: 0, y: 455, alignMent: .center, fontColor: diamondGreen, fontSize: 70, text: "Combo Attack", zPosition: 5, name: "comboAttack", fontName: "Helvetica Bold", isHidden: false, alpha: 0)

    }
    
    //拉開任務＋連結開始學習
    func openQuest(){
        //拉開任務板子的action
        let questBoardAction = SKAction.resize(toHeight: 780, duration: 0.3)
        
        //拉開任務 ＋ 開始學習階段
        findImageNode(name: "questBoard").run(questBoardAction) {[weak self] in
            
            let action = self!.typingAction(text: "loading", nodeName: "questTitle", finalText: "Quest")
            self!.run(action, completion: {[weak self] in
                
                //開始學習階段, 也是產生學習單字的func
                self!.startLearning()
                
                //可以按畫面
                self?.isUserInteractionEnabled = true
                //可以按button
                self!.isButtonEnable = true
                
            })
            
        }
        
    }
    
    //學習階段, 也是產生學習單字的func
    func startLearning(){
        
        //找目前sequence的英文+中文字
        let halfCount = wordSets.count / 3
        let engWord = wordSets[currentWordSequence]
        let chiWord = wordSets[halfCount +  currentWordSequence]

        
        //製作中英文字
        makeWords(word: engWord, lang: "engWord")
        makeWords(word: chiWord, lang: "chiWord")
        
        //字fade in
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        for node in children{
            
            if (node.name?.contains("Word"))!{
                
                node.run(fadeIn, completion: {[weak self] in
                    
                    if (node.name?.contains("chiWord"))!{
                        
                        //中文字產生完之後, 就產生掃描線及發音
                        self!.scanAndPronounce()
                        
                        //產生黑點點
                        self!.findImageNode(name: "bDot1").alpha = 1
                        self!.findImageNode(name: "bDot2").alpha = 1
                        self!.findImageNode(name: "bDot3").alpha = 1
                    }
                    
                })
                
            }
        }
        
    }
    
    
    
    
    
    //製作掃描線+發音
    func scanAndPronounce(){
        
        //抓任務背景node
        if let questBoard = findImageNode(name: "questBoard") as SKSpriteNode?{
            
            //抓任務背景寬度
            let questBoardWidth = questBoard.size.width
            
            //設定掃描總高度
            let engChiWordHeight:CGFloat = 174
            
            // semi-autoplay 檢查
            
            //製作掃描線
            //避免已有scanningline *這一定要
            if childNode(withName: "scanning") != nil {
                
                print("already has scanning line")
                
            } else {
                
                //製作scanningline
                makeNode(name: "scanning", color: diamondGreen, x: 0, y: 120, width: questBoardWidth, height: 1, z: 3, isAnchoring: false, alpha: 1)
                
            }
            
            //往下掃瞄速度
            let scanAction = SKAction.moveTo(y: 120 - engChiWordHeight, duration: 0.3)
            //線縮起來速度
            let shrinkAction = SKAction.resize(toWidth: 0, duration: 0.08)
            let sequenceAction = SKAction.sequence([scanAction,shrinkAction])
            
            //啟動掃描動畫
            
            if let scanningLine = findImageNode(name: "scanning") as SKSpriteNode?{
                
                scanningLine.run(sequenceAction, completion: {[weak self] in
                    //播放發音
                    self!.pronounce()
                    
                    let removeAction = SKAction.run({
                        
                        //移除掃描線
                        self!.findImageNode(name: "scanning").removeFromParent()
                        
                    })
                    
                    self!.run(removeAction, completion: {
                        
                        
                        //允許再按掃描
                        self!.isScanning = false
                        
                        
                        //判斷在聽讀模式還是練習模式
                        //非戰鬥模式時才亮燈
                        if self!.isBattleMode == false {
                        
                        if self!.isPracticeMode == false {
                            
                            self!.playSoundTime += 1
                            
                            //聽讀模式
                            self!.lightDotFunc(times: self!.playSoundTime)
                            
                            print("1")
                            
                        } else{
                            
                            //練習模式
                            self!.lightDotFunc(times: self!.correctTime)
                            
                            print("2")
                        }
                        
                        
                    }
                    }
                    )
                    
                })
                
            }
            
            
            
        }
    }
    
    //單純發音功能, 要搭配scanAndPronounce使用
    func pronounce(){
        
        let pronounceAction = SKAction.playSoundFileNamed(wordsToPronounce + ".mp3", waitForCompletion: true)
        run(pronounceAction)
        
    }
    
    //亮燈功能, 也順便切換hint的字
    func lightDotFunc(times: Int){
        
        let fadeIn = SKAction.fadeIn(withDuration: 0.3)
        
        switch times {
            
        case 1:
            findImageNode(name: "lDot1").run(fadeIn)
        case 2:
            findImageNode(name: "lDot2").run(fadeIn)
        case 3:
            
            findImageNode(name: "lDot3").run(fadeIn)
            
            if isPracticeMode == false {
                
                //更改hint文字
                findLabelNode(name: "hint").text = "[ 準備進入練習 ]"
                
            } else {
                //回到學習單字
                isUserInteractionEnabled = false
                
                findLabelNode(name: "hint").text = "[ 練習完成 ]"
                
                findImageNode(name: "lDot3").alpha = 0
                
            }
            
        default:
            break
        }
        
    }
    
    //戰鬥模式
    func battleMode(){

        //抓怪物名稱來做圖片
        let monsterName = monsters[monsterSequence]
        
        //進入battle模式
        isBattleMode = true
        
        //隱藏QuestTitle
        findLabelNode(name: "questTitle").text = ""
        
        //移除進度點
        removeSomeNodes(name: "Dot")
        

        //移除選項字
        removeSomeNodes(name: "Sel")
        
         //移除中英文字
        removeSomeNodes(name: "Word")
        
        //更改hint
        findLabelNode(name: "hint").text = ""
        
        
        //怪物畫面
        makeImageNode(name: "monsterBlurredBg", image: "blurredBg", x: 0, y: 500, width: 750, height: 431, z: 2, alpha: 0, isAnchoring: false)
        
        // 建立怪物 width:750
        makeImageNode(name: "monsterEffect", image: "monsterEffect", x: 0, y: 450, width: 0, height: 431, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "monster", image: monsterName, x: 0, y: 455, width: 183.6, height: 216, z: 4, alpha: 0, isAnchoring: false)
        
        
        //怪物titleBg
        makeImageNode(name: "monsterTitleBg", image: "monsterTitle", x: 0, y: 632, width: 750, height: 70, z: 4, alpha: 0, isAnchoring: false)
        
        //怪物title
        makeLabelNode(x: 0, y: 624, alignMent: .center, fontColor: tiffanyColor, fontSize: 35, text: "Level 1 [Ca] 元素怪", zPosition: 5, name: "monsterTitle", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        //怪物血Bg
        makeImageNode(name: "monsterBloodBg", image: "bloodBg", x: 0, y: 310, width: 510, height: 20, z: 4, alpha: 0, isAnchoring: false)
        //怪物血
        makeImageNode(name: "monsterBlood", image: "monsterBlood", x: -256, y: 300, width: 510, height: 20, z: 5, alpha: 0, isAnchoring: true)
    
        //player血Bg
         makeImageNode(name: "playerBloodBg", image: "bloodBg", x: 0, y: 180, width: 510, height: 20, z: 4, alpha: 0, isAnchoring: false)
        
        //player血
        makeImageNode(name: "playerBlood", image: "playerBlood", x: -273, y: 145, width: 545, height: 70, z: 5, alpha: 0, isAnchoring: true)
        
        
        //確認血量
        fullMonsterBlood = findImageNode(name: "monsterBlood").size.width
        fullPlayerBlood = findImageNode(name: "playerBlood").size.width

        
        for node in children{

            //把選項alpha弄淡
            if (node.name?.contains("emptyButton"))!{
                
                node.alpha = 0
                
            }
            if (node.name?.contains("filledButton"))!{
                
                node.alpha = 0
                
            }
            
        }
        

        //怪物出現前動畫, 出現後顯時所有資訊
        monsterAppearIntro{[weak self] in
            
            //顯示怪物Label, x = 0
            let label = self!.findLabelNode(name: "questTitle")
            label.position.x = 0
            label.fontSize = 35
            label.horizontalAlignmentMode = .center
            label.text = "戰鬥開始"
            
            self!.findLabelNode(name: "hint").text = "[ 結合正確音節攻擊元素怪 ]"
            
            //顯示所有怪物資訊及玩家血條
            self!.changeImageAlfa(name: "monsterTitleBg", toAlpha: 1, time: 0)
            self!.changeLabelAlfa(name: "monsterTitle", toAlpha: 1, time: 0)
            self!.changeImageAlfa(name: "monsterBloodBg", toAlpha: 1, time: 0)
            self!.changeImageAlfa(name: "monsterBlood", toAlpha: 1, time: 0)
            self!.changeImageAlfa(name: "playerBloodBg", toAlpha: 1, time: 0)
            self!.changeImageAlfa(name: "playerBlood", toAlpha: 1, time: 0)
            
            //開始戰鬥
            self!.battleTest()
        }


    }
    
    //怪物出現畫面動畫
    func monsterAppearIntro(finished: @escaping () -> Void){
        
        //左右框
        makeImageNode(name: "leftFrame", image: "leftFrame", x: -450, y: 50, width: 141, height: 29, z: 2, alpha: 1, isAnchoring: false)
        makeImageNode(name: "rightFrame", image: "rightFrame", x: 450, y: 30, width: 141, height: 29, z: 2, alpha: 1, isAnchoring: false)
        //發現怪物字樣
        makeLabelNode(x: 0, y: 25, alignMent: .center, fontColor: diamondGreen, fontSize: 50, text: "發現怪物", zPosition: 2, name: "monsterFound", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        let toRight = SKAction.moveTo(x: -215, duration: 0.05)
        let floatToRight = SKAction.moveTo(x: -195, duration: 2)
        let sequence = SKAction.sequence([toRight,floatToRight])
        findImageNode(name: "leftFrame").run(sequence)
        
        let toLeft = SKAction.moveTo(x: 215, duration: 0.05)
        let floatToLeft = SKAction.moveTo(x: 195, duration: 2)
        let sequence1 = SKAction.sequence([toLeft,floatToLeft])
        findImageNode(name: "rightFrame").run(sequence1)
        
        let wait = SKAction.wait(forDuration: 0.05)
        let fadeIn = SKAction.fadeIn(withDuration: 0)
        let waitLonger = SKAction.wait(forDuration: 1.5)
        let fadeOut = SKAction.fadeOut(withDuration: 0)
        let waitTillEnd = SKAction.wait(forDuration: 0.5)
        let vanishToLeft = SKAction.moveTo(x: -450, duration: 0.05)
        let vanishToRight = SKAction.moveTo(x: 450, duration: 0.05)
        
        let sequence2 = SKAction.sequence([wait,fadeIn,waitLonger,fadeOut,wait,fadeIn,waitTillEnd])
        
        findLabelNode(name: "monsterFound").run(sequence2) {[weak self] in
            
            self!.findImageNode(name: "leftFrame").run(vanishToLeft)
            self!.findImageNode(name: "rightFrame").run(vanishToRight)
            self!.findLabelNode(name: "monsterFound").alpha = 0
            
            
            //1. 模糊背景
            self!.changeImageAlfa(name: "monsterBlurredBg", toAlpha: 1, time: 0.2)
            
            //2. 怪物後方背景
            
            let enlarge = SKAction.resize(toWidth: 750, duration: 0.2)
            self!.changeImageAlfa(name: "monsterEffect", toAlpha: 1, time: 0.2)
            
            self!.findImageNode(name: "monsterEffect").run(enlarge, completion: {[weak self] in
                
                //3. 怪物出現, 然後永久上下動
                let showUp = SKAction.run({
                    self!.changeImageAlfa(name: "monster", toAlpha: 1, time: 0)
                })
                
                let up = SKAction.moveTo(y: 460, duration: 0.2)
                let down = SKAction.moveTo(y: 450, duration: 0.3)
                let wait = SKAction.wait(forDuration: 0.2)
                let upWaitDown = SKAction.sequence([up,wait,down])
                let repeatAction = SKAction.repeatForever(upWaitDown)
                let sequence = SKAction.sequence([showUp,repeatAction])
                self!.findImageNode(name: "monster").run(sequence)
                
                finished()
                
            })
            
        }
        
    }
    
    //啟動戰鬥功能 -> 利用測驗機制
    func battleTest(){
        
        //找目前sequence的英文+中文字
        let halfCount = wordSets.count / 3
        let engWord = wordSets[currentWordSequence]
        let chiWord = wordSets[halfCount +  currentWordSequence]
        
        //製作中英文字
        makeWords(word: engWord, lang: "engWord")
        makeWords(word: chiWord, lang: "chiWord")
        
        //中文字fade in
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        for node in children{
            
            if (node.name?.contains("chiWord"))!{
                
                node.run(fadeIn, completion: {[weak self] in
                    
                        
                        //中文字產生完之後, 就產生掃描線及發音
                        self!.scanAndPronounce()
                    
                        //可以按畫面
                        self!.isUserInteractionEnabled = true
                    
                    //測驗的機制
                    self!.learningTest()
                    
                    
                })
                
            }
        }
        
    }
    
    //學習階段的測驗
    func learningTest(){
        
        //讓英文字alpha變淡
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.3)
        
        //顯示空格子
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.3)
        
        for node in children{
         
            //隱藏英文單字
            if (node.name?.contains("engWord"))!{
                
                node.run(fadeOut)
            }
            
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
                
                if currentWordArray.contains(s) {
                } else {
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
            
        case 2:
            
            
            for _ in 0 ..< 2 {
                randomNumbers = Int(arc4random_uniform(UInt32(countArray.count)))
                extraWords.append(otherWordsOrderSets[countArray[randomNumbers]])
                countArray.remove(at: randomNumbers)
                
                
            }
            
        case 3:
            
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
        
        //設定四格的位置
        let positions = [[-160,-390],[-160,-190],[160,-390],[160,-190]]
        
        for i in 0 ..< shownWords.count{
            
            makeLabelNode(x: CGFloat(positions[i][0]), y: CGFloat(positions[i][1]), alignMent: .center, fontColor: diamondGreen, fontSize: 50, text: shownWords[i], zPosition: 5, name: shownWords[i] + String(i) + "Sel", fontName: "Helvetica", isHidden: false, alpha: 1)
            
            //可按按鍵
            isUserInteractionEnabled = true
            
            //把建立的選項名稱放入array裡
            selNodeNames.append(shownWords[i] + String(i) + "Sel")
            
        }
        
        
        isDragAndPlayEnable = true
        
    }
    
    
    
    
    //關上任務版+再打開的動畫
    func closeQuestBoardAndReopen(){
        
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
        //把questTitle字消失
        findLabelNode(name: "questTitle").text = ""
        
        //remove所有的字Node
        removeSomeNodes(name: "Word")
        removeSomeNodes(name: "hint")
        
        //關上任務板子的action
        let questBoardClose = SKAction.resize(toHeight: 0, duration: 0.3)
        findImageNode(name: "questBoard").run(questBoardClose){[weak self] in
            
            //拉開任務板子的action
            self!.openQuest()
            
        }
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            location = touch.location(in: self)
            
            let node : SKNode = self.atPoint(location)
            
            //按鈕功能, 暫時用不到
            if isButtonEnable {
                if node.name == "button"{
                    print("button pressed")
                    
                }
            }
            
            //按主畫面的功能
            if isScanning == false{
                
                //假如發音按超過三次要開始練習, 三次跳練習目前放在update裡面
                if playSoundTime < 3{
                    
                    if node.name == "questBoard" || (node.name?.contains("engWord"))! || (node.name?.contains("chiWord"))!{
                        
                        scanAndPronounce()
                    }
                }
            }
            
            //**** 開始拖拉遊戲 dragAndPlay ***
            if isDragAndPlayEnable {
                
                //在建立一條新的線
                line = SKShapeNode()
                line?.strokeColor = diamondGreen
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
                            
                            //藥水動畫
                            pourPoison(word: wordChosen, poisonNumber: i)
                            
                        }
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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
     
                            //移除藥水
                            //取得數字順序
                            let idx = nodesTouchedCount - 1
                            let node = nodesTouched[idx]
                            let nameToRemove = node.name
                            let seq = Int((nameToRemove?.replacingOccurrences(of: "newse", with: ""))!)
                            let word = shownWords[seq!]
                            removePoison(word: word, poisonNumber: seq!)
    
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
                
                //移動中遇到其它三個node
                if node.name == selNodeNames[0] || node.name == selNodeNames[1] || node.name == selNodeNames[2] {
                    
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
                        pourPoison(word: wordChosen, poisonNumber: index!)
                        
                        
                    }
                    
                    //檢查已經增加第幾個node, 然後做固定轉折點
                    switch touchTimes {
                        
                    case 2:
                        
                        fixedSecondTouch = getCgPoint(name: name)
                        
                    case 3:
                        
                        fixedThirdTouch = getCgPoint(name: name)
                        
                    case 4:
                        
                        fixedFourthTouch = getCgPoint(name: name)
                        
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
        
        //手指離開後對答案的機制
        
        //確認有按到任何選項單字才會開始偵測end動作
        if touchTimes > 0{
            
            if isDragAndPlayEnable {
                
                //****確認模式****
                if isBattleMode {
                    // Part 1. 戰鬥模式
                    
                    //避免再次按
                    isUserInteractionEnabled = false
                    
                    //移除上一次的發亮按鈕
                    removeSomeNodes(name: "new")
                    //移除上一次的線
                    removeSomeNodes(name: "line")
                    
                    //初始化
                    selNodeNames = ["se0","se1","se2","se3"]
                    
                    for touch in touches{
                        let lastTouch = touch.location(in: self)
                        
                        let node : SKNode = self.atPoint(lastTouch)
                        
                        //是否修改線
                        if node.name == selNodeNames[0] || node.name == selNodeNames[1] || node.name == selNodeNames[2] || node.name == selNodeNames[3]{
                            
                            //最後有碰到node, 不修改線
                            
                        } else {
                            //最後一個沒碰到node的話, 一放開縮短線
                            
                            isEndOnNode = false
                            
                            drawLine()
                            
                        }
                        
                    }
                    
                    //固定線
                    line = SKShapeNode()
                    line?.strokeColor = diamondGreen
                    line?.lineWidth = 8
                    line?.name = "line"
                    line?.zPosition = 4
                    line?.glowWidth = 2
                    addChild(line!)
                    
                    //初始化
                    isFirstTouch = false
                    touchTimes = 0
                    isTouched = false
                    nodesTouched.removeAll(keepingCapacity: false)
                    
                    
                    //指定名稱的變數
                    let monster = "monsterBlood"
                    let player = "playerBlood"
                    
                    //抓目前怪物及玩家血量
                    
                    monsterBlood = findImageNode(name: monster).size.width
                    playerBlood = findImageNode(name: player).size.width
                    //print(monsterBlood)

                    
                    //假如答案正確
                    if wordEntered == currentWordArray{
                        
                        //combo確認+1
                        battleComboTime += 1
                        
                        //把temp字改顏色
                        let tempNode = findLabelNode(name: "tempWord")
                        let changeColor = SKAction.colorize(with: diamondGreen, colorBlendFactor: 1, duration: 0.3)
                        tempNode.run(changeColor, completion: {[weak self] in
                            
                            
                            //自我爆炸動畫
                            let explode = SKAction.run({
                                self!.explodeEmitter?.isHidden = false
                                self!.explodeEmitter?.resetSimulation()
                                
                            })
                            //等待爆炸秒數
                            let waitAction = SKAction.wait(forDuration: 0.7)
                            let sequence = SKAction.sequence([explode,waitAction])
                            
                            //temp自我爆炸後攻擊怪物
                            self!.run(sequence, completion: {

                                //正確攻擊
                                self!.findImageNode(name: "monster").run(self!.rightAttack())
                                
                            })

                            
                            //等待攻擊動畫秒數後扣分
                            let when = DispatchTime.now() + 2.3

                            DispatchQueue.main.asyncAfter(deadline: when, execute: {
                                
                                //假如怪沒死
                                //攻擊怪
                                self!.attack(point: 3, whom: monster){
                                    if self!.monsterBlood == 0 {
                                        
                                        //這局結束
                                        print("monster dead")
                                        //下一場比賽
                                        self!.nextBattle()
                                        
                                    } else{
                                        
                                        //假如有combo
                                        if self!.battleComboTime == 2 {
                                            
                                            print("combo Attack")
                                            
                                            //combo閃字動畫
                                            let wait = SKAction.wait(forDuration: 0.2)
                                            self!.findLabelNode(name: "comboAttack").alpha = 1
                                            let redFontAction = SKAction.run({[weak self] in
                                                self!.findLabelNode(name: "comboAttack").fontColor = self!.pinkColor
                                            })
                                            let whiteFontAction = SKAction.run({[weak self] in
                                                self!.findLabelNode(name: "comboAttack").fontColor = .white
                                            })
                                            let sequence = SKAction.sequence([redFontAction,wait,whiteFontAction,wait])
                                            let repeatAction = SKAction.repeat(sequence, count: 2)
                                           
                                            
                                            //啟動閃字
                                            self!.findLabelNode(name: "comboAttack").run(repeatAction, completion: {
                                                
                                                //閃完alpha=0
                                                self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.2)
                                                
                                                //閃完後做combo攻擊
                                                self!.findImageNode(name: "monster").run(self!.comboAttack())
                                                
                                                //等待combo攻擊的時間
                                                let when = DispatchTime.now() + 1.5

                                                DispatchQueue.main.asyncAfter(deadline: when, execute: {
                                                    //combo攻擊怪
                                                    self!.attack(point: 3, whom: monster, finished: {[weak self] in
                                                        
                                                        //combo -1
                                                        self!.battleComboTime -= 1
                                                        
                                                        //假如怪還沒死就攻擊人
                                                        //怪物死了
                                                        if self!.monsterBlood == 0 {
                                                            //這局結束
                                                            //print("monster dead")
                                                            
                                                            //下一場
                                                             self!.nextBattle()
                                                            
                                                        } else {
                                                            
                                                            //以目前的血量設定來說, 不會進到這裡因為combo打完怪物就一定死了
                                                            
                                                            //攻擊人
                                                            self!.attack(point: 2, whom: player, finished: {
                                                                
                                                                if self!.playerBlood == 0 {
                                                                    
                                                                    //print("player dead")
                                                                    self!.nextBattle()
                                                                } else {
                                                                    
                                                                    //print("continue play")
                                                                             //繼續攻擊
                                                                    self!.continueBattle()
                                                           
                                                                    
                                                                }
                                                            })
                                                            
                                                        }
                                                        
                                                    })

                                                })

                                            })
                                            

                                        } else {
                                            
                                            //一般的攻擊人
                                            
                                            //怪物自爆
                                            self!.monsterExplode?.isHidden = false
                                            self!.monsterExplode?.resetSimulation()
                                            
                                            //等待怪物自爆的時間
                                            let when = DispatchTime.now() + 1.5

                                            DispatchQueue.main.asyncAfter(deadline: when, execute: {

                                                let attack = SKAction.run({
                                            
                                                    self!.monsterAttack?.isHidden = false
                                                    self!.monsterAttack?.resetSimulation()
                                                    
                                                })
                                            
                                                //等待怪物攻擊後再扣血
                                                let wait = SKAction.wait(forDuration: 1.2)
                                                
                                                let sequence = SKAction.sequence([attack,wait])
                                                
                                                self!.run(sequence, completion: {
                                                
                                                    //攻擊人
                                                    self!.attack(point: 2, whom: player, finished: {
                                                        
                                                        if self!.playerBlood == 0 {
                                                            
                                                            //下一場
                                                            //print("player dead")
                                                             self!.nextBattle()
                                                        } else {
                                                            
                                                            //print("continue play")
                                                            //繼續攻擊
                                                            self!.continueBattle()
                                                            
                                                        }
                                                    })
                                                })
                                                
                                                
                   

                                                
                                            })
                                            
                                        }
                                    }
                                }
                                
                            })


                        })
        
         
                    } else {
                        //答案錯誤
                        //print("wrong Answer")
                        
                        //combo - 1
                        if battleComboTime == 1 {
                        battleComboTime -= 1
                        }
                        
                        //抓正確音節數有幾個
                        var correctSyllableCounts = Int()
                        let syllableCounts = currentWordArray.count
                        let enterCounts = wordEntered.count
                        var checkCounts = Int()
                        
                        if enterCounts > syllableCounts {
                            
                            checkCounts = syllableCounts
                        } else {
                            
                            checkCounts = enterCounts
                        }
                        
                        
                        //確認總共對幾個音節
                        for i in 0 ..< checkCounts{
                            
                            if wordEntered[i] == currentWordArray[i] {
                             correctSyllableCounts += 1
                            }
                        }
                        
                        //可攻擊分數
                        let point = 3 / CGFloat(syllableCounts) / 1.5 * CGFloat(correctSyllableCounts)
                        
                        //如果全錯就沒有攻擊怪動畫
                        var tempAction = SKAction()
                        if point != 0 {
                            //一般攻擊
                            tempAction = normalAttack()
                        } else {
                            //失敗攻擊
                            tempAction = missAttack()
                        }
                        
                        //先閃紅字 +  再攻擊
                        findLabelNode(name: "tempWord").run(wrongAnswerAction(), completion: {[weak self] in
                            
                            //等待閃紅字的時間
                            let wait = SKAction.wait(forDuration: 0.5)
                            
                            let sequence = SKAction.sequence([wait,tempAction])
                            
                            //執行攻擊
                            self!.findImageNode(name: "monster").run(sequence, completion: {
                                
                                //攻擊怪
                                self!.attack(point: point, whom: monster){
                                    
                                    //假如怪死
                                    if self!.monsterBlood == 0 {
                                        
                                        //這局結束
                                        //print("monster dead")
                                         self!.nextBattle()
                                        
                                    } else{
                                        
                                        //攻擊人
                                        
                                        //怪物自爆
                                        self!.monsterExplode?.isHidden = false
                                        self!.monsterExplode?.resetSimulation()
                                        
                                        //等待自爆秒數
                                        let when = DispatchTime.now() + 1.5
                                        
                                        DispatchQueue.main.asyncAfter(deadline: when, execute: {
                                            
                                            
                                            let attack = SKAction.run({
                                                
                                                self!.monsterAttack?.isHidden = false
                                                self!.monsterAttack?.resetSimulation()
                                                
                                            })
                                            
                                            //等待秒數
                                            let wait = SKAction.wait(forDuration: 1)
                                            
                                            //等待怪物攻擊動畫後再扣分
                                            let sequence = SKAction.sequence([attack,wait])
                                            
                                            self!.run(sequence, completion: {
                                                //攻擊人
                                                self!.attack(point: 2, whom: player, finished: {
                                                    
                                                    if self!.playerBlood == 0 {
                                                        
                                                        print("player dead")
                                                         self!.nextBattle()
                                                    } else {
                                                        
                                                        print("continue play")
                                                        //繼續攻擊
                                                        self!.continueBattle()
                                                        
                                                    }
                                                })
                                            })
             
                                        })
                                        
                                       
                                        
                                    }
                                }

                            })
                            
                            
                        })

                        
                    }
                    
                    
                } else {
                
                // Part 2.練習模式
                
                //移除上一次的發亮按鈕
                removeSomeNodes(name: "new")
                //移除上一次的線
                removeSomeNodes(name: "line")
                
                //初始化
                selNodeNames = ["se0","se1","se2","se3"]
                
                for touch in touches{
                    let lastTouch = touch.location(in: self)
                    
                    let node : SKNode = self.atPoint(lastTouch)
                    
                    //是否修改線
                    if node.name == selNodeNames[0] || node.name == selNodeNames[1] || node.name == selNodeNames[2] || node.name == selNodeNames[3]{
                        
                        //最後有碰到node, 不修改線
                        
                    } else {
                        //最後一個沒碰到node的話, 一放開縮短線
                        
                        isEndOnNode = false
                        
                        drawLine()
                        
                    }
                    
                }
                
                //固定線
                line = SKShapeNode()
                line?.strokeColor = diamondGreen
                line?.lineWidth = 8
                line?.name = "line"
                line?.zPosition = 4
                line?.glowWidth = 2
                addChild(line!)
                
                //初始化
                isFirstTouch = false
                touchTimes = 0
                isTouched = false
                nodesTouched.removeAll(keepingCapacity: false)
                
                //假如答案正確
                if wordEntered == currentWordArray{
                    
                    //部首音節變色...
                    
                    //1. 把顯示的輸入字刪除
                    findLabelNode(name: "tempWord").text = ""
                    
                    //2. 顯示原本有音節變色的字
                    
                    for node in children{
                        if (node.name?.contains("engWord"))!{
                            changeLabelAlfa(name: node.name!, toAlpha: 1, time: 0.3)
                            
                        }
                        
                    }
                    
                    //不能按畫面
                    self.isUserInteractionEnabled = false
                    
                    //避免再次顯示掃描線
                    isScanning = true
                    
                    //播放單字
                    self.scanAndPronounce()
                    
                    //輸入正確音節數歸零
                    //alreadyCorrectsyllables = 0
                    
                    //初始化
                    shownWords.removeAll(keepingCapacity: false)
                    wordEntered.removeAll(keepingCapacity: false)
                    
                    //正確數+1
                    correctTime += 1
                    
                    let when = DispatchTime.now() + 2
                    
                    //關上任務版
                    DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                        
                        //確認練習三次了沒
                        if self!.correctTime < 1 {
                            //再次練習
                            
                            //能按畫面
                            self!.isUserInteractionEnabled = true
                            
                            //選項顏色變淡+移除選項字
                            for node in self!.children{
                                
                                if (node.name?.contains("filledButton"))!{
                                    self!.changeImageAlfa(name: node.name!, toAlpha: 0, time: 0)
                                }
                                
                                if (node.name?.contains("emptyButton"))!{
                                    self!.changeImageAlfa(name: node.name!, toAlpha: 0, time: 0)
                                }
                                
                                if (node.name?.contains("Sel"))!{
                                    node.removeFromParent()
                                }
                            }
                            
                            //再次啟動練習
                            self!.learningTest()
                            self!.isButtonEnable = false
                            
                        } else {
                            //繼續產生學習單字
                            self!.dotSparkingFunc()
                            
                            let when = DispatchTime.now() + 2
                            
                            DispatchQueue.main.asyncAfter(deadline: when, execute: {
                                
                                //把順序+1
                                if self!.currentWordSequence < self!.wordSets.count / 3 - 1{
                                    self!.currentWordSequence += 1
                                    
                                    //解除practiceMode
                                    self!.isPracticeMode = false
                                    
                                    //正確數歸零
                                    self!.correctTime = 0
                                    
                                    //播放次數歸零
                                    self!.playSoundTime = 0
                                    
                                    //點點消失
                                    self!.findImageNode(name: "lDot1").alpha = 0
                                    self!.findImageNode(name: "lDot2").alpha = 0
                                    self!.findImageNode(name: "lDot3").alpha = 0
                                    
                                    self!.findImageNode(name: "bDot1").alpha = 0
                                    self!.findImageNode(name: "bDot2").alpha = 0
                                    self!.findImageNode(name: "bDot3").alpha = 0
                                    
                                    
                                    //任務版重來
                                    self!.closeQuestBoardAndReopen()
                                    
                                    //不能dragAndPlay
                                    self!.isDragAndPlayEnable = false
                                    
                                } else {
                                    self!.currentWordSequence = 0
                                    
                                    print("enterBattle")
                                    
                                    //進入battleMode
                                    self!.battleMode()
                                    
                                }
                            
                            })
                            
                        }
                    })
                    
                } else {
                    
                    //答案錯誤的機制
                    print("wrong answer")
                    //不能按畫面
                    self.isUserInteractionEnabled = false
                    //避免再次顯示掃描線
                    isScanning = true
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
                      
                        self!.isButtonEnable = false
                        
                        //能再次按發音
                        self!.isScanning = false
                        
                        
                    })
      
                }
        
            }
        }
        }
    }
    
    //失敗攻擊
    func missAttack() -> SKAction{

        //建立miss字
        makeLabelNode(x: 0, y: 445, alignMent: .center, fontColor: .white, fontSize: 60, text: "MISS", zPosition: 7, name: "miss", fontName: "Helvetica Bold", isHidden: false, alpha: 0)

        
        //fadein+fadeout
        let fadeIn = SKAction.fadeIn(withDuration: 0.2)
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let sequence = SKAction.sequence([fadeIn,fadeOut])
        
        //執行
        let action = SKAction.run {[weak self] in
            self!.findLabelNode(name: "miss").run(sequence) {[weak self] in
                self!.findLabelNode(name: "miss").removeFromParent()
                
            }
        }
        return action
    
    }

    //combo攻擊
    func comboAttack() -> SKAction{
        
        //所有會出現的圖, 這部分可以多加一點圖
        makeImageNode(name: "attEff", image: "attack3", x: 0, y: 455, width: 120, height: 120, z: 7, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "attEff2", image: "attack5", x: -40, y: 475, width: 40, height: 40, z: 6, alpha: 0, isAnchoring: false)
        makeImageNode(name: "attEff3", image: "attack5", x: -20, y: 455, width: 60, height: 66, z: 6, alpha: 0, isAnchoring: false)
        makeImageNode(name: "attEff4", image: "attack5", x: 40, y: 435, width: 15, height: 15, z: 6, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "starAttEff", image: "attack2", x: 0, y: 455, width: 100, height: 100, z: 7, alpha: 0, isAnchoring: false)
        

        //慢慢出現 1秒
        let appear = SKAction.fadeIn(withDuration: 1)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([appear,remove])
        
        //所有圖跑慢慢出現
        let action = SKAction.run {[weak self] in
            
            self!.findImageNode(name: "attEff").run(sequence)
            self!.findImageNode(name: "attEff2").run(sequence)
            self!.findImageNode(name: "attEff3").run(sequence)
            self!.findImageNode(name: "attEff4").run(sequence)
            
        }
        
        
        //星星出現+變大+fadeout 0.17秒
        let starAppear = SKAction.fadeIn(withDuration: 0.05)
        let enlarge = SKAction.resize(toWidth: 130, height: 130, duration: 0.02)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let backToSize = SKAction.resize(toWidth: 65, height: 65, duration: 0)
        let starSequence = SKAction.sequence([starAppear,enlarge,fadeOut,backToSize])

        //星星改變位置
        let pos = CGPoint(x: 40, y: 500)
        let pos2 = CGPoint(x: -20, y: 400)
        let changePosition = SKAction.move(to: pos, duration: 0)
        let chagePosition2 = SKAction.move(to: pos2, duration: 0)
        
        //合併
        let changePosSequence = SKAction.sequence([starSequence,changePosition,starSequence,chagePosition2,starSequence])
        
        //星星攻擊特效
        let effect = SKAction.run {[weak self] in
            self!.findImageNode(name: "starAttEff").run(changePosSequence, completion: {
                self!.findImageNode(name: "starAttEff").removeFromParent()
            })
            
        }

        //等待慢慢出現後星星攻擊
        let wait = SKAction.wait(forDuration: 1)
        let effectSequence = SKAction.sequence([action,wait,effect])
        
        //monster震動動畫, 需搭配monster.run
        let point1 = CGPoint(x: 20, y: 465)
        let point2 = CGPoint(x: 0, y: 455)
        let move1 = SKAction.move(to: point1, duration: 0.1)
        let move2 = SKAction.move(to: point2, duration: 0.1)
        let wait2 = SKAction.wait(forDuration: 1)
        let tremble = SKAction.sequence([move1,move2])
        let tremble3Times = SKAction.repeat(tremble, count: 3)
        let waitAndTremble = SKAction.sequence([wait2,tremble3Times])
        
        let groupAction = SKAction.group([waitAndTremble,effectSequence])

        //輸出動畫
        return groupAction
    }
    
    
    //答對時的攻擊, 旋轉後攻擊
    func rightAttack() -> SKAction {
        
        //所有效果
        makeImageNode(name: "pinkAttEff", image: "attack4", x: 20, y: 505, width: 159, height: 137, z: 6, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "darkAttEff", image: "attack1", x: -10, y: 445, width: 111 * 0.5, height: 92 * 0.5, z: 6, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "attEff", image: "attack3", x: 80, y: 465, width: 70, height: 70, z: 7, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "attEff2", image: "attack5", x: -70, y: 405, width: 40, height: 40, z: 6, alpha: 0, isAnchoring: false)
        makeImageNode(name: "attEff3", image: "attack5", x: -50, y: 425, width: 60, height: 66, z: 6, alpha: 0, isAnchoring: false)
        makeImageNode(name: "attEff4", image: "attack5", x: 40, y: 435, width: 15, height: 15, z: 6, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "attEff5", image: "attack3", x: -100, y: 510, width: 120, height: 120, z: 6, alpha: 0, isAnchoring: false)
        
        //出現後旋轉 1秒
        let appear = SKAction.fadeIn(withDuration: 0.2)
        let rotate = SKAction.rotate(byAngle: 0.5, duration: 0.8)
        let group = SKAction.group([appear,rotate])
        
        //fadeOut 0.2秒
        let fadeOut = SKAction.fadeOut(withDuration: 0.2)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([group,fadeOut,remove])
        
        //全體都出現旋轉後移除
        let action = SKAction.run {[weak self] in
            
            self!.findImageNode(name: "pinkAttEff").run(sequence)
            self!.findImageNode(name: "darkAttEff").run(sequence)
            self!.findImageNode(name: "attEff").run(sequence)
            self!.findImageNode(name: "attEff2").run(sequence)
            self!.findImageNode(name: "attEff3").run(sequence)
            self!.findImageNode(name: "attEff4").run(sequence)
            self!.findImageNode(name: "attEff5").run(sequence)
            
        }
        
        //主要攻擊圖
        makeImageNode(name: "solidAttEff", image: "attack5", x: -40, y: 475, width: 80, height: 88, z: 6, alpha: 0, isAnchoring: false)
       
        //出現+變大+消失 0.17秒
        let appear2 = SKAction.fadeIn(withDuration: 0.05)
        let enlarge = SKAction.resize(toWidth: 130, height: 130, duration: 0.02)
        let fadeOut2 = SKAction.fadeOut(withDuration: 0.1)
        let backToSize = SKAction.resize(toWidth: 65, height: 65, duration: 0)
        let sequence2 = SKAction.sequence([appear2,enlarge,fadeOut2,backToSize])
        
        //等待出現後旋轉 + 改變兩個位置來攻擊 1秒
        let pos = CGPoint(x: 40, y: 500)
        let pos2 = CGPoint(x: -20, y: 400)
        let changePosition = SKAction.move(to: pos, duration: 0)
        let chagePosition2 = SKAction.move(to: pos2, duration: 0)
        let wait = SKAction.wait(forDuration: 1)
        let changePosSequence = SKAction.sequence([wait,sequence2,changePosition,sequence2,chagePosition2,sequence2])
        
        //攻擊動畫
        let runThis = SKAction.run {[weak self] in
            self!.findImageNode(name: "solidAttEff").run(changePosSequence, completion: {
                self!.removeSomeNodes(name: "solidAttEff")
            })
            
        }
        
        //把出現+旋轉+攻擊 合一
        let finalSequence = SKAction.sequence([action,runThis])
        
        //怪物震動動畫, 必須用monster來run
        let point1 = CGPoint(x: 20, y: 465)
        let point2 = CGPoint(x: 0, y: 455)
        let move1 = SKAction.move(to: point1, duration: 0.1)
        let move2 = SKAction.move(to: point2, duration: 0.1)
        let wait2 = SKAction.wait(forDuration: 1.2)
        let tremble = SKAction.sequence([move1,move2])
        let tremble3Times = SKAction.repeat(tremble, count: 3)
        let waitAndTremble = SKAction.sequence([wait2,tremble3Times])
        let groupAction = SKAction.group([waitAndTremble,finalSequence])
        
        //輸出
        return groupAction
        
    }
    
    //一般攻擊
    func normalAttack() -> SKAction{
        
        //會出現的圖
        makeImageNode(name: "hollowAttEff", image: "attack6", x: 0, y: 455, width: 65, height: 65, z: 5, alpha: 0, isAnchoring: false)
        makeImageNode(name: "solidAttEff", image: "attack5", x: -40, y: 475, width: 80, height: 88, z: 6, alpha: 0, isAnchoring: false)
        makeImageNode(name: "lightAttEff", image: "attack3", x: 0, y: 455, width: 120, height: 120, z: 7, alpha: 0, isAnchoring: false)
        
        //快速閃:出現+放大+fadeOut+變回原型 * 3
        let appear = SKAction.fadeIn(withDuration: 0.05)
        let enlarge = SKAction.resize(toWidth: 130, height: 130, duration: 0.02)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let backToSize = SKAction.resize(toWidth: 65, height: 65, duration: 0)
        let sequence = SKAction.sequence([appear,enlarge,fadeOut,backToSize])
        let repeat3Times = SKAction.repeat(sequence, count: 3)
        
        //改變位置
        let pos = CGPoint(x: 40, y: 500)
        let pos2 = CGPoint(x: -20, y: 400)
        let changePosition = SKAction.move(to: pos, duration: 0)
        let chagePosition2 = SKAction.move(to: pos2, duration: 0)
        let changePosSequence = SKAction.sequence([sequence,changePosition,sequence,chagePosition2,sequence])
        
        //合併
        let effect = SKAction.run {[weak self] in
        
            //先快速閃爍結束後再改變位置
            self!.findImageNode(name: "hollowAttEff").run(repeat3Times, completion: {
          
                self!.findImageNode(name: "hollowAttEff").removeFromParent()
                
                self!.findImageNode(name: "solidAttEff").run(changePosSequence, completion: {
            
                    self!.findImageNode(name: "solidAttEff").removeFromParent()
                    
                })
            })
            
        }

        //怪物震動動畫, 必須用monster來run

        let point1 = CGPoint(x: 20, y: 465)
        let point2 = CGPoint(x: 0, y: 455)
        let move1 = SKAction.move(to: point1, duration: 0.1)
        let move2 = SKAction.move(to: point2, duration: 0.1)
        let wait = SKAction.wait(forDuration: 0.51)
        let tremble = SKAction.sequence([move1,move2])
        let tremble3Times = SKAction.repeat(tremble, count: 3)
        let waitAndTremble = SKAction.sequence([wait,tremble3Times])
        let groupAction = SKAction.group([waitAndTremble,effect])
        
        //輸出動畫
        return groupAction
   
    }
    
    func nextBattle(){
        
        //更改單字次序
        
        if currentWordSequence < wordSets.count / 3 - 1{
            currentWordSequence += 1
        }  else {
            print("Session End")
            currentWordSequence = 0
        }

        //更改怪物出現次序
        if monsterSequence < monsters.count - 1 {
            monsterSequence += 1
        } else {
            monsterSequence = 0

        }
        
        //初始化
        shownWords.removeAll(keepingCapacity: false)
        wordEntered.removeAll(keepingCapacity: false)
        battleComboTime = 0
        
        //移除畫面
        removeSomeNodes(name: "monster")
        removeSomeNodes(name: "player")
        removeSomeNodes(name: "Frame")
        removeSomeNodes(name: "tempWord")
        
        //開始戰鬥, 建立下一個單字
        battleMode()
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
    
  
    func continueBattle(){
        
        //fadeOut
        changeLabelAlfa(name: "tempWord", toAlpha: 0, time: 0.5)
        
        
        //選項顏色變淡+移除選項字
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
        
        //1. 把顯示的輸入字刪除
        findLabelNode(name: "tempWord").text = ""
        
        //顏色回復白色
        findLabelNode(name: "tempWord").color = .white
        
        //初始化
        shownWords.removeAll(keepingCapacity: false)
        wordEntered.removeAll(keepingCapacity: false)
        
        //下一次開始的時間等待秒數
        let when = DispatchTime.now() + 0.8
        
        DispatchQueue.main.asyncAfter(deadline: when) {[weak self] in
            
            //2. tempWord Alpha調整
            self!.changeLabelAlfa(name: "tempWord", toAlpha: 1, time: 0)
            
            //能按畫面
            self!.isUserInteractionEnabled = true
            
            //再次啟動練習, 不用battleTest是因為不用再建立新的單字
            self!.learningTest()
            self!.isButtonEnable = false
        }
        
    }
    

    //扣分的func
    func attack(point:CGFloat,whom:String,finished: @escaping () -> Void){
        
        //每個單位的扣分計算法
        var hurtMonster = fullMonsterBlood / 9 * point
        var hurtPlayer = fullPlayerBlood / 10 * point
        
        //假如超過分數就扣光
        if hurtMonster > monsterBlood {
            hurtMonster = monsterBlood
        }

        if hurtPlayer > playerBlood{
            hurtPlayer = playerBlood
        }
        
         //扣血畫面
        
        switch whom {
        case "monsterBlood":
           
            let hurtAction = SKAction.resize(toWidth: monsterBlood - hurtMonster, duration: 0.2)
            findImageNode(name: whom).run(hurtAction)
            monsterBlood = monsterBlood - hurtMonster

            /*
            if monsterBlood == 0 {
                
                isRoundEnd = true
                
            }
            print(monsterBlood)
            */
        case "playerBlood":
            let hurtAction = SKAction.resize(toWidth: playerBlood - hurtPlayer, duration: 0.2)
            findImageNode(name: whom).run(hurtAction)
            playerBlood = playerBlood - hurtPlayer
            
            /*
            if playerBlood == 0 {
                
                isRoundEnd = true
            }
 */
            
        default:
            break
        }
    
        //扣分後的短暫等待
        let when = DispatchTime.now() + 0.5

        DispatchQueue.main.asyncAfter(deadline: when) {

             finished()
        }

        
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
            makeLabelNode(x: 0, y: 85, alignMent: .center, fontColor: .white, fontSize: 100, text: word, zPosition: 3, name: "tempWord", fontName: "Helvetica", isHidden: false, alpha: 1)

            
        }
    }
    
  
    func pourPoison(word:String, poisonNumber:Int){
        
        //找選項正確音節
        let selectedLabel = findLabelNode(name: word + String(poisonNumber) + "Sel")
        
        //改變label fontColor
        let changeTextColor = SKAction.run {
            selectedLabel.fontColor = .white
        }
        run(changeTextColor)
        
        
        //按鈕發亮
        let buttonName =  String(poisonNumber) + "filledButton"
        changeImageAlfa(name: buttonName, toAlpha: 1, time: 0.4)
        
    }
    
    func removePoison(word:String, poisonNumber:Int){
        
        print("removePoison")
        
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
    
    
    //變形動畫的範例
    func warpNode(_ node: SKSpriteNode)
    {
        
        let sourcePositions: [vector_float2] =
            [
                vector_float2(0, 0),   vector_float2(0.5, 0),   vector_float2(1, 0),  //bottom row of object
                vector_float2(0, 0.5), vector_float2(0.5, 0.5), vector_float2(1, 0.5),  //middle row of object
                vector_float2(0, 1),   vector_float2(0.5, 1),   vector_float2(1, 1)  //top row of object
        ]
        
        let destinationPositions: [vector_float2] =
            [
                vector_float2(0, 0),   vector_float2(0.5, 0),   vector_float2(1, 0),  //bottom row of object
                vector_float2(0, 0.5), vector_float2(0.5, 0.5), vector_float2(1, 0.5),  //middle row of object
                vector_float2(0, 0.8), vector_float2(0.5, 0.8), vector_float2(1, 0.8)  //top row of object
        ]
        
        let warpGeometryGrid = SKWarpGeometryGrid(columns: 2, rows: 2, sourcePositions: sourcePositions, destinationPositions: destinationPositions)
        
        let warpGeometryGridNoWarp = SKWarpGeometryGrid(columns: 2, rows: 2)
        
        node.warpGeometry = warpGeometryGridNoWarp
        
        let warpAction = SKAction.animate(withWarps: [warpGeometryGridNoWarp, warpGeometryGrid, warpGeometryGridNoWarp], times: [0.25, 0.5, 0.75], restore: true)
        
        node.run(warpAction!)
    }
    
    
    
    //回傳SKLabelNode打字動畫+閃爍指令的func
    func typingAction(text:String, nodeName:String, finalText:String) -> SKAction{
        
        //輸入的text
        let questText = text
        //把text拆成array並加入底線_
        var questTextArray = questText.characters.map { String($0) }

        questTextArray.append("_")
        
        var i = 0
        
        //每字間隔0.1秒
        let wait = SKAction.wait(forDuration: 0.1)
        
        //開始顯示打字動畫
        let typingAction = SKAction.run {[weak self] in
            
            self?.findLabelNode(name: nodeName).text = (self?.findLabelNode(name: nodeName).text!)! + questTextArray[i]
            
            i += 1
            
        }
        
        
        let sequence = SKAction.sequence([wait,typingAction])
        //讓打字動畫做到字數數量
        let repeatAction = SKAction.repeat(sequence, count: questTextArray.count)
        
        //底線閃爍
        let sparklingAction1 = SKAction.run {[weak self] in
            self?.findLabelNode(name: nodeName).text = questText + "_"
            
        }
        let sparklingAction2 = SKAction.run {[weak self] in
            self?.findLabelNode(name: nodeName).text = questText
        }
        
        let sparklingSequence = SKAction.sequence([sparklingAction1,wait,sparklingAction2,wait])
        //讓底線閃爍4次
        let repeatSparklingAction = SKAction.repeat(sparklingSequence, count: 4)
        
        //顯示最後text
        let finalWord = SKAction.run {
            
            self.findLabelNode(name: nodeName).text = finalText
            
        }
        
        //把打字+底線閃爍加在一起
        let allSparklingAction = SKAction.sequence([repeatAction,repeatSparklingAction, finalWord])
        
        return allSparklingAction
        
    }
    
    
    //建立音節單字的func
    func makeWords(word:String, lang:String){
        
        //設定x及y的位置
        var posX = CGFloat()
        var posY = CGFloat()
        
        //字型大小
        var fontSize = CGFloat()
        
        //對齊位置
        var align:SKLabelHorizontalAlignmentMode?
        
        //製作中文字
        if lang == "chiWord" {

            //label的屬性
            align = .center
            posY = -10
            fontSize = 70
            
            //建立中文字
            makeLabelNode(x: 0, y: posY, alignMent: align!, fontColor: .white, fontSize: fontSize, text: word, zPosition: 2, name: "chiWord", fontName: "Helvetica Light", isHidden: false, alpha: 0)
            
            
        //製作英文字
        } else if lang == "engWord"{
            
            //分音節
            var sepWords = word.components(separatedBy: " ")
            
            //計算字母有多少個, 用來決定xPos
            var characterCounts = 0
            for i in sepWords{
                characterCounts = characterCounts + i.characters.count
                
            }
            
            switch characterCounts {
            case 1...3:
                posX = -115
            case 4...6:
                posX = -150
            case 7...10:
                posX = -175
            case 11...15:
                posX = -240
            case 16...20:
                posX = -280
            default:
                posX = -180
            }
            
            //label的屬性
            align = .left
            posY = 85
            fontSize = 100
            
            //加一個順序
            nextWordSequence += 1
            
            //還原該單字
            wordsToPronounce = word.replacingOccurrences(of: " ", with: "")
            
            //產生提示
            
            let hintY = findImageNode(name: "questBoard").frame.minY
            
            //戰鬥模式就不做這個hint了
            if isBattleMode == false{
            makeLabelNode(x: 0, y: hintY + 10, alignMent: .center, fontColor: diamondGreen, fontSize: 30, text: "[ 請按畫面聽讀單字 ]", zPosition: 2, name: "hint" , fontName: "Helvetica Light", isHidden: false, alpha: 1)
            }
            
            //抓音節數
            let sepCount = sepWords.count
            
            for i in 0 ..< sepCount{
                
                let sepWord = sepWords[i]
                
                //檢查有沒有元素的字節, 有的話顯示為黃色
                if syllables.contains(sepWord){
                    
                    let fontColor = UIColor.yellow
                    
                    if i > 0 {
                        
                        //非第一組字
                        if let leftNode = childNode(withName: sepWords[i - 1] + String(i - 1) + lang) as? SKLabelNode{
                            
                            let nextX = CGFloat(leftNode.frame.origin.x + leftNode.frame.width + 4)
                            
                            makeLabelNode(x: nextX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: sepWord + String(i) + lang, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                            
                        }
                        
                    } else{
                        //第一組字
                        
                        makeLabelNode(x: posX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: sepWord  + String(i) + lang, fontName: "Helvetica Light", isHidden: false, alpha: 0)
    
                    }
                    
                } else {
                    
                    //非元素字
                    let fontColor = UIColor.white
                    
                    if i > 0 {
                        print("3")
                        //非第一組字
                        if let leftNode = childNode(withName: sepWords[i - 1] + String(i - 1) + lang) as? SKLabelNode{
                            
                            let nextX = CGFloat(leftNode.frame.origin.x + leftNode.frame.width + 4)
                            
                            makeLabelNode(x: nextX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: sepWord + String(i) + lang, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                            
                        }
                        
                    } else{
                        
                        print("4")
                        
                        //第一組字
                        makeLabelNode(x: posX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: sepWord + String(i) + lang, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                        
                    }
                }
                
            }
        }
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
            
        default:
            break
        }
        
        line!.path = path
        
    }
    
    func getCgPoint(name:String) -> CGPoint{
        
        let node = childNode(withName: name) as! SKSpriteNode
        let xPos = node.frame.midX
        let yPos = node.frame.midY
        let position = CGPoint(x: xPos, y: yPos)
        return position
    }
    
    
    //找labelNode
    func findLabelNode(name:String) -> SKLabelNode{
        var node:SKLabelNode?
        node = childNode(withName: name) as? SKLabelNode
        return node!
        
    }
    
    //找IMAGE的skspritenode
    func findImageNode(name:String) -> SKSpriteNode{
        var node:SKSpriteNode?
        node = childNode(withName: name) as? SKSpriteNode
        return node!
        
    }
    
    //製作image的skspriteNode
    func makeImageNode(name:String, image:String, x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat, z:CGFloat, alpha:CGFloat, isAnchoring:Bool){
        
        
        let bundlePath = Bundle.main.path(forResource: image, ofType: "png")
        let imageFile = UIImage(contentsOfFile: bundlePath!)
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
    
    
    override func update(_ currentTime: TimeInterval) {
        
        //發音三次後直跳練習
        
        if playSoundTime == 3 {
            //直接開啟練習
            //只開啟一次
            playSoundTime = 0
            
            //封鎖按鍵
            isUserInteractionEnabled = false
            
            dotSparkingFunc()
            
            let when = DispatchTime.now() + 2
            
            DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                
                //開始學習練習模式
                self!.isPracticeMode = true
                
                //點點消失
                self!.findImageNode(name: "lDot1").alpha = 0
                self!.findImageNode(name: "lDot2").alpha = 0
                self!.findImageNode(name: "lDot3").alpha = 0
                
                
                //更改提示字
                self!.findLabelNode(name: "hint").text = "[ 練習拼字 ]"
                
                //發音次數歸零
                self!.playSoundTime = 0
                
                
                //啟動練習
                self!.learningTest()
                self!.isButtonEnable = false
                
            })
            
            
            
        }
        
        
        if isBattleMode{
            //戰鬥模式中, 暫時用不到
            /*
            if isRoundEnd{
                isRoundEnd = false
                //回合結束
                print("roundEnd")
                if currentWordSequence < wordSets.count / 3 - 1{
                    currentWordSequence += 1
                }  else {
                        print("Session End")
                    currentWordSequence = 0
                    }
                
                //下一回合戰鬥
                
                
                
                
            }
            
            */
        }
    }
    
    
    func dotSparkingFunc(){
        
        let sparkling1 = SKAction.fadeAlpha(to: 0, duration: 0.2)
        let sparkling2 = SKAction.fadeAlpha(to: 1, duration: 0.2)
        let sequence = SKAction.sequence([sparkling1,sparkling2])
        let repeatAction = SKAction.repeat(sequence, count: 3)
        
        for node in children{
            
            if (node.name?.contains("lDot"))!{
                
                node.run(repeatAction)
                
                
            }
            
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

//顯示下一個字, 暫時先用不到
/*
 func showNextWord(){
 
 
 //移除目前的字
 removeSomeNodes(name: "Word")
 let halfCount = wordSets.count / 2
 
 //按順序建立單字
 if nextWordSequence < halfCount{
 
 let nextEngWord = wordSets[nextWordSequence]
 let nextChiWord = wordSets[halfCount + nextWordSequence]
 
 //做英文字
 makeWords(word: nextEngWord, language: "engWord")
 //做中文字
 makeWords(word: nextChiWord, language: "chiWord")
 
 } else {
 
 
 findImageNode(name: "playButton").isHidden = false
 //跳回顯示第一組單字
 nextWordSequence = 0
 let nextEngWord = wordSets[nextWordSequence]
 let nextChiWord = wordSets[halfCount + nextWordSequence]
 
 
 //做英文字
 makeWords(word: nextEngWord, language: "engWord")
 //做中文字
 makeWords(word: nextChiWord, language: "chiWord")
 
 }
 }
 
 */

/*
 //檢查音節數以及正確數, 暫時用不到
 func checkLearningTestAnswer(word:String, poisonNumber:Int){
 
 //抓總共輸入幾次字
 let count = wordEntered.count
 
 //檢查須確認的音節位置, 以count為參考
 switch count {
 case 0:
 if word == currentWordArray[0]{
 //正確
 //pourPoisonAndRemoveLabel(sequence: 0, word: word, poisonNumber: poisonNumber)
 
 } else {
 //錯誤
 
 }
 case 1:
 if word == currentWordArray[1]{
 //正確
 //pourPoisonAndRemoveLabel(sequence: 1, word: word, poisonNumber: poisonNumber)
 
 } else {
 //錯誤
 
 }
 
 
 case 2:
 if word == currentWordArray[2]{
 //正確
 
 //pourPoisonAndRemoveLabel(sequence: 2, word: word, poisonNumber: poisonNumber)
 
 } else {
 //錯誤
 
 }
 case 3:
 if word == currentWordArray[3]{
 //正確
 //pourPoisonAndRemoveLabel(sequence: 3, word: word, poisonNumber: poisonNumber)
 
 } else {
 //錯誤
 
 }
 case 4:
 if word == currentWordArray[4]{
 //正確
 
 //pourPoisonAndRemoveLabel(sequence: 4, word: word, poisonNumber: poisonNumber)
 } else {
 //錯誤
 
 }
 case 5:
 if word == currentWordArray[5]{
 //正確
 
 //pourPoisonAndRemoveLabel(sequence: 5, word: word, poisonNumber: poisonNumber)
 
 } else {
 //錯誤
 
 }
 default:
 break
 
 
 }
 
 }
 
 */

