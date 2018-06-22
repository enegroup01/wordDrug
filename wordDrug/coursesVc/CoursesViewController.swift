//
//  CoursesViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/2/21.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController {
    @IBOutlet weak var block0: UIImageView!
    @IBOutlet weak var block2: UIImageView!
    @IBOutlet weak var block0LBtn: UIButton!
    
    @IBOutlet weak var block0RBtn: UIButton!
    @IBOutlet weak var block3: UIImageView!
    @IBOutlet weak var block1: UIImageView!
    
    @IBOutlet weak var block1LBtn: UIButton!
    
    @IBOutlet weak var block2RBtn: UIButton!
    @IBOutlet weak var block2LBtn: UIButton!
    @IBOutlet weak var block1RBtn: UIButton!
    @IBOutlet weak var dialogueBg: UIImageView!
    
    @IBOutlet weak var dialogueLabel: UILabel!
    
    @IBOutlet weak var block0WordCountLabel: UILabel!
    
    @IBOutlet weak var block1WordCountLabel: UILabel!
    
    @IBOutlet weak var block2WordCountLabel: UILabel!
    
   
    
    @IBOutlet weak var block0TitleImg: UIImageView!
    
    @IBOutlet weak var block1TitleImg: UIImageView!
    

  
    @IBOutlet weak var block2TitleImg: UIImageView!
    
    

    
    @IBOutlet weak var logOutBtn: UIButton!
    var alertBg = UIImageView()
    var alertText = UILabel()
    var iknowBtn = UIButton()
    var ghostBtn = UIButton()
    
    var noClassBtn = UIButton()
    var courseSent = Int()
    
    var isGuidingMode = false
    
    var guideBg = UIImageView()
    var guideGhost = UIButton()
    var guideTitle = UILabel()
    var guideText = UILabel()
    
    //test用
    var guideTitle2 = UILabel()
    var guideTitle3 = UILabel()
    
    
    //layOut
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    @IBOutlet weak var toInfoVcBtn: UIButton!
    
    var guideStep = 0
    var step0Line = UIImageView()
    
    var headPhone = UIImageView()
    
    let specialRed = UIColor.init(red: 1, green: 123/255, blue: 123/255, alpha: 1)
    
    var step1Line0 = UIImageView()
    var step1Line1 = UIImageView()
    var step1Line2 = UIImageView()
    
    var step1Circle0 = UIImageView()
    var step1Circle1 = UIImageView()
    var step1Circle2 = UIImageView()
    
    var step1Book0 = UIImageView()
    var step1Book1 = UIImageView()
    var step1Book2 = UIImageView()
    
    
    var step0Chart = UIImageView()
    
    var step0Circle = UIImageView()
    var step0Person = UIImageView()
    
    var step2Circle = UIImageView()
    //test用
    var step2Circle2 = UIImageView()
    var step2Circle3 = UIImageView()
    
    
    var step2Line0 = UIImageView()
    var step2Line1 = UIImageView()
    var step2Line2 = UIImageView()
    
    var recommendedClass:String?
    
    @IBOutlet weak var sepLine0: UIImageView!
    
    @IBOutlet weak var sepLine1: UIImageView!
    
    
    @IBOutlet weak var sepLine2: UIImageView!
    

    
    @IBOutlet weak var bottomBg: UIImageView!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var unitLabel1: UILabel!
    
    @IBOutlet weak var unitLabel2: UILabel!
    
    @IBOutlet weak var toChartVcBtn: UIButton!
    
    @IBOutlet weak var toInfoLabel: UILabel!
    
    @IBOutlet weak var toShopLabel: UILabel!
    @IBOutlet weak var toChartLabel: UILabel!
    @IBOutlet weak var toShopVcBtn: UIButton!
    
    var hiddenInfoBtn = UIButton()
    var hiddenChartBtn = UIButton()
    var hiddenShopBtn = UIButton()
    
    var isWelcome = false
    
    @IBOutlet weak var bigNameLabel: UILabel!
    
    @IBOutlet weak var dayTitleLabel: UILabel!
    @IBOutlet weak var userStatusLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    
    @IBOutlet weak var finger: UIImageView!
    
    @IBOutlet weak var point: UIImageView!
    
    @IBOutlet weak var logoImg: UIImageView!
    var fingerTimer = Timer()
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(isGuidingMode)
        
        // Do any additional setup after loading the view.
        //print("coursesVC:\(user!)")
        
        
        
        var xPos = CGFloat()
        var fontSize = CGFloat()
        var titleDif = CGFloat()
        var dif = CGFloat()
        var iPadDif = CGFloat()
        var wordCountX = CGFloat()
        var btnDif = CGFloat()
        var btnY = CGFloat()
        
        switch height {
            
        case 812:
            fontSize = 20
            xPos = -22
            titleDif = 1
            dif = 1.15
            iPadDif = 1
            wordCountX = 1.03
            btnDif = 1
            btnY = -5
            
        case 736:
            
            fontSize = 18
            xPos = 0
            titleDif = 1
            dif = 1.1
            iPadDif = 1
             wordCountX = 1
            btnDif = 1
            btnY = 0
            
        case 667:
            
            fontSize = 18
            xPos = 0
            titleDif = 0.9
            dif = 1
            iPadDif = 1
             wordCountX = 1.03
            btnDif = 0.95
            btnY = 0
            
        case 568:
            fontSize = 16
            xPos = 0
            titleDif = 0.8
            dif = 0.9
            iPadDif = 1
             wordCountX = 1.03
            btnDif = 0.8
            btnY = 0
            
        default:
            fontSize = 14
            xPos = 0
            titleDif = 0.8
            dif = 0.9
            iPadDif = 1.5
             wordCountX = 1
            btnDif = 1
            btnY = 0
            
        }
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.layer.zPosition = 15
        let alphaGray = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.4)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.layer.cornerRadius = activityIndicator.frame.width / 20
        activityIndicator.backgroundColor = alphaGray
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.addSubview(activityIndicator)
        
        //這部分的顯示還沒安排位置
        var nickname = String()
        //測試用
        
        if user != nil {
            nickname = user?["username"] as! String
        } else {
            nickname = "新學生"
        }
        
        
        
        block0.frame = CGRect(x: xPos, y: 0, width: width, height: height / 4)
        block0.contentMode = .scaleAspectFill
        block1.frame = CGRect(x: xPos, y: height / 4, width: width, height: height / 4)
        block2.frame = CGRect(x: xPos, y: height / 2, width: width, height: height / 4)
        //block3.frame = CGRect(x: xPos, y: height * 3 / 4, width: width, height: height / 4)
        
        //block0LBtn.frame = CGRect(x: 0, y: 0, width: width * 3 / 4 + width / 42, height: height / 4)
        //block0RBtn.frame = CGRect(x: block0LBtn.frame.width, y: 0, width: width - block0LBtn.frame.width, height: height / 4)
        //block0RBtn.backgroundColor = .red
        //block0LBtn.backgroundColor = .green
        
        
        //block0TitleImg.frame = CGRect(x: block0.frame.width / 26, y: block0.frame.height / 3 * iPadDif, width: 136 * titleDif, height: 94 * titleDif / iPadDif)
        
        //新位置
        
        block0TitleImg.frame = CGRect(x: block0.frame.width / 26, y: height / 3.5 * iPadDif, width: 136 * titleDif, height: 94 * titleDif / iPadDif)
        

        
        // block1TitleImg.frame = CGRect(x: block0.frame.width / 26, y: block1.frame.origin.y + block0.frame.height / 5 * iPadDif, width: 136 * titleDif, height: 97 * titleDif / iPadDif)
        
        
        //新位置
        block1TitleImg.frame = CGRect(x: block0.frame.width / 26, y: height / 2 * iPadDif, width: 136 * titleDif, height: 97 * titleDif / iPadDif)
        
        
        
        
        //block2TitleImg.frame = CGRect(x: block0.frame.width / 26, y: block2.frame.origin.y + block0.frame.height / 4 * iPadDif, width: 136 * titleDif, height: 81 * titleDif / iPadDif)
        
        
        
        //新位置
        block2TitleImg.frame = CGRect(x: block0.frame.width / 40, y: height / 1.38
            * iPadDif, width: 146 * titleDif, height: 92 * titleDif / iPadDif)

        
        //新位置
        block0LBtn.frame = CGRect(x: width / 2.5, y: block0TitleImg.frame.maxY * 0.95 - btnY, width: 105 * btnDif, height: 35 * btnDif)
        block0RBtn.frame = CGRect(x: block0LBtn.frame.maxX + 10, y: block0LBtn.frame.minY, width: 105 * btnDif, height: 35 * btnDif)
        
        
        
        //block1LBtn.frame = CGRect(x: 0, y: height / 4, width: width * 3 / 4 + width / 42, height: height / 4)0
        //新位置
        block1LBtn.frame = CGRect(x: width / 2.5, y: block1TitleImg.frame.maxY * 0.95 - btnY, width: 105 * btnDif, height: 35 * btnDif)
        
      //  block1RBtn.frame = CGRect(x: block1LBtn.frame.width, y: block1LBtn.frame.minY, width: block0RBtn.frame.width, height: block0RBtn.frame.height)
        //block1RBtn.backgroundColor = .blue
        
        
      
       // block1RBtn.frame = CGRect(x: block1LBtn.frame.maxX + 5, y: block1LBtn.frame.minY, width: 222, height: 36)
        
        //新位置
        block1RBtn.frame = CGRect(x: block1LBtn.frame.maxX + 10, y: block1LBtn.frame.minY, width: 105 * btnDif, height: 35 * btnDif)
        
        //block1LBtn.backgroundColor = .purple
        
       // block2LBtn.frame = CGRect(x: 0, y: block1LBtn.frame.maxY, width: block1LBtn.frame.width, height: height / 4)
       // block2LBtn.backgroundColor = .yellow
        
        
        //block2RBtn.frame = CGRect(x: block1LBtn.frame.maxX, y: block2LBtn.frame.minY, width: block1RBtn.frame.width, height: block2LBtn.frame.height)
       // block2RBtn.backgroundColor = .brown
        
        //新位置
       block2LBtn.frame = CGRect(x: width / 2.5, y: block2TitleImg.frame.maxY * 0.97 - btnY, width: 105 * btnDif, height: 35 * btnDif)
        
   
        block2RBtn.frame = CGRect(x: block2LBtn.frame.maxX + 10, y: block2LBtn.frame.minY, width: 105 * btnDif, height: 35 * btnDif)
        /*
        dialogueBg.frame = CGRect(x: width / 3, y: block0.frame.height / 5.5, width: width * 1.8 / 3, height: block0.frame.height / 5)
        
        dialogueLabel.frame = CGRect(x: dialogueBg.frame.origin.x + dialogueBg.frame.width / 40, y: dialogueBg.frame.origin.y + dialogueBg.frame.height / 4, width: dialogueBg.frame.width * 19 / 20, height: dialogueBg.frame.height / 2)
        
        dialogueLabel.adjustsFontSizeToFitWidth = true
        dialogueLabel.text = "Hi! \(nickname) 請選擇課程"
        */
        
        
       // toInfoVcBtn.frame = CGRect(x: dialogueBg.frame.minX, y: dialogueBg.frame.minY, width: dialogueBg.frame.height, height: dialogueBg.frame.height)
        //新位置
        
        bottomBg.frame = CGRect(x: 0, y: height - 80 * dif * btnDif, width: width, height: 80 * dif)
       
        //toInfoVcBtn.frame = CGRect(x: width / 7 , y: height / 8, width: 44 * dif, height: 42 * dif)
        
        toInfoVcBtn.frame = CGRect(x: width / 7 , y: bottomBg.frame.minY + 5, width: 37 * dif, height: 48 * dif)
        
        toInfoVcBtn.center = CGPoint(x: width / 6, y: bottomBg.frame.midY - 4)
        //toChartVcBtn.frame = CGRect(x: width * 3 / 7, y: height / 8 - 8, width: 43 * dif, height: 49 * dif)
        
        toChartVcBtn.frame = CGRect(x: width * 3 / 7, y: bottomBg.frame.minY + 3, width: 43 * dif, height: 49 * dif)
        toChartVcBtn.center = CGPoint(x: width / 2, y: bottomBg.frame.midY - 5)
        
        //toShopVcBtn.frame = CGRect(x: width * 5 / 7, y: height / 8, width: 43 * dif, height: 43 * dif)
        
        toShopVcBtn.frame = CGRect(x: width * 5 / 7, y: bottomBg.frame.minY + 5, width: 43 * dif, height: 43 * dif)

        toShopVcBtn.center = CGPoint(x: width * 5 / 6, y: bottomBg.frame.midY - 4)
        
        toInfoLabel.center = CGPoint(x: toInfoVcBtn.frame.midX, y: toInfoVcBtn.frame.maxY + 15)
        toChartLabel.center = CGPoint(x: toChartVcBtn.frame.midX, y: toInfoLabel.frame.midY)
        toShopLabel.center = CGPoint(x: toShopVcBtn.frame.midX, y: toInfoLabel.frame.midY)
        
        toInfoLabel.isHidden = true
        toChartLabel.isHidden = true
        toShopLabel.isHidden = true
        
        hiddenInfoBtn.frame = toInfoLabel.frame
        hiddenInfoBtn.addTarget(self, action: #selector(CoursesViewController.toInfoVcClicked(_:)), for: .touchUpInside)
        self.view.addSubview(hiddenInfoBtn)
        
        hiddenChartBtn.frame = toChartLabel.frame
        hiddenChartBtn.addTarget(self, action: #selector(CoursesViewController.toChartVcBtnClicked(_:)), for: .touchUpInside)
        self.view.addSubview(hiddenChartBtn)
        
        hiddenShopBtn.frame = toShopLabel.frame
        hiddenShopBtn.addTarget(self, action: #selector(CoursesViewController.toShopVcBtnClicked(_:)), for: .touchUpInside)
        self.view.addSubview(hiddenShopBtn)
        
        
        
        logOutBtn.frame = CGRect(x: width / 18, y: height / 24, width: 30 * dif * iPadDif, height: 21 * dif * iPadDif)
        
      
        
        /*
         block0Text.frame = CGRect(x: block0.frame.width / 26, y: block0.frame.height / 3, width: 272, height: 94)
         block1Text.frame = CGRect(x: block0.frame.width / 26, y: block1.frame.origin.y + block0.frame.height / 3, width: 272, height: 97)
         block2Text.frame = CGRect(x: block0.frame.width / 26, y: block2.frame.origin.y + block0.frame.height / 3, width: 272, height: 84)
         block3Text.frame = CGRect(x: block0.frame.width / 26, y:  block3.frame.origin.y + block0.frame.height / 3, width: 272, height: 82)
         */
        

        
       // block3TitleImg.frame = CGRect(x: block0.frame.width / 26, y:  block3.frame.origin.y + block0.frame.height / 4 * iPadDif, width: 136 * titleDif, height: 81 * titleDif / iPadDif)
        
        
        //block0WordCountLabel.frame = CGRect(x: dialogueBg.frame.origin.x * 1.2, y: block0.frame.height / 2 / iPadDif, width: width / 2.8, height: block0.frame.height / 3 * iPadDif)
        //block0WordCountLabel.backgroundColor = .red
        block0WordCountLabel.adjustsFontSizeToFitWidth = true

        
        
        
        
        //新位置
        block0WordCountLabel.frame = CGRect(x: width * 2 / 3 * 0.85, y: block0TitleImg.frame.minY * 1.05, width: width / 2.8, height: block0.frame.height / 3 * iPadDif)
        
        
        
        
        //block1WordCountLabel.frame = CGRect(x: dialogueBg.frame.origin.x * 1.2, y: block1.frame.origin.y + block1.frame.height / 3, width: width / 2.8, height: block0.frame.height / 3 * iPadDif)
        //block1WordCountLabel.backgroundColor = .red
        //新位置
        block1WordCountLabel.frame = CGRect(x: width * 2 / 3 * 0.85, y: block1TitleImg.frame.minY * 1.02, width: width / 2.8, height: block0.frame.height / 3 * iPadDif)

        block1WordCountLabel.adjustsFontSizeToFitWidth = true
       
        
        //block2WordCountLabel.frame = CGRect(x: dialogueBg.frame.origin.x * 1.2, y: block2.frame.origin.y + block2.frame.height / 3, width: width / 2.8, height: block0.frame.height / 3 * iPadDif)
        //block2WordCountLabel.backgroundColor = .red
       
        block2WordCountLabel.adjustsFontSizeToFitWidth = true
        //新位置
         block2WordCountLabel.frame = CGRect(x: width * 2 / 3 * 0.85, y: block2TitleImg.frame.minY, width: width / 2.8, height: block0.frame.height / 3 * iPadDif)
        
        
        unitLabel.frame = CGRect(x: block0WordCountLabel.frame.maxX * 0.98 * wordCountX, y: block0WordCountLabel.frame.maxY - 20, width: 14, height: 20)
        
                unitLabel1.frame = CGRect(x: block1WordCountLabel.frame.maxX * 0.98 * wordCountX, y: block1WordCountLabel.frame.maxY - 20, width: 14, height: 20)
                unitLabel2.frame = CGRect(x: block2WordCountLabel.frame.maxX * 0.98 * wordCountX
                    , y: block2WordCountLabel.frame.maxY - 20, width: 14, height: 20)
        
        
        
       
        
        //block3WordCountLabel.frame = CGRect(x: dialogueBg.frame.origin.x * 1.2, y: block3.frame.origin.y + block3.frame.height / 3, width: width / 2.8, height: block0.frame.height / 3 * iPadDif)
        //=block3WordCountLabel.backgroundColor = .red
        // block3WordCountLabel.adjustsFontSizeToFitWidth = true
        
        
        
        
        //block0BookImg.frame = CGRect(x: width - width / 6, y: block0WordCountLabel.frame.origin.y + height / 70, width: 41 * titleDif, height: 45 * titleDif)
       // block1BookImg.frame = CGRect(x: width - width / 6, y: block1WordCountLabel.frame.origin.y + height / 70, width: 41 * titleDif, height: 45 * titleDif)
        //block2BookImg.frame = CGRect(x: width - width / 6, y: block2WordCountLabel.frame.origin.y + height / 70, width: 41 * titleDif, height: 45 * titleDif)
        //block3BookImg.frame = CGRect(x: width - width / 6, y: block3WordCountLabel.frame.origin.y + height / 70, width: 41 * titleDif, height: 45 * titleDif)
        
        
        // Do any additional setup after loading the view.
        
        
        ghostBtn.frame = CGRect(x: 0, y: 0, width: width, height: height)
        let lightGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.58)
        ghostBtn.backgroundColor = lightGray
        alertBg.frame = CGRect(x: (width - 237 * dif) / 2, y: height * 1 / 4, width: 237 * dif, height: 156 * dif)
        alertBg.image = UIImage(named: "noClassAlertBg.png")
        
        alertText.frame = CGRect(x: 5 * dif , y: 5 * dif, width: alertBg.frame.width - 5 * dif * 2, height: alertBg.frame.height / 2)
        alertText.font = UIFont(name: "Helvetica Neue Bold", size: 26)
        alertText.textColor = .white
        alertText.text = ""
        alertText.numberOfLines = 0
        alertText.textAlignment = .center
        alertText.adjustsFontSizeToFitWidth = true
        
        alertBg.addSubview(alertText)
        let darkRed = UIColor.init(red: 192/255, green: 40/255, blue: 75/255, alpha: 1)
        iknowBtn.frame = CGRect(x: (width - 150 * dif) / 2, y: height * 1.6 / 4, width: 150 * dif, height: 36 * dif)
        iknowBtn.titleLabel?.font = UIFont(name: "Helvetica Neue Bold", size: 16)
        iknowBtn.setBackgroundImage(UIImage(named:"noClassOkBtn.png"), for: .normal)
        iknowBtn.setTitle("開始學習", for: .normal)
        iknowBtn.setTitleColor(darkRed, for: .normal)
        iknowBtn.addTarget(self, action: #selector(CoursesViewController.iKnowClicked), for: .touchUpInside)
        self.view.addSubview(ghostBtn)
        
        self.view.addSubview(iknowBtn)
        
        self.view.addSubview(alertBg)
        
        self.view.bringSubview(toFront: iknowBtn)
        
       // if isWelcome == false {
        removeBtns()
        //}
        
        /* 暫時用不到, alpha test用
         noClassBtn.frame = CGRect(x: 0, y: block0LBtn.frame.maxY, width: width, height: height - block0LBtn.frame.maxY)
         
         //noClassBtn.backgroundColor = .red
         
         noClassBtn.addTarget(self, action: #selector(CoursesViewController.noClassNotice), for: .touchUpInside)
         self.view.addSubview(noClassBtn)
         self.view.bringSubview(toFront: iknowBtn)
         
         */
        
        
        /*
        if isGuidingMode{
            
            guideGhost.frame = CGRect(x: 0, y: 0, width: width, height: height)
            guideGhost.layer.zPosition = 12
            //guideGhost.isEnabled = false
            guideGhost.addTarget(self, action: #selector(CoursesViewController.guideStart), for: .touchUpInside)
            self.view.addSubview(guideGhost)
            
            
            
            guideBg.frame = CGRect(x: 0, y: 0, width: width, height: height)
            guideBg.image = UIImage(named: "guideBg.png")
            guideBg.layer.zPosition = 10
            self.view.addSubview(guideBg)
            
            guideTitle.frame = CGRect(x: 0, y: 300, width: width, height: 150)
            guideTitle.font = UIFont(name: "Helvetica Bold", size: 36)
            guideTitle.numberOfLines = 0
            guideTitle.textColor = .white
            guideTitle.textAlignment = .center
            guideTitle.text = "歡迎進入\nMissWord\n畫面導覽"
            guideTitle.layer.zPosition = 11
            //guideTitle.backgroundColor = .green
            self.view.addSubview(guideTitle)
            
            
            //以下兩個為測試用
            
            /*
             guideTitle2.frame = CGRect(x: 0, y: 300, width: width, height: 150)
             guideTitle2.font = UIFont(name: "Helvetica Bold", size: 36)
             guideTitle2.numberOfLines = 0
             guideTitle2.textColor = .white
             guideTitle2.backgroundColor = .yellow
             guideTitle2.textAlignment = .center
             
             guideTitle2.layer.zPosition = 11
             self.view.addSubview(guideTitle2)
             
             guideTitle3.frame = CGRect(x: 0, y: 300, width: width, height: 150)
             guideTitle3.font = UIFont(name: "Helvetica Bold", size: 36)
             guideTitle3.numberOfLines = 0
             guideTitle3.textColor = .white
             guideTitle3.backgroundColor = .red
             guideTitle3.textAlignment = .center
             
             guideTitle3.layer.zPosition = 11
             //self.view.addSubview(guideTitle3)
             */
            
            step2Line0.image = UIImage(named: "step2Line0")
            step2Line0.layer.zPosition = 11
            step2Line1.image = UIImage(named: "step2Line1")
            step2Line1.layer.zPosition = 11
            step2Line2.image = UIImage(named: "step2Line2")
            step2Line2.layer.zPosition = 11
            
            
            
            step2Circle.image = UIImage(named: "step2Circle.png")
            step2Circle.layer.zPosition = 11
            
            
            //以下為測試用
            /*
             step2Circle2.image = UIImage(named: "step2Circle.png")
             step2Circle2.layer.zPosition = 11
             
             step2Circle3.image = UIImage(named: "step2Circle.png")
             step2Circle3.layer.zPosition = 11
             */
            
            
            
            
            guideText.frame = CGRect(x: 0, y: 600, width: width, height: 30)
            guideText.font = UIFont(name: "Helvetica Neue", size: 18)
            guideText.numberOfLines = 0
            guideText.textColor = .white
            guideText.textAlignment = .center
            guideText.text = "點擊繼續下一步"
            guideText.layer.zPosition = 11
            self.view.addSubview(guideText)
            
            



        }

        */

        
        sepLine0.frame = CGRect(x: 0, y: height / 4.2, width: width, height: 1)
        sepLine1.frame = CGRect(x: 0, y: height / 2.2, width: width, height: 1)
        sepLine2.frame = CGRect(x: 0, y: height / 1.5, width: width, height: 1)
        

        /*
        bottomLabel.frame = CGRect(x: 0, y: bottomBg.frame.minY, width: width, height: bottomBg.frame.height)
        bottomLabel.numberOfLines = 2
        bottomLabel.textAlignment = .center
        bottomLabel.text = "更多字庫即將上架\ncoming soon..."
*/

        
        bigNameLabel.frame = CGRect(x: logOutBtn.frame.minX, y: logOutBtn.frame.maxY * 1.5 * titleDif * titleDif, width:  190, height: 42)

        //bigNameLabel.backgroundColor = .red
        bigNameLabel.adjustsFontSizeToFitWidth = true
        userStatusLabel.frame = CGRect(x: bigNameLabel.frame.minX, y: bigNameLabel.frame.maxY, width: 190, height: 55)
       // userStatusLabel.backgroundColor = .green
        dayTitleLabel.frame = CGRect(x: block0WordCountLabel.frame.minX * titleDif, y: bigNameLabel.frame.midY - 3, width: 160, height: 25)
       // dayTitleLabel.backgroundColor = .blue
        daysLabel.frame = CGRect(x: block0WordCountLabel.frame.minX * titleDif, y: dayTitleLabel.frame.maxY, width: 160, height: 55)
        //daysLabel.backgroundColor = .purple
        daysLabel.adjustsFontSizeToFitWidth = true
        
        bigNameLabel.text = "Ethan Li"
        userStatusLabel.text = "免費用戶\n新課程：每天7分鐘\n單字集/挑戰模式：不限時間"
        //userStatusLabel.backgroundColor = .red
        dayTitleLabel.text = "學習天數"
        daysLabel.text = ""
        
        
        //稍稍靠右邊
        logoImg.center = CGPoint(x: width / 2 + 5, y: height / 8)
        logoImg.frame.size = CGSize(width: 135 * dif, height: 131 * dif)

      //recommendedClass = "英檢中級"
       
        if recommendedClass != nil {
        
            
            //假如尚未註冊者, 就是開始引導
            
            var posX = CGFloat()
            var posY = CGFloat()
            
            
            // recommendedClass = "英檢初級"
            
            switch recommendedClass{
                
            case "英檢初級":
                print("初級")
                posX = block0LBtn.frame.minX
                posY = block0LBtn.frame.midY
                
                
            case "英檢中級":
                print("中級")
                posX = block1LBtn.frame.minX
                posY = block1LBtn.frame.midY
                
                
            case "多益滿分":
                print("多益")
                posX = block2LBtn.frame.minX
                posY = block2LBtn.frame.midY
                
            default:
                break
                
                
            }
            
            finger.frame = CGRect(x: posX, y: posY, width: 67, height: 88)
            //finger.alpha = 0
            point.center = CGPoint(x: finger.frame.midX, y: finger.frame.minY)
            point.frame.size = CGSize(width: 45, height: 45)
            //point.alpha = 0
            
            fingerAnimation()
            
                   //fingerTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(CoursesViewController.fingerAnimation), userInfo: nil, repeats: true)
        
        }
    }
    
    
    var repeatTimes = 0
    
func fingerAnimation(){
        
        
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveLinear, animations: {[weak self] in
             self!.finger.alpha = 1
            self!.point.alpha = 1
       
        
        }) { (finished:Bool) in
            
            if finished {
                
                UIView.animate(withDuration: 0.6, animations: {[weak self] in
                 
                    self!.point.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                    self!.point.alpha = 0
                }, completion: {[weak self] (finished:Bool) in
                    
          
                    self!.point.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self!.point.alpha = 1
                    
                    UIView.animate(withDuration: 0.6, animations: {[weak self] in
                        self!.point.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                        self!.point.alpha = 0
                        self!.finger.alpha = 0
                        }, completion: {[weak self] (finished:Bool) in

                            self!.point.transform = CGAffineTransform(scaleX: 1, y: 1)
                            
 
                           
                            self!.repeatTimes += 1
                            
                            
                            if self!.repeatTimes < 6{
                             self!.fingerAnimation()
                            }
                            
                            
                            
                    })
                    
                    
                    
                    
                })
                
                
                
                
            }
            
            
            
            
            
            
        }
        
        
        
    }
    
    
    @objc func repeatFinger(){
        
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseIn, animations: {[weak self] in
            self!.finger.alpha = 1
            self!.point.alpha = 1
        }) { (finished:Bool) in
            
            if finished {
                
                UIView.animate(withDuration: 0.6, animations: {[weak self] in
                    
                    self!.point.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                    self!.point.alpha = 0
                    }, completion: {[weak self] (finished:Bool) in
                        
                        
                        self!.point.transform = CGAffineTransform(scaleX: 1, y: 1)
                        self!.point.alpha = 1
                        
                        UIView.animate(withDuration: 0.6, animations: {[weak self] in
                            self!.point.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                            self!.point.alpha = 0
                            self!.finger.alpha = 0
                            }, completion: {[weak self] (finished:Bool) in
                                
                                self!.point.transform = CGAffineTransform(scaleX: 1, y: 1)
                                UIView.animate(withDuration: 0.3, animations: {[weak self] in
                                    
                                })
                                
                                
                                
                                
                        })
                        
                        
                        
                        
                })
                
                
                
                
            }
            

            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        fingerTimer.invalidate()
        //self.view.layer.removeAllAnimations()
        finger.alpha = 0
        point.alpha = 0
        
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    
        self.view.subviews.forEach({$0.layer.removeAllAnimations()})
        self.view.layer.removeAllAnimations()
        self.view.layoutIfNeeded()

    }
    
    @objc func guideStart(){
        
        
        let attrs0 = [NSAttributedStringKey.font : UIFont(name: "Helvetica Bold", size: 24), NSAttributedStringKey.foregroundColor : UIColor.white]
        let attrs1 = [NSAttributedStringKey.font : UIFont(name: "Helvetica Bold", size: 24), NSAttributedStringKey.foregroundColor : specialRed]
        
        
        if guideStep == 0 {
            
            guideTitle.frame = CGRect(x: width / 8, y: height / 3.8, width: 160, height: 99)
            guideTitle.font = UIFont(name: "Helvetica Bold", size: 24)
            guideTitle.text = "由此可進入個\n人學習紀錄及\n成就排行榜！"
            
            
            step0Line.frame = CGRect(x: width / 3.3, y: height / 9.8, width: 30, height: 105)
            step0Line.image = UIImage(named: "step0Line.png")
            step0Line.layer.zPosition = 12
            self.view.addSubview(step0Line)
            
            step0Chart.frame = CGRect(x: width / 4.5, y: height / 2.5, width: 76, height: 86)
            step0Chart.image = UIImage(named: "step0Champion.png")
            step0Chart.layer.zPosition = 11
            
            
            self.view.addSubview(step0Chart)
            
            /*
             step0Circle.frame = CGRect(x: width / 3.2, y: dialogueBg.frame.minY - 5, width: 52, height: 52)
             step0Circle.image = UIImage(named: "step0Circle.png")
             step0Circle.layer.zPosition = 11
             self.view.addSubview(step0Circle)
             */
            step0Person.frame = CGRect(x: width / 3 + 2, y: dialogueBg.frame.minY, width: 36, height: 36)
            step0Person.image = UIImage(named: "person.png")
            step0Person.layer.zPosition = 11
            self.view.addSubview(step0Person)
            
        } else if guideStep == 1 {
            
            
            
            
            step0Person.isHidden = true
            step0Chart.isHidden = true
            step0Line.isHidden = true
            step0Circle.isHidden = true
            
            headPhone.frame = CGRect(x: width / 4.5, y: height / 10, width: 67, height: 55)
            
            headPhone.image = UIImage(named: "headphone.png")
            headPhone.layer.zPosition = 12
            self.view.addSubview(headPhone)
            
            
            let text0 = NSMutableAttributedString(string: "每個課程的右\n側為單字紀錄\n本，學過的單\n字可以", attributes: attrs0)
            
            let text1 = NSMutableAttributedString(string: "自動播\n放，隨選播放", attributes: attrs1)
            let text2 = NSMutableAttributedString(string: "來練習聽力！", attributes: attrs0)
            let attrWords = NSMutableAttributedString()
            attrWords.append(text0)
            attrWords.append(text1)
            attrWords.append(text2)
            
            
            
            guideTitle.frame = CGRect(x: width / 9, y: height / 5, width: 160, height: 198)
            
            guideTitle.font = UIFont(name: "Helvetica Bold", size: 24)
            guideTitle.attributedText = attrWords
            
            
            step1Line0.frame = CGRect(x: width / 2, y: height / 5, width: 104, height: 39)
            step1Line0.image = UIImage(named: "step1Line0.png")
            step1Line0.contentMode = .scaleAspectFit
            step1Line0.layer.zPosition = 11
            self.view.addSubview(step1Line0)
            
            step1Line1.frame = CGRect(x: width / 2, y: height / 3, width: 104, height: 30)
            step1Line1.image = UIImage(named: "step1Line1.png")
            step1Line1.contentMode = .scaleAspectFit
            step1Line1.layer.zPosition = 11
            self.view.addSubview(step1Line1)
            
            step1Line2.frame = CGRect(x: width / 2, y: height / 2.2, width: 86, height: 56)
            step1Line2.image = UIImage(named: "step1Line2.png")
            step1Line2.contentMode = .scaleAspectFit
            step1Line2.layer.zPosition = 11
            self.view.addSubview(step1Line2)
            
            step1Circle0.frame = CGRect(x: block0RBtn.frame.minX + 10, y: height / 14, width: 74, height: 136)
            step1Circle0.image = UIImage(named: "step1Circle.png")
            step1Circle0.layer.zPosition = 11
            self.view.addSubview(step1Circle0)
            
            step1Circle1.frame = CGRect(x: block0RBtn.frame.minX + 10, y: height * 3.5 / 12, width: 74, height: 136)
            step1Circle1.image = UIImage(named: "step1Circle.png")
            step1Circle1.layer.zPosition = 11
            self.view.addSubview(step1Circle1)
            
            step1Circle2.frame = CGRect(x: block0RBtn.frame.minX + 10 , y: height * 6.5 / 12, width: 74, height: 136)
            step1Circle2.image = UIImage(named: "step1Circle.png")
            step1Circle2.layer.zPosition = 11
            self.view.addSubview(step1Circle2)
            
            
            step1Book0.frame = CGRect(x: block0RBtn.frame.minX + block0RBtn.frame.width / 2 - 20, y: block0RBtn.frame.minY + block0RBtn.frame.height / 2 + 10, width: 41, height: 45)
            step1Book0.image = UIImage(named: "bookPng.png")
            step1Book0.layer.zPosition = 11
            self.view.addSubview(step1Book0)
            
            step1Book1.frame = CGRect(x: block1RBtn.frame.minX + block1RBtn.frame.width / 2 - 20, y: block1RBtn.frame.minY + block1RBtn.frame.height / 2 - 20, width: 41, height: 45)
            step1Book1.image = UIImage(named: "bookPng.png")
            step1Book1.layer.zPosition = 11
            self.view.addSubview(step1Book1)
            
            //之後加入btn後需要修改裡面的參數
            
            step1Book2.frame = CGRect(x: block1RBtn.frame.minX + block1RBtn.frame.width / 2 - 20, y: block1RBtn.frame.maxY + block1RBtn.frame.height / 2 - 20, width: 41, height: 45)
            step1Book2.image = UIImage(named: "bookPng.png")
            step1Book2.layer.zPosition = 11
            
            self.view.addSubview(step1Book2)
            
            
            
        } else if guideStep == 2 {
            
            
            headPhone.isHidden = true
            step1Line0.isHidden = true
            step1Line1.isHidden = true
            step1Line2.isHidden = true
            
            step1Circle0.isHidden = true
            step1Circle1.isHidden = true
            step1Circle2.isHidden = true
            step1Book0.isHidden = true
            step1Book1.isHidden = true
            step1Book2.isHidden = true
            
            let attrWords = NSMutableAttributedString()
            
            var text0 = NSMutableAttributedString()
            var text1 = NSMutableAttributedString()
            
            var text2 = NSMutableAttributedString()
            
            text0 = NSMutableAttributedString(string: "稍後開始學習單字，\nMissWord建議你先從\n", attributes: attrs0)
            
            //recommendedClass = "多益滿分"
            
            text1 = NSMutableAttributedString(string: recommendedClass!, attributes: attrs1)
            text2 = NSMutableAttributedString(string: "開始喔！", attributes: attrs0)
            
            
            guideText.text = "點擊畫面結束導覽"
            
            switch recommendedClass{
                
            case "英檢初級":
                
                guideTitle.frame = CGRect(x: width / 20, y: height / 2.5, width: width * 2 / 3, height: 99)
                
                //guideTitle.frame =  CGRect(x: width / 20, y: block1.frame.minY, width: width * 2 / 3, height: 99)
                
                step2Circle.frame = CGRect(x: width / 20, y: block0.frame.minY + 50, width: 256, height: 116)
                
                
                /*
                 step2Circle2.frame = CGRect(x: width / 20, y: block1.frame.minY + 30, width: 256, height: 116)
                 step2Circle3.frame = CGRect(x: width / 20, y: block2.frame.minY + 40, width: 256, height: 116)
                 */
                step2Line0.frame = CGRect(x: block1.frame.width / 3, y: block1.frame.minY, width: 31, height: 106)
                
               // guideTitle2.frame = CGRect(x: width / 20, y: block0.frame.minY + 10, width: width * 2 / 3, height: 99)
                
               // guideTitle3.frame = CGRect(x: width / 20, y: block1.frame.minY, width: width * 2 / 3, height: 99)
                self.view.addSubview(step2Line0)
                
            case "英檢中級":
                
                guideTitle.frame = CGRect(x: width / 20, y: block0.frame.minY + 10, width: width * 2 / 3, height: 99)
                step2Circle.frame = CGRect(x: width / 20, y: block1.frame.minY + 30, width: 256, height: 116)
                step2Line1.frame = CGRect(x: block0.frame.width / 3, y: block0.frame.midY + 15, width: 25, height: 86)
                self.view.addSubview(step2Line1)
            case "多益滿分":
                
                guideTitle.frame = CGRect(x: width / 20, y: block1.frame.minY, width: width * 2 / 3, height: 99)
                
                step2Circle.frame = CGRect(x: width / 20, y: block2.frame.minY + 40, width: 256, height: 116)
                text0 = NSMutableAttributedString(string: "稍後開始學習單字，\nMissWord建議可以學習\n", attributes: attrs0)
                
                text2 = NSMutableAttributedString(string: "喔！", attributes: attrs0)
                
                
                step2Line2.frame = CGRect(x: block1.frame.width / 3, y: block1.frame.midY + 10, width: 30, height: 105)

                self.view.addSubview(step2Line2)
            default:
                break
                
                
            }
            
            attrWords.append(text0)
            attrWords.append(text1)
            attrWords.append(text2)
            guideTitle.attributedText = attrWords
           // guideTitle2.attributedText = attrWords
           // guideTitle3.attributedText = attrWords
            
            self.view.addSubview(step2Circle)
            //self.view.addSubview(step2Circle2)
            //self.view.addSubview(step2Circle3)
            
            
        } else if guideStep == 3 {
            
            guideTitle.isHidden = true
            step2Circle.isHidden = true
            step2Line0.isHidden = true
            step2Line1.isHidden = true
            step2Line2.isHidden = true
            guideText.isHidden = true
            guideBg.isHidden = true
            guideGhost.isHidden = true
            

            
            
            
        }
        
        
        guideStep += 1
        
        
    }
    
    func daysBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    
    @IBAction func toChartVcBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "toChartVc", sender: self)

    }
    @IBAction func toShopVcBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "toShopVc", sender: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
    
        
        finger.alpha = 0
        point.alpha = 0
       
        
         var nickname = String()
         var purchaseStatus = String()
         //測試用
         
         if user != nil {
         nickname = user?["nickname"] as! String
         let isPurchased = user?["isPurchased"] as? String
            if isPurchased == "0"{
                
                purchaseStatus = "免費用戶\n新課程：每天7分鐘\n單字集/挑戰模式：不限時間"
            } else if isPurchased == "1"{
                
                purchaseStatus = "付費用戶\n新課程：不限時間\n單字集/挑戰模式：不限時間"
            }
            
            
            let startDateString = user?["date"] as! String
            let startDate = startDateString.components(separatedBy: " ")
            let start = dateFormatter.date(from: startDate[0])
            let todayString = Date()
            let today = dateFormatter.string(from: todayString)
            print("today:\(today)")
            let todayDate = dateFormatter.date(from: today)
            
            
            let days = daysBetween(start: start!, end: todayDate!)

            daysLabel.text = String(days)
            
            
         } else {
         nickname = "新學生"
            purchaseStatus = "免費用戶\n新課程：每天7分鐘\n單字集/挑戰模式：不限時間"
            daysLabel.text = "0"
         }


        bigNameLabel.text = "Hi!" + nickname
        userStatusLabel.text = purchaseStatus
        
        
        
        if isRegistered == false{
            
            logOutBtn.isHidden = true
        } else {
            
            logOutBtn.isHidden = false
        }
        

        /*
        if isWelcome{
      
                openAlert(text: "\nHi！\(nickname)！\n歡迎註冊MissWord\n我的單字老師\n祝你學習愉快！")

        }
        */
        

        
        //抓gamePassed
        let decodedObject = UserDefaults.standard.object(forKey: "gamePassed") as? NSData
        
        if let decoded = decodedObject {
            gamePassed = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int : Int]
        }
        //抓mapPassed
        mapPassed = UserDefaults.standard.object(forKey: "mapPassed") as? Int
        
        
        
        //抓gamePassed2
        let decodedObject2 = UserDefaults.standard.object(forKey: "gamePassed2") as? NSData
        
        if let decoded = decodedObject2 {
            gamePassed2 = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int : Int]
        }
        
        //抓mapPassed2
        mapPassed2 = UserDefaults.standard.object(forKey: "mapPassed2") as? Int
        
        //抓gamePassed3
        let decodedObject3 = UserDefaults.standard.object(forKey: "gamePassed3") as? NSData
        
        if let decoded = decodedObject3 {
            gamePassed3 = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int : Int]
        }
        
        //抓mapPassed3
        mapPassed3 = UserDefaults.standard.object(forKey: "mapPassed3") as? Int
        
        
    }
    
    @objc func noClassNotice(){
        
        openAlert(text: "目前只開放英檢初級課程喔！其餘課程將於6月正式上線開放！")
    }
    
    
    @objc func iKnowClicked(){
        
        print("clicked")
        isWelcome = false
        removeBtns()
    }
    
    func removeBtns(){
        
        alertBg.isHidden = true
        iknowBtn.isHidden = true
        ghostBtn.isHidden = true
        alertText.text = ""
        iknowBtn.isEnabled = false
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func elementaryClicked(_ sender: Any) {
        courseSent = 0
        performSegue(withIdentifier: "toStageVc", sender: self)
    }
    
    @IBAction func intermedaiteClicked(_ sender: Any) {
        courseSent = 1
        performSegue(withIdentifier: "toStageVc", sender: self)
        
    }
    
    @IBAction func toeicClicked(_ sender: Any) {
        courseSent = 2
        performSegue(withIdentifier: "toStageVc", sender: self)
        
    }
    /*
     @IBAction func intermediateClicked(_ sender: Any) {
     
     courseSent = 1
     performSegue(withIdentifier: "toStageVc", sender: self)
     
     }
     
     @IBAction func toeicClicked(_ sender: Any) {
     
     }
     
     @IBAction func toeflClicked(_ sender: Any) {
     
     }
     */
    @IBAction func toNewBookBtn(_ sender: Any) {
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        let time = DispatchTime.now() + 0.1
        DispatchQueue.main.asyncAfter(deadline: time) {[weak self] in
            self!.courseSent = 0
            self!.performSegue(withIdentifier: "toNewBookVc", sender: self)
        }
        
        
        
    }
    
    
    
    @IBAction func toNewBook2Btn(_ sender: Any) {
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        let time = DispatchTime.now() + 0.1
        DispatchQueue.main.asyncAfter(deadline: time) {[weak self] in
            self!.courseSent = 1
            self!.performSegue(withIdentifier: "toNewBookVc", sender: self)
        }
        
        
    }
    @IBAction func toNewBook3Btn(_ sender: Any) {
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        let time = DispatchTime.now() + 0.1
        DispatchQueue.main.asyncAfter(deadline: time) {[weak self] in
            self!.courseSent = 2
            self!.performSegue(withIdentifier: "toNewBookVc", sender: self)
        }
    }
    
    @IBAction func toInfoVcClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toInfoVc", sender: self)
    }
    
    
    
    @IBAction func logOutClicked(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "parseJSON")
        
        /*
        UserDefaults.standard.removeObject(forKey: "mapPassed")
        UserDefaults.standard.removeObject(forKey: "gamePassed")
        UserDefaults.standard.removeObject(forKey: "mapPassed2")
        UserDefaults.standard.removeObject(forKey: "gamePassed2")
        UserDefaults.standard.removeObject(forKey: "mapPassed3")
        UserDefaults.standard.removeObject(forKey: "gamePassed3")
 */
        //UserDefaults.standard.removeObject(forKey: "isIntroWatched")
        //UserDefaults.standard.removeObject(forKey: "isRegistered")
        //UserDefaults.standard.removeObject(forKey: "previousDate")
        //UserDefaults.standard.removeObject(forKey: "limitSeconds")
        

        
        
        let loginVc = storyboard?.instantiateViewController(withIdentifier: "loginVc")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginVc!
        
    }
    
    func openAlert(text:String){
        
        alertBg.isHidden = false
        iknowBtn.isHidden = false
        ghostBtn.isHidden = false
        alertText.text = text
        iknowBtn.isEnabled = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "toNewBookVc"{
            
            let destinationVc = segue.destination as! NewBookViewController
            
            //之後這裡要傳送的是課程名稱
            destinationVc.courseReceived = courseSent
            
            
        }
        
        
        if segue.identifier == "toStageVc"{
            
            let destinationVc = segue.destination as! StageViewController
            
            destinationVc.courseReceived = courseSent
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
