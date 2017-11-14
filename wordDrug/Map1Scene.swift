//
//  mapTestScene.swift
//  wordDrug
//
//  Created by Ethan on 2017/11/8.
//  Copyright © 2017年 playplay. All rights reserved.
//

import SpriteKit
import GameplayKit

class Map1Scene: SKScene {
    
    //node按鈕位置
    var location = CGPoint()
    
    //特別顏色
    let specialCyan = UIColor.init(red: 9/255, green: 255/255, blue: 218/255, alpha: 1)

    //探索點
    var spots = [String]()
    var selectedSpotNumber = Int()
    
    override func didMove(to view: SKView) {
  
        //跳進元素表NC
        NotificationCenter.default.addObserver(self, selector: #selector(Map1Scene.notifyJumpToElement), name: NSNotification.Name("jumpToElement"), object: nil)
        
        //做地圖
        makeImageNode(name: "map1", image: "map1", x: 0, y: 0, width: 750, height: 1334, z: 0, alpha: 1, isAnchoring: false)
        
        //滑鼠游標
        makeImageNode(name: "open", image: "scanning", x: location.x, y: location.y, width: 200, height: 200, z: 1, alpha: 0, isAnchoring: false)

        //做點點
        makeImageNode(name: "lSpot0", image: "lightBlueSpot", x: -100, y: 100, width: 120, height: 120, z: 2, alpha: 1, isAnchoring: false)
        makeImageNode(name: "lSpot1", image: "lightYellowSpot", x: 250, y: 200, width: 120, height: 120, z: 2, alpha: 1, isAnchoring: false)
        makeImageNode(name: "lSpot2", image: "lightPinkSpot", x: 260, y: -300, width: 120, height: 120, z: 2, alpha: 1, isAnchoring: false)
        makeImageNode(name: "lSpot3", image: "lightBlueSpot", x: -20, y: 170, width: 120, height: 120, z: 2, alpha: 1, isAnchoring: false)
        makeImageNode(name: "lSpot4", image: "lightYellowSpot", x: -250, y: 30, width: 120, height: 120, z: 2, alpha: 1, isAnchoring: false)
        makeImageNode(name: "lSpot5", image: "lightPinkSpot", x: -80, y: -400, width: 120, height: 120, z: 2, alpha: 1, isAnchoring: false)
        makeImageNode(name: "lSpot6", image: "lightBlueSpot", x: -140, y: -175, width: 120, height: 120, z: 2, alpha: 1, isAnchoring: false)
        makeImageNode(name: "lSpot7", image: "lightYellowSpot", x: 340, y: -300, width: 120, height: 120, z: 2, alpha: 1, isAnchoring: false)
        makeImageNode(name: "lSpot8", image: "lightPinkSpot", x: 0, y: -300, width: 120, height: 120, z: 2, alpha: 1, isAnchoring: false)
        makeImageNode(name: "lSpot9", image: "lightBlueSpot", x: -10, y: -370, width: 120, height: 120, z: 2, alpha: 1, isAnchoring: false)
        makeImageNode(name: "lSpot10", image: "lightYellowSpot", x: 120, y: 200, width: 120, height: 120, z: 2, alpha: 1, isAnchoring: false)
        makeImageNode(name: "lSpot11", image: "lightPinkSpot", x: -130, y: -30, width: 120, height: 120, z: 2, alpha: 1, isAnchoring: false)
        makeImageNode(name: "lSpot12", image: "lightBlueSpot", x: -100, y: 10, width: 120, height: 120, z: 2, alpha: 1, isAnchoring: false)
        makeImageNode(name: "lSpot13", image: "lightYellowSpot", x: 60, y: 155, width: 120, height: 120, z: 2, alpha: 1, isAnchoring: false)

        //抓所有名字
        for node in children{
            if (node.name?.contains("lSpot"))!{
                spots.append(node.name!)
            }
        }

        //製作對話
        makeImageNode(name: "dialogue", image: "dialogue", x: 0, y: 400, width: 370, height: 0, z: 3, alpha: 0, isAnchoring: false)
        
        //製作按鍵
        makeImageNode(name: "enterButton", image: "enterButton", x: 0, y: 330, width: 120, height: 55, z: 4, alpha: 0, isAnchoring: false)
        
        //製作title
        makeLabelNode(x: 0, y: 470, alignMent: .center, fontColor: specialCyan, fontSize: 40, text: "發現探索點", zPosition: 4, name: "title", fontName: "Helvetica", isHidden: false, alpha: 0)
        
        //製作對話框裡探索點號碼
        makeLabelNode(x: 0, y: 420, alignMent: .center, fontColor: specialCyan, fontSize: 40, text: "", zPosition: 4, name: "spotNumber", fontName: "Helvetica", isHidden: false, alpha: 0)
    
        //做底部欄位
        makeImageNode(name: "elementBottom", image: "elementBottom", x: 0, y: -618, width: 752, height: 110, z: 1, alpha: 1, isAnchoring: false)
        
        //做元素按鈕
        makeImageNode(name: "diamond", image: "diamond", x: 0, y: -580, width: 180, height: 180, z: 2, alpha: 1, isAnchoring: false)
        
    }
    

    @objc func notifyJumpToElement(){
   
    }
    
    //探索游標出現
    func mouseAppearAction() -> SKAction {
        let englarge = SKAction.resize(toWidth: 278, height: 278, duration: 0.1)
        let rotateLeft = SKAction.rotate(toAngle: 1, duration: 1)
        let rotateRight = SKAction.rotate(toAngle: 0, duration: 1)
        let sequence = SKAction.sequence([rotateLeft,rotateRight])
        let repeatAction = SKAction.repeatForever(sequence)
        let finalAction = SKAction.sequence([englarge,repeatAction])
        return finalAction

    }
    
    //探索游標消失
    func mouseDisappearAction() -> SKAction {
        
        let changeToSmallSize = SKAction.resize(toWidth: 200, height: 200, duration: 0.1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.05)
        let sequence = SKAction.sequence([changeToSmallSize,fadeOut])
        
        return sequence
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //對話框裡所有內容消失
        let changeToSmall = SKAction.resize(toHeight: 0, duration: 0)
        findImageNode(name: "dialogue").run(changeToSmall)
        changeImageAlfa(name: "dialogue", toAlpha: 0, time: 0)
        changeImageAlfa(name: "enterButton", toAlpha: 0, time: 0)
        changeLabelAlfa(name: "title", toAlpha: 0, time: 0)
        findLabelNode(name: "spotNumber").text = ""
        changeLabelAlfa(name: "spotNumber", toAlpha: 0, time: 0)
        
        for touch in touches {
            
            location = touch.location(in: self)
            
            let node : SKNode = self.atPoint(location)
            
            //除了enterButton之外其餘畫面, 都要出現滑鼠游標
            if node.name != "enterButton"{
                
            //滑鼠游標出現
            changeImageAlfa(name: "open", toAlpha: 1, time: 0.05)
            let mouseNode = findImageNode(name: "open")
            let pos = CGPoint(x: location.x, y: location.y)
            let changePos = SKAction.move(to: pos, duration: 0)
            mouseNode.run(changePos)
            mouseNode.run(mouseAppearAction())
                
            }
            
            
            //假如碰到點點, 打開對話窗, 並且顯示所選擇的探索點
            for i in 0 ..< spots.count{
                if node.name == spots[i] {
                    openDialogue(spotNumber: i)
                }
            }
            
            
            //按到enter就傳送nc以及探索點給scene
            if node.name == "enterButton"{
                
                let spotSelected:[String:Int] = ["spotNumber":selectedSpotNumber]
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "jumpToElement"), object: nil, userInfo: spotSelected)
                
            }
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        
        for touch in touches {
            
            location = touch.location(in: self)
            
            let node : SKNode = self.atPoint(location)
            
            //滑鼠跟著移動
            let pos = CGPoint(x: location.x, y: location.y)
            let changePos = SKAction.move(to: pos, duration: 0)
            findImageNode(name: "open").run(changePos)

            //假如碰到點點
            for i in 0 ..< spots.count{
                if node.name == spots[i] {
                    
                    //打開對話框, 並顯示探索點號碼
                    openDialogue(spotNumber: i)
                }
            }
        }
    }
    
    
    //打開對話框
    func openDialogue(spotNumber:Int){
        
        //展開對話框的動畫
        changeImageAlfa(name: "dialogue", toAlpha: 1, time: 0)
        let enlarge = SKAction.resize(toHeight: 280, duration: 0.05)
     
        
        findImageNode(name: "dialogue").run(enlarge) {[weak self] in
            self!.changeImageAlfa(name: "enterButton", toAlpha: 1, time: 0)
            self!.changeLabelAlfa(name: "title", toAlpha: 1, time: 0)
            self!.findLabelNode(name: "spotNumber").text = "[ " + String(spotNumber + 1) + " ]"
            self!.changeLabelAlfa(name: "spotNumber", toAlpha: 1, time: 0)
        }

        //設定探索點號碼
        selectedSpotNumber = spotNumber
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            location = touch.location(in: self)
            
            let node : SKNode = self.atPoint(location)
   
            //滑鼠消失及移除動畫
            let mouseNode = findImageNode(name: "open")
            mouseNode.run(mouseDisappearAction(), completion: {
                mouseNode.removeAllActions()
            })
        }
    }
    
    override func update(_ currentTime: TimeInterval) {

    
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
    //閃亮動畫
    func flashFunc(name:String,time:TimeInterval){
        
        let fadeOut = SKAction.fadeOut(withDuration: time)
        let fadeIn = SKAction.fadeIn(withDuration: time)
        let sequence = SKAction.sequence([fadeOut,fadeIn])
        let repeatAction = SKAction.repeatForever(sequence)
        
        if let node = childNode(withName: name) as? SKSpriteNode{
            node.run(repeatAction)
            
        }
    }
}

