//
//  IntroScene.swift
//  wordDrug
//
//  Created by Ethan on 2018/5/29.
//  Copyright © 2018年 playplay. All rights reserved.
//

import SpriteKit
import GameplayKit


let tutorialRecognize = "tutorialRecognize"

class IntroScene: SKScene {

    //紀錄手指位置
    var location = CGPoint()
    let darkTextColor = UIColor.init(red: 51/255, green: 10/255, blue: 41/255, alpha: 1)
    let lightTextColor = UIColor.init(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
    
     var line:SKShapeNode?
    //路徑
    var path:CGMutablePath = CGMutablePath()
    
    //第一點
    var firstTouch = CGPoint()
    
    //未確認的點
    var movingTouch = CGPoint()
    
    
    var isDrawingEnable = false
    
    /*
    let question1 = ["nervous","realize","act","bake","draw","trip","hour"]
    let question2 = ["strategy","suspicion","valuable","fortune","informal","captain","enemy"]
    let question3 = ["feature","calculate","costume","casualty","efficiency","dash","stiff"]
    
    let answer1 = ["緊張的, 易怒的","理解, 立即","扮演, 保護","烘焙, 魚餌","畫, 放置","旅行, 轉換","小時, 車廂"]
    let answer2 = ["策略, 情節","懷疑, 穩固","有價值的, 清醒的","財產, 風險","非正式的, 資訊","隊長, 海灣","敵人, 陰暗的"]
    let answer3 = ["特色, 節慶","計算, 構成","服裝, 習俗","死傷, 隨性","效率, 激動","猛撞, 混入","硬的, 有黏性的"]
    */
    
    
    let question1 = ["male", "concert", "desert", "bottom", "quite", "temperature", "bucket"]
    
    let question2 = ["principal", "lack", "museum", "swallow", "diet", "domestic", "employee"]
    
    let question3 = ["paraphrase", "sufficient", "complement", "tendency", "consequence", "equivalent", "trauma"]
    
    let answer1 = ["男性的, 女性的", "演唱會, 關心", "沙漠, 甜點", "底部, 按鈕", "相當地, 安靜的", "溫度, 脾氣", "桶子, 美元"]
    
    let answer2 = ["校長, 原則", "缺乏, 湖泊", "博物館, 音樂會", "吞嚥, 麻雀", "飲食, 死亡", "家庭的, 民主的", "雇員, 雇主"]
    
    let answer3 = ["改述, 段落", "足夠的, 有效的", "使增色, 讚美", "傾向, 溫柔", "後果, 一連串", "相等的, 裝備", "心理創傷, 腫瘤"]
    
    //中文字左右對錯
    var leftOrRight = Int()
    

    var right1 = Int()
    var right2 = Int()
    var right3 = Int()
    
    
    var recommendedClass = String()
    
    
    var timer = Timer()
    var finalPercent = Int()
    var numberShown = 0
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    var xDif = CGFloat()
    
    var rightSound = SKAction()
   

    override func didMove(to view: SKView) {
        print("yes scene")
        
        
        rightSound = SKAction.playSoundFileNamed("correct.wav", waitForCompletion: false)

        
        switch height {
        case 812:
            xDif = 1.2

        case 736:
            xDif = 1

            
        case 667:
            xDif = 1

            
        case 568:
            xDif = 1

            
        default:
            xDif = 1

        }

        
        
        //口試Nc (單字 + 句子)
        NotificationCenter.default.addObserver(self, selector: #selector(IntroScene.notifyStartToRecognize), name: NSNotification.Name("tutorialRecognize"), object: nil)
        
        
        //口試正確
        NotificationCenter.default.addObserver(self, selector: #selector(IntroScene.recogRight), name: NSNotification.Name("recogRight"), object: nil)
        
        
        //口試正確
        NotificationCenter.default.addObserver(self, selector: #selector(IntroScene.notifyToCourse), name: NSNotification.Name("toCourse"), object: nil)
        
        
        makeImageNode(name: "introBg", image: "introBg", x: 0, y: 0, width: 750, height: 1334, z: 0, alpha: 1, isAnchoring: false)
        
        makeImageNode(name: "speaker", image: "speaker", x: -270, y: 500, width: 63, height: 72, z: 1, alpha: 1, isAnchoring: false)
        makeImageNode(name: "volume", image: "volume", x: -200, y: 500, width: 45, height: 68, z: 1, alpha: 1, isAnchoring: false)
    
        makeImageNode(name: "volumeBlock", image: "volumeBlock", x: -210, y: 500, width: 101, height: 108, z: 2, alpha: 1, isAnchoring: false)
        makeLabelNode(x: 0, y: 0, alignMent: .center, fontColor: .cyan, fontSize: 48, text: "請打開音量按鈕", zPosition: 1, name: "tutorialLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        

        makeImageNode(name: "okBtnFrame", image: "okBtnFrame", x: 0, y: -400, width: 253, height: 75, z: 1, alpha: 0, isAnchoring: false)
        
        makeLabelNode(x: 0, y: -425, alignMent: .center, fontColor: .cyan, fontSize: 36, text: "下一步", zPosition: 2, name: "okBtnLabel", fontName: "Helvetica Neue Light", isHidden: false, alpha: 0)
        
        makeImageNode(name: "world", image: "world", x: 0, y: 0, width: 256, height: 256, z: 1, alpha: 0, isAnchoring: false)
        
       // makeLabelNode(x: 0, y: -500, alignMent: .center, fontColor: .cyan, fontSize: 30, text: "1/4", zPosition: 1, name: "stepLabel", fontName: "Helvetica Neue Light", isHidden: false, alpha: 0)
        
        makeImageNode(name: "Mi", image: "grayBall", x: -180, y: 0, width: 180, height: 180, z: 1, alpha: 0, isAnchoring: false)
        makeImageNode(name: "ss", image: "grayBall", x: 180, y: 50, width: 180, height: 180, z: 1, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "Mi2", image: "cyanBall", x: -180, y: 0, width: 180, height: 180, z: 2, alpha: 0, isAnchoring: false)
        makeImageNode(name: "ss2", image: "cyanBall", x: 180, y: 50, width: 180, height: 180, z: 2, alpha: 0, isAnchoring: false)
        
        
        makeLabelNode(x: -180, y: -50, alignMent: .center, fontColor: .black, fontSize: 70, text: "Mi", zPosition: 3, name: "MiLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        makeLabelNode(x: 180, y: 10, alignMent: .center, fontColor: .black, fontSize: 70, text: "ss", zPosition: 3, name: "ssLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        
        makeImageNode(name: "arrow", image: "blueArrow", x: 0, y: 20, width: 117, height: 79, z: 1, alpha: 0, isAnchoring: false)

        
        makeImageNode(name: "finger", image: "blueFinger", x: -180, y: -110, width: 134, height: 174, z: 3, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "point", image: "bluePoint", x: -170, y: -20, width: 45, height: 45, z: 3, alpha: 0, isAnchoring: false)
        

        makeLabelNode(x: 0, y: 250, alignMent: .center, fontColor: .cyan, fontSize: 90, text: "Mi", zPosition: 1, name: "bigWordLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        
        makeImageNode(name: "recogWordsBg", image: "recogWordsBg", x: 0, y: 0, width: 750, height: 228, z: 10, alpha: 0, isAnchoring: false)
        
        //makeImageNode(name: "cyanLine", image: "cyanLine", x: 0, y: 40, width: 230, height: 40, z: 1, alpha: 1, isAnchoring: false)
        
        
        makeImageNode(name: "leftChiBtn", image: "gradeChiBtnLeft", x: -160, y: -450, width: 256, height: 256, z: 1, alpha: 0, isAnchoring: false)
        
         makeImageNode(name: "rightChiBtn", image: "gradeChiBtnRight", x: 160, y: -450, width: 256, height: 256, z: 1, alpha: 0, isAnchoring: false)
        
        
        makeLabelNode(x: -160, y: -490, alignMent: .center, fontColor: .white, fontSize: 60, text: "政治", zPosition: 2, name: "leftChi", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        
        makeLabelNode(x: 160, y: -490, alignMent: .center, fontColor: .white, fontSize: 60, text: "政府", zPosition: 2, name: "rightChi", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        makeLabelNode(x: 0, y: 500, alignMent: .center, fontColor: .white, fontSize: 48, text: "分級測驗", zPosition: 1, name: "testTitle", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        makeLabelNode(x: 0, y: 450, alignMent: .center, fontColor: .white, fontSize: 40, text: "1/15", zPosition: 1, name: "testNumber", fontName: "Helvetica Neue Light", isHidden: false, alpha: 0)
       
        makeLabelNode(x: 0, y: 0, alignMent: .center, fontColor: .white, fontSize: 90, text: "government", zPosition: 1, name: "bigEnglishLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        
        let moveToRight = SKAction.moveTo(x: -140, duration: 1)
        let jumpBack = SKAction.moveTo(x: -215, duration: 0)
        let blockAction = SKAction.sequence([moveToRight,jumpBack])
        let repeatAction = SKAction.repeatForever(blockAction)
        findImageNode(name: "volumeBlock").run(repeatAction)
        
        let wait = SKAction.wait(forDuration: 2)
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        let fadeInAction = SKAction.sequence([wait,fadeIn])
        
        //findLabelNode(name: "stepLabel").run(fadeInAction)
        findImageNode(name: "okBtnFrame").run(fadeInAction)
      
        isUserInteractionEnabled = false
        findLabelNode(name: "okBtnLabel").run(fadeInAction) {[weak self] in
            self!.isUserInteractionEnabled = true
        }
        
        
        //提示字
        makeLabelNode(x: -425, y: 0, alignMent: .center, fontColor: .white, fontSize: 50, text: "", zPosition: 1, name: "hintLeftLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        makeLabelNode(x: 425, y: 0, alignMent: .center, fontColor: .white, fontSize: 50, text: "", zPosition: 1, name: "hintRightLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        
        
        makeImageNode(name: "testResult", image: "testResult", x: 0, y: 0, width: 650 / xDif, height: 520 / xDif, z: 1, alpha: 0, isAnchoring: false)
        
        makeLabelNode(x: -290 / xDif, y: 160  / xDif, alignMent: .left, fontColor: .white, fontSize: 30, text: "MissWord\n建議你學習", zPosition: 2, name: "resultTitle", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
       // makeLabelNode(x: -290, y: 160, alignMent: .left, fontColor: darkTextColor, fontSize: 20, text: "總計2100字", zPosition: 2, name: "classWords", fontName: "Helvetica Neue Light", isHidden: false, alpha: 1)
         //       makeLabelNode(x: -292, y: 80, alignMent: .left, fontColor: darkTextColor, fontSize: 20, text: "預計學習時數\n21小時", zPosition: 2, name: "classHours", fontName: "Helvetica Neue Light", isHidden: false, alpha: 1)
        makeLabelNode(x: 310  / xDif, y: 60  / xDif, alignMent: .right, fontColor: darkTextColor, fontSize: 100  / xDif, text: "英檢初級", zPosition: 2, name: "suggestedClass", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        makeLabelNode(x: 0, y: -50, alignMent: .center, fontColor: darkTextColor, fontSize: 24, text: "正確率", zPosition: 2, name: "percentTitle", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        makeLabelNode(x: 0, y: -90, alignMent: .center, fontColor: darkTextColor, fontSize: 30, text: "83%", zPosition: 2, name: "percent", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        makeImageNode(name: "resultOkBtn", image: "resultOkBtn", x: 2, y: -210  / xDif, width: 420, height: 58, z: 2, alpha: 0, isAnchoring: false)
        
        makeLabelNode(x: -270  / xDif, y: -50  / xDif, alignMent: .left, fontColor: darkTextColor, fontSize: 18, text: "正確字數", zPosition: 2, name: "rightWordTitle", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        makeLabelNode(x: -120  / xDif, y: -100  / xDif, alignMent: .right, fontColor: darkTextColor, fontSize: 60 / xDif / xDif, text: "14", zPosition: 2, name: "rightWordCount", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        
        makeLabelNode(x: 115  / xDif, y: 10  / xDif, alignMent: .left, fontColor: darkTextColor, fontSize: 18, text: "錯誤字數", zPosition: 2, name: "wrongWordTitle", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
          makeLabelNode(x: 260  / xDif, y: -30  / xDif, alignMent: .right, fontColor: darkTextColor, fontSize: 60 / xDif / xDif, text: "7", zPosition: 2, name: "wrongWordCount", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        
        
        //製作跳過按鍵
        /*
        makeLabelNode(x: 255, y: 482, alignMent: .center, fontColor: .cyan, fontSize: 40, text: "skip", zPosition: 2, name: "skipLabel", fontName: "Helvetica Neue", isHidden: false, alpha: 1)
        makeImageNode(name: "skip", image: "skipPng", x: 320, y: 503, width: 19, height: 31, z: 2, alpha: 1, isAnchoring: false)
        */
        
        /*
        makeImageNode(name: "mark", image: "rightCircle", x: -160, y: -450, width: 275, height: 275, z: 9, alpha: 0, isAnchoring: false)
        makeImageNode(name: "mark", image: "wrongX", x: 160, y: -450, width: 202, height: 214, z: 9, alpha: 0, isAnchoring: false)
        */
        
        
        makeImageNode(name: "steps", image: "step1Png", x: 0, y: -600, width: 79, height: 15, z: 2, alpha: 0, isAnchoring: false)
        
        let stepFadeIn = SKAction.fadeIn(withDuration: 2)
        let stepAction = SKAction.sequence([wait, stepFadeIn])
        findImageNode(name: "steps").run(stepAction)
    }
    
    var isTouchedNode = false
    
    
    @objc func notifyStartToRecognize(){
        
        
    }
    
    @objc func notifyToCourse(){
        
        
    }
    
    var isEnterTest = false
    
    var isBigWordLocked = false
    @objc func recogRight(){
        
        changeImageAlfa(name: "steps", toAlpha: 0, time: 0.3)
        
        findImageNode(name: "recogWordsBg").alpha = 0
        findLabelNode(name: "bigWordLabel").fontSize = 50
        findLabelNode(name: "bigWordLabel").text = "為了建議適合你的課程\n請先試試你的單字程度"
        isBigWordLocked = true
        
        isOkClicked = false
        isEnterTest = true
        findLabelNode(name: "okBtnLabel").text = "進入分級測驗"
        
        changeImageAlfa(name: "world", toAlpha: 1, time: 0.3)
        changeImageAlfa(name: "okBtnFrame", toAlpha: 1, time: 0.3)
        changeLabelAlfa(name: "okBtnLabel", toAlpha: 1, time: 0.3)
        
        let rotate = SKAction.rotate(toAngle: 180, duration: 600)
        
        findImageNode(name: "world").run(rotate)
        
    }
    
    
    var isOkClicked = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            
            location = touch.location(in: self)
            
            let node : SKNode = self.atPoint(location)
            
              firstTouch = touch.location(in: self)
         

            if node.name == "okBtnFrame" || node.name == "okBtnLabel"{
                if isOkClicked == false {

                isOkClicked = true
                
                    
                    if isEnterTest {
                        //進入分級測驗
                        
                        
                        let quickTurn = SKAction.rotate(toAngle: 180, duration: 3)
                        let fadeOut = SKAction.fadeOut(withDuration: 0.2)
                        
                        let group = SKAction.group([quickTurn,fadeOut])
                        findImageNode(name: "world").run(group)
                        
                        changeImageAlfa(name: "okBtnFrame", toAlpha: 0, time: 0.5)
                        //changeLabelAlfa(name: "okBtnLabel", toAlpha: 0, time: 0.5)
                        
                        changeLabelAlfa(name: "bigWordLabel", toAlpha: 0, time: 0.5)
                        
                        let finalFadeOut = SKAction.fadeOut(withDuration: 0.5)
                        findLabelNode(name: "okBtnLabel").run(finalFadeOut) {[weak self] in
                            self!.hintSlideIn(leftText: "分級", rightText: "測驗", waitTime: 1) {
                                
                                
                                
                                self!.testSetup()
                            }
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                    } else {
                
                let fadeOut = SKAction.fadeOut(withDuration: 0.4)
                findImageNode(name: "okBtnFrame").run(fadeOut)
                findLabelNode(name: "okBtnLabel").run(fadeOut)
                findImageNode(name: "volume").run(fadeOut)
                findImageNode(name: "speaker").run(fadeOut)
                findImageNode(name: "volumeBlock").run(fadeOut)
                //findLabelNode(name: "stepLabel").run(fadeOut)
                findLabelNode(name: "tutorialLabel").run(fadeOut) {[weak self] in
                    
                    self!.changeTexture(nodeName: "steps", newTexture: "step2Png")
                    
                    //self!.findLabelNode(name: "stepLabel").text = "2/4"
                    self!.findLabelNode(name: "tutorialLabel").text = "請連線拼字"
                    
                    let wait = SKAction.wait(forDuration: 0.3)
                    let fadeIn = SKAction.fadeIn(withDuration: 0.5)
                    let fadeInAction = SKAction.sequence([wait,fadeIn])
                    self!.findLabelNode(name: "tutorialLabel").run(fadeInAction, completion: {[weak self] in
                        self!.step2()
                    })
                    
                    
                }
                
                    }
            
                }
            
            }
            
            if isDrawingEnable {
            
            if node.name == "Mi" || node.name == "MiLabel"{
                
                isTouchedNode = true
            
            //在建立一條新的線
            line = SKShapeNode()
            line?.strokeColor = .cyan
            line?.lineWidth = 8
            line?.name = "line"
            line?.zPosition = 2
            line?.glowWidth = 2
            
            addChild(line!)
                
                
                findImageNode(name: "Mi2").alpha = 1
                findLabelNode(name: "bigWordLabel").alpha = 1
                findLabelNode(name: "bigWordLabel").text = "Mi"
                
                
            }
                

                
                
                
            }
            
            
            
            let when = DispatchTime.now() + 0.3

            
            if node.name == "leftChiBtn" || node.name == "leftChi"{
                
                if leftOrRight == 0 {
                    //答對
                    changeImageAlfa(name: "leftChiBtn", toAlpha: 0, time: 0.1)
                    //changeImageAlfa(name: "rightChiBtn", toAlpha: 0, time: 0.1)
                    
                    makeImageNode(name: "mark", image: "rightCircle", x: -160, y: -450, width: 275 , height: 275, z: 9, alpha: 1, isAnchoring: false)
                    makeImageNode(name: "mark", image: "wrongX", x: 160 , y: -450, width: 202, height: 214, z: 9, alpha: 1, isAnchoring: false)
                    
                    DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                        self!.chooseChineseResult(isCorrect: true)
                    })
                    
                } else {
                    //答錯
                    
                    changeImageAlfa(name: "leftChiBtn", toAlpha: 0, time: 0.1)
                    //changeImageAlfa(name: "rightChiBtn", toAlpha: 0, time: 0.1)
                    makeImageNode(name: "mark", image: "rightCircle", x: 160, y: -450, width: 275, height: 275 , z: 9, alpha: 1, isAnchoring: false)
                    
                    makeImageNode(name: "mark", image: "wrongX", x: -160, y: -450, width: 202 , height: 214, z: 9, alpha: 1, isAnchoring: false)
                    
                    DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                        self!.chooseChineseResult(isCorrect: false)
                    })
                    
                }
                
            }
            
            if node.name == "rightChiBtn" || node.name == "rightChi"{
                
                if leftOrRight == 1 {
                    //答對
                    changeImageAlfa(name: "rightChiBtn", toAlpha: 0, time: 0.1)
                    
                    makeImageNode(name: "mark", image: "wrongX", x: -160, y: -450, width: 202, height: 214 , z: 9, alpha: 1, isAnchoring: false)
                    makeImageNode(name: "mark", image: "rightCircle", x: 160, y: -450, width: 275, height: 275, z: 9, alpha: 1, isAnchoring: false)
                    
                    DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                        self!.chooseChineseResult(isCorrect: true)
                    })
                    
                } else {
                    //答錯
                    
                    changeImageAlfa(name: "rightChiBtn", toAlpha: 0, time: 0.1)
                    makeImageNode(name: "mark", image: "rightCircle", x: -160, y: -450, width: 275, height: 275, z: 9, alpha: 1, isAnchoring: false)
                    
                    
                    makeImageNode(name: "mark", image: "wrongX", x: 160, y: -450, width: 202, height: 214, z: 9, alpha: 1, isAnchoring: false)
                    
                    DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                        self!.chooseChineseResult(isCorrect: false)
                    })
                }

                
                
                
                
                
            }
            
            
            
            if node.name == "resultOkBtn"{
                
                let recommendedClass:[String:String] = ["recommendedClass":self.recommendedClass]
                
            
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toCourse"), object: nil, userInfo: recommendedClass)
                
                
            }
            
        }
        
    }
    
  
    var sequence = 0
    func testSetup(){
        
        
        makeWord(seq: sequence)
        
        
        changeImageAlfa(name: "leftChiBtn", toAlpha: 1, time: 0.3)
        changeImageAlfa(name: "rightChiBtn", toAlpha: 1, time: 0.3)
        changeLabelAlfa(name: "leftChi", toAlpha: 1, time: 0.3)
        changeLabelAlfa(name: "rightChi", toAlpha: 1, time: 0.3)
        changeLabelAlfa(name: "testTitle", toAlpha: 1, time: 0.3)
        changeLabelAlfa(name: "testNumber", toAlpha: 1, time: 0.3)
        changeLabelAlfa(name: "bigEnglishLabel", toAlpha: 1, time: 0.3)
        
        
        
        
        
        
    }
    
    
    func makeWord(seq:Int){
        
        
        var wordSets = [String]()
        var chiSets = [String]()
        var index = Int()
        switch seq{
        case ..<7:
            print("1")
            wordSets = question1
            chiSets = answer1
            index = seq
        case 7 ..< 14:
            print("1")
            wordSets = question2
            chiSets = answer2
            index = seq - 7
        case 14...:
            print("1")
            wordSets = question3
            chiSets = answer3
            index = seq - 14
        default:
            break

        }
        
        
        let engWord = wordSets[index]
        let chiWords = chiSets[index].components(separatedBy: ", ")
        
        print(engWord)
        print(chiWords)
    
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
        
        findLabelNode(name: "bigEnglishLabel").text = engWord
        findLabelNode(name: "leftChi").text = chiWords[randomL]
        findLabelNode(name: "rightChi").text = chiWords[randomR]
        findLabelNode(name: "testNumber").text = "\(sequence + 1)/21"
        
        
        sequence += 1
        
        
        
    }
    
    func chooseChineseResult(isCorrect:Bool){

            
            if isCorrect{
                
              
                print("add Right")

                switch sequence{
                case ..<7:

                    right1 += 1
                    
                case 7 ..< 14:
                    
                    right2 += 1
                case 14...:
                    right3 += 1
                    
                default:
                    break
                    
                }
                
            }
        //測試用
       if sequence == 21{
            
       //     if sequence == 2{
            print("test is over")
            
        
        
        if right1 >= 5 {
            
            
            if right2 >= 4 {
                
                
                 recommendedClass = "英檢中級"
 
                    
                    if right3 >= 5 {
                        
                         recommendedClass = "多益滿分"
                        
                    }
                

                
            } else {
                
                
                 recommendedClass = "英檢初級"
            }
            

            
        } else {
            
           recommendedClass = "英檢初級"
            
        }
        
        
        
        /*
            if right1 < 7 {
                //留在英檢初級
                print("英檢初")
                
                recommendedClass = "英檢初級"
                
            } else if right2 < 3{
                
                //留在英檢中
                
                
                print("英檢中")
                
                recommendedClass = "英檢初級"
                
                //這裡的判斷邏輯錯全對者無推薦
            }  else if right2 > 3 && right3 > 5 {
                
                //建議Toeic
                
                print("Toeic")
                recommendedClass = "多益滿分"
                
            }
            */
            
            
        print(right1)
        print(right2)
        print(right3)
        let rightCount = right1 + right2 + right3
            findLabelNode(name: "rightWordCount").text = String(rightCount)
            
            let wrongCount = 21 - rightCount
            findLabelNode(name: "wrongWordCount").text = String(wrongCount)
            
            
            let percentage = Double(rightCount) / Double(21) * 100
            
            finalPercent = Int(percentage)
            //findLabelNode(name: "percent").text = String(Int(percentage)) + "%"
            
            
            findLabelNode(name: "suggestedClass").text = recommendedClass
            
            
            
            removeSomeNodes(name: "mark")
            
            findImageNode(name: "leftChiBtn").alpha = 0
            findImageNode(name: "rightChiBtn").alpha = 0
            findLabelNode(name: "leftChi").text = ""
            findLabelNode(name: "rightChi").text = ""
            findLabelNode(name: "bigEnglishLabel").text = ""
            
            
            changeImageAlfa(name: "testResult", toAlpha: 1, time: 0.3)
            changeLabelAlfa(name: "resultTitle", toAlpha: 1, time: 0.3)
            //changeLabelAlfa(name: "suggestedClass", toAlpha: 1, time: 0.3)
            changeLabelAlfa(name: "percentTitle", toAlpha: 1, time: 0.3)
            changeLabelAlfa(name: "percent", toAlpha: 1, time: 0.3)
            changeImageAlfa(name: "resultOkBtn", toAlpha: 1, time: 0.3)
            changeLabelAlfa(name: "rightWordTitle", toAlpha: 1, time: 0.3)
            changeLabelAlfa(name: "rightWordCount", toAlpha: 1, time: 0.3)
            changeLabelAlfa(name: "wrongWordTitle", toAlpha: 1, time: 0.3)
            changeLabelAlfa(name: "wrongWordCount", toAlpha: 1, time: 0.3)
            
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(IntroScene.startCounting), userInfo: nil, repeats: true)
            
            
            
            
            
        } else {
        
            
            removeSomeNodes(name: "mark")
            
            findImageNode(name: "leftChiBtn").alpha = 1
            findImageNode(name: "rightChiBtn").alpha = 1
            
            findLabelNode(name: "leftChi").text = ""
            findLabelNode(name: "rightChi").text = ""
            
            makeWord(seq: sequence)

            
            
        }
            
        
        
    }


    @objc func startCounting(){
        
        
        
        
        
        if numberShown < finalPercent {
            
            numberShown += 1
            
            findLabelNode(name: "percent").text = String(numberShown) + "%"
            
            
            
            
            
        } else {
            
            timer.invalidate()
            
            
            print("count over")
            
            let downY = findLabelNode(name: "suggestedClass").frame.origin.y - 20
            let moveDown = SKAction.moveTo(y: downY, duration: 0)
            let moveUp = SKAction.moveTo(y: 60, duration: 0.2)
            let fadeIn = SKAction.fadeIn(withDuration: 0.2)
            let groupAction = SKAction.group([moveUp,fadeIn])
            let sequence = SKAction.sequence([moveDown,groupAction])
            findLabelNode(name: "suggestedClass").run(sequence)
            
        }
        
        
        
        
    }
    
    var isEndOnNode = false
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch in touches{
            
      
            //設定正在移動中的位置
            movingTouch = touch.location(in: self)
            
            let node : SKNode = self.atPoint(movingTouch)


            if isTouchedNode{
            
                isEndOnNode = true
            //畫線
            drawLine()
                
                
                
                if node.name == "ss" || node.name == "ssLabel"{
                    
                    
                    
                    findImageNode(name: "ss2").alpha = 1
   
                        
                        findLabelNode(name: "bigWordLabel").text = "Miss"
                    
                    
                    
                    
                    
            
                }
                
            }
                
                
            
        }
        
    }
    
    
    func drawLine(){
        
    path = CGMutablePath()

    path.move(to: firstTouch)
    
        if isEndOnNode{
    path.addLine(to: movingTouch)
        }
    line!.path = path
    
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch in touches{
            location = touch.location(in: self)
            
            let node : SKNode = self.atPoint(location)
          if isTouchedNode{
            
            if node.name == "ss" || node.name == "ssLabel" || node.name == "ss2" ||  findLabelNode(name: "bigWordLabel").text == "Miss"{
                
                self.run(rightSound)
                
                print("1111")
                //passed
                
                findImageNode(name: "finger").removeAllActions()
                findImageNode(name: "arrow").removeAllActions()
                findImageNode(name: "point").removeAllActions()
                changeImageAlfa(name: "finger", toAlpha: 0, time: 0.2)
                changeImageAlfa(name: "arrow", toAlpha: 0, time: 0.2)
                changeImageAlfa(name: "point", toAlpha: 0, time: 0.2)
                
                
                
                let moveUp = SKAction.moveTo(y: 280, duration: 0.7)
                let fadeOut = SKAction.fadeOut(withDuration: 0.5)
                let quickFadeOut = SKAction.fadeOut(withDuration: 0.2)
                let groupAction = SKAction.group([moveUp,fadeOut])
              
                findImageNode(name: "Mi").run(quickFadeOut)
                findImageNode(name: "Mi2").run(quickFadeOut)
                findImageNode(name: "ss").run(quickFadeOut)
                findImageNode(name: "ss2").run(quickFadeOut)
                findLabelNode(name: "MiLabel").run(quickFadeOut)
                findLabelNode(name: "ssLabel").run(quickFadeOut)
                let node = childNode(withName: "line") as! SKShapeNode
                node.run(quickFadeOut)
                
                findLabelNode(name: "bigWordLabel").run(groupAction) {[weak self] in
                    
                    
                    self!.findLabelNode(name: "tutorialLabel").text = "Good！"
                    self!.findLabelNode(name: "tutorialLabel").alpha = 1
                    
                             self!.step5()
                }
                
                
            } else {
                
                
                
      
                print("22222")
                    removeSomeNodes(name: "line")
                    findImageNode(name: "Mi2").alpha = 0
                    findImageNode(name: "ss2").alpha = 0
                if isBigWordLocked == false {
                    findLabelNode(name: "bigWordLabel").text = ""
                }
                    isTouchedNode = false
                

            }
        }
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
    
    
    
    func step2(){
        
        let wait = SKAction.wait(forDuration: 0.5)
        let fadeOut = SKAction.fadeOut(withDuration: 0.3)
        let fadeOutAction = SKAction.sequence([wait,fadeOut])
        
        let fadeIn = SKAction.fadeIn(withDuration: 0.3)
        let fadeInAction = SKAction.sequence([wait, fadeIn])
        
        
        findLabelNode(name: "tutorialLabel").run(fadeOutAction) {[weak self] in
            
            
            self!.findImageNode(name: "Mi").run(fadeInAction)
            self!.findImageNode(name: "ss").run(fadeInAction)
            
            self!.findLabelNode(name: "MiLabel").run(fadeInAction)
            self!.findLabelNode(name: "ssLabel").run(fadeInAction, completion: {[weak self] in
               self!.step3()

            })
            
            
        }

        
    }
    
    
    func step3(){
        
        let wait = SKAction.wait(forDuration: 0.5)
        let bigSize = CGSize(width: 90, height: 90)
        let enlarge = SKAction.scale(to: bigSize, duration: 0.3)
        let fadeOut = SKAction.fadeOut(withDuration: 0.2)
        let reSize = CGSize(width: 45, height: 45)
        let reScale = SKAction.scale(to: reSize, duration: 0)
        let fadeIn = SKAction.fadeIn(withDuration: 0)
        let appear = SKAction.sequence([wait, fadeIn])
        let enlargeAndGone = SKAction.sequence([appear, enlarge, fadeOut, reScale])
        let repeatAction2 = SKAction.repeat(enlargeAndGone, count: 1)
        
        findImageNode(name: "finger").run(appear)
        findImageNode(name: "point").run(repeatAction2) {[weak self] in
            
            
            self!.isDrawingEnable = true
            self!.step4()
          
        }
        
        
        
        
    }
    
    
    func step4(){
        
        
        let blinkOut = SKAction.fadeOut(withDuration: 0.4)
        let blinkIn = SKAction.fadeIn(withDuration: 0.2)
        let blink = SKAction.sequence([blinkIn, blinkOut])
        let repeatBlinkAction = SKAction.repeat(blink, count: 2)
        
        //findLabelNode(name: "bigWordLabel").run(blinkIn)
        //changeTexture(nodeName: "Mi", newTexture: "cyanBall")
        
        let rightPos = CGPoint(x: 180, y: -60)
        
        let moveToRight = SKAction.move(to: rightPos, duration: 0.5)
        findImageNode(name: "finger").run(moveToRight)
        
        
        findImageNode(name: "arrow").run(repeatBlinkAction) {[weak self] in
            
   
  
            //self?.findImageNode(name: "finger").run(blinkOut)
            
            self?.findImageNode(name: "finger").run(blinkOut, completion: {[weak self] in
                let originalPos = CGPoint(x: -180, y: -110)
                let moveBack = SKAction.move(to: originalPos, duration: 0)
                self!.findImageNode(name: "finger").run(moveBack)
                self!.step3()
            })
            
        }
        
        
    }
    
    

    
    
    func step5(){
        
        //準備發音練習
        
        let wait = SKAction.wait(forDuration: 0.7)
        let fadeOut = SKAction.fadeOut(withDuration: 0.3)
        
        let fadeOutSeq = SKAction.sequence([wait,fadeOut])
        changeTexture(nodeName: "steps", newTexture: "step3Png")

        
        findLabelNode(name: "tutorialLabel").run(fadeOutSeq) {[weak self] in
   
            self!.findLabelNode(name: "bigWordLabel").text = "Hi!"
            self!.changeLabelAlfa(name: "bigWordLabel", toAlpha: 1, time: 0.2)
            
            //let moveDown = SKAction.moveTo(y: -170, duration: 0)
            
            /*
            self?.findLabelNode(name: "tutorialLabel").run(moveDown)
            
            self!.findLabelNode(name: "tutorialLabel").text = "按一下麥克風"
            
            self!.changeLabelAlfa(name: "tutorialLabel", toAlpha: 1, time: 0.2)
            */
            self!.changeImageAlfa(name: "recogWordsBg", toAlpha: 1, time: 0.2)
            
            
                    self!.changeImageAlfa(name: "steps", toAlpha: 0, time: 0.5)
            
                     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tutorialRecognize"), object: nil, userInfo: nil)
            
            
            
            
        }
    
        
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
    
}

