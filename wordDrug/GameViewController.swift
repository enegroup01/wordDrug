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


class GameViewController: UIViewController {
    
    var spotNumber = Int()
    var unitNumber = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("gameReceivedSpot:\(spotNumber)")
        print("gameReceivedUnit:\(unitNumber)")
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.jumpBackToElement), name: NSNotification.Name("endUnit"), object: nil)
        
        
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
        
        /*
        let elementVc = storyboard?.instantiateViewController(withIdentifier: "elementVc")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = elementVc!
        */
        self.dismiss(animated: true, completion: nil)
        
        
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
