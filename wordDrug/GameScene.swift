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
    let darkYellow = UIColor.init(red: 1, green: 156/255, blue: 0, alpha:1)
    
    
    //暫時使用的單字
    var wordSets = [String]()
    
    //此元素頁面裡所有的音節
    var syllables = [String]()
    
    //一張地圖裡的所有音節
    //音節
    let syllableSets = [["ab1","ac1","ad1","a_e1","af1","ai1","al1","am1","an1","any1"],["ap1","ar1","as1","at1","au1","aw1","ay1","ba1","be1","bi1"],["bit1","bl1","bo1","br1","bu1","by1","ce1","ch1","ci1","ble1"],["ck1","cl1","co1","com1","con1","cian1","cr1","ct1","de1","di1"],["do1","dr1","dy1","dis1","ea1","ee1","el1","em1","en1","er1"],["et1","ew1","ex1","ey1","fi1","fl1","fo1","fr1","ft1","ful1"],["ge1","gi1","gl1","go1","gr1","he1","hi1","id1","ie1","igh1"],["il1","im1","in1","ing1","ir1","is1","ject1","kn1","le1","li1"],["ly1","mi1","nd1","no1","nt1","oa1","ob1","oe1","of1","oi1"],["old1","on1","ong1","oo1","op1","or1","ot1","ou1","ow1","oy1"],["ph1","pi1","pl1","pr1","rare1","re1","ro1","ry1","sh1","si1"],["sk1","so1","sp1","st1","sion1","th1","ti1","tion1","tive1","tle1"],["to1","tr1","ture1","ty1","ub1","ue1","ui1","um1","un1","up1"],["ur1","ut1","war1","wh1","ab2","ac2","ad2","a_e2","af2","ai2"]]
    
    
    var syllablesToCheck = String()
    
    var syllablesWithoutDigit = String()
    
    //母音
    let vowels = ["a","e","i","o","u"]
    
    //是否是_e音節
    var isSpecialE = false
    
    //做名字供下方使用
    var syllableWordName = String()
    
    //做名字給上方的第一個字母用
    var normalSyllableName = String()
    
    //_e使用
    var characters = [Character]()
    
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
    //var monsters = ["flatMonster1","flatMonster2","flatMonster3"]
    //輪流順序
    var monsterSequence = 0
    
    var monsters = [["id":101,"name":"毛毛蟲"],["id":201,"name":"蘑菇怪"],["id":301,"name":"球球"],["id":401,"name":"史帝奇"],["id":501,"name":"青螳螂"],["id":601,"name":"被污染的鹿"],["id":701,"name":"田鼠"],["id":801,"name":"涡蝙蝠"],["id":901,"name":"鬍狗"],["id":1001,"name":"鋼牙鯊"],["id":1101,"name":"偵查哥八犬"],["id":1201,"name":"變異鹿"],["id":1301,"name":"眼鏡蛇"],["id":1401,"name":"三頭地獄犬"],["id":1501,"name":"獨眼觸手"],["id":1601,"name":"荊棘豬"],["id":1701,"name":"長毛犀牛"],["id":1801,"name":"王者翼獸"],["id":1901,"name":"巨爪虎"],["id":2001,"name":"海蛇王"],["id":2101,"name":"水晶蠍"],["id":2201,"name":"幽靈劍齒虎"],["id":2301,"name":"飛行焰馬"],["id":2401,"name":"恐龍"],["id":2501,"name":"老樹精"],["id":2601,"name":"污染的惡狼"],["id":2701,"name":"變異蜥蜴"],["id":2801,"name":"恐龍博士"],["id":2901,"name":"獅龍獸"],["id":3001,"name":"尖齒龍"],["id":3101,"name":"元素熊"],["id":3201,"name":"狐狸人"],["id":3301,"name":"咕魯"],["id":3401,"name":"食屍鬼"],["id":3501,"name":"泰坦星人"],["id":3601,"name":"納瑟斯"],["id":3701,"name":"翰墨丁格"],["id":3801,"name":"小小"],["id":3901,"name":"菲斯"],["id":4001,"name":"梅杜莎"],["id":4101,"name":"骷顱王"],["id":4201,"name":"死亡之握"]]
    
    
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
    var selNodeNames = ["se0","se1","se2","se3","se4"]
    
    //被設定好的頁數
    var spotNumber = Int()
    var unitNumber = Int()
    
    override func didMove(to view: SKView) {
        
        //元素單位練習完後的key
        NotificationCenter.default.addObserver(self, selector: #selector(GameScene.notifyEndUnit), name: NSNotification.Name("endUnit"), object: nil)
        
        //抓正確unit
        currentWordSequence = 3 * unitNumber
        
        //抓正確的音節
        syllables = syllableSets[spotNumber]
        
        //建立整個背景
        makeImageNode(name: "bg", image: "testBgBlurred", x: 0, y: 0, width: 750, height: 1334, z: 0, alpha: 1, isAnchoring: false)
        
        //建立任務版子
        makeImageNode(name: "questBoard", image: "testQuestBoardDark", x: 0, y: 380, width: 610, height: 0, z: 1, alpha: 1, isAnchoring: false)
        
        //建立任務標題
        makeLabelNode(x: -100, y:500, alignMent: .left, fontColor: .white, fontSize: 50, text: "", zPosition: 2, name: "questTitle", fontName: "Helvetica Bold", isHidden: false, alpha:1)
        
        //任務板子動畫 + 標題動畫
        openQuest()
        
        //建立怪物畫面背景
       // makeImageNode(name: "screenBg", image: "screenBg", x: 0, y: 500, width: 750, height: 431, z: 1, alpha: 1, isAnchoring: false)
        
        //建立開啟按鈕
        makeNode(name: "button", color: .clear, x: 0, y: -575, width: 150, height: 150, z: 2, isAnchoring: false, alpha: 1)
        
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
        
        //製作按鈕
        let lightWidth:CGFloat = 170
        let lightHeight:CGFloat = 168
        let darkWidth:CGFloat = 155
        let darkHeight:CGFloat = 155
        let positions = [[-160,-360],[-260,-80],[160,-360],[260,-80],[0,110]]
        
        //選項按鈕
        
        makeNode(name: "se0", color: .clear, x:CGFloat(positions[0][0]) , y: CGFloat(positions[0][1]), width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se1", color: .clear, x:CGFloat(positions[1][0]) , y: CGFloat(positions[1][1]), width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se2", color: .clear, x:CGFloat(positions[2][0]) , y: CGFloat(positions[2][1]), width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se3", color: .clear, x:CGFloat(positions[3][0]) , y: CGFloat(positions[3][1]), width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se4", color: .clear, x:CGFloat(positions[4][0]) , y: CGFloat(positions[4][1]), width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        
        //填滿按鈕
        
        makeImageNode(name: "0filledButton", image: "lightD", x:CGFloat(positions[0][0]) , y: CGFloat(positions[0][1]), width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "1filledButton", image: "lightD", x:CGFloat(positions[1][0]), y: CGFloat(positions[1][1]), width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "2filledButton", image: "lightD", x:CGFloat(positions[2][0]) , y: CGFloat(positions[2][1]), width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "3filledButton", image: "lightD", x:CGFloat(positions[3][0]) , y: CGFloat(positions[3][1]), width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "4filledButton", image: "lightD", x:CGFloat(positions[4][0]) , y: CGFloat(positions[4][1]), width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
    
        
        //空的按鈕
        makeImageNode(name: "0emptyButton", image: "darkerD", x:CGFloat(positions[0][0]) , y: CGFloat(positions[0][1]), width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "1emptyButton", image: "darkerD", x:CGFloat(positions[1][0]) , y: CGFloat(positions[1][1]), width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "2emptyButton", image: "darkerD", x:CGFloat(positions[2][0]) , y: CGFloat(positions[2][1]), width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "3emptyButton", image: "darkerD", x:CGFloat(positions[3][0]) , y: CGFloat(positions[3][1]), width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "4emptyButton", image: "darkerD", x:CGFloat(positions[4][0]) , y: CGFloat(positions[4][1]), width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        
        //建立三黑點+亮點, 並hidden
        makeImageNode(name: "bDot1", image: "bDot1", x: -70, y: -600, width: 60, height: 30, z: 2, alpha: 0, isAnchoring: false)
        makeImageNode(name: "bDot2", image: "bDot2", x: 0, y: -600, width: 60, height: 30, z: 2, alpha: 0, isAnchoring: false)
        makeImageNode(name: "bDot3", image: "bDot3", x: 70, y: -600, width: 60, height: 30, z: 2, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "lDot1", image: "lDot1", x: -70, y: -600, width: 105, height: 70, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "lDot2", image: "lDot2", x: 0, y: -600, width: 105, height: 70, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "lDot3", image: "lDot3", x: 70, y: -600, width: 105, height: 70, z: 3, alpha: 0, isAnchoring: false)
        
        //避免多次按
        self.view?.isMultipleTouchEnabled = false
        
        
        //自我爆炸explode
        explodeEmitter = SKEmitterNode(fileNamed: "explode.sks")
        explodeEmitter?.position = CGPoint(x: 0, y: -150)
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
        let questBoardAction = SKAction.resize(toHeight: 359, duration: 0.3)
        
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
        let halfCount = wordSets.count / 4
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
    
    //元素單位練習完成
    @objc func notifyEndUnit(){
        
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
                        scanningLine.removeFromParent()
                        
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
                                
                            } else{
                                
                                //練習模式
                                self!.lightDotFunc(times: self!.correctTime)
                                
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
        //let monsterName = monsters[monsterSequence]
        
        //找目前sequence的英文+中文字
        let halfCount = wordSets.count / 2
        let monsterId = wordSets[halfCount + currentWordSequence]
        let monsterIdInt = Int(monsterId)
        var monsterName = String()
        
        for monster in monsters{
            
            if monsterIdInt == monster["id"] as! Int{
                monsterName = monster["name"] as! String
                print(monsterName)
            }
        }
        
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
        //makeImageNode(name: "monsterBlurredBg", image: "blurredBg", x: 0, y: 500, width: 750, height: 431, z: 2, alpha: 0, isAnchoring: false)
        
        // 建立怪物 width:750
        //makeImageNode(name: "monsterEffect", image: "monsterEffect", x: 0, y: 450, width: 0, height: 431, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "monster", image: monsterId, x: 0, y: -150, width: 241, height: 285, z: 1, alpha: 0, isAnchoring: false)
        
        //怪物titleBg
        makeImageNode(name: "monsterTitleBg", image: "monsterTitle", x: 0, y: 632, width: 750, height: 70, z: 4, alpha: 0, isAnchoring: false)
        
        //怪物title
        makeLabelNode(x: 0, y: 624, alignMent: .center, fontColor: tiffanyColor, fontSize: 35, text: monsterName, zPosition: 5, name: "monsterTitle", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        //怪物血Bg
        makeImageNode(name: "monsterBloodBg", image: "bloodBg", x: 0, y: 200, width: 510, height: 20, z: 4, alpha: 0, isAnchoring: false)
        //怪物血
        makeImageNode(name: "monsterBlood", image: "monsterBlood", x: -256, y: 190, width: 510, height: 20, z: 5, alpha: 0, isAnchoring: true)
        
        //player血Bg
        makeImageNode(name: "playerBloodBg", image: "bloodBg", x: 0, y: -490, width: 500, height: 20, z: 4, alpha: 0, isAnchoring: false)
        
        //player血
        makeImageNode(name: "playerBlood", image: "playerBlood", x: -273, y: -525, width: 545, height: 70, z: 5, alpha: 0, isAnchoring: true)
        
        //確認血量
        fullMonsterBlood = findImageNode(name: "monsterBlood").size.width
        fullPlayerBlood = findImageNode(name: "playerBlood").size.width
        
        
        //瞄準器
        makeImageNode(name: "aimer", image: "aimer", x: 0, y: -150, width: 477, height: 477, z: 2, alpha: 0, isAnchoring: false)
        //瞄準圈
        makeImageNode(name: "aimerCircle", image: "aimerCircle", x: 0, y: -150, width: 305, height: 287, z: 2, alpha: 0, isAnchoring: false)
        //瞄準心
        makeImageNode(name: "aimerHeart", image: "aimerHeart", x: 0, y: -150, width: 144, height: 144, z: 2, alpha: 0, isAnchoring: false)
        
        
        
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
            
            
            //瞄準器動畫
            self!.changeImageAlfa(name: "aimer", toAlpha: 1, time: 0.1)
            self!.changeImageAlfa(name: "aimerCircle", toAlpha: 1, time: 0.1)
            self!.changeImageAlfa(name: "aimerHeart", toAlpha: 1, time: 0.1)
            
            let turnLeft = SKAction.rotate(toAngle: 0.5, duration: 3)
            let turnRight = SKAction.rotate(toAngle: -0.5, duration: 4)
            
            let leftSequence = SKAction.sequence([turnLeft,turnRight])
            let leftRepeat = SKAction.repeatForever(leftSequence)
            
            let rightSequence = SKAction.sequence([turnRight,turnLeft])
            let rightRepeat = SKAction.repeatForever(rightSequence)
            
            self!.findImageNode(name: "aimer").run(leftRepeat)
            self!.findImageNode(name: "aimerCircle").run(rightRepeat)
            
            
            //開始戰鬥
            self!.battleTest()
        }
        
    }
    
    
    //放大後消失的動畫, 瞄準器使用
    func enlargeAndDisappear(name:String){
        
        let width = findImageNode(name: name).frame.width * 2
        let height = findImageNode(name: name).frame.height * 2
        let enlarge = SKAction.resize(toWidth: width, height: height, duration: 0.5)
        let alphaAction = SKAction.run {[weak self] in
            self!.changeImageAlfa(name: name, toAlpha: 0, time: 0.4)
        }
        
        let sequence = SKAction.group([enlarge,alphaAction])
        //findImageNode(name: name).run(sequence)
        
        findImageNode(name: name).run(sequence) {[weak self] in
            self!.findImageNode(name: name).removeFromParent()
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
            //self!.changeImageAlfa(name: "monsterBlurredBg", toAlpha: 1, time: 0.2)
            
            //2. 怪物後方背景
            
            //let enlarge = SKAction.resize(toWidth: 750, duration: 0.2)
            //self!.changeImageAlfa(name: "monsterEffect", toAlpha: 1, time: 0.2)
            
           // self!.findImageNode(name: "monsterEffect").run(enlarge, completion: {[weak self] in
                
                //3. 怪物出現, 然後永久上下動
                let showUp = SKAction.run({
                    self!.changeImageAlfa(name: "monster", toAlpha: 1, time: 0)
                })
                
                let up = SKAction.moveTo(y: -140, duration: 0.2)
                let down = SKAction.moveTo(y: -150, duration: 0.3)
                let wait = SKAction.wait(forDuration: 0.2)
                let upWaitDown = SKAction.sequence([up,wait,down])
                let repeatAction = SKAction.repeatForever(upWaitDown)
                let sequence = SKAction.sequence([showUp,repeatAction])
                self!.findImageNode(name: "monster").run(sequence)
                
                finished()
                
          //  })
            
        }
        
    }
    
    
    
    //啟動戰鬥功能 -> 利用測驗機制
    func battleTest(){
        
        //找目前sequence的英文+中文字
        let halfCount = wordSets.count / 4
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
        for i in 0 ..< wordSets.count / 4{
            
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
        
        //設定四格的位置
        //let positions = [[-160,-390],[-160,-190],[160,-390],[160,-190]]

        let positions = [[-160,-370],[-260,-90],[160,-370],[260,-90],[0,100]]
        
        for i in 0 ..< shownWords.count{
            
            makeLabelNode(x: CGFloat(positions[i][0]), y: CGFloat(positions[i][1]), alignMent: .center, fontColor: .white, fontSize: 60, text: shownWords[i], zPosition: 5, name: shownWords[i] + String(i) + "Sel", fontName: "Helvetica", isHidden: false, alpha: 1)
            
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
                line?.strokeColor = pinkColor
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
                            
                            //瞄準器縮小
                            if isBattleMode{
                            findImageNode(name: "aimerHeart").run(zoomIn())
                            }
                            
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
                
                //移動中遇到其它4個node
                if node.name == selNodeNames[0] || node.name == selNodeNames[1] || node.name == selNodeNames[2] || node.name == selNodeNames[3]{
                    
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
        
        //手指離開後對答案的機制
        
        //確認有按到任何選項單字才會開始偵測end動作
        if touchTimes > 0{
            

            
            if isDragAndPlayEnable {
                
                //****確認模式****
                if isBattleMode {
                    // Part 1. 戰鬥模式
                    
                    //瞄準器放大
                    findImageNode(name: "aimerHeart").run(zoomOut())
                    
                    //避免再次按
                    isUserInteractionEnabled = false
                    
                    //移除上一次的發亮按鈕
                    removeSomeNodes(name: "new")

                    
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
                    
                    //固定線
                    /*
                    line = SKShapeNode()
                    line?.strokeColor = diamondGreen
                    line?.lineWidth = 8
                    line?.name = "line"
                    line?.zPosition = 4
                    line?.glowWidth = 2
                    addChild(line!)
                    */
                    
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
                        
                        //放大後消失移除
                        enlargeAndDisappear(name: "aimer")
                        enlargeAndDisappear(name: "aimerCircle")
                        enlargeAndDisappear(name: "aimerHeart")
 
                        
                        //把temp字改顏色
                        let tempNode = findLabelNode(name: "tempWord")
                        let changeColor = SKAction.colorize(with: pinkColor, colorBlendFactor: 1, duration: 0.3)
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
                           
                                //移除上一次的線
                                self!.removeSomeNodes(name: "line")
              
                                
                            })
                            
                            
                            //等待攻擊動畫秒數後扣分
                            let when = DispatchTime.now() + 2.3
                            
                            DispatchQueue.main.asyncAfter(deadline: when, execute: {
                                
                                //假如怪沒死
                                //攻擊怪
                                //測試用, 暫時設置為9, 原本是3
                                self!.attack(point: 9, whom: monster){
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
                        
                        let when = DispatchTime.now() + 0.5
                        
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
                                
                                let when = DispatchTime.now() + 0.5
                                
                                DispatchQueue.main.asyncAfter(deadline: when, execute: {
                                    
                                    //把順序+1
                                    
                                    
                                    //if self!.currentWordSequence < self!.wordSets.count / 4 - 1{
                                    
                                    if self!.currentWordSequence < (self!.unitNumber + 1) * 3 - 1{
                                        
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
                                        //
                                        //self!.currentWordSequence = 0
                                        
                                        self!.currentWordSequence  = self!.unitNumber * 3
                                        
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
    
    
    func zoomIn() -> SKAction{
        
        let zoomIn = SKAction.resize(toWidth: 100, height: 100, duration: 0.1)
        return zoomIn
    }
    func zoomOut() -> SKAction{
        
        let zoomOut = SKAction.resize(toWidth: 144, height: 144, duration: 0.2)
        return zoomOut
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
        let point1 = CGPoint(x: 20, y: -140)
        let point2 = CGPoint(x: 0, y: -150)
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
        makeImageNode(name: "pinkAttEff", image: "attack4", x: 20, y: -150, width: 159, height: 137, z: 6, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "darkAttEff", image: "attack1", x: -10, y: -210, width: 111 * 0.5, height: 92 * 0.5, z: 6, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "attEff", image: "attack3", x: 80, y: -190, width: 70, height: 70, z: 7, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "attEff2", image: "attack5", x: -70, y: -250, width: 40, height: 40, z: 6, alpha: 0, isAnchoring: false)
        makeImageNode(name: "attEff3", image: "attack5", x: -50, y: -230, width: 60, height: 66, z: 6, alpha: 0, isAnchoring: false)
        makeImageNode(name: "attEff4", image: "attack5", x: 40, y: -220, width: 15, height: 15, z: 6, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "attEff5", image: "attack3", x: -100, y: -145, width: 120, height: 120, z: 6, alpha: 0, isAnchoring: false)
        
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
        makeImageNode(name: "solidAttEff", image: "attack5", x: -40, y: -180, width: 80, height: 88, z: 6, alpha: 0, isAnchoring: false)
        
        //出現+變大+消失 0.17秒
        let appear2 = SKAction.fadeIn(withDuration: 0.05)
        let enlarge = SKAction.resize(toWidth: 130, height: 130, duration: 0.02)
        let fadeOut2 = SKAction.fadeOut(withDuration: 0.1)
        let backToSize = SKAction.resize(toWidth: 65, height: 65, duration: 0)
        let sequence2 = SKAction.sequence([appear2,enlarge,fadeOut2,backToSize])
        
        //等待出現後旋轉 + 改變兩個位置來攻擊 1秒
        let pos = CGPoint(x: 40, y: -155)
        let pos2 = CGPoint(x: -20, y: -255)
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
        let point1 = CGPoint(x: 20, y: -140)
        let point2 = CGPoint(x: 0, y: -150)
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
        
        let point1 = CGPoint(x: 20, y: -140)
        let point2 = CGPoint(x: 0, y: -150)
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
        
        //更改怪物出現次序
        /*
        if monsterSequence < monsters.count - 1 {
            monsterSequence += 1
        } else {
            monsterSequence = 0
        }
        */
        //初始化
        shownWords.removeAll(keepingCapacity: false)
        wordEntered.removeAll(keepingCapacity: false)
        battleComboTime = 0
        
        //移除畫面
        removeSomeNodes(name: "monster")
        removeSomeNodes(name: "player")
        removeSomeNodes(name: "Frame")
        removeSomeNodes(name: "tempWord")
        
        //更改單字次序
        
        //if currentWordSequence < wordSets.count / 4 - 1{
        
        if currentWordSequence < (unitNumber + 1) * 3 - 1{
            
            currentWordSequence += 1
            
            
            //開始戰鬥, 建立下一個單字
            battleMode()
            
        }  else {
            print("Session End")
            
            //currentWordSequence = 0
            //currentWordSequence = unitNumber * 3
            
            //取得元素

 
            
            //取得User資料, 比對元素,
            
            if let getElements = user?["getElement"] as? String{
                
                print("has data")
               
                if getElements.contains(syllablesToCheck){
                    
                    //有得到過, 暫時先跳回
                    
                    //跳轉回元素表
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "endUnit"), object: nil, userInfo: nil)
                    
                    //移除node及動畫
                    removeEverything()

                    
                } else {
                    //得到元素
                    
                    //指定得到元素及使用者id
                    let element = syllablesToCheck
                    let id = user?["id"] as! String
                    
                    
                    // url to access our php file
                    let url = URL(string: "http://ec2-52-199-122-149.ap-northeast-1.compute.amazonaws.com/wordDrug/getElement.php")!
                    
                    // request url
                    var request = URLRequest(url: url)
                    
                    // method to pass data POST - cause it is secured
                    request.httpMethod = "POST"
                    
                    // body gonna be appended to url
                    let body = "userID=\(id)&element=\(element)"
                    
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
                                    print(user!)
                                    
                                    //跳轉回元素表
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "endUnit"), object: nil, userInfo: nil)
                                   
                                    //移除node及動畫
                                    self!.removeEverything()
                                    
                                } catch{
                                    
                                    print("catch error")
                                    
                                    
                                    
                                }
                            } else {
                                
                                print("urlsession has error")
                                
                            }
                        }).resume()


                    
                    
                    
                    /* // 動畫部分要重做
                    
                    makeImageNode(name: "getElemntBg1", image: "getElementBg1", x: 0, y: 0, width: 750, height: 1334, z: 10, alpha: 1, isAnchoring: false)
                    makeImageNode(name: "getElementBg2", image: "getElementBg2", x: 0, y: 0, width: 750, height: 1334, z: 11, alpha: 1, isAnchoring: false)
                    makeImageNode(name: "getElement", image: "getElement", x: 0, y: -20, width: 280, height: 280, z: 12, alpha: 1, isAnchoring: false)
                    makeLabelNode(x: 0, y: -35, alignMent: .center, fontColor: darkYellow, fontSize: 50, text: syllablesWithoutDigit, zPosition: 13, name: "syllableWithoutDigit", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
                    */

                    
                    
                    
                }
                
            }
            
        }

        
    }
    
    
    func removeEverything(){
        
        self.removeAllActions()
        self.removeAllChildren()
        
        
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
            makeLabelNode(x: 0, y: 380, alignMent: .center, fontColor: .white, fontSize: 100, text: word, zPosition: 3, name: "tempWord", fontName: "Helvetica", isHidden: false, alpha: 1)
            
            
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
        
        
        //按鈕發亮, 要設置為0秒完成, 否則會異常
        let buttonName =  String(poisonNumber) + "filledButton"
        changeImageAlfa(name: buttonName, toAlpha: 1, time: 0)
        
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
        
        //首先設定不是_e
        isSpecialE = false
        
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
            posY = 270
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
            posY = 380
            fontSize = 100
            
            //加一個順序
            nextWordSequence += 1
            
            //還原該單字
            wordsToPronounce = word.replacingOccurrences(of: " ", with: "")
            
            //產生提示
            let hintY = findImageNode(name: "questBoard").frame.minY
            
            //戰鬥模式就不做這個hint了
            if isBattleMode == false{
                makeLabelNode(x: 0, y: hintY + 10, alignMent: .center, fontColor: .white, fontSize: 30, text: "[ 請按畫面聽讀單字 ]", zPosition: 2, name: "hint" , fontName: "Helvetica Light", isHidden: false, alpha: 1)
            }
            
            //抓音節數
            let sepCount = sepWords.count
            
            //抓部首
            syllablesToCheck = syllables[unitNumber]
            
            //去掉數字
            syllablesWithoutDigit = (syllablesToCheck.components(separatedBy: NSCharacterSet.decimalDigits) as NSArray).componentsJoined(by: "")
            
            //提供給_e部首字的sepWord使用
            var newSepWords = [["1"],["1"],["1"],["1"],["1"]]
            
            //確認新增順序
            var sequenceToAppend = -1
            var specialSyllable = Int()
            
            //在此先拆每個單字的字母來看是否有三個字母並且符合 _e規則的音節
            
            for i in 0 ..< sepCount{
                
                //先清空字母array
                characters.removeAll(keepingCapacity: false)
                
                let sepWord = sepWords[i]
                
                //直接拆單字字母變成character, 填入array裡面
                for i in sepWord{
                    characters.append(i)
                    
                }
                
                //確認是否是_e的部首, 有的話就做新字
                if syllablesWithoutDigit.contains("_e"){
                    
                    //確認是_e部首
                    isSpecialE = true
                    
                    //(1)有任何字節是三個字母
                    if characters.count == 3 {
                        
                        //(2)第一個字母是母音
                        if vowels.contains(String(characters[0])){
                            
                            
                            //(3)第三個字母是e
                            if characters[2] == "e"{
                                
                                //***符合: _e 部首
                                
                                //要開始填入的順序+1
                                sequenceToAppend += 1
                                
                                //設定此順序為部首字的特別順序
                                specialSyllable = sequenceToAppend
                                
                                
                                //假如這個array位置的第一個字是1, 就移除
                                if newSepWords[sequenceToAppend][0] == "1"{
                                    
                                    newSepWords[sequenceToAppend].removeFirst()
                                    
                                }
                                
                                //建立三個字母進去
                                for i in 0 ..< 3 {
                                    newSepWords[sequenceToAppend].append(String(characters[i]))
                                }
                                
                                
                            } else {
                                
                                //最後一個字母不是e
                                
                                sequenceToAppend += 1
                                if newSepWords[sequenceToAppend][0] == "1"{
                                    newSepWords[sequenceToAppend].removeFirst()
                                }
                                newSepWords[sequenceToAppend].append(sepWord)
                                
                            }
                            
                        }  else {
                            
                            //第一個字母不是母音
                            sequenceToAppend += 1
                            if newSepWords[sequenceToAppend][0] == "1"{
                                newSepWords[sequenceToAppend].removeFirst()
                            }
                            newSepWords[sequenceToAppend].append(sepWord)
                            
                            
                        }
                    } else {
                        
                        //沒有三個字母
                        sequenceToAppend += 1
                        if newSepWords[sequenceToAppend][0] == "1" {
                            newSepWords[sequenceToAppend].removeFirst()
                        }
                        newSepWords[sequenceToAppend].append(sepWord)
                        
                        
                    }
                    
                }
                
            }
            
            
            
            //===========以下為做字功能, 分成兩部分===============
            
            //Part 1. 有三字母部首的話
            if isSpecialE{
                
                //***在此做_e單字
                
                //跑所有字節
                for i in 0 ..< newSepWords.count{
                    
                    //用不到的字節就不做字
                    if newSepWords[i][0] != "1"{
                        
                        //***有append字母的才來做單字
                        
                        //Part 1. 假如是_e部首
                        if i == specialSyllable {
                            
                            
                            var fontColor = UIColor()
                            
                            //裡面的每一個字母
                            for s in 0 ..< newSepWords[i].count{
                                
                                //抓每個字
                                let sepWord = newSepWords[i][s]
                                
                                //指定名字
                                syllableWordName = sepWord +  String(s) + lang
                                
                                //做1,3音節顏色
                                switch s{
                                case 0:
                                    fontColor = .red
                                case 1:
                                    fontColor = .white
                                case 2:
                                    fontColor = .red
                                    
                                default:
                                    break
                                }
                                
                                //做字
                                if s > 0 {
                                    
                                    //非第一組字
                                    if let leftNode = childNode(withName: newSepWords[i][s - 1] + String(s - 1) + lang) as? SKLabelNode{
                                        
                                        let nextX = CGFloat(leftNode.frame.origin.x + leftNode.frame.width + 4)
                                        
                                        makeLabelNode(x: nextX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: syllableWordName, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                                    }
                                    
                                } else{
                                    
                                    //若是第一個字母
                                    
                                    //如果不是第一個字節
                                    if i != 0 {
                                        
                                        //位置要抓前一非部首的音節位置
                                        
                                        if let leftNode = childNode(withName: normalSyllableName) as? SKLabelNode{
                                            
                                            let nextX = CGFloat(leftNode.frame.origin.x + leftNode.frame.width + 4)
                                            
                                            makeLabelNode(x: nextX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: syllableWordName, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                                            
                                        }
                                        
                                    } else {
                                        
                                        //若是第一個字節, 直接製作
                                        makeLabelNode(x: posX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: syllableWordName, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                                        
                                        
                                        
                                    }
                                    
                                    
                                }
                                
                            }
                            
                        }  else {
                            
                            //若不是部首字
                            let sepWord = newSepWords[i][0]
                            
                            //取名字
                            normalSyllableName = sepWord + String(i) + lang
                            
                            //非元素字顏色
                            let fontColor = UIColor.white
                            
                            if i > 0 {
                                
                                //非第一組字, 要抓上一個字的結尾位置
                                
                                //先確認前個字是否接部首字
                                if i - 1 == specialSyllable{
                                    
                                    //是的話就抓部首字位置
                                    if let leftNode = childNode(withName: syllableWordName) as? SKLabelNode{
                                        let nextX = CGFloat(leftNode.frame.origin.x + leftNode.frame.width + 4)
                                        
                                        makeLabelNode(x: nextX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: normalSyllableName, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                                    }
                                    
                                } else {
                                    //不是的話抓上一個一般字的位置
                                    if let leftNode = childNode(withName: sepWords[i - 1] + String(i - 1) + lang) as? SKLabelNode{
                                        
                                        let nextX = CGFloat(leftNode.frame.origin.x + leftNode.frame.width + 4)
                                        
                                        makeLabelNode(x: nextX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: normalSyllableName, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                                        
                                    }
                                    
                                    
                                    
                                }
                                
                                
                                
                            } else{
                                
                                //第一組字
                                makeLabelNode(x: posX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: normalSyllableName, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                                
                            }
                            
                        }
                    }
                }
                
            } else {
                
                
                // Part 2. 不是_e, 就在這裡做單字
                
                
                //一個單字以處理成array之後建立每一個array的value
                for i in 0 ..< sepCount{
                    
                    let sepWord = sepWords[i]
                    
                    //檢查有沒有元素的字節, 有的話顯示為黃色
                    if syllablesWithoutDigit.contains(sepWord){
                        
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
                            
                            
                            //非第一組字
                            if let leftNode = childNode(withName: sepWords[i - 1] + String(i - 1) + lang) as? SKLabelNode{
                                
                                let nextX = CGFloat(leftNode.frame.origin.x + leftNode.frame.width + 4)
                                
                                makeLabelNode(x: nextX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: sepWord + String(i) + lang, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                                
                            }
                            
                        } else{
                            
                            
                            //第一組字
                            makeLabelNode(x: posX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: sepWord + String(i) + lang, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                            
                        }
                        
                        
                        
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
        if let nodeFound = childNode(withName: name) as? SKSpriteNode{
            node = nodeFound
        }
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
        
        if playSoundTime == 2 {
            //直接開啟練習
            //只開啟一次
            playSoundTime = 0
            
            //封鎖按鍵
            isUserInteractionEnabled = false
            
            dotSparkingFunc()
            
            let when = DispatchTime.now() + 0.5
            
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
        
        let sparkling1 = SKAction.fadeAlpha(to: 0, duration: 0.1)
        let sparkling2 = SKAction.fadeAlpha(to: 1, duration: 0.1)
        let sequence = SKAction.sequence([sparkling1,sparkling2])
        let repeatAction = SKAction.repeat(sequence, count: 2)
        
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

