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
    let darkRed = UIColor.init(red: 192/255, green: 40/255, blue: 75/255, alpha: 1)
    
    
    
    //發音單字
    var synWord = String()
    
    //Text to speech合成器
    var synth = AVSpeechSynthesizer()
    
   
    var audioSession = AVAudioSession.sharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        var dif = CGFloat()
        var xDif = CGFloat()
        switch height {
        case 812:
            xDif = 1.2
            dif = 1

        case 736:
            xDif = 1
            dif = 1.1
      
            
        case 667:
            xDif = 1
            dif = 1

            
        case 568:
            xDif = 1
            dif = 0.9

            
        default:
            xDif = 1
            dif = 0.9
            
        }

        
        //加入alertView
        let lightGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.58)
        ghostBtn.frame = CGRect(x: 0, y: 0, width: width, height: height)
        ghostBtn.backgroundColor = lightGray
        ghostBtn.addTarget(self, action: #selector(LessonViewController.removeBtns), for: .touchUpInside)
        self.view.addSubview(ghostBtn)
        
        
        
        alertBg.frame = CGRect(x: (width - 237 * dif) / 2, y: height * 2 /  5, width: width * 237 / 375, height: height * 140 / 667)
        alertBg.image = UIImage(named: "reviewSelectBg.png")
        self.view.addSubview(alertBg)
        
        ghost2Btn.frame = CGRect(x: (width - 237 * dif) / 2, y: height * 2 /  5, width: width * 237 / 375, height: height * 140 / 667)
        self.view.addSubview(ghost2Btn)
        
        alertText.frame = CGRect(x: 5 * dif , y: 5 * dif, width: alertBg.frame.width - 5 * dif * 2, height: alertBg.frame.height / 2)
        alertText.font = UIFont(name: "Helvetica Neue Bold", size: 28)
        alertText.textColor = .white
        alertText.text = "選擇練習模式"
        alertText.numberOfLines = 0
        alertText.textAlignment = .center
        alertText.adjustsFontSizeToFitWidth = true
        alertBg.addSubview(alertText)
        
        
        practiceWordBtn.frame = CGRect(x: alertBg.frame.minX, y: alertBg.frame.maxY - 44 * dif * xDif, width: alertBg.frame.width / 2, height: height * 44 / 667)
        
        practiceWordBtn.setTitle("複習單字", for: .normal)
        practiceWordBtn.setTitleColor(darkRed, for: .normal)
        practiceWordBtn.addTarget(self, action: #selector(LessonViewController.practiceWord), for: .touchUpInside)
        self.view.addSubview(practiceWordBtn)
        
        practiceSenBtn.frame = CGRect(x: practiceWordBtn.frame.maxX, y: alertBg.frame.maxY - 44 * dif * xDif, width: alertBg.frame.width / 2, height: height * 44 / 667)
        practiceSenBtn.setTitle("複習句型", for: .normal)
        practiceSenBtn.setTitleColor(darkRed, for: .normal)
        practiceSenBtn.addTarget(self, action: #selector(LessonViewController.practiceSen), for: .touchUpInside)
        self.view.addSubview(practiceSenBtn)
        
        leftBtnClickedImg.frame = practiceWordBtn.frame
        leftBtnClickedImg.image = UIImage(named: "leftBtnClickedImg.png")
        
        rightBtnClickedImg.frame = practiceSenBtn.frame
        rightBtnClickedImg.image = UIImage(named: "rightBtnClickedImg.png")
        
        self.view.addSubview(leftBtnClickedImg)
        self.view.addSubview(rightBtnClickedImg)
        leftBtnClickedImg.alpha = 0
        rightBtnClickedImg.alpha = 0

        
        backBtn.frame = CGRect(x: width / 10, y: width / 8, width: 19, height: 31)
        lessonTitleLabel.frame = CGRect(x: width * 5.5 / 7, y: backBtn.frame.minY - 10 * dif, width: 66 , height: 22)
        
        lessonLabel.frame = CGRect(x: width * 3 / 4, y: lessonTitleLabel.frame.maxY, width: width / 4, height: 60 * dif)
        lessonLabel.backgroundColor = .clear

        
        syllableLabel.frame = CGRect(x: 0, y: height / 5 * dif, width: width, height: height / 3.5 * dif)
    

        syllableLabel.textAlignment = .center
        //syllableLabel.backgroundColor = .blue
        

        firstLabel.frame = CGRect(x: 0, y: syllableLabel.frame.maxY + 10 * dif, width: width, height: 44 * dif)
        
        //firstLabel.backgroundColor = .red
        secondLabel.frame = CGRect(x: 0, y: firstLabel.frame.maxY, width: width, height: 44 * dif)
        //secondLabel.backgroundColor = .green
              thirdLabel.frame = CGRect(x: 0, y: secondLabel.frame.maxY, width: width, height: 44 * dif)
        
        //thirdLabel.backgroundColor = .yellow
        
        
        enterBtn.frame = CGRect(x: width / 2, y: height - 66 * dif, width: width / 2, height: 66 * dif)
        
        reviewBtn.frame = CGRect(x: 0, y: height - 66 * dif, width: width / 2, height: 66 * dif)
        
        fullLength.frame = CGRect(x: 0, y: enterBtn.frame.minY, width: width, height: 3)
        
        
        //拉到最前方
        self.view.bringSubview(toFront: ghostBtn)
        self.view.bringSubview(toFront: alertBg)
        self.view.bringSubview(toFront: ghost2Btn)
        self.view.bringSubview(toFront: practiceWordBtn)
        self.view.bringSubview(toFront: practiceSenBtn)
        self.view.bringSubview(toFront: leftBtnClickedImg)
        self.view.bringSubview(toFront: rightBtnClickedImg)
        
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
        
        ghostBtn.isHidden = true
        alertBg.isHidden = true
        ghost2Btn.isHidden = true
        practiceWordBtn.isHidden = true
        practiceSenBtn.isHidden = true
        leftBtnClickedImg.isHidden = true
        rightBtnClickedImg.isHidden = true
    }
    
    @objc func practiceSen(){
        print("practice Sen")
        
        gameMode = 2
        
        UIView.animate(withDuration: 0.06, animations: {[weak self] in
            
            self!.rightBtnClickedImg.alpha = 1
            
            
        }) {[weak self] (finished:Bool) in
            
            
            if finished {
                
                self!.rightBtnClickedImg.alpha = 0
                
                self?.practiceWordBtn.isEnabled = false
                self?.practiceSenBtn.isEnabled = false
                
                if mapPassed == 0 {
                    
                    if gamePassed == [0:0] {
                        
                        
                        
                    } else {
                        self!.performSegue(withIdentifier: "toGameVc", sender: self)
                        
                    }
                } else {
   
                    self!.performSegue(withIdentifier: "toGameVc", sender: self)
                    
                }
                

                
            }
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
                
                if mapPassed == 0 {
                    
                    if gamePassed == [0:0] {
                        
                        print("不能練習")
                    } else {
                        

                        self!.performSegue(withIdentifier: "toGameVc", sender: self)
                    }
                    
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
    
    override func viewWillAppear(_ animated: Bool) {
        
       
        //確認進入的地圖是否為當下地圖, 是的話跳轉到目前的元素, 不是的話代表以全過關, 跳轉到第一個重來
        
        //測試用
        
        //mapNumToReceive = 0
        //gamePassed = [4:3]
        //mapPassed = 0
        
        let attrs0 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 45), NSAttributedStringKey.foregroundColor : pinkColor]
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor : UIColor.white]
        let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 40), NSAttributedStringKey.foregroundColor : UIColor.cyan]
        let attrs3 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 40), NSAttributedStringKey.foregroundColor : UIColor.white]
        
        
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
        default:
            break
        }
        
        var syllablesWithoutDigit = String()
        
        var progressFloat = CGFloat()
        
        if mapNumToReceive == mapPassed! {
            //抓目前的元素
            
            for (s,u) in gamePassed! {
                
                let syllableChosen = syllableSets[s][u]
                
                let syllableChosenArray = syllableChosen.components(separatedBy: NSCharacterSet.decimalDigits)
                
                syllablesWithoutDigit = syllableChosenArray[0]
                syllableLabel.text = syllablesWithoutDigit
         
                mapNum = mapPassed!
                spotNum = s
                unitNum = u
                progressFloat = CGFloat(u + 1)
                
                
                
            }
            
        } else {
            
            print("not the same")
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
        synPronounce()
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toGameVc"{
            let destinationVC = segue.destination as! NewGameViewController
            destinationVC.spotNumber = spotNum
            destinationVC.unitNumber = unitNum
            destinationVC.mapNumber = mapNum
            destinationVC.gameMode = gameMode
            
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
