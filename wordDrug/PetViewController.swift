//
//  PetViewController.swift
//  wordDrug
//
//  Created by Ethan on 2017/11/27.
//  Copyright © 2017年 playplay. All rights reserved.
//

import UIKit

class PetViewController: UIViewController {
    @IBOutlet weak var petAva: UIImageView!
    @IBOutlet weak var selElem1Img: UIImageView!
    @IBOutlet weak var selElem2Img: UIImageView!
    @IBOutlet weak var selElem3Img: UIImageView!
    @IBOutlet weak var petInfoBg: UIImageView!
    @IBOutlet weak var petTitle: UILabel!
    @IBOutlet weak var petLevelLabel: UILabel!
    @IBOutlet weak var petLifeLabel: UILabel!
    @IBOutlet weak var petAttackLabel: UILabel!
    @IBOutlet weak var petExtraAttackLabel: UILabel!
    @IBOutlet weak var petDoubleAttackLabel: UILabel!
    @IBOutlet weak var petDefenseLabel: UILabel!
    @IBOutlet weak var petCureLabel: UILabel!
    @IBOutlet weak var elementBg: UIImageView!
    @IBOutlet weak var elem1: UIImageView!
    @IBOutlet weak var elem2: UIImageView!
    @IBOutlet weak var elem3: UIImageView!
    @IBOutlet weak var elem4: UIImageView!
    @IBOutlet weak var elem5: UIImageView!
    @IBOutlet weak var elem6: UIImageView!
    @IBOutlet weak var elem7: UIImageView!
    @IBOutlet weak var elem8: UIImageView!
    @IBOutlet weak var elem9: UIImageView!
    @IBOutlet weak var elem10: UIImageView!
    @IBOutlet weak var elem11: UIImageView!
    @IBOutlet weak var elem12: UIImageView!
    @IBOutlet weak var pageLabel: UILabel!
    
    var location = CGPoint()
    //畫面上所有元素
    var elems = [UIImageView]()
    //記憶所有元素的原始位置
    var elemCgPoints = [CGPoint]()
    //碰觸到的元素
    var touchedElem = UIImageView()
    //記憶碰觸到元素的原始位置
    var originalPosition = CGPoint()
    //畫面上選項的元素
    var selElems = [UIImageView]()
    //暫時抓正確位置
    var selElemsCgs = [[35,258],[100.5,258],[164.5,258]]
    
    //目前選到的元素Index
    var currentElemIndex = Int()
    //紀錄三個選項元素的數字
    var selOccupiedByElemIndex = [-1,-1,-1]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //寵物大頭照
        petAva.image = UIImage(named: "401.png")
        
        //使用的元素
        let selElemImage = UIImage(named: "elem.png")
        selElem1Img.image = selElemImage
        selElem2Img.image = selElemImage
        selElem3Img.image = selElemImage
        
        //寵物資訊背景
        petInfoBg.image = UIImage(named: "petInfoBg.png")
        
        //元素列表背景
        elementBg.image = UIImage(named: "elemBg.png")
        let elemImage = UIImage(named: "attack4.png")
        elem1.image = UIImage(named: "ae1.png")
        elem2.image = UIImage(named: "ai1.png")
        elem3.image = UIImage(named:"ao1.png")
        elem4.image = UIImage(named:"bi1.png")
        elem5.image = elemImage
        elem6.image = elemImage
        elem7.image = elemImage
        elem8.image = elemImage
        elem9.image = elemImage
        elem10.image = elemImage
        elem11.image = elemImage
        elem12.image = elemImage
        
        //加入元素
        elems.append(elem1)
        elems.append(elem2)
        elems.append(elem3)
        elems.append(elem4)
        elems.append(elem5)
        elems.append(elem6)
        elems.append(elem7)
        elems.append(elem8)
        elems.append(elem9)
        elems.append(elem10)
        elems.append(elem11)
        elems.append(elem12)
        
        //加入元素位置
        elemCgPoints.append(elem1.center)
        elemCgPoints.append(elem2.center)
        elemCgPoints.append(elem3.center)
        elemCgPoints.append(elem4.center)
        elemCgPoints.append(elem5.center)
        elemCgPoints.append(elem6.center)
        elemCgPoints.append(elem7.center)
        elemCgPoints.append(elem8.center)
        elemCgPoints.append(elem9.center)
        elemCgPoints.append(elem10.center)
        elemCgPoints.append(elem11.center)
        elemCgPoints.append(elem12.center)
        
        //加入選項元素
        selElems.append(selElem1Img)
        selElems.append(selElem2Img)
        selElems.append(selElem3Img)
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            location = touch.location(in: self.view)
            
            //跑所有元素
            for e in  0 ..< elems.count{
                
                //確認e是否為occupied當中的index, 是的話把數字還原-1,讓其可以繼續填入其他元素
                        if elems[e].frame.contains(location){
                            switch e {
                            case selOccupiedByElemIndex[0]:
                                selOccupiedByElemIndex[0] = -1
                            case selOccupiedByElemIndex[1]:
                                selOccupiedByElemIndex[1] = -1
                            case selOccupiedByElemIndex[2]:
                                selOccupiedByElemIndex[2] = -1
                            default:
                              break
                            }
                            
                            //指定該元素的原始位置
                            originalPosition = elemCgPoints[e]
                            //移動
                            elems[e].center = location
                            //指定該元素
                            touchedElem = elems[e]
                            //指定該元素Index
                            currentElemIndex = e
                            
                }
            
            }

        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            location = touch.location(in: self.view)
            //移動元素
            touchedElem.center = location
            
        }
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            location = touch.location(in: self.view)
            
            //Part 1. 首先先讓元素回原位
            touchedElem.center = originalPosition
            
            
            //Part 2. 下方假如元素有碰到選項, 就移至選項位置
            
            //跑所有的選項元素
            for s in 0 ..< selElems.count{
                
                //假如碰到了其中之一
                if selElems[s].frame.contains(location){
                    
                    //先檢查是否沒有任何元素
                    if selOccupiedByElemIndex[s] == -1 {
                    
                    //沒有的話固定元素
                        
                    touchedElem.center = CGPoint(x: selElemsCgs[s][0], y: selElemsCgs[s][1])
                    
                    //設定數字
                    selOccupiedByElemIndex[s] = currentElemIndex
       
                    
                    }
                }
            }

        }
    }
    
    @IBAction func prevButtonClick(_ sender: Any) {
    }
    
    @IBAction func nextButtonClick(_ sender: Any) {
    }
    
}
