//
//  GameViewController.swift
//  wordDrug
//
//  Created by Ethan on 2017/10/18.
//  Copyright © 2017年 playplay. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

//此元素三個單字練習完後結束的key
let endUnitKey = "endUnit"
//跳回背包畫面的Key
let backToBackpackKey = "backToBackpack"


class GameViewController: UIViewController {
    
    var spotNumber = Int()
    var unitNumber = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("gameReceivedSpot:\(spotNumber)")
        print("gameReceivedUnit:\(unitNumber)")
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.jumpBackToElement), name: NSNotification.Name("endUnit"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.backToBackpack), name: NSNotification.Name("backToBackpack"), object: nil)
      
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                sceneNode.unitNumber = unitNumber
                sceneNode.spotNumber = spotNumber
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }


    override var shouldAutorotate: Bool {
        return true
    }
    
    
    @objc func jumpBackToElement(){
        
        
        //dimiss掉兩個VCs
   self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)

    }
    

    //跳回背包畫面的NC
    @objc func backToBackpack(_ notification: NSNotification){
        
        //抓四個數值, 回傳給前一個Vc
        if let page = notification.userInfo?["page"] as? Int{
            if let seg = notification.userInfo?["seg"] as? Int{
                if let typeSeg = notification.userInfo?["typeSeg"] as? Int{
                    if let elem = notification.userInfo?["elem"] as? String{
                    
                    
                        //回傳給前一個Vc, 並在Vc裡viewWillAppear產生作用
                    if let presenter = presentingViewController as? PetViewController {
                        presenter.defaultPage = page
                        presenter.defaultSeg = seg
                        presenter.defaultTypeSeg = typeSeg
                        presenter.isBackpackFull = true
                        presenter.isElemAttachable = false
                        presenter.defaultElemToGet = elem
                        
                    }
                    }
                }
            }
        }
        
        

        
        self.dismiss(animated: false, completion: nil)
        

    }
    

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
