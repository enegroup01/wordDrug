//
//  NewBookViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/3/15.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit
import TwicketSegmentedControl
import Speech


class NewBookViewController: UIViewController,TwicketSegmentedControlDelegate, UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, AVSpeechSynthesizerDelegate{
    
    
    //所有音節
    var syllableSets = [String]()
    
    
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

    //刪掉數字的音節
    var sylArray = [String]()
    
    //整理過的音節
    var sortedSylArray = [String]()
    
    //選擇到的音節
    var collectionTouched = [Int]()
    
    //上方的seg
    let segControl = TwicketSegmentedControl()
    
    let darkPurpleColor = UIColor.init(red: 82/255, green: 90/255, blue: 120/255, alpha: 1)
    let segSliderBgColor = UIColor.init(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.25)
    let btnOffColor = UIColor.init(red: 115/255, green: 115/255, blue: 115/255, alpha: 1)
    let btnOnColor = UIColor.init(red: 223/255, green: 223/255, blue: 223/255, alpha: 1)
    
    //table & collection
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var autoPlayImg: UIImageView!
    @IBOutlet weak var autoPlayText: UILabel!
    
    @IBOutlet weak var playSenImg: UIImageView!
    @IBOutlet weak var playSenText: UILabel!
    
    @IBOutlet weak var playTimesText: UILabel!
    @IBOutlet weak var playTimesImg: UIImageView!
    
    @IBOutlet weak var playSpeedImg: UIImageView!
    @IBOutlet weak var playSpeedText: UILabel!
    
    @IBOutlet weak var practiceText: UILabel!
    @IBOutlet weak var practiceImg: UIImageView!
    //所有的單字的array
    var wordSets = [[String]]()
    var sentenceSets = [[String]]()
    
    //殘值的字的array
    var tempWordSets = [[String]]()
    var tempSentenceSets = [[String]]()
    
    //所有背過的單字, 中文, 詞性, 音節, 英文句, 中文句
    var engWordsToShow = [String]()
    var chiWordsToShow = [String]()
    var partOfSpeechToShow = [String]()
    var syllablesToShow = [String]()
    var engSenToShow = [String]()
    var chiSenToShow = [String]()
    
    
    var sortedEngWordsToShow = [String]()
      var sortedChiWordsToShow = [String]()
      var sortedPartOfSpeechToShow = [String]()
      var sortedSyllablesToShow = [String]()
      var sortedEngSenToShow = [String]()
      var sortedChiSenToShow = [String]()
    
    //使用者的字群
    var myFavWords = [String]()
    var myWrongWords = [String]()
    
    //指定我的最愛
    var myFavEngWordsToShow = [String]()
    var myFavChiWordsToShow = [String]()
    var myFavPartOfSpeechToShow = [String]()
    var myFavSyllablesToShow = [String]()
    var myFavEngSenToShow = [String]()
    var myFavChiSenToShow = [String]()
    
    var myWrongEngWordsToShow = [String]()
    var myWrongChiWordsToShow = [String]()
    var myWrongPartOfSpeechToShow = [String]()
    var myWrongSyllablesToShow = [String]()
    var myWrongEngSenToShow = [String]()
    var myWrongChiSenToShow = [String]()
    
    var engWordsSelected = [String]()
    var chiWordsSelected = [String]()
    var partOfSpeechSelected = [String]()
    var syllablesSelected = [String]()
    var engSenSelected = [String]()
    var chiSenSelected = [String]()
    
    //我的最愛圖片是否要顯示的array
    var myFavImgs = [Int]()
    
    //之後判斷加入最愛的時刻
    var likeMode = true
    
    //collection選到的index
    var collectionSelectedIndex:Int?
    
    //對應的syllable
    var sylSelected:String?
    
    //播放發音
    //Text to speech合成器
    var synth = AVSpeechSynthesizer()
    
    //發音單字
    var synEngWord = String()
    var synChiWord = String()
    var synEngSen = String()
    var synChiSen = String()
    
    //設定發音次數
    var speakTimes = 1
    //發音速度：0.5標準
    var speakRate = 0.45
    let lightRed = UIColor.init(red: 1, green: 0, blue: 0, alpha: 0.3)
    
    //是否要唸句子
    var isPlaySentence = true
    
    //避免tableView & collectionView戶卡
    var isScrolling = false
    
    //是否連續播放
    var isAutoPlay = false
    
    //endScrolling後才能按collectionView
    var isCollectionViewSelectabel = true
    
    var currentWordIndex = Int()
    
    //目前播放過幾次
    var alreadyPlayTimes = 0
    //發音階段
    var step = 1
    @IBOutlet weak var bookViewBottomBg: UIImageView!
    
    let width =  UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height

    @IBOutlet weak var playSpeedBtn: UIButton!
    @IBOutlet weak var playTimesBtn: UIButton!
    @IBOutlet weak var sentenceBtn: UIButton!
    @IBOutlet weak var practiceBtn: UIButton!
    
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var newBookBg: UIImageView!
    
    
    var dif = CGFloat()
    var cellDif = CGFloat()
    var seperatorDif = CGFloat()
    var fontDif = Int()
    
    
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        switch height {
        case 812:
            
            seperatorDif = 1.1
            dif = 1.35
            cellDif = 1.2
            fontDif = 0
            
        case 736:
            seperatorDif = 1.1
            dif = 1.1
            cellDif = 1.1
            fontDif = 3
            
        case 667:
            
            seperatorDif = 1
            dif = 1
            cellDif = 1
            fontDif = 4
            
        case 568:
            seperatorDif = 0.9
            dif = 0.9
            cellDif = 0.9
            fontDif = 5
        default:
            seperatorDif = 0.9
            dif = 0.9
            cellDif = 0.9
            fontDif = 5
            
            
        }
        
        //加入alertView
       let lightGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.58)
        ghostBtn.frame = CGRect(x: 0, y: 0, width: width, height: height)
        ghostBtn.backgroundColor = lightGray
        ghostBtn.addTarget(self, action: #selector(NewBookViewController.removeBtns), for: .touchUpInside)
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
        
        
        practiceWordBtn.frame = CGRect(x: alertBg.frame.minX, y: alertBg.frame.maxY - 44 * dif, width: alertBg.frame.width / 2, height: height * 44 / 667)
   
        practiceWordBtn.setTitle("複習單字", for: .normal)
        practiceWordBtn.setTitleColor(darkRed, for: .normal)
        practiceWordBtn.addTarget(self, action: #selector(NewBookViewController.practiceWord), for: .touchUpInside)
        self.view.addSubview(practiceWordBtn)
        
        practiceSenBtn.frame = CGRect(x: practiceWordBtn.frame.maxX, y: alertBg.frame.maxY - 44 * dif, width: alertBg.frame.width / 2, height: height * 44 / 667)
        practiceSenBtn.setTitle("複習句型", for: .normal)
        practiceSenBtn.setTitleColor(darkRed, for: .normal)
        practiceSenBtn.addTarget(self, action: #selector(NewBookViewController.practiceSen), for: .touchUpInside)
        self.view.addSubview(practiceSenBtn)

        leftBtnClickedImg.frame = practiceWordBtn.frame
        leftBtnClickedImg.image = UIImage(named: "leftBtnClickedImg.png")
        
        rightBtnClickedImg.frame = practiceSenBtn.frame
        rightBtnClickedImg.image = UIImage(named: "rightBtnClickedImg.png")
        
        self.view.addSubview(leftBtnClickedImg)
        self.view.addSubview(rightBtnClickedImg)
        leftBtnClickedImg.alpha = 0
        rightBtnClickedImg.alpha = 0
        

        // Do any additional setup after loading the view.
        //layOut
        newBookBg.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
         backBtn.frame = CGRect(x: width / 14, y: width / 10, width: 19, height: 31)
        
        //設定好segMent
        segControl.frame = CGRect(x: backBtn.frame.maxX, y: backBtn.frame.minY,width: width - backBtn.frame.width * 4, height: 30 * dif)
        self.view.addSubview(segControl)
        
        collectionView.frame = CGRect(x: backBtn.frame.minX, y: segControl.frame.maxY + 5 * dif, width: width - (backBtn.frame.minX * 2), height: height / 3.2)
        tableView.frame = CGRect(x: 0, y: collectionView.frame.maxY, width: width, height: height - collectionView.frame.maxY - 66 * dif)
        
        bookViewBottomBg.frame = CGRect(x: 0, y: tableView.frame.maxY, width: width, height: 66 * dif)
        
        playBtn.frame = CGRect(x: 0, y: tableView.frame.maxY, width: width / 5, height: 66 * dif)
        
        autoPlayImg.frame = CGRect(x: (width / 5 - 23 * dif) / 2, y: bookViewBottomBg.frame.minY + 12 * dif, width: 23 * dif, height: 23 * dif)
        autoPlayText.frame = CGRect(x:(width / 5 - 72 * dif) / 2, y: height - 21 * 1.2 * dif, width: 72 * dif , height: 21 * dif)
        
        
        sentenceBtn.frame = CGRect(x: playBtn.frame.maxX, y: tableView.frame.maxY, width: width / 5, height: 66 * dif)
        playSenImg.frame = CGRect(x: width / 5 + (width / 5 - 27 * dif) / 2 ,y: bookViewBottomBg.frame.minY + 12 * dif, width: 27 * dif, height: 23 * dif)
        playSenText.frame = CGRect(x: width / 5 + (width / 5 - 79 * dif) / 2, y: height - 21 * 1.2 * dif, width: 79 * dif , height: 21 * dif)
        
        
        playTimesBtn.frame = CGRect(x: sentenceBtn.frame.maxX, y: tableView.frame.maxY, width: width / 5, height: 66 * dif)
        playTimesImg.frame = CGRect(x: width * 2 / 5 + (width / 5 - 46 * dif) / 2, y: bookViewBottomBg.frame.minY + 18 * dif, width: 46 * dif, height: 8 * dif)
        
        playTimesText.frame = CGRect(x: width * 2 / 5 + (width / 5 - 76 * dif) / 2, y: height - 21 * 1.2 * dif, width: 76 * dif, height: 21 * dif)
        
        
        playSpeedBtn.frame = CGRect(x: playTimesBtn.frame.maxX, y: tableView.frame.maxY, width: width / 5, height: 66 * dif)
        
        playSpeedImg.frame = CGRect(x: width * 3 / 5 + (width / 5 - 44 * dif) / 2, y: bookViewBottomBg.frame.minY + 12 * dif, width: 44 * dif, height: 28 * dif)
        
        playSpeedText.frame = CGRect(x: width * 3 / 5 + (width / 5 - 76 * dif) / 2, y:  height - 21 * 1.2 * dif, width: 76 * dif, height: 21 * dif)
        
        practiceBtn.frame = CGRect(x: playSpeedBtn.frame.maxX, y: tableView.frame.maxY, width: width / 5, height: 66 * dif)
        
        practiceImg.frame = CGRect(x: width * 4 / 5 + (width / 5 - 24 * dif) / 2, y: bookViewBottomBg.frame.minY + 12 * dif, width: 24 * dif, height: 24 * dif)
        
        practiceText.frame = CGRect(x: width * 4 / 5 + (width / 5 - 76 * dif) / 2, y:  height - 21 * 1.2 * dif, width: 76 * dif, height: 21 * dif)
        
        
        /*
        playBtn.backgroundColor = .green
        sentenceBtn.backgroundColor = .red
        playTimesBtn.backgroundColor = .green
        playSpeedBtn.backgroundColor = .red
        
        collectionView.backgroundColor = .red
        */
        //設定delegate來監控讀音
        synth.delegate = self
        
        let titles = ["正確單字", "錯誤單字", "最愛單字"]
        segControl.setSegmentItems(titles)
        segControl.backgroundColor = .clear
        segControl.sliderBackgroundColor = segSliderBgColor
        segControl.segmentsBackgroundColor = .clear
        segControl.defaultTextColor = darkPurpleColor
        segControl.highlightTextColor = .white
        segControl.isSliderShadowHidden = true
        
        //所有的delegate
        segControl.delegate = self
        collectionView.delegate = self
        tableView.delegate = self
        tableView.isUserInteractionEnabled = true
        
        
        collectionView.backgroundColor = .clear
        tableView.backgroundColor = .clear
        
        let bgImg = UIImage(named:"wordTableBg.png")
        tableView.backgroundView = UIImageView(image: bgImg)
        tableView.separatorColor = UIColor.init(red: 215/255, green: 217/255, blue: 226/255, alpha: 1)
        tableView.separatorInset = .init(top: 0, left: 50 * seperatorDif, bottom: 0, right: 70)
        
        //設定Btn顏色狀態
        autoPlayText.textColor = btnOffColor
        playSenText.textColor = btnOffColor
        playTimesText.textColor = btnOnColor
        playTimesImg.image = UIImage(named:"bookTimes0.png")
        playSpeedImg.image = UIImage(named:"bookSpeed0.png")
        playSpeedText.textColor = btnOffColor
        playSenText.textColor = btnOnColor
        playSenImg.image = UIImage(named:"bookSenOn.png")
        
        //歸類所有syllable
        
        for group in map1SyllableSets{
            
            for syl in group{
                
                syllableSets.append(syl)
            }
        }
        for group in map2SyllableSets{
            
            for syl in group{
                
                syllableSets.append(syl)
            }
        }
        for group in map3SyllableSets{
            
            for syl in group{
                
                syllableSets.append(syl)
            }
        }
        for group in map4SyllableSets{
            
            for syl in group{
                
                syllableSets.append(syl)
            }
        }
        for group in map5SyllableSets{
        
            for syl in group{
                
                syllableSets.append(syl)
            }
        }
     
        
        //讀取所有syl, 排除相同的再次出現
        for syl in syllableSets{
 
     
                let sylBreaks = syl.components(separatedBy: NSCharacterSet.decimalDigits)
                let sylOnlyText = sylBreaks[0]
                
              //  if !sylArray.contains(sylOnlyText){
                    
                    sylArray.append(sylOnlyText)
               // }
            
            if !sortedSylArray.contains(sylOnlyText){
                
                
                sortedSylArray.append(sylOnlyText)
            }
            
        }
        
        
        
        //建立collectionView按鈕數量
        for _ in 0 ..< sortedSylArray.count{
            
         
            collectionTouched.append(0)
            
        }
        
        //預設第一個元素
        collectionTouched[0] = 1
        
        //讀取已過地圖
        //mapPassed = 1
        
        //spot & unit, 當下已過的地圖裡的關卡數字
        //gamePassed = [0:0]
        
        print("book mapPassed:\(mapPassed!)")
        print("book gamPassed:\(gamePassed!)")
        
        //所有已過關的地圖字都要抓進去
        for m in 0 ..< mapPassed!{
            //要讀取裡面的全部
    
       
            //讀取已完整的所有字集 + 句子
            //print("m:\(m)")
            //目前設置15的原因因為所有探索點都有15個, 若之後不同課程有不同的探索點數, 要抓動態探索點數字
            for i in 0 ..< 15{
                
                var wordFile:String?
                //前面的1代表第一張地圖
                let name = String(m + 1) + "-" + String(i + 1)
                let sName = "s\(String(m + 1))-" + String(i + 1)
            
                
                //抓字
                if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
                    do {
                        wordFile = try String(contentsOfFile: filepath)
                        let words = wordFile?.components(separatedBy: "; ")
                        
                        //把字讀取到wordSets裡
                        wordSets.append(words!)
                        //print(contents)
                        
                    } catch {
                        // contents could not be loaded
                    }
                } else {
                    // example.txt not found!
                }
                
                var sentenceFile:String?
                
                //抓句子
                if let filepath = Bundle.main.path(forResource: sName, ofType: "txt") {
                    do {
                        sentenceFile = try String(contentsOfFile: filepath)
                        let words = sentenceFile?.components(separatedBy: "; ")
                        
                        //把字讀取到wordSets裡
                        sentenceSets.append(words!)
                        //print(contents)
                        
                    } catch {
                        // contents could not be loaded
                    }
                } else {
                    // example.txt not found!
                }
                
            }
        
        }
        
        
        //接著抓目前最新開放地圖裡的完成字 + 殘字
        for (s,_) in gamePassed!{
  
            
            
            //讀取已完整的所有字集 + 句子
            for i in 0 ..< (s){
                

                var wordFile:String?
                //前面的1代表第一張地圖
                let name = String(describing: mapPassed! + 1) + "-" + String(i + 1)
                let sName = "s\(String(describing: mapPassed! + 1))-" + String(i + 1)
                
                //抓字
                if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
                    do {
                        wordFile = try String(contentsOfFile: filepath)
                        let words = wordFile?.components(separatedBy: "; ")
                        
                        //把字讀取到wordSets裡
                        wordSets.append(words!)
                        //print(contents)
                        
                    } catch {
                        // contents could not be loaded
                    }
                } else {
                    // example.txt not found!
                }
                
                var sentenceFile:String?
                
                //抓句子
                if let filepath = Bundle.main.path(forResource: sName, ofType: "txt") {
                    do {
                        sentenceFile = try String(contentsOfFile: filepath)
                        let words = sentenceFile?.components(separatedBy: "; ")
                        
                        //把字讀取到wordSets裡
                        sentenceSets.append(words!)
                        //print(contents)
                        
                    } catch {
                        // contents could not be loaded
                    }
                } else {
                    // example.txt not found!
                }
                
            }
            
            //再來讀取殘餘的英文字 + 句子
            var wordFile:String?

            //讀取最新一層的字
            let name = String(describing: mapPassed! + 1) + "-" + String(s + 1)
            let sName = "s\(String(describing: mapPassed! + 1))-" +  String(s + 1)
            
            if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
                do {
                    wordFile = try String(contentsOfFile: filepath)
                    let words = wordFile?.components(separatedBy: "; ")
                    
                    //把字讀取到wordSets裡
                    tempWordSets.append(words!)
                    //print(contents)
                    
                } catch {
                    // contents could not be loaded
                }
            } else {
                // example.txt not found!
            }
            
            
            
            var sentenceFile:String?
            
            //抓句子
            if let filepath = Bundle.main.path(forResource: sName, ofType: "txt") {
                do {
                    sentenceFile = try String(contentsOfFile: filepath)
                    let words = sentenceFile?.components(separatedBy: "; ")
                    
                    //把字讀取到wordSets裡
                    tempSentenceSets.append(words!)
                    //print(contents)
                    
                } catch {
                    // contents could not be loaded
                }
            } else {
                // example.txt not found!
            }
            
        }
        
        
        //抓所有單字
        //Part 1. 抓完整值
        
        //抓單字
        for i in 0 ..< wordSets.count{
            
           
            for w in 0 ..< 30{
                

                engWordsToShow.append(wordSets[i][w])
                
                //抓出正確的順序
                let syllableSequence = Int(i * 10) +  Int(w / 3)
                syllablesToShow.append(sylArray[syllableSequence]) //[i]
                
            }
            
            for c in 30 ..< 60{
                

                chiWordsToShow.append(wordSets[i][c])
            }
            
            for p in 60 ..< 90{
                

                partOfSpeechToShow.append(wordSets[i][p])
            }
            
        }
        
        //抓完整句子
        for i in 0 ..< sentenceSets.count{

           
            for e in 0 ..< 30{

                engSenToShow.append(sentenceSets[i][e])
                
            }
            
            for c in 30 ..< 60{
     
                chiSenToShow.append(sentenceSets[i][c])
            }
            
        }
        
        //Part 2. 抓殘值 ＆ 抓可能出現錯字的最新三個
        
        
        //* * * 抓已append完的音節數量, 之後殘值以此數量append
        let sequence = Int(syllablesToShow.count / 3)
        
        for (_,g) in gamePassed!{
            

            
            for w in 0 ..< ((g + 1) * 3){
                
                
                engWordsToShow.append(tempWordSets[0][w])
    
                let syllableSequence = sequence + Int(w / 3)

                syllablesToShow.append(sylArray[syllableSequence]) //[s]
                
                engSenToShow.append(tempSentenceSets[0][w])
                
                
            }
            
            for w in 30 ..< (30 + (g + 1) * 3){
                
            
                chiWordsToShow.append(tempWordSets[0][w])
                
                chiSenToShow.append(tempSentenceSets[0][w])
           
            }
            
            for w in 60 ..< (60 + (g + 1) * 3){
                
            
                partOfSpeechToShow.append(tempWordSets[0][w])
           
            }
            
        }
        
        
        //載入我的最愛單字
        if let myWordsString = user!["myWords"] as! String?{
            myFavWords = myWordsString.components(separatedBy: ";")
        }
        
        //載入我的錯誤單字
        if let myWrongWordsString = user!["wrongWords"] as! String?{
            myWrongWords = myWrongWordsString.components(separatedBy: ";")
            
        }
        
        //填入所有字的數量, 等等準備抓我的最愛的部分
        for _ in 0 ..< engWordsToShow.count - 3{

            myFavImgs.append(0)
        }
        
        //兩個音節做比對, 抓新字的順序
        for s in 0 ..< sortedSylArray.count{

            
            for i in 0 ..< sylArray.count{

                
                if sortedSylArray[s] == sylArray[i]{
                    
                    
                    for n in 0 ..< 3 {

                        
                        //音節過多, 單字不夠多所以要確認數量
                        if engWordsToShow.count > ((i * 3) + n){
                        
                        sortedEngWordsToShow.append(engWordsToShow[(i * 3) + n])
                        sortedChiWordsToShow.append(chiWordsToShow[(i * 3) + n])
                        sortedPartOfSpeechToShow.append(partOfSpeechToShow[(i * 3) + n])
                        sortedSyllablesToShow.append(syllablesToShow[(i * 3) + n])
                        sortedEngSenToShow.append(engSenToShow[(i * 3) + n])
                        sortedChiSenToShow.append(chiSenToShow[(i * 3) + n])
                      
                        }
                        
                    }
                    
                }
                
            }
            
        }
        print("sorted:\(sortedEngWordsToShow.count)")
        print("notSorted:\(engWordsToShow.count)")
       
        //從所有的單字裡去找match到的我的最愛單字
        for i in 0 ..< sortedEngWordsToShow.count{
            
            //這個完整字沒有拆音節
            let word = sortedEngWordsToShow[i].replacingOccurrences(of: " ", with: "")
            let chiWord = sortedChiWordsToShow[i]
            let partOfSpeech = sortedPartOfSpeechToShow[i]
            let syllables = sortedSyllablesToShow[i]
            //這個字才有拆音節
            let wordToAppend = sortedEngWordsToShow[i]
            let engSenToAppend = sortedEngSenToShow[i]
            let chiSenToAppend = sortedChiSenToShow[i]
            
            for myWord in myFavWords{
                
                if myWord == word {

                    myFavEngWordsToShow.append(wordToAppend)
                    myFavChiWordsToShow.append(chiWord)
                    myFavPartOfSpeechToShow.append(partOfSpeech)
                    myFavSyllablesToShow.append(syllables)
                    myFavEngSenToShow.append(engSenToAppend)
                    myFavChiSenToShow.append(chiSenToAppend)
                    
                    //抓全部單字要反紅的部分
                    //myFavImgs[i] = 1
                    
                }
                
            }
            
            //抓我的錯字
            for myWrongWord in myWrongWords{
                
                if myWrongWord == word {
                    
                    myWrongEngWordsToShow.append(wordToAppend)
                    myWrongChiWordsToShow.append(chiWord)
                    myWrongPartOfSpeechToShow.append(partOfSpeech)
                    myWrongSyllablesToShow.append(syllables)
                    myWrongEngSenToShow.append(engSenToAppend)
                    myWrongChiSenToShow.append(chiSenToAppend)
                    
                }
                
            }
            
        }
        
        //設定好要show的第一組單字就是全部的單字
        engWordsSelected = sortedEngWordsToShow
        chiWordsSelected = sortedChiWordsToShow
        partOfSpeechSelected = sortedPartOfSpeechToShow
        syllablesSelected = sortedSyllablesToShow
        engSenSelected = sortedEngSenToShow
        chiSenSelected = sortedChiSenToShow
        
        //移除三個多增加的數量, 這三個是可能會錯的部分?? 為什麼只移除engWordsSelected..應該是因為這樣return cell就直接少三個
        for  _ in 0 ..< 3 {
            
            engWordsSelected.removeLast()
        }
        
        //預設collectionView的syl
        collectionSelectedIndex = 0
        
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
    
    @objc func removeBtns(){
        
        ghostBtn.isHidden = true
        alertBg.isHidden = true
        ghost2Btn.isHidden = true
        practiceWordBtn.isHidden = true
        practiceSenBtn.isHidden = true
        leftBtnClickedImg.isHidden = true
        rightBtnClickedImg.isHidden = true
    }
    
    @objc func practiceWord(){
        print("practice word")
        
        
        UIView.animate(withDuration: 0.06, animations: {[weak self] in
            
            self!.leftBtnClickedImg.alpha = 1
           
            
        }) {[weak self] (finished:Bool) in
            
            
            if finished {
                self!.leftBtnClickedImg.alpha = 0
        
            }
        }
        
        
    }
    
    @objc func practiceSen(){
        print("practice Sen")
        
        
        UIView.animate(withDuration: 0.06, animations: {[weak self] in
            
            self!.rightBtnClickedImg.alpha = 1
            
            
        }) {[weak self] (finished:Bool) in
            
            
            if finished {
                self!.rightBtnClickedImg.alpha = 0
                
            }
        }
        
        
    }
    
    //再次載入所有單字裡我的最愛要反紅的字, 使用時機: 在我的最愛裡修改過後跳回所有單字
    func loadAllWordFavs(){
        
        //載入我的最愛單字
        if let myWordsString = user!["myWords"] as! String?{
            myFavWords = myWordsString.components(separatedBy: ";")
        }
        
        /*
        myFavImgs.removeAll(keepingCapacity: false)
        
        //填入所有字的數量, 等等準備抓我的最愛的部分
        for _ in 0 ..< engWordsToShow.count - 3{
            myFavImgs.append(0)
            
        }
        */
        //去對有沒有符合我的最愛然後將其反紅
        /*
        for i in 0 ..< engWordsToShow.count{
            
            let word = engWordsToShow[i].replacingOccurrences(of: " ", with: "")
            
            for myWord in myFavWords{
                
                if myWord == word {
                    
                    //抓全部單字要反紅的部分
                    //myFavImgs[i] = 1
                    
                }
                
            }
            
        }
        */
    }
    
    
    //讀取我的最愛的單字, 使用時機: (1) 在我的最愛裡刪除最愛單字, 做即時反應 (2) 其他時候跳轉到我的最愛畫面時
    func loadMyFavWords(){
        
        //載入我的最愛單字
        if let myWordsString = user!["myWords"] as! String?{
            myFavWords = myWordsString.components(separatedBy: ";")
        }
        
        
        //刪除所有已append的值
        myFavEngWordsToShow.removeAll(keepingCapacity: false)
        myFavChiWordsToShow.removeAll(keepingCapacity: false)
        myFavPartOfSpeechToShow.removeAll(keepingCapacity: false)
        myFavSyllablesToShow.removeAll(keepingCapacity: false)
        myFavEngSenToShow.removeAll(keepingCapacity: false)
        myFavChiSenToShow.removeAll(keepingCapacity: false)
       // myFavImgs.removeAll(keepingCapacity: false)
        
        
        //所有單字反紅
        /*
        for _ in 0 ..< myFavWords.count{
            
            myFavImgs.append(1)
            
        }
        */
        
        //以所有的單字來match我的最愛單字的資訊
        for i in 0 ..< sortedEngWordsToShow.count{
            
            //做比對使用
            let word = sortedEngWordsToShow[i].replacingOccurrences(of: " ", with: "")
            for myWord in myFavWords{
                
                if myWord == word {
                    
                    let chiWord = sortedChiWordsToShow[i]
                    let partOfSpeech = sortedPartOfSpeechToShow[i]
                    let syllables = sortedSyllablesToShow[i]
                    let wordToAppend = sortedEngWordsToShow[i]
                    let engSenToAppend = sortedEngSenToShow[i]
                    let chiSenToAppend = sortedChiSenToShow[i]
                    
                    myFavEngWordsToShow.append(wordToAppend)
                    myFavChiWordsToShow.append(chiWord)
                    myFavPartOfSpeechToShow.append(partOfSpeech)
                    myFavSyllablesToShow.append(syllables)
                    myFavEngSenToShow.append(engSenToAppend)
                    myFavChiSenToShow.append(chiSenToAppend)
                    
                    
                }
                
            }
            
        }
        
        //選擇好要show的單字
        engWordsSelected = myFavEngWordsToShow
        chiWordsSelected = myFavChiWordsToShow
        partOfSpeechSelected = myFavPartOfSpeechToShow
        syllablesSelected = myFavSyllablesToShow
        engSenSelected = myFavEngSenToShow
        chiSenSelected = myFavChiSenToShow
        
        //不產生動畫的reload
        tableView.reloadData()
 
        findMatchCollectionCell()
        
    }
    
    //載入錯誤單字, 使用時機: 移除錯誤單字即時顯示使用
    func loadMyWrongWords(){
        
        //載入我的錯誤單字
        if let myWrongWordsString = user!["wrongWords"] as! String?{
            myWrongWords = myWrongWordsString.components(separatedBy: ";")
            
        }
        
        myWrongEngWordsToShow.removeAll(keepingCapacity: false)
        myWrongChiWordsToShow.removeAll(keepingCapacity: false)
        myWrongPartOfSpeechToShow.removeAll(keepingCapacity: false)
        myWrongSyllablesToShow.removeAll(keepingCapacity: false)
        myWrongEngSenToShow.removeAll(keepingCapacity: false)
        myWrongChiSenToShow.removeAll(keepingCapacity: false)
        
        
        for i in 0 ..< sortedEngWordsToShow.count{
            
            let word = sortedEngWordsToShow[i].replacingOccurrences(of: " ", with: "")
            
            //抓我的錯字
            for myWrongWord in myWrongWords{
                
                if myWrongWord == word {
                    
                    let chiWord = sortedChiWordsToShow[i]
                    let partOfSpeech = sortedPartOfSpeechToShow[i]
                    let syllables = sortedSyllablesToShow[i]
                    let wordToAppend = sortedEngWordsToShow[i]
                    let engSenToAppend = sortedEngSenToShow[i]
                    let chiSenToAppend = sortedChiSenToShow[i]
                    
                    myWrongEngWordsToShow.append(wordToAppend)
                    myWrongChiWordsToShow.append(chiWord)
                    myWrongPartOfSpeechToShow.append(partOfSpeech)
                    myWrongSyllablesToShow.append(syllables)
                    myWrongEngSenToShow.append(engSenToAppend)
                    myWrongChiSenToShow.append(chiSenToAppend)
                    
                    
                }
                
                
            }
            
            
        }
        
        engWordsSelected = myWrongEngWordsToShow
        chiWordsSelected = myWrongChiWordsToShow
        partOfSpeechSelected = myWrongPartOfSpeechToShow
        syllablesSelected = myWrongSyllablesToShow
        engSenSelected = myWrongEngSenToShow
        chiSenSelected = myWrongChiSenToShow
        
        
        tableView.reloadData()
        findMatchCollectionCell()
    }
    
    //上方segMent選擇
    func didSelect(_ segmentIndex: Int) {
        
        //停止所有func
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        switch segmentIndex{
            
        case 0:
            //再次讀我的最愛反紅部分
            loadAllWordFavs()
            //切換到可以修改最愛的模式
            likeMode = true
            
            //設定要顯示的字
            /*
            engWordsSelected = engWordsToShow
            chiWordsSelected = chiWordsToShow
            partOfSpeechSelected = partOfSpeechToShow
            syllablesSelected = syllablesToShow
            engSenSelected = engSenToShow
            chiSenSelected = chiSenToShow
            */
            
            engWordsSelected = sortedEngWordsToShow
            chiWordsSelected = sortedChiWordsToShow
            partOfSpeechSelected = sortedPartOfSpeechToShow
            syllablesSelected = sortedSyllablesToShow
            engSenSelected = sortedEngSenToShow
            chiSenSelected = sortedChiSenToShow
            
            
            //移除三個多增加的數量
            for  _ in 0 ..< 3 {
                engWordsSelected.removeLast()
            }
            
            tableView.reloadData()
            findMatchCollectionCell()
            
        case 1:
            
            
            likeMode = false
            //讀取錯字
            
            //內包含findMatch
            loadMyWrongWords()
            
            
        case 2:
            
            
            likeMode = true
            //內包含findMatch
            loadMyFavWords()
            
        default:
            break
        }
        
        
        
    }
    
    
    //自動播放鍵
    @IBAction func playClicked(_ sender: Any) {
        
        if isAutoPlay{
            
            //立即停止發音 & 停止上次動作
            stopSpeech()
            
            autoPlayText.textColor = btnOffColor
            autoPlayImg.image = UIImage(named:"bookPlayOff.png")
            isAutoPlay = false
            
            //停止播放
            
            
        } else {

            //立即停止發音 & 停止上次動作
            stopSpeech()
            
            autoPlayText.textColor = btnOnColor
            autoPlayImg.image = UIImage(named:"bookPlayOn.png")
            isAutoPlay = true
            
            
            //確認是否有字, 才會發音
            if engWordsSelected.count > 0 {
            
            
            //Part 1. scroll停止
            tableView.setContentOffset(tableView.contentOffset, animated: false)
            
            //Part 2. 抓visible的中間cell
            if let cells = tableView.visibleCells as [UITableViewCell]?{
                
                //設定選擇到的cell
                var selectedCell = UITableViewCell()

                //首先抓最上方的cell Index
                let topCell = tableView.indexPathsForVisibleRows![0]
                
                //確認有沒有全部顯示
                let cellRect = tableView.rectForRow(at: topCell)
                let isCompletelyVisible = tableView.bounds.contains(cellRect)
    
                //如果index是0, 又全部顯示, 就選擇第一個cell
                if topCell.row == 0 && isCompletelyVisible{
                    
                    selectedCell = cells[0]
   
                    
                    //其餘狀態選第2個
                } else if cells.count > 1 {
                    
                    selectedCell = cells[1]
   
                }
                
                //抓目前cell的label
                let currentEngWordLabel = selectedCell.viewWithTag(2) as! UILabel
                
                //比對單字
                    for i in 0 ..< engWordsSelected.count{
                        
                        let engWord = engWordsSelected[i].replacingOccurrences(of: " ", with: "")
                        
                        //抓出順序
                        if engWord == currentEngWordLabel.text!{
                            
                            //指定順序及發音單字
                            currentWordIndex = i
                            
                            synEngWord = engWord
                            synChiWord = chiWordsSelected[i]
                            synEngSen = engSenSelected[i]
                            synChiSen = chiSenSelected[i]
                            
                        }
                    }
                
                    //跳轉到該個單字
                    let index = IndexPath(row: currentWordIndex, section: 0)
                    tableView.scrollToRow(at: index, at: .middle, animated: true)
                    
                    let row = tableView.cellForRow(at: index)
                    UIView.animate(withDuration: 0.2, animations: {[weak self] in
                        
                        row?.backgroundColor = self!.lightRed
                        }, completion: { (finished:Bool) in
                            if finished{
                                UIView.animate(withDuration: 0.2, animations: {
                                    
                                    row?.backgroundColor = .clear
                                })
                                
                            }
                    })
                    
                    
                    //Part 3. 往下播放
                    synPronounce()
                
            }
            }else {
                
                //找不到字
                print("no word")
            }
        }
        
        
    }
    
    @IBAction func practiceBtnClicked(_ sender: Any) {
        print("enter practice")
        
        ghostBtn.isHidden = false
        alertBg.isHidden = false
        ghost2Btn.isHidden = false
        practiceWordBtn.isHidden = false
        practiceSenBtn.isHidden = false
        leftBtnClickedImg.isHidden = false
        rightBtnClickedImg.isHidden = false
        
        
    }
    
    //播放完每次發音後的行為, 在此控制所有發音順序
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        
       
        switch step{
         
        //英單
        case 1:
            
            switch speakTimes{
            case 1:

                alreadyPlayTimes = 0
                pronounceChi()
                
                
            case 2:
   
                switch alreadyPlayTimes{
                    
                case 1:
            
                    pronounceEng()
      
                case 2:
    
                    alreadyPlayTimes = 0
                    pronounceChi()
       
                default:
                    break
                    
                }
                
            case 3:
                switch alreadyPlayTimes{
                case 1:
                    pronounceEng()
                case 2:
              
                    pronounceEng()
                case 3:
            
                    alreadyPlayTimes = 0
                    pronounceChi()
                    
                default:
                    break

                }
            default:
                break
                
            }
         
      //中單
        case 2:
            
            //假如不播放句子, 就直接重播
            if !isPlaySentence{
                
                if !synth.isSpeaking{
                    autoPlayFunc()
                }
            } else {
                
                
                //英句
                //或者往下播放句子
                pronounceEngSen()

            }
            
        
            //中句
        case 3:
   
            pronounceChiSen()
            

            //是否重播
        case 4:

            
            
            switch speakTimes{
            case 1:
                if !synth.isSpeaking{
                    autoPlayFunc()
                }
                alreadyPlayTimes = 0
                
            case 2:
                
                switch alreadyPlayTimes{
                case 1:

                    pronounceEngSen()
                case 2:
                    
                    alreadyPlayTimes = 0
                    if !synth.isSpeaking{
                        autoPlayFunc()
                    }
                    
                    
                default:
                    break
                    
                }
                
            case 3:
                switch alreadyPlayTimes{
                    
                case 1:

                    pronounceEngSen()
                case 2:
                    

                    pronounceEngSen()
                case 3:
                    
                    alreadyPlayTimes = 0
                    if !synth.isSpeaking{
                        autoPlayFunc()
                    }
                    
                    
                default:
                    break
                    
                    
                }
            default:
                break
                
            }
            
        default:
            break
            
        }
        
        
    }
    
    func autoPlayFunc(){
        
        //繼續往下Play
        if isAutoPlay{
            
            
            if currentWordIndex < engWordsSelected.count - 1{
                currentWordIndex += 1
                
                synEngWord = engWordsSelected[currentWordIndex].replacingOccurrences(of: " ", with: "")
                synChiWord = chiWordsSelected[currentWordIndex]
                synEngSen = engSenSelected[currentWordIndex]
                synChiSen = chiSenSelected[currentWordIndex]
                
                
                let index = IndexPath(row: currentWordIndex, section: 0)
                tableView.scrollToRow(at: index, at: .middle, animated: true)
                
                let row = tableView.cellForRow(at: index)
                UIView.animate(withDuration: 0.2, animations: {[weak self] in
                    
                    row?.backgroundColor = self!.lightRed
                    }, completion: { (finished:Bool) in
                        if finished{
                            UIView.animate(withDuration: 0.2, animations: {
                                
                                row?.backgroundColor = .clear
                            })
                            
                        }
                })
                
                synPronounce()
                
            }
            
        }
    }
    
    @IBAction func playSentenceClicked(_ sender: Any) {
        
        if isPlaySentence{
            playSenText.textColor = btnOffColor
            playSenImg.image = UIImage(named:"bookSenOff.png")
            isPlaySentence = false
        } else {
            playSenText.textColor = btnOnColor
            playSenImg.image = UIImage(named:"bookSenOn.png")
            isPlaySentence = true
            
            
        }
        
    }
    
    @IBAction func playTimesClicked(_ sender: Any) {
        
        switch speakTimes{
            
        case 1:
            playTimesImg.image = UIImage(named:"bookTimes1.png")
            speakTimes = 2
        case 2:
            playTimesImg.image = UIImage(named:"bookTimes2.png")
            
            speakTimes = 3
        case 3:
            playTimesImg.image = UIImage(named:"bookTimes0.png")
            speakTimes = 1
        default:
            break
            
        }
        
    }
    
    
    @IBAction func playSpeedClicked(_ sender: Any) {
        
        switch speakRate{
            
        case 0.45:
            playSpeedImg.image = UIImage(named:"bookSpeed1.png")
            playSpeedText.textColor = btnOnColor
            speakRate = 0.25
            
        case 0.25:
            playSpeedImg.image = UIImage(named:"bookSpeed2.png")
            playSpeedText.textColor = btnOnColor
            
            
            speakRate = 0.15
            
        case 0.15:
            playSpeedImg.image = UIImage(named:"bookSpeed0.png")
            playSpeedText.textColor = btnOffColor
            
            
            speakRate = 0.45
            
        default:
            break
            
            
            
        }
        //立即停止發音 & 停止上次動作
        
        if synth.isSpeaking{

            //立即停止
            stopSpeech()
            
            //再次播放
            alreadyPlayTimes = 0
            synPronounce()
        }
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        print(engWordsSelected.count)
        
        return engWordsSelected.count
        
        //return 5
     
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellHight = tableView.frame.height / 2.5 / cellDif
        return cellHight
        
        
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let engWordSize = width / 14
        let chiWordSize = width / 30
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath) as! BookTableViewCell
    
        let syllableLabel = cell.viewWithTag(1) as! UILabel
        let engWordLabel = cell.viewWithTag(2) as! UILabel
        let partOfSpeechLabel = cell.viewWithTag(3) as! UILabel
        let chiWordLabel = cell.viewWithTag(4) as! UILabel
        let engSenLabel = cell.viewWithTag(5) as! UILabel
        let chiSenLabel = cell.viewWithTag(6) as! UILabel

        
        //抓音節的字母 +  數字
        let syllableText = syllablesSelected[indexPath.row]
        
        //let syllableNum = syllablesSelected[indexPath.row].replacingOccurrences(of: syllableText[0], with: "")
        

        
        
        //抓字
        let engWords = engWordsSelected[indexPath.row]

        
        //拆音節成array
        let engWordArray = engWords.components(separatedBy: " ")
       
        //定義母音
        let vowels = ["a","e","i","o","u"]
        
        //字型顏色
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: engWordSize), NSAttributedStringKey.foregroundColor : UIColor.cyan]
        let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: engWordSize), NSAttributedStringKey.foregroundColor : UIColor.white]
        
        //假如音節是_e, 另外處理
        if syllableText.contains("_") {

            var characters = [Character]()
            
            var attrWords = [NSMutableAttributedString]()
            
            //每一個英文字節拆字母
            for i in 0 ..< engWordArray.count{
                
                characters.removeAll(keepingCapacity: false)
                
                for i in engWordArray[i]{

                    

                    characters.append(i)
                    
                }
                
                
                //確認是不是_e部首, 目前設定為三個字母, 若要增加要在這裡修改
                if characters.count == 3 {
                    if characters[2] == "e"{
                        if vowels.contains(String(characters[0])){

                            
                            //剛好是_e部首
                            let word = NSMutableAttributedString(string: String(characters[0]), attributes: attrs1)
                            attrWords.append(word)
                            let word1 = NSMutableAttributedString(string: String(characters[1]), attributes: attrs2)
                            attrWords.append(word1)
                            let word2 = NSMutableAttributedString(string: String(characters[2]), attributes: attrs1)
                            attrWords.append(word2)
                            
                            
                            //以下確認非部首字就loop through 然後新增
                        } else {
                            
                            for c in 0 ..< characters.count {
                                
                                let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs2)
                                attrWords.append(word)
                            }
                        }
                        
                    } else {
                        
                        for c in 0 ..< characters.count {
                            
                            let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs2)
                            attrWords.append(word)
                        }
                        
                    }
                    
                } else {
                    
                    for c in 0 ..< characters.count {
                        
                        let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs2)
                        attrWords.append(word)
                    }
                    
                }
            }
            
            var word = NSMutableAttributedString()
            
            //跑這個字的array然後append成一個字串
            for i in 0 ..< attrWords.count {
                
                if i == 0 {
                    word = attrWords[i]
                } else {
                    word.append(attrWords[i])
                }
            }
            
            engWordLabel.attributedText = word
            
        } else {
            //非_e部首, 設定一些字的顏色
            
            var attrWords = [NSMutableAttributedString]()
            
            for i in 0 ..< engWordArray.count{
                
                if let engWord = engWordArray[i] as String?{
                    
                    //如果此字節是音節字元
                    if engWord.lowercased() == syllableText{
                        
                        let word = NSMutableAttributedString(string: engWord, attributes: attrs1)
                        attrWords.append(word)
                        
                    } else {
                        //一般字元
                        let word = NSMutableAttributedString(string: engWord, attributes: attrs2)
                        attrWords.append(word)
                    }
                    
                }
                
            }
            //造字
            var word = NSMutableAttributedString()
            for i in 0 ..< attrWords.count {
                if i == 0 {
                    word = attrWords[i]
                } else {
                    word.append(attrWords[i])
                }
            }
            
            engWordLabel.attributedText = word
        }
        
        
        //中文字及詞性
        let chiWord = chiWordsSelected[indexPath.row]
        let partOfSpeech = partOfSpeechSelected[indexPath.row].replacingOccurrences(of: "\r\n", with: "")
        
        //chiWordLabel.text = "(" + partOfSpeech + ")" + " " +  chiWord
        chiWordLabel.text = chiWord
        
        chiWordLabel.font = UIFont(name: "System Semibold", size: chiWordSize)
        engSenLabel.font = UIFont(name: "System Semibold", size: chiWordSize)
        chiSenLabel.font = UIFont(name: "System Semibold", size: chiWordSize)
        
        partOfSpeechLabel.font = UIFont(name: "Helvetica Neue Medium", size: chiWordSize)
        partOfSpeechLabel.adjustsFontSizeToFitWidth = true
        partOfSpeechLabel.text = partOfSpeech
        syllableLabel.adjustsFontSizeToFitWidth = true
        syllableLabel.text = syllableText
        
        chiSenLabel.adjustsFontSizeToFitWidth = true
        engSenLabel.adjustsFontSizeToFitWidth = true
        //抓句子
        let engSen = engSenSelected[indexPath.row]
        let chiSen = chiSenSelected[indexPath.row]
        
        engSenLabel.text = engSen
        chiSenLabel.text = chiSen
        
        cell.backgroundColor = .clear
        
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //立即停止發音 & 停止上次動作
        
        alreadyPlayTimes = 0
        currentWordIndex = indexPath.row
        
        stopSpeech()
        
        synEngWord = engWordsSelected[indexPath.row].replacingOccurrences(of: " ", with: "")
        synChiWord = chiWordsSelected[indexPath.row]
        
        if isPlaySentence{
            synEngSen = engSenSelected[indexPath.row]
            synChiSen = chiSenSelected[indexPath.row]
        }else {
            
            synEngSen = ""
            synChiSen = ""
        }
        
        
        synPronounce()
        
        let row = tableView.cellForRow(at: indexPath)
        UIView.animate(withDuration: 0.2, animations: {[weak self] in
            
            row?.backgroundColor = self!.lightRed
            }, completion: { (finished:Bool) in
                if finished{
                    UIView.animate(withDuration: 0.2, animations: {
                        
                        row?.backgroundColor = .clear
                    })
                    
                }
        })
        let index = IndexPath(row: indexPath.row, section: 0)
        tableView.scrollToRow(at: index, at: .middle, animated: true)
        
    }
    
    //用以下兩個方法來檢測scroll暫停時間
    
    @objc func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //滾動時不能選擇
        isCollectionViewSelectabel = false
        segControl.isEnabled = false
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(NewBookViewController.scrollViewDidEndDecelerating(_:)), object: nil)

        perform(#selector(NewBookViewController.scrollViewDidEndDecelerating(_:)), with: nil, afterDelay: 0.1)
        
    }
    
    @objc func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //滾動停止可以選擇
        isCollectionViewSelectabel = true
        segControl.isEnabled = true
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(NewBookViewController.scrollViewDidScroll(_:)), object: nil)
    
        //用這個func來決定collectionView Cell要顯示哪個
        
        if scrollView == tableView{
            
                  findMatchCollectionCell()
        }
  
        print("end scrolling")
        
    }
    
    //指定一個數字, 去找符合音節的字
    var indexToChange = Int()
    
    //決定collectionView 那個cell被選擇
    func findMatchCollectionCell(){
        
      
        
        if engWordsSelected.count > 0 {
        
        if let cells = tableView.visibleCells as [UITableViewCell]?{
            
            //抓最後那個cell的音節
            //定義音節的label, 有可能因為無值而找不到
            var sylTextLabel = UILabel()
            
            if cells.count > 2 {
                sylTextLabel = cells[1].viewWithTag(1) as! UILabel
                
            } else if cells.count > 0{
                sylTextLabel = cells[cells.count - 1].viewWithTag(1) as! UILabel
            }
            
            

         
                for i in 0 ..< sortedSylArray.count{
                    
                    if sortedSylArray[i] == sylTextLabel.text! {
                        indexToChange = i
                    }
                }
            
            //假如找到的話就做collecitonView更新
                //設定選項顏色
                for c in 0 ..< collectionTouched.count{
                    
                    collectionTouched[c] = 0
                }
                
                collectionTouched[indexToChange] = 1

        }
        } else {
            
            //找不到任何字, 把所有collection cell選項歸零
            for c in 0 ..< collectionTouched.count{
                collectionTouched[c] = 0
            }

        }
    
        //重整collectionView
        isScrolling = true

        
        let indexToScroll = IndexPath(row: indexToChange, section: 0)
        collectionView.scrollToItem(at: indexToScroll, at: .centeredVertically, animated: true)
        
        collectionView.reloadData()

    }
    
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return sortedSylArray.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isCollectionViewSelectabel{
            //設定選項顏色
            for i in 0 ..< collectionTouched.count{
                collectionTouched[i] = 0
                
            }
            collectionTouched[indexPath.row] = 1
            
            //指定文字
            collectionSelectedIndex = indexPath.row
            
            isScrolling = false
            
            collectionView.reloadData()
        }
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: "SylCell", for: indexPath as IndexPath)
        
        let blueBall = cell.viewWithTag(2) as! UIImageView
        let sylText = cell.viewWithTag(1) as!UILabel
        let sylToDisplay = sortedSylArray[indexPath.row]
        
        sylText.text = sylToDisplay
        sylText.textColor = btnOffColor
        
        sylSelected = sortedSylArray[collectionSelectedIndex!]
        
        if !isScrolling{
            jumpToRow(sylSelected: sylSelected!)
        }
        
        
        if collectionTouched[indexPath.row] == 1 {
            sylText.textColor = .white
            blueBall.isHidden = false
        } else {
            blueBall.isHidden = true
            sylText.textColor = .darkGray
            
        }
        
        return cell
        
    }
    
    func jumpToRow(sylSelected:String){
        
        var isJump = false
        //找對應的row, 並跳過去
        
            for i in 0 ..< syllablesSelected.count{
            
                if isJump == false {
                
            //確認有字可以跳, 因爲有一些是正開放可以學習的單字但是不代表已經過了
            if syllablesSelected[i] == sylSelected{
                
                if i < tableView.numberOfRows(inSection: 0){
                    
                    if i == 0 {
                        
                        let index = IndexPath(row: 0, section: 0)
                        
                        tableView.scrollToRow(at: index, at: .top, animated: true)
                        
                        isJump = true
                        
                    } else {
                        
                        let index = IndexPath(row: i + 1, section: 0)
                        
                        tableView.scrollToRow(at: index, at: .bottom, animated: true)
                        
                        isJump = true
                        
                    }
                    
                }
    
            }
                }
        }
    
        
   
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        
        synth.stopSpeaking(at: .immediate)
        synth.delegate = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //重設synth & 他的delegate
    func stopSpeech(){
        
        if synth.isSpeaking{
            
            synth.stopSpeaking(at: .immediate)
            synth = AVSpeechSynthesizer()
            synth.delegate = self
            
        }
    }
    
    //syn發音
    func synPronounce(){
        
        do {

            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
        } catch  {
            
        }
       
        
        pronounceEng()
        
        
    }
    
    
    @objc func pronounceEng(){
        
        alreadyPlayTimes += 1
        step = 1
        let engWord = AVSpeechUtterance(string: synEngWord)
        engWord.voice = AVSpeechSynthesisVoice(language: "en-US")
        engWord.rate = Float(speakRate)
        synth.speak(engWord)
        print("already:\(alreadyPlayTimes)")
        
    }
    
    @objc func pronounceChi(){
        
        step = 2
        let chiWord = AVSpeechUtterance(string:synChiWord)
        chiWord.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        chiWord.rate = 0.48
        synth.speak(chiWord)
        
        
    }
    
    //英文句子念完才算結束
    
    @objc func pronounceEngSen(){
        
        
        step = 3
        let engSen = AVSpeechUtterance(string:synEngSen)
        engSen.voice = AVSpeechSynthesisVoice(language: "en-US")
        engSen.rate = Float(speakRate)
        synth.speak(engSen)
        
    }
    
    
    @objc func pronounceChiSen(){
        
        
        alreadyPlayTimes += 1
        step = 4
        
        print("alreadyPlay:\(alreadyPlayTimes)")
        
        let chiSen = AVSpeechUtterance(string:synChiSen)
        chiSen.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        chiSen.rate = 0.48
        synth.speak(chiSen)
        
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

