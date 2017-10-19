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
    
    //暫時使用的單字
    var wordSets = [String]()
    
    
    
    override func didMove(to view: SKView) {
        
        //整個背景
        makeImageNode(name: "bg", image: "bg", x: 0, y: 0, width: 750, height: 1334, z: 0, alpha: 1, isAnchoring: false)
        //任務版子
        makeImageNode(name: "questBoard", image: "questBoard", x: 0, y: 0, width: 700, height: 0, z: 1, alpha: 1, isAnchoring: false)
        
        //建立任務標題
        makeLabelNode(x: -100, y:220, alignMent: .left, fontColor: .yellow, fontSize: 50, text: "", zPosition: 2, name: "questTitle", fontName: "Helvetica Bold", isHidden: false, alpha:1)
        
        //任務板子動畫 + 標題動畫
        let questBoardAction = SKAction.resize(toHeight: 550, duration: 0.5)
        findImageNode(name: "questBoard").run(questBoardAction) {[weak self] in
            let action = self!.typingAction(text: "QUEST", nodeName: "questTitle")
            self!.run(action)
        }
        
        
        //怪物畫面背景
        makeImageNode(name: "monsterBg", image: "monsterBg", x: 0, y: 500, width: 750, height: 431, z: 1, alpha: 1, isAnchoring: false)
        
    
       //讀取Bundle裡的文字檔
        var wordFile:String?
        
        if let filepath = Bundle.main.path(forResource: "ca2", ofType: "txt") {
            do {
                wordFile = try String(contentsOfFile: filepath)
                let words = wordFile?.components(separatedBy: ", ")
                
                //把字讀取到wordSets裡
                wordSets = words!
               
                
                //print(contents)
            } catch {
                // contents could not be loaded
            }
        } else {
            // example.txt not found!
        }
        
        //找第一組英文+中文字
        let halfCount = wordSets.count / 2
        let firstEngWord = wordSets[0]
        let firstChiWord = wordSets[halfCount]
        

    }
    
    
    //回傳SKLabelNode閃爍指令的func
    func typingAction(text:String, nodeName:String) -> SKAction{
        
        //閃爍指令
        let questText = text
        var questTextArray = questText.characters.map { String($0) }
        questTextArray.append("_")
        var i = 0
        
        
        let wait = SKAction.wait(forDuration: 0.2)
        
        let typingAction = SKAction.run {[weak self] in
            
            self?.findLabelNode(name: nodeName).text = (self?.findLabelNode(name: nodeName).text!)! + questTextArray[i]
            
            i += 1
            
        }
        
        
        let sequence = SKAction.sequence([wait,typingAction])
        let repeatAction = SKAction.repeat(sequence, count: questTextArray.count)
        let sparklingAction1 = SKAction.run {[weak self] in
            
            self?.findLabelNode(name: nodeName).text = questText + "_"
            
            
        }
        let sparklingAction2 = SKAction.run {[weak self] in
            self?.findLabelNode(name: nodeName).text = questText
        }
        
        let sparklingSequence = SKAction.sequence([sparklingAction1,wait,sparklingAction2,wait])
        let repeatSparklingAction = SKAction.repeat(sparklingSequence, count: 4)
        
        
        let allSparklingAction = SKAction.sequence([repeatAction,repeatSparklingAction])
        
        
        return allSparklingAction
        
        
    }
    
    
    //建立音節單字的func
    func makeWords(word:String, lang:String){
        
        //設定x及y的位置
        var xPos = CGFloat()
        var yPos = CGFloat()
        
        //分音節
        var sepWord = word
        /*
        switch lang {
        case "engWord":
            
            
        case "chiWord":
            
        default:
            break
        }
        */
        
        
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
    
    
}
