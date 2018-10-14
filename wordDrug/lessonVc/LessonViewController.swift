//
//  LessonViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/4/19.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit
import AVFoundation

class LessonViewController: UIViewController{
    
    
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var syllableLabel: UILabel!
    @IBOutlet weak var lessonLabel: UILabel!
    @IBOutlet weak var lessonTitleLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    @IBOutlet weak var progressLength: UIImageView!
    @IBOutlet weak var fullLength: UIImageView!
    @IBOutlet weak var enterBtn: UIButton!
    let pinkColor = UIColor.init(red: 247/255, green: 127/255, blue: 124/255, alpha: 1)
    var mapNumToReceive = Int()
   
    
    //被選擇到的音節
    var syllableSets = [[String]()]
    
    var wordSets = [String]()
    //做三個字
    var words = [NSMutableAttributedString(),NSMutableAttributedString(),NSMutableAttributedString()]
    
    var mapNum = Int()
    var spotNum = Int()
    var unitNum = Int()
    var gameMode = Int()
    
    @IBOutlet weak var reviewBtn: UIButton!
    
    //所有alertView的變數
    var alertBg = UIImageView()
    var alertText = UILabel()
    var ghostBtn = UIButton()
    //var ghost2Btn = UIButton()
    var practiceWordBtn = UIButton()
    var practiceSenBtn = UIButton()
    var leftBtnClickedImg = UIImageView()
    var rightBtnClickedImg = UIImageView()
    var bigQuitBtn = UIButton()
    let darkRed = UIColor.init(red: 192/255, green: 40/255, blue: 75/255, alpha: 1)
    let orangeColor = UIColor.init(red: 232/255, green: 98/255, blue: 61/255, alpha: 1)
    
    @IBOutlet weak var hintLabel: UILabel!
    
    //發音單字
    var synWord = String()
    
    //Text to speech合成器
    var synth = AVSpeechSynthesizer()
    var audioSession = AVAudioSession.sharedInstance()
   
    @IBOutlet weak var titleLabel: UILabel!
    
    //收到的課程數字
    var courseReceived = Int()
    
    
    var isClassAllPassed = false
    
    var maxMapNum = Int()
    var sylFontSize = CGFloat()
    var wordFontSize = CGFloat()
    var titleFontSize = CGFloat()
    
    var hiddenBtn = UIButton()
    
    var lessonTitleFontSize: CGFloat!
    var lessonBigFontSize: CGFloat!
    var lessonSmallFontSize: CGFloat!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        var dif = CGFloat()
 
        var iPadSizeDif: CGFloat!
        var btnFontSize:CGFloat!
        var hintLabelFontSize:CGFloat!
        
        switch height {
            
        case 1366, 1336, 1112:
            print("big iPad")
   

            dif = 0.9
            iPadSizeDif = 2.3
            
            sylFontSize = 170
            wordFontSize = 70
            titleFontSize = 45
            lessonTitleFontSize = 25
            lessonBigFontSize = 60
            lessonSmallFontSize = 20
            btnFontSize = 40
            hintLabelFontSize = 30
        
            
        case 1024:
            
            print("small iPad")
  
            dif = 0.9
            iPadSizeDif = 2
            
            sylFontSize = 160
            wordFontSize = 60
            titleFontSize = 45
            lessonTitleFontSize = 25
            lessonBigFontSize = 60
            lessonSmallFontSize = 20
            btnFontSize = 40
            hintLabelFontSize = 30
        
            
        case 812:
            
       
            dif = 1
            iPadSizeDif = 1
            
            sylFontSize = 130
            wordFontSize = 40
            titleFontSize = 28
            lessonTitleFontSize = 14
            lessonBigFontSize = 30
            lessonSmallFontSize = 15
            btnFontSize = 22
            hintLabelFontSize = 16
 

        case 736:
  
            dif = 1.1
            iPadSizeDif = 1
            
            sylFontSize = 130
            wordFontSize = 40
            titleFontSize = 28
            lessonTitleFontSize = 12
            lessonBigFontSize = 30
            lessonSmallFontSize = 15
            btnFontSize = 22
            hintLabelFontSize = 16
          
            
        case 667:
            
   
            dif = 1
            iPadSizeDif = 1
            
            sylFontSize = 120
            wordFontSize = 35
            titleFontSize = 24
            lessonTitleFontSize = 12
            lessonBigFontSize = 30
            lessonSmallFontSize = 15
            btnFontSize = 20
            hintLabelFontSize = 16
      
            
        case 568:
     
            dif = 0.9
            iPadSizeDif = 1


            sylFontSize = 100
            wordFontSize = 30
            titleFontSize = 20
            lessonTitleFontSize = 12
            lessonBigFontSize = 30
            lessonSmallFontSize = 15
            btnFontSize = 20
            hintLabelFontSize = 16
      
       
        default:

            break
        }
   
        
        //加入alertView
        let lightGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.58)
        ghostBtn.backgroundColor = lightGray
        ghostBtn.addTarget(self, action: #selector(LessonViewController.removeBtns), for: .touchUpInside)
        self.view.addSubview(ghostBtn)
        ghostBtn.fillSupervivew()
        
    

        alertBg.translatesAutoresizingMaskIntoConstraints = false
        alertBg.image = UIImage(named: "reviewSelectBg3.png")
        self.view.addSubview(alertBg)
        alertBg.widthAnchor.constraint(equalToConstant: 237 * iPadSizeDif).isActive = true
        alertBg.heightAnchor.constraint(equalToConstant: 140 * iPadSizeDif).isActive = true
        alertBg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertBg.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        
    

        alertText.translatesAutoresizingMaskIntoConstraints = false
        //alertText.backgroundColor = .blue
        alertText.font = UIFont(name: "Helvetica Bold", size: hintLabelFontSize)
        alertText.textColor = .white
        alertText.text = "請選擇挑戰模式"
        alertText.numberOfLines = 3
        alertText.textAlignment = .center
        alertText.adjustsFontSizeToFitWidth = true
        alertBg.addSubview(alertText)
        alertText.widthAnchor.constraint(equalToConstant: 200 * iPadSizeDif).isActive = true
        alertText.heightAnchor.constraint(equalToConstant: 80 * iPadSizeDif).isActive = true
        alertText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertText.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10).isActive = true

        
    
        practiceWordBtn.titleLabel?.font = UIFont(name: "Helvetica Bold", size: hintLabelFontSize)
        practiceWordBtn.setTitle("拼字王挑戰", for: .normal)
        practiceWordBtn.setTitleColor(orangeColor, for: .normal)
        practiceWordBtn.addTarget(self, action: #selector(LessonViewController.practiceWord), for: .touchUpInside)
        //practiceWordBtn.backgroundColor = .green
        //practiceWordBtn.alpha = 0.5
        //practiceWordBtn.layer.zPosition = 10
        self.view.addSubview(practiceWordBtn)
       
        practiceWordBtn.anchor(top: alertText.bottomAnchor, leading: alertBg.leadingAnchor, bottom: alertBg.bottomAnchor, trailing: nil, size: .init(width: 119 * iPadSizeDif, height: alertBg.frame.height / 3))

        //practiceSenBtn.backgroundColor = .brown
        //practiceSenBtn.alpha = 0.5
        practiceSenBtn.titleLabel?.font = UIFont(name: "Helvetica Bold", size: hintLabelFontSize)
        practiceSenBtn.setTitle("句型冠軍榜", for: .normal)
        practiceSenBtn.setTitleColor(orangeColor, for: .normal)
        practiceSenBtn.addTarget(self, action: #selector(LessonViewController.practiceSen), for: .touchUpInside)
        self.view.addSubview(practiceSenBtn)
        practiceSenBtn.anchor(top: alertText.bottomAnchor, leading: practiceWordBtn.trailingAnchor, bottom: alertBg.bottomAnchor, trailing: nil)
        practiceSenBtn.anchorSize(to: practiceWordBtn)
        
        bigQuitBtn = UIButton(type: .system)
       
 
        bigQuitBtn.titleLabel?.font = UIFont(name: "Helvetica Bold", size: hintLabelFontSize)
        bigQuitBtn.setTitle("我知道了", for: .normal)
        bigQuitBtn.setTitleColor(orangeColor, for: .normal)
        //bigQuitBtn.backgroundColor = .blue
        bigQuitBtn.addTarget(self, action:#selector(LessonViewController.removeBtns), for: .touchUpInside)
        self.view.addSubview(bigQuitBtn)
        bigQuitBtn.anchor(top: alertText.bottomAnchor, leading: alertBg.leadingAnchor, bottom: alertBg.bottomAnchor, trailing: alertBg.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        
 

        
        backBtn.anchor(top: view.safeTopAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: nil, padding: .init(top: 30, left: 10, bottom: 0, right: 0), size: .init(width: 19 * iPadSizeDif, height: 31 * iPadSizeDif))
        
        
        //backBtn.backgroundColor = .blue

        
        lessonTitleLabel.anchor(top: view.safeTopAnchor, leading: nil, bottom: nil, trailing: view.safeRightAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: -20), size: .init(width: 66 * iPadSizeDif, height: 22 * iPadSizeDif))
    
        lessonTitleLabel.textAlignment = .right
        lessonTitleLabel.font = lessonTitleLabel.font.withSize(lessonTitleFontSize)
        
        

        lessonLabel.anchor(top: lessonTitleLabel.bottomAnchor, leading: nil, bottom: nil, trailing: view.safeRightAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: -20), size: .zero)

        lessonLabel.anchorSize(to: lessonTitleLabel)
        
        titleLabel.anchor(top: lessonTitleLabel.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: view.safeRightAnchor, size: .init(width: width, height: 72 * dif * iPadSizeDif))
        
        //titleLabel.backgroundColor = .red

        titleLabel.numberOfLines = 2
        titleLabel.text = "即將學習\n下列三個新單字"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = titleLabel.font.withSize(titleFontSize)
        
     
        
        syllableLabel.anchor(top: titleLabel.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: view.safeRightAnchor, size: .init(width: width, height: height / 3.5 * dif))
        syllableLabel.adjustsFontSizeToFitWidth = true
        syllableLabel.font = syllableLabel.font.withSize(sylFontSize)
        
        syllableLabel.textAlignment = .center
      
    
        firstLabel.anchor(top: syllableLabel.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: view.safeRightAnchor, size: .init(width: width, height: 44 * dif * iPadSizeDif))
        firstLabel.adjustsFontSizeToFitWidth = true
        firstLabel.font = firstLabel.font.withSize(wordFontSize)
        
        
     
         secondLabel.anchor(top: firstLabel.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: view.safeRightAnchor, size: .zero)
        
        secondLabel.anchorSize(to: firstLabel)
        
        secondLabel.adjustsFontSizeToFitWidth = true
        secondLabel.font = secondLabel.font.withSize(wordFontSize)
        
        

        thirdLabel.anchor(top: secondLabel.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: view.safeRightAnchor)
        
        thirdLabel.anchorSize(to: secondLabel)
        
        thirdLabel.adjustsFontSizeToFitWidth = true
        thirdLabel.font = thirdLabel.font.withSize(wordFontSize)

        
        enterBtn.anchor(top: nil, leading: nil, bottom: view.safeBottomAnchor, trailing: view.safeRightAnchor, size: .init(width: width / 2, height: 50 * iPadSizeDif))
        
        reviewBtn.anchor(top: nil, leading: view.safeLeftAnchor, bottom: view.safeBottomAnchor, trailing: nil)
        reviewBtn.anchorSize(to: enterBtn)


        enterBtn.titleLabel?.font = enterBtn.titleLabel?.font.withSize(btnFontSize)
        reviewBtn.titleLabel?.font = reviewBtn.titleLabel?.font.withSize(btnFontSize)
        

        fullLength.anchor(top: nil, leading: view.safeLeftAnchor, bottom: enterBtn.topAnchor, trailing: view.safeRightAnchor, size: .init(width: width, height: 3))

        

        hintLabel.anchor(top: nil, leading: view.safeLeftAnchor, bottom: fullLength.topAnchor, trailing: view.safeRightAnchor, padding: .init(top: 0, left: 0, bottom: -5, right: 0) ,size: .init(width: width, height: 21 * dif * iPadSizeDif))
        
         hintLabel.font = hintLabel.font.withSize(hintLabelFontSize)
        
        //拉到最前方
        self.view.bringSubview(toFront: ghostBtn)
         self.view.bringSubview(toFront: alertBg)
        
        self.view.bringSubview(toFront: practiceWordBtn)
        self.view.bringSubview(toFront: practiceSenBtn)
        self.view.bringSubview(toFront: leftBtnClickedImg)
        self.view.bringSubview(toFront: rightBtnClickedImg)
        self.view.bringSubview(toFront: bigQuitBtn)
  
        
        
        /*
        firstLabel.backgroundColor = .red
        lessonTitleLabel.backgroundColor = .yellow
        secondLabel.backgroundColor = .green
        thirdLabel.backgroundColor = .yellow
        hintLabel.backgroundColor = .green
        lessonLabel.backgroundColor = .red
        syllableLabel.backgroundColor = .blue
        */
        
        
        removeBtns()

    }
    
    //syn發音, 用不到
    func synPronounce(){
        print("pronounce")
        print(synWord)
        
        do {
            
            //設置成ambient看能不能避免任何interruption 造成當機
            
            try audioSession.setCategory(AVAudioSessionCategoryAmbient)
            try audioSession.setMode(AVAudioSessionModeDefault)
            try audioSession.setActive(true)
            
        } catch  {
            print("error")
        }
        
        
        
        var rateFloat = Float()
        
        let utterance = AVSpeechUtterance(string: synWord)
        let utterance2 = AVSpeechUtterance(string: synWord)
        
        
            rateFloat = 0.45
            utterance.postUtteranceDelay = 0
    
        utterance2.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance2.rate = rateFloat
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = rateFloat
        
        
        //stopSpeech()
         //發音等待時間
         let when = DispatchTime.now() + 2
         
         DispatchQueue.main.async {[weak self] in
         
         guard let strongSelf = self else{
         return
         }
         //strongSelf.synth.stopSpeaking(at: .immediate)
         strongSelf.synth.speak(utterance)
         
         DispatchQueue.main.asyncAfter(deadline: when, execute: {
         strongSelf.synth.speak(utterance2)
         
         })
         }
         
        
    }

    
    @objc func removeBtns(){
        
        alertText.text = "請選擇挑戰模式"
        ghostBtn.isHidden = true
        alertBg.isHidden = true
        //ghost2Btn.isHidden = true
        practiceWordBtn.isHidden = true
        practiceSenBtn.isHidden = true
        leftBtnClickedImg.isHidden = true
        rightBtnClickedImg.isHidden = true
        bigQuitBtn.isHidden = true
        practiceSenBtn.isEnabled = true
        practiceWordBtn.isEnabled = true
        alertBg.image = UIImage(named: "reviewSelectBg3.png")
    }
    
    
    
    deinit {
        print("lesson deinit")
    }
    
    
    @objc func practiceSen(){
        print("practice Sen")
        
        gameMode = 2
   
        
        practiceWordBtn.isEnabled = false
        practiceSenBtn.isEnabled = false
        
        //有bug, 印出以下兩數字
        
        /*
        print(self!.mapPassedInt)
        print(self!.gamePassedDic)
        */
        
        //這裡沒有大於的可能性
        if gamePassedDic == [0:0] && mapNumToReceive == mapPassedInt{
            
            print("不能練習句子")
            cannotPracticeAlert()
            
        } else {
            
            performSegue(withIdentifier: "toGameVc", sender: self)
        }

    }
    
    @objc func practiceWord(){
        print("practice word")
    
        
        gameMode = 1
        
        UIView.animate(withDuration: 0.06, animations: {[weak self] in
            
            self!.leftBtnClickedImg.alpha = 1
            
            
        }) {[weak self] (finished:Bool) in
            
            
            if finished {
                self!.leftBtnClickedImg.alpha = 0
                self?.practiceSenBtn.isEnabled = false
                self?.practiceWordBtn.isEnabled = false
                
                //這裡沒有大於的可能性
                if self!.gamePassedDic == [0:0] && self!.mapNumToReceive == self!.mapPassedInt{
                    
                    print("不能練習單字")
                    self!.cannotPracticeAlert()
                } else {
                    
                    self!.performSegue(withIdentifier: "toGameVc", sender: self)
                }
                
             
                
            }
        }
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {

        practiceSenBtn.isEnabled = true
        practiceWordBtn.isEnabled = true
        removeBtns()
        
    }
    
    var gamePassedDic:[Int:Int]?
    var mapPassedInt = Int()
    var increaseNum = Int()
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        //MARK: must update
        //就算user == nil, gamePassed & mapPassed都已經設定初始值了
        //測試用
        
        //mapNumToReceive = 0
        //gamePassed = [4:3]
        //mapPassed = 0
        
        switch courseReceived {
        case 0:
            gamePassedDic = gamePassed!
            mapPassedInt = mapPassed!
            increaseNum = 0
            maxMapNum = 5
            
        case 1:
            gamePassedDic = gamePassed2!
            mapPassedInt = mapPassed2!
            increaseNum = 5
            maxMapNum = 6
            
        case 2:
            gamePassedDic = gamePassed3!
            mapPassedInt = mapPassed3!
            increaseNum = 11
            maxMapNum = 7
            
            
        case 3:
            gamePassedDic = gamePassed4!
            mapPassedInt = mapPassed4!
            increaseNum = 18
            maxMapNum = 9
            
        case 4:
            gamePassedDic = gamePassed5!
            mapPassedInt = mapPassed5!
            increaseNum = 27
            maxMapNum = 8


        default:
            break
        }
        
        
    
        
        if isClassAllPassed == false{

        
        let attrs0 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: lessonBigFontSize), NSAttributedStringKey.foregroundColor : pinkColor]
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: lessonSmallFontSize), NSAttributedStringKey.foregroundColor : UIColor.white]
        let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: wordFontSize), NSAttributedStringKey.foregroundColor : UIColor.cyan]
        let attrs3 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: wordFontSize), NSAttributedStringKey.foregroundColor : UIColor.white]
        
        //增加數字來抓正確的值
        mapNumToReceive += increaseNum
            
            //MARK: must update
        
        switch mapNumToReceive {
        case 0:
            syllableSets = map1SyllableSets
        case 1:
            syllableSets = map2SyllableSets
        case 2:
            syllableSets = map3SyllableSets
        case 3:
            syllableSets = map4SyllableSets
        case 4:
            syllableSets = map5SyllableSets
        case 5:
            syllableSets = map6SyllableSets
        case 6:
            syllableSets = map7SyllableSets
        case 7:
            syllableSets = map8SyllableSets
            
        case 8:
            syllableSets = map9SyllableSets
            
        case 9:
            syllableSets = map10SyllableSets
        case 10:
            syllableSets = map11SyllableSets
        case 11:
            syllableSets = map12SyllableSets
        case 12:
            syllableSets = map13SyllableSets
        case 13:
            syllableSets = map14SyllableSets
        case 14:
            syllableSets = map15SyllableSets
        case 15:
            syllableSets = map16SyllableSets
        case 16:
            syllableSets = map17SyllableSets
        case 17:
            syllableSets = map18SyllableSets
        case 18:
            syllableSets = map19SyllableSets
        case 19:
            syllableSets = map20SyllableSets
        case 20:
            syllableSets = map21SyllableSets
        case 21:
            syllableSets = map22SyllableSets
        case 22:
            syllableSets = map23SyllableSets
        case 23:
            syllableSets = map24SyllableSets
        case 24:
            syllableSets = map25SyllableSets
        case 25:
            syllableSets = map26SyllableSets
        case 26:
            syllableSets = map27SyllableSets
            
        case 27:
            syllableSets = map28SyllableSets
        case 28:
            syllableSets = map29SyllableSets
        case 29:
            syllableSets = map30SyllableSets
        case 30:
            syllableSets = map31SyllableSets
        case 31:
            syllableSets = map32SyllableSets
        case 32:
            syllableSets = map33SyllableSets
        case 33:
            syllableSets = map34SyllableSets
        case 34:
            syllableSets = map35SyllableSets
        default:
            break
        }
        
        var syllablesWithoutDigit = String()
        
        var progressFloat = CGFloat()
        
        //再把數字減回來
        mapNumToReceive -= increaseNum
            print("mapNumToReceive:\(mapNumToReceive)")
            
        if mapNumToReceive == mapPassedInt {
            //抓目前的元素
            
            for (s,u) in gamePassedDic! {
                
                let syllableChosen = syllableSets[s][u]
                
                let syllableChosenArray = syllableChosen.components(separatedBy: NSCharacterSet.decimalDigits)
                
                syllablesWithoutDigit = syllableChosenArray[0]
                syllableLabel.text = syllablesWithoutDigit
         
                //這個狀態下mapPassedInt 跟 mapNumToReceive是一樣的
                mapNum = mapPassedInt
                
                spotNum = s
                unitNum = u
                progressFloat = CGFloat(u + 1)
                
            }
            print("############got mapnum:\(mapNum)")
        } else {
            
  
            //這裡是進不來的地方
            
            //跳轉到該地圖的第一個元素
            
            mapNum = mapNumToReceive
            spotNum = 0
            unitNum = 0
            progressFloat = 10
            
            let syllableChosen = syllableSets[spotNum][unitNum]
            
            let syllableChosenArray = syllableChosen.components(separatedBy: NSCharacterSet.decimalDigits)
            
            syllablesWithoutDigit = syllableChosenArray[0]
            
            syllableLabel.text = syllablesWithoutDigit
            
            }
        
 
        //第幾課
        let lessonText = NSMutableAttributedString(string: String(spotNum + 1), attributes: attrs0)
        lessonText.append(NSMutableAttributedString(string: " / 15", attributes: attrs1))
        lessonLabel.attributedText = lessonText
        
        //進度條
            print("讀取進度條")
        //progressLength.frame = CGRect(x: 0, y: fullLength.frame.minY, width: width * progressFloat / 10, height: 3)
        progressLength.anchor(top: nil, leading: view.safeLeftAnchor, bottom: enterBtn.topAnchor, trailing: nil, size: .init(width: width * progressFloat / 10, height: 3))

            
            
        //MARK: 讀取文字檔
        //讀取Bundle裡的文字檔
        var wordFile:String?
        
        //供抓字用 & pass給 gameVc
        mapNum += increaseNum
        
        let name = String(mapNum + 1) + "-" + String(spotNum + 1)
        
        //print(name)
        
        if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
            do {
                wordFile = try String(contentsOfFile: filepath)
                let words = wordFile?.components(separatedBy: "; ")
                
                //把字讀取到wordSets裡
                wordSets = words!
                //print(contents)
            } catch {
                // contents could not be loaded
            }
        } else {
            // example.txt not found!
        }
            
            mapNum -= increaseNum
        
        //這個engWords是尚未attr的, attr完的是
        var allThreeEngWordsArray = [[String]]()
        var allThreeEngWords = [String]()
        
        let engWord0 = wordSets[unitNum * 3].components(separatedBy: " ")
        let engWord1 = wordSets[unitNum * 3 + 1].components(separatedBy: " ")
        let engWord2 = wordSets[unitNum * 3 + 2].components(separatedBy: " ")
        
        allThreeEngWordsArray.append(engWord0)
        allThreeEngWordsArray.append(engWord1)
        allThreeEngWordsArray.append(engWord2)
        
        
        for i in 0 ..< allThreeEngWordsArray.count{
            var word = String()
            
            for syl in allThreeEngWordsArray[i]{
                
                word = word + syl
            }
            
            allThreeEngWords.append(word)
        }
        
        var attrWords = [[NSMutableAttributedString](),[NSMutableAttributedString](),[NSMutableAttributedString]()]
        
        
            //MARK: 音節變色
        if syllablesWithoutDigit.contains("_"){
            //specialE的作法
            
            var characters = [Character]()
            let vowels = ["a","e","i","o","u"]
            
            //每一個英文字節拆字母
            for w in 0 ..< allThreeEngWordsArray.count{
                
                for i in 0 ..< allThreeEngWordsArray[w].count{
                    
                    characters.removeAll(keepingCapacity: false)
                    
                    for c in allThreeEngWordsArray[w][i]{
                        
                        characters.append(c)
                    }
                    
                    if characters.count == 3{
                        if characters[2] == "e"{
                            
                            if vowels.contains(String(characters[0])){
                                
                                
                                //剛好是_e部首
                                let word = NSMutableAttributedString(string: String(characters[0]), attributes: attrs2)
                                attrWords[w].append(word)
                                let word1 = NSMutableAttributedString(string: String(characters[1]), attributes: attrs3)
                                attrWords[w].append(word1)
                                let word2 = NSMutableAttributedString(string: String(characters[2]), attributes: attrs2)
                                attrWords[w].append(word2)
                                
                                
                            } else {
                                
                                for c in 0 ..< characters.count {
                                    
                                    let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs3)
                                    attrWords[w].append(word)
                                }
                                
                            }
                            
                        } else {
                            
                            for c in 0 ..< characters.count {
                                
                                let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs3)
                                attrWords[w].append(word)
                            }
                            
                        }
                        
                    } else {
                        
                        for c in 0 ..< characters.count {
                            
                            let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs3)
                            attrWords[w].append(word)
                        }
                        
                    }
                    
                }
            }
            
        } else {
            //非specialE的作法
            
            //抓三個字的array
            for w in 0 ..< allThreeEngWordsArray.count{
                
                //抓array的音節,  只抓一個字
                for i in 0 ..< allThreeEngWordsArray[w].count{
                    
                    if let engWord = allThreeEngWordsArray[w][i] as String?{
                        
                        if engWord == syllablesWithoutDigit{
                            //符合部首字
                            
                            let word = NSMutableAttributedString(string: engWord, attributes: attrs2)
                            attrWords[w].append(word)
                            
                            
                        } else{
                            //一般字元
                            
                            let word = NSMutableAttributedString(string: engWord, attributes: attrs3)
                            
                            attrWords[w].append(word)
                            
                        }
                    }
                    
                }
                
            }
            
        }
        
        
        //*** 以下為共同的造字func, 把字造到words裡
        
        for w in 0 ..< attrWords.count {
            
            for i in 0 ..< attrWords[w].count { //[w]
                
                if i == 0 {
                    words[w] = attrWords[w][i] //[w]
                    
                } else {
                    words[w].append(attrWords[w][i]) //[w]
                }
            }
        }
        
        
        //造完字後顯示出英文部分
        firstLabel.attributedText = words[0]
        secondLabel.attributedText = words[1]
        thirdLabel.attributedText = words[2]

        enterBtn.isEnabled = true
        
        //指定音節
        synWord = syllablesWithoutDigit
                
        //音節發音
        //synPronounce()
        
        } else {
            
            //複習模式
            
            
            //進度條
            
            titleLabel.text = ""
            
            //如果是複習模式在此指定傳送數值, 在此不要加increaseNum因為在gameVc裡沒有再減了, 直接拿來比較
            mapNum = mapNumToReceive
            
            let attrs0 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 36), NSAttributedStringKey.foregroundColor : UIColor.white]
            let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 36), NSAttributedStringKey.foregroundColor : pinkColor]
            
            let attrWords = NSMutableAttributedString()
            let text1 = NSMutableAttributedString(string: "此單元結束", attributes: attrs0)
            let text2 = NSMutableAttributedString(string: "請選擇", attributes: attrs0)
            let text3 = NSMutableAttributedString(string: "挑戰模式", attributes: attrs1)
            
            let text4 = NSMutableAttributedString(string: "來複習", attributes: attrs0)
            
            attrWords.append(text1)
            attrWords.append(NSMutableAttributedString(string: "\n"))
            attrWords.append(text2)
            attrWords.append(text3)
            attrWords.append(NSMutableAttributedString(string: "\n"))
            attrWords.append(text4)
            
            //progressLength.frame = CGRect(x: 0, y: fullLength.frame.minY, width: fullLength.frame.width, height: 3)
            progressLength.anchor(top: nil, leading: view.safeLeftAnchor, bottom: enterBtn.topAnchor, trailing: view.safeRightAnchor, size: .init(width: fullLength.frame.width, height: 3))
            
            enterBtn.isEnabled = false
            enterBtn.setTitle("課程結束", for: .normal)
            //syllableLabel.text = "此單元結束\n請選擇下方快速複習\n挑戰模式"
            syllableLabel.attributedText = attrWords
            //syllableLabel.font = UIFont(name: "Helvetica Bold", size: 36)
            syllableLabel.adjustsFontSizeToFitWidth = true
            syllableLabel.numberOfLines = 3
            syllableLabel.textAlignment = .center

        }
    }

    @IBAction func enterGameClicked(_ sender: Any) {
        
        gameMode = 0
        enterBtn.isEnabled = false
        performSegue(withIdentifier: "toGameVc", sender: self)
    }
    
    @IBAction func reviewBtnClicked(_ sender: Any) {
        
        ghostBtn.isHidden = false
        alertBg.isHidden = false
        //ghost2Btn.isHidden = false
        practiceWordBtn.isHidden = false
        practiceSenBtn.isHidden = false
        leftBtnClickedImg.isHidden = false
        rightBtnClickedImg.isHidden = false
        
    }
    
    func cannotPracticeAlert(){
        

        
        alertText.text = "\n此課程尚未學習，無法挑戰\n至少需要學習一個單元才能挑戰"
        ghostBtn.isHidden = false
        
        
        alertBg.image = UIImage(named: "reviewQuitBg3.png")
        alertBg.isHidden = false
        bigQuitBtn.isHidden = false
        //ghost2Btn.isHidden = false
        practiceWordBtn.isHidden = true
        practiceSenBtn.isHidden = true
        //leftBtnClickedImg.isHidden = false
        //rightBtnClickedImg.isHidden = false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toGameVc"{
            let destinationVC = segue.destination as! NewGameViewController
            destinationVC.spotNumber = spotNum
            destinationVC.unitNumber = unitNum
            destinationVC.mapNumber = mapNum
            destinationVC.gameMode = gameMode
            destinationVC.courseReceived = courseReceived
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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

extension UIView{
    
    func fillSupervivew(){
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    
    func anchorSize(to view: UIView){
        
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
            
        }
        
        if let leading = leading {
            
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
            
        }
        
        if let bottom = bottom {
            
            bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
            
        }
        if let trailing = trailing {
            
            trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
            
        }

        if size.width != 0 {
            
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
            
        }
        
        
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
        
        }
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.leadingAnchor
        }else {
            return self.leadingAnchor
        }
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.trailingAnchor
        }else {
            return self.trailingAnchor
        }
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }
    
    
}
