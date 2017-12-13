//
//  ElementViewController.swift
//  wordDrug
//
//  Created by Ethan on 2017/11/10.
//  Copyright © 2017年 playplay. All rights reserved.
//
import UIKit
import SpriteKit
import GameplayKit

//傳送元素單位號碼
let passSpotNumberKey = "passUnitNumber"
//回到地圖
let backToMapKey = "backToMap"


class ElementViewController: UIViewController {
    
    //接收到探索點的號碼
    var spotNumber = Int()
    
    //所選擇的元素號碼
    var unitNumber = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //設定NC
        NotificationCenter.default.addObserver(self, selector: #selector(ElementViewController.passUnitNumber), name: NSNotification.Name("passUnitNumber"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ElementViewController.jumpBackToMap), name: NSNotification.Name("backToMap"), object: nil)
        
        if let scene = GKScene(fileNamed: "ElementScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! ElementScene? {
                
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
    
    
    @objc func jumpBackToMap(){
        
        //跳回上一個畫面
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func passUnitNumber(_ notification: NSNotification){
        
        //抓元素單位
        if let unitNumberReceived = notification.userInfo?["unitNumber"] as? Int {
            
            //接收元素單位
            unitNumber = unitNumberReceived
            
            //等待跳轉畫面
            let when = DispatchTime.now() + 0.5
            
            //跳轉畫面
            DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                self!.performSegue(withIdentifier: "beforePracticeToPet", sender: self)
            })
            
        }
        
    }
    
    //傳送探索點號碼及其元素表號碼, 直接設定至遊戲Vc的變數裡
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "beforePracticeToPet" {
            
            let destinationVC = segue.destination as! PetViewController
            destinationVC.spotNumber = spotNumber
            destinationVC.unitNumber = unitNumber
            //確認準備進入練習
            destinationVC.isReadyToEnterBattle = true
            //不能按元素
            destinationVC.isElementTouchable = false
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
