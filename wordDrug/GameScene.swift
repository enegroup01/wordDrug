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
    
    //暫時使用的單字
    var wordSets = [String]()
    
    //暫時設定的音節
    var syllables = ["ac"]
    
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
    var isEnterAnswerEnable = false
    
    //是否能按功能button
    var isButtonEnable = false
    
    
    //autoPlay使用變數
    
    var isPracticeMode = false
    var playSoundTime = 0
    var correctTime = 0
    
    
    
    override func didMove(to view: SKView) {
        
        //建立整個背景
        makeImageNode(name: "bg", image: "bg4", x: 0, y: 0, width: 750, height: 1334, z: 0, alpha: 1, isAnchoring: false)
        
        //建立任務版子
        makeImageNode(name: "questBoard", image: "questBoard", x: 0, y: 0, width: 700, height: 0, z: 1, alpha: 1, isAnchoring: false)
        
        //建立任務標題
        makeLabelNode(x: -100, y:220, alignMent: .left, fontColor: pinkColor, fontSize: 50, text: "", zPosition: 2, name: "questTitle", fontName: "Helvetica Bold", isHidden: false, alpha:1)
        
        //任務板子動畫 + 標題動畫
        openQuest()
        
        //建立怪物畫面背景
        makeImageNode(name: "monsterBg", image: "monsterBg", x: 0, y: 500, width: 750, height: 431, z: 1, alpha: 1, isAnchoring: false)
        
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
        
        //製作選項Node
        
        for i in 0 ..< 6 {
            makeNode(name: String(i) + "se", color: .clear, x:CGFloat(-300 + (120 * i)) , y: -380, width: 105, height: 150, z: 4, isAnchoring: false, alpha: 0.5)
        }
        
        //製作發亮藥水, height:187
        for i in 0 ..< 6 {
            
            makeImageNode(name: String(i) + "Poison" , image: "fillBar", x:CGFloat(-355 + (119 * i)) , y: -462, width: 125, height: 187, z: 5, alpha: 0, isAnchoring: true)
            
        }
        
        //建立三黑點+亮點, 並hidden
        makeImageNode(name: "bDot1", image: "blackDot", x: -70, y: -150, width: 15, height: 15, z: 2, alpha: 0, isAnchoring: false)
        makeImageNode(name: "bDot2", image: "blackDot", x: 0, y: -150, width: 15, height: 15, z: 2, alpha: 0, isAnchoring: false)
        makeImageNode(name: "bDot3", image: "blackDot", x: 70, y: -150, width: 15, height: 15, z: 2, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "lDot1", image: "lightDot", x: -70, y: -150, width: 107, height: 107, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "lDot2", image: "lightDot", x: 0, y: -150, width: 107, height: 107, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "lDot3", image: "lightDot", x: 70, y: -150, width: 107, height: 107, z: 3, alpha: 0, isAnchoring: false)
        
    }
    
    
    
    //拉開任務＋連結開始學習
    func openQuest(){
        //拉開任務板子的action
        let questBoardAction = SKAction.resize(toHeight: 550, duration: 0.3)
        
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
        
        
        //把SklabelNode -> SKNode並作warp動畫
        /*
         let labelNodeTexture = SKView().texture(from: self!.findLabelNode(name: "questTitle"))!
         let labelNodeSprite = SKSpriteNode(texture: labelNodeTexture)
         self?.addChild(labelNodeSprite)
         self?.warpNode(labelNodeSprite)
         */
        
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
                makeNode(name: "scanning", color: pinkColor, x: 0, y: 120, width: questBoardWidth, height: 1, z: 3, isAnchoring: false, alpha: 1)

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
    
    //學習階段的測驗
    func learningTest(){
        
        //讓英文字alpha變淡
        let fadeOut = SKAction.fadeAlpha(to: 0.1, duration: 0.3)
        
        //所有英文字fadeOut
        for node in children{
            
            if (node.name?.contains("engWord"))!{
                
                node.run(fadeOut)
                
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
            
            
            for _ in 0 ..< 4 {
                randomNumbers = Int(arc4random_uniform(UInt32(countArray.count)))
                extraWords.append(otherWordsOrderSets[countArray[randomNumbers]])
                countArray.remove(at: randomNumbers)
                
                
            }
            
        case 3:
            
            for _ in 0 ..< 3 {
                randomNumbers = Int(arc4random_uniform(UInt32(countArray.count)))
                extraWords.append(otherWordsOrderSets[countArray[randomNumbers]])
                countArray.remove(at: randomNumbers)
                
                
            }
            
        case 4:
            
            for _ in 0..<2 {
                randomNumbers = Int(arc4random_uniform(UInt32(countArray.count)))
                extraWords.append(otherWordsOrderSets[countArray[randomNumbers]])
                countArray.remove(at: randomNumbers)
            }
            
        case 5:
            randomNumbers = Int(arc4random_uniform(UInt32(countArray.count)))
            extraWords.append(otherWordsOrderSets[countArray[randomNumbers]])
            countArray.remove(at: randomNumbers)
            
        case 6:
            
            print("6 syllables")
            
        default:
            print("default")
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
        
        for i in 0 ..< shownWords.count{
            
            makeLabelNode(x: CGFloat(-300 + (120 * i)), y: -400, alignMent: .center, fontColor: .white, fontSize: 50, text: shownWords[i], zPosition: 3, name: shownWords[i] + String(i) + "sel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
          
            isUserInteractionEnabled = true
            
        }
        
        
    }
    
    
    //關上任務版的動畫
    func closeQuestBoardAndReopen(){
        
        //藥水刪掉
        for node in children{
            
            if (node.name?.contains("Poison"))!{
                node.alpha = 0
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
            
            //按鈕功能
            
            if isButtonEnable {
                if node.name == "button"{
       
                    print("button pressed")
           
                }
            }
            
            
            //按主畫面的功能
            if isScanning == false{
                
                //假如發音按超過三次要開始練習
                if playSoundTime < 3{
                    
                    if node.name == "questBoard"{

                        scanAndPronounce()
                    }
                    
                }
             
            }
            
            //假設有選項單字
            if shownWords.count > 0 {
                
                //抓選項方塊
                for i in 0 ..< shownWords.count{
                    
                    if node.name == String(i) + "se"{
                        
                        
                        let wordChosen = shownWords[i]
                        print(wordChosen)
                        
                        checkLearningTestAnswer(word: wordChosen,poisonNumber: i)
                        
                    }
                }
                
                
                
            }
            
            
        }
    }
    
    
    func checkLearningTestAnswer(word:String, poisonNumber:Int){
        
        //抓總共輸入幾次字
        let count = wordEntered.count
        
        //檢查須確認的音節位置, 以count為參考
        switch count {
        case 0:
            if word == currentWordArray[0]{
                //正確
                pourPoisonAndRemoveLabel(sequence: 0, word: word, poisonNumber: poisonNumber)
                
            } else {
                //錯誤
                
            }
        case 1:
            if word == currentWordArray[1]{
                //正確
                pourPoisonAndRemoveLabel(sequence: 1, word: word, poisonNumber: poisonNumber)
                
            } else {
                //錯誤
                
            }
            
            
        case 2:
            if word == currentWordArray[2]{
                //正確
                
                pourPoisonAndRemoveLabel(sequence: 2, word: word, poisonNumber: poisonNumber)
                
            } else {
                //錯誤
                
            }
        case 3:
            if word == currentWordArray[3]{
                //正確
                pourPoisonAndRemoveLabel(sequence: 3, word: word, poisonNumber: poisonNumber)
                
            } else {
                //錯誤
                
            }
        case 4:
            if word == currentWordArray[4]{
                //正確
                
                pourPoisonAndRemoveLabel(sequence: 4, word: word, poisonNumber: poisonNumber)
            } else {
                //錯誤
                
            }
        case 5:
            if word == currentWordArray[5]{
                //正確
                
                pourPoisonAndRemoveLabel(sequence: 5, word: word, poisonNumber: poisonNumber)
                
            } else {
                //錯誤
                
            }
        default:
            break
            
            
        }
        
    }
    
    func pourPoisonAndRemoveLabel(sequence: Int, word:String, poisonNumber:Int){
        
        //確認正確然後填入array
        wordEntered.append(word)
        
        //找正確的音節來顯示alpha
        let correctWordName = word + String(sequence) + "engWord"
        findLabelNode(name: correctWordName).alpha = 1
        
        //將音節正確數量+1, 來對應目前單字音節量
        alreadyCorrectsyllables += 1
        
        //找選項正確音節
        let selectionLabel = findLabelNode(name: word + String(poisonNumber) + "sel")
        
        //把它fadeOut後移除
        let fadeOut  = SKAction.fadeOut(withDuration: 0.3)
        selectionLabel.run(fadeOut, completion: {
            selectionLabel.removeFromParent()
        })
        
        //讓正確藥水罐填滿
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.4)
        findImageNode(name: String(poisonNumber) + "Poison").run(fadeIn)
        
        
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
        
        //分音節
        var sepWords = word.components(separatedBy: " ")
        
        //計算字母有多少個, 用來決定xPos
        var characterCounts = 0
        for i in sepWords{
            characterCounts = characterCounts + i.characters.count
            
        }
        
        
        
        //中文字的x點
        if lang == "chiWord" {
            
            //看字數多少
            switch characterCounts {
                
            case 1...2:
                posX = -70
            case 3...4:
                posX = -90
            case 5...6:
                posX = -110
            case 7...8:
                posX = -130
            default:
                posX = -70
            }
            
            posY = -50
            fontSize = 70
            
            //英文字的x點
        } else if lang == "engWord"{
            
            switch characterCounts {
            case 1...5:
                posX = -150
            case 6...10:
                posX = -175
            case 11...15:
                posX = -240
            case 16...20:
                posX = -280
            default:
                posX = -180
            }
            
            
            posY = 45
            fontSize = 100
            
            //加一個順序
            nextWordSequence += 1
            
            //還原該單字
            wordsToPronounce = word.replacingOccurrences(of: " ", with: "")
            
            //產生提示
            createFlashHint()
            
            
        }
        
        //抓音節數
        let sepCount = sepWords.count
        
        //建立單字
        for i in 0 ..< sepCount{
            
            let sepWord = sepWords[i]
            
            //檢查有沒有元素的字節, 有的話顯示為黃色
            if syllables.contains(sepWord){
                
                let fontColor = UIColor.yellow
                
                if i > 0 {
                    
                    //非第一組字
                    if let leftNode = childNode(withName: sepWords[i - 1] + String(i - 1) + lang) as? SKLabelNode{
                        
                        let nextX = CGFloat(leftNode.frame.origin.x + leftNode.frame.width + 4)
                        
                        makeLabelNode(x: nextX, y: posY, alignMent: .left, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: sepWord + String(i) + lang, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                        
                        
                    }
                    
                } else{
                    //第一組字
                    
                    makeLabelNode(x: posX, y: posY, alignMent: .left, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: sepWord  + String(i) + lang, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                    
                    
                }
                
            } else {
                
                //非元素字
                let fontColor = UIColor.white
                
                if i > 0 {
                    print("3")
                    //非第一組字
                    if let leftNode = childNode(withName: sepWords[i - 1] + String(i - 1) + lang) as? SKLabelNode{
                        
                        let nextX = CGFloat(leftNode.frame.origin.x + leftNode.frame.width + 4)
                        
                        makeLabelNode(x: nextX, y: posY, alignMent: .left, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: sepWord + String(i) + lang, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                        
                    }
                    
                } else{
                    
                    print("4")
                    
                    //第一組字
                    makeLabelNode(x: posX, y: posY, alignMent: .left, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: sepWord + String(i) + lang, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                    
                    
                }
            }
            
        }
        
    }
    
    //建立hint閃爍Label
    
    func createFlashHint(){
        
        //產生提示label, 並閃爍forever
        let hintY = findImageNode(name: "questBoard").frame.minY
        
        makeLabelNode(x: 0, y: hintY + 10, alignMent: .center, fontColor: pinkColor, fontSize: 30, text: "[ 請按畫面聽讀單字 ]", zPosition: 2, name: "hint" , fontName: "Helvetica Light", isHidden: false, alpha: 1)
        
        /*
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.1)
        let wait = SKAction.wait(forDuration: 0.5)
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.1)
        let sparklingAction = SKAction.sequence([wait,fadeOut,wait,fadeIn,wait,fadeOut])
        let sparklingRepeat = SKAction.repeatForever(sparklingAction)
        findLabelNode(name: "hint").run(sparklingRepeat)
        */
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
    
    
    override func update(_ currentTime: TimeInterval) {
        
        
        
        //確定答案正確
        if alreadyCorrectsyllables == currentWordArray.count && alreadyCorrectsyllables != 0 {
            
            
            //不能按畫面
            self.isUserInteractionEnabled = false
            
            //避免再次顯示掃描線
            isScanning = true
            
            //播放單字
            self.scanAndPronounce()
            //輸入正確音節數歸零
            alreadyCorrectsyllables = 0
            

            //初始化
            shownWords.removeAll(keepingCapacity: false)
            wordEntered.removeAll(keepingCapacity: false)
            

            //正確數+1
            correctTime += 1

            
            //移除選項node
            for node in children {
                if (node.name?.contains("sel"))!{
                    node.removeFromParent()
                }
                
            }
            let when = DispatchTime.now() + 2
            
            //關上任務版
            
            DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                
                //確認練習三次了沒
                
                if self!.correctTime < 3 {
                    //再次練習
                    
                    //能按畫面
                    self!.isUserInteractionEnabled = true
                    
                    //藥水刪掉
                    for node in self!.children{
                        
                        if (node.name?.contains("Poison"))!{
                            node.alpha = 0
                        }
                    }
                    
                    //再次啟動練習
                    self!.learningTest()
                    self!.isButtonEnable = false
                    
                } else {
                    //繼續產生學習單字
                    
                    
                    //把順序+1
                    if self!.currentWordSequence < self!.wordSets.count / 3 - 1{
                        self!.currentWordSequence += 1
                    } else {
                        self!.currentWordSequence = 0
                        
                        print("return to Zero")
                    }
                    
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
                    
                    
                    
                }
            })
            
            
        }
        
        
        if playSoundTime == 3 {
            //直接開啟練習
            //只開啟一次
            playSoundTime = 0
            
            //封鎖按鍵
            isUserInteractionEnabled = false
            
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





