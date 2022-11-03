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
    
    let bookVC_correctWordTitle = NSLocalizedString("bookVC_correctWordTitle", comment: "")
    let bookVC_wrongWordTitle = NSLocalizedString("bookVC_wrongWordTitle", comment: "")
    let bookVC_favoriteWordTitle = NSLocalizedString("bookVC_favoriteWordTitle", comment: "")
    let bookVC_addToFav = NSLocalizedString("bookVC_addToFav", comment: "")
    let bookVC_deleteWord = NSLocalizedString("bookVC_deleteWord", comment: "")
    let bookVC_deleteFav = NSLocalizedString("bookVC_deleteFav", comment: "")
    let bookVC_alreadyAddedToFav = NSLocalizedString("bookVC_alreadyAddedToFav", comment: "")
    let bookVC_autoPlay = NSLocalizedString("bookVC_autoPlay", comment: "")
    let bookVC_playSentence = NSLocalizedString("bookVC_playSentence", comment: "")
    let bookVC_playTimes = NSLocalizedString("bookVC_playTimes", comment: "")
    let bookVC_playSpeed = NSLocalizedString("bookVC_playSpeed", comment: "")
    let bookVC_alertNoWords = NSLocalizedString("bookVC_alertNoWords", comment: "")
    let bookVC_iKnow = NSLocalizedString("bookVC_iKnow", comment: "")
    let bookVC_alertNoWrongWords = NSLocalizedString("bookVC_alertNoWrongWords", comment: "")
    let bookVC_alertNoFavWords = NSLocalizedString("bookVC_alertNoFavWords", comment: "")
    let bookVC_noWordsLearned = NSLocalizedString("bookVC_noWordsLearned", comment: "")
    
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
    var maxSpotNumArray:[Int]!
    var isSimVerSingleSyllable = false
    
    
    //MARK: simVer K12 課程紀錄變數
//    var k12MapPassed:[Int]!
//    var k12GamePassed:[[Int:Int]]!
    
    var k12WordSets = [[[String()]]]
    var k12SentenceSets = [[[String()]]]
    
    var wordContainer:[Word] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let file = File(chapter: 1, unit: 1)
//        let words = MissWordUtility.shared.loadWords(file: file)
//
//
        
        
        var sliderHeight: CGFloat!
        var btnDif: CGFloat!
        var btnTextFontSize: CGFloat!
        
        var alertXDif:CGFloat!
 
        //準備口試句子
        NotificationCenter.default.addObserver(self, selector: #selector(NewBookViewController.turnOffRedLight), name: NSNotification.Name("turnOffRedLight"), object: nil)
        
        switch height {
            
        case 1366, 1336:
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
            
        case 1024, 1194, 1112:
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
            
            break
            
        }
        

        
        //MARK: must update
        //在此就算user == nil, gamePasse & mapPasse也都設定好初始值了
        
        //MARK: simVer這裏最大值要動態 & 要append的音節檔案數量也不同 & 在此的maxSpotNum也加1了為了配合數字分類然後做成Array
        
        
        //單機test使用
        
//        mapPassed = 5
//        mapPassed2 = 6
//        mapPassed3 = 7
//        mapPassed4 = 9
//        mapPassed5 = 8
//
//        gamePassed = [0:0]
//        gamePassed2 = [0:0]
//        gamePassed3 = [0:0]
//        gamePassed4 = [0:0]
//        gamePassed5 = [0:0]
        
        //簡體版單機test
//                mapPassed = 3
//                mapPassed2 = 5
//                mapPassed3 = 6
//                mapPassed4 = 11
//                mapPassed5 = 13
//                k12MapPassed = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,]
//        mapPassed7 = 7
//        mapPassed8 = 9
//        mapPassed9 = 8
//        
//                gamePassed = [0:0]
//                gamePassed2 = [0:0]
//                gamePassed3 = [0:0]
//                gamePassed4 = [0:0]
//                gamePassed5 = [0:0]
//        k12GamePassed = [[0:0],[0:0],[0:0],[0:0],[0:0],[0:0],[0:0],[0:0],[0:0],[0:0],[0:0],[0:0],[0:0],[0:0],[0:0],[0:0],[0:0],[0:0]]
//        gamePassed7 = [0:0]
//        gamePassed8 = [0:0]
//        gamePassed9 = [0:0]
        

        switch courseReceived{
            
        case 0:
            isSimVerSingleSyllable = true
            
            if lan == "zh-Hans"{
                //檢體中文
                
                //print("檢體中文關卡數")
                
                syllableGroup.append(map36SyllableSets)
                syllableGroup.append(map37SyllableSets)
                syllableGroup.append(map38SyllableSets)
                
                increaseNum = 35
                maxMapNum = 3
                //maxSpotNum = 11
                
                maxSpotNumArray = [11,11,11]
                
                
            } else {
                //其餘語言
                //print("繁體中文關卡數")
                syllableGroup.append(map1SyllableSets)
                syllableGroup.append(map2SyllableSets)
                syllableGroup.append(map3SyllableSets)
                syllableGroup.append(map4SyllableSets)
                syllableGroup.append(map5SyllableSets)
                increaseNum = 0
                maxMapNum = 5
                //maxSpotNum = 15
                maxSpotNumArray = [15,15,15,15,15]
                
            }
            
            mapPassedInt = mapPassed
            gamePassedDic = gamePassed
            
            
            
        case 1:
            
            isSimVerSingleSyllable = false
            
            
            if lan == "zh-Hans"{
                
                
                syllableGroup.append(map39SyllableSets)
                syllableGroup.append(map40SyllableSets)
                syllableGroup.append(map41SyllableSets)
                syllableGroup.append(map42SyllableSets)
                syllableGroup.append(map43SyllableSets)
                
                maxMapNum = 5
                increaseNum = 38
                
                //maxSpotNum = 15
                maxSpotNumArray = [15,15,15,15,15]
                
            } else {
                
                syllableGroup.append(map6SyllableSets)
                syllableGroup.append(map7SyllableSets)
                syllableGroup.append(map8SyllableSets)
                syllableGroup.append(map9SyllableSets)
                syllableGroup.append(map10SyllableSets)
                syllableGroup.append(map11SyllableSets)
                
                increaseNum = 5
                maxMapNum = 6
                //maxSpotNum = 14
                
                maxSpotNumArray = [15,15,15,15,15,15]
            }
            
            
            mapPassedInt = mapPassed2
            gamePassedDic = gamePassed2
            
            
        case 2:
            
            isSimVerSingleSyllable = false
            
            if lan == "zh-Hans"{
                
                
                syllableGroup.append(map44SyllableSets)
                syllableGroup.append(map45SyllableSets)
                syllableGroup.append(map46SyllableSets)
                syllableGroup.append(map47SyllableSets)
                syllableGroup.append(map48SyllableSets)
                syllableGroup.append(map49SyllableSets)
                
                
                maxMapNum = 6
                increaseNum = 43
                //maxSpotNum = 15
                maxSpotNumArray = [15,15,15,15,15,15]
                
                
            } else {
                
                syllableGroup.append(map12SyllableSets)
                syllableGroup.append(map13SyllableSets)
                syllableGroup.append(map14SyllableSets)
                syllableGroup.append(map15SyllableSets)
                syllableGroup.append(map16SyllableSets)
                syllableGroup.append(map17SyllableSets)
                syllableGroup.append(map18SyllableSets)
                
                increaseNum = 11
                maxMapNum = 7
                //maxSpotNum = 14
                maxSpotNumArray = [15,15,15,15,15,15,15]
                
            }
            
            mapPassedInt = mapPassed3
            gamePassedDic = gamePassed3
            
            
            
        case 3:
            
            isSimVerSingleSyllable = false
            
            if lan == "zh-Hans"{
                
                syllableGroup.append(map50SyllableSets)
                syllableGroup.append(map51SyllableSets)
                syllableGroup.append(map52SyllableSets)
                syllableGroup.append(map53SyllableSets)
                syllableGroup.append(map54SyllableSets)
                syllableGroup.append(map55SyllableSets)
                syllableGroup.append(map56SyllableSets)
                syllableGroup.append(map57SyllableSets)
                syllableGroup.append(map58SyllableSets)
                syllableGroup.append(map59SyllableSets)
                syllableGroup.append(map60SyllableSets)
                
                maxMapNum = 11
                increaseNum = 49
                //maxSpotNum = 15
                maxSpotNumArray = [15,15,15,15,15,15,15,15,15,15,15]
                
            } else {
                
                
                syllableGroup.append(map19SyllableSets)
                syllableGroup.append(map20SyllableSets)
                syllableGroup.append(map21SyllableSets)
                syllableGroup.append(map22SyllableSets)
                syllableGroup.append(map23SyllableSets)
                syllableGroup.append(map24SyllableSets)
                syllableGroup.append(map25SyllableSets)
                syllableGroup.append(map26SyllableSets)
                syllableGroup.append(map27SyllableSets)
                
                
                increaseNum = 18
                maxMapNum = 9
                //maxSpotNum = 14
                
                maxSpotNumArray = [15,15,15,15,15,15,15,15,15]
                
            }
            
            mapPassedInt = mapPassed4
            gamePassedDic = gamePassed4
            
        case 4:
            
            isSimVerSingleSyllable = false
            
            if lan == "zh-Hans"{
                
                syllableGroup.append(map61SyllableSets)
                syllableGroup.append(map62SyllableSets)
                syllableGroup.append(map63SyllableSets)
                syllableGroup.append(map64SyllableSets)
                syllableGroup.append(map65SyllableSets)
                syllableGroup.append(map66SyllableSets)
                syllableGroup.append(map67SyllableSets)
                syllableGroup.append(map68SyllableSets)
                syllableGroup.append(map69SyllableSets)
                syllableGroup.append(map70SyllableSets)
                syllableGroup.append(map71SyllableSets)
                syllableGroup.append(map72SyllableSets)
                syllableGroup.append(map73SyllableSets)
                
                
                
                maxMapNum = 13
                increaseNum = 60
                //maxSpotNum = 15
                
                maxSpotNumArray = [15,15,15,15,15,15,15,15,15,15,15,15,15]
                
                
            } else {
                
                
                syllableGroup.append(map28SyllableSets)
                syllableGroup.append(map29SyllableSets)
                syllableGroup.append(map30SyllableSets)
                syllableGroup.append(map31SyllableSets)
                syllableGroup.append(map32SyllableSets)
                syllableGroup.append(map33SyllableSets)
                syllableGroup.append(map34SyllableSets)
                syllableGroup.append(map35SyllableSets)
                
                
                increaseNum = 27
                maxMapNum = 8
                //maxSpotNum = 14
                maxSpotNumArray = [15,15,15,15,15,15,15,15]
                
            }
            
            
            mapPassedInt = mapPassed5
            gamePassedDic = gamePassed5
            
            
        case 5:
            
            
            isSimVerSingleSyllable = true
            
            syllableGroup.append(map74SyllableSets)
            syllableGroup.append(map75SyllableSets)
            syllableGroup.append(map76SyllableSets)
            syllableGroup.append(map77SyllableSets)
            syllableGroup.append(map78SyllableSets)
            syllableGroup.append(map79SyllableSets)
            syllableGroup.append(map80SyllableSets)
            syllableGroup.append(map81SyllableSets)
            syllableGroup.append(map82SyllableSets)
            syllableGroup.append(map83SyllableSets)
            syllableGroup.append(map84SyllableSets)
            syllableGroup.append(map85SyllableSets)
            syllableGroup.append(map86SyllableSets)
            syllableGroup.append(map87SyllableSets)
            syllableGroup.append(map88SyllableSets)
            syllableGroup.append(map89SyllableSets)
            syllableGroup.append(map90SyllableSets)
            syllableGroup.append(map91SyllableSets)
            
            increaseNum = 73
            maxMapNum = 18
            // maxSpotNum = 10
            maxSpotNumArray = [4,11,11,10,11,11,11,11,13,13,11,11,7,11,11,6,13,13]
            
            
            //MARK: simVer K12改變作法
            k12WordSets = Array(repeating: [], count: 18)
            k12SentenceSets = Array(repeating: [], count: 18)
            
//            print("book check :\(k12WordSets)")
//            print("book check:\(k12MapPassed)")
//            print("book check:\(k12GamePassed)")
//            print("book check :\(k12SentenceSets)")
            
            //測試用
//            k12MapPassed = Array(repeating: 0, count: 18)
//            k12GamePassed = Array(repeating: [0:0], count: 18)
            
            
//            k12MapPassed[0] = 1
//
//            k12MapPassed[2] = 1
//            k12MapPassed[7] = 1
//
//            k12GamePassed[11] = [0:8]
//            k12GamePassed[6] = [0:1]
//            k12GamePassed[8] = [0:1]
//            k12GamePassed[10] = [0:1]
//            k12GamePassed[12] = [0:1]
//            k12GamePassed[13] = [0:1]
//            k12GamePassed[15] = [0:1]
            
            
            
        case 6:
            
            isSimVerSingleSyllable = false
            
            syllableGroup.append(map92SyllableSets)
            syllableGroup.append(map93SyllableSets)
            syllableGroup.append(map94SyllableSets)
            syllableGroup.append(map95SyllableSets)
            syllableGroup.append(map96SyllableSets)
            syllableGroup.append(map97SyllableSets)
            syllableGroup.append(map98SyllableSets)
            
            
            maxMapNum = 7
            increaseNum = 91
            // maxSpotNum = 10
            maxSpotNumArray = [15,15,15,15,15,15,15]
            
            mapPassedInt = mapPassed7
            gamePassedDic = gamePassed7
            
        case 7:
            
            isSimVerSingleSyllable = false
            
            syllableGroup.append(map99SyllableSets)
            syllableGroup.append(map100SyllableSets)
            syllableGroup.append(map101SyllableSets)
            syllableGroup.append(map102SyllableSets)
            syllableGroup.append(map103SyllableSets)
            syllableGroup.append(map104SyllableSets)
            syllableGroup.append(map105SyllableSets)
            syllableGroup.append(map106SyllableSets)
            syllableGroup.append(map107SyllableSets)
            
            
            maxMapNum = 9
            increaseNum = 98
            // maxSpotNum = 10
            maxSpotNumArray = [15,15,15,15,15,15,15,15,15]
            
            mapPassedInt = mapPassed8
            gamePassedDic = gamePassed8
            
        case 8:
            isSimVerSingleSyllable = false
            
            syllableGroup.append(map108SyllableSets)
            syllableGroup.append(map109SyllableSets)
            syllableGroup.append(map110SyllableSets)
            syllableGroup.append(map111SyllableSets)
            syllableGroup.append(map112SyllableSets)
            syllableGroup.append(map113SyllableSets)
            syllableGroup.append(map114SyllableSets)
            syllableGroup.append(map115SyllableSets)
            
            maxMapNum = 8
            increaseNum = 107
            // maxSpotNum = 10
            maxSpotNumArray = [15,15,15,15,15,15,15,15]
            
            mapPassedInt = mapPassed9
            gamePassedDic = gamePassed9
            
            
        default:
            break
            
        }
        
    
        
        
        
        //加入alertView
        let lightGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.58)
        ghostBtn.frame = CGRect(x: 0, y: 0, width: width, height: height)
        ghostBtn.backgroundColor = lightGray
        //ghostBtn.addTarget(self, action: #selector(NewBookViewController.removeBtns), for: .touchUpInside)
        self.view.addSubview(ghostBtn)
        
        alertBg.image = UIImage(named: "reviewQuitBg3.png")
        self.view.addSubview(alertBg)
        
        alertBg.translatesAutoresizingMaskIntoConstraints = false
        alertBg.widthAnchor.constraint(equalToConstant: 237 * dif * btnDif * alertXDif).isActive = true
        alertBg.heightAnchor.constraint(equalToConstant: 140 * dif * btnDif * alertXDif).isActive = true
        alertBg.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        alertBg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        ghost2Btn.frame = CGRect(x: (width - 237 * dif) / 2, y: height * 2 /  5, width: width * 237 / 375, height: height * 140 / 667)
        self.view.addSubview(ghost2Btn)
        

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
        

        //名稱有誤 其實只是alert的按鈕 要保留
        practiceWordBtn.titleLabel?.font = UIFont(name: "Helvetica Bold", size: sylFontSize)
        practiceWordBtn.setTitle(bookVC_iKnow, for: .normal)
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
        

        
        //設定好segMent
        segControl.frame = CGRect(x: backBtn.frame.maxX, y: backBtn.frame.minY,width: width - backBtn.frame.width * 4, height: sliderHeight )
        self.view.addSubview(segControl)
        
        
        collectionView.frame = CGRect(x: backBtn.frame.minX, y: segControl.frame.maxY + 5 * dif, width: width - (backBtn.frame.minX * 2), height: height / 3.2)
        //collectionView.backgroundColor = .red
        
        tableView.frame = CGRect(x: 0, y: collectionView.frame.maxY, width: width, height: height - collectionView.frame.maxY - 66 * dif * iPadDif)
        
        bookViewBottomBg.frame = CGRect(x: 0, y: tableView.frame.maxY, width: width, height: 66 * dif * iPadDif)
        
        playBtn.frame = CGRect(x: 0, y: tableView.frame.maxY, width: width / 4, height: 66 * dif * iPadDif)
        //playBtn.backgroundColor = .red
        

        autoPlayImg.translatesAutoresizingMaskIntoConstraints = false
        autoPlayImg.widthAnchor.constraint(equalToConstant: 23 * dif * btnDif).isActive = true
        autoPlayImg.heightAnchor.constraint(equalToConstant: 23 * dif * btnDif).isActive = true
        autoPlayImg.centerYAnchor.constraint(equalTo: bookViewBottomBg.centerYAnchor, constant: -autoPlayImg.frame.height / 2).isActive = true

        
        autoPlayImg.centerXAnchor.constraint(equalTo: playBtn.centerXAnchor).isActive = true
        
        
        autoPlayText.anchor(top: autoPlayImg.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: nil,padding: .init(top: 5 * iPadDif, left: 0, bottom: 0, right: 0), size: .init(width: width / 4, height: bookViewBottomBg.frame.height / 3))
        
        autoPlayText.font = autoPlayText.font.withSize(btnTextFontSize)
        autoPlayText.text = bookVC_autoPlay
        
        sentenceBtn.frame = CGRect(x: playBtn.frame.maxX, y: tableView.frame.maxY, width: width / 4, height: 66 * dif * iPadDif)
        
        
        //sentenceBtn.backgroundColor = .green
        
        
        playSenImg.translatesAutoresizingMaskIntoConstraints = false
        playSenImg.widthAnchor.constraint(equalToConstant: 27 * dif * btnDif).isActive = true
        playSenImg.heightAnchor.constraint(equalToConstant: 23 * dif * btnDif).isActive = true
        playSenImg.centerYAnchor.constraint(equalTo: bookViewBottomBg.centerYAnchor, constant: -playSenImg.frame.height / 2).isActive = true
        
        playSenImg.centerXAnchor.constraint(equalTo: sentenceBtn.centerXAnchor).isActive = true
        
        
        playSenText.anchor(top: autoPlayText.topAnchor, leading: playBtn.trailingAnchor, bottom: nil, trailing: nil, size: .init(width: width / 4, height: bookViewBottomBg.frame.height / 3))
        
        playSenText.font = playSenText.font.withSize(btnTextFontSize)
        playSenText.text = bookVC_playSentence
        
        playTimesBtn.frame = CGRect(x: sentenceBtn.frame.maxX, y: tableView.frame.maxY, width: width / 4, height: 66 * dif * iPadDif)
        
        
        //playTimesBtn.backgroundColor = .yellow
        
        playTimesImg.translatesAutoresizingMaskIntoConstraints = false
        playTimesImg.widthAnchor.constraint(equalToConstant: 46 * dif * btnDif).isActive = true
        playTimesImg.heightAnchor.constraint(equalToConstant: 8 * dif * btnDif).isActive = true
        playTimesImg.centerYAnchor.constraint(equalTo: bookViewBottomBg.centerYAnchor, constant: -playTimesImg.frame.height / 2).isActive = true
        
        playTimesImg.centerXAnchor.constraint(equalTo: playTimesBtn.centerXAnchor).isActive = true
        
        
        playTimesText.anchor(top: playSenText.topAnchor, leading: sentenceBtn.trailingAnchor, bottom: nil, trailing: nil, size: .init(width: width / 4, height: bookViewBottomBg.frame.height / 3))
        
        playTimesText.font = playTimesText.font.withSize(btnTextFontSize)
        playTimesText.text = bookVC_playTimes
        
        playSpeedBtn.frame = CGRect(x: playTimesBtn.frame.maxX, y: tableView.frame.maxY, width: width / 4, height: 66 * dif * iPadDif)
        
        //playSpeedBtn.backgroundColor = .purple
        
        playSpeedImg.translatesAutoresizingMaskIntoConstraints = false
        playSpeedImg.widthAnchor.constraint(equalToConstant: 40 * dif * btnDif).isActive = true
        playSpeedImg.heightAnchor.constraint(equalToConstant: 26 * dif * btnDif).isActive = true
        playSpeedImg.centerYAnchor.constraint(equalTo: bookViewBottomBg.centerYAnchor, constant: -playSpeedImg.frame.height / 2).isActive = true
        
        playSpeedImg.centerXAnchor.constraint(equalTo: playSpeedBtn.centerXAnchor).isActive = true
        

        playSpeedText.anchor(top: playTimesText.topAnchor, leading: playTimesBtn.trailingAnchor, bottom: nil, trailing: nil, size: .init(width: width / 4, height: bookViewBottomBg.frame.height / 3))
        
        playSpeedText.font = playSpeedText.font.withSize(btnTextFontSize)
        playSpeedText.text = bookVC_playSpeed
        
        
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
        
        let titles = [bookVC_correctWordTitle, bookVC_wrongWordTitle, bookVC_favoriteWordTitle]
        
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
        self.view.bringSubviewToFront(favAddedLabel)
        

        // *** 處理文字 ***
        
        //歸類所有syllable
        syllableGroup.removeFirst()
        
        for groupSet in syllableGroup {
            
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

            //全部的syl放這裡
            sylArray.append(sylOnlyText)
            if !sortedSylArray.contains(sylOnlyText){
                //排除掉相同的syl之後放這裡
                sortedSylArray.append(sylOnlyText)
            }
        }
        
        //建立collectionView按鈕數量
        for _ in 0 ..< sortedSylArray.count{
            collectionTouched.append(0)
        }
        
        //預設第一個元素
        collectionTouched[0] = 1
        // *** 讀取單字 ***
        //MARK: simVer K12特別作法
        if courseReceived == 5  {

            //篩選有字的再讀, 沒有字的就保持空值
            
            for i in 0 ..< k12MapPassed.count {
                
                for (spot, unit) in k12GamePassed[i] {
               
                    if spot != 0 || unit != 0  || k12MapPassed[i] == 1{
                   
                        //有字
                        
                        //讀全部值
                        for s in 0 ..< maxSpotNumArray[i]{
                            
                            var wordFile:String?
                            //前面的1代表第一張地圖
                            let name = String(i + increaseNum + 1) + "-" + String(s + 1)
                            let sName = "s\(String(i + increaseNum + 1))-" + String(s + 1)

                            //抓字
                            if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
                                do {
                                    wordFile = try String(contentsOfFile: filepath)
                                    let words = wordFile?.components(separatedBy: "; ")
                                    
                                    //把字讀取到wordSets裡
                                    k12WordSets[i].append(words!)
                                    
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
                                    k12SentenceSets[i].append(words!)
                                    
                                } catch {
                                    // contents could not be loaded
                                }
                            } else {
                                // example.txt not found!
                            }
                            
                        }
                    }
                    
                }
            
                
            }
            
        }  else {
            
            //非K12其他課程的讀取單字方式
            //所有已過關的地圖字都要抓進去, ...這部分是繁體可以?
            if mapPassedInt == maxMapNum {
                
                //在這裡 -1 後面要加回來
                //Mark: simVer 這裏maxSpotNum要減１,陪配合上方的數字分類
                mapPassedInt! -= 1
                
                // gamePassedDic = [maxSpotNum - 1:9]
                gamePassedDic = [maxSpotNumArray[maxSpotNumArray.count - 1] - 1:9]
                
            }
            
            for m in 0 ..< mapPassedInt!{
                //要讀取裡面的全部
                
                //MARK: simVer這裏要全部改成讀array裡的值
                //for i in 0 ..< maxSpotNum{
                //目前每個地圖的最大spot已經放在array之內
                
                for i in 0 ..< maxSpotNumArray[m]{
                    
                    let file = File(chapter: m + increaseNum + 1, unit: i + 1)
                    let words = MissWordUtility.shared.loadWords(file: file)
                    wordContainer.append(contentsOf: words)
//                    var wordFile:String?
//                    //前面的1代表第一張地圖
//                    let name = String(m + increaseNum + 1) + "-" + String(i + 1)
//                    let sName = "s\(String(m + increaseNum + 1))-" + String(i + 1)
//
//                    //抓字
//                    if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
//                        do {
//                            wordFile = try String(contentsOfFile: filepath)
//                            let words = wordFile?.components(separatedBy: "; ")
//
//                            //把字讀取到wordSets裡
//                            wordSets.append(words!)
//
//                            //print(contents)
//
//                        } catch {
//                            // contents could not be loaded
//                        }
//                    } else {
//                        // example.txt not found!
//                    }
//
//                    var sentenceFile:String?
//
//                    //抓句子
//                    if let filepath = Bundle.main.path(forResource: sName, ofType: "txt") {
//                        do {
//                            sentenceFile = try String(contentsOfFile: filepath)
//                            let words = sentenceFile?.components(separatedBy: "; ")
//
//                            //把字讀取到wordSets裡
//                            sentenceSets.append(words!)
//                            //print(contents)
//
//                        } catch {
//                            // contents could not be loaded
//                        }
//                    } else {
//                        // example.txt not found!
//                    }
//
                }
                
            }

            
            //接著抓目前最新開放地圖裡的完成字 + 殘字
            for (s,_) in gamePassedDic!{
                
                //讀取已完整的所有字集 + 句子
                for i in 0 ..< (s){
                    
                    let file = File(chapter: mapPassedInt! + increaseNum + 1, unit: i + 1)
                    let words = MissWordUtility.shared.loadWords(file: file)
                    wordContainer.append(contentsOf: words)
//                    var wordFile:String?
//                    //前面的1代表第一張地圖
//
//                    //裡面的檔名也要加上increaseNum
//                    let name = String(describing: mapPassedInt! + increaseNum + 1) + "-" + String(i + 1)
//                    let sName = "s\(String(describing: mapPassedInt! + increaseNum + 1))-" + String(i + 1)
//
//                    //抓字
//                    if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
//                        do {
//                            wordFile = try String(contentsOfFile: filepath)
//                            let words = wordFile?.components(separatedBy: "; ")
//
//                            //把字讀取到wordSets裡
//                            wordSets.append(words!)
//                            //print(contents)
//
//                        } catch {
//                            // contents could not be loaded
//                        }
//
//                    } else {
//                        // example.txt not found!
//                    }
//
//                    var sentenceFile:String?
//
//                    //抓句子
//                    if let filepath = Bundle.main.path(forResource: sName, ofType: "txt") {
//                        do {
//                            sentenceFile = try String(contentsOfFile: filepath)
//                            let words = sentenceFile?.components(separatedBy: "; ")
//
//                            //把字讀取到wordSets裡
//                            sentenceSets.append(words!)
//                            //print(contents)
//
//                        } catch {
//                            // contents could not be loaded
//                        }
//                    } else {
//                        // example.txt not found!
//                    }
                    
                }
                
                let file = File(chapter: mapPassedInt! + increaseNum + 1, unit: s + 1)
                let words = MissWordUtility.shared.loadWords(file: file)
                wordContainer.append(contentsOf: words)
                
//                //再來讀取殘餘的英文字 + 句子
//                var wordFile:String?
//
//                //讀取最新一層的字
//
//                //檔名要加上increaseNum
//                let name = String(describing: mapPassedInt! + increaseNum + 1) + "-" + String(s + 1)
//                let sName = "s\(String(describing: mapPassedInt! + increaseNum + 1))-" +  String(s + 1)
//
//                if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
//                    do {
//                        wordFile = try String(contentsOfFile: filepath)
//                        let words = wordFile?.components(separatedBy: "; ")
//
//                        //把字讀取到wordSets裡
//                        tempWordSets.append(words!)
//                        //print(contents)
//
//
//                    } catch {
//                        // contents could not be loaded
//                    }
//                } else {
//                    // example.txt not found!
//                }
//
//
//
//                var sentenceFile:String?
//
//                //抓句子
//                if let filepath = Bundle.main.path(forResource: sName, ofType: "txt") {
//                    do {
//                        sentenceFile = try String(contentsOfFile: filepath)
//                        let words = sentenceFile?.components(separatedBy: "; ")
//
//                        //把字讀取到wordSets裡
//                        tempSentenceSets.append(words!)
//                        //print(contents)
//
//                    } catch {
//                        // contents could not be loaded
//                    }
//                } else {
//                    // example.txt not found!
//                }
                
            }
            
        }
        
        
        //  *** 把讀取的單字抓出來 ***
        //MARK: simVer 在此先測試同一個地方抓全部及殘值
        
        //K12抓單字 + 抓音節
       
        if courseReceived == 5 {
            //PART 1. 在此先loop through全部mapPassed
            for m in 0 ..< k12MapPassed.count {
                if k12MapPassed[m] == 1 {
                    //抓全部
                    for j in 0 ..< k12WordSets[m].count {
                        for w in 0 ..< 30{
                            engWordsToShow.append(k12WordSets[m][j][w])
                            engSenToShow.append(k12SentenceSets[m][j][w])
                        }
                        for c in 30 ..< 60{
                            chiWordsToShow.append(k12WordSets[m][j][c])
                            chiSenToShow.append(k12SentenceSets[m][j][c])
                        }
                        for p in 60 ..< 90{
                            partOfSpeechToShow.append(k12WordSets[m][j][p])
                        }
                    }
                } else {
                    //抓殘值
                    for (s,u) in k12GamePassed[m] {
                        if s != 0 || u != 0 {
                            //先抓s的全部值
                            for j in 0 ..< s {
                                for w in 0 ..< 30 {
                                    engWordsToShow.append(k12WordSets[m][j][w])
                                    engSenToShow.append(k12SentenceSets[m][j][w])
                                }
                                for c in 30 ..< 60{
                                    chiWordsToShow.append(k12WordSets[m][j][c])
                                    chiSenToShow.append(k12SentenceSets[m][j][c])
                                }
                                for p in 60 ..< 90{
                                    partOfSpeechToShow.append(k12WordSets[m][j][p])
                                }
                            }
                            //最後抓u剩餘的殘值
                            for w in 0 ..< u * 3{
                                engWordsToShow.append(k12WordSets[m][s][w])
                                engSenToShow.append(k12SentenceSets[m][s][w])
                            }
                            for w in 30 ..< (30 + u * 3){
                                chiWordsToShow.append(k12WordSets[m][s][w])
                                chiSenToShow.append(k12SentenceSets[m][s][w])
                            }
                            for w in 60 ..< (60 + u * 3){
                                partOfSpeechToShow.append(k12WordSets[m][s][w])
                            }
                        }
                    }
                }
            }
            
            // *** k12 抓全部音節的方式在下 ***
            var addedSequence = Int()
            for i in 0 ..< k12GamePassed.count {
                if i != 0{
                    for s in 1 ..< i + 1 {
                        addedSequence += maxSpotNumArray[s - 1] * 30
                    }
                }
                
                if k12MapPassed[i] == 1 {
                    for _ in 0 ..< maxSpotNumArray[i]{
                        for _ in 0 ..< 30{
                            syllablesToShow.append(sylArray[addedSequence])
                            addedSequence += 1
                        }
                    }
                    //addedSequence歸零
                    addedSequence = 0
                    //在這裡一種抓字法
                } else {
                    for (s,g) in k12GamePassed[i]{
                        for _ in 0 ..< s {
                            for _ in 0 ..< 30 {
                                syllablesToShow.append(sylArray[addedSequence])
                                addedSequence += 1
                            }
                        }
                        for _ in 0 ..< g * 3{
                            syllablesToShow.append(sylArray[addedSequence])
                            addedSequence += 1
                        }
                    }
                    
                    //addedSequence歸零
                    addedSequence = 0
                    //在這裡另一種抓字法
                }
            }
            
        } else {
            
            // *** 其他課程抓單字 + 音節 ***
            //TODO: refact wordSets
            for word in wordContainer {
                engWordsToShow.append(word.english)
                engSenToShow.append(word.englishSentence)
                chiWordsToShow.append(word.chinese)
                chiSenToShow.append(word.chineseSentence)
                partOfSpeechToShow.append(word.partOfSpeech)
                syllablesToShow.append(word.syllables)
            }
//            for i in 0 ..< wordSets.count{
//
//                for w in 0 ..< 30{
//
//                    engWordsToShow.append(wordSets[i][w])
//                    engSenToShow.append(sentenceSets[i][w])
//
//                    //抓出正確的順序
//                    //MARK: simVer 這裡的syllables 要更改
//
//                    var syllableSequence = Int()
//
//                    if lan == "zh-Hans" && isSimVerSingleSyllable{
//                        //檢體中文
//
//                        syllableSequence = Int(i * 30) +  Int(w)
//
//                    } else {
//                        //其餘語言
//                        //print("繁體中文關卡數")
//                        syllableSequence = Int(i * 10) +  Int(w / 3)
//
//                    }
//
//                    //排除掉K12, 到後方抓殘字時再處理, 這裡先保留著之後再check
//
//                    syllablesToShow.append(sylArray[syllableSequence])
//
//                }
//
//                for c in 30 ..< 60{
//
//                    chiWordsToShow.append(wordSets[i][c])
//                    chiSenToShow.append(sentenceSets[i][c])
//                }
//
//                for p in 60 ..< 90{
//
//                    partOfSpeechToShow.append(wordSets[i][p])
//                }
//
//            }

            //Part 2. 抓殘值 ＆ 抓可能出現錯字的最新三個

            //MARK: simVer 這裡應該不用除3
            //* * * 抓已append完的音節數量, 之後殘值以此數量append

            var sequence = Int()

            if lan == "zh-Hans" && isSimVerSingleSyllable{

                sequence = syllablesToShow.count

            } else {
                sequence = Int(syllablesToShow.count / 3)

            }


//            for (_,g) in gamePassedDic!{
//
//
//                for w in 0 ..< ((g + 1) * 3){
//
//                    engWordsToShow.append(tempWordSets[0][w])
//
//                    //MARK: simVer 應該不用除以3
//
//                    var syllableSequence = Int()
//
//                    if lan == "zh-Hans" && isSimVerSingleSyllable{
//                        //檢體中文
//
//                        //print("檢體中文關卡數")
//                        syllableSequence = sequence + w
//
//                    } else {
//                        //其餘語言
//                        //print("繁體中文關卡數")
//                        syllableSequence = sequence + Int(w / 3)
//
//                    }
//
//                    syllablesToShow.append(sylArray[syllableSequence]) //[s]
//
//                    engSenToShow.append(tempSentenceSets[0][w])
//
//                }
//
//                for w in 30 ..< (30 + (g + 1) * 3){
//
//
//                    chiWordsToShow.append(tempWordSets[0][w])
//
//                    chiSenToShow.append(tempSentenceSets[0][w])
//
//                }
//
//                for w in 60 ..< (60 + (g + 1) * 3){
//
//                    partOfSpeechToShow.append(tempWordSets[0][w])
//                }
//
//            }

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
        
        //在這如果沒有全破關者要先移除掉三個字
        //移除三個多增加的數量, 這三個是可能會錯的部分?? 為什麼只移除engWordsSelected..應該是因為這樣return cell就直接少三個
        
        //MARK: simVER 這裡有bug要再重新分組前就先移除 done
        //MARK: simVer 避免K12特別作法
        
        if courseReceived != 5 {
            
            if (mapPassedInt! + 1) != maxMapNum{
                
                for  _ in 0 ..< 3 {
                    
                    //engWordsSelected.removeLast()
                    engWordsToShow.removeLast()
                }
                
            }
            
        }
        
      
        //print("sortedsyl Array :\(sortedSylArray)")
        //print("syll array :\(sylArray)")
        //兩個音節做比對, 抓新字的順序
        for s in 0 ..< sortedSylArray.count{
            
            for i in 0 ..< sylArray.count{
                
                
                if sortedSylArray[s] == sylArray[i]{
                   // print("same syl :\(sortedSylArray[s])")
                    //MARK: simVer 這裏不抓三個字... 原始寫法保留在下方
                    
                    if lan == "zh-Hans" && isSimVerSingleSyllable{
                        //檢體中文
    
                        if engWordsToShow.count > i {
                            sortedEngWordsToShow.append(engWordsToShow[i])
                            sortedChiWordsToShow.append(chiWordsToShow[i])
                            sortedPartOfSpeechToShow.append(partOfSpeechToShow[i])
                            sortedSyllablesToShow.append(syllablesToShow[i])
                            sortedEngSenToShow.append(engSenToShow[i])
                            sortedChiSenToShow.append(chiSenToShow[i])

                        }
                        
                    } else {
                        //其餘語言

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
            
        }
        


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
        
        //預設collectionView的syl
        collectionSelectedIndex = 0
        
        //拉到最前方
        

        //swift 4.1
        self.view.bringSubviewToFront(ghostBtn)
        self.view.bringSubviewToFront(alertBg)
        self.view.bringSubviewToFront(ghost2Btn)
        self.view.bringSubviewToFront(practiceWordBtn)
        self.view.bringSubviewToFront(practiceSenBtn)
        self.view.bringSubviewToFront(leftBtnClickedImg)
        self.view.bringSubviewToFront(rightBtnClickedImg)
        
        removeBtns()
        
        
        //預設值
        alertTextShown = bookVC_alertNoWords
        
        
        //沒有值的話 無線條
        tableView.tableFooterView = UIView()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {

        //沒有網路的測試要comment掉
        
//        if user != nil {
//            selectUser()
//        }

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
            favAddedLabel.text = "\(word)\n\(bookVC_alreadyAddedToFav)"
        case 1:
            
            favAddedLabel.text = bookVC_noWordsLearned
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
        
        
        alertTextShown = bookVC_alertNoFavWords
        
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
        //print("sortedEngWord:\(sortedEngWordsToShow)")
        
        //MARK: simVer 應該不需要再扣三個 因為最初已經扣三個了
        //        //假如沒有全破關的話全部可顯示字要扣掉三個
        //        var tempCount = sortedEngSenToShow.count
        //
        //        if (mapPassedInt! + 1) != maxMapNum{
        //
        //            tempCount -= 3
        //        }
        //
        
        //以所有的單字來match我的最愛單字的資訊
        for i in 0 ..< sortedEngWordsToShow.count{
            
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
                
                //如果已經有的話 又不曾刪除掉的話, 就沒有必要存在, 因為myFavWord裡已經有了
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
        
        alertTextShown = bookVC_alertNoWrongWords
        
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
        
        //print(myWrongWords.count)
        
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
            }
            
        }

    }
    
    @IBAction func practiceBtnClicked(_ sender: Any) {
 
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
        
        return wordContainer.count
        
        
        if engWordsSelected.count == 0 {

            
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
            }
        }
        
        print("how many words loaded:\(engWordsSelected.count)")
        return engWordsSelected.count

        
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
        
        let word = wordContainer[indexPath.row]
        engWordLabel.text = word.english
        chiWordLabel.text = word.chinese
        partOfSpeechLabel.text = word.partOfSpeech
        engSenLabel.text = word.englishSentence
        chiSenLabel.text = word.chineseSentence
        
        
        return cell
        
        
//        let accessoryImg = UIImageView()
//        
//        cell.accessoryType = .none
//        cell.accessoryView = UIView(frame: CGRect(x: 0, y: 0, width: cell.frame.height, height: cell.frame.height))
//        
//        
//        cell.accessoryView?.addSubview(accessoryImg)
//        accessoryImg.translatesAutoresizingMaskIntoConstraints = false
//        accessoryImg.centerYAnchor.constraint(equalTo: (cell.accessoryView?.centerYAnchor)!).isActive = true
//        
//        accessoryImg.trailingAnchor.constraint(equalTo: (cell.accessoryView?.trailingAnchor)!, constant: -5 * iPadDif).isActive = true
//        accessoryImg.widthAnchor.constraint(equalToConstant: 19 * iPadDif ).isActive = true
//        accessoryImg.heightAnchor.constraint(equalToConstant: 31 * iPadDif).isActive = true
//        accessoryImg.image = UIImage(named: "indicatorPng.png")
        
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
        let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: engWordSize), NSAttributedString.Key.foregroundColor : UIColor.cyan]
        let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: engWordSize), NSAttributedString.Key.foregroundColor : UIColor.white]
        
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
            
            
            let addToFavAction = UITableViewRowAction(style: .default, title: bookVC_addToFav) { [weak self](action, indexPath) in
                
                //抓單字
                
                let wordToCheck = self!.engWordsSelected[indexPath.row]
                
                let wordToAdd = wordToCheck.replacingOccurrences(of: " ", with: "")
                
                
                //tempMyFav
                
                if !self!.tempMyFav.contains(wordToAdd){
                    
                    self!.tempMyFav.append(wordToAdd)
                    
                }
                
                self!.addToFavAnimation(word: wordToAdd, state: 0)
                
                
                
            }

            
            return [addToFavAction]
            
            
        case 1:
            
            
            let addToFavAction = UITableViewRowAction(style: .default, title: bookVC_addToFav) {[weak self] (action, indexPath) in
                
                
                //抓單字
                
                let wordToCheck = self!.engWordsSelected[indexPath.row]
                
                let wordToAdd = wordToCheck.replacingOccurrences(of: " ", with: "")
                
                print(wordToAdd)
                
                //tempMyFav
                
                if !self!.tempMyFav.contains(wordToAdd){
                    
                    self!.tempMyFav.append(wordToAdd)
                    
                }
                
                
                self!.addToFavAnimation(word: wordToAdd, state: 0)
                

                
                
            }
            
            
            let deleteAction = UITableViewRowAction(style: .normal, title: bookVC_deleteWord, handler: {[weak self] (action, indexPath) in
                
                
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
            
            return [addToFavAction,deleteAction]
            
            
        case 2:
            
            let deleteAction = UITableViewRowAction(style: .normal, title: bookVC_deleteFav, handler: {[weak self] (action, indexPath) in
                
                
                let wordToCheck = self!.engWordsSelected[indexPath.row]
                let wordToDelete = wordToCheck.replacingOccurrences(of: " ", with: "")
                
                
                
                
                //之後給後端儲存使用
                if !self!.tempFavWordsToDelete.contains(wordToDelete) {
                    self!.tempFavWordsToDelete.append(wordToDelete)
                    
                }

                
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
        
        //print("end scrolling")
        
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
                
                

                //#新寫法
                
                indexToChange = sortedSylArray.index(of: sylTextLabel.text!)!
             
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
        return 0
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

                collectionView.reloadData()
                
            } else {
      
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
        
        return cell
        
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
        
        
        
        if let indexToJump = syllablesSelected.index(of: sylSelected) {
            
            //  if let indexToJump = syllablesSelected.firstIndex(of: sylSelected) {
            if indexToJump < tableView.numberOfRows(inSection: 0){
                
                if indexToJump == 0 {
                    
                    let indexPathRow = IndexPath(row: 0, section: 0)
                    tableView.scrollToRow(at: indexPathRow, at: .top, animated: true)
                    
                } else {
                    
                    //這裡可以加1的原因是因為3個字為一組
                    //MARK: simVer 這裡可能要避開三個字一組...試試看
                    
                    
                    var indexPathRow = IndexPath()
                    
                    if lan == "zh-Hans" && isSimVerSingleSyllable{
                        //檢體中文
                        
                        //之後還要用courseReceived來改數值, 因為每個course值不同
                        indexPathRow = IndexPath(row: indexToJump, section: 0)
                        
                        
                    } else {
                        //其餘語言
            
                        indexPathRow = IndexPath(row: indexToJump + 1, section: 0)
                        
                    }
                    
                    
                    if segControl.selectedSegmentIndex == 2 {
                        
                        indexPathRow = IndexPath(row: indexToJump, section: 0)
                    }
                    
                    tableView.scrollToRow(at: indexPathRow, at: .bottom, animated: true)
                    
                    
                }
            }
        } else {
            
            print("沒有找到字")
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
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default, options: .defaultToSpeaker)
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
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
        //print("already:\(alreadyPlayTimes)")
        
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

        let chiSen = AVSpeechUtterance(string:synChiSen)
        chiSen.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        chiSen.rate = 0.48
        synth.speak(chiSen)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        //在此存檔後端

        //確認錯誤單字的刪除狀態
        
        if tempWrongWordsToDelete.count > 0 {
            
            
            
            for word in tempWrongWordsToDelete {
                
                wordsToDeleteInWrong.append(word)
                
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
                        wordsToDeleteInFav.append(word)
                        
                        
                        for fav in tempMyFav {
                            
                            
                            if !myFavWords.contains(fav) {
                                
                                
                                wordsToAddToFav.append(fav)
                                
                                tempMyFav = tempMyFav.filter { $0 != fav }

                                
                            }
                            
                        }
         
                    }
                    
                    
                    
                } else {
                    
                    
                    
                    //沒有包含的話
                    
                    
                    for fav in tempMyFav {
                        
                        
                        //直接add
                        
                        wordsToAddToFav.append(fav)
                        
                        tempMyFav = tempMyFav.filter { $0 != fav }

                        
                    }
                    
                    
                }
                
                
            }
            
            
            
        } else {
            
            if tempMyFav.count > 0 {
                
                
                //直接add
                
                
                
                for fav in tempMyFav {
                    
                    
                    if !myFavWords.contains(fav) {
                        wordsToAddToFav.append(fav)

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
            
            let copyUser = user?.mutableCopy() as! NSMutableDictionary
            let favWords = user?.object(forKey: kMyWords) as! String
            let newFavWords = favWords + word + ";"

            copyUser.setValue(newFavWords, forKey: kMyWords)
            user = copyUser
            userDefaults.set(user, forKey: "parseJSON")
            
        }
        
        
        
        
//        for word in wordsToAddToFav {
//
//
//            let id = user?["id"] as! String
//
//            // url to access our php file
//
//            var url:URL
//            if lan == "zh-Hans" {
//                url = URL(string: "http://ec2-52-198-62-78.ap-northeast-1.compute.amazonaws.com/misswordChina/addWord.php")!
//            } else {
//                url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/addWord.php")!
//            }
//
//            // request url
//            var request = URLRequest(url: url)
//
//            // method to pass data POST - cause it is secured
//            request.httpMethod = "POST"
//
//            // body gonna be appended to url
//            let body = "userID=\(id)&word=\(word)"
//
//            // append body to our request that gonna be sent
//            request.httpBody = body.data(using: .utf8)
//
//            URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
//                // no error
//                if error == nil {
//
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
//
//                        guard let parseJSON = json else {
//                            print("Error while parsing")
//                            //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
//                            //self?.isParseEnabled = true
//                            return
//                        }
//
//
//                        //再次儲存使用者資訊
//                        UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
//                        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
//
//                        //載入我的最愛單字
//                        /*
//                         if let myWordsString = user!["myWords"] as! String?{
//                         self!.myWords = myWordsString.components(separatedBy: ";")
//
//                         }
//                         self?.isParseEnabled = true
//                         */
//                    } catch{
//                        // self?.isParseEnabled = true
//                        print("catch error")
//
//
//                    }
//                } else {
//                    //   self?.isParseEnabled = true
//                    print("urlsession has error")
//
//                }
//            }).resume()
//        }
    }
    
    
    func removeWrongWord(){
  
        for word in wordsToDeleteInWrong {
            
            let copyUser = user?.mutableCopy() as! NSMutableDictionary
            var wrongWords = user?.object(forKey: kWrongWords) as! String
            
            wrongWords = wrongWords.replacingOccurrences(of: word + ";", with: "")
            
            copyUser.setValue(wrongWords, forKey: kWrongWords)
            user = copyUser
            
            userDefaults.set(user, forKey: "parseJSON")
    
        }
    }
    
    
    func removeWord(){
        
        for word in wordsToDeleteInFav {
            
         
            let copyUser = user?.mutableCopy() as! NSMutableDictionary
            var favWords = user?.object(forKey: kMyWords) as! String
            
            favWords = favWords.replacingOccurrences(of: word + ";", with: "")
            
            copyUser.setValue(favWords, forKey: kMyWords)
            user = copyUser
            
            userDefaults.set(user, forKey: "parseJSON")
 
        }
        
        
//        for word in wordsToDeleteInFav{
//            let id = user?["id"] as! String
//
//            // url to access our php file
//
//            var url:URL!
//            if lan == "zh-Hans" {
//                url = URL(string: "http://ec2-52-198-62-78.ap-northeast-1.compute.amazonaws.com/misswordChina/removeWord.php")!
//            } else {
//                url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/removeWord.php")!
//            }
//
//
//            //let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/removeWord.php")!
//
//            // request url
//            var request = URLRequest(url: url)
//
//            // method to pass data POST - cause it is secured
//            request.httpMethod = "POST"
//
//            // body gonna be appended to url
//            let body = "userID=\(id)&word=\(word)"
//
//            // append body to our request that gonna be sent
//            request.httpBody = body.data(using: .utf8)
//
//            URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
//                // no error
//                if error == nil {
//
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
//
//                        guard let parseJSON = json else {
//                            print("Error while parsing")
//                            //  self?.isParseEnabled = true
//                            //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
//                            return
//                        }
//
//
//
//                        //再次儲存使用者資訊
//                        UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
//                        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
//                        //print(user!)
//                        /*
//                         //載入我的最愛單字
//                         if let myWordsString = user!["myWords"] as! String?{
//                         self!.myWords = myWordsString.components(separatedBy: ";")
//
//                         }
//
//                         self?.isParseEnabled = true
//                         */
//                    } catch{
//
//                        //  self?.isParseEnabled = true
//                        print("catch error")
//
//                    }
//                } else {
//                    //     self?.isParseEnabled = true
//                    print("urlsession has error")
//
//                }
//            }).resume()
//        }
//    }
//
//    func removeWrongWord(){
        
        
        
        
//
//        for word in wordsToDeleteInWrong{
//            let id = user?["id"] as! String
//
//            // url to access our php file
//
//            var url:URL!
//            if lan == "zh-Hans" {
//                url = URL(string: "http://ec2-52-198-62-78.ap-northeast-1.compute.amazonaws.com/misswordChina/removeWrongWord.php")!
//            } else {
//                url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/removeWrongWord.php")!
//            }
//
//            //let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/removeWrongWord.php")!
//
//            // request url
//            var request = URLRequest(url: url)
//
//            // method to pass data POST - cause it is secured
//            request.httpMethod = "POST"
//
//            // body gonna be appended to url
//            let body = "userID=\(id)&word=\(word)"
//
//            // append body to our request that gonna be sent
//            request.httpBody = body.data(using: .utf8)
//
//            URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
//                // no error
//                if error == nil {
//
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
//
//                        guard let parseJSON = json else {
//                            print("Error while parsing")
//                            //  self?.isParseEnabled = true
//                            //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
//                            return
//                        }
//
//
//
//
//                        //再次儲存使用者資訊
//                        UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
//                        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
//
//                        /*
//                         //載入我的最愛單字
//                         if let myWordsString = user!["myWords"] as! String?{
//                         self!.myWords = myWordsString.components(separatedBy: ";")
//
//                         }
//
//                         self?.isParseEnabled = true
//                         */
//                    } catch{
//
//                        //  self?.isParseEnabled = true
//                        print("catch error")
//
//                    }
//                } else {
//                    //     self?.isParseEnabled = true
//                    print("urlsession has error")
//
//                }
//            }).resume()
//        }
    }
    
    
    
    func selectUser(){
        
        
//        // url to access our php file
//
//        var url:URL!
//        if lan == "zh-Hans" {
//            url = URL(string: "http://ec2-52-198-62-78.ap-northeast-1.compute.amazonaws.com/misswordChina/selectUser.php")!
//        } else {
//            url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/selectUser.php")!
//        }
//
//
//        //let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/selectUser.php")!
//
//        let id = user?["id"] as! String
//
//        // request url
//        var request = URLRequest(url: url)
//
//        // method to pass data POST - cause it is secured
//        request.httpMethod = "POST"
//
//
//        // body gonna be appended to url
//        let body = "id=\(id)"
//
//        // append body to our request that gonna be sent
//        request.httpBody = body.data(using: .utf8)
//
//        URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
//            // no error
//            if error == nil {
//
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
//
//                    guard let parseJSON = json else {
//                        print("Error while parsing")
//
//                        //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
//                        return
//                    }
//
//
//
//                    //print("selectUser:\(parseJSON)")
//                    //print("become active refresh user status")
//                    UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
//                    user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
//
//
//                    //MARK: must update
//
//                    if let mapPassedString = user?["mapPassed"] as! String?{
//
//                        mapPassed = Int(mapPassedString)!
//
//                        let userDefaults = UserDefaults.standard
//                        userDefaults.set(mapPassed!, forKey: "mapPassed")
//
//
//                    }
//
//                    if let mapPassed2String = user?["mapPassed2"] as! String?{
//
//                        mapPassed2 = Int(mapPassed2String)!
//
//                        let userDefaults = UserDefaults.standard
//                        userDefaults.set(mapPassed2!, forKey: "mapPassed2")
//
//
//                    }
//
//                    if let mapPassed3String = user?["mapPassed3"] as! String?{
//
//                        mapPassed3 = Int(mapPassed3String)!
//                        let userDefaults = UserDefaults.standard
//                        userDefaults.set(mapPassed3!, forKey: "mapPassed3")
//
//
//                    }
//
//                    if let mapPassed4String = user?["mapPassed4"] as! String?{
//
//                        mapPassed4 = Int(mapPassed4String)!
//                        let userDefaults = UserDefaults.standard
//                        userDefaults.set(mapPassed4!, forKey: "mapPassed4")
//
//
//                    }
//
//                    if let mapPassed5String = user?["mapPassed5"] as! String?{
//
//                        mapPassed5 = Int(mapPassed5String)!
//                        let userDefaults = UserDefaults.standard
//                        userDefaults.set(mapPassed5!, forKey: "mapPassed5")
//
//
//                    }
//
//                    //MARK: simVer K12 特別作法
//
//                    if let mapPassed6String = user?["mapPassed6"] as! String?{
//
//                        var mapPassedStringArray = mapPassed6String.components(separatedBy: ";")
//
//                        for i in 0 ..< mapPassedStringArray.count {
//
//                            //避免最後一位空值
//                            if mapPassedStringArray[i] != "" {
//
//                                k12MapPassed[i] = Int(mapPassedStringArray[i])!
//                            }
//
//
//                        }
//
//                        let userDefaults = UserDefaults.standard
//                        userDefaults.set(k12MapPassed, forKey: "mapPassed6")
//
//
//
//                    }
//
//
//
//                    if let mapPassed7String = user?["mapPassed7"] as! String?{
//
//                        mapPassed7 = Int(mapPassed7String)!
//                        let userDefaults = UserDefaults.standard
//                        userDefaults.set(mapPassed7!, forKey: "mapPassed7")
//
//
//                    }
//
//                    if let mapPassed8String = user?["mapPassed8"] as! String?{
//
//                        mapPassed8 = Int(mapPassed8String)!
//                        let userDefaults = UserDefaults.standard
//                        userDefaults.set(mapPassed8!, forKey: "mapPassed8")
//
//
//                    }
//
//                    if let mapPassed9String = user?["mapPassed9"] as! String?{
//
//                        mapPassed9 = Int(mapPassed9String)!
//                        let userDefaults = UserDefaults.standard
//                        userDefaults.set(mapPassed9!, forKey: "mapPassed9")
//
//
//                    }
//
//
//
//                    if let gamePassedString = user?["gamePassed"] as! String?{
//
//                        let gamePassedStringArray = gamePassedString.components(separatedBy: ":")
//
//                        let s = gamePassedStringArray[0]
//                        let u = gamePassedStringArray[1]
//                        gamePassed = [Int(s)!:Int(u)!]
//
//                        let userDefaults = UserDefaults.standard
//                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed!)
//
//                        userDefaults.set(encodedObject, forKey: "gamePassed")
//
//                    }
//
//                    if let gamePassed2String = user?["gamePassed2"] as! String?{
//
//                        let gamePassed2StringArray = gamePassed2String.components(separatedBy: ":")
//
//                        let s = gamePassed2StringArray[0]
//                        let u = gamePassed2StringArray[1]
//                        gamePassed2 = [Int(s)!:Int(u)!]
//
//                        let userDefaults = UserDefaults.standard
//                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed2!)
//
//                        userDefaults.set(encodedObject, forKey: "gamePassed2")
//
//                    }
//
//                    if let gamePassed3String = user?["gamePassed3"] as! String?{
//
//                        let gamePassed3StringArray = gamePassed3String.components(separatedBy: ":")
//
//                        let s = gamePassed3StringArray[0]
//                        let u = gamePassed3StringArray[1]
//                        gamePassed3 = [Int(s)!:Int(u)!]
//
//                        let userDefaults = UserDefaults.standard
//                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed3!)
//
//                        userDefaults.set(encodedObject, forKey: "gamePassed3")
//
//                    }
//
//
//                    if let gamePassed4String = user?["gamePassed4"] as! String?{
//
//                        let gamePassed4StringArray = gamePassed4String.components(separatedBy: ":")
//
//                        let s = gamePassed4StringArray[0]
//                        let u = gamePassed4StringArray[1]
//                        gamePassed4 = [Int(s)!:Int(u)!]
//
//                        let userDefaults = UserDefaults.standard
//                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed4!)
//
//                        userDefaults.set(encodedObject, forKey: "gamePassed4")
//
//                    }
//
//                    if let gamePassed5String = user?["gamePassed5"] as! String?{
//
//                        let gamePassed5StringArray = gamePassed5String.components(separatedBy: ":")
//
//                        let s = gamePassed5StringArray[0]
//                        let u = gamePassed5StringArray[1]
//                        gamePassed5 = [Int(s)!:Int(u)!]
//
//                        let userDefaults = UserDefaults.standard
//                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed5!)
//
//                        userDefaults.set(encodedObject, forKey: "gamePassed5")
//
//                    }
//
//                    //MARK: simVer K12 特別作法
//
//                    if let gamePassed6String = user?["gamePassed6"] as! String?{
//
//                        var k12GamePassedStringArray = gamePassed6String.components(separatedBy: ";")
//
//                        //如果有19位數就移除最後一位
//                        if k12GamePassedStringArray.count == 19{
//                            k12GamePassedStringArray.removeLast()
//                        }
//
//                        for i in 0 ..< k12GamePassedStringArray.count {
//
//                            let gamePassed6StringArray = k12GamePassedStringArray[i].components(separatedBy: ":")
//
//                                let s = gamePassed6StringArray[0]
//                                let u = gamePassed6StringArray[1]
//                                k12GamePassed[i] = [Int(s)!:Int(u)!]
//
//                        }
//
//                        let userDefaults = UserDefaults.standard
//                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: k12GamePassed!)
//
//                        userDefaults.set(encodedObject, forKey: "gamePassed6")
//
//                    }
//
//                    if let gamePassed7String = user?["gamePassed7"] as! String?{
//
//                        let gamePassed7StringArray = gamePassed7String.components(separatedBy: ":")
//
//                        let s = gamePassed7StringArray[0]
//                        let u = gamePassed7StringArray[1]
//                        gamePassed7 = [Int(s)!:Int(u)!]
//
//                        let userDefaults = UserDefaults.standard
//                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed7!)
//
//                        userDefaults.set(encodedObject, forKey: "gamePassed7")
//
//                    }
//                    if let gamePassed8String = user?["gamePassed8"] as! String?{
//
//                        let gamePassed8StringArray = gamePassed8String.components(separatedBy: ":")
//
//                        let s = gamePassed8StringArray[0]
//                        let u = gamePassed8StringArray[1]
//                        gamePassed8 = [Int(s)!:Int(u)!]
//
//                        let userDefaults = UserDefaults.standard
//                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed8!)
//
//                        userDefaults.set(encodedObject, forKey: "gamePassed8")
//
//                    }
//                    if let gamePassed9String = user?["gamePassed9"] as! String?{
//
//                        let gamePassed9StringArray = gamePassed9String.components(separatedBy: ":")
//
//                        let s = gamePassed9StringArray[0]
//                        let u = gamePassed9StringArray[1]
//                        gamePassed9 = [Int(s)!:Int(u)!]
//
//                        let userDefaults = UserDefaults.standard
//                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed9!)
//
//                        userDefaults.set(encodedObject, forKey: "gamePassed9")
//
//                    }
//
//
//
//
//                } catch{
//
//                    print("catch error")
//
//                }
//            } else {
//
//                print("urlsession has error")
//
//            }
//        }).resume()
        
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

