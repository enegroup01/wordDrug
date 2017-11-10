//
//  Map1ViewController.swift
//  wordDrug
//
//  Created by Ethan on 2017/11/8.
//  Copyright © 2017年 playplay. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class Map1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        NotificationCenter.default.addObserver(self, selector: #selector(Map1ViewController.jumpToGame), name: NSNotification.Name("jumpToGame"), object: nil)
        

        
        // Do any additional setup after loading the view.
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "Map1Scene") {
            
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! Map1Scene? {
                
                // Copy gameplay related content over to the scene
                
                
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
    
    
    
    @objc func jumpToGame(_ notification: NSNotification){
        
        
        if let number = notification.userInfo?["spotNumber"] as? Int {
            print("number:\(number)")
        }
        
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
