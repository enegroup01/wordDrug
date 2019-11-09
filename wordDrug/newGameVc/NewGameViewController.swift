//
//  NewGameViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/2/1.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import Speech
import AVFoundation
import SwiftSiriWaveformView
import NVActivityIndicatorView

let showSentenceKey = "showSentence"
let backToSpellKey = "backToSpell"
let practiceNextWordKey = "practiceNextWord"
let startCountDownKey = "startCountDown"
let timesUpKey = "timesUp"

let readyToReadSentenceKey = "readyToReadSentence"
let readSentenceKey = "readSentence"
let onlyPracticeSentenceKey = "onlyPracticeSentence"
let restartGame2Key = "stopReview"
let restartCountingKey = "restartCounting"
let globalPause = "globalPause"
let globalStart = "globalStart"
let turnOffRedLight = "turnOffRedLight"
let sendUnlockStatus = "sendUnlockStatus"


var limitTimer = Timer()

var sentenceCounts = Int()
var senFontSize = CGFloat()

class NewGameViewController: UIViewController, SFSpeechRecognizerDelegate, TagListViewDelegate, AVSpeechSynthesizerDelegate{
    
    let gameVC_pleasePressMic = NSLocalizedString("gameVC_pleasePressMic", comment: "")
  
    let gameVC_pleasePronounce = NSLocalizedString("gameVC_pleasePronounce", comment: "")
    let gameVC_oopsWrong = NSLocalizedString("gameVC_oopsWrong", comment: "")
    let gameVC_great = NSLocalizedString("gameVC_great", comment: "")
    let gameVC_tryAgain = NSLocalizedString("gameVC_tryAgain", comment: "")
    let gameVC_pleaseChooseRightChiSen = NSLocalizedString("gameVC_pleaseChooseRightChiSen", comment: "")
    let gameVC_tagWordsToMakeSentence = NSLocalizedString("gameVC_tagWordsToMakeSentence", comment: "")
    let gameVC_alertLeave = NSLocalizedString("gameVC_alertLeave", comment: "")
    let gameVC_leave = NSLocalizedString("gameVC_leave", comment: "")
    let gameVC_cancel = NSLocalizedString("gameVC_cancel", comment: "")
    let gameVC_addToFav = NSLocalizedString("gameVC_addToFav", comment: "")
    
    let gameVC_quickReview = NSLocalizedString("gameVC_quickReview", comment: "")
    let gameVC_wordPassed = NSLocalizedString("gameVC_wordPassed", comment: "")
    let gameVC_total = NSLocalizedString("gameVC_total", comment: "")
    let gameVC_word = NSLocalizedString("gameVC_word", comment: "")
    let gameVC_iKnow = NSLocalizedString("gameVC_iKnow", comment: "")
    let gameVC_senPassed = NSLocalizedString("gameVC_senPassed", comment: "")
    let gameVC_sen = NSLocalizedString("gameVC_sen", comment: "")
    let gameVC_toShop = NSLocalizedString("gameVC_toShop", comment: "")
    let gameVC_noBuyNow = NSLocalizedString("gameVC_noBuyNow", comment: "")
    let gameVC_reviewNoScore = NSLocalizedString("gameVC_reviewNoScore", comment: "")
    let gameVC_pressMicAgain = NSLocalizedString("gameVC_pressMicAgain", comment: "")
    let gameVC_isReplayTitle = NSLocalizedString("gameVC_isReplayTitle", comment: "")
    //中文字粉紅色
    let pinkColor = UIColor.init(red: 1, green: 153/255, blue: 212/255, alpha: 1)
    let waveColor = UIColor.init(red: 1, green: 237/255, blue: 241/255, alpha: 1)
    let recordingPinkColor = UIColor.init(red: 1, green: 0, blue: 149/255, alpha: 1)
    let yellowColor = UIColor.init(red: 239/255, green: 196/255, blue: 91/255, alpha: 1)
    let orangeColor = UIColor.init(red: 232/255, green: 98/255, blue: 61/255, alpha: 1)
    
    //顯示辨識字的label
    @IBOutlet weak var recogTextLabel: UILabel!
    
    //句子中文label
    @IBOutlet weak var chiSentenceLabel: UILabel!
    
    //句子英文label
    @IBOutlet weak var sentenceLabel: UILabel!
    
    //錄音鍵
    @IBOutlet weak var recordBtn: UIButton!
    
    @IBOutlet weak var limitTimerLabel: UILabel!
    //接收數字
    var spotNumber = Int()
    var unitNumber = Int()
    var mapNumber = Int()
    var gameMode = Int()
    var isReplay = false
    var isUnlocked = false
    
    //辨識聲音用的變數
    
    var speechRecognizer = SFSpeechRecognizer()!
    
    let audioEngine = AVAudioEngine()
    var recognitionRequest:SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask:SFSpeechRecognitionTask?
    
    //暫時使用的句子
    var sentenceSets = [String]()
    
    var allSentenceSets = [[String]]()
    
    //音波用的變數
    var timer:Timer?
    var change:CGFloat = 0.01
    @IBOutlet weak var audioView: SwiftSiriWaveformView!
    
    //辨識的答案
    //var wordToReceive = String()
    //辨識所錄到的聲音
    var wordRecorded = String()
    
    //發音的句子名稱
    var sentenceToPronounce = String()
    
    //辨識單字是否正確
    var isRecogWordCorrect = Bool()
    
    //所收到的單字次序
    var wordSequenceToReceive = String()
    
    //句子的文字
    var sentence = String()
    
//    //是否是在確認句子
//    var isCheckingSentence = Bool()
    
    //所選到的tag
    //var tagsSelected = [String]()
    var attrTagsSelected = [NSMutableAttributedString]()
    
    //製作tag
    @IBOutlet weak var tagView: TagListView!
    
    //發音單字
    var synWord = String()
    
    //Text to speech合成器
    var synth = AVSpeechSynthesizer()
    
    @IBOutlet weak var resultBg: UIImageView!
    
    let resultTitleImg = UIImageView()
    
    @IBOutlet weak var coverBg: UIImageView!
    @IBOutlet weak var firstWordBtn: UIButton!
    
    @IBOutlet weak var secondWordBtn: UIButton!
    @IBOutlet weak var thirdWordBtn: UIButton!
    //避免按鍵
    @IBOutlet weak var coverBtn: UIButton!
    
    @IBOutlet weak var firstEngWord: UILabel!
    
    @IBOutlet weak var secondEngWord: UILabel!
    @IBOutlet weak var thirdEngWord: UILabel!
    @IBOutlet weak var firstChiWord: UILabel!
    
    @IBOutlet weak var secondChiWord: UILabel!
    
    @IBOutlet weak var bigOkBtn: UIButton!
    @IBOutlet weak var thirdChiWord: UILabel!
    
    @IBOutlet weak var skipPronounceBtn: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    var bonusScoreLabel = UILabel()
    
    var answerTime = 0
    
    //用來顯示正確與否
    var wordBtns = [UIButton]()
    
    //我的字集
    var myWords = [String]()
    //抓字上傳後台使用
    var firstEngWordText = String()
    var secondEngWordText = String()
    var thirdEngWordText = String()

    @IBOutlet weak var wordCountLabel: UILabel!
    
    let word1Label = UILabel()
    let word2Label = UILabel()
    let word3Label = UILabel()
    
    let inCircle = UIImageView()
    let midCircle = UIImageView()
    let outCircle = UIImageView()
    
    var isCelebratingMapPassed = false
    
    
    //用來顯示正確答案的變數, 保留標點符號大小寫
    var completeWordsToShow = String()
    var sentenceTag = [String]()
    
    //錄音動畫
    var recordingIndicator:NVActivityIndicatorView?
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var waitTimer = Timer()
    //紀錄錯誤發音字
    
    let wrongPronounceWords:[[String:[String]]] = [["烘焙":["烘陪"]], ["affect":["a fect"]], ["頭髮":["頭法"]], ["campaign":["cam pain"]], ["和":["汗"]], ["woman":["wo men"]], ["snowman":["snow man"]], ["fisherman":["fisher man"]], ["gentleman":["gentle man"]], ["supermarket":["super market"]], ["劣拙地":["列濁地"]], ["begin":["be ghing"]], ["巧克力":["巧顆粒"]], ["lead":["leed"]], ["tear":["tee er"]], ["度數":["度樹"]], ["年紀較長的":["年紀較漲的"]], ["告訴":["吿速"]], ["envelope":["anvelope"]], ["sensor":["sen sir"]], ["友誼":["有宜"]], ["kilometer":["killa meter"]], ["桶子":["統子"]], ["油炸":["油柵"]], ["外框":["外筐"]], ["高麗菜":["高力菜"]], ["油炸的":["油柵的"]], ["磨坊":["魔訪"]], ["螫":["遮"]], ["kneepad":["knee pad"]], ["iron":["eye ern"]], ["歌曲":["哥取"]], ["鵝":["蛾"]], ["forehead":["fore head"]], ["數":["鼠"]], ["April":["eigh pro"]], ["重播":["蟲剝"]], ["槳糊":["降胡"]], ["stupid":["stubid"]], ["錫":["習"]], ["曲線":["娶線"]], ["風箏":["風蒸"]], ["comb":["kome"]], ["wolf":["wallf"]], ["absurd":["a bsurd"]]]
    
    @IBOutlet weak var sen1Btn: UIButton!
    
    @IBOutlet weak var sen2Btn: UIButton!
    
    @IBOutlet weak var sen3Btn: UIButton!
    
    @IBOutlet weak var sen4Btn: UIButton!
    
    var allUnitSpotNums = [[Int]]()
    
    var randomSpots = [Int]()
    var randomUnits = [Int]()
    
    var allRandomSens = [[Int:Int]]()
    
    //新的隨機句子作法
    
    var randomSens = [Int]()
    
    var allBtns = [UIButton]()
    
    var correctRandom = Int()
    
    let correctSign = UIImageView()
    let wrongSign = UIImageView()
    
    var btnTimer = Timer()
    var timerCount = 0
    
    var chiSentence = String()
    
    //所有alertView的變數
    var alertBg = UIImageView()
    var alertText = UILabel()
    var ghostBtn = UIButton()
    var quitBtn = UIButton()
    var cancelBtn = UIButton()
    var leftBtnClickedImg = UIImageView()
    var rightBtnClickedImg = UIImageView()
    let darkRed = UIColor.init(red: 192/255, green: 40/255, blue: 75/255, alpha: 1)
    let darkColor = UIColor.init(red: 53/255, green: 53/255, blue: 53/255, alpha: 1)
    
    var noBuyBtn = UIButton()
    var goToBuyBtn = UIButton()
    
    //reviewWord & sentence alert
    var reviewWordBg = UIImageView()
    var reviewAlertTitle1 = UILabel()
    var reviewAlertTitle2 = UILabel()
    var reviewAlertTotalLabel = UILabel()
    var reviewAlertCountLabel = UILabel()
    var reviewAlertUnitLabel = UILabel()
    var reviewOkBtn = UIButton()
    var isReviewWrong = false
    
    var isCountingTriggered = false
    var isCelebratingClassPassed = false
    
    var audioSession = AVAudioSession.sharedInstance()
    
    @IBOutlet weak var playSoundBtn: UIButton!
    var clearTagBtn = UIButton()
    
    var courseReceived = Int()
    var gamePassedDic:[Int:Int]?
    var mapPassedInt = Int()
    var increaseNum = Int()
    var maxMapNum = Int()

    var maxSpot:Int!
    
    var countScoreTimer = Timer()
    //紀錄已加過的分數
    var scoreAdded = Int()
    
    var wrongChineseCounts = Int()
    
    var proRate = Int()
    var senRate = Int()
    
    var senCount = Int()
    
    var firstTimeFavWords = [String]()
    
    var limitSeconds = Int()
    
    @IBOutlet weak var circleOkBtn: UIButton!
    //var isPurchased = String()
    
    var originalPoints = Int()
    var wrongWordsToSend = [String]()
    var scoresToSend = Int()
    
    var newRels = [String]()
    
    
    var sentenceCount = Int()
    @IBOutlet weak var hintLabel: UILabel!
    
    @IBOutlet weak var purchaseAlert: UIImageView!
    
    
    var chiSentenceFontSize:CGFloat!

    var dif = CGFloat()
    var iPadDif = CGFloat()

    
    //MARK: simVer K12 課程紀錄變數
//    var k12MapPassed:[Int]!
//    var k12GamePassed:[[Int:Int]]!
    
    //MARK: 這個變數移到外面
    var tempGamePassedDic:[Int:Int]?
    
    //MARK: simVer這裏新增一個變數來避免 wrongPronounce word把 synWord被取代掉
    var originalWordToRecognize:String!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        print("width: \(width)")
        print("height: \(height)")
        
        skipPronounceBtn.isHidden = true
        
        var tagMarginY = CGFloat()
        var okBtnDif = CGFloat()
        var hintLabelFontSize:CGFloat!
        var engSentenceFontSize:CGFloat!
        var cornerRadiusNumber:CGFloat!
        var resultElementDif:CGFloat!
        var wordCountLabelSize:CGFloat!
        var iPhoneXHeightDif:CGFloat!
        var iPhoneXHeightDif2:CGFloat!
        var iPhonePlusHeightDif:CGFloat!
        var iPhoneSeYDif:CGFloat!
        var resultBgExtraHigh:CGFloat = 0
        
        switch width {
        case 834:
            resultBgExtraHigh = 80
            
        default:
            break
        }
     
        switch height {
            
            
        case 1366, 1336:

            dif = 1
            iPadDif = 2
            engSentenceFontSize = 70
            chiSentenceFontSize = 40
            wordCountLabelSize = 130
            hintLabelFontSize = 30
            senFontSize = 60
            tagMarginY = 13
            okBtnDif = 10
          
            cornerRadiusNumber = 4
            resultElementDif = 1
            iPhoneXHeightDif = 1
            iPhoneXHeightDif2 = 1
            iPhonePlusHeightDif = 1

            iPhoneSeYDif = 10
   
            
        case 1024, 1194, 1112:
  
            
            dif = 1
            iPadDif = 1.6
            engSentenceFontSize = 55
            chiSentenceFontSize = 30
            wordCountLabelSize = 115
            hintLabelFontSize = 24
            senFontSize = 50
            tagMarginY = 13

            okBtnDif = 10
            cornerRadiusNumber = 6
            resultElementDif = 1.05
            iPhoneXHeightDif = 1
            iPhoneXHeightDif2 = 1
            iPhonePlusHeightDif = 1
   
            iPhoneSeYDif = 0

        case 812:
            
            //iphoneX
            
            dif = 1
            iPadDif = 1
            engSentenceFontSize = 30
            chiSentenceFontSize = 18
            wordCountLabelSize = 80
            hintLabelFontSize = 16
            senFontSize = 26
            tagMarginY = 13
        
            okBtnDif = 15
            
            cornerRadiusNumber = 6
            resultElementDif = 1
            iPhoneXHeightDif = 1.5
            iPhoneXHeightDif2 = 1.1
            iPhonePlusHeightDif = 1

            iPhoneSeYDif = 0

        case 736:
            
            //plus
            
            dif = 1.1
            iPadDif = 1
            engSentenceFontSize = 30
            chiSentenceFontSize = 18
            wordCountLabelSize = 80
         
            hintLabelFontSize = 16

            senFontSize = 28
            tagMarginY = 13
      
            okBtnDif = 10
            cornerRadiusNumber = 6
            resultElementDif = 1
            iPhoneXHeightDif = 1
            iPhoneXHeightDif2 = 1
            iPhonePlusHeightDif = 0.8
   
            iPhoneSeYDif = 0

     
        case 667:
            
            //iPhone 7 & 8
            dif = 1
            iPadDif = 1
            engSentenceFontSize = 26
            chiSentenceFontSize = 18
            wordCountLabelSize = 70
        
            hintLabelFontSize = 16
   
            senFontSize = 24
            tagMarginY = 10
            
            okBtnDif = 10
         
            cornerRadiusNumber = 8
            resultElementDif = 1
            iPhoneXHeightDif = 1
            iPhoneXHeightDif2 = 1
            iPhonePlusHeightDif = 1
      
            iPhoneSeYDif = 0
        

        case 568:
            
            dif = 0.9
           
            iPadDif = 1
            engSentenceFontSize = 24
            chiSentenceFontSize = 16
            wordCountLabelSize = 60
           
            hintLabelFontSize = 16
            senFontSize = 22
            tagMarginY = 8
       
            okBtnDif = -10
            cornerRadiusNumber = 8
            resultElementDif = 1.1
            iPhoneXHeightDif = 1
            iPhoneXHeightDif2 = 1
            iPhonePlusHeightDif = 1

 
            iPhoneSeYDif = 20
           
            
        case 896:
            print("user figures here")
            dif = 1
            iPadDif = 1
            engSentenceFontSize = 30
            chiSentenceFontSize = 18
            wordCountLabelSize = 80
            hintLabelFontSize = 16
            senFontSize = 26
            tagMarginY = 13
            
            okBtnDif = 15
            
            cornerRadiusNumber = 6
            resultElementDif = 0.95
            iPhoneXHeightDif = 1.5
            iPhoneXHeightDif2 = 1.1
            iPhonePlusHeightDif = 1
            
            iPhoneSeYDif = 0
        default:
           
            dif = 1
            iPadDif = 1
            engSentenceFontSize = 30
            chiSentenceFontSize = 18
            wordCountLabelSize = 80
            hintLabelFontSize = 16
            senFontSize = 26
            tagMarginY = 13
            
            okBtnDif = 15
            
            cornerRadiusNumber = 6
            resultElementDif = 1
            iPhoneXHeightDif = 1.5
            iPhoneXHeightDif2 = 1.1
            iPhonePlusHeightDif = 1
            
            iPhoneSeYDif = 0

            break
        }
        
        
        //離開遊戲
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.leaveGame), name: NSNotification.Name("leaveGame"), object: nil)
        
        //離開自訂練習
        
        //接收發音 - ok
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.pronounceWord), name: NSNotification.Name("pronounceWord"), object: nil)
        
        //接收口試NC (單字 + 句子)
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.startToRecognize), name: NSNotification.Name("startToRecognize"), object: nil)
        
        //啟動聽考拼寫
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyBackToSpell), name: NSNotification.Name("backToSpell"), object: nil)
        //接收做句子
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.showSentence), name: NSNotification.Name("showSentence"), object: nil)
        
        //啟動下個單字
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyPracticeNextWord), name: NSNotification.Name("practiceNextWord"), object: nil)
        
        
        //啟動計分
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyAddScore), name: NSNotification.Name("addScore"), object: nil)
        
        //啟動倒數
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyStartCountDown), name: NSNotification.Name("startCountDown"), object: nil)
        
        //接收時間到, 利用別的func來刪除畫面
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyPracticeNextWord), name: NSNotification.Name("timesUp"), object: nil)
        

        //通知句子念完要準備口試
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyReadyToReadSentence), name: NSNotification.Name("readyToReadSentence"), object: nil)
        
        
        //準備口試句子
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.readSentence), name: NSNotification.Name("readSentence"), object: nil)
        
        
        //接收練習句子
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.onlyPracticeSentence), name: NSNotification.Name("onlyPracticeSentence"), object: nil)
        
        
        //從gameScene時間到來接收restartGame2
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.stopReview), name: NSNotification.Name("stopReview"), object: nil)
        
        
        //接收暫停功能
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.pauseGame), name: NSNotification.Name("pause"), object: nil)
        
        //重新倒數
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyRestartCounting), name: NSNotification.Name("restartCounting"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.pauseGame), name: NSNotification.Name("globalPause"), object: nil)
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.stopLimitTimer), name: NSNotification.Name("stopLimitTimer"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyPlayEndMusic), name: NSNotification.Name("playEndingMusic"), object: nil)
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.removePlaySoundBtn), name: NSNotification.Name("removePlaySoundBtn"), object: nil)

        //MARK: UI Setting
        scoreLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.widthAnchor.constraint(equalToConstant: 150 * dif * iPadDif).isActive = true
        scoreLabel.heightAnchor.constraint(equalToConstant: 40 * dif * iPadDif).isActive = true
        scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 35 * dif * iPadDif).isActive = true
        scoreLabel.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 140 * iPadDif * dif * iPhoneXHeightDif).isActive = true
        
        scoreLabel.font = scoreLabel.font.withSize(chiSentenceFontSize + CGFloat(10))

        scoreLabel.text = ""
        
    
        self.view.bringSubviewToFront(limitTimerLabel)
        limitTimerLabel.translatesAutoresizingMaskIntoConstraints = false
        limitTimerLabel.font = limitTimerLabel.font.withSize(hintLabelFontSize)
        limitTimerLabel.textAlignment = .center

        limitTimerLabel.adjustsFontSizeToFitWidth = true
        limitTimerLabel.widthAnchor.constraint(equalToConstant: 50 * iPadDif * dif).isActive = true
        limitTimerLabel.heightAnchor.constraint(equalToConstant: 20 * iPadDif * dif).isActive = true
        limitTimerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        limitTimerLabel.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 5 * dif * iPadDif).isActive = true
        
        
        
        //ghost View
        let lightGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.58)
        ghostBtn.frame = CGRect(x: 0, y: 0, width: width, height: height)
        ghostBtn.backgroundColor = lightGray
        self.view.addSubview(ghostBtn)
        self.view.bringSubviewToFront(ghostBtn)
        

        //做reviewAlert
        reviewWordBg.frame = CGRect(x: width / 2 - 237 * dif * iPadDif / 2, y: height / 3, width: 237 * dif * iPadDif, height: 214 * dif * iPadDif)
        
        
        reviewWordBg.image = UIImage(named:"reviewWordResultBg.png")
        self.view.addSubview(reviewWordBg)
        self.view.bringSubviewToFront(reviewWordBg)
        
        

        reviewAlertTitle1.frame = CGRect(x: reviewWordBg.frame.width / 22, y: reviewWordBg.frame.height / 20, width: 92 * dif * iPadDif, height: 25 * dif * iPadDif)
        //reviewAlertTitle1.backgroundColor = .gray
        
        reviewAlertTitle1.text = gameVC_quickReview
        reviewAlertTitle1.font = UIFont(name: "Helvetica Bold", size: 20 * iPadDif)
        reviewAlertTitle1.textColor = .white
        reviewAlertTitle1.textAlignment = .right
        reviewWordBg.addSubview(reviewAlertTitle1)
        self.view.bringSubviewToFront(reviewAlertTitle1)
     
        
        reviewAlertTitle2.frame = CGRect(x: reviewAlertTitle1.frame.minX, y: reviewAlertTitle1.frame.maxY - 5 * dif, width: 92 * dif * iPadDif, height: 25 * dif * iPadDif)
        //reviewAlertTitle2.backgroundColor = .red
        reviewAlertTitle2.text = gameVC_wordPassed
        reviewAlertTitle2.font = UIFont(name: "Helvetica Bold", size: 12 * iPadDif)
        reviewAlertTitle2.textColor = .white
        reviewAlertTitle2.textAlignment = .right
        
        reviewWordBg.addSubview(reviewAlertTitle2)
           self.view.bringSubviewToFront(reviewAlertTitle2)
        
        
        reviewAlertTotalLabel.frame = CGRect(x: reviewAlertTitle1.frame.midX - 10 * dif, y: reviewAlertTitle2.frame.maxY * 1.3, width: 30 * dif * iPadDif, height: 17 * dif * iPadDif)
        reviewAlertTotalLabel.text = gameVC_total
        reviewAlertTotalLabel.textAlignment = .left
        reviewAlertTotalLabel.font = UIFont(name: "Helvetica Bold", size: 12 * iPadDif)
        reviewAlertTotalLabel.textColor = darkColor
        //reviewAlertTotalLabel.backgroundColor = .gray
        reviewWordBg.addSubview(reviewAlertTotalLabel)
                self.view.bringSubviewToFront(reviewAlertTotalLabel)
        
        
        reviewAlertCountLabel.frame = CGRect(x: (reviewWordBg.frame.width - 170 * dif * iPadDif) / 2, y: reviewAlertTotalLabel.frame.midY, width: 170 * dif * iPadDif, height: 80 * dif * iPadDif)
        reviewAlertCountLabel.text = "1306"
        reviewAlertCountLabel.textAlignment = .center
        reviewAlertCountLabel.font = UIFont(name: "Helvetica Bold", size: 70 * iPadDif)
        reviewAlertCountLabel.textColor = darkColor
        //reviewAlertCountLabel.backgroundColor = .gray
        reviewWordBg.addSubview(reviewAlertCountLabel)
                self.view.bringSubviewToFront(reviewAlertCountLabel)
        
        
        reviewAlertUnitLabel.frame = CGRect(x: reviewAlertCountLabel.frame.maxX - 10 * dif * iPadDif, y: reviewAlertCountLabel.frame.maxY - 17 * dif * iPadDif, width: 20 * dif * iPadDif, height: 17 * dif * iPadDif)
        reviewAlertUnitLabel.text = gameVC_word
        reviewAlertUnitLabel.textAlignment = .left
        reviewAlertUnitLabel.font = UIFont(name: "Helvetica Bold", size: 12 * iPadDif)
        reviewAlertUnitLabel.textColor = darkColor
        //reviewAlertCountLabel.backgroundColor = .gray
        reviewWordBg.addSubview(reviewAlertUnitLabel)
        self.view.bringSubviewToFront(reviewAlertUnitLabel)
        
        let attrs0 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12 * iPadDif), NSAttributedString.Key.foregroundColor : darkColor]
        
        
        let title = NSAttributedString(string: gameVC_iKnow, attributes: attrs0)
        
        reviewOkBtn = UIButton(type: .system)
        //reviewOkBtn.showsTouchWhenHighlighted = true
        reviewOkBtn.frame = CGRect(x: (width - 169 * dif * iPadDif) / 2 + okBtnDif, y: reviewWordBg.frame.maxY - 27 * dif * 1.5 * iPadDif, width: 169 * dif * iPadDif, height: 27 * dif * iPadDif)
        reviewOkBtn.addTarget(self, action: #selector(NewGameViewController.reviewOkBtnClicked), for: .touchUpInside)
        reviewOkBtn.setBackgroundImage(UIImage(named:"reviewOkBtnPng.png"), for: .normal)
        reviewOkBtn.setAttributedTitle(title, for: .normal)
        self.view.addSubview(reviewOkBtn)
        self.view.bringSubviewToFront(reviewOkBtn)

        //加入alertView
        
        self.view.bringSubviewToFront(alertBg)
        alertBg.translatesAutoresizingMaskIntoConstraints = false
        alertBg.image = UIImage(named: "reviewSelectBg3.png")
        self.view.addSubview(alertBg)
        alertBg.widthAnchor.constraint(equalToConstant: 237 * iPadDif * dif).isActive = true
        alertBg.heightAnchor.constraint(equalToConstant: 140 * iPadDif * dif).isActive = true
        alertBg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertBg.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        self.view.bringSubviewToFront(purchaseAlert)
        purchaseAlert.isHidden = true
        purchaseAlert.translatesAutoresizingMaskIntoConstraints = false
        
        purchaseAlert.widthAnchor.constraint(equalToConstant: 237 * iPadDif * dif).isActive = true
        purchaseAlert.heightAnchor.constraint(equalToConstant: 462 * iPadDif * dif).isActive = true
        purchaseAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        purchaseAlert.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        var purImg = String()
        if lan == "zh-Hans"{
            purImg = "purchaseAlertSim3.png"
        } else {
            purImg = "purchaseAlert.png"
        }
        purchaseAlert.image = UIImage(named:purImg)
        
         alertText.translatesAutoresizingMaskIntoConstraints = false

        //alertText.backgroundColor = .green
        alertText.font = UIFont(name: "Helvetica Bold", size: hintLabelFontSize)
        alertText.textColor = .white
        alertText.text = gameVC_alertLeave
        alertText.numberOfLines = 0
        alertText.textAlignment = .center
        alertText.adjustsFontSizeToFitWidth = true
        alertBg.addSubview(alertText)
        alertText.widthAnchor.constraint(equalToConstant: 200 * iPadDif * dif).isActive = true
        alertText.heightAnchor.constraint(equalToConstant: 80 * iPadDif * dif).isActive = true
        alertText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertText.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        

        cancelBtn.titleLabel?.font = UIFont(name: "Helvetica Bold", size: hintLabelFontSize)
        cancelBtn.titleLabel?.numberOfLines = 2
        cancelBtn.setTitle(gameVC_cancel, for: .normal)
        cancelBtn.setTitleColor(orangeColor, for: .normal)
        cancelBtn.addTarget(self, action: #selector(NewGameViewController.removeBtns), for: .touchUpInside)
        self.view.addSubview(cancelBtn)
        self.view.bringSubviewToFront(cancelBtn)
        


        cancelBtn.anchor(top: alertText.bottomAnchor, leading: alertBg.leadingAnchor, bottom: alertBg.bottomAnchor, trailing: alertBg.centerXAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        
    
        //cancelBtn.backgroundColor = .red
        

        noBuyBtn.titleLabel?.font = UIFont(name: "Helvetica Bold", size: hintLabelFontSize)
        //noBuyBtn.backgroundColor = .red
        noBuyBtn.setTitleColor(orangeColor, for: .normal)
        noBuyBtn.setTitle(gameVC_noBuyNow, for: .normal)
        
        self.view.addSubview(noBuyBtn)
          self.view.bringSubviewToFront(noBuyBtn)
        noBuyBtn.anchor(top: nil, leading: purchaseAlert.leadingAnchor, bottom: purchaseAlert.bottomAnchor, trailing: nil, size: .init(width: 119 * iPadDif * dif, height: 462 * iPadDif * dif / 10))

        quitBtn.titleLabel?.font = UIFont(name: "Helvetica Bold", size: hintLabelFontSize)
        quitBtn.setTitle(gameVC_leave, for: .normal)
        quitBtn.titleLabel?.numberOfLines = 2
        quitBtn.setTitleColor(orangeColor, for: .normal)
        quitBtn.addTarget(self, action: #selector(NewGameViewController.leaveWithoutSaving), for: .touchUpInside)
        self.view.addSubview(quitBtn)
                self.view.bringSubviewToFront(quitBtn)

        
        quitBtn.anchor(top: alertText.bottomAnchor, leading: alertBg.centerXAnchor, bottom: alertBg.bottomAnchor, trailing: alertBg.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        //quitBtn.backgroundColor = .black

        goToBuyBtn.titleLabel?.font = UIFont(name: "Helvetica Bold", size: hintLabelFontSize)
        
        goToBuyBtn.setTitleColor(orangeColor, for: .normal)
        goToBuyBtn.setTitle(gameVC_toShop, for: .normal)
        self.view.addSubview(goToBuyBtn)
        self.view.bringSubviewToFront(goToBuyBtn)
        
        goToBuyBtn.anchor(top: nil, leading: noBuyBtn.trailingAnchor, bottom: purchaseAlert.bottomAnchor, trailing: nil)
        goToBuyBtn.anchorSize(to: noBuyBtn)
        
        coverBg.image = UIImage(named:"coverBg.png")
        var resultBgImg = String()
        if lan == "zh-Hans"{
            resultBgImg = "newResultBgSim.png"
        } else {
            
            resultBgImg = "newResultBg.png"
        }
        
        resultBg.image = UIImage(named:resultBgImg)

        coverBtn.isHidden = true
        coverBg.isHidden = true
        resultBg.isHidden = true
    
        resultTitleImg.isHidden = true
        firstWordBtn.isHidden = true
        secondWordBtn.isHidden = true
        thirdWordBtn.isHidden = true
        bigOkBtn.isHidden = true
        bigOkBtn.setImage(UIImage(named:"bigOkBtn.png"), for: .normal)
        firstWordBtn.isEnabled = false
        secondWordBtn.isEnabled = false
        thirdWordBtn.isEnabled = false
        
        
        //sentenceBtn layout

        sen1Btn.titleLabel?.adjustsFontSizeToFitWidth = true
        sen1Btn.titleLabel?.numberOfLines = 2
        sen1Btn.titleEdgeInsets.left = 8
        
        sen1Btn.translatesAutoresizingMaskIntoConstraints = false
        sen1Btn.widthAnchor.constraint(equalToConstant: width * 0.9).isActive = true
        sen1Btn.heightAnchor.constraint(equalToConstant: 65 * iPadDif * dif).isActive = true
        sen1Btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sen1Btn.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -23 * iPadDif * dif / iPhoneXHeightDif / iPhoneXHeightDif).isActive = true
        

        sen2Btn.titleLabel?.adjustsFontSizeToFitWidth = true
        sen2Btn.titleLabel?.numberOfLines = 2
        sen2Btn.titleEdgeInsets.left = 8
        
        sen2Btn.translatesAutoresizingMaskIntoConstraints = false
        sen2Btn.widthAnchor.constraint(equalToConstant: width * 0.9).isActive = true
        sen2Btn.heightAnchor.constraint(equalToConstant: 65 * iPadDif * dif).isActive = true
        sen2Btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sen2Btn.topAnchor.constraint(equalTo: sen1Btn.bottomAnchor, constant: 12 * iPadDif * dif).isActive = true
        
    
        sen3Btn.titleLabel?.adjustsFontSizeToFitWidth = true
        sen3Btn.titleLabel?.numberOfLines = 2
        sen3Btn.titleEdgeInsets.left = 8
        sen3Btn.translatesAutoresizingMaskIntoConstraints = false
        sen3Btn.widthAnchor.constraint(equalToConstant: width * 0.9).isActive = true
        sen3Btn.heightAnchor.constraint(equalToConstant: 65 * iPadDif * dif).isActive = true
        sen3Btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sen3Btn.topAnchor.constraint(equalTo: sen2Btn.bottomAnchor, constant: 12 * iPadDif * dif).isActive = true
        

        sen4Btn.titleLabel?.adjustsFontSizeToFitWidth = true
        sen4Btn.titleLabel?.numberOfLines = 2
        sen4Btn.titleEdgeInsets.left = 8
        sen4Btn.translatesAutoresizingMaskIntoConstraints = false
        
        
        sen4Btn.widthAnchor.constraint(equalToConstant: width * 0.9).isActive = true
        sen4Btn.heightAnchor.constraint(equalToConstant: 65 * iPadDif * dif).isActive = true
        sen4Btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sen4Btn.topAnchor.constraint(equalTo: sen3Btn.bottomAnchor, constant: 12 * iPadDif * dif).isActive = true
        
        
        allBtns.append(sen1Btn)
        allBtns.append(sen2Btn)
        allBtns.append(sen3Btn)
        allBtns.append(sen4Btn)
        
        for btn in allBtns{
            btn.titleLabel?.font = btn.titleLabel?.font.withSize(chiSentenceFontSize)
            btn.layer.cornerRadius = btn.frame.width / cornerRadiusNumber
            btn.isHidden = true
        }
        
        
        //layOut
        
        //做titleLabel放在resultBg上方
        
  
        self.view.addSubview(resultTitleImg)
        self.view.bringSubviewToFront(resultTitleImg)
        
        resultBg.translatesAutoresizingMaskIntoConstraints = false
        resultBg.widthAnchor.constraint(equalToConstant: 280 * dif * iPadDif).isActive = true
        resultBg.heightAnchor.constraint(equalToConstant: 488 * dif * iPadDif + resultBgExtraHigh).isActive = true
        resultBg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //568的位置過低
        resultBg.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: (100 * iPadDif * dif / resultElementDif) * iPhoneXHeightDif * iPhoneXHeightDif2).isActive = true

        
        firstWordBtn.translatesAutoresizingMaskIntoConstraints = false
        firstWordBtn.widthAnchor.constraint(equalToConstant: 260 * dif * iPadDif).isActive = true
        firstWordBtn.heightAnchor.constraint(equalToConstant: 60 * dif * iPadDif).isActive = true
        firstWordBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstWordBtn.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: ((height / 2 - (15 * iPadDif * dif)) * resultElementDif)).isActive = true
       
        
        secondWordBtn.translatesAutoresizingMaskIntoConstraints = false
        secondWordBtn.widthAnchor.constraint(equalToConstant: 260 * dif * iPadDif).isActive = true
        secondWordBtn.heightAnchor.constraint(equalToConstant: 60 * dif * iPadDif).isActive = true
        secondWordBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       secondWordBtn.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: ((height / 2 + (50 * iPadDif * dif)) * resultElementDif)).isActive = true
        
   
        thirdWordBtn.translatesAutoresizingMaskIntoConstraints = false
        thirdWordBtn.widthAnchor.constraint(equalToConstant: 260 * dif * iPadDif).isActive = true
        thirdWordBtn.heightAnchor.constraint(equalToConstant: 60 * dif * iPadDif).isActive = true
        thirdWordBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        thirdWordBtn.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: ((height / 2 + (115 * iPadDif * dif)) * resultElementDif)).isActive = true
        
  
        
        firstEngWord.translatesAutoresizingMaskIntoConstraints = false
        firstEngWord.widthAnchor.constraint(equalToConstant: 160 * dif * iPadDif).isActive = true
        firstEngWord.heightAnchor.constraint(equalToConstant: 40 * dif * iPadDif).isActive = true
        firstEngWord.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -40 * iPadDif * dif).isActive = true
        firstEngWord.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: (height / 2 - (5 * iPadDif * dif)) * resultElementDif).isActive = true
     
        firstEngWord.text = ""


        
        firstChiWord.translatesAutoresizingMaskIntoConstraints = false
        firstChiWord.widthAnchor.constraint(equalToConstant: 80 * dif * iPadDif).isActive = true
        firstChiWord.heightAnchor.constraint(equalToConstant: 40 * dif * iPadDif).isActive = true
        firstChiWord.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 80 * iPadDif * dif).isActive = true
        firstChiWord.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: (height / 2 - (5 * iPadDif * dif)) * resultElementDif).isActive = true

        firstChiWord.text = ""
        
        //secondEngWord.backgroundColor = .yellow
        //secondChiWord.backgroundColor = .green
     
        
        secondEngWord.translatesAutoresizingMaskIntoConstraints = false
        secondEngWord.widthAnchor.constraint(equalToConstant: 160 * dif * iPadDif).isActive = true
        secondEngWord.heightAnchor.constraint(equalToConstant: 40 * dif * iPadDif).isActive = true
        secondEngWord.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -40 * iPadDif * dif).isActive = true
        secondEngWord.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: (height / 2 + (60 * iPadDif * dif)) * resultElementDif).isActive = true
        
     
        secondChiWord.translatesAutoresizingMaskIntoConstraints = false
        secondChiWord.widthAnchor.constraint(equalToConstant: 80 * dif * iPadDif).isActive = true
        secondChiWord.heightAnchor.constraint(equalToConstant: 40 * dif * iPadDif).isActive = true
        secondChiWord.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 80 * iPadDif * dif).isActive = true
        secondChiWord.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: (height / 2 + (60 * iPadDif * dif)) * resultElementDif).isActive = true
        
        
        
        //thirdEngWord.backgroundColor = .blue
        //thirdEngWord.alpha = 0.3
        //thirdChiWord.backgroundColor = .purple
     
        
        thirdEngWord.translatesAutoresizingMaskIntoConstraints = false
        thirdEngWord.widthAnchor.constraint(equalToConstant: 160 * dif * iPadDif).isActive = true
        thirdEngWord.heightAnchor.constraint(equalToConstant: 40 * dif * iPadDif).isActive = true
        thirdEngWord.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -40 * iPadDif * dif).isActive = true
        thirdEngWord.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: (height / 2 + (125 * iPadDif * dif)) * resultElementDif).isActive = true
        
   
        thirdChiWord.translatesAutoresizingMaskIntoConstraints = false
        thirdChiWord.widthAnchor.constraint(equalToConstant: 80 * dif * iPadDif).isActive = true
        thirdChiWord.heightAnchor.constraint(equalToConstant: 40 * dif * iPadDif).isActive = true
        thirdChiWord.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 80 * iPadDif * dif).isActive = true
        thirdChiWord.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: (height / 2 + (125 * iPadDif * dif)) * resultElementDif).isActive = true
        
        
        //三個字label的共同屬性
        firstEngWord.adjustsFontSizeToFitWidth = true
        secondEngWord.adjustsFontSizeToFitWidth = true
        thirdEngWord.adjustsFontSizeToFitWidth = true
       
        firstEngWord.font = firstEngWord.font.withSize(chiSentenceFontSize)
        secondEngWord.font = firstEngWord.font.withSize(chiSentenceFontSize)
        thirdEngWord.font = firstEngWord.font.withSize(chiSentenceFontSize)
        
        
        firstChiWord.adjustsFontSizeToFitWidth = true
        secondChiWord.adjustsFontSizeToFitWidth = true
        thirdChiWord.adjustsFontSizeToFitWidth = true
       
        firstChiWord.font = firstEngWord.font.withSize(hintLabelFontSize)
        secondChiWord.font = firstEngWord.font.withSize(hintLabelFontSize)
        thirdChiWord.font = firstEngWord.font.withSize(hintLabelFontSize)
        
        firstChiWord.textAlignment = .center
        secondChiWord.textAlignment = .center
        thirdChiWord.textAlignment = .center
    
        
        bigOkBtn.translatesAutoresizingMaskIntoConstraints = false
        bigOkBtn.widthAnchor.constraint(equalToConstant: 210 * dif * iPadDif).isActive = true
        bigOkBtn.heightAnchor.constraint(equalToConstant: 29 * dif * iPadDif).isActive = true
        bigOkBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bigOkBtn.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: (height / 2 + (190 * iPadDif * dif)) * resultElementDif + okBtnDif).isActive = true
        
       
        self.view.bringSubviewToFront(bonusScoreLabel)
      
        //針對iPhoneX的高度部分特別調整, 也針對iPhonePlusY做調整
        bonusScoreLabel.frame = CGRect(x: (width - 100 * iPadDif * dif) / 2, y: (140 * iPadDif * dif) * resultElementDif * iPhoneXHeightDif * iPhoneXHeightDif2 * iPhoneXHeightDif2 / iPhonePlusHeightDif, width: 100 * iPadDif * dif, height: 39 * iPadDif * dif)
        
        
        bonusScoreLabel.textColor = .red
        bonusScoreLabel.textAlignment = .right
        bonusScoreLabel.font = UIFont(name: "Helvetica Bold", size: hintLabelFontSize)
        bonusScoreLabel.text = "+bonus"
        bonusScoreLabel.alpha = 0
        //bonusScoreLabel.backgroundColor = .white

        view.addSubview(bonusScoreLabel)
        
        
        wordCountLabel.translatesAutoresizingMaskIntoConstraints = false
        wordCountLabel.widthAnchor.constraint(equalToConstant: 170 * dif * iPadDif).isActive = true
        wordCountLabel.heightAnchor.constraint(equalToConstant: 70 * dif * iPadDif).isActive = true
        wordCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -20 * dif * iPadDif).isActive = true
        wordCountLabel.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: (height / 2 - (90 * iPadDif * dif)) * resultElementDif).isActive = true
        
    
        //wordCountLabel.backgroundColor = .yellow
        wordCountLabel.font = wordCountLabel.font.withSize(wordCountLabelSize)
        wordCountLabel.textAlignment = .right
        wordCountLabel.adjustsFontSizeToFitWidth = true
        wordCountLabel.text = ""
        
        //0911
        
        sentenceLabel.font = sentenceLabel.font.withSize(engSentenceFontSize)
        sentenceLabel.adjustsFontSizeToFitWidth = true
        sentenceLabel.translatesAutoresizingMaskIntoConstraints = false
        sentenceLabel.widthAnchor.constraint(equalToConstant: width - 80 * iPadDif * dif).isActive = true
        sentenceLabel.heightAnchor.constraint(equalToConstant: 150 * iPadDif * dif - iPhoneSeYDif).isActive = true
        sentenceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sentenceLabel.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 50 * iPadDif * dif).isActive = true
        
        //sentenceLabel.backgroundColor = .red

        chiSentenceLabel.numberOfLines = 2
        chiSentenceLabel.font = chiSentenceLabel.font.withSize(chiSentenceFontSize)
        chiSentenceLabel.adjustsFontSizeToFitWidth = true
        chiSentenceLabel.textColor = pinkColor
        
        chiSentenceLabel.translatesAutoresizingMaskIntoConstraints = false
        chiSentenceLabel.widthAnchor.constraint(equalToConstant: width - 50 * iPadDif * dif).isActive = true
        chiSentenceLabel.heightAnchor.constraint(equalToConstant: 70 * iPadDif * dif - iPhoneSeYDif).isActive = true
        chiSentenceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chiSentenceLabel.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 200 * iPadDif * dif - iPhoneSeYDif).isActive = true
        
        
        //chiSentenceLabel.backgroundColor = .green

        
        circleOkBtn.translatesAutoresizingMaskIntoConstraints = false
        
        circleOkBtn.widthAnchor.constraint(equalToConstant: 128 * iPadDif * dif).isActive = true
        circleOkBtn.heightAnchor.constraint(equalToConstant: 128 * iPadDif * dif).isActive = true
        circleOkBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        circleOkBtn.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 160 * dif * iPadDif * iPhoneXHeightDif).isActive = true
        
        if lan == "zh-Hans" {
            circleOkBtn.setBackgroundImage(UIImage(named: "circleOkBtnSim2.png"), for: .normal)
        } else {
            circleOkBtn.setBackgroundImage(UIImage(named: "circleOkBtn.png"), for: .normal)
        }

    
        coverBg.frame = CGRect(x: 0, y: 0, width: width, height: height)
        coverBtn.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        recogTextLabel.frame = CGRect(x: 0, y: height * 2 / 5, width: width, height: height / 5.5)
    
        
        //recogTextLabel.backgroundColor = .yellow
       
        //recogTextLabel.alpha = 0.3

        word1Label.textColor = .white
        word1Label.font = UIFont(name: "Helvetica Bold", size: hintLabelFontSize)
        word1Label.text = gameVC_addToFav
        word1Label.textAlignment = .center
        word1Label.alpha = 0
        self.firstWordBtn.addSubview(word1Label)
        
        word1Label.translatesAutoresizingMaskIntoConstraints = false
        
        word1Label.widthAnchor.constraint(equalToConstant: 80 * dif * iPadDif).isActive = true
        word1Label.heightAnchor.constraint(equalToConstant: 60 * iPadDif * dif).isActive = true
        word1Label.centerXAnchor.constraint(equalTo: firstWordBtn.centerXAnchor).isActive = true
        word1Label.centerYAnchor.constraint(equalTo:firstWordBtn.centerYAnchor).isActive = true

        word2Label.textColor = .white
        word2Label.font = UIFont(name: "Helvetica Bold", size: hintLabelFontSize)
        word2Label.text = gameVC_addToFav
        word2Label.textAlignment = .center
        word2Label.alpha = 0
        self.secondWordBtn.addSubview(word2Label)
        word2Label.translatesAutoresizingMaskIntoConstraints = false
        
        word2Label.widthAnchor.constraint(equalToConstant: 80 * dif * iPadDif).isActive = true
        word2Label.heightAnchor.constraint(equalToConstant: 60 * iPadDif * dif).isActive = true
        word2Label.centerXAnchor.constraint(equalTo: secondWordBtn.centerXAnchor).isActive = true
        word2Label.centerYAnchor.constraint(equalTo:secondWordBtn.centerYAnchor).isActive = true
        
        

        word3Label.textColor = .white
        word3Label.font = UIFont(name: "Helvetica Bold", size: hintLabelFontSize)
        word3Label.text = gameVC_addToFav
        word3Label.textAlignment = .center
        word3Label.alpha = 0
        self.thirdWordBtn.addSubview(word3Label)
        word3Label.translatesAutoresizingMaskIntoConstraints = false
        
        word3Label.widthAnchor.constraint(equalToConstant: 80 * dif * iPadDif).isActive = true
        word3Label.heightAnchor.constraint(equalToConstant: 60 * iPadDif * dif).isActive = true
        word3Label.centerXAnchor.constraint(equalTo: thirdWordBtn.centerXAnchor).isActive = true
        word3Label.centerYAnchor.constraint(equalTo:thirdWordBtn.centerYAnchor).isActive = true
        
        
        //載入我的最愛單字
        
        if let myWordsString = user?[kMyWords] as! String?{
            myWords = myWordsString.components(separatedBy: ";")
            
        }
        
        wordBtns.append(firstWordBtn)
        wordBtns.append(secondWordBtn)
        wordBtns.append(thirdWordBtn)
        
        //設定delegate來監控讀音
        synth.delegate = self
        
        //設定好tagView
        tagView.backgroundColor = .clear
        
        tagView.delegate = self
        //tagView.isHidden = true
        
        tagView.marginY = tagMarginY


        tagView.anchor(top: recogTextLabel.bottomAnchor, leading: view.safeLeftAnchor, bottom: view.safeBottomAnchor, trailing: view.safeRightAnchor, padding: .init(top: 30 * dif * iPadDif, left: 10 * dif * iPadDif, bottom: -30 * dif * iPadDif, right: -10 * dif * iPadDif))
        
        //tagView.backgroundColor = .red
        
        //辨識字的大小設定
        recogTextLabel.adjustsFontSizeToFitWidth = true
        //recogTextLabel.backgroundColor = .green
        
        
        //設定發音鍵
        
        playSoundBtn.anchor(top: nil, leading: nil, bottom: view.safeBottomAnchor, trailing: view.safeRightAnchor, padding: .init(top: 0, left: 0, bottom: -5 * iPadDif * dif, right: -5 * iPadDif * dif), size: .init(width: 60 * iPadDif * dif, height: 27 * iPadDif * dif))
        var playSoundBtnImg = UIImage()
        if lan == "zh-Hans" {
            playSoundBtnImg = UIImage(named: "playSoundBtnSim.png")!
            
        } else {
            
            playSoundBtnImg = UIImage(named: "pronounceBtn4.png")!
        }

        playSoundBtn.setBackgroundImage(playSoundBtnImg, for: .normal)
        
        clearTagBtn = UIButton(type: .system)
        clearTagBtn.addTarget(self, action: #selector(NewGameViewController.clearTag), for: .touchUpInside)

        view.addSubview(clearTagBtn)
        view.bringSubviewToFront(clearTagBtn)
        clearTagBtn.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeBottomAnchor, trailing: nil, padding: .init(top: 0, left: 5 * iPadDif * dif, bottom: -5 * iPadDif * dif, right: 0), size: .init(width: 25 * iPadDif * dif, height: 23 * iPadDif * dif))

        clearTagBtn.setBackgroundImage(UIImage(named:"clearTagBtn.png"
            ), for: .normal)

        
        skipPronounceBtn.anchor(top: recogTextLabel.bottomAnchor, leading: nil, bottom: nil, trailing: view.safeRightAnchor, padding: .init(top: 30 * iPadDif * dif, left: 0, bottom: 0, right: -5 * iPadDif * dif), size: .init(width: 82 * iPadDif * dif, height: 29 * iPadDif * dif))
        
        var skipProImg = UIImage()
        if lan == "zh-Hans"{
            skipProImg = UIImage(named: "skipPronounceBtnSim.png")!
        } else {
             skipProImg = UIImage(named: "skipPronounceBtn.png")!
            
        }
        
        skipPronounceBtn.setBackgroundImage(skipProImg, for: .normal)
    
        //先隱藏錄音及辨識
        recordBtn.isHidden = true
        
        recogTextLabel.isHidden = true
        
        
        //讀目前課程數字數量
        var titleImg:String!
        var titleWidth:CGFloat!

        //MARK: must update
        //MARK: simVer 這裏課程最大值要動態化 done

        
        switch courseReceived {
            
        case 0:
            
            gamePassedDic = gamePassed!
            mapPassedInt = mapPassed!
            
   
            titleWidth = 70
            //print("------------------\(lan)")
            if lan == "zh-Hans"{
                //檢體中文
                //之後還要用courseReceived來改數值, 因為每個course值不同
                titleImg = "simBlock0.png"
                maxMapNum = 2
                increaseNum = 35

                
            } else {
                //其餘語言
          
                titleImg = "block0Title.png"
                maxMapNum = 4
                increaseNum = 0
            }
            
            
            
        case 1:
            
            gamePassedDic = gamePassed2!
            mapPassedInt = mapPassed2!
    
            
            titleWidth = 70
            
            if lan == "zh-Hans"{
                //檢體中文
                //初中
                //print("檢體中文關卡數")
                titleImg = "simBlock1.png"
                maxMapNum = 4
                increaseNum = 38
                
            } else {
                //其餘語言
                //print("繁體中文關卡數")
                titleImg = "block1Title.png"
                increaseNum = 5
                maxMapNum = 5
                
            }
            
            
            
        case 2:
            
            gamePassedDic = gamePassed3!
            mapPassedInt = mapPassed3!
          
            
            titleWidth = 70
            
            if lan == "zh-Hans"{
                //檢體中文
                //高中
                //print("檢體中文關卡數")
                maxMapNum = 5
                increaseNum = 43
                titleImg = "simBlock2.png"
                
            } else {
                //其餘語言
                //print("繁體中文關卡數")
                increaseNum = 11
                maxMapNum = 6
                titleImg = "block2Title.png"
                
            }

            
            
            
        case 3:
            gamePassedDic = gamePassed4!
            mapPassedInt = mapPassed4!
       
            titleImg = "block3Title.png"
            
            if lan == "zh-Hans"{
                //檢體中文
                //CET4
                //print("檢體中文關卡數")
                maxMapNum = 10
                increaseNum = 49
                titleImg = "simBlock3.png"
                titleWidth = 70

                
            } else {
                //其餘語言
                
                //print("繁體中文關卡數")
                increaseNum = 18
                maxMapNum = 8
                titleImg = "block3Title.png"
                titleWidth = 87

                
            }

        case 4:
            gamePassedDic = gamePassed5!
            mapPassedInt = mapPassed5!
        
            titleImg = "block4Title.png"
         
            
            if lan == "zh-Hans"{
                //檢體中文
                //CET6
                //print("檢體中文關卡數")
                maxMapNum = 12
                increaseNum = 60
                titleImg = "simBlock4.png"
                   titleWidth = 70

                
            } else {
                //其餘語言
                
                //print("繁體中文關卡數")
                increaseNum = 27
                maxMapNum = 7
                titleImg = "block4Title.png"
                   titleWidth = 95
                
            }

        case 5:
            
        
            //MARK: simVer K12改變作法
            gamePassedDic = k12GamePassed[mapNumber]
            mapPassedInt = k12MapPassed[mapNumber]

            
            titleImg = "simBlock5.png"
            titleWidth = 70
            
            if lan == "zh-Hans"{
                //檢體中文
                //CET6
                //print("檢體中文關卡數")
                maxMapNum = 17
                increaseNum = 73
            }
            
        case 6:
            gamePassedDic = gamePassed7!
            mapPassedInt = mapPassed7!
            
            titleImg = "simBlock6.png"
            titleWidth = 70
            
            if lan == "zh-Hans"{
                //檢體中文
                //CET6
                //print("檢體中文關卡數")
                maxMapNum = 6
                increaseNum = 91
            }

        case 7:
            gamePassedDic = gamePassed8!
            mapPassedInt = mapPassed8!
            
            titleImg = "simBlock7.png"
            titleWidth = 87
            
            if lan == "zh-Hans"{
                //檢體中文
                //CET6
                //print("檢體中文關卡數")
                maxMapNum = 8
                increaseNum = 98
            }
            
        case 8:
            gamePassedDic = gamePassed9!
            mapPassedInt = mapPassed9!
            
            titleImg = "simBlock8.png"
            titleWidth = 95
            
            if lan == "zh-Hans"{
                //檢體中文
                //CET6
                //print("檢體中文關卡數")
                maxMapNum = 7
                increaseNum = 107
            }


        default:
            break
            
        }
        //MARK: simVer 這裏tempGamePassedDic要做動態化 done
        //MARK: 移到外面
        if lan == "zh-Hans"{
            
            //之後還要用courseReceived來改數值, 因為每個course值不同
            switch courseReceived{
                
            case 0:
                //國小
                
                maxSpot = 11
            case 1:
                //初中
                maxSpot = 15
            case 2:
                //高中
                maxSpot = 15
            case 3:
                //CET4
                maxSpot = 15
            case 4:
                //CET6
                maxSpot = 15
            case 5:
                //K12
                
                //MARK: simVer 要確認這裡是否抓到正確的mapNumber沒被改過的 done
                switch (mapNumber){
                    
                case 0:
                    maxSpot = 4
                case 1:
                    maxSpot = 11
                case 2:
                    maxSpot = 11
                case 3:
                    maxSpot = 10
                case 4:
                    maxSpot = 11
                case 5:
                    maxSpot = 11
                case 6:
                    maxSpot = 11
                case 7:
                    maxSpot = 11
                case 8:
                    maxSpot = 13
                case 9:
                    maxSpot = 13
                case 10:
                    maxSpot = 11
                case 11:
                    maxSpot = 11
                case 12:
                    maxSpot = 7
                case 13:
                    maxSpot = 11
                case 14:
                    maxSpot = 11
                case 15:
                    maxSpot = 6
                case 16:
                    maxSpot = 13
                case 17:
                    maxSpot = 13
                    
                default:
                    break
                    
                }
                
            case 6:
                //Toeic
                maxSpot = 15
                
            case 7:
                //ielts
                maxSpot = 15
            case 8:
                
                //tofel
                maxSpot = 15
                
            default:
                
                break
                
            }
        } else {
            
            maxSpot = 15
        }
        

        //需要判定抓那一個title圖來顯示
        resultTitleImg.image = UIImage(named: titleImg)
        resultTitleImg.anchor(top: resultBg.topAnchor, leading: resultBg.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20 * dif * iPadDif, left: 20 * dif * iPadDif, bottom: 0, right: 0), size: .init(width: titleWidth * dif * iPadDif, height: 70 * dif * iPadDif))
        
        
        //讀取Bundle裡的句子
        var sentenceFile:String?
        
        if gameMode == 0 {
            
            limitSeconds = UserDefaults.standard.object(forKey: "limitSeconds") as! Int
        
            //測試用
            //limitSeconds = 2
            
            //不論如何都啟動, 但是有購買就會invalidate
            
            if !isReplay{
            
            limitTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NewGameViewController.countLimit), userInfo: nil, repeats: true)
            } 
            //修正成要加increaseNum, lessonVc傳過來之前有扣除increaseNum
       
           let sentenceName = "s" + String(mapNumber + increaseNum + 1) + "-" + String(spotNumber + 1)
          
            
            if let filepath = Bundle.main.path(forResource: sentenceName, ofType: "txt") {
                do {
                    sentenceFile = try String(contentsOfFile: filepath)
                    let sentences = sentenceFile?.components(separatedBy: "; ")
                    
                    //把字讀取到wordSets裡
                    sentenceSets = sentences!
       
                } catch {
                    // contents could not be loaded
                    print("catch error")
                }
            } else {
                // example.txt not found!
                print("txt can't be found")
            }
            //print(sentenceName)
        } else if gameMode == 2{
            
            //隨機單字
            //在此抓測驗單字的亂數順序
            //MARK: simVer K12 特別辨識是否已學完
            
            //代表K12該關卡已學玩, mapPassedInt == 1是之後破關後要設定供辨識的
            if courseReceived == 5{
                //K12
                
                if mapPassedInt == 1 {
                    //K12當關卡全破
                    tempGamePassedDic = [maxSpot - 1:9]
                
                } else {
                    //未全破的話
                    tempGamePassedDic = gamePassedDic
                    
                }
                
            } else if mapNumber < mapPassedInt{
                //非K12

                if lan == "zh-Hans"{
                    //檢體中文
                    
                    //print("檢體中文關卡數")
                    //print("got a maxSpot:\(maxSpot)")
                    
                    tempGamePassedDic = [maxSpot - 1:9]
                    
                    
                } else {
                    //其餘語言
                    //print("繁體中文關卡數")
                    tempGamePassedDic = [14:9]
                    
                }
                
            } else {
                
                //相等的話
                tempGamePassedDic = gamePassedDic
            }
  
            for (s,u) in tempGamePassedDic!{
                
                //1. 填入spot上限供亂數選擇
                
                //填入全部
                if s > 0 {
                    
                    //做出幾個30
                    allUnitSpotNums = [Array<Any>](repeating: [Int](), count: s + 1) as! [[Int]]
                    
                    //把所有的30空格填滿 [0:0] [0:1].....
                    for i in 0 ..< (s) {
                        
                        for n in 0 ..< 30{
                            allUnitSpotNums[i].append(n)
                        }
                    }
                    
                    //填入殘值
                    if u > 0 {
                        
                        //再最後一位數填入每三個的殘值
                        for i in 0 ..< u * 3 {
                            
                            allUnitSpotNums[allUnitSpotNums.count - 1].append(i)
                        }
                   
                    } else {
                        //若u為0, 就移除掉一整排空值
                        allUnitSpotNums.remove(at: allUnitSpotNums.count - 1)
                    }
                    
                } else {
                    
                    allUnitSpotNums = [Array<Any>](repeating: [Int](), count: 1) as! [[Int]]
                    //填入殘值
                    
                    //如果只過一關, 加入四個句子去隨機選項
                    if u == 1 {
                        
                        for i in 0 ..< 4 {
                            
                            allUnitSpotNums[0].append(i)
                            
                        }
                        
                        //超過一關就直接隨機所有學過句子
                    } else if u > 0 {
                        
                        for i in 0 ..< u * 3 {
                            
                            allUnitSpotNums[0].append(i)
                            
                        }
                    }
                }
            }

            //Part 2. 讀取所有句子
            
            for (s,_) in tempGamePassedDic!{
                
                //讀取已完整的所有字集
                
                for i in 0 ..< (s + 1){
                    var wordFile:String?
                    //前面的1代表第一張地圖
                    
                     let name = "s" + String(describing: mapNumber + increaseNum + 1) + "-" + String(i + 1)
                  
                    //抓字
                    if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
                        do {
                            wordFile = try String(contentsOfFile: filepath)
                            let words = wordFile?.components(separatedBy: "; ")
                            
                            //把字讀取到wordSets裡
                            allSentenceSets.append(words!)
                            //print(contents)
                            
                        } catch {
                            // contents could not be loaded
                        }
                    } else {
                        // example.txt not found!
                    }
                    
                }
                
                
            }
            
        }
        
        //print("how many: :\(allSentenceSets[0])")
        
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "NewGameScene") {
            
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! NewGameScene? {
                
                // Copy gameplay related content over to the scene
                //傳送關卡資訊過去
                sceneNode.unitNumber = unitNumber
                sceneNode.spotNumber = spotNumber
                sceneNode.mapNumber =  mapNumber
                sceneNode.gameMode = gameMode
                sceneNode.courseReceived = courseReceived
                sceneNode.isReplay = isReplay
                sceneNode.isUnlocked = isUnlocked
    
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = false
                    view.showsNodeCount = false
                }
            }
        }
        
        //辨識語音的delegate
        speechRecognizer.delegate = self
        
        //先設定為false之後做開啟
        recordBtn.isEnabled = false
        
        //設定語言
        speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en"))!
        
        //備註: 請求授權, 之後要做拒絕的機制
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            OperationQueue.main.addOperation({
                
                switch authStatus {
                    
                case .authorized:
                    self.recordBtn.isEnabled = true
                    
                case .denied:
                    self.recordBtn.isEnabled = true
                    //self.recordingButton.setTitle("User denied access to speech recogniztion", for: .disabled)
                    
                case .restricted:
                    self.recordBtn.isEnabled = true
                    //self.recordingButton.setTitle("Speech recogniztion is restricted on this device", for: .disabled)
                    
                case .notDetermined:
                    self.recordBtn.isEnabled = true
                    //self.recordingButton.setTitle("Speech recognition has not yet been authorized", for: .disabled)
                    
                    
                }
                
                
            })
            
            
        }
        


        circleOkBtn.isHidden = true
        noBuyBtn.isHidden = true
        goToBuyBtn.isHidden = true
        ghostBtn.isHidden = true
        alertBg.isHidden = true
        cancelBtn.isHidden = true
        quitBtn.isHidden = true
        leftBtnClickedImg.isHidden = true
        rightBtnClickedImg.isHidden = true
        reviewWordBg.isHidden = true
        reviewOkBtn.isHidden = true
        clearTagBtn.isHidden = true
        
        
        //抓發音相關字
        var relWordFile = String()
        var relArray = [String]()
        //抓字
        if let filepath = Bundle.main.path(forResource: "relWords", ofType: "txt") {
            do {
                relWordFile = try String(contentsOfFile: filepath)
                
                relArray = relWordFile.components(separatedBy: "]],")
                
            } catch {
                // contents could not be loaded
            }
        } else {
            // example.txt not found!
        }
        
        //MARK: relevant word Rules
        var newRel = String()
        for rel in relArray {
            
            newRel = rel.replacingOccurrences(of: "[", with:"")
            newRel = newRel.replacingOccurrences(of: "]", with:"")
            newRel = newRel.replacingOccurrences(of: "\"", with: "")
            newRel = newRel.replacingOccurrences(of: "\\", with: "")
            newRels.append(newRel)
            
        }

        
        hintLabel.textColor = .white
        
        self.view.bringSubviewToFront(hintLabel)
        hintLabel.translatesAutoresizingMaskIntoConstraints = false


        
        //hintLabel.backgroundColor = .blue
        hintLabel.widthAnchor.constraint(equalToConstant: 250 * iPadDif * dif).isActive = true
        hintLabel.heightAnchor.constraint(equalToConstant: 50 * iPadDif * dif).isActive = true
        hintLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        hintLabel.topAnchor.constraint(equalTo: recordBtn.topAnchor, constant: -50 / dif * iPadDif / iPhonePlusHeightDif).isActive = true
        
        hintLabel.font = hintLabel.font.withSize(hintLabelFontSize)
        hintLabel.text = ""
        //hintLabel.backgroundColor = .blue
        hintLabel.adjustsFontSizeToFitWidth = true
        hintLabel.textAlignment = .center
        
        recordBtn.translatesAutoresizingMaskIntoConstraints = false
        
        recordBtn.widthAnchor.constraint(equalToConstant: 128 * iPadDif * dif).isActive = true
        recordBtn.heightAnchor.constraint(equalToConstant: 128 * iPadDif * dif).isActive = true
        recordBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        recordBtn.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 160 * dif * iPadDif * iPhoneXHeightDif).isActive = true

        //做錄音動畫
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        recordingIndicator = NVActivityIndicatorView(frame: frame, type: .circleStrokeSpin, color: recordingPinkColor, padding: 2)
   
        self.view.addSubview(recordingIndicator!)
        self.view.bringSubviewToFront(recordBtn)
        recordingIndicator?.translatesAutoresizingMaskIntoConstraints = false
        recordingIndicator?.widthAnchor.constraint(equalToConstant: 150 * iPadDif * dif).isActive = true
        recordingIndicator?.heightAnchor.constraint(equalToConstant: 150 * iPadDif * dif).isActive = true
        recordingIndicator?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        recordingIndicator?.centerYAnchor.constraint(equalTo: recordBtn.centerYAnchor).isActive = true

        //wave畫面設定
        audioView.isHidden = true
        audioView.backgroundColor = .clear
        audioView.density = 1
        audioView.numberOfWaves = 5
        audioView.secondaryLineWidth = 1
        audioView.amplitude = 0.1
        audioView.alpha = 0.7
        audioView.waveColor = recordingPinkColor
        audioView.translatesAutoresizingMaskIntoConstraints = false
        
        audioView.widthAnchor.constraint(equalToConstant: width).isActive = true
        audioView.heightAnchor.constraint(equalToConstant: height / 6.5).isActive = true
        audioView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        audioView.centerYAnchor.constraint(equalTo: recordBtn.centerYAnchor).isActive = true
        
        //print("loaded relword counts:\(newRels.count)")
        
    }
    
    @objc func clearTag(){
        
        recogTextLabel.text = ""
        for tag in tagView.tagViews{
            
            tag.isSelected = false
        }
    
        for i in 0 ..< attrTagsSelected.count{
            attrTagsSelected[i] = NSMutableAttributedString()
        }
        
    }
   
    
    deinit {
        print("new game deinit")
    }
    
    
    
    @objc func removePronounceBtn(){
         
    }
    

    @objc func removePlaySoundBtn(){

        playSoundBtn.isHidden = true
        
    }
    
    
    @objc func exitReview(){
    
    self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func countLimit(){
        
        if(limitSeconds > 0){
            
            let minutes = String(limitSeconds / 60)
            var seconds = String(limitSeconds % 60)
            let secondsToCheck = limitSeconds % 60
            
            if seconds == "0" {
                
                seconds = "00"
            } else if secondsToCheck < 10 {
                
                seconds = "0" + seconds
                
            }
            
            limitTimerLabel.text = minutes + ":" + seconds
            limitSeconds -= 1
            
        } else {
            
            //本日時間已到
            
            
            limitTimerLabel.text = "0:00"
            timerPause()
            
            
        }
        
        
    }
    
    
    @objc func notifyPlayEndMusic(){
        
    }
    
    @objc func stopLimitTimer(){
        
        limitTimer.invalidate()
        
        UserDefaults.standard.set(limitSeconds, forKey: "limitSeconds")
        
    }

    @objc func reviewOkBtnClicked(){

        //這裏按下去要能夠儲存

        self.dismiss(animated: true, completion: nil)
    }
    
    //接收nc
    @objc func pauseGame(){

        
        limitTimer.invalidate()
        
        if gameMode == 0 {
        UserDefaults.standard.set(limitSeconds, forKey: "limitSeconds")
        }
        
        alertText.text = gameVC_alertLeave
        quitBtn.setTitle(gameVC_leave, for: .normal)
        cancelBtn.setTitle(gameVC_cancel, for: .normal)
        ghostBtn.isHidden = false
        alertBg.isHidden = false
        cancelBtn.isHidden = false
        quitBtn.isHidden = false
        leftBtnClickedImg.isHidden = false
        rightBtnClickedImg.isHidden = false
        
        quitBtn.removeTarget(self, action: #selector(NewGameViewController.toPurchaseVc), for: .touchUpInside)
        quitBtn.addTarget(self, action: #selector(NewGameViewController.leaveWithoutSaving), for: .touchUpInside)
        
        cancelBtn.removeTarget(self, action: #selector(NewGameViewController.leaveWithoutSaving), for: .touchUpInside)
        cancelBtn.addTarget(self, action: #selector(NewGameViewController.removeBtns), for: .touchUpInside)
        
        
    }
    
    func timerPause(){
        

        limitTimer.invalidate()
        UserDefaults.standard.set(limitSeconds, forKey: "limitSeconds")
        
        
        //alertText.text = ""
        goToBuyBtn.setTitle(gameVC_toShop, for: .normal)
        noBuyBtn.setTitle(gameVC_noBuyNow, for: .normal)
        ghostBtn.isHidden = false
        purchaseAlert.isHidden = false
        goToBuyBtn.isHidden = false
        noBuyBtn.isHidden = false
        leftBtnClickedImg.isHidden = false
        rightBtnClickedImg.isHidden = false
        purchaseAlert.layer.zPosition = 10
        goToBuyBtn.layer.zPosition = 10
        noBuyBtn.layer.zPosition = 10
        leftBtnClickedImg.layer.zPosition = 10
        rightBtnClickedImg.layer.zPosition = 10

        goToBuyBtn.addTarget(self, action: #selector(NewGameViewController.toPurchaseVc), for: .touchUpInside)
        
        noBuyBtn.addTarget(self, action: #selector(NewGameViewController.leaveWithoutSaving), for: .touchUpInside)
    }
    
    
    @objc func toPurchaseVc(){
        
        performSegue(withIdentifier: "fromGameToPurchase", sender: self)
    }
    

    
    
    
    @IBAction func playSoundClicked(_ sender: Any) {
  
 
        //避免空字也發音
        if synWord != String(){
  
            synPronounce()
        }
    }
    
    
    @objc func leaveWithoutSaving(){

        timer?.invalidate()

        self.dismiss(animated: true, completion: nil)
        
        

    }
    
    @objc func removeBtns(){
        
        //send Nc去continue
        //檢查這個有沒有問題
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "restartCounting"), object: nil, userInfo: nil)
        

        purchaseAlert.isHidden = true
        ghostBtn.isHidden = true
        alertBg.isHidden = true
        cancelBtn.isHidden = true
        quitBtn.isHidden = true
        leftBtnClickedImg.isHidden = true
        rightBtnClickedImg.isHidden = true
        noBuyBtn.isHidden = true
        goToBuyBtn.isHidden = true
        
        
        //暫時測試使用 let 改成 var
        let isPurchased = UserDefaults.standard.object(forKey: "isPurchased") as! Bool
        
        //isPurchased = true

        if gameMode == 0 {
            
            //沒有買的話
            if !isPurchased && !isReplay{
                
                limitTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NewGameViewController.countLimit), userInfo: nil, repeats: true)
            }
            
        }
        
        
    }
    
    @objc func notifyRestartCounting(){
        
    }
    

    
    @objc func notifyReadyToReadSentence(){
        
    }
    
    @objc func readSentence(){
        
        //補足delegate裡沒有enable的功能
        
        if tagView.isHidden {
            recordBtn.isEnabled = true
            
            recordBtn.isHidden = false
        }

        //打開輸入字的label
        recogTextLabel.isHidden = false
        
    }
    
    
    @objc func notifyAddScore(){
        
    }
    
    
    //wave動畫
    @objc internal func refreshAudioView(_:Timer) {
        if self.audioView.amplitude <= self.audioView.idleAmplitude || self.audioView.amplitude > 1.0 {
            self.change *= -1.0
        }
        // Simply set the amplitude to whatever you need and the view will update itself.
        self.audioView.amplitude += self.change
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       
        
        
        NotificationCenter.default.removeObserver(self)

        //離開遊戲
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.leaveGame), name: NSNotification.Name("leaveGame"), object: nil)
        
        //接收發音 - ok
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.pronounceWord), name: NSNotification.Name("pronounceWord"), object: nil)
        //接收口試NC (單字 + 句子)
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.startToRecognize), name: NSNotification.Name("startToRecognize"), object: nil)
        
        //啟動聽考拼寫
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyBackToSpell), name: NSNotification.Name("backToSpell"), object: nil)
        //接收做句子
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.showSentence), name: NSNotification.Name("showSentence"), object: nil)
        
        //啟動下個單字
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyPracticeNextWord), name: NSNotification.Name("practiceNextWord"), object: nil)
        
        
        //啟動計分
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyAddScore), name: NSNotification.Name("addScore"), object: nil)
        
        //啟動倒數
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyStartCountDown), name: NSNotification.Name("startCountDown"), object: nil)
        
        //接收時間到, 利用別的func來刪除畫面
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyPracticeNextWord), name: NSNotification.Name("timesUp"), object: nil)
        
        
        //接收顯示tagView內容
//        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.showTag), name: NSNotification.Name("showTag"), object: nil)
        
        
        //通知句子念完要準備口試
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyReadyToReadSentence), name: NSNotification.Name("readyToReadSentence"), object: nil)
        
        
        //準備口試句子
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.readSentence), name: NSNotification.Name("readSentence"), object: nil)
        
        
        //接收練習句子
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.onlyPracticeSentence), name: NSNotification.Name("onlyPracticeSentence"), object: nil)
        
        
        //從gameScene時間到來接收restartGame2
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.stopReview), name: NSNotification.Name("stopReview"), object: nil)
        
        
        //接收暫停功能
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.pauseGame), name: NSNotification.Name("pause"), object: nil)
        
        //重新倒數
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyRestartCounting), name: NSNotification.Name("restartCounting"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.pauseGame), name: NSNotification.Name("globalPause"), object: nil)
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.stopLimitTimer), name: NSNotification.Name("stopLimitTimer"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.removePlaySoundBtn), name: NSNotification.Name("removePlaySoundBtn"), object: nil)
        
        
        //1.0.7 bug fixed
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyPlayEndMusic), name: NSNotification.Name("playEndingMusic"), object: nil)

        
        //send unlock status
           NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifySendUnlockStatus), name: NSNotification.Name(sendUnlockStatus), object: nil)
        
 
        
        //先確認有沒有購買
        
        //暫時測試使用let 改成var
        let isPurchased = UserDefaults.standard.object(forKey: "isPurchased") as! Bool
        
        //test
        //isPurchased = true
        
        if isPurchased{
            
            //print("已購買, 不計時")
            //已購買, 不計時
            limitTimer.invalidate()
 
            limitTimerLabel.text = ""
            removeBtns()
            
        } else {
            
            print("還沒買所以要計時")
            
            if gameMode == 0 {

                limitSeconds = UserDefaults.standard.object(forKey: "limitSeconds") as! Int
                
                //測試
                //limitSeconds = 2
                
                if(limitSeconds > 0){
                    
                    let minutes = String(limitSeconds / 60)
                    var seconds = String(limitSeconds % 60)
                    let secondsToCheck = limitSeconds % 60
                    
                    if seconds == "0" {
                        
                        seconds = "00"
                    } else if secondsToCheck < 10 {
                        
                        seconds = "0" + seconds
                        
                    }
                    
                    limitTimerLabel.text = minutes + ":" + seconds
                    
                } else{
                    
                    //本日時間已到
                    if !isReplay{
                    
                    limitTimerLabel.text = "0:00"
                    
                    timerPause()
                    }
                }
                
            }
            
            
        }
        
      if isReplay && gameMode == 0{
            limitTimerLabel.textColor = pinkColor
            limitTimerLabel.text = gameVC_isReplayTitle
    
        }
    }
    
    
    //造句子
    @objc func showSentence(_ notification: NSNotification){
        
        //接收單字數字準備做句子
        
        if gameMode == 0 {
            
            if let sequenceToReceive = notification.userInfo?["currentWordSequence"] as? String{
                
                //指定好數字
                wordSequenceToReceive = sequenceToReceive
                
            }
            if let speakTime = notification.userInfo?["pronounceTime"] as? Int{
                
                pronounceTime = speakTime
            }
            
            //回復錄音btn圖示
            recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
            
            //製作句子
            makeSentence()
        } else if gameMode == 2 {
            makeSentence()
        }
        
    }
    
    
    @objc func notifyPracticeNextWord(){

        //移除tagView
        attrTagsSelected.removeAll(keepingCapacity: false)
        tagView.isHidden = true
        tagView.removeAllTags()
        clearTagBtn.isHidden = true
        
        //移除輸入字
        recogTextLabel.text = ""
        recogTextLabel.isHidden = true
        
        //回復recordBtn
        if gameMode == 0 {
            
            //移除按鈕target
            for btn in allBtns {
                
                btn.removeTarget(nil, action: nil, for: .allEvents)
            }
            
            recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
      
        }
        
        //輸入重置
        sentenceLabel.text = ""
        chiSentenceLabel.text = ""
        
    }
    
    @objc func notifyBackToSpell(){
        
        //隱藏錄音字欄位
        recogTextLabel.text = ""
        
        recogTextLabel.isHidden = true
   
        recordBtn.isHidden = true
        
    }
    
    
    @objc func notifySendUnlockStatus(){
        print("sending isunlock status")
    }
    
    
    //result畫面
    @objc func leaveGame(_ notification: NSNotification){
        
        if gameMode == 0 {
            limitTimer.invalidate()
            UserDefaults.standard.set(limitSeconds, forKey: "limitSeconds")
        }
        
        playSoundBtn.isEnabled = false
        
        coverBtn.isHidden = false
        coverBg.isHidden = false
        resultBg.isHidden = false
        resultTitleImg.isHidden = false
        
        firstWordBtn.isHidden = false
        secondWordBtn.isHidden = false
        thirdWordBtn.isHidden = false
        bigOkBtn.isHidden = false
        bigOkBtn.isEnabled = false
        
        firstWordBtn.isEnabled = true
        secondWordBtn.isEnabled = true
        thirdWordBtn.isEnabled = true

        var wrongWordsCount = 0
        
        if let engWords = notification.userInfo?["engWords"] as? [String]{
            if let chiWords = notification.userInfo?["chiWords"] as? [String]{
                if let score = notification.userInfo?["score"] as? [String] {
                    if let results = notification.userInfo?["correctResults"] as? [String]{
                        if let popQuizRight = notification.userInfo?["popQuizRight"] as? [String]{
                            if let wrongChinese = notification.userInfo?["wrongChinese"] as? [String]{
                                if let wrongWords = notification.userInfo?["wrongWords"] as? [String]{
                                    
                                    //指定好第一次玩家的數字
                                    wrongWordsToSend = wrongWords
                                    scoresToSend = Int(score[0])!
                                    
                                    for i in 0 ..< wrongChinese.count{
                                        
                                        if wrongChinese[i] == "1" {
                                            
                                            wrongChineseCounts += 1
                                        }
                                    }
                                    
                                    for i in 0 ..< results.count{
                                        
                                        if results[i] == "1"{
                                            wordBtns[i].setImage(UIImage(named:"wrongWordBtn.png"), for: .normal)
                                            
                                            wrongWordsCount += 1
                                            
                                        } else {
                                            wordBtns[i].setImage(UIImage(named:"rightWordBtn.png"), for: .normal)
                                            
                                        }
                                    }
                                    
                                    //抓字
                                    firstEngWordText = engWords[0]
                                    secondEngWordText = engWords[1]
                                    thirdEngWordText = engWords[2]
                                    
                                    //做分數動畫+ 單字動畫
                                    
                                    if let originalScore = user?["score"] as? Int{
                                        
                                        originalPoints = Int(originalScore)
                                        
                                        scoreLabel.text = String(originalPoints)
                                        
                                    } else {
                                        //第一次玩的人

                                        scoreLabel.text = "0"
                                  
                                    }

                                    moveUpAnimation(label: firstEngWord, text: firstEngWordText)
                                    
                                    moveUpAnimation(label: secondEngWord, text: secondEngWordText)
                                    
                                    moveUpAnimation(label: thirdEngWord, text: thirdEngWordText)
                                    
                                    
                                    moveUpAnimation(label: firstChiWord, text: chiWords[0])
                                    
                                    moveUpAnimation(label: secondChiWord, text: chiWords[1])
                                    
                                    moveUpAnimation(label: thirdChiWord, text: chiWords[2])
                                    
                                    
                                    //popQuiz bonus加分
                                    if isReplay || isUnlocked{
                                        
                                        scoreLabel.text = gameVC_reviewNoScore
                                        wordCountLabel.text = "3"
                                        bigOkBtn.isEnabled = true
                                    } else {
                                    switch popQuizRight[0]{
                                        
                                    case "-1":
                      
                                        bigOkBtn.isEnabled = true
                                        countScore(score:Int(score[0])!)
                                        
                                    case "0":
                           
                                        bonusAnimation(repeatCount:1)
                                        
                                        countScore(score: Int(score[0])! + 500)
                                        
                                        
                                        
                                    case "1":
            
                                        bonusAnimation(repeatCount:2)
                                        
                                        countScore(score: Int(score[0])! + 1000)
                                        
                                        
                                    case "2":
                                        
                                        bonusAnimation(repeatCount:3)
                                        
                                        countScore(score: Int(score[0])! + 1500)
                                    default:
                                        break
                                    }
                                        
                                        //如果有錯就不算過關的條件
                                        // if wrongWordsCount == 0 {}
                                        
                                        //目前這裡就先寫成都可以過關
                                        
                                        
                                        if user != nil {  // 要保留給第一次進入的玩家
   
                                            //紀錄關卡
                                            if unitNumber == 9{         //代表過一整個課程
                                                
                                                //此探索點已過完, 此探索點要做動態化  ----中級為 14
                                                //MARK: simVer 要動態話SpotNum
                                                

                                                //MARK: simVer 要取代掉動態的最大值改到這裡...
                                                
                                                if spotNumber == maxSpot - 1 {
                                                    
                                                    //確認是否為最後一張地圖, 這裏不會有K12的情形發生因為k12 mapPassedInt最大只有1, 不會相等
                                                    if mapPassedInt == maxMapNum{
                                                        
                                                        // 破關訊息
                                                    
                                                        isCelebratingClassPassed = true
                                                           var btnImgStr = String()
                                                        
                                                        if lan == "zh-Hans"{
                                                            btnImgStr = "classFinishedBtnSim.png"
                                                        } else {
                                                            btnImgStr = "classFinishedBtn.png"
                                                            
                                                        }
                                                        bigOkBtn.setImage(UIImage(named:btnImgStr), for: .normal)
                                                        
                                                    } else if courseReceived == 5 {
                                                        
                                                        isCelebratingMapPassed = true
                                                        bigOkBtn.setImage(UIImage(named:"k12PassedBtnSim.png"), for: .normal)
                                                        
                                                    } else {
                                                        isCelebratingMapPassed = true
                                                       
                                                           var btnImgStr = String()
                                                        if lan == "zh-Hans"{
                                                            btnImgStr = "unlockOkBtnSim.png"
                                                        } else {
                                                            btnImgStr = "unlockOkBtn.png"
                                                        }
                                                        bigOkBtn.setImage(UIImage(named:btnImgStr), for: .normal)
                                                        
                                                    }
                                                    
                                                    //MARK: simVer 這裡如果有超過的話要加 以下所有的狀態就要加 done
                                                    //MARK: must update
                                                    switch courseReceived{
                                                        
                                                    case 0:
                                                        mapPassed! += 1
                                                        gamePassed = [0:0]
                                                        
                                                        //設定給全部值供上傳後端
                                                        mapPassedInt = mapPassed!
                                                        gamePassedDic = gamePassed
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed!)
                                                        
                                                        UserDefaults.standard.set(mapPassed!, forKey: "mapPassed")
                                                        userDefaults.set(encodedObject, forKey: "gamePassed")
                                                        

                                                        
                                                    case 1:
                                                        mapPassed2! += 1
                                                        gamePassed2 = [0:0]
                                                        
                                                        
                                                        //設定給全部值供上傳後端
                                                        mapPassedInt = mapPassed2!
                                                        gamePassedDic = gamePassed2
                                                        
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed2!)
                                                        UserDefaults.standard.set(mapPassed2!, forKey: "mapPassed2")
                                                        userDefaults.set(encodedObject, forKey: "gamePassed2")

                                                        
                                                    case 2:
                                                        mapPassed3! += 1
                                                        gamePassed3 = [0:0]
                                                        
                                                        
                                                        //設定給全部值供上傳後端
                                                        mapPassedInt = mapPassed3!
                                                        gamePassedDic = gamePassed3
                                                        
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed3!)
                                                        UserDefaults.standard.set(mapPassed3!, forKey: "mapPassed3")
                                                        userDefaults.set(encodedObject, forKey: "gamePassed3")

                                                        
                                                    case 3:
                                                        mapPassed4! += 1
                                                        gamePassed4 = [0:0]
                                                        
                                                        //設定給全部值供上傳後端
                                                        mapPassedInt = mapPassed4!
                                                        gamePassedDic = gamePassed4
                                                        
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed4!)
                                                        UserDefaults.standard.set(mapPassed4!, forKey: "mapPassed4")
                                                        userDefaults.set(encodedObject, forKey: "gamePassed4")
          
                                                        
                                                    case 4:
                                                        mapPassed5! += 1
                                                        gamePassed5 = [0:0]
                                                        
                                                        //設定給全部值供上傳後端
                                                        mapPassedInt = mapPassed5!
                                                        gamePassedDic = gamePassed5
                                                        
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed5!)
                                                        UserDefaults.standard.set(mapPassed5!, forKey: "mapPassed5")
                                                        userDefaults.set(encodedObject, forKey: "gamePassed5")
                                                        
                                                    case 5:
                                                        
                                                        //MARK: simVer K12特別作法
                                                        // *** 在此mapPassed == 1 代表已經過關 ***
                                                        k12MapPassed[mapNumber] = 1
                                                        k12GamePassed[mapNumber] = [0:0]
                                                        
                                                        //mapPassed6! += 1
                                                        //gamePassed6 = [0:0]
                                                        
                                                        //設定給全部值供上傳後端
//                                                        mapPassedInt = mapPassed6!
//                                                        gamePassedDic = gamePassed6
                                                        mapPassedInt =  k12MapPassed[mapNumber]
                                                        gamePassedDic = k12GamePassed[mapNumber]

                                                        
                                                        print("ready to save: \(k12MapPassed)")
                                                        print("ready to save: \(k12GamePassed)")
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: k12GamePassed)
                                                        UserDefaults.standard.set(k12MapPassed, forKey: "mapPassed6")
                                                        userDefaults.set(encodedObject, forKey: "gamePassed6")

                                                    case 6:
                                                        mapPassed7! += 1
                                                        gamePassed7 = [0:0]
                                                        
                                                        //設定給全部值供上傳後端
                                                        mapPassedInt = mapPassed7!
                                                        gamePassedDic = gamePassed7
                                                        
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed7!)
                                                        UserDefaults.standard.set(mapPassed7!, forKey: "mapPassed7")
                                                        userDefaults.set(encodedObject, forKey: "gamePassed7")
                                                        

                                                    case 7:
                                                        mapPassed8! += 1
                                                        gamePassed8 = [0:0]
                                                        
                                                        //設定給全部值供上傳後端
                                                        mapPassedInt = mapPassed8!
                                                        gamePassedDic = gamePassed8
                                                        
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed8!)
                                                        UserDefaults.standard.set(mapPassed8!, forKey: "mapPassed8")
                                                        userDefaults.set(encodedObject, forKey: "gamePassed8")
                                                        

                                                    case 8:
                                                        mapPassed9! += 1
                                                        gamePassed9 = [0:0]
                                                        
                                                        //設定給全部值供上傳後端
                                                        mapPassedInt = mapPassed9!
                                                        gamePassedDic = gamePassed9
                                                        
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed9!)
                                                        UserDefaults.standard.set(mapPassed9!, forKey: "mapPassed9")
                                                        userDefaults.set(encodedObject, forKey: "gamePassed9")
                                                        
                                                        
                                                    default:
                                                        break
                                                        
                                                    }
                                                    
                                                } else {
                                                    
                                                    
                                                    switch courseReceived{
                                                        
                                                    case 0:
                                                        
                                                        gamePassed = [spotNumber + 1:0]
                                                        //設定給全部值供上傳後端
                                                        gamePassedDic = gamePassed
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed!)
                                                        
                                                        userDefaults.set(encodedObject, forKey: "gamePassed")
                                                        
                                                        
                                                    case 1:
                                                        
                                                        gamePassed2 = [spotNumber + 1:0]
                                                        //設定給全部值供上傳後端
                                                        gamePassedDic = gamePassed2
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed2!)
                                                        
                                                        userDefaults.set(encodedObject, forKey: "gamePassed2")
      
                                                    case 2:
                                                        
                                                        gamePassed3 = [spotNumber + 1:0]
                                                        //設定給全部值供上傳後端
                                                        gamePassedDic = gamePassed3
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed3!)
                                                        
                                                        userDefaults.set(encodedObject, forKey: "gamePassed3")
                                                        
                                                    case 3:
                                                        
                                                        gamePassed4 = [spotNumber + 1:0]
                                                        //設定給全部值供上傳後端
                                                        gamePassedDic = gamePassed4
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed4!)
                                                        
                                                        userDefaults.set(encodedObject, forKey: "gamePassed4")
                                                        
                                                    case 4:
                                                        
                                                        gamePassed5 = [spotNumber + 1:0]
                                                        //設定給全部值供上傳後端
                                                        gamePassedDic = gamePassed5
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed5!)
                                                        
                                                        userDefaults.set(encodedObject, forKey: "gamePassed5")
                                                        
                                                    case 5:
                                                        
                                                        k12GamePassed[mapNumber] = [spotNumber + 1:0]
                                                        //設定給全部值供上傳後端
                                                        gamePassedDic = k12GamePassed[mapNumber]
                                                        
//                                                        gamePassed6 = [spotNumber + 1:0]
//                                                        //設定給全部值供上傳後端
//                                                        gamePassedDic = gamePassed6
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: k12GamePassed)
                                                        
                                                        userDefaults.set(encodedObject, forKey: "gamePassed6")

                                                    case 6:
                                                        
                                                        gamePassed7 = [spotNumber + 1:0]
                                                        //設定給全部值供上傳後端
                                                        gamePassedDic = gamePassed7
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed7!)
                                                        
                                                        userDefaults.set(encodedObject, forKey: "gamePassed7")

                                                    case 7:
                                                        
                                                        gamePassed8 = [spotNumber + 1:0]
                                                        //設定給全部值供上傳後端
                                                        gamePassedDic = gamePassed8
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed8!)
                                                        
                                                        userDefaults.set(encodedObject, forKey: "gamePassed8")

                                                    case 8:
                                                        
                                                        gamePassed9 = [spotNumber + 1:0]
                                                        //設定給全部值供上傳後端
                                                        gamePassedDic = gamePassed9
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed9!)
                                                        
                                                        userDefaults.set(encodedObject, forKey: "gamePassed9")
             
                                                    default:
                                                        break
                                                        
                                                    }
                                                    
                                                }
                                                
                                            }else {
                                                
                                                
                                                switch courseReceived{
                                                    
                                                case 0:
                                                    
                                                  
                                                    gamePassed = [spotNumber: unitNumber + 1]
                                                    gamePassedDic = gamePassed
                                                    
                                                    //然後儲存
                                                    let userDefaults = UserDefaults.standard
                                                    let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed!)
                                                    
                                                    userDefaults.set(encodedObject, forKey: "gamePassed")
                                                    let savedNumber = userDefaults.object(forKey: "gamePassed")
                                                    print("saved number:\(savedNumber)")
                                                    
                                                    
                                                case 1:
                                                    
                                                    gamePassed2 = [spotNumber: unitNumber + 1]
                                                    gamePassedDic = gamePassed2
                                                    
                                                    //然後儲存
                                                    let userDefaults = UserDefaults.standard
                                                    let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed2!)
                                                    
                                                    userDefaults.set(encodedObject, forKey: "gamePassed2")
                                                    
                                                    
                                                case 2:
                                                    
                                                    gamePassed3 = [spotNumber: unitNumber + 1]
                                                    gamePassedDic = gamePassed3
                                                    
                                                    //然後儲存
                                                    let userDefaults = UserDefaults.standard
                                                    let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed3!)
                                                    
                                                    userDefaults.set(encodedObject, forKey: "gamePassed3")

                                                    
                                                case 3:
                                                    
                                                    gamePassed4 = [spotNumber: unitNumber + 1]
                                                    gamePassedDic = gamePassed4
                                                    
                                                    //然後儲存
                                                    let userDefaults = UserDefaults.standard
                                                    let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed4!)
                                                    
                                                    userDefaults.set(encodedObject, forKey: "gamePassed4")
      
                                                case 4:
                                                    
                                                    gamePassed5 = [spotNumber: unitNumber + 1]
                                                    gamePassedDic = gamePassed5
                                                    
                                                    //然後儲存
                                                    let userDefaults = UserDefaults.standard
                                                    let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed5!)
                                                    
                                                    userDefaults.set(encodedObject, forKey: "gamePassed5")

                                                case 5:

                                                    k12GamePassed[mapNumber] = [spotNumber: unitNumber + 1]
                                                    gamePassedDic = k12GamePassed[mapNumber]
//                                                    gamePassed6 = [spotNumber: unitNumber + 1]
//                                                    gamePassedDic = gamePassed6
                                                    
                                                    //然後儲存
                                                    let userDefaults = UserDefaults.standard
                                                    let encodedObject = NSKeyedArchiver.archivedData(withRootObject: k12GamePassed)
                                                    
                                                    userDefaults.set(encodedObject, forKey: "gamePassed6")
       
                                                case 6:
                                                    
                                                    gamePassed7 = [spotNumber: unitNumber + 1]
                                                    gamePassedDic = gamePassed7
                                                    
                                                    //然後儲存
                                                    let userDefaults = UserDefaults.standard
                                                    let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed7!)
                                                    
                                                    userDefaults.set(encodedObject, forKey: "gamePassed7")
       
                                                case 7:
                                                    
                                                    gamePassed8 = [spotNumber: unitNumber + 1]
                                                    gamePassedDic = gamePassed8
                                                    
                                                    //然後儲存
                                                    let userDefaults = UserDefaults.standard
                                                    let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed8!)
                                                    
                                                    userDefaults.set(encodedObject, forKey: "gamePassed8")

                                                case 8:
                                                    
                                                    gamePassed9 = [spotNumber: unitNumber + 1]
                                                    gamePassedDic = gamePassed9
                                                    
                                                    //然後儲存
                                                    let userDefaults = UserDefaults.standard
                                                    let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed9!)
                                                    
                                                    userDefaults.set(encodedObject, forKey: "gamePassed9")
                                                    
                                                default:
                                                    break
                                                    
                                                }
                                                
                                            }
                                            
                                            countWords()
                                            
                                        } else {
                                            
                                            
                                            //顯示出來
                                            wordCountLabel.text = "3"
                                            
                                            
                                        }

                                        
                                    }
                                    
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "playEndingMusic"), object: nil, userInfo: nil)
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    

    
    func countScore(score:Int){
        
        let scoreToPass:[String:Int] = ["Score":score]

        countScoreTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(NewGameViewController.startCounting), userInfo: scoreToPass, repeats: true)
        
    }
    
    
    @objc func startCounting(){
        

        if let userInfo = countScoreTimer.userInfo as? Dictionary<String, Int>{
     
            if let scoreToAdd = userInfo["Score"]{

                if scoreAdded < scoreToAdd {
         
                    scoreAdded += 50
                    scoreLabel.text = String(Int(scoreLabel.text!)! + 50)
                } else {
      
                    scoreAdded = 0
                    countScoreTimer.invalidate()
                    
                    //加完分後直接上傳
                    bigOkBtn.isEnabled = true

                }
                
            }
        }
    }
    
    //MARK: must update
    func countWords(){
        //計算所有字數
        //print("enter word count")
        var unitMaxWordCount = Int()
        
        var wordsCounts = Int()
        
        //MARK: simVer 這裡的450要做成動態化, 單位最大值要拉出來做, 並且加入K12特別作法
        //print(maxSpot)
        
        unitMaxWordCount = maxSpot * 30
        //print("after unitMaxWordCount done")
        
        
        if courseReceived == 5 {
            
            var k12ElemWordsMax = [120,330,330,300,330,330,330,330,390,390,330,330,210,330,300,180,390,390]
            
            //k12
            for i in 0 ..< k12MapPassed.count {
                
                if k12MapPassed[i] == 1 {
                    
                    wordsCounts += k12ElemWordsMax[i]
                    
                } else {
                    
                    //eachCellMyWordsCount[i] =
                    
                    for (s,u) in k12GamePassed[i] {
                        
                        wordsCounts += s * 30 + u * 3
                    }
                    
                    
                }
            }

            
            
        } else {
            
            wordsCounts += mapPassedInt * unitMaxWordCount
            
            
            for (s,u) in gamePassedDic!{
                
                wordsCounts += s * 30 + u * 3
                
            }

        }
        

        
        //顯示出來
        wordCountLabel.text = String(wordsCounts)
        
    }
    
    @IBAction func firstWordClicked(_ sender: Any) {
        
        if user != nil {
 
                addWord(word: firstEngWordText)
                moveUpAndGone(label: word1Label)
        } else {
            
            moveUpAndGone(label: word1Label)
        }
        
    }
    @IBAction func secondWordClicked(_ sender: Any) {
        
        if user != nil {
            

                addWord(word: secondEngWordText)
                moveUpAndGone(label: word2Label)
        } else {
            
            moveUpAndGone(label: word2Label)
        }
    }
    
    @IBAction func thirdWordClicked(_ sender: Any) {
        
        
        if user != nil {
      
                addWord(word: thirdEngWordText)
                moveUpAndGone(label: word3Label)
 
        } else {
            
            moveUpAndGone(label: word3Label)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        //isUnlocked = false
        
        let status:[String:Bool] = ["isUnlocked":isUnlocked]
        
        NotificationCenter.default.post(name: NSNotification.Name(sendUnlockStatus), object: nil, userInfo: status)
        
        
    }

    
    override func viewDidDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self)
        timer?.invalidate()
        waitTimer.invalidate()

    }
    
    
    func moveUpAnimation(label:UILabel,text:String){
        
        let labelToMove = label
        
        labelToMove.alpha = 0.3
        labelToMove.text = text
        let originY = label.frame.origin.y
        labelToMove.frame.origin.y = originY + 20
        UIView.animate(withDuration: 0.3) {
            labelToMove.alpha = 1
            labelToMove.frame.origin.y = originY
            
        }
    }
    
    
    func bonusAnimation(repeatCount:Float){
        
        
        bonusScoreLabel.alpha = 0.3
        
        bigOkBtn.isEnabled = false
        bigOkBtn.isHidden = true
        
        let originY = bonusScoreLabel.frame.origin.y
        //bonusScoreLabel.frame.origin.y = originY + 20
        
        
        //UIView.animate(withDuration: 0.3, animations: {[weak self] in
        UIView.animate(withDuration: 0.7, delay: 0.5, options: [.curveEaseIn], animations: {[weak self] in
            
            //UIView.setAnimationRepeatCount(repeatCount)
            
            self!.bonusScoreLabel.alpha = 1
            self!.bonusScoreLabel.frame.origin.y = originY - 30
            
            //self!.bonusScoreLabel.topAnchor.constraint(equalTo: self!.view.safeTopAnchor, constant: self!.height / 2 - (160 * self!.iPadDif * self!.dif)).isActive = true
            
        }) { (finished:Bool) in
            UIView.animate(withDuration: 0, delay: 0.5, options: .curveEaseIn, animations: {[weak self] in
                
                self!.bonusScoreLabel.alpha = 0
                
                }, completion: {[weak self] (true) in
                    
                 self!.bonusScoreLabel.frame.origin.y = originY
                    
               //self!.bonusScoreLabel.topAnchor.constraint(equalTo: self!.view.safeTopAnchor, constant: self!.height / 2 - (190 * self!.iPadDif * self!.dif)).isActive = true
              
                    self!.bigOkBtn.isHidden = false
                    
                    self!.bigOkBtn.isEnabled = true
                    
            })
        }
        
        
        
        
        
        
        
    }
    
    func moveUpAndGone(label:UILabel){
        
        let labelToMove = label
        labelToMove.alpha = 1
        
        UIView.animate(withDuration: 0.7, animations: {
            labelToMove.alpha = 0
            labelToMove.frame.origin.y = -20
        }) { (true) in
            labelToMove.frame.origin.y = 0
        }
    }
    
    //MARK: recognize voice
    
    //開始辨識聲音
    @objc func startToRecognize(){
        //顯示按鈕, 顯示label
        recordBtn.isHidden = false
        
        skipPronounceBtn.isHidden = false
        
        recogTextLabel.isHidden = false
        
        //回復錄音輸入的單字或句子
        wordRecorded = String()
        
        //對字
//        isCheckingSentence = false
        
        //指定答案的字
        //MARK: simVer 這裡要避免wrong pronounceWord, synWord可能已經被取代掉了
        //所有的變數要改成另一個
        
        //wordToReceive = synWord

        
        //移除標點符號
        //wordToReceive = wordToReceive.removingCharacters(inCharacterSet: CharacterSet.punctuationCharacters)
        
        originalWordToRecognize = originalWordToRecognize.removingCharacters(inCharacterSet: CharacterSet.punctuationCharacters)

        
        //改成小寫
        originalWordToRecognize = originalWordToRecognize.lowercased()
        
        hintLabel.text = gameVC_pleasePressMic
        
        
    }
    
    
    
    var pronounceTime = Int()
    
    @objc func pronounceWord(_ notification: NSNotification){
        
        //一定要指定要說幾次
        guard let speakTime = notification.userInfo?["pronounceTime"] as? Int else{
            return
        }
        pronounceTime = speakTime
        
        //要發音的單字或句子可有可無
        if let wordToPronunce = notification.userInfo?["wordToPass"] as? String {
            
            //設訂發音的單字, 避免synWord又被取代掉所以新增一個變數
            synWord = wordToPronunce
            originalWordToRecognize = wordToPronunce
            
            //確認是否有別的發音
            
            //抓發音錯誤字集
            for i in 0 ..< wrongPronounceWords.count{
                
                for (word,rightWord) in wrongPronounceWords[i]{
                    
                    //假如有抓到的話
                    if word == wordToPronunce{
                    
                        synWord = rightWord[0]
                        
                    }
                    
                }
                
            }
            
        }
        //發音
        
        synPronounce()
    }
    
    @objc func notifyStartCountDown(){
        
        
    }
    
    //按鈕
    @IBAction func recordClicked(_ sender: Any) {
        
        
        skipPronounceBtn.isEnabled = false
        
        //停止
        if audioEngine.isRunning {
            
            //避免再次快速按
            recordBtn.isEnabled = false
            
            //wave 消失停止
            audioView.isHidden = true
            timer?.invalidate()
            
            //更改Btn圖示為待錄音
            recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
            
            //停止動畫
            recordingIndicator?.stopAnimating()
            
            
            //停止辨識
            
            audioEngine.stop()
            recognitionRequest?.endAudio()
            recognitionTask?.cancel()
            
            playSoundBtn.isEnabled = true
            
            //檢查答案, 句子/單字
//            if isCheckingSentence{
//
//                //檢查 以下的func已經不用了
//                //self.checkSentence()
//
//                //隱藏Btn, 以便顯示句子得分的img
//                recordBtn.isHidden = true
//
//            } else {
//
//
//            }
                      self.checkWord()
            
        }  else {
            
            
            hintLabel.text = gameVC_pleasePronounce
            
            
            
            //btn圖案更改成錄音
            recordBtn.setImage(UIImage(named:"recordingBtn.png"), for: .normal)
            
            //siriWave
            audioView.isHidden = false
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 0.009, target: self, selector: #selector(NewGameViewController.refreshAudioView(_:)), userInfo: nil, repeats: true)
            
            //錄音動畫開啟
            recordingIndicator?.startAnimating()
            
            //如果Task還在, 就取消task 等待再次開啟
            if recognitionTask != nil {
                recognitionTask?.cancel()
                recognitionTask = nil
            }
            
            //抓目前單字的相關字
            var relWordsFound = [String]()
            
            
            //MARK: 找相關字也要改掉變數
            for new in newRels {
                
                let keyArray = new.components(separatedBy: ":")
                if keyArray[0].replacingOccurrences(of: " ", with: "") ==  originalWordToRecognize{
                    
              
                    let rels = keyArray[1].components(separatedBy: ", ")
                    for r in rels{
                        
                        relWordsFound.append(r)
                    }
                }

            }
            
            //print(relWordsFound)
            
            //開始辨識
            
            
            do {
                
                try audioSession.setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.record)), mode: .default)
                
                try audioSession.setMode(AVAudioSession.Mode.measurement)
                try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
                
                
                if let inputNode = audioEngine.inputNode as AVAudioInputNode?{
                    
                    recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
                    
                    guard let recognitionRequest = recognitionRequest else {
                        fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
                    }
                    
                    recognitionRequest.shouldReportPartialResults = true
                    
                    self.recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: {[weak self] (result, error) in
                        
                        
                        if let result = result {
                            
                            if let resultWord = result.bestTranscription.formattedString.lowercased() as String?{
                                
                                self!.recogTextLabel.font = self!.recogTextLabel.font.withSize(self!.chiSentenceFontSize * 2)
                                self!.hintLabel.text = self!.gameVC_pressMicAgain
                                
                                
                                if relWordsFound.count != 0 {
                                    if relWordsFound.contains(resultWord){
                                              self!.recogTextLabel.text = self!.originalWordToRecognize
                                        
                                    } else {
                                        
                                        self!.recogTextLabel.text = resultWord
                                    }
                                } else {
                                    
                                    self!.recogTextLabel.text = resultWord
                                    
                                }
                                
                            }
                            
                            //對答案的部分要修掉標點符號
                            self!.wordRecorded = self!.recogTextLabel.text!.removingCharacters(inCharacterSet: CharacterSet.punctuationCharacters)
                            
                            
                            if result.isFinal {
                                
                                self!.audioEngine.stop()
                                inputNode.removeTap(onBus: 0)
                                
                                //移除掉Request避免Reuse
                                self!.recognitionRequest = nil
                                self!.recognitionTask = nil
                                
                 
                            }
                            
                        }
                        
                    })
                    
                    let recordingFormat = inputNode.outputFormat(forBus: 0)
                    
                    //先移除之前的
                    inputNode.removeTap(onBus: 0)
                    inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat, block: {[weak self] (buffer, when) in
                        
                        self!.recognitionRequest?.append(buffer)
                        
                    })
                    
                    audioEngine.prepare()
                    try audioEngine.start()
                    
                    //開啟錄音
                    playSoundBtn.isEnabled = false
                }
                
                
            } catch {
                
                //Handle error
                
            }
            
        }
        
    }
    
    
    
    //假如沒有辦法錄音就要啟動認證
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        
        if available{
            
            
        } else {
            //重新啟動認證
            
        }
    }
    
    //準備離開遊戲
    @IBAction func okBtnClicked(_ sender: Any) {
        
        //在此確認是否已過地圖的確認
        
        
        if isReplay || isUnlocked{
            
            self.dismiss(animated: true, completion: nil)
            
        } else {
        
        
        if user != nil {
            
            switch senRate{
                
            case 0:
                senRate = 0
            case 1:
                senRate = 33
            case 2:
                senRate = 66
            case 3:
                senRate = 100
            default:
                break
            }
            
            switch proRate{
                
            case 0:
                proRate = 0
            case 1:
                proRate = 33
            case 2:
                proRate = 66
            case 3:
                proRate = 100
            default:
                break
            }
            
            
            let updatePoints = Int(scoreLabel.text!)! - originalPoints
            
            //單機版更新法
            
            if let score = user?[kScore] as! Int?{
                if score == 200 {
  
                    
                    let copyUser = user?.mutableCopy() as! NSMutableDictionary
                    
                    copyUser.setValue(updatePoints, forKey: kScore)
                    copyUser.setValue(wrongChineseCounts, forKey: kWrongChinese)
                    copyUser.setValue(proRate, forKey: kProRate)
                    copyUser.setValue(senRate, forKey: kSenRate)
//                    copyUser[kScore] = updatePoints
//                    copyUser[kWrongChinese] = wrongChineseCounts
//                    copyUser[kProRate] = proRate
//                    copyUser[kSenRate] = senRate
                    
                    user = copyUser
                    userDefaults.set(user, forKey: "parseJSON")
                    
                } else {
                    
                    let oldScore = user?.object(forKey: kScore) as! Int
                    let newScore = oldScore + updatePoints
                    
                    let oldWrongChinese = user?.object(forKey: kWrongChinese) as! Int
                    let newWrongChinese = oldWrongChinese + wrongChineseCounts
                    
                    var oldProRate = user?.object(forKey: kProRate) as! Int
                    if oldProRate == 200 {
                       oldProRate = 0
                    }
                    let newProRate = (oldProRate + proRate) / 2
                    
                    var oldSenRate = user?.object(forKey: kSenRate) as! Int
                    if oldSenRate == 200 {
                        oldSenRate = 0
                    }
                    
                    let newSenRate = (oldSenRate + senRate) / 2
               
                    let copyUser = user?.mutableCopy() as! NSMutableDictionary
                    
                    copyUser.setValue(newScore, forKey: kScore)
                    copyUser.setValue(newWrongChinese, forKey: kWrongChinese)
                    copyUser.setValue(newProRate, forKey: kProRate)
                    copyUser.setValue(newSenRate, forKey: kSenRate)
                    
                    user = copyUser
                    userDefaults.set(user, forKey: "parseJSON")

                }
                
            }
            
//            updateScore(score:updatePoints, wrongWordsCount:wrongChineseCounts, proRate:proRate, senRate:senRate)
            
            
            if isCelebratingClassPassed {
                
                
                //dimiss掉兩個VCs
                self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                
                
                //一個恭喜訊息
                
            } else if isCelebratingMapPassed{
                
                //dimiss掉兩個VCs
                self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                
            } else {
                

                self.dismiss(animated: true, completion: nil)
                
                
            }
            
            }
//             else {
//            //第一次嘗試玩
//
//            //print("first time play")
//
//            //註冊畫面
//
//            performSegue(withIdentifier: "toRegisterVc", sender: self)
//
//        }
        
        
        
        }
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
//
//        if segue.identifier == "toRegisterVc" {
//
//            let registerVc = segue.destination as! RegisterViewController
//
//            //MARK: simVer K12 必須多傳送mapNumber去紀錄玩第幾關
//            registerVc.k12MapNumber = mapNumber
//
//            registerVc.coursePlayed = courseReceived
//            registerVc.wrongWordsToAdd = wrongWordsToSend
//            registerVc.scoresToAdd = scoresToSend
//            registerVc.proRateToAdd = proRate
//            registerVc.senRateToAdd = senRate
//            registerVc.wrongChineseCount = wrongChineseCounts
//
//
//        } else
        if segue.identifier == "fromGameToPurchase"{
        
            
            let purchaseVc = segue.destination as! PurchaseViewController
            
            purchaseVc.isDirectedFromGame = true
            purchaseVc.modalPresentationStyle = .fullScreen
            
            if #available(iOS 13.0, *) {
                purchaseVc.isModalInPresentation = false
            } else {
                // Fallback on earlier versions
            }
            
        }
        
        
    }
    
    //檢查句子
    
    //這裡的func 已經用不到了...
//
//    func checkSentence(){
//        print("trigger check sentence")
//        var attrSentence = NSMutableAttributedString()
//
//        let attrs0 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 35), NSAttributedStringKey.foregroundColor : UIColor.white]
//        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 35), NSAttributedStringKey.foregroundColor : UIColor.magenta]
//
//        var recorded = [String]()
//        var received = [String]()
//        var completeWords = [String]()
//
//        recorded = wordRecorded.components(separatedBy: " ")
//        received = wordToReceive.components(separatedBy: " ")
//        completeWords = completeWordsToShow.components(separatedBy: " ")
//
//
//        //寫一個對答案比例的func
//        var finalPoints = Int()
//        let unitPoint = 100 / received.count
//        var pointGet = Int()
//        var pointMinus = Int()
//
//        //計分算法, 基本上還是要按照順序來計算
//        if recorded == received{
//
//            finalPoints = 100
//
//        } else {
//
//            for i in 0 ..< received.count{
//
//
//                if i < recorded.count{
//                    if recorded[i] == received[i]{
//                        if i == 0 {
//
//                            attrSentence = NSMutableAttributedString(string: completeWords[i] + " ", attributes: attrs0)
//                        } else {
//
//                            attrSentence.append(NSMutableAttributedString(string: completeWords[i] + " ", attributes: attrs0))
//                        }
//
//                    } else {
//
//                        if i == 0 {
//
//                            attrSentence = NSMutableAttributedString(string: completeWords[i] + " ", attributes: attrs1)
//                        } else {
//
//                            attrSentence.append(NSMutableAttributedString(string: completeWords[i] + " ", attributes: attrs1))
//                        }
//                    }
//                } else {
//
//
//                    if i == 0 {
//
//                        attrSentence = NSMutableAttributedString(string: completeWords[i] + " ", attributes: attrs1)
//                    } else {
//
//                        attrSentence.append(NSMutableAttributedString(string: completeWords[i] + " ", attributes: attrs1))
//                    }
//                }
//
//                for r in 0 ..< recorded.count{
//
//                    if recorded[r] == received[i]{
//
//                        //假如有字對到
//
//                        pointGet += 1
//
//                    }
//
//                }
//
//            }
//
//            //顯示label字的正確與否 用顏色分辨
//            recogTextLabel.attributedText = attrSentence
//
//            //避免分數超過
//            if pointGet > received.count{
//                pointGet = received.count
//            }
//
//            finalPoints = pointGet * unitPoint
//        }
//
//        //如果輸入的字更多要扣分
//        if recorded.count > received.count{
//
//            pointMinus = recorded.count  - received.count
//            finalPoints = finalPoints - pointMinus * unitPoint / 2
//
//            if finalPoints < 0 {
//                finalPoints = 0
//            }
//
//        }
//
//
//
//        //計算分數
//        var score = Int()
//        score = 500 * finalPoints / 100
//
//        //卡一下顯示分數
//        //之後可以改變分數高低不同的img顏色
//
//        let pointImg = UIImageView()
//        let pointLabel = UILabel()
//
//        pointImg.frame = CGRect(x: recordBtn.frame.origin.x, y: recordBtn.frame.origin.y, width: recordBtn.frame.width, height: recordBtn.frame.height)
//        pointImg.image = UIImage(named: "pointImg.png")
//        self.view.addSubview(pointImg)
//
//        pointLabel.frame = CGRect(x: 0, y: recordBtn.frame.height / 3.5, width: recordBtn.frame.width, height: 60)
//        pointLabel.backgroundColor = .clear
//        pointLabel.textColor = .white
//        pointLabel.font = UIFont(name: "Helvetica Bold", size: 40)
//        pointLabel.textAlignment = .center
//        pointLabel.text = "\(finalPoints)%"
//        pointImg.addSubview(pointLabel)
//
//        //pointsIndicator?.startAnimating()
//
//        //隱藏recordBtn
//        //recordBtn.isHidden = true
//
//        //讓分數停留一下後再消失
//        let when = DispatchTime.now() + 1.5
//
//        //接著做選擇題, 所有顯示的func都包在下方
//        DispatchQueue.main.asyncAfter(deadline: when) {[weak self] in
//
//            pointImg.removeFromSuperview()
//
//            //            self!.pointsIndicator?.stopAnimating()
//
//            //製作tags
//            self!.sentenceTag = self!.sentence.components(separatedBy: " ")
//
//
//            self!.sentenceTag.shuffled()
//
//
//            //在此可以決定句子有多少個字
//
//            if self!.sentenceTag.count > 10 {
//                //10個字以上
//
//
//
//            } else {
//
//
//            }
//
//
//            print("製作句子 check sentence")
//
//
//
//            for i in 0 ..< self!.sentenceTag.count{
//
//                self!.tagView.addTag(self!.sentenceTag[i] + " " + String(i))
//
//
//
//            }
//
//
//            //self!.tagView.addTags(self!.sentenceTag)
//
//
//            //準備選擇題
//            self!.sentenceLabel.text = ""
//
//            //算分數 + 啟動tag的機制 (目前修正成nc去啟動倒數）
//            let addScore:[String:Int] = ["addScore":score,"finalPoints":finalPoints]
//
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addScore"), object: nil, userInfo: addScore)
//
//            //給暫停使用的
//            // self!.isCountingTriggered = true
//
//            //隱藏輸入字
//            self!.recogTextLabel.text = ""
//
//            //顯示出tag
//            self!.tagView.isHidden = false
//
//            //避免再次產生hint
//            self!.isCheckingSentence = false
//
//            //發音
//            self!.pronounceTime = 1
//
//            self!.synPronounce()
//
//
//        }
//
//
//    }
    
    
    @IBAction func skipPronunceBtnClicked(_ sender: Any) {
        
        //停止
        if audioEngine.isRunning {
        
        //避免再次快速按
        recordBtn.isEnabled = false
        
        //wave 消失停止
        audioView.isHidden = true
        timer?.invalidate()
        
        //更改Btn圖示為待錄音
        recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
        
        //停止動畫
        recordingIndicator?.stopAnimating()
        
        
        //停止辨識
        
        audioEngine.stop()
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        
        playSoundBtn.isEnabled = true
        }
        
        //辨識的字消失
        recogTextLabel.text = ""
        
        //回復顏色
        recogTextLabel.textColor = .white
        
        //隱藏Btn
        recordBtn.isHidden = true
        
        
        hintLabel.text = ""
        
        skipPronounceBtn.isHidden = true
        
        answerTime = 0
        
        let addScore:[String:Int] = ["addScore":0]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "backToSpell"), object: nil, userInfo: addScore)
    }
    
    
    func checkWord(){
        
        //正確
        
//        print("wordRecorded = \(wordRecorded)")
//        print("wordToReceive = \(wordToReceive)")
//        print("recognizeWord = \(originalWordToRecognize)")
        
//        if wordRecorded == wordToReceive{
        if wordRecorded == originalWordToRecognize{
        
            hintLabel.text = gameVC_great
            
            recordBtn.setImage(UIImage(named:"recordCheck.png"), for: .normal)
            
            isRecogWordCorrect = true
            
            //正確暫時不改顏色
            proRate += 1
            
        } else {
            
            hintLabel.text = gameVC_oopsWrong

            //錯誤
            recordBtn.setImage(UIImage(named:"recordCross.png"), for: .normal)
            
            isRecogWordCorrect = false
            
            //改變字成紅色
            self.recogTextLabel.textColor = .red
            
        }
        
        //都等一下反應, 讓user看到成功或失敗的圖示
        let when = DispatchTime.now() + 0.5
        
        DispatchQueue.main.asyncAfter(deadline: when) {[weak self] in
            
            //辨識的字消失
            self!.recogTextLabel.text = ""
            
            //回復顏色
            self!.recogTextLabel.textColor = .white
            
            if self!.isRecogWordCorrect{

                //隱藏Btn
                self!.recordBtn.isHidden = true
                
                //計分
                var score = Int()
                if self!.answerTime == 0 {

                    score = 200
                } else if self!.answerTime == 1 {
                    
                    score = 100
                    self?.answerTime = 0
                }
                
                self!.hintLabel.text = ""
                
                self!.skipPronounceBtn.isHidden = true
                
                let addScore:[String:Int] = ["addScore":score]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "backToSpell"), object: nil, userInfo: addScore)
                
                
            } else {
                
                
                if self!.answerTime < 1 {
                    
                    //可以繼續練習
                    
                    self!.hintLabel.text = self!.gameVC_tryAgain
                    
                    self!.answerTime += 1
                    
                    self!.recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
                    self!.recordBtn.isHidden = false
                    self!.recordBtn.isEnabled = true
                    
                } else {
                    //失敗跳離畫面
                    self!.answerTime = 0
                  
                    self!.skipPronounceBtn.isHidden = true
                    
                    self!.hintLabel.text = ""
                    let addScore:[String:Int] = ["addScore":0]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "backToSpell"), object: nil, userInfo: addScore)
                    
                    
                }
                
            }

            self!.skipPronounceBtn.isEnabled = true

            
        }
        
    }
    
    @objc func onlyPracticeSentence(_ notification: NSNotification){

        //抓所有句子數量來做全部的亂數
        var totalNum = Int()
        
        for s in allUnitSpotNums{
            
            for _ in s{
                
                totalNum += 1
            }
        }
        
        
        //做亂數
        for _ in 0 ..< totalNum {
            
            //新增目前能選擇的spotIndex
            let spotIndex = Int(arc4random_uniform(UInt32(allUnitSpotNums.count)))
            randomSpots.append(spotIndex)
            
            //從目前能選的spotIndex中選擇能選的unitIndex
            let unitCount = allUnitSpotNums[spotIndex].count
            let unitIndex = Int(arc4random_uniform(UInt32(unitCount)))
            randomUnits.append(allUnitSpotNums[spotIndex][unitIndex])
            
            //移除已指定給他的亂數
            
            allUnitSpotNums[spotIndex].remove(at: unitIndex)
            
            if allUnitSpotNums[spotIndex].count == 0 {
                
                allUnitSpotNums.remove(at: spotIndex)
            }
            
        }
        
        //print(randomSpots)
        //print(randomUnits)
        
        //抓到的順序為0
        if let wordSeq = notification.userInfo?["wordSequence"] as? Int {
            
            wordSequenceToReceive = String(wordSeq)
        }
        
        //做句子
        makeSentence()
        
    }
    
    
    //做句子, 傳送nc去發音
    func makeSentence(){
        
        //顯示句子文字
        
        //testing
        if gameMode == 2 {
            
            //只練習句子
            
            //英文句子
            sentence = allSentenceSets[randomSpots[Int(wordSequenceToReceive)!]][randomUnits[Int(wordSequenceToReceive)!]]
            
            let halfCount = allSentenceSets[randomSpots[Int(wordSequenceToReceive)!]].count / 2

            //中文句子
            chiSentence = allSentenceSets[randomSpots[Int(wordSequenceToReceive)!]][randomUnits[Int(wordSequenceToReceive)!] + halfCount]

            
            //製作4個中文選項Btn
            for btn in allBtns{
                btn.isHidden = false
            }

            //抓好中英文句子答案
            sentenceLabel.text = sentence
            chiSentenceLabel.text = gameVC_pleaseChooseRightChiSen

            
            //準備做四個選項
            var senBtnTitles = ["","","",""]
            
            //抓一個正確的隨機置放位置, 放中文答案進去
            correctRandom = Int(arc4random_uniform(UInt32(4)))
            senBtnTitles[correctRandom] = chiSentence

            
            //填入數字
            allRandomSens = Array(repeating: [Int:Int](), count: 4)
            
            //填入正確句子的數字
            allRandomSens[correctRandom] = [randomSpots[Int(wordSequenceToReceive)!]:randomUnits[Int(wordSequenceToReceive)!]]
            

            //設定好正確的按鈕
            allBtns[correctRandom].addTarget(self, action: #selector(NewGameViewController.rightSenButtonClicked), for: .touchUpInside)
            allBtns[correctRandom].tag = correctRandom
            
            
            //填滿其他的隨機數
            
            for i in 0 ..< 4 where i != correctRandom{
                
                //抓四個隨機數, 並且避開重複值
                allRandomSens[i] = getRandom()

                for (s,u) in allRandomSens[i] {
                    
                    //填入中文句子當作選項
                    senBtnTitles[i] = allSentenceSets[s][u + halfCount]
                    
                }
                
                //設定好其餘選項的tag
                allBtns[i].tag = i
                
                //加入到錯誤按鈕的button
                allBtns[i].addTarget(self, action: #selector(NewGameViewController.wrongSenButtonClicked), for: .touchUpInside)
                
            }
            
            
            //設定所有案件的中文內文
            for i in 0 ..< allBtns.count {
                
                
                allBtns[i].contentHorizontalAlignment = .left
                
                //allBtns[i].setTitle("   \(i + 1). " + senBtnTitles[i], for: .normal)
                
                allBtns[i].setTitle(" " + senBtnTitles[i], for: .normal)
                
            }

            
//            //避免再次產生hint
//            isCheckingSentence = false

            
        } else{
            
            /*
             //英文句子
             sentence = sentenceSets[Int(wordSequenceToReceive)!]
             let halfCount = sentenceSets.count / 2
             chiSentence = sentenceSets[halfCount + Int(wordSequenceToReceive)!]
             
             sentenceLabel.text = sentence
             
             //接著要辨認句子, 用此來讓delegate send NC給gameScene
             
             isCheckingSentence = true
             chiSentenceLabel.text = chiSentence
             
             
             //對答案用
             wordToReceive = sentence
             
             //提供顯示用的答案, 包含標點符號及大小寫
             completeWordsToShow = sentence
             
             //移除標點符號
             wordToReceive = wordToReceive.removingCharacters(inCharacterSet: CharacterSet.punctuationCharacters)
             
             //改成小寫
             wordToReceive = wordToReceive.lowercased()
             
             //準備練習句子
             //顯示按鈕, 顯示label
             
             //回復錄音輸入的單字或句子
             wordRecorded = String()
             */
            
            // newMakeSentenceTest()
            
            //只讀句子
            guidedSentence()
        }
        
        //句子發音
        synWord = sentence
        synPronounce()
    }
    
    
    var isReadingGuidedSentence = false
    
    func guidedSentence(){
        //英文句子
        
        if gameMode == 0 {
        
            sentence = sentenceSets[Int(wordSequenceToReceive)!]
        let halfCount = sentenceSets.count / 2
        
            chiSentence = sentenceSets[halfCount + Int(wordSequenceToReceive)!]
        }         //抓好中英文句子答案
        sentenceLabel.text = sentence
        chiSentenceLabel.text = chiSentence
        
        //用這個來啟動ok按鍵
        isReadingGuidedSentence = true
     
    }
    
    
    @IBAction func circleOkBtnClicked(_ sender: Any) {
        
        newMakeSentenceTest()
    }
    
    
    
    func newMakeSentenceTest(){
        
        circleOkBtn.isHidden = true
        
        synPronounce()
        
        //只練習句子
        
        //英文句子

        let halfCount = sentenceSets.count / 2
        
        
        
        //製作4個中文選項Btn
        for btn in allBtns{
            btn.isHidden = false
        }
        
        
        //抓好中英文句子答案
        
        chiSentenceLabel.text = gameVC_pleaseChooseRightChiSen
        
        
        //準備做四個選項
        var senBtnTitles = ["","","",""]
        
        //抓一個正確的隨機置放位置, 放中文答案進去
        correctRandom = Int(arc4random_uniform(UInt32(4)))
        senBtnTitles[correctRandom] = chiSentence
        
        
        //填入數字
        
        randomSens = [Int(),Int(),Int(),Int()]
        randomSens[correctRandom] = Int(wordSequenceToReceive)!
   
      
        //設定好正確的按鈕
        allBtns[correctRandom].addTarget(self, action: #selector(NewGameViewController.rightSenButtonClicked), for: .touchUpInside)
        allBtns[correctRandom].tag = correctRandom
        
        
        
        //填滿其他的隨機數
        

        for i in 0 ..< 4 where i != correctRandom{
            
            randomSens[i] = getRan()
            
            senBtnTitles[i] = sentenceSets[randomSens[i] + halfCount]
            
            //設定好其餘選項的tag
            allBtns[i].tag = i
            
            //加入到錯誤按鈕的button
            allBtns[i].addTarget(self, action: #selector(NewGameViewController.wrongSenButtonClicked), for: .touchUpInside)
      
        }

        
        //設定所有案件的中文內文
        for i in 0 ..< allBtns.count {
            
            allBtns[i].contentHorizontalAlignment = .left
            
            //allBtns[i].setTitle("   \(i + 1). " + senBtnTitles[i], for: .normal)
            allBtns[i].setTitle(" " + senBtnTitles[i], for: .normal)
            
        }

        
//        //避免再次產生hint
//        isCheckingSentence = false
        
        
        
    }
    
    @objc func rightSenButtonClicked(sender:UIButton){

        
        //錯誤按鈕改圖片
        //sender.setBackgroundImage(UIImage(named:"answerRightBtn.png"), for: .normal)
        
        sender.backgroundColor = #colorLiteral(red: 0.937810123, green: 0.768859446, blue: 0.3554584682, alpha: 1)
        
        
        //錯誤的隱藏
        for i in 0 ..< 4 where i != correctRandom{
            
            allBtns[i].isHidden = true
            
        }
        
        //所有按鍵都不要有反應
        for btn in allBtns{
            
            btn.isUserInteractionEnabled = false
            
        }
        
        //等待1.5秒
        btnTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(NewGameViewController.btnCounting), userInfo: nil, repeats: true)
        
    }
    
    
    
    @objc func wrongSenButtonClicked(sender:UIButton) {

        
        if gameMode == 2 {
            isReviewWrong = true
        }
        //錯誤按鈕改圖片
        //sender.setBackgroundImage(UIImage(named:"wrongSenBlock.png"), for: .normal)
        
        sender.backgroundColor = #colorLiteral(red: 0.792498529, green: 0.2271894217, blue: 0.4495441318, alpha: 1)
        
        
        //留下對錯兩按鈕, 其餘隱藏
        for i in 0 ..< 4 where i != correctRandom && i != sender.tag{
            
            allBtns[i].isHidden = true
            
        }
        
        //所有按鈕不能按
        for btn in allBtns{
            
            btn.isUserInteractionEnabled = false
        }
        
        //做錯誤符號
        wrongSign.frame = CGRect(x: allBtns[sender.tag].frame.midX - allBtns[sender.tag].frame.width / 10, y: allBtns[sender.tag].frame.minY - allBtns[sender.tag].frame.height * 0.1, width: allBtns[sender.tag].frame.height * 1.2, height: allBtns[sender.tag].frame.height * 1.2)
        wrongSign.image = UIImage(named:"wrongX.png")
        self.view.addSubview(wrongSign)
        self.view.bringSubviewToFront(wrongSign)
        
        
        //等待1.5秒
        
        
        btnTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(NewGameViewController.btnCounting), userInfo: nil, repeats: true)
        
    }
    
    
    func reviewResult(type:Int, count:Int){
        
        
        var bgImage = String()
        var title = String()
        var unit = String()
        
        
        switch type{
            
        case 0:
            bgImage = "reviewSenResultBg.png"
            title = gameVC_wordPassed
            unit = gameVC_word
        case 1:
            bgImage = "reviewWordResultBg.png"
            title = gameVC_senPassed
            unit = gameVC_sen
        default:
            break
            
            
        }
        
        
        reviewWordBg.image = UIImage(named:bgImage)
        reviewAlertTitle2.text = title
        reviewAlertUnitLabel.text = unit
        
        reviewAlertCountLabel.text = String(count)
        
        wrongSign.isHidden = true
        reviewWordBg.isHidden = false
        reviewOkBtn.isHidden = false
        
        ghostBtn.isHidden = false
        
        
    }
    
    
    //倒數秒數, 倒數玩跳下一題
    @objc func btnCounting(){
        
        if timerCount < 2 {
            
            timerCount += 1
        } else {
          
            btnTimer.invalidate()
            timerCount = 0
            
            //跳下一題
            
            if isReviewWrong{

                updateReviewSenCount(senCount: senCount, course: courseReceived)

            } else{
                
                jumpToTagPractice()
            }
            
        }
        
        
    }
    
    
    //進入選擇題
    func jumpToTagPractice(){
        

        
        correctSign.removeFromSuperview()
        wrongSign.removeFromSuperview()
        
        for btn in allBtns{
            
            btn.isUserInteractionEnabled = true
            btn.isHidden = true
            //btn.setBackgroundImage(UIImage(named:"senBlock.png"), for: .normal)
            btn.backgroundColor = #colorLiteral(red: 0.2851897478, green: 0.6569955945, blue: 0.5925286412, alpha: 1)
        }
        
        sentenceLabel.text = ""
        chiSentenceLabel.text = chiSentence
        recogTextLabel.isHidden = false
        
        makeTag()
        
    }
    
    
    
    //3/19 做到MakeTag
    
    //選擇題
    func makeTag(){
        //製作tags
        sentenceTag = sentence.components(separatedBy: " ")
        
        //亂數
        sentenceTag.shuffled()
        
        //tagView.backgroundColor = .red
        
        //加入tag裡
        
        sentenceCounts = sentenceTag.count
        
        switch sentenceCounts{
     
        case 15 ..< 20:
          
            senFontSize -= 4
            
        case 20...23:
            
            senFontSize -= 6
            
        case 24...26:
       
            senFontSize -= 8
            
        case 26...:
      
            senFontSize -= 10
            
        default:
            break

        }
        
        
        tagView.textFont = UIFont.boldSystemFont(ofSize: senFontSize)
        
        for i in 0 ..< sentenceTag.count{
            
            //後方加入數字做辨認
            tagView.addTag(sentenceTag[i] + " " + String(i))
            
        }
        
        
        //準備選擇題
        sentenceLabel.text = ""
        
        //算分數 + 啟動tag的機制 (目前修正成nc去啟動倒數, score為0過去, finalPoints為0過去啟動）
        let score = Int()
        let finalPoints = Int()
        
        let addScore:[String:Int] = ["addScore":score,"finalPoints":finalPoints]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addScore"), object: nil, userInfo: addScore)
        
        
        //隱藏輸入字

        recogTextLabel.text = ""
        
        //做提示
        
        //在此Crash, 無法讀dynamic字型大小.....
        
        let attrs0 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: chiSentenceFontSize), NSAttributedString.Key.foregroundColor : UIColor.white]
        
     
        recogTextLabel.attributedText = NSAttributedString(string: gameVC_tagWordsToMakeSentence, attributes: attrs0)
        
        //recogTextLabel.font = UIFont(name: "Helvetica Bold", size: chiSentenceFontSize)
        
        //顯示出tag
        tagView.isHidden = false
        //tagView.backgroundColor = .white
        clearTagBtn.isHidden = false
        
//        //避免再次產生hint
//        isCheckingSentence = false
        
        //發音
        pronounceTime = 1
        
        synPronounce()
        
    }
    
    

    func getRandom() -> [Int:Int] {
        
        var selRan = [Int:Int]()
        
        let ranSpot = Int(arc4random_uniform(UInt32(randomSpots.count)))
        
        let ranUnit = Int(arc4random_uniform(UInt32(randomUnits.count)))
        selRan = [randomSpots[ranSpot]:randomUnits[ranUnit]]
        
        
        //如果數字重複了就重來
        if allRandomSens.contains(selRan){
            
            return getRandom()
        }
        
        return selRan
        
    }

    
    func getRan() ->Int{
        
        var selRan = Int()
        
        
        selRan = Int(arc4random_uniform(UInt32(sentenceSets.count / 2)))
        
        
        if randomSens.contains(selRan){
            
            return getRan()
        }
        
        return selRan
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //確認tag的答案
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
        recogTextLabel.text = ""
        
        tagView.isSelected = !tagView.isSelected
        
        //抓attrTitle
        let attr = tagView.attributedTitle(for: .normal) as! NSMutableAttributedString
        
        var sentenceShown = String()
        
        if attrTagsSelected.count > 0 {
            
            if attrTagsSelected.contains(attr){
                
                for i in 0 ..< attrTagsSelected.count{
                    
                    if attrTagsSelected[i] == attr{
                        
                        attrTagsSelected[i] = NSMutableAttributedString()
                        
                    }
                }
                
            } else {
                
                attrTagsSelected.append(attr)
            }
            
            
        } else {
            
            attrTagsSelected.append(attr)
        }
        
        
        //把attrTitle的純String顯示在畫面上
        for attr in attrTagsSelected{
            
            
            if attr != NSMutableAttributedString() {
                
                let attrWords = attr.mutableString.components(separatedBy: NSCharacterSet.decimalDigits)
                
                sentenceShown += attrWords[0] + " "
                
            }
       
        }
        
        
        //show出選擇的字
        recogTextLabel.font = recogTextLabel.font.withSize(senFontSize)
        recogTextLabel.text = sentenceShown
        
        //抓輸入答案來對
        let answerEntered = recogTextLabel.text?.dropLast()
        
        if answerEntered! == sentence{
            
            //    isCountingTriggered = false
            
            //跳轉下個字
            
            if gameMode == 0{
                //過關進入下個字
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "practiceNextWord"), object: nil, userInfo: nil)
                
                senRate += 1
                
            } else if gameMode == 2{
                
                //確認是否還有字
                //繼續練習下一個字
                //如果是的話代表是練習最後一個
                
                senCount += 1
                
                //在此抓共有幾題
                var randomSpotsCount = randomSpots.count
                
                //避免只有三題卻出四次
                for (s,u) in gamePassed! {
                    if s == 0 {
                        
                        if u == 1 {
                            
                            randomSpotsCount = 3
                        }
                    }
                    
                }
                
                if Int(wordSequenceToReceive) == (randomSpotsCount - 1){
            
                    
                    //過關進入下個字, 在此功能在gameMode == 2為刪除倒數線
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "practiceNextWord"), object: nil, userInfo: nil)
                    
                    
                    //要跳出練習總結畫面
                    
                    updateReviewSenCount(senCount: senCount, course:courseReceived)

                    
                } else {
                    
                    
                    //過關進入下個字, 在此功能在gameMode == 2為刪除倒數線
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "practiceNextWord"), object: nil, userInfo: nil)
                    
                    //這裡包含了重新開始的所有功能, 另外建功能是要為了接收gameScene發出來的NC, 避免以上的再次send Nc到gameScene
                    
                    game2RestartFunc()
                    
                }
                
            }
            
            
        } else {
            
            print("not yet correct")
            
        }
        
    }
    
    
    
    @objc func stopReview(_ notification:NSNotification){
        
        //抓分數
        
        if gameMode == 1 {
            
            
            if let wordCount = notification.userInfo?["wordCount"] as? Int{
                
                //在此updateWordCount
        
                updateReviewWordCount(wordCount: wordCount, course:courseReceived)
                

            }
            
        } else if gameMode == 2 {
            
            updateReviewSenCount(senCount: senCount, course:courseReceived)
            
        }
        
    }
    
    
    //MARK: must update
    //MARK: simVer 增加值
    func updateReviewWordCount(wordCount:Int, course:Int){
        
        var wordReviewGroup = [kWordReviewCount, kWordReviewCount2, kWordReviewCount3, kWordReviewCount4, kWordReviewCount5, kWordReviewCount6, kWordReviewCount7, kWordReviewCount8, kWordReviewCount9]
        
        let copyUser = user?.mutableCopy() as! NSMutableDictionary
        
        let wordReviewCount = user?.object(forKey: wordReviewGroup[course]) as! Int
        
        if wordCount > wordReviewCount {
            //replace new counts
            copyUser.setValue(wordCount, forKey: wordReviewGroup[course])
            user = copyUser
            userDefaults.set(user, forKey: "parseJSON")
        }
        
        //計算所有的count
        
        var totalCount = Int()
        for i in 0 ..< wordReviewGroup.count {
            let count = user?.object(forKey: wordReviewGroup[i]) as! Int
            totalCount += count
        }
        
        reviewResult(type: 1, count: totalCount)
        
        
        
//        let id = user?["id"] as! String
//
//        // url to access our php file
//        var url:URL
//        if lan == "zh-Hans" {
//            url = URL(string: "http://ec2-52-198-62-78.ap-northeast-1.compute.amazonaws.com/misswordChina/updateWordReviewCount.php")!
//        } else {
//            url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/updateWordReviewCount.php")!
//        }
//        //let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/updateWordReviewCount.php")!
//
//        // request url
//        var request = URLRequest(url: url)
//
//        // method to pass data POST - cause it is secured
//        request.httpMethod = "POST"
//
//        // body gonna be appended to url
//        let body = "userID=\(id)&wordCount=\(wordCount)&course=\(course)"
//
//        // append body to our request that gonna be sent
//        request.httpBody = body.data(using: .utf8)
//
//        URLSession.shared.dataTask(with: request, completionHandler: {[weak self] data, response, error in
//            // no error
//            if error == nil {
//
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NMutableSDictionary
//
//                    guard let parseJSON = json else {
//                        print("Error while parsing")
//
//                        //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
//                        return
//                    }
//
//                    //print("rank")
//                    //再次儲存使用者資訊
//
//                    //print(parseJSON)
//
//                    var tempCount = Int()
//                    var tempJsonName = String()
//                    var otherCountName = String()
//                    var otherCountName2 = String()
//                    var otherCountName3 = String()
//                    var otherCountName4 = String()
//
//                    var otherCountName5 = String()
//                    var otherCountName6 = String()
//                    var otherCountName7 = String()
//                    var otherCountName8 = String()
//
//
//                    var totalCount = Int()
//
//                    switch course{
//
//                    case 0:
//                        tempJsonName = "wordReviewCount"
//                        otherCountName = "wordReviewCount2"
//                        otherCountName2 = "wordReviewCount3"
//                        otherCountName3 = "wordReviewCount4"
//                        otherCountName4 = "wordReviewCount5"
//                        otherCountName5 = "wordReviewCount6"
//                        otherCountName6 = "wordReviewCount7"
//                        otherCountName7 = "wordReviewCount8"
//                        otherCountName8 = "wordReviewCount9"
//
//                    case 1:
//                        tempJsonName = "wordReviewCount2"
//                        otherCountName = "wordReviewCount"
//                        otherCountName2 = "wordReviewCount3"
//                        otherCountName3 = "wordReviewCount4"
//                        otherCountName4 = "wordReviewCount5"
//                        otherCountName5 = "wordReviewCount6"
//                        otherCountName6 = "wordReviewCount7"
//                        otherCountName7 = "wordReviewCount8"
//                        otherCountName8 = "wordReviewCount9"
//
//
//                    case 2:
//                        tempJsonName = "wordReviewCount3"
//                        otherCountName = "wordReviewCount"
//                        otherCountName2 = "wordReviewCount2"
//                        otherCountName3 = "wordReviewCount4"
//                        otherCountName4 = "wordReviewCount5"
//                        otherCountName5 = "wordReviewCount6"
//                        otherCountName6 = "wordReviewCount7"
//                        otherCountName7 = "wordReviewCount8"
//                        otherCountName8 = "wordReviewCount9"
//
//                    case 3:
//                        tempJsonName = "wordReviewCount4"
//                        otherCountName = "wordReviewCount"
//                        otherCountName2 = "wordReviewCount2"
//                        otherCountName3 = "wordReviewCount3"
//                        otherCountName4 = "wordReviewCount5"
//                        otherCountName5 = "wordReviewCount6"
//                        otherCountName6 = "wordReviewCount7"
//                        otherCountName7 = "wordReviewCount8"
//                        otherCountName8 = "wordReviewCount9"
//
//                    case 4:
//                        tempJsonName = "wordReviewCount5"
//                        otherCountName = "wordReviewCount"
//                        otherCountName2 = "wordReviewCount2"
//                        otherCountName3 = "wordReviewCount3"
//                        otherCountName4 = "wordReviewCount4"
//                        otherCountName5 = "wordReviewCount6"
//                        otherCountName6 = "wordReviewCount7"
//                        otherCountName7 = "wordReviewCount8"
//                        otherCountName8 = "wordReviewCount9"
//
//                    case 5:
//                        tempJsonName = "wordReviewCount6"
//                        otherCountName = "wordReviewCount"
//                        otherCountName2 = "wordReviewCount2"
//                        otherCountName3 = "wordReviewCount3"
//                        otherCountName4 = "wordReviewCount4"
//                        otherCountName5 = "wordReviewCount5"
//                        otherCountName6 = "wordReviewCount7"
//                        otherCountName7 = "wordReviewCount8"
//                        otherCountName8 = "wordReviewCount9"
//                    case 6:
//                        tempJsonName = "wordReviewCount7"
//                        otherCountName = "wordReviewCount"
//                        otherCountName2 = "wordReviewCount2"
//                        otherCountName3 = "wordReviewCount3"
//                        otherCountName4 = "wordReviewCount4"
//                        otherCountName5 = "wordReviewCount6"
//                        otherCountName6 = "wordReviewCount5"
//                        otherCountName7 = "wordReviewCount8"
//                        otherCountName8 = "wordReviewCount9"
//                    case 7:
//                        tempJsonName = "wordReviewCount8"
//                        otherCountName = "wordReviewCount"
//                        otherCountName2 = "wordReviewCount2"
//                        otherCountName3 = "wordReviewCount3"
//                        otherCountName4 = "wordReviewCount4"
//                        otherCountName5 = "wordReviewCount6"
//                        otherCountName6 = "wordReviewCount7"
//                        otherCountName7 = "wordReviewCount5"
//                        otherCountName8 = "wordReviewCount9"
//                    case 8:
//                        tempJsonName = "wordReviewCount9"
//                        otherCountName = "wordReviewCount"
//                        otherCountName2 = "wordReviewCount2"
//                        otherCountName3 = "wordReviewCount3"
//                        otherCountName4 = "wordReviewCount4"
//                        otherCountName5 = "wordReviewCount6"
//                        otherCountName6 = "wordReviewCount7"
//                        otherCountName7 = "wordReviewCount8"
//                        otherCountName8 = "wordReviewCount5"
//
//
//
//                    default:
//                        break
//
//                    }
//
//                    //如果有抓到該更新數字
//                    if let resultCount = parseJSON[tempJsonName] as? String{
//
//                        //只有正確更新時會回傳user資訊
//                        user = parseJSON
//                        //有更新的狀態
//
//                        tempCount = Int(resultCount)!
//                        let otherCount = user?[otherCountName] as! String
//                        let otherCount2 = user?[otherCountName2] as! String
//                        let otherCount3 = user?[otherCountName3] as! String
//                        let otherCount4 = user?[otherCountName4] as! String
//                        let otherCount5 = user?[otherCountName5] as! String
//                        let otherCount6 = user?[otherCountName6] as! String
//                        let otherCount7 = user?[otherCountName7] as! String
//                        let otherCount8 = user?[otherCountName8] as! String
//
//                        totalCount = tempCount + Int(otherCount)! + Int(otherCount2)! + Int(otherCount3)! + Int(otherCount4)! + Int(otherCount5)! + Int(otherCount6)! + Int(otherCount7)! + Int(otherCount8)!
//
//
//                    } else {
//
//                        //無更新的狀態
//                        //這裡的user檔案必須要有所有的gamePassed & mapPassed才不會user?[]抓不到導致crash
//
//
//                        let count = user?["wordReviewCount"] as! String
//                        let otherCount = user?["wordReviewCount2"] as! String
//                        let otherCount2 = user?["wordReviewCount3"] as! String
//                        let otherCount3 = user?["wordReviewCount4"] as! String
//                        let otherCount4 = user?["wordReviewCount5"] as! String
//                        let otherCount5 = user?["wordReviewCount6"] as! String
//                        let otherCount6 = user?["wordReviewCount7"] as! String
//                        let otherCount7 = user?["wordReviewCount8"] as! String
//                        let otherCount8 = user?["wordReviewCount9"] as! String
//
//                        totalCount = Int(count)! + Int(otherCount)! + Int(otherCount2)! + Int(otherCount3)! + Int(otherCount4)! + Int(otherCount5)! + Int(otherCount6)! + Int(otherCount7)! + Int(otherCount8)!
//
//                    }
//
//
//                    DispatchQueue.main.async(execute: {
//                        self!.reviewResult(type:0, count:totalCount)
//
//
//                    })
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
//
    }
    
    
    //MARK: simVer 增加值
    //MARK: must update
    func updateReviewSenCount(senCount:Int, course:Int){
        
        
       var senReviewGroup = [kSenReviewCount, kSenReviewCount2, kSenReviewCount3, kSenReviewCount4, kSenReviewCount5, kSenReviewCount6, kSenReviewCount7, kSenReviewCount8, kSenReviewCount9]
        
        let copyUser = user?.mutableCopy() as! NSMutableDictionary
        
        let senReviewCount = user?.object(forKey: senReviewGroup[course]) as! Int

        if senCount > senReviewCount {
            //replace new counts
            copyUser.setValue(senCount, forKey: senReviewGroup[course])
            user = copyUser
            userDefaults.set(user, forKey: "parseJSON")
        }
        
        //計算所有的count
        
        var totalCount = Int()
        for i in 0 ..< senReviewGroup.count {
            let count = user?.object(forKey: senReviewGroup[i]) as! Int
            totalCount += count
        }
        
        reviewResult(type: 1, count: totalCount)
        
//
//        let id = user?["id"] as! String
//
//        // url to access our php file
//        var url:URL
//        if lan == "zh-Hans" {
//            url = URL(string: "http://ec2-52-198-62-78.ap-northeast-1.compute.amazonaws.com/misswordChina/updateSenReviewCount.php")!
//        } else {
//            url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/updateSenReviewCount.php")!
//        }
//        //let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/updateSenReviewCount.php")!
//
//        // request url
//        var request = URLRequest(url: url)
//
//        // method to pass data POST - cause it is secured
//        request.httpMethod = "POST"
//
//
//        // body gonna be appended to url
//        let body = "userID=\(id)&senCount=\(senCount)&course=\(course)"
//
//        // append body to our request that gonna be sent
//        request.httpBody = body.data(using: .utf8)
//
//        URLSession.shared.dataTask(with: request, completionHandler: {[weak self] data, response, error in
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
//                    //print("rank")
//                    //再次儲存使用者資訊
//
//
//
//                    var tempCount = Int()
//                    var tempJsonName = String()
//                    var otherCountName = String()
//                    var otherCountName2 = String()
//                    var otherCountName3 = String()
//                    var otherCountName4 = String()
//
//                    var otherCountName5 = String()
//                    var otherCountName6 = String()
//                    var otherCountName7 = String()
//                    var otherCountName8 = String()
//
//
//                    var totalCount = Int()
//
//
//                    switch course{
//
//                    case 0:
//                        tempJsonName = "senReviewCount"
//                        otherCountName = "senReviewCount2"
//                        otherCountName2 = "senReviewCount3"
//                        otherCountName3 = "senReviewCount4"
//                        otherCountName4 = "senReviewCount5"
//                        otherCountName5 = "senReviewCount6"
//                        otherCountName6 = "senReviewCount7"
//                        otherCountName7 = "senReviewCount8"
//                        otherCountName8 = "senReviewCount9"
//
//                    case 1:
//                        tempJsonName = "senReviewCount2"
//                        otherCountName = "senReviewCount"
//                        otherCountName2 = "senReviewCount3"
//                        otherCountName3 = "senReviewCount4"
//                        otherCountName4 = "senReviewCount5"
//                        otherCountName5 = "senReviewCount6"
//                        otherCountName6 = "senReviewCount7"
//                        otherCountName7 = "senReviewCount8"
//                        otherCountName8 = "senReviewCount9"
//
//
//                    case 2:
//                        tempJsonName = "senReviewCount3"
//                        otherCountName = "senReviewCount"
//                        otherCountName2 = "senReviewCount2"
//                        otherCountName3 = "senReviewCount4"
//                        otherCountName4 = "senReviewCount5"
//                        otherCountName5 = "senReviewCount6"
//                        otherCountName6 = "senReviewCount7"
//                        otherCountName7 = "senReviewCount8"
//                        otherCountName8 = "senReviewCount9"
//
//                    case 3:
//                        tempJsonName = "senReviewCount4"
//                        otherCountName = "senReviewCount"
//                        otherCountName2 = "senReviewCount2"
//                        otherCountName3 = "senReviewCount3"
//                        otherCountName4 = "senReviewCount5"
//                        otherCountName5 = "senReviewCount6"
//                        otherCountName6 = "senReviewCount7"
//                        otherCountName7 = "senReviewCount8"
//                        otherCountName8 = "senReviewCount9"
//
//                    case 4:
//                        tempJsonName = "senReviewCount5"
//                        otherCountName = "senReviewCount"
//                        otherCountName2 = "senReviewCount2"
//                        otherCountName3 = "senReviewCount3"
//                        otherCountName4 = "senReviewCount4"
//                        otherCountName5 = "senReviewCount6"
//                        otherCountName6 = "senReviewCount7"
//                        otherCountName7 = "senReviewCount8"
//                        otherCountName8 = "senReviewCount9"
//
//                    case 5:
//                        tempJsonName = "senReviewCount6"
//                        otherCountName = "senReviewCount"
//                        otherCountName2 = "senReviewCount2"
//                        otherCountName3 = "senReviewCount3"
//                        otherCountName4 = "senReviewCount4"
//                        otherCountName5 = "senReviewCount5"
//                        otherCountName6 = "senReviewCount7"
//                        otherCountName7 = "senReviewCount8"
//                        otherCountName8 = "senReviewCount9"
//                    case 6:
//                        tempJsonName = "senReviewCount7"
//                        otherCountName = "senReviewCount"
//                        otherCountName2 = "senReviewCount2"
//                        otherCountName3 = "senReviewCount3"
//                        otherCountName4 = "senReviewCount4"
//                        otherCountName5 = "senReviewCount6"
//                        otherCountName6 = "senReviewCount5"
//                        otherCountName7 = "senReviewCount8"
//                        otherCountName8 = "senReviewCount9"
//                    case 7:
//                        tempJsonName = "senReviewCount8"
//                        otherCountName = "senReviewCount"
//                        otherCountName2 = "senReviewCount2"
//                        otherCountName3 = "senReviewCount3"
//                        otherCountName4 = "senReviewCount4"
//                        otherCountName5 = "senReviewCount6"
//                        otherCountName6 = "senReviewCount7"
//                        otherCountName7 = "senReviewCount5"
//                        otherCountName8 = "senReviewCount9"
//                    case 8:
//                        tempJsonName = "senReviewCount9"
//                        otherCountName = "senReviewCount"
//                        otherCountName2 = "senReviewCount2"
//                        otherCountName3 = "senReviewCount3"
//                        otherCountName4 = "senReviewCount4"
//                        otherCountName5 = "senReviewCount6"
//                        otherCountName6 = "senReviewCount7"
//                        otherCountName7 = "senReviewCount8"
//                        otherCountName8 = "senReviewCount5"
//
//
//
//                    default:
//                        break
//
//                    }
//
////                    switch course{
////
////                    case 0:
////                        tempJsonName = "senReviewCount"
////                        otherCountName = "senReviewCount2"
////                        otherCountName2 = "senReviewCount3"
////                        otherCountName3 = "senReviewCount4"
////                        otherCountName4 = "senReviewCount5"
////
////                    case 1:
////                        tempJsonName = "senReviewCount2"
////                        otherCountName = "senReviewCount"
////                        otherCountName2 = "senReviewCount3"
////                        otherCountName3 = "senReviewCount4"
////                        otherCountName4 = "senReviewCount5"
////
////
////                    case 2:
////                        tempJsonName = "senReviewCount3"
////                        otherCountName = "senReviewCount"
////                        otherCountName2 = "senReviewCount2"
////                        otherCountName3 = "senReviewCount4"
////                        otherCountName4 = "senReviewCount5"
////
////                    case 3:
////                        tempJsonName = "senReviewCount4"
////                        otherCountName = "senReviewCount"
////                        otherCountName2 = "senReviewCount2"
////                        otherCountName3 = "senReviewCount3"
////                        otherCountName4 = "senReviewCount5"
////
////                    case 4:
////                        tempJsonName = "senReviewCount5"
////                        otherCountName = "senReviewCount"
////                        otherCountName2 = "senReviewCount2"
////                        otherCountName3 = "senReviewCount3"
////                        otherCountName4 = "senReviewCount4"
////
////                    default:
////                        break
////
////
////                    }
//
//                    //如果有抓到該更新數字
//                    if let resultCount = parseJSON[tempJsonName] as? String{
//
//                        //只有正確更新時會回傳user資訊
//                        user = parseJSON
//                        //有更新的狀態
//
//                        tempCount = Int(resultCount)!
//                        let otherCount = user?[otherCountName] as! String
//                        let otherCount2 = user?[otherCountName2] as! String
//                        let otherCount3 = user?[otherCountName3] as! String
//                        let otherCount4 = user?[otherCountName4] as! String
//
//                        let otherCount5 = user?[otherCountName5] as! String
//                        let otherCount6 = user?[otherCountName6] as! String
//                        let otherCount7 = user?[otherCountName7] as! String
//                        let otherCount8 = user?[otherCountName8] as! String
//
//                        totalCount = tempCount + Int(otherCount)! + Int(otherCount2)! + Int(otherCount3)! + Int(otherCount4)! + Int(otherCount5)! + Int(otherCount6)! + Int(otherCount7)! + Int(otherCount8)!
//
//                    } else {
//
//                        //無更新的狀態
//                        //這裡的user檔案必須要有所有的gamePassed & mapPassed才不會user?[]抓不到導致crash
//
//
//                        let count = user?["senReviewCount"] as! String
//                        let otherCount = user?["senReviewCount2"] as! String
//                        let otherCount2 = user?["senReviewCount3"] as! String
//                        let otherCount3 = user?["senReviewCount4"] as! String
//                        let otherCount4 = user?["senReviewCount5"] as! String
//
//                        let otherCount5 = user?["senReviewCount6"] as! String
//                        let otherCount6 = user?["senReviewCount7"] as! String
//                        let otherCount7 = user?["senReviewCount8"] as! String
//                        let otherCount8 = user?["senReviewCount9"] as! String
//
//                        totalCount = Int(count)! + Int(otherCount)! + Int(otherCount2)! + Int(otherCount3)! + Int(otherCount4)! + Int(otherCount5)! + Int(otherCount6)! + Int(otherCount7)! + Int(otherCount8)!
//
//
//                    }
//
//
//                    DispatchQueue.main.async(execute: {
//                        self!.reviewResult(type:1, count:totalCount)
//                    })
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
    
    
    
    //快速複習答對繼續
    func game2RestartFunc(){
        let seq = Int(wordSequenceToReceive)
        
        //順序 + 1
        wordSequenceToReceive = String(seq! + 1)
        
        //移除按鈕target
        for btn in allBtns {
            
            btn.removeTarget(nil, action: nil, for: .allEvents)
        }
        
        allRandomSens.removeAll(keepingCapacity: false)
        
        //移除tagView
        attrTagsSelected.removeAll(keepingCapacity: false)
        tagView.isHidden = true
        removeAll()
        
        //移除輸入字
        recogTextLabel.text = ""
        recogTextLabel.isHidden = true
        
        //製作句子
        makeSentence()
        
    }
    
    @objc func removeAll(){
        
        tagView.removeAllTags()
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
            
            //設置成ambient看能不能避免任何interruption 造成當機
            
            try audioSession.setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.ambient)), mode: .default)
            try audioSession.setMode(AVAudioSession.Mode.default)
            try audioSession.setActive(true)
            
        } catch  {
            print("error")
        }
        
        
        let string = synWord
        
        var rateFloat = Float()
        
        let utterance = AVSpeechUtterance(string: string)
        let utterance2 = AVSpeechUtterance(string: string)
        
        if string.contains(" "){
            
            rateFloat = 0.4
            
            //delay要做0, delegate才會發音結束準時告知
            utterance.postUtteranceDelay = 0
            
        } else {
            rateFloat = 0.45
            utterance.postUtteranceDelay = 0
        }
        
        
        //utterance2.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance2.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Samantha-compact")
        utterance2.rate = rateFloat
        //utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Samantha-compact")
    
        utterance.rate = rateFloat
        
        stopSpeech()
        synth.speak(utterance)
        
        //print(AVSpeechSynthesisVoice.speechVoices())
    }
    
    
    
    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance){

        recordBtn.isEnabled = false
        
    }
    
    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance){
        
        
        if isReadingGuidedSentence{
            
            
            circleOkBtn.isHidden = false
            isReadingGuidedSentence = false
        }
        
        if !synth.isSpeaking{
            recordBtn.isEnabled = true

            
        } else {
            
            //避免delegate不成功...此function可能不需要暫時留著需要注意timer有沒有invalidate..

            waitTimer.invalidate()
            waitTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(NewGameViewController.waitTime), userInfo: nil, repeats: true)
        }
        
        
    }
    
    
    //避免delegate不成功的TIMER
    @objc func waitTime(){
        
       
        if !synth.isSpeaking{
            recordBtn.isEnabled = true
   
            waitTimer.invalidate()
        }
        
        
    }
    
    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance){
        print("**pause")
        recordBtn.isEnabled = true
    }
    
    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance){
        print("**continue")
        recordBtn.isEnabled = false
    }
    
    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance){
        print("**cancel")
        recordBtn.isEnabled = true
        
    }
    

    //新增最愛單字
    func addWord(word:String){
        
        let favWords = user?.object(forKey: kMyWords) as! String
        let newFavWords = favWords + word + ";"
        
        let copyUser = user?.mutableCopy() as! NSMutableDictionary
        
        copyUser.setValue(newFavWords, forKey: kMyWords)
        user = copyUser
        userDefaults.set(user, forKey: "parseJSON")
 
}
}


extension String {
    func removingCharacters(inCharacterSet forbiddenCharacters:CharacterSet) -> String
    {
        var filteredString = self
        while true {
            if let forbiddenCharRange = filteredString.rangeOfCharacter(from: forbiddenCharacters)  {
                filteredString.removeSubrange(forbiddenCharRange)
            }
            else {
                break
            }
        }
        
        return filteredString
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}
