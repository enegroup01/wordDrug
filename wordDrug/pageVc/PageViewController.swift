//
//  PageViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/2/23.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import Magnetic

let toNewGameKey = "toNewGame"

class PageViewController: UIViewController,UIScrollViewDelegate{
    
    //控制頁數的左右鍵
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var leftBtn: UIButton!
    //顯示四頁數的btn
    @IBOutlet weak var page0: UIButton!
    @IBOutlet weak var page3: UIButton!
    @IBOutlet weak var page2: UIButton!
    @IBOutlet weak var page1: UIButton!
    //回上一頁的Btn
    @IBOutlet weak var backBtn: UIButton!
    
    //集合所有的頁數
    var pageBtns = [UIButton]()
    
    //磁力的參數
    var magnetic: Magnetic?
    var magneticDelegate: MagneticDelegate? // magnetic delegate
    var allowsMultipleSelection: Bool? // controls whether you can select multiple nodes. defaults to true
    var selectedChildren: [Node]?
    
    //顏色
    let lightBlueColor = UIColor.init(red: 52/255, green: 136/255, blue: 182/255, alpha: 1)
    let darkBlueColor = UIColor.init(red: 55/255, green: 61/255, blue: 106/255, alpha: 1)
    let darkPurpleColor = UIColor.init(red: 73/255, green: 54/255, blue: 100/255, alpha: 1)
    let darkTextColor = UIColor.init(red: 189/255, green: 189/255, blue: 189/255, alpha: 34)
    var fullSize: CGSize!
    
    //所有小球
    var ball0 = SKNode()
    var ball1 = SKNode()
    var ball2 = SKNode()
    var ball3 = SKNode()
    var ball4 = SKNode()
    var ball5 = SKNode()
    var ball6 = SKNode()
    var ball7 = SKNode()
    var ball8 = SKNode()
    var ball9 = SKNode()
    //集合小球
    var balls = [SKNode]()
    //大球
    var bigBall = SKNode()
    
    //好像用不到
    //var ballTexts = [String]()
    
    //被選擇到的音節
    var syllableSets = [[String]()]
    
    
    //以下為各地圖的音節
    
    //***前三張地圖的第15行探索點syllable都是先亂打的.....之後要改變
    let map1SyllableSets = [["ab1","ac1","ad1","a_e1","af1","ai1","al1","am1","an1","any1"],
                            ["ap1","ar1","as1","at1","au1","aw1","ay1","ba1","be1","bi1"],
                            ["bit1","bl1","bo1","br1","bu1","by1","ce1","ch1","ci1","ble1"],
                            ["ck1","cl1","co1","com1","con1","di1","cr1","ct1","de1","cian1"],
                            ["do1","dr1","dy1","dis1","ea1","ee1","el1","en1","er1","em1"],
                            ["et1","ew1","ex1","ey1","fi1","fl1","fo1","fr1","ft1","ful1"],
                            ["ge1","gi1","gl1","go1","gr1","he1","hi1","id1","ie1","igh1"],
                            ["il1","im1","in1","ing1","ir1","is1","ject1","le1","li1","kn1"],
                            ["ly1","mi1","nd1","no1","oa1","ob1","o_e1","of1","oi1","nt1"],
                            ["old1","on1","ong1","oo1","op1","or1","ot1","ou1","ow1","oy1"],
                            ["ph1","pi1","pl1","pr1","cop1","ro1","ry1","sh1","si1","re1"],
                            ["sk1","so1","st1","sion1","th1","ti1","tion1","tive1","tle1","sp1"],
                            ["to1","tr1","ty1","ub1","u_e1","ui1","um1","un1","up1","ture1"],
                            ["ur1","ut1","war1","wh1","ab2","ac2","ad2","a_e2","ai2","af2"],
                            ["er34","er35","er36","ea34","ea35","ble4","ble5","fr3","at4","ple2"]]
    
    let map2SyllableSets = [["al2","am2","an2","ar2","as2","at2","au2","aw2","ay2","be2"],
                            ["bo2","bu2","ce2","ch2","ck2","cl2","co2","com2","cr2", "con2"],
                            ["di2","do2","dr2","ea2","ee2","el2","en2","er2","et2", "em2"],
                            ["ew2","ex2","ey2","fi2","fr2","gr2","hi2","ie2","igh2","ge2"],
                            ["il2","im2","in2","ing2","ir2","is2","ly2","oa2","o_e2", "nd2"],
                            ["oi2","on2","ong2","oo2","op2","or2","ot2","ou2","ow2","ph2"],
                            ["pr2","ness1","re2","ry2","sh2","sk2","st2","th2","tion2","tr2"],
                            ["ture2","u_e2","i_e1","i_e2","ue1","ue2","ui2","um2","un2","ty2"],
                            ["up2","ur2","wh2","a_e3","ai3","al3","am3","an3","ac3","ad3"],
                            ["ar3","at3","aw3","ay3","be3","ce3","ch3","ck3","cl3","au3"],
                            ["ea3","ee3","el3","em3","en3","er3","et3","ex3","ey3","con3"],
                            ["i_e3","igh3","im3","in3","ing3","ir3","o_e3","oa3","oi3", "ge3"],
                            ["on3","ong3","oo3","op3","or3","ot3","ou3","ow3","pr3","gar1"],
                            ["re3","sh3","st3","th3","tion3","tr3","ty3","u_e3","ui3","ry3"],
                            ["er37","er38","er39","er40","er41","er42","er43","er44","er45","er46"]]
    
    let map3SyllableSets = [["un3","ur3","wh3","a_e4","ad4","ai4","al4","am4","an4","um3"],
                            ["ar4","au4","ay4","ce4","ch4","ck4","ea4","ee4","el4","em4"],
                            ["en4","er4","ex4","ge4","i_e4","igh4","im4","in4","ing4","ir4"],
                            ["o_e4","oa4","on4","oo4","or4","ot4","ou4","ow4","mo1","pr4"],
                            ["re4","sh4","st4","th4","ui4","um4","un4","ur4","a_e5","tion4"],
                            ["ad5","ai5","al5","am5","an5","ar5","au5","ay5","ce5","ch5"],
                            ["ck5","ea5","ee5","el5","en5","er5","ge5","i_e5","in5","im5"],
                            ["ing5","ir5","o_e5","oa5","oo5","or5","ou5","ow5","go2","pr5"],
                            ["sh5","st5","th5","tion5","un5","ur5","a_e6","ai6","al6","am6"],
                            ["an6","ar6","ay6","ce6","ch6","ck6","ea6","ee6","el6","en6"],
                            ["er6","i_e6","in6","ing6","o_e6","oo6","or6","ou6","ow6","oa6"],
                            ["pr6","buy1","sh6","st6","th6","un6","ur6","a_e7","ai7","tion6"],
                            ["al7","am7","an7","ar7","ay7","ch7","ea7","ee7","el7","ce7"],
                            ["en7","er7","i_e7","in7","ing7","oo7","or7","ou7","ow7","gy1"],
                            ["er47","er48","er49","er50","er51","er52","ea36","ea37","ea38","ce9"]]
    
    let map4SyllableSets = [["sh7","st7","th7","a_e8","ai8","al8","am8","an8","ar8","ay8"],
                            ["ce8","ea8","ee8","el8","en8","er8","i_e8","in8","ing8","ch8"],
                            ["oo8","or8","ou8","ow8","nic1","st8","th8","a_e9","ai9","sh8"],
                            ["al9","an9","ar9","ay9","ea9","ee9","el9","er9","i_e9","en9"],
                            ["in9","oo9","or9","ou9","ow9","ple1","st9","th9","a_e10","ai10"],
                            ["al10","an10","ar10","ea10","ee10","el10","en10","er10","i_e10","ay10"],
                            ["in10","oo10","or10","ou10","ow10","vil1","st10","a_e11","ai11","al11"],
                            ["an11","ar11","ay11","ea11","ee11","el11","en11","er11","i_e11","in11"],
                            ["oo11","or11","ow11","ju1","st11","a_e12","al12","an12","ar12","ai12"],
                            ["ou11","ea12","ee12","el12","en12","er12","i_e12","in12","or12","oo12"],
                            ["ou12","ow12","que1","sc1","sent1","sic1","so2","st12","stle1","ult1"],
                            ["zle1","a_e13","ai13","al13","ame1","an13","ar13","bed1","ble2","bt1"],
                            ["by2","cle1","cus1","dis2","ea13","ee13","el13","en13","er13","cian2"],
                            ["ge6","gh1","gi2","gn1","gu1","i_e13","in13","lar1","mb1","mid1"],
                            ["st17","an21","ng1","ge7","ou22","str1","pi2","ca1","ax1","ax2"]]
    
    let map5SyllableSets = [["mi2","mi3","mud1","na1","nd3","ny1","olf1","oo13","ood1","or13"],
                            ["ou13","st13","sw1","tle2","a_e14","al14","an14","ar14","ea14","sym1"],
                            ["ee14","en14","er14","i_e14","in14","oo14","or14","ou14","st14","a_e15"],
                            ["al15","an15","ar15","ea15","ee15","en15","er15","i_e15","in15","oo15"],
                            ["or15","ou15","st15","al16","an16","ea16","ee16","en16","er16","ar16"],
                            ["oo16","or16","ou16","st16","al17","an17","ar17","ea17","ee17","in16"],
                            ["en17","er17","in17","oo17","or17","ou17","al18","an18","ea18","ar18"],
                            ["ee18","en18","er18","in18","or18","ou18","an19","ea19","ee19","al19"],
                            ["en19","er19","or19","ou19","al20","ea20","ee20","en20","er20","an20"],
                            ["or20","ou20","ea21","ee21","en21","er21","or21","ou21","ea22","al21"],
                            ["ee22","en22","er22","or22","ea23","ee23","en23","er23","or23","ee24"],
                            ["ea24","en24","er24","or24","en25","er25","ea25","ea26","en26","or25"],
                            ["er26","ea27","en27","er27","ea28","en28","er28","ea29","en29","er29"],
                            ["ea30","en30","er30","ea31","er31","ea32","er32","ea33","er33","en31"],
                            ["bet1","a_e16","ba2","ban1","bar1","bl2","br2","br3","br4","ble3"]]

    //紀錄所有音節不包含數字
    var pageSyllables = [String]()
    
    //紀錄所有球的名字, 包含數字, 供之後進入關卡使用
    var pageNames = [String]()
    
    //備註: 測試用總頁數, 應該設為count數量, 以目前英檢初來說都是15頁
    var totalPages = 15
    
    //目前頁數
    var currentPage = Int()
    //記錄前一頁的頁數, 供直接選擇數字時使用
    var prePage = Int()
    
    //用來控制可以show多少關卡的變數, 讀取gamePassed之後決定
    var shownMaxInt = Int()
    
    //傳送unit數字
    var unitNumberToPass = Int()
    //接收地圖數字
    var mapNumToReceive = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //進入遊戲nc
        NotificationCenter.default.addObserver(self, selector: #selector(PageViewController.toNewGame), name: NSNotification.Name("toNewGame"), object: nil)
        
        //設定地圖的音節
        switch mapNumToReceive {
        case 1:
            syllableSets = map1SyllableSets
        case 2:
            syllableSets = map2SyllableSets
        case 3:
            syllableSets = map3SyllableSets
        case 4:
            syllableSets = map4SyllableSets
        case 5:
            syllableSets = map5SyllableSets
        default:
            break
        }
        
        if let scene = GKScene(fileNamed: "PageScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! PageScene? {
                
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
        
        //設定好整個磁力view
        let magneticView = MagneticView(frame: self.view.bounds)
        magnetic = magneticView.magnetic
        self.view.addSubview(magneticView)
        
        //把所有view拉到前方
        self.view.bringSubview(toFront: backBtn)
        self.view.bringSubview(toFront: leftBtn)
        self.view.bringSubview(toFront: rightBtn)
        self.view.bringSubview(toFront: page0)
        self.view.bringSubview(toFront: page1)
        self.view.bringSubview(toFront: page2)
        self.view.bringSubview(toFront: page3)
        
        //在此確認已過關卡
        //gamePassed = [14:9]
        

        
        //集合所有的頁數按鈕
        pageBtns.append(page0)
        pageBtns.append(page1)
        pageBtns.append(page2)
        pageBtns.append(page3)
        
       
        
        /*
        //按鈕頁數
        currentPage = 0
        
        //抓最大顯示unit
        setMaxInt()
        setBtnPage(currentPage: currentPage)
 */
    }
    
    
    //跳轉到遊戲的NC
    @objc func toNewGame(_ notification: NSNotification){
        
        //抓元素單位
        if let syllableReceived = notification.userInfo?["syllable"] as? String {
            
            //如果得到空值就不跳轉到遊戲
            if syllableReceived == "" {
                print("沒有元素")
                
            } else {
            //接收元素單位
            for i in  0 ..< syllableSets[currentPage].count{
                
                //對比所選擇的元素
                if syllableReceived == syllableSets[currentPage][i]{
                    
                    //指定要pass的index
                    unitNumberToPass = i
                }
                
            }
            
            //等待跳轉畫面
            
            let when = DispatchTime.now() + 0.5
            
            //跳轉畫面
            DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                self!.performSegue(withIdentifier: "toNewGame", sender: self)
                
                self!.bigBall.removeFromParent()
                self!.ball0.removeFromParent()
                self!.ball1.removeFromParent()
                self!.ball2.removeFromParent()
                self!.ball3.removeFromParent()
                self!.ball4.removeFromParent()
                self!.ball5.removeFromParent()
                self!.ball6.removeFromParent()
                self!.ball7.removeFromParent()
                self!.ball8.removeFromParent()
                self!.ball9.removeFromParent()
            })
        }
        }
        
    }
    
    //設定最大可以開放的數字
    func setMaxInt(){
        
        for (s,u) in gamePassed!{
     
            //  如果大於頁數, 則該頁全部的元素都代表過關
            if s > currentPage {
                
                //全顯示
                shownMaxInt = 9
                
                // 如果等於頁數, 則只顯示通過的數字
            } else if s == currentPage{
                
                //只亮該關卡的通過數字
                shownMaxInt = u
                
            } else {
                //都不開放
                shownMaxInt = -1
            }
            
        }
        
    }
    
    //目前按鍵無法改變位置及大小
    
    //設定完所有頁數按鈕後, 最後trigger翻頁讀取元素功能
    func setBtnPage(currentPage:Int){
        
        //首先都設成暗色, 之後再來處理
        page0.setTitleColor(darkPurpleColor, for: .normal)
        page1.setTitleColor(darkPurpleColor, for: .normal)
        page2.setTitleColor(darkPurpleColor, for: .normal)
        page3.setTitleColor(darkPurpleColor, for: .normal)
        
        switch totalPages {
        case 3:

            //  隱藏第4頁
            page3.isHidden = true
            
            //設定目前頁數的顏色
            pageBtns[currentPage].setTitleColor(lightBlueColor, for: .normal)
            
            //設定每頁數字
            for i in 0 ..< totalPages{
                pageBtns[i].setTitle(String(i + 1), for: .normal)
            }
            
            //確認是否要有左右鍵
            if currentPage == (totalPages - 1){
                //若是最後一頁
                rightBtn.isHidden = true
                leftBtn.isHidden = false
                
            } else if currentPage == 0 {
                
                //若是第一頁
                rightBtn.isHidden = false
                leftBtn.isHidden = true
            } else {
                
                rightBtn.isHidden = false
                leftBtn.isHidden = false
                
            }
            
    
        case 2:
            
            //隱藏3,4頁數
            page3.isHidden = true
            page2.isHidden = true
            
            //設定目前頁數的顏色
            pageBtns[currentPage].setTitleColor(lightBlueColor, for: .normal)
            
            //設定每頁數字
            for i in 0 ..< totalPages{
                pageBtns[i].setTitle(String(i + 1), for: .normal)
            }
            //確認是否要有左右鍵
            if currentPage == (totalPages - 1){
                //若是最後一頁
                rightBtn.isHidden = true
                leftBtn.isHidden = false
                
            } else if currentPage == 0 {
                
                //若是第一頁
                rightBtn.isHidden = false
                leftBtn.isHidden = true
            } else {
                
                rightBtn.isHidden = false
                leftBtn.isHidden = false
                
            }
            
        case 1:
            
            
            //隱藏2,3,4頁
            rightBtn.isHidden = true
            leftBtn.isHidden = true
            page3.isHidden = true
            page2.isHidden = true
            page1.isHidden = true
            
            //設定目前頁數的顏色
            pageBtns[currentPage].setTitleColor(lightBlueColor, for: .normal)
            
            //設定每頁數字
            for i in 0 ..< totalPages{
                pageBtns[i].setTitle(String(i + 1), for: .normal)
            }
            
            //四頁以上的設定
        case 4...:
            
            //設定頁數數字
            if currentPage >= totalPages - 2 {
                //最後頁數
                pageBtns[0].setTitle(String(totalPages - 3), for: .normal)
                pageBtns[1].setTitle(String(totalPages - 2), for: .normal)
                pageBtns[2].setTitle(String(totalPages - 1), for: .normal)
                pageBtns[3].setTitle(String(totalPages), for: .normal)
                
                
            } else if currentPage <= 2 {
                //最前頁數
                pageBtns[0].setTitle(String(1), for: .normal)
                pageBtns[1].setTitle(String(2), for: .normal)
                pageBtns[2].setTitle(String(3), for: .normal)
                pageBtns[3].setTitle(String(4), for: .normal)
                
            } else {
                
                //中段頁數
                pageBtns[0].setTitle(String(currentPage - 1), for: .normal)
                pageBtns[1].setTitle(String(currentPage), for: .normal)
                pageBtns[2].setTitle(String(currentPage + 1), for: .normal)
                pageBtns[3].setTitle(String(currentPage + 2), for: .normal)
                
            }
            
            
            //設定顏色及左右鍵
            if currentPage == 0 {
                page0.setTitleColor(lightBlueColor, for: .normal)
                leftBtn.isHidden = true
                rightBtn.isHidden = false
                
            } else if currentPage == 1 {
                page1.setTitleColor(lightBlueColor, for: .normal)
                leftBtn.isHidden = false
                rightBtn.isHidden = false
            } else if currentPage == (totalPages - 1){
                
                //最後一頁
                page3.setTitleColor(lightBlueColor, for: .normal)
                rightBtn.isHidden = true
                leftBtn.isHidden = false
            } else {
                //其他的頁數
                page2.setTitleColor(lightBlueColor, for: .normal)
                leftBtn.isHidden = false
                rightBtn.isHidden = false
                
            }
            
        default:
            break
        }
        
        //翻頁
        findPageSyllables(page: currentPage)
        
    }
    
    //回到上一頁
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //不改變位置的作法
    func setPageNoChangePos(prePage:Int, currentPage:Int){
        if currentPage == 0 {
            //如果是第一頁
            leftBtn.isHidden = true
        } else if currentPage == (totalPages - 1) {
            rightBtn.isHidden = true
            
        }
        
        var newBtnNum = Int()
        
        if prePage > currentPage{
            
            for i in 0 ..< pageBtns.count{
                
                //之前那一個Btn
                if pageBtns[i].currentTitleColor == lightBlueColor{
                    newBtnNum = i - (prePage - currentPage)
                    
                }
                
            }
        } else {
            
            for i in 0 ..< pageBtns.count{
                
                //之前那一個Btn
                if pageBtns[i].currentTitleColor == lightBlueColor{
                    newBtnNum = i + (currentPage - prePage)
                    
                }
                
            }
        }
        
        for b in pageBtns{
            b.setTitleColor(darkPurpleColor, for: .normal)
        }
        
        pageBtns[newBtnNum].setTitleColor(lightBlueColor, for: .normal)
        
        //翻頁
        findPageSyllables(page: currentPage)
        
    }
    
    @IBAction func leftBtnClicked(_ sender: Any) {
        removeAllBalls {[weak self] in
            self!.currentPage -= 1
            self!.setMaxInt()
            self!.setBtnPage(currentPage: self!.currentPage)
            
        }
        
    }
    @IBAction func page0Clicked(_ sender: Any) {
        
        removeAllBalls {[weak self] in
            
            self!.prePage = self!.currentPage
            self!.currentPage = Int(self!.page0.currentTitle!)! - 1
            self!.setMaxInt()
            self!.setPageNoChangePos(prePage: self!.prePage, currentPage: self!.currentPage)
            
        }
        
    }
    @IBAction func page1Clicked(_ sender: Any) {
        removeAllBalls {[weak self] in
            
            self!.prePage = self!.currentPage
            self!.currentPage = Int(self!.page1.currentTitle!)! - 1
            self!.setMaxInt()
            self!.setPageNoChangePos(prePage: self!.prePage, currentPage: self!.currentPage)
            
        }
        
    }
    @IBAction func page2Clicked(_ sender: Any) {
        removeAllBalls {[weak self] in
            
            self!.prePage = self!.currentPage
            self!.currentPage = Int(self!.page2.currentTitle!)! - 1
            self!.setMaxInt()
            self!.setPageNoChangePos(prePage: self!.prePage, currentPage: self!.currentPage)
            
        }
        
    }
    
    @IBAction func page3Clicked(_ sender: Any) {
        removeAllBalls {[weak self] in
            
            self!.prePage = self!.currentPage
            self!.currentPage = Int(self!.page3.currentTitle!)! - 1
            self!.setMaxInt()
            self!.setPageNoChangePos(prePage: self!.prePage, currentPage: self!.currentPage)
            
            
        }
        
        
    }
    
    @IBAction func rightBtnClicked(_ sender: Any) {
        
        removeAllBalls {[weak self] in
            self!.currentPage += 1
            self!.setMaxInt()
            self!.setBtnPage(currentPage: self!.currentPage)
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func removeAllBalls(finished: @escaping () -> Void){
        
        bigBall.removeFromParent()
        
        ball0.removeFromParent()
        ball1.removeFromParent()
        ball2.removeFromParent()
        ball3.removeFromParent()
        ball4.removeFromParent()
        ball5.removeFromParent()
        ball6.removeFromParent()
        ball7.removeFromParent()
        ball8.removeFromParent()
        ball9.removeFromParent()
        
        finished()
        
    }
    
    func findPageSyllables(page:Int){
        
        //每次換頁都必須先移除
        pageSyllables.removeAll(keepingCapacity: false)
        pageNames.removeAll(keepingCapacity: false)
        
        //抓該頁的元素, 分成有數字的name還有沒數字的syllable
        for i in 0 ..< syllableSets.count{
            
            if i == page {
                
                //抓到有開放的部分
                for s in 0 ..< (shownMaxInt + 1) {
                    
                    //沒數字的
                    let syllableWithoutDigit = (syllableSets[i][s].components(separatedBy: NSCharacterSet.decimalDigits) as NSArray).componentsJoined(by: "")
                    
                    //新增這頁所有syllable & name
                    pageNames.append(syllableSets[i][s])
                    pageSyllables.append(syllableWithoutDigit)
                    
                }
                
            }
            
        }
        
        //在此決定已過關的球的顏色
        var colors = [UIColor]()
        
        for _ in 0 ..< 10 {
            
            colors.append(darkBlueColor)
        }
        
        for i in 0 ..< pageSyllables.count  - 1{
            
                
                colors[i] = UIColor.darkGray
                
        }
        
        //接著append空值給未全開放的
        let emptyNums = 10 - (shownMaxInt + 1)
        for  _ in 0 ..< emptyNums{
            
            pageSyllables.append("")
            pageNames.append("")
            
        }
        
        /*

        */
        
   
        ball0 = Node(text: pageSyllables[0], image: UIImage(), color: colors[0], radius: 35, name: pageNames[0])
        ball1 = Node(text: pageSyllables[1], image: UIImage(), color: colors[1], radius: 35, name: pageNames[1])
        ball2 = Node(text: pageSyllables[2], image: UIImage(), color: colors[2], radius: 35, name: pageNames[2])
        ball3 = Node(text: pageSyllables[3], image: UIImage(), color: colors[3], radius: 35, name: pageNames[3])
        ball4 = Node(text: pageSyllables[4], image: UIImage(), color: colors[4], radius: 35, name: pageNames[4])
        ball5 = Node(text: pageSyllables[5], image: UIImage(), color: colors[5], radius: 35, name: pageNames[5])
        ball6 = Node(text: pageSyllables[6], image: UIImage(), color: colors[6], radius: 35, name: pageNames[6])
        ball7 = Node(text: pageSyllables[7], image: UIImage(), color: colors[7], radius: 35, name: pageNames[7])
        ball8 = Node(text: pageSyllables[8], image: UIImage(), color: colors[8], radius: 35, name: pageNames[8])
        ball9 = Node(text: pageSyllables[9], image: UIImage(), color: colors[9], radius: 35, name: pageNames[9])
        
        
        
        //集合所有的球
        /*
        balls.append(ball0)
        balls.append(ball1)
        balls.append(ball2)
        balls.append(ball3)
        balls.append(ball4)
        balls.append(ball5)
        balls.append(ball6)
        balls.append(ball7)
        balls.append(ball8)
        balls.append(ball9)
        
        
        for i in 0 ..< pageSyllables.count{
            
            if pageSyllables[i] == "" {
                
                print(i)
                balls[i].isHidden = true
            }
        }
 
 */
        
        /*
        //做球
         if pageSyllables[0] != "" {
       
        }
        if pageSyllables[1] != "" {
        
        }
        
        if pageSyllables[2] != "" {
            
        }
        if pageSyllables[3] != "" {
            
        }
        if pageSyllables[4] != "" {
            
        }
        if pageSyllables[5] != "" {
            
        }
        if pageSyllables[6] != "" {
            
        }
        if pageSyllables[7] != "" {
            
        }
        if pageSyllables[8] != "" {
            
        }
        if pageSyllables[9] != "" {
            
        }
*/
        
        //做大球並隱藏
        bigBall = Node(text: "", image: UIImage(), color: lightBlueColor, radius: 100, name: "bigBall")
        bigBall.isHidden = true
        magnetic!.addChild(bigBall)
        
        magnetic!.addChild(ball0)
        magnetic!.addChild(ball1)
        magnetic!.addChild(ball2)
        magnetic!.addChild(ball3)
        magnetic!.addChild(ball4)
        magnetic!.addChild(ball5)
        magnetic!.addChild(ball6)
        magnetic!.addChild(ball7)
        magnetic!.addChild(ball8)
        magnetic!.addChild(ball9)
        
        //列印該頁所有應該要顯示的元素
        print(pageSyllables)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        print("will appear")
        

        
        
        //抓最大顯示unit
        setMaxInt()
        
        setBtnPage(currentPage: currentPage)
        
    }
    //設定要傳送的值
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toNewGame"{
            let destinationVC = segue.destination as! NewGameViewController
            destinationVC.spotNumber = currentPage
            destinationVC.unitNumber = unitNumberToPass
            destinationVC.mapNumber = mapNumToReceive
            
        }
        
        
    }
    
}

extension PageViewController: MagneticDelegate {
    
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        print("didSelect -> \(node)")
    }
    
    func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
        print("didDeselect -> \(node)")
    }
    
}
