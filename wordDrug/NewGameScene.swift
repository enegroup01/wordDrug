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
    
    let lightGreen = UIColor.init(red: 196/255, green: 255/255, blue: 137/255, alpha: 1)
    let darkWordColor = UIColor.init(red: 104/255, green: 129/255, blue: 130/255, alpha: 1)
    
    //中文字左右對錯
    var leftOrRight = Int()
    let leftChiNode = SKLabelNode()
    let rightChiNode = SKLabelNode()
    
    //目前單字的順位
    var currentWordSequence = 0
    
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
    var firstWordLabel = UILabel()
    var secondWordLabel = UILabel()
    var thirdWordLabel = UILabel()
    
    var firstChiWordLabel = UILabel()
    var secondChiWordLabel = UILabel()
    var thirdChiWordLabel = UILabel()

    
    

    
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
    
    func setUpScreen(){
   
        //背景
        makeImageNode(name: "gameBg", image: "newGameBg", x: 0, y: 0, width: 754, height: 1334, z: 0, alpha: 1, isAnchoring: false)
    
        //單字元素
        makeImageNode(name: "elementToShow", image: "elemExample", x: -290, y: 590, width: 80, height: 80, z: 1, alpha: 1, isAnchoring: false)
    
        //單字等級label
        makeLabelNode(x: 0, y: 600, alignMent: .center, fontColor: lightGreen, fontSize: 40, text: "英檢初級", zPosition: 1, name: "levelTitle", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
    
        //單字量Label
        makeLabelNode(x: 0, y: 550, alignMent: .center, fontColor: .lightGray, fontSize: 30, text: "175/2100", zPosition: 1, name: "wordAmount", fontName: "Helvetica Neue", isHidden: false, alpha: 1)
        
        //得分Label
        makeLabelNode(x: 330, y: 555, alignMent: .right, fontColor: .white, fontSize: 40, text: "13750", zPosition: 1, name: "score", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        
        //三個點點
        makeImageNode(name: "whiteDot0", image: "whiteDot", x: -300, y: 450, width: 20, height: 20, z: 1, alpha: 1, isAnchoring: false)
        makeImageNode(name: "whiteDot1", image: "whiteDot", x: -300, y: 300, width: 20, height: 20, z: 1, alpha: 1, isAnchoring: false)
        makeImageNode(name: "whiteDot2", image: "whiteDot", x: -300, y: 150, width: 20, height: 20, z: 1, alpha: 1, isAnchoring: false)
        
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
        leftChiNode.position = CGPoint(x: 0, y: -10)
        leftChiNode.horizontalAlignmentMode = .center
        leftChiNode.fontSize = 60
        leftChiNode.fontColor = .white
        leftChiNode.zPosition = 8
        leftChiNode.name = "leftChi"
        leftChiNode.fontName = "Helvetica Bold"
        
        findImageNode(name: "leftChiBtn").addChild(leftChiNode)
        
        
        rightChiNode.position = CGPoint(x: 0, y: -10)
        rightChiNode.horizontalAlignmentMode = .center
        rightChiNode.fontSize = 60
        rightChiNode.fontColor = .white
        rightChiNode.zPosition = 8
        rightChiNode.name = "rightChi"
        rightChiNode.fontName = "Helvetica Bold"

        
        findImageNode(name: "rightChiBtn").addChild(rightChiNode)

        
        //建立三個單字
        
        firstWordLabel.frame = CGRect(x: 60, y: 85, width: 200, height: 40)
        //firstWordLabel.backgroundColor = .cyan
        firstWordLabel.textColor = darkWordColor
        firstWordLabel.textAlignment = .left
        firstWordLabel.adjustsFontSizeToFitWidth = true
        firstWordLabel.font = UIFont(name: "Helvetica Bold", size: 30)
        firstWordLabel.text = "california"
        self.view?.addSubview(firstWordLabel)
        
        secondWordLabel.frame = CGRect(x: 60, y: 160, width: 200, height: 40)

        secondWordLabel.textColor = darkWordColor
        secondWordLabel.textAlignment = .left
        secondWordLabel.adjustsFontSizeToFitWidth = true
        secondWordLabel.font = UIFont(name: "Helvetica Bold", size: 30)
        secondWordLabel.text = "regret"
        self.view?.addSubview(secondWordLabel)
        
        thirdWordLabel.frame = CGRect(x: 60, y: 235, width: 200, height: 40)

        thirdWordLabel.textColor = darkWordColor
        thirdWordLabel.textAlignment = .left
        thirdWordLabel.adjustsFontSizeToFitWidth = true
        thirdWordLabel.font = UIFont(name: "Helvetica Bold", size: 30)
        thirdWordLabel.text = "congratulations"
        self.view?.addSubview(thirdWordLabel)
        
        //建立三個單字
        firstChiWordLabel.frame = CGRect(x: 270, y: 85, width: 90, height: 40)
        //firstChiWordLabel.backgroundColor = .green
        firstChiWordLabel.textColor = darkWordColor
        firstChiWordLabel.textAlignment = .right
        firstChiWordLabel.adjustsFontSizeToFitWidth = true
        firstChiWordLabel.font = UIFont(name: "Helvetica Neue", size: 20)
        firstChiWordLabel.text = "加利福尼亞"
        self.view?.addSubview(firstChiWordLabel)
        
        secondChiWordLabel.frame = CGRect(x: 270, y: 160, width: 90, height: 40)
        //firstChiWordLabel.backgroundColor = .green
        secondChiWordLabel.textColor = darkWordColor
        secondChiWordLabel.textAlignment = .right
        secondChiWordLabel.adjustsFontSizeToFitWidth = true
        secondChiWordLabel.font = UIFont(name: "Helvetica Neue", size: 20)
        secondChiWordLabel.text = "遺憾"
        self.view?.addSubview(secondChiWordLabel)
        
        thirdChiWordLabel.frame = CGRect(x: 270, y: 235, width: 90, height: 40)
        //firstChiWordLabel.backgroundColor = .green
        thirdChiWordLabel.textColor = darkWordColor
        thirdChiWordLabel.textAlignment = .right
        thirdChiWordLabel.adjustsFontSizeToFitWidth = true
        thirdChiWordLabel.font = UIFont(name: "Helvetica Neue", size: 20)
        thirdChiWordLabel.text = "恭喜"
        self.view?.addSubview(thirdChiWordLabel)
        
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

    
}
