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
    var ghost2Btn = UIButton()
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
    
    var iPadSmall = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        var dif = CGFloat()
        var xDif = CGFloat()
        
        switch height {
        case 812:
            xDif = 1.2
            dif = 1
            sylFontSize = 130
            wordFontSize = 40
            titleFontSize = 28
            iPadSmall = 0
            

        case 736:
            xDif = 1
            dif = 1.1
            sylFontSize = 130
            wordFontSize = 40
            titleFontSize = 28
            iPadSmall = 0

            
        case 667:
            xDif = 1
            dif = 1
            sylFontSize = 120
            wordFontSize = 35
            titleFontSize = 26
            iPadSmall = 0

            
        case 568:
            xDif = 1
            dif = 0.9
            sylFontSize = 100
            wordFontSize = 30
            titleFontSize = 24
            iPadSmall = 0


            
        default:
            xDif = 1
            dif = 0.9
            sylFontSize = 80
            wordFontSize = 30
            titleFontSize = 18
            iPadSmall = 10


            
        }

        
        //加入alertView
        let lightGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.58)
        ghostBtn.frame = CGRect(x: 0, y: 0, width: width, height: height)
        ghostBtn.backgroundColor = lightGray
        ghostBtn.addTarget(self, action: #selector(LessonViewController.removeBtns), for: .touchUpInside)
        self.view.addSubview(ghostBtn)
        
        
        
        alertBg.frame = CGRect(x: (width - 237 * dif) / 2, y: height * 2 /  5, width: width * 237 / 375, height: height * 140 / 667)
        alertBg.image = UIImage(named: "reviewSelectBg3.png")
        self.view.addSubview(alertBg)
        
        ghost2Btn.frame = CGRect(x: (width - 237 * dif) / 2, y: height * 2 /  5, width: width * 237 / 375, height: height * 140 / 667)
        self.view.addSubview(ghost2Btn)
        
        alertText.frame = CGRect(x: 5 * dif , y: 20 * dif, width: alertBg.frame.width - 5 * dif * 2, height: alertBg.frame.height / 2)
        alertText.font = UIFont(name: "Helvetica Bold", size: 16)
        alertText.textColor = .white
        alertText.text = "請選擇挑戰模式"
        alertText.numberOfLines = 4
        alertText.textAlignment = .center
        alertText.adjustsFontSizeToFitWidth = true
        alertBg.addSubview(alertText)
        
        
        practiceWordBtn.frame = CGRect(x: alertBg.frame.minX, y: alertBg.frame.maxY - 40 * dif * xDif + iPadSmall, width: alertBg.frame.width / 2, height: height * 44 / 667)
        
        practiceWordBtn.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 16)
        practiceWordBtn.setTitle("拼字王挑戰", for: .normal)
        practiceWordBtn.setTitleColor(orangeColor, for: .normal)
        practiceWordBtn.addTarget(self, action: #selector(LessonViewController.practiceWord), for: .touchUpInside)
        self.view.addSubview(practiceWordBtn)
        
        practiceSenBtn.frame = CGRect(x: practiceWordBtn.frame.maxX, y: alertBg.frame.maxY - 40 * dif * xDif + iPadSmall, width: alertBg.frame.width / 2, height: height * 44 / 667)
        
        practiceSenBtn.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 16)
        practiceSenBtn.setTitle("句型冠軍榜", for: .normal)
        practiceSenBtn.setTitleColor(orangeColor, for: .normal)
        practiceSenBtn.addTarget(self, action: #selector(LessonViewController.practiceSen), for: .touchUpInside)
        self.view.addSubview(practiceSenBtn)
        
        bigQuitBtn = UIButton(type: .system)
        bigQuitBtn.frame = CGRect(x: alertBg.frame.minX, y: alertBg.frame.maxY - 40 * dif * xDif + iPadSmall, width: alertBg.frame.width, height: height * 44 / 667)
 
        bigQuitBtn.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 16)
        bigQuitBtn.setTitle("我知道了", for: .normal)
        bigQuitBtn.setTitleColor(orangeColor, for: .normal)
        
        bigQuitBtn.addTarget(self, action:#selector(LessonViewController.removeBtns), for: .touchUpInside)
        self.view.addSubview(bigQuitBtn)
        

        
        backBtn.frame = CGRect(x: width / 10, y: width / 8, width: 19, height: 31)
        lessonTitleLabel.frame = CGRect(x: width * 5.5 / 7, y: backBtn.frame.minY - 10 * dif, width: 66 , height: 22)
        
        lessonLabel.frame = CGRect(x: width * 3 / 4, y: lessonTitleLabel.frame.maxY, width: width / 4, height: 60 * dif)
        lessonLabel.backgroundColor = .clear

        
        syllableLabel.frame = CGRect(x: 0, y: height / 5 * dif, width: width, height: height / 3.5 * dif)
    
        syllableLabel.adjustsFontSizeToFitWidth = true
        syllableLabel.font = syllableLabel.font.withSize(sylFontSize)

        syllableLabel.textAlignment = .center
        //syllableLabel.backgroundColor = .blue
        
        
        titleLabel.frame = CGRect(x: 0, y: syllableLabel.frame.minY - 72 * dif, width: width, height: 72 * dif)
        //titleLabel.backgroundColor = .red

        titleLabel.numberOfLines = 2
        titleLabel.text = "即將學習\n下列三個新單字"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = titleLabel.font.withSize(titleFontSize)
        
        
        firstLabel.frame = CGRect(x: 0, y: syllableLabel.frame.maxY + 10 * dif, width: width, height: 44 * dif)
        firstLabel.adjustsFontSizeToFitWidth = true
        firstLabel.font = firstLabel.font.withSize(wordFontSize)
        
        //firstLabel.backgroundColor = .red
        secondLabel.frame = CGRect(x: 0, y: firstLabel.frame.maxY, width: width, height: 44 * dif)
        secondLabel.adjustsFontSizeToFitWidth = true
        secondLabel.font = secondLabel.font.withSize(wordFontSize)

        
        //secondLabel.backgroundColor = .green
              thirdLabel.frame = CGRect(x: 0, y: secondLabel.frame.maxY, width: width, height: 44 * dif)
        
        thirdLabel.adjustsFontSizeToFitWidth = true
        thirdLabel.font = thirdLabel.font.withSize(wordFontSize)

        
 
        //thirdLabel.backgroundColor = .yellow
        
        
        enterBtn.frame = CGRect(x: width / 2, y: height - 66 * dif, width: width / 2, height: 66 * dif)
        
        reviewBtn.frame = CGRect(x: 0, y: height - 66 * dif, width: width / 2, height: 66 * dif)
        
        fullLength.frame = CGRect(x: 0, y: enterBtn.frame.minY, width: width, height: 3)
        
        hintLabel.frame = CGRect(x: (width - 136 * dif) / 2, y: enterBtn.frame.minY - 36, width: 136 * dif, height: 21 * dif)
        
        
        //拉到最前方
        self.view.bringSubview(toFront: ghostBtn)
        self.view.bringSubview(toFront: alertBg)
        self.view.bringSubview(toFront: ghost2Btn)
        self.view.bringSubview(toFront: practiceWordBtn)
        self.view.bringSubview(toFront: practiceSenBtn)
        self.view.bringSubview(toFront: leftBtnClickedImg)
        self.view.bringSubview(toFront: rightBtnClickedImg)
        self.view.bringSubview(toFront: bigQuitBtn)
        
        removeBtns()


        
    }
    
    //syn發音
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
        ghost2Btn.isHidden = true
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
        
        if gamePassedDic == [0:0] && mapNumToReceive >= mapPassedInt{
            
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
                
                
                if self!.gamePassedDic == [0:0] && self!.mapNumToReceive >= self!.mapPassedInt{
                    
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
        
        
        
        //確認進入的地圖是否為當下地圖, 是的話跳轉到目前的元素, 不是的話代表以全過關, 跳轉到第一個重來
        
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

        default:
            break
        }
        
        
    
        
        if isClassAllPassed == false{
            
            
            //加入可以按的按鍵
            /*
            hiddenBtn.frame = CGRect(x: 0, y: titleLabel.frame.minY, width: width, height: thirdLabel.frame.maxY - titleLabel.frame.minY)
            hiddenBtn.addTarget(self, action: #selector(LessonViewController.enterGameClicked(_:)), for: .touchUpInside)
            self.view.addSubview(hiddenBtn)
            self.view.bringSubview(toFront: hiddenBtn)
*/
            
        
        let attrs0 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 45), NSAttributedStringKey.foregroundColor : pinkColor]
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor : UIColor.white]
        let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: wordFontSize), NSAttributedStringKey.foregroundColor : UIColor.cyan]
        let attrs3 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: wordFontSize), NSAttributedStringKey.foregroundColor : UIColor.white]
        
        //增加數字來抓正確的值
        mapNumToReceive += increaseNum
        
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
            
        default:
            break
        }
        
        var syllablesWithoutDigit = String()
        
        var progressFloat = CGFloat()
        
        //再把數字減回來
        mapNumToReceive -= increaseNum
        
        if mapNumToReceive == mapPassedInt {
            //抓目前的元素
            
            for (s,u) in gamePassedDic! {
                
                let syllableChosen = syllableSets[s][u]
                
                let syllableChosenArray = syllableChosen.components(separatedBy: NSCharacterSet.decimalDigits)
                
                syllablesWithoutDigit = syllableChosenArray[0]
                syllableLabel.text = syllablesWithoutDigit
         
                mapNum = mapPassedInt
                spotNum = s
                unitNum = u
                progressFloat = CGFloat(u + 1)
                
            }
            
        } else {
            
  
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
        progressLength.frame = CGRect(x: 0, y: fullLength.frame.minY, width: width * progressFloat / 10, height: 3)
        
        //讀取Bundle裡的文字檔
        var wordFile:String?
        
        //供抓字用 & pass給 gameVc
        mapNum += increaseNum
        
        let name = String(mapNum + 1) + "-" + String(spotNum + 1)
        
        print(name)
        
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
            //進度條
            
            titleLabel.text = ""
            
            
            
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
            
            progressLength.frame = CGRect(x: 0, y: fullLength.frame.minY, width: fullLength.frame.width, height: 3)
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
        ghost2Btn.isHidden = false
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
        ghost2Btn.isHidden = false
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
