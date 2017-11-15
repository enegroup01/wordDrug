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

//跳進元素
let jumpToGameKey = "jumpToElement"
let jumpToBookKey = "jumpToBook"

class Map1ViewController: UIViewController {

    //抓探索點號碼
    var spotNumber = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //跳進元素NC
        NotificationCenter.default.addObserver(self, selector: #selector(Map1ViewController.jumpToElement), name: NSNotification.Name("jumpToElement"), object: nil)
        
        //跳進書裡
                NotificationCenter.default.addObserver(self, selector: #selector(Map1ViewController.jumpToBook), name: NSNotification.Name("jumpToBook"), object: nil)
        
  

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
    
    @objc func notifyJumpBackToMap(){
        
        
    }
    
    
    @objc func jumpToElement(_ notification: NSNotification){
        
        //抓探索點號碼
        if let spotNumberReceived = notification.userInfo?["spotNumber"] as? Int {

            spotNumber = spotNumberReceived
            
            let when = DispatchTime.now() + 0.5

            DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                self!.performSegue(withIdentifier: "toElement", sender: self)
            })
            
        }
        
    }
    
    
    @objc func jumpToBook(){

        performSegue(withIdentifier: "toBook", sender: self)
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //傳送探索點數字
        if segue.identifier == "toElement" {
        
            let destinationVC = segue.destination as! ElementViewController
            destinationVC.spotNumber = spotNumber
        }
        
    }
        


    override var shouldAutorotate: Bool {
        return true
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
