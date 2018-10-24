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


//TwicketSegment有在內部修改slider的高度


class NewBookViewController: UIViewController,TwicketSegmentedControlDelegate, UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, AVSpeechSynthesizerDelegate, UICollectionViewDelegateFlowLayout{
    
    //所有音節
    var syllableSets = [String]()
    
 
    //刪掉數字的音節
    var sylArray = [String]()
    
    //整理過的音節
    var sortedSylArray = [String]()
    
    //選擇到的音節
    var collectionTouched = [Int]()
    
    //上方的seg
    let segControl = TwicketSegmentedControl()
    
    //let darkPurpleColor = UIColor.init(red: 82/255, green: 90/255, blue: 120/255, alpha: 1)
    let darkPurpleColor = UIColor.init(red: 124/255, green: 136/255, blue: 183/255, alpha: 1)
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
    let orangeColor = UIColor.init(red: 232/255, green: 98/255, blue: 61/255, alpha: 1)

    let wrongPronounceWords:[[String:[String]]] = [["烘焙":["烘陪"]], ["affect":["a fect"]], ["頭髮":["頭法"]], ["campaign":["cam pain"]], ["和":["汗"]], ["woman":["wo men"]], ["snowman":["snow man"]], ["fisherman":["fisher man"]], ["gentleman":["gentle man"]], ["supermarket":["super market"]], ["劣拙地":["列濁地"]], ["begin":["be ghing"]], ["巧克力":["巧顆粒"]], ["lead":["leed"]], ["tear":["tee er"]], ["度數":["度樹"]], ["年紀較長的":["年紀較漲的"]], ["告訴":["吿速"]], ["envelope":["anvelope"]], ["sensor":["sen sir"]], ["友誼":["有宜"]], ["kilometer":["killa meter"]], ["桶子":["統子"]], ["油炸":["油柵"]], ["外框":["外筐"]], ["高麗菜":["高力菜"]], ["油炸的":["油柵的"]], ["磨坊":["魔訪"]], ["螫":["遮"]], ["kneepad":["knee pad"]], ["iron":["eye ern"]], ["歌曲":["哥取"]], ["鵝":["蛾"]], ["forehead":["fore head"]], ["數":["鼠"]], ["April":["eigh pro"]], ["重播":["蟲剝"]], ["槳糊":["降胡"]], ["stupid":["stubid"]], ["錫":["習"]], ["曲線":["娶線"]], ["風箏":["風蒸"]], ["comb":["kome"]], ["wolf":["wallf"]], ["absurd":["a bsurd"]]]
    
    var courseReceived = Int()
    
    var syllableGroup = [[[String()]]]
    var mapPassedInt:Int?
    var gamePassedDic:[Int:Int]?
    var increaseNum = Int()
    
    var maxMapNum = Int()
    var maxSpotNum = Int()
    
    var isAllEmpty = true
    
    var xDif = CGFloat()
    var iPadDif: CGFloat!
    var collectionViewCellSize:CGFloat!
    var sylFontSize: CGFloat!
    var wordsToAddToFav = [String]()
    var wordsToDeleteInFav = [String]()
    var wordsToDeleteInWrong = [String]()
    var engWordSizeDif: CGFloat!
    var chiWordSizeDif: CGFloat!
    
    var favAddedLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var sliderHeight: CGFloat!
        var btnDif: CGFloat!
        var btnTextFontSize: CGFloat!

        var alertXDif:CGFloat!

        //準備口試句子
        NotificationCenter.default.addObserver(self, selector: #selector(NewBookViewController.turnOffRedLight), name: NSNotification.Name("turnOffRedLight"), object: nil)
        
        switch height {
            
        case 1366, 1336, 1112:
            seperatorDif = 2.5
            dif = 0.9
            cellDif = 1.2
            fontDif = 5
            xDif = 0
     
            iPadDif = 1.8
            collectionViewCellSize = 100
            sylFontSize = 30
            sliderHeight = 60
            btnDif = 2.5
            btnTextFontSize = 20

            engWordSizeDif = 18
            chiWordSizeDif = 30
        
            alertXDif = 1
            
        case 1024:
            seperatorDif = 1.9
            dif = 0.9
            cellDif = 1.1
            fontDif = 5
            xDif = 0
        
            iPadDif = 1.4
            collectionViewCellSize = 80
            sylFontSize = 24
            sliderHeight = 50
            btnDif = 1.8
            btnTextFontSize = 18
   
            engWordSizeDif = 18
            chiWordSizeDif = 26
    
            alertXDif = 1
            
        case 812:
            
            seperatorDif = 0.9
            dif = 1.35
            cellDif = 1.2
            fontDif = 0
            xDif = 50
   
            iPadDif = 1
            collectionViewCellSize = 50
            sylFontSize = 15
            sliderHeight = 30
            btnDif = 1
            btnTextFontSize = 14
     
            engWordSizeDif = 14
            chiWordSizeDif = 24
       
            alertXDif = 0.8

            
        case 736:
            seperatorDif = 1.1
            dif = 1.1
            cellDif = 1.1
            fontDif = 3
            xDif = 0

            iPadDif = 1.1
            collectionViewCellSize = 50
            sylFontSize = 15
            sliderHeight = 30
            btnDif = 1
            btnTextFontSize = 14

            engWordSizeDif = 14
            chiWordSizeDif = 26
    
            alertXDif = 1

            
        case 667:
            
            seperatorDif = 1
            dif = 1
            cellDif = 1
            fontDif = 4
            xDif = 0
   
            iPadDif = 1.1
            collectionViewCellSize = 50
            sylFontSize = 15
            sliderHeight = 30
            btnDif = 1
            btnTextFontSize = 14
            engWordSizeDif = 12
            chiWordSizeDif = 24
        
            alertXDif = 1

            
        case 568:
            seperatorDif = 0.9
            dif = 0.9
            cellDif = 0.9
            fontDif = 5
            xDif = 0
     
            iPadDif = 1.1
            collectionViewCellSize = 50
            sylFontSize = 12
            sliderHeight = 30
            btnDif = 1
            btnTextFontSize = 14
      
            engWordSizeDif = 14
            chiWordSizeDif = 24
      
            alertXDif = 1

        default:

            break
            
        }
        
        
        print("courseReceived\(courseReceived)")
        
        
        //MARK: must update
        //在此就算user == nil, gamePasse & mapPasse也都設定好初始值了
        
        switch courseReceived{
            
        case 0:
            syllableGroup.append(map1SyllableSets)
            syllableGroup.append(map2SyllableSets)
            syllableGroup.append(map3SyllableSets)
            syllableGroup.append(map4SyllableSets)
            syllableGroup.append(map5SyllableSets)
            mapPassedInt = mapPassed
            gamePassedDic = gamePassed
            increaseNum = 0
            maxMapNum = 5
            maxSpotNum = 14
            
        
        case 1:
            syllableGroup.append(map6SyllableSets)
            syllableGroup.append(map7SyllableSets)
            syllableGroup.append(map8SyllableSets)
            syllableGroup.append(map9SyllableSets)
            syllableGroup.append(map10SyllableSets)
            syllableGroup.append(map11SyllableSets)
            
            mapPassedInt = mapPassed2
            gamePassedDic = gamePassed2
            increaseNum = 5
            maxMapNum = 6
            maxSpotNum = 14
           
            
        case 2:
            syllableGroup.append(map12SyllableSets)
            syllableGroup.append(map13SyllableSets)
            syllableGroup.append(map14SyllableSets)
            syllableGroup.append(map15SyllableSets)
            syllableGroup.append(map16SyllableSets)
            syllableGroup.append(map17SyllableSets)
            syllableGroup.append(map18SyllableSets)

            mapPassedInt = mapPassed3
            gamePassedDic = gamePassed3
            increaseNum = 11
            maxMapNum = 7
            maxSpotNum = 14
            
            
        case 3:
            syllableGroup.append(map19SyllableSets)
            syllableGroup.append(map20SyllableSets)
            syllableGroup.append(map21SyllableSets)
            syllableGroup.append(map22SyllableSets)
            syllableGroup.append(map23SyllableSets)
            syllableGroup.append(map24SyllableSets)
            syllableGroup.append(map25SyllableSets)
            syllableGroup.append(map26SyllableSets)
            syllableGroup.append(map27SyllableSets)
            
            mapPassedInt = mapPassed4
            gamePassedDic = gamePassed4
            increaseNum = 18
            maxMapNum = 9
            maxSpotNum = 14

        case 4:
            syllableGroup.append(map28SyllableSets)
            syllableGroup.append(map29SyllableSets)
            syllableGroup.append(map30SyllableSets)
            syllableGroup.append(map31SyllableSets)
            syllableGroup.append(map32SyllableSets)
            syllableGroup.append(map33SyllableSets)
            syllableGroup.append(map34SyllableSets)
            syllableGroup.append(map35SyllableSets)
          
            mapPassedInt = mapPassed5
            gamePassedDic = gamePassed5
            increaseNum = 27
            maxMapNum = 8
            maxSpotNum = 14
            

        default:
            break
      
        }
        
        //加入alertView
       
        let lightGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.58)
        ghostBtn.frame = CGRect(x: 0, y: 0, width: width, height: height)
        ghostBtn.backgroundColor = lightGray
        //ghostBtn.addTarget(self, action: #selector(NewBookViewController.removeBtns), for: .touchUpInside)
        self.view.addSubview(ghostBtn)
        
        //alertBg.frame = CGRect(x: (width - 237 * dif) / 2 + xDif, y: height * 2 /  5, width: width * 237 / 375, height: height * 140 / 667)
        alertBg.image = UIImage(named: "reviewQuitBg3.png")
        self.view.addSubview(alertBg)

        
        alertBg.translatesAutoresizingMaskIntoConstraints = false
        alertBg.widthAnchor.constraint(equalToConstant: 237 * dif * btnDif * alertXDif).isActive = true
        alertBg.heightAnchor.constraint(equalToConstant: 140 * dif * btnDif * alertXDif).isActive = true
        alertBg.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        alertBg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        
        ghost2Btn.frame = CGRect(x: (width - 237 * dif) / 2, y: height * 2 /  5, width: width * 237 / 375, height: height * 140 / 667)
        self.view.addSubview(ghost2Btn)
        
        //alertText.frame = CGRect(x: 5 * dif , y: 15 * dif, width: alertBg.frame.width - 5 * dif * 2, height: alertBg.frame.height / 2)
        alertText.font = UIFont(name: "Helvetica Bold", size: sylFontSize)
        alertText.textColor = .white
        alertText.text = "選擇練習模式"
        alertText.numberOfLines = 0
        alertText.textAlignment = .center
        alertText.adjustsFontSizeToFitWidth = true
        alertBg.addSubview(alertText)
        
        //alertText.backgroundColor = .green
        alertText.translatesAutoresizingMaskIntoConstraints = false
        alertText.widthAnchor.constraint(equalToConstant: 237 * dif * btnDif * 0.7 * alertXDif).isActive = true
        alertText.heightAnchor.constraint(equalToConstant: 140 * dif * btnDif * 0.4 * alertXDif).isActive = true
        alertText.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10 * iPadDif).isActive = true
        alertText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        //practiceWordBtn.frame = CGRect(x: alertBg.frame.minX, y: alertBg.frame.maxY - 40 * cellDif + iPadSmall, width: alertBg.frame.width, height: height * 44 / 667)
   
        practiceWordBtn.titleLabel?.font = UIFont(name: "Helvetica Bold", size: sylFontSize)
        practiceWordBtn.setTitle("我知道了", for: .normal)
        practiceWordBtn.setTitleColor(orangeColor, for: .normal)
        practiceWordBtn.addTarget(self, action: #selector(NewBookViewController.practiceWord), for: .touchUpInside)
        self.view.addSubview(practiceWordBtn)
        
        //practiceWordBtn.backgroundColor = .yellow
        practiceWordBtn.translatesAutoresizingMaskIntoConstraints = false
        practiceWordBtn.widthAnchor.constraint(equalToConstant: 237 * dif * btnDif * alertXDif).isActive = true
        practiceWordBtn.heightAnchor.constraint(equalToConstant: 140 * dif * btnDif * 0.3 * alertXDif).isActive = true
        practiceWordBtn.topAnchor.constraint(equalTo: alertText.bottomAnchor, constant: 15 * iPadDif).isActive = true
        practiceWordBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        /*
        practiceSenBtn.frame = CGRect(x: practiceWordBtn.frame.maxX, y: alertBg.frame.maxY - 44 * dif, width: alertBg.frame.width / 2, height: height * 44 / 667)
        practiceSenBtn.setTitle("複習句型", for: .normal)
        practiceSenBtn.setTitleColor(darkRed, for: .normal)
        practiceSenBtn.addTarget(self, action: #selector(NewBookViewController.practiceSen), for: .touchUpInside)
        self.view.addSubview(practiceSenBtn)
         */
        
        
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
        
        backBtn.frame = CGRect(x: width / 14 / iPadDif , y: width / 10 / iPadDif / iPadDif, width: 19 * iPadDif, height: 31 * iPadDif)
        
        //backBtn.anchor(top: view.safeTopAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: nil, padding: .init(top: 10 * iPadDif, left: 15 * iPadDif, bottom: 0, right: 0), size: .init(width: 19 * iPadDif, height: 31 * iPadDif))
        
        //設定好segMent
        segControl.frame = CGRect(x: backBtn.frame.maxX, y: backBtn.frame.minY,width: width - backBtn.frame.width * 4, height: sliderHeight )
        self.view.addSubview(segControl)
        
        
        collectionView.frame = CGRect(x: backBtn.frame.minX, y: segControl.frame.maxY + 5 * dif, width: width - (backBtn.frame.minX * 2), height: height / 3.2)
       //collectionView.backgroundColor = .red
        
        tableView.frame = CGRect(x: 0, y: collectionView.frame.maxY, width: width, height: height - collectionView.frame.maxY - 66 * dif * iPadDif)
        
        bookViewBottomBg.frame = CGRect(x: 0, y: tableView.frame.maxY, width: width, height: 66 * dif * iPadDif)
        
        playBtn.frame = CGRect(x: 0, y: tableView.frame.maxY, width: width / 4, height: 66 * dif * iPadDif)
        //playBtn.backgroundColor = .red
        
        //autoPlayImg.frame = CGRect(x: (width / 5 - 23 * dif) / 2, y: bookViewBottomBg.frame.minY + 12 * dif, width: 23 * dif, height: 23 * dif)
        
        //autoPlayImg.center = CGPoint(x: playBtn.frame.midX, y: bookViewBottomBg.frame.midY - 12 * dif * btnDif)
        //autoPlayImg.frame.size = CGSize(width: 23 * dif * btnDif, height: 23 * dif * btnDif)
        autoPlayImg.translatesAutoresizingMaskIntoConstraints = false
        autoPlayImg.widthAnchor.constraint(equalToConstant: 23 * dif * btnDif).isActive = true
        autoPlayImg.heightAnchor.constraint(equalToConstant: 23 * dif * btnDif).isActive = true
        autoPlayImg.centerYAnchor.constraint(equalTo: bookViewBottomBg.centerYAnchor, constant: -autoPlayImg.frame.height / 2).isActive = true
        //autoPlayImg.leadingAnchor.constraint(equalTo: view.safeLeftAnchor, constant: width / 8 - autoPlayImg.frame.width).isActive = true
        
          autoPlayImg.centerXAnchor.constraint(equalTo: playBtn.centerXAnchor).isActive = true

        
        //autoPlayText.frame = CGRect(x:(width / 5 - 72 * dif) / 2, y: height - 21 * 1.2 * dif, width: 72 * dif , height: 21 * dif)
        //autoPlayText.backgroundColor = .green
      // autoPlayText.frame.size = CGSize(width: 72 * dif , height: 21 * dif)
        //autoPlayText.center = CGPoint(x: playBtn.frame.midX, y: height - 11 * 1.2 * dif)
        
        autoPlayText.anchor(top: autoPlayImg.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: nil,padding: .init(top: 5 * iPadDif, left: 0, bottom: 0, right: 0), size: .init(width: width / 4, height: bookViewBottomBg.frame.height / 3))
        
        autoPlayText.font = autoPlayText.font.withSize(btnTextFontSize)
        
        sentenceBtn.frame = CGRect(x: playBtn.frame.maxX, y: tableView.frame.maxY, width: width / 4, height: 66 * dif * iPadDif)
       
        //sentenceBtn.backgroundColor = .green
        
        //playSenImg.frame = CGRect(x: width / 5 + (width / 5 - 27 * dif) / 2 ,y: bookViewBottomBg.frame.minY + 12 * dif, width: 27 * dif, height: 23 * dif)
        
        //playSenImg.center = CGPoint(x: sentenceBtn.frame.midX, y: bookViewBottomBg.frame.midY - 12 * dif)
        //playSenImg.frame.size = CGSize(width: 27 * dif, height: 23 * dif)
        
        
        playSenImg.translatesAutoresizingMaskIntoConstraints = false
        playSenImg.widthAnchor.constraint(equalToConstant: 27 * dif * btnDif).isActive = true
        playSenImg.heightAnchor.constraint(equalToConstant: 23 * dif * btnDif).isActive = true
        playSenImg.centerYAnchor.constraint(equalTo: bookViewBottomBg.centerYAnchor, constant: -playSenImg.frame.height / 2).isActive = true
        //playSenImg.leadingAnchor.constraint(equalTo: playBtn.trailingAnchor ,constant: width / 8 - playSenImg.frame.width).isActive = true

        playSenImg.centerXAnchor.constraint(equalTo: sentenceBtn.centerXAnchor).isActive = true
        
       
        //playSenText.frame = CGRect(x: width / 5 + (width / 5 - 79 * dif) / 2, y: height - 21 * 1.2 * dif, width: 79 * dif , height: 21 * dif)
        //playSenText.frame.size = CGSize(width: 79 * dif , height: 21 * dif)
        //playSenText.center = CGPoint(x: sentenceBtn.frame.midX, y: height - 11 * 1.2 * dif)
        
        //playSenText.anchor(top: playSenImg.bottomAnchor, leading: playBtn.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 5 * iPadDif, left: 0, bottom: 0, right: 0), size: .init(width: width / 4, height: bookViewBottomBg.frame.height / 3))
        
        playSenText.anchor(top: autoPlayText.topAnchor, leading: playBtn.trailingAnchor, bottom: nil, trailing: nil, size: .init(width: width / 4, height: bookViewBottomBg.frame.height / 3))
        
        playSenText.font = playSenText.font.withSize(btnTextFontSize)
        
        playTimesBtn.frame = CGRect(x: sentenceBtn.frame.maxX, y: tableView.frame.maxY, width: width / 4, height: 66 * dif * iPadDif)
       
        
        //playTimesBtn.backgroundColor = .yellow
        
        //playTimesImg.frame = CGRect(x: width * 2 / 5 + (width / 5 - 46 * dif) / 2, y: bookViewBottomBg.frame.minY + 18 * dif, width: 46 * dif, height: 8 * dif)
        
        //playTimesImg.center = CGPoint(x: playTimesBtn.frame.midX, y: bookViewBottomBg.frame.midY - 11 * dif)
        //playTimesImg.frame.size = CGSize(width: 46 * dif, height: 8 * dif)
        
        
        playTimesImg.translatesAutoresizingMaskIntoConstraints = false
        playTimesImg.widthAnchor.constraint(equalToConstant: 46 * dif * btnDif).isActive = true
        playTimesImg.heightAnchor.constraint(equalToConstant: 8 * dif * btnDif).isActive = true
        playTimesImg.centerYAnchor.constraint(equalTo: bookViewBottomBg.centerYAnchor, constant: -playTimesImg.frame.height / 2).isActive = true

        playTimesImg.centerXAnchor.constraint(equalTo: playTimesBtn.centerXAnchor).isActive = true
        
        
        
        //playTimesText.frame = CGRect(x: width * 2 / 5 + (width / 5 - 76 * dif) / 2, y: height - 21 * 1.2 * dif, width: 76 * dif, height: 21 * dif)
        //playTimesText.frame.size = CGSize(width: 76 * dif, height: 21 * dif)
        //playTimesText.center = CGPoint(x: playTimesBtn.frame.midX, y: height - 11 * 1.2 * dif)
        
        
        //playTimesText.anchor(top: playTimesImg.bottomAnchor, leading: sentenceBtn.trailingAnchor, bottom: nil, trailing: nil,padding:.init(top: 10 * iPadDif - playTimeBtnYDif, left: 0, bottom: 0, right: 0) , size: .init(width: width / 4, height: bookViewBottomBg.frame.height / 3))
        
        playTimesText.anchor(top: playSenText.topAnchor, leading: sentenceBtn.trailingAnchor, bottom: nil, trailing: nil, size: .init(width: width / 4, height: bookViewBottomBg.frame.height / 3))
        
        playTimesText.font = playTimesText.font.withSize(btnTextFontSize)
        
        playSpeedBtn.frame = CGRect(x: playTimesBtn.frame.maxX, y: tableView.frame.maxY, width: width / 4, height: 66 * dif * iPadDif)
        
        //playSpeedBtn.backgroundColor = .purple
        
       // playSpeedImg.frame = CGRect(x: width * 3 / 5 + (width / 5 - 44 * dif) / 2, y: bookViewBottomBg.frame.minY + 12 * dif, width: 44 * dif, height: 28 * dif)
        
        
       // playSpeedImg.center = CGPoint(x: playSpeedBtn.frame.midX, y: bookViewBottomBg.frame.midY - 11 * dif)
      //  playSpeedImg.frame.size = CGSize(width: 44 * dif, height: 28 * dif)
        
        
        playSpeedImg.translatesAutoresizingMaskIntoConstraints = false
        playSpeedImg.widthAnchor.constraint(equalToConstant: 40 * dif * btnDif).isActive = true
        playSpeedImg.heightAnchor.constraint(equalToConstant: 26 * dif * btnDif).isActive = true
        playSpeedImg.centerYAnchor.constraint(equalTo: bookViewBottomBg.centerYAnchor, constant: -playSpeedImg.frame.height / 2).isActive = true
     
        playSpeedImg.centerXAnchor.constraint(equalTo: playSpeedBtn.centerXAnchor).isActive = true
        
        
        //playSpeedText.frame = CGRect(x: width * 3 / 5 + (width / 5 - 76 * dif) / 2, y:  height - 21 * 1.2 * dif, width: 76 * dif, height: 21 * dif)
        //playSpeedText.frame.size = CGSize(width: 76 * dif, height: 21 * dif)
        //playSpeedText.center = CGPoint(x: playSpeedBtn.frame.midX, y: height - 11 * 1.2 * dif)
        
        //playSpeedText.anchor(top: playSpeedImg.bottomAnchor, leading: playTimesBtn.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 5 * iPadDif, left: 0, bottom: 0, right: 0), size: .init(width: width / 4, height: bookViewBottomBg.frame.height / 3))
        
        playSpeedText.anchor(top: playTimesText.topAnchor, leading: playTimesBtn.trailingAnchor, bottom: nil, trailing: nil, size: .init(width: width / 4, height: bookViewBottomBg.frame.height / 3))
        
        playSpeedText.font = playSpeedText.font.withSize(btnTextFontSize)
        
        
        /*
        practiceBtn.frame = CGRect(x: playSpeedBtn.frame.maxX, y: tableView.frame.maxY, width: width / 5, height: 66 * dif)
        
        practiceImg.frame = CGRect(x: width * 4 / 5 + (width / 5 - 24 * dif) / 2, y: bookViewBottomBg.frame.minY + 12 * dif, width: 24 * dif, height: 24 * dif)
        
        practiceText.frame = CGRect(x: width * 4 / 5 + (width / 5 - 76 * dif) / 2, y:  height - 21 * 1.2 * dif, width: 76 * dif, height: 21 * dif)
        */
        
        practiceBtn.isHidden = true
        practiceImg.isHidden = true
        practiceText.isHidden = true
        
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
        segControl.setSegmentItems(segments:titles, height:sliderHeight)
        //segControl.set
        segControl.backgroundColor = .clear
        segControl.sliderBackgroundColor = segSliderBgColor
        segControl.segmentsBackgroundColor = .clear
        segControl.defaultTextColor = darkPurpleColor
        segControl.highlightTextColor = .white
        segControl.isSliderShadowHidden = true
        segControl.font = segControl.font.withSize(sylFontSize)
        
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
        
        
        favAddedLabel.frame = CGRect(x: (width - width * 0.8) / 2 , y: height / 2, width: width * 0.8, height: 50 * btnDif)
        favAddedLabel.adjustsFontSizeToFitWidth = true
        favAddedLabel.textColor = .white
        favAddedLabel.backgroundColor = .black
        favAddedLabel.clipsToBounds = true
        favAddedLabel.layer.cornerRadius = favAddedLabel.frame.width / 15
        favAddedLabel.font = UIFont(name: "Helvetica Bold", size: 20 * btnDif)
        favAddedLabel.textAlignment = .center
        favAddedLabel.numberOfLines = 2
        favAddedLabel.alpha = 0
        self.view.addSubview(favAddedLabel)
        self.view.bringSubview(toFront: favAddedLabel)
        
        
        //歸類所有syllable
        
        syllableGroup.removeFirst()
        
        for groupSet in syllableGroup{
            
            for group in groupSet{
                
                for syl in group{
                    
                    syllableSets.append(syl)
                    
                }
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
        
        /*
        print("book mapPassed:\(mapPassed!)")
        print("book gamPassed:\(gamePassed!)")
        */
        //所有已過關的地圖字都要抓進去
        
        
        if mapPassedInt == maxMapNum{
            
            //在這裡 -1 後面要加回來
            mapPassedInt! -= 1
            gamePassedDic = [maxSpotNum:9]
        }
        
        
        
        
        
        for m in 0 ..< mapPassedInt!{
            //要讀取裡面的全部
    
       
            //讀取已完整的所有字集 + 句子
            //print("m:\(m)")
            //目前設置15的原因因為所有探索點都有15個, 若之後不同課程有不同的探索點數, 要抓動態探索點數字
            
            
            //在此要加上increaseNum才能抓到正確的檔案
            
            for i in 0 ..< 15{
                
                var wordFile:String?
                //前面的1代表第一張地圖
                let name = String(m + increaseNum + 1) + "-" + String(i + 1)
                let sName = "s\(String(m + increaseNum + 1))-" + String(i + 1)
            
                
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
        for (s,_) in gamePassedDic!{
  
            
            
            //讀取已完整的所有字集 + 句子
            for i in 0 ..< (s){
                

                var wordFile:String?
                //前面的1代表第一張地圖
                
                //裡面的檔名也要加上increaseNum
                let name = String(describing: mapPassedInt! + increaseNum + 1) + "-" + String(i + 1)
                let sName = "s\(String(describing: mapPassedInt! + increaseNum + 1))-" + String(i + 1)
                
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
            
            //檔名要加上increaseNum
            let name = String(describing: mapPassedInt! + increaseNum + 1) + "-" + String(s + 1)
            let sName = "s\(String(describing: mapPassedInt! + increaseNum + 1))-" +  String(s + 1)
            
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
        
        for (_,g) in gamePassedDic!{
            

            
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
        
        
        //這部分之後要分course類了
        //載入我的最愛單字
        if let myWordsString = user?["myWords"] as! String?{
            myFavWords = myWordsString.components(separatedBy: ";")
        }
        
        //載入我的錯誤單字
        if let myWrongWordsString = user?["wrongWords"] as! String?{
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
        
      
        if (mapPassedInt! + 1) != maxMapNum{
            
            print("要移除三個")
        
        for  _ in 0 ..< 3 {
            
            engWordsSelected.removeLast()
        }
            
            
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
        
        
        //預設值
        alertTextShown = "\n此課程尚未學習任何單字\n單字集還是空的喔!"
        
        
        //沒有值的話 無線條
        tableView.tableFooterView = UIView()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        //沒有網路的測試要comment掉
        
        if user != nil {
            
            selectUser()
        }
    
        
        
    }
    
    
    //MARK: CollectionViewLayOut
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSize = CGSize(width: collectionViewCellSize, height: collectionViewCellSize)
        return cellSize
        
    }
    

    deinit {
        print("book deinit")
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
        
        //self.dismiss(animated: false, completion: nil)
  
        
        UIView.animate(withDuration: 0.06, animations: {[weak self] in
            
            self!.leftBtnClickedImg.alpha = 1
           
            
        }) {[weak self] (finished:Bool) in
            
            
            if finished {
                self!.leftBtnClickedImg.alpha = 0
        
                self!.removeBtns()
                //self!.isAlertPoppedOut = false
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
    
    
    
    //addToFav animation
    
    
    func addToFavAnimation(word:String, state:Int){

        switch state{
            
        case 0:
               favAddedLabel.text = "\(word)\n已新增至最愛"
        case 1:
            
            favAddedLabel.text = "沒有學習過的單字喔！"
        default:
            break
        }
        
        
     
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {[weak self] in
            self!.favAddedLabel.alpha = 1
            self!.favAddedLabel.frame.origin.y -= 20
        
        
        }) {[weak self] (finished:Bool) in
            
            UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveLinear, animations: {
                self!.favAddedLabel.alpha = 0
            }, completion: {[weak self] (finished:Bool) in
                
                self!.favAddedLabel.frame.origin.y += 20
                

                
            })
            
            
            
        }
        
        
        
    }
    

    
    
    
    var laterSaveMyFav = [String]()
    
    //讀取我的最愛的單字, 使用時機: (1) 在我的最愛裡刪除最愛單字, 做即時反應 (2) 其他時候跳轉到我的最愛畫面時
    func loadMyFavWords(){
        
        
        alertTextShown = "\n此課程還沒加任何字\n到我的最愛!"
        
        //載入我的最愛單字
        if let myWordsString = user?["myWords"] as! String?{
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
        
        //把臨時的加入myFavWord裡
        print("sortedEngWord:\(sortedEngWordsToShow)")
 
        //假如沒有全破關的話全部可顯示字要扣掉三個
        var tempCount = sortedEngSenToShow.count
        
        if (mapPassedInt! + 1) != maxMapNum{
            
            tempCount -= 3
        }
        
        
        //以所有的單字來match我的最愛單字的資訊
        for i in 0 ..< tempCount{
            
            //做比對使用
            let word = sortedEngWordsToShow[i].replacingOccurrences(of: " ", with: "")
            
            
            for myWord in myFavWords{
                
                if myWord == word && !tempFavWordsToDelete.contains(myWord) {
                    
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
        
        //目前機制 先看delete完再看add就是正確
        for temp in tempMyFav {
            
            
            for fav in myFavWords{
                
                
                if temp == fav && !tempFavWordsToDelete.contains(temp){
                    
                    
                    tempMyFav = tempMyFav.filter { $0 != temp }
                }
                
            }
            
            
        }



        //以所有的單字來match我的最愛單字的資訊
        for i in 0 ..< sortedEngWordsToShow.count{
            
            //做比對使用
            let word = sortedEngWordsToShow[i].replacingOccurrences(of: " ", with: "")
            
            
            for myWord in tempMyFav{
                
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
        
        alertTextShown = "\n此課程到目前為止\n無任何錯字!"
        
        //載入我的錯誤單字
        if let myWrongWordsString = user?["wrongWords"] as! String?{
            myWrongWords = myWrongWordsString.components(separatedBy: ";")
            
        }
        
        myWrongEngWordsToShow.removeAll(keepingCapacity: false)
        myWrongChiWordsToShow.removeAll(keepingCapacity: false)
        myWrongPartOfSpeechToShow.removeAll(keepingCapacity: false)
        myWrongSyllablesToShow.removeAll(keepingCapacity: false)
        myWrongEngSenToShow.removeAll(keepingCapacity: false)
        myWrongChiSenToShow.removeAll(keepingCapacity: false)
        
        print(myWrongWords.count)
        
        for i in 0 ..< sortedEngWordsToShow.count{
            
            let word = sortedEngWordsToShow[i].replacingOccurrences(of: " ", with: "")
            
                for myWrongWord in myWrongWords{
                    
                     if myWrongWord == word && !tempWrongWordsToDelete.contains(myWrongWord){
                    
                    
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

            
            
        /*
            
            //抓我的錯字
            for myWrongWord in myWrongWords{
                
                //排除暫時刪除的字
      //          for temp in tempWrongWordsToDelete{
                
                
                if myWrongWord == word {
                    
                    if tempWrongWordsToDelete.count > 0 {
                    
                    for temp in tempWrongWordsToDelete {
                        
                        if myWrongWord != temp {
                            
                            
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
                    } else {
             
                    
                    }
                }
          
                
            }
            
            */
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
    
    var alertTextShown = String()

    func didSelect(_ segmentIndex: Int) {
        
        //停止所有func
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        switch segmentIndex{
            
        case 0:
            
            isAllEmpty = true


            engWordsSelected = sortedEngWordsToShow
            chiWordsSelected = sortedChiWordsToShow
            partOfSpeechSelected = sortedPartOfSpeechToShow
            syllablesSelected = sortedSyllablesToShow
            engSenSelected = sortedEngSenToShow
            chiSenSelected = sortedChiSenToShow
            
            //移除三個多增加的數量
             if (mapPassedInt! + 1) != maxMapNum{
                
            
                for  _ in 0 ..< 3 {
                
                engWordsSelected.removeLast()
            
                }
            
            }
            tableView.reloadData()
            findMatchCollectionCell()
            
        case 1:
            
            isAllEmpty = false
          
            //讀取錯字
            
            //內包含findMatch
            loadMyWrongWords()
         
            
        case 2:
            
            isAllEmpty = false
         
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
                            
                            
                            //抓發音錯誤字集
                            for i in 0 ..< wrongPronounceWords.count{
                                
                                for (word,rightWord) in wrongPronounceWords[i]{
                                    
                                    //假如有抓到的話
                                    if word == engWord{
                                        print("found wrong pronounce word")
                                        synEngWord = rightWord[0]
                                        
                                    }
                                    
                                }
                                
                            }
     
                            
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
                
                //抓發音錯誤字集
                for i in 0 ..< wrongPronounceWords.count{
                    
                    for (word,rightWord) in wrongPronounceWords[i]{
                        
                        //假如有抓到的話
                        if word == synEngWord{
                            print("found wrong pronounce word")
                            synEngWord = rightWord[0]
                            
                        }
                        
                    }
                    
                }
                
                
                
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
        
        if engWordsSelected.count == 0 {
            
            print("沒有字")
            
            
            ghostBtn.isHidden = false
            alertBg.isHidden = false
            ghost2Btn.isHidden = false
            practiceWordBtn.isHidden = false
            //practiceSenBtn.isHidden = false
            leftBtnClickedImg.isHidden = false
            rightBtnClickedImg.isHidden = false
            alertText.text = alertTextShown
            alertText.textAlignment = .center
            
            if isAllEmpty{
                //設定直接跳出畫面
                
                practiceWordBtn.removeTarget(self, action: #selector(NewBookViewController.practiceWord), for: .touchUpInside)
                practiceWordBtn.addTarget(self, action: #selector(NewBookViewController.backBtnClicked(_:)), for: .touchUpInside)
                
                
                
            } else {
                
                
            }
            
            
            
        }
        
        return engWordsSelected.count
        
        //return 5
     
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellHight = tableView.frame.height / 2.5 / cellDif
        return cellHight
        
        
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let engWordSize = width / engWordSizeDif
        let chiWordSize = width / chiWordSizeDif
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath) as! BookTableViewCell
    
        let syllableLabel = cell.viewWithTag(1) as! UILabel
        let engWordLabel = cell.viewWithTag(2) as! UILabel
        let partOfSpeechLabel = cell.viewWithTag(3) as! UILabel
        let chiWordLabel = cell.viewWithTag(4) as! UILabel
        let engSenLabel = cell.viewWithTag(5) as! UILabel
        let chiSenLabel = cell.viewWithTag(6) as! UILabel

        cell.hintLabel.font = cell.hintLabel.font.withSize(chiWordSize)
        
        
        let accessoryImg = UIImageView()
        
        cell.accessoryType = .none
        cell.accessoryView = UIView(frame: CGRect(x: 0, y: 0, width: cell.frame.height, height: cell.frame.height))


        cell.accessoryView?.addSubview(accessoryImg)
        accessoryImg.translatesAutoresizingMaskIntoConstraints = false
        accessoryImg.centerYAnchor.constraint(equalTo: (cell.accessoryView?.centerYAnchor)!).isActive = true
        
        accessoryImg.trailingAnchor.constraint(equalTo: (cell.accessoryView?.trailingAnchor)!, constant: -5 * iPadDif).isActive = true
        accessoryImg.widthAnchor.constraint(equalToConstant: 19 * iPadDif ).isActive = true
        accessoryImg.heightAnchor.constraint(equalToConstant: 31 * iPadDif).isActive = true
        accessoryImg.image = UIImage(named: "indicatorPng.png")
        

        if indexPath.row == 0 {
            
            cell.hintLabel.isHidden = false
            
 
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse,.repeat], animations: {
                
                UIView.setAnimationRepeatCount(5)
                cell.hintLabel.alpha = 0
            })
            
            
        } else {
            
            cell.hintLabel.isHidden = true
        }
        
        
        /*
        cell.accessoryView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height:10))
        cell.accessoryView?.layer.cornerRadius = (cell.accessoryView?.frame.width)! / 2
        cell.accessoryView?.backgroundColor = .lightGray
        */
        
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
        
        //chiWordLabel.font = UIFont(name: "System Semibold", size: chiWordSize)
        chiWordLabel.font = chiWordLabel.font.withSize(chiWordSize)
        //engSenLabel.font = UIFont(name: "System Semibold", size: chiWordSize)
        engSenLabel.font = engSenLabel.font.withSize(chiWordSize)
        //chiSenLabel.font = UIFont(name: "System Semibold", size: chiWordSize)
        chiSenLabel.font = chiSenLabel.font.withSize(chiWordSize)
        
        //partOfSpeechLabel.font = UIFont(name: "Helvetica Neue Medium", size: chiWordSize)
        partOfSpeechLabel.font = partOfSpeechLabel.font.withSize(chiWordSize)
        
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
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    var tempMyFav = [String]()
    var tempFavWordsToDelete = [String]()
    var tempWrongWordsToDelete = [String]()
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        
        
        switch segControl.selectedSegmentIndex{
            
        case 0:
            
            
            let addToFavAction = UITableViewRowAction(style: .default, title: "加入最愛") { [weak self](action, indexPath) in
                
                //抓單字
                
                let wordToCheck = self!.engWordsSelected[indexPath.row]
                
                let wordToAdd = wordToCheck.replacingOccurrences(of: " ", with: "")
          
                
                //tempMyFav
                
                if !self!.tempMyFav.contains(wordToAdd){
                
                self!.tempMyFav.append(wordToAdd)
                
                }
         
                self!.addToFavAnimation(word: wordToAdd, state: 0)
                
                
                /*
                if self!.tempFavWordsToDelete.count > 0 {
                
                for i in 0 ..< self!.tempFavWordsToDelete.count {
                    
                    if self!.tempFavWordsToDelete[i] == wordToAdd {
                        
                        self!.tempFavWordsToDelete.remove(at: i)
                  
                    }
                    
                    }
               
                }
                 
            */
                
                
            }
         
            print("add:\(tempMyFav)")
            
            print("toDelete:\(tempFavWordsToDelete)")

            return [addToFavAction]

            
        case 1:
            
            
            let addToFavAction = UITableViewRowAction(style: .default, title: "加入最愛") {[weak self] (action, indexPath) in
                
                
                
                //抓單字
                
                let wordToCheck = self!.engWordsSelected[indexPath.row]
                
                let wordToAdd = wordToCheck.replacingOccurrences(of: " ", with: "")
                
                print(wordToAdd)
                
                //tempMyFav
                
                if !self!.tempMyFav.contains(wordToAdd){
                    
                    self!.tempMyFav.append(wordToAdd)
                    
                }
                
        
                           self!.addToFavAnimation(word: wordToAdd, state: 0)

                /*
                if self!.tempFavWordsToDelete.count > 0 {
                
                for i in 0 ..< self!.tempFavWordsToDelete.count {
                    
                    if self!.tempFavWordsToDelete[i] == wordToAdd {
                        
                        self!.tempFavWordsToDelete.remove(at: i)
                    }
                    
                }
                }
                */
                
                
            }

            
            let deleteAction = UITableViewRowAction(style: .normal, title: "移除單字", handler: {[weak self] (action, indexPath) in
                
                
                let wordToCheck = self!.engWordsSelected[indexPath.row]
                let wordToDelete = wordToCheck.replacingOccurrences(of: " ", with: "")
                
                //之後給後端儲存使用
                self!.tempWrongWordsToDelete.append(wordToDelete)
                
                
                //前段直接刪掉
                self!.engWordsSelected.remove(at: indexPath.row)
                self!.syllablesSelected.remove(at: indexPath.row)
                self!.chiWordsSelected.remove(at: indexPath.row)
                self!.partOfSpeechSelected.remove(at: indexPath.row)
                self!.engSenSelected.remove(at: indexPath.row)
                self!.chiSenSelected.remove(at: indexPath.row)
                
                
                self!.tableView.reloadData()
                

            })
            
             print("add:\(tempMyFav)")
             print("toDelete:\(tempFavWordsToDelete)")
             print("wrongToDelete:\(tempWrongWordsToDelete)")

       
            
            return [addToFavAction,deleteAction]

            
        case 2:
            
            let deleteAction = UITableViewRowAction(style: .normal, title: "移除最愛", handler: {[weak self] (action, indexPath) in
                
                
                let wordToCheck = self!.engWordsSelected[indexPath.row]
                let wordToDelete = wordToCheck.replacingOccurrences(of: " ", with: "")
                
                
                
                
                //之後給後端儲存使用
                if !self!.tempFavWordsToDelete.contains(wordToDelete) {
                self!.tempFavWordsToDelete.append(wordToDelete)
                
                }
                
                
                
                
            /*
                var indexToRemove = [Int]()
                for i in 0 ..< self!.tempMyFav.count{
                    
                    if self!.tempMyFav[i] == wordToDelete {
                        
                        indexToRemove.append(i)
                        
                    }

                }
                */
                
                
                for temp in self!.tempMyFav {
                    
                    
                    if temp == wordToDelete {
                                self?.tempMyFav = self!.tempMyFav.filter { $0 != temp }
                        
                    }
                    
                }

                
                //for前端顯示only
                self!.engWordsSelected.remove(at: indexPath.row)
                self!.syllablesSelected.remove(at: indexPath.row)

                self!.chiWordsSelected.remove(at: indexPath.row)
                self!.partOfSpeechSelected.remove(at: indexPath.row)
                self!.engSenSelected.remove(at: indexPath.row)
                self!.chiSenSelected.remove(at: indexPath.row)
 
                self!.tableView.reloadData()
                
            })

            
            
             print("toDelete:\(tempFavWordsToDelete)")
             print("toAdd:\(tempMyFav)")
            
            return [deleteAction]

        default:
            return []
        
            
        }


        
        
        
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //立即停止發音 & 停止上次動作
        
        alreadyPlayTimes = 0
        currentWordIndex = indexPath.row
        
        stopSpeech()
        
        synEngWord = engWordsSelected[indexPath.row].replacingOccurrences(of: " ", with: "")
        
    
        //抓發音錯誤字集
        for i in 0 ..< wrongPronounceWords.count{
            
            for (word,rightWord) in wrongPronounceWords[i]{
                
                //假如有抓到的話
                if word == synEngWord{
                    print("found wrong pronounce word")
                    synEngWord = rightWord[0]
                    
                }
                
            }
            
        }
        
        
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
    
    //避免閃紅燈
    
    @objc func turnOffRedLight(){
        

            print("turn off red light")
        
        for cell in tableView.visibleCells{
            
            cell.backgroundColor = .clear
        }
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
 
         
            /*
                for i in 0 ..< sortedSylArray.count{
                    
                    if sortedSylArray[i] == sylTextLabel.text! {
                        indexToChange = i
                    }
                }
 */
             //#新寫法
            
            indexToChange = sortedSylArray.firstIndex(of: sylTextLabel.text!)!
            
 
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
            
            if syllablesSelected.contains(sortedSylArray[collectionSelectedIndex!]) {
                
   
                           print("可以show")
                             collectionView.reloadData()
       
            } else {
                print("沒有單字可以show")
                addToFavAnimation(word: "", state: 1)
            }
        }
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: "SylCell", for: indexPath as IndexPath)
        
        
        let blueBall = cell.viewWithTag(2) as! UIImageView
        
        blueBall.frame.size = CGSize(width: collectionViewCellSize, height: collectionViewCellSize)
        
        
        let sylText = cell.viewWithTag(1) as!UILabel
        let sylToDisplay = sortedSylArray[indexPath.row]
        
        sylText.text = sylToDisplay
        sylText.textColor = btnOffColor
        sylText.font = sylText.font.withSize(sylFontSize)
        //sylText.backgroundColor = .green
        sylText.translatesAutoresizingMaskIntoConstraints = false
        sylText.widthAnchor.constraint(equalToConstant: collectionViewCellSize * 0.9).isActive = true
        sylText.heightAnchor.constraint(equalToConstant: collectionViewCellSize * 0.9).isActive = true
        sylText.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        sylText.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true

        
        
        
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
    
    
    
    
    
//var isAlertPoppedOut = false
    func jumpToRow(sylSelected:String){
        
    
        //找對應的row, 並跳過去
        //#新寫法
      
        if let indexToJump = syllablesSelected.firstIndex(of: sylSelected) {
        if indexToJump < tableView.numberOfRows(inSection: 0){
            
            if indexToJump == 0 {
                
                let indexPathRow = IndexPath(row: 0, section: 0)
                tableView.scrollToRow(at: indexPathRow, at: .top, animated: true)
               
            } else {
                
                //這裡可以加1的原因是因為3個字為一組
                var indexPathRow = IndexPath(row: indexToJump + 1, section: 0)
                
                
                if segControl.selectedSegmentIndex == 2 {
                    
                    indexPathRow = IndexPath(row: indexToJump, section: 0)
                }
                
                tableView.scrollToRow(at: indexPathRow, at: .bottom, animated: true)
                

                
            }
        }
        } else {
            
            print("沒有找到字")
        }
        
        
        /*
        
            for i in 0 ..< syllablesSelected.count{
            
                if isJump == false {
                
            //確認有字可以跳, 因爲有一些是正開放可以學習的單字但是不代表已經過了
                    
                  //  print("allsylSelected:\(syllablesSelected)")
                  //  print("sylSelected:\(sylSelected)")
                    
            if syllablesSelected[i] == sylSelected{
   
                if i < tableView.numberOfRows(inSection: 0){
                    
                    if i == 0 {
                        
                        let index = IndexPath(row: 0, section: 0)
                        
                        tableView.scrollToRow(at: index, at: .top, animated: true)
                        
                        isJump = true
                        
                    } else {
                        
                        //這裡可以加1的原因是因為3個字為一組
                        var index = IndexPath(row: i + 1, section: 0)

                        
                        if segControl.selectedSegmentIndex == 2 {
                            
                            index = IndexPath(row: i, section: 0)
                        }
                        
                        tableView.scrollToRow(at: index, at: .bottom, animated: true)
                        
                        isJump = true
                        
                        
                        
                    }
                    
                }
    
            } else {
                //沒有字
                print("還是沒有字")
    
                
                    }
                    
                }
        }
        */
    
        
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
        //engWord.voice = AVSpeechSynthesisVoice(language: "en-US")
        engWord.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Samantha-compact")

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
        //engSen.voice = AVSpeechSynthesisVoice(language: "en-US")
        engSen.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Samantha-compact")
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

    
    override func viewWillDisappear(_ animated: Bool) {
        
        //在此存檔後端
        
        print("book will disapear")
        
        //確認錯誤單字的刪除狀態
        
        if tempWrongWordsToDelete.count > 0 {
            
            
            
            for word in tempWrongWordsToDelete {
                
                
                wordsToDeleteInWrong.append(word)
                print("錯誤字刪除:\(word)")
                
                
                
            }
            
            
            
        }
        
        
        
        
        
        //確認我的最愛刪除狀況
        
        if tempFavWordsToDelete.count > 0 {
            
            
            for word in tempFavWordsToDelete {
                
                
                if myFavWords.contains(word) {
                    
                    //有包含的話
                    

                    //確認有沒有add
                    
                    
                    if !tempMyFav.contains(word){
                        
                        
                        //直接delete
                        
                        print("刪除字1:\(word)")
                        wordsToDeleteInFav.append(word)
                        
                        
                        for fav in tempMyFav {
                            
                            
                            if !myFavWords.contains(fav) {
                                
                                
                                
                                wordsToAddToFav.append(fav)
                                
                                tempMyFav = tempMyFav.filter { $0 != fav }

                                
                                print("新增字1:\(fav)")
                                
                            }
                            
                        }
                        
                        
                        
                        
                        
                    }


                    
                } else {
                    
                    
                    
                    //沒有包含的話
                    
                    
                    for fav in tempMyFav {
                        
                     
                            //直接add
                        
                            wordsToAddToFav.append(fav)
                        
                        tempMyFav = tempMyFav.filter { $0 != fav }
                            
                            print("新增字2:\(fav)")
                   
                        
                        
                    }

                    
                }
                

            }
            
            
            
        } else {
            
            if tempMyFav.count > 0 {
                
                
                //直接add
                
                

                for fav in tempMyFav {
                    
                    
                    if !myFavWords.contains(fav) {
                             wordsToAddToFav.append(fav)
                    
                    print("新增字3:\(fav)")
                    
                    }
                    
                }
         
                
            }
            
        }
       
        
        
        print(wordsToAddToFav)
        
        if wordsToAddToFav.count > 0 {
            
            addWord()
        }
        
        
        if wordsToDeleteInFav.count > 0 {
            
            removeWord()
        }
        
        if wordsToDeleteInWrong.count > 0 {
            
            removeWrongWord()
            
            
        }
    }
    
    
    
    
    //新增最愛單字
    func addWord(){
        

        for word in wordsToAddToFav {
        
            
            let id = user?["id"] as! String
            
            // url to access our php file
            let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/addWord.php")!
            
            // request url
            var request = URLRequest(url: url)
            
            // method to pass data POST - cause it is secured
            request.httpMethod = "POST"
            
            // body gonna be appended to url
            let body = "userID=\(id)&word=\(word)"
            
            // append body to our request that gonna be sent
            request.httpBody = body.data(using: .utf8)
            
            URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
                // no error
                if error == nil {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        guard let parseJSON = json else {
                            print("Error while parsing")
                            //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                            //self?.isParseEnabled = true
                            return
                        }
                        print("add word")
                        
                   
                        //再次儲存使用者資訊
                        UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                        
                        //載入我的最愛單字
                        /*
                        if let myWordsString = user!["myWords"] as! String?{
                            self!.myWords = myWordsString.components(separatedBy: ";")
                            
                        }
                        self?.isParseEnabled = true
                        */
                    } catch{
                       // self?.isParseEnabled = true
                        print("catch error")
                        
                        
                    }
                } else {
                 //   self?.isParseEnabled = true
                    print("urlsession has error")
                    
                }
            }).resume()
        }
            }
    
    
    
    func removeWord(){
        
        for word in wordsToDeleteInFav{
            let id = user?["id"] as! String
            
            // url to access our php file
            let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/removeWord.php")!
            
            // request url
            var request = URLRequest(url: url)
            
            // method to pass data POST - cause it is secured
            request.httpMethod = "POST"
            
            // body gonna be appended to url
            let body = "userID=\(id)&word=\(word)"
            
            // append body to our request that gonna be sent
            request.httpBody = body.data(using: .utf8)
            
            URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
                // no error
                if error == nil {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        guard let parseJSON = json else {
                            print("Error while parsing")
                          //  self?.isParseEnabled = true
                            //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                            return
                        }
                        
                        
                        
                        //再次儲存使用者資訊
                        UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                        print(user!)
                        /*
                        //載入我的最愛單字
                        if let myWordsString = user!["myWords"] as! String?{
                            self!.myWords = myWordsString.components(separatedBy: ";")
                            
                        }
                        
                        self?.isParseEnabled = true
                        */
                    } catch{
                        
                      //  self?.isParseEnabled = true
                        print("catch error")
                        
                    }
                } else {
               //     self?.isParseEnabled = true
                    print("urlsession has error")
                    
                }
            }).resume()
        }
    }
    
    func removeWrongWord(){
        
        for word in wordsToDeleteInWrong{
            let id = user?["id"] as! String
            
            // url to access our php file
            let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/removeWrongWord.php")!
            
            // request url
            var request = URLRequest(url: url)
            
            // method to pass data POST - cause it is secured
            request.httpMethod = "POST"
            
            // body gonna be appended to url
            let body = "userID=\(id)&word=\(word)"
            
            // append body to our request that gonna be sent
            request.httpBody = body.data(using: .utf8)
            
            URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
                // no error
                if error == nil {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        guard let parseJSON = json else {
                            print("Error while parsing")
                            //  self?.isParseEnabled = true
                            //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                            return
                        }
                        
                  
                        
                        
                        //再次儲存使用者資訊
                        UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                        print(user!)
                        /*
                         //載入我的最愛單字
                         if let myWordsString = user!["myWords"] as! String?{
                         self!.myWords = myWordsString.components(separatedBy: ";")
                         
                         }
                         
                         self?.isParseEnabled = true
                         */
                    } catch{
                        
                        //  self?.isParseEnabled = true
                        print("catch error")
                        
                    }
                } else {
                    //     self?.isParseEnabled = true
                    print("urlsession has error")
                    
                }
            }).resume()
        }
    }
    
    
    
    func selectUser(){
        
        
        // url to access our php file
        let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/selectUser.php")!
        
        let id = user?["id"] as! String
        
        // request url
        var request = URLRequest(url: url)
        
        // method to pass data POST - cause it is secured
        request.httpMethod = "POST"
        
        
        // body gonna be appended to url
        let body = "id=\(id)"
        
        // append body to our request that gonna be sent
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            // no error
            if error == nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    guard let parseJSON = json else {
                        print("Error while parsing")
                        
                        //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                        return
                    }
                    
                    
                    
                    print("selectUser:\(parseJSON)")
                    print("become active refresh user status")
                    UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                    user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                    
                    
                    //MARK: must update
                    
                    if let mapPassedString = user?["mapPassed"] as! String?{
                        
                        mapPassed = Int(mapPassedString)!
                        
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(mapPassed!, forKey: "mapPassed")
                        
                        print("retrieve mapPassed:\(mapPassed!)")
                        
                    }
                    
                    if let mapPassed2String = user?["mapPassed2"] as! String?{
                        
                        mapPassed2 = Int(mapPassed2String)!
                        
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(mapPassed2!, forKey: "mapPassed2")
                        
                        print("retrieve mapPassed:\(mapPassed2!)")
                        
                    }
                    
                    if let mapPassed3String = user?["mapPassed3"] as! String?{
                        
                        mapPassed3 = Int(mapPassed3String)!
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(mapPassed3!, forKey: "mapPassed3")
                        
                        print("retrieve mapPassed:\(mapPassed3!)")
                        
                    }
                    
                    if let mapPassed4String = user?["mapPassed4"] as! String?{
                        
                        mapPassed4 = Int(mapPassed4String)!
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(mapPassed4!, forKey: "mapPassed4")
                        
                        print("retrieve mapPassed:\(mapPassed4!)")
                        
                    }
                    
                    if let mapPassed5String = user?["mapPassed5"] as! String?{
                        
                        mapPassed5 = Int(mapPassed5String)!
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(mapPassed5!, forKey: "mapPassed5")
                        
                        print("retrieve mapPassed:\(mapPassed5!)")
                        
                    }
                    
                    
                    if let gamePassedString = user?["gamePassed"] as! String?{
                        
                        let gamePassedStringArray = gamePassedString.components(separatedBy: ":")
                        
                        let s = gamePassedStringArray[0]
                        let u = gamePassedStringArray[1]
                        gamePassed = [Int(s)!:Int(u)!]
                        
                        let userDefaults = UserDefaults.standard
                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed!)
                        
                        print("retrieve gamePassed:\(gamePassed!)")
                        userDefaults.set(encodedObject, forKey: "gamePassed")
                        
                    }
                    
                    if let gamePassed2String = user?["gamePassed2"] as! String?{
                        
                        let gamePassed2StringArray = gamePassed2String.components(separatedBy: ":")
                        
                        let s = gamePassed2StringArray[0]
                        let u = gamePassed2StringArray[1]
                        gamePassed2 = [Int(s)!:Int(u)!]
                        
                        let userDefaults = UserDefaults.standard
                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed2!)
                        
                        print("retrieve gamePassed:\(gamePassed2!)")
                        userDefaults.set(encodedObject, forKey: "gamePassed2")
                        
                    }
                    
                    if let gamePassed3String = user?["gamePassed3"] as! String?{
                        
                        let gamePassed3StringArray = gamePassed3String.components(separatedBy: ":")
                        
                        let s = gamePassed3StringArray[0]
                        let u = gamePassed3StringArray[1]
                        gamePassed3 = [Int(s)!:Int(u)!]
                        
                        let userDefaults = UserDefaults.standard
                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed3!)
                        
                        print("retrieve gamePassed:\(gamePassed3!)")
                        userDefaults.set(encodedObject, forKey: "gamePassed3")
                        
                    }
                    
                    
                    if let gamePassed4String = user?["gamePassed4"] as! String?{
                        
                        let gamePassed4StringArray = gamePassed4String.components(separatedBy: ":")
                        
                        let s = gamePassed4StringArray[0]
                        let u = gamePassed4StringArray[1]
                        gamePassed4 = [Int(s)!:Int(u)!]
                        
                        let userDefaults = UserDefaults.standard
                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed4!)
                        
                        print("retrieve gamePassed:\(gamePassed4!)")
                        userDefaults.set(encodedObject, forKey: "gamePassed4")
                        
                    }
                    
                    if let gamePassed5String = user?["gamePassed5"] as! String?{
                        
                        let gamePassed5StringArray = gamePassed5String.components(separatedBy: ":")
                        
                        let s = gamePassed5StringArray[0]
                        let u = gamePassed5StringArray[1]
                        gamePassed5 = [Int(s)!:Int(u)!]
                        
                        let userDefaults = UserDefaults.standard
                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed5!)
                        
                        print("retrieve gamePassed:\(gamePassed5!)")
                        userDefaults.set(encodedObject, forKey: "gamePassed5")
                        
                    }
                    
                    
                    
                    
                } catch{
                    
                    print("catch error")
                    
                }
            } else {
                
                print("urlsession has error")
                
            }
        }).resume()
        
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

