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
let showTagKey = "showTag"
let readyToReadSentenceKey = "readyToReadSentence"
let readSentenceKey = "readSentence"
let onlyPracticeSentenceKey = "onlyPracticeSentence"
let restartGame2Key = "stopReview"
let restartCountingKey = "restartCounting"
let globalPause = "globalPause"
let globalStart = "globalStart"

var limitTimer = Timer()

var sentenceCounts = Int()
var senFontSize = CGFloat()

class NewGameViewController: UIViewController, SFSpeechRecognizerDelegate, TagListViewDelegate, AVSpeechSynthesizerDelegate{
    
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
    var wordToReceive = String()
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
    
    //是否是在確認句子
    var isCheckingSentence = Bool()
    
    
    //所選到的tag
    //var tagsSelected = [String]()
    
    var attrTagsSelected = [NSMutableAttributedString]()

    //製作tag
    @IBOutlet weak var tagView: TagListView!

    //這兩個應該用不到
    var player: AVAudioPlayer?
    var mp3FileName = String()
    
    
    //發音單字
    var synWord = String()
    
    //Text to speech合成器
    var synth = AVSpeechSynthesizer()
    
    @IBOutlet weak var resultBg: UIImageView!
    
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
    var isParseEnabled = true
    
    @IBOutlet weak var wordCountLabel: UILabel!
    
    let word1Label = UILabel()
    let word2Label = UILabel()
    let word3Label = UILabel()

    let inCircle = UIImageView()
    let midCircle = UIImageView()
    let outCircle = UIImageView()
    
    var isCelebratingMapPassed = false
    
    //@IBOutlet weak var talkCircle: UIView!
    
    //用來顯示正確答案的變數, 保留標點符號大小寫
    var completeWordsToShow = String()
    var sentenceTag = [String]()
    
    //錄音動畫
    var recordingIndicator:NVActivityIndicatorView?
    //var pointsIndicator:NVActivityIndicatorView?
    
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var waitTimer = Timer()
    //紀錄錯誤發音字
    
    

    var relevantWords:[[String:[String]]]?
    
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
    
    var courseReceived = Int()
    var gamePassedDic:[Int:Int]?
    var mapPassedInt = Int()
    var increaseNum = Int()
    var maxSpotNum = Int()
    var maxMapNum = Int()
    
    
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
    var isPurchased = String()
    
    var originalPoints = Int()
    var wrongWordsToSend = [String]()
    var scoresToSend = Int()
  
    var newRels = [String]()
          //  var tagFontSize = CGFloat()
    
    var sentenceCount = Int()
    @IBOutlet weak var hintLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var dif = CGFloat()
        var senLabelHeightDif = CGFloat()
        var iPadDif = CGFloat()
        var btnDif = CGFloat()
        
        var xDif = CGFloat()

        var tagMarginY = CGFloat()
        var btnDif2 = CGFloat()
        var playBtnY = CGFloat()
        
        switch height {
        case 812:
            xDif = 1.05
            btnDif = 1
            dif = 1.15
            senLabelHeightDif = 0.7
            iPadDif = 1
            senFontSize = 26
            tagMarginY = 13
            btnDif2 = 1
            playBtnY = 0
        case 736:
            xDif = 1
            btnDif = 1.1
            dif = 1.1
            senLabelHeightDif = 0.78
            iPadDif = 1
            senFontSize = 26
            tagMarginY = 13
            btnDif2 = 1.1
            playBtnY = 0
            
        case 667:
            xDif = 1
            btnDif = 1
            dif = 1
            senLabelHeightDif = 0.9
            iPadDif = 1
            senFontSize = 22
            tagMarginY = 10
            btnDif2 = 1
            playBtnY = 0
            
        case 568:
            xDif = 1
            btnDif = 0.9
            dif = 0.9
            senLabelHeightDif = 1
            iPadDif = 1
            senFontSize = 20
            tagMarginY = 8
            btnDif2 = 0.9
            playBtnY = 5
            
        default:
            xDif = 1
            btnDif = 0.9
            dif = 0.9
            senLabelHeightDif = 1
            iPadDif = 1.2
            senFontSize = 26
            tagMarginY = 13
            btnDif2 = 0.9
            playBtnY = 0
            
        }
        
        
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
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.showTag), name: NSNotification.Name("showTag"), object: nil)
        
        
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

        
        //做reviewAlert
        reviewWordBg.frame = CGRect(x: width / 2 - 237 / 2, y: height / 3, width: 237 * dif, height: 214 * dif)
        reviewWordBg.image = UIImage(named:"reviewWordResultBg.png")
        self.view.addSubview(reviewWordBg)
        
        reviewAlertTitle1.frame = CGRect(x: reviewWordBg.frame.width / 22, y: reviewWordBg.frame.height / 20, width: 92 * dif, height: 25 * dif)
        //reviewAlertTitle1.backgroundColor = .gray
        reviewAlertTitle1.text = "快速複習"
        reviewAlertTitle1.font = UIFont(name: "Helvetica Bold", size: 20)
        reviewAlertTitle1.textColor = .white
        reviewAlertTitle1.textAlignment = .right
        reviewWordBg.addSubview(reviewAlertTitle1)
        
        reviewAlertTitle2.frame = CGRect(x: reviewAlertTitle1.frame.minX, y: reviewAlertTitle1.frame.maxY - 5 * dif, width: 92 * dif, height: 25 * dif)
        //reviewAlertTitle2.backgroundColor = .red
        reviewAlertTitle2.text = "單字達成"
        reviewAlertTitle2.font = UIFont(name: "Helvetica Bold", size: 12)
        reviewAlertTitle2.textColor = .white
        reviewAlertTitle2.textAlignment = .right
        
        reviewWordBg.addSubview(reviewAlertTitle2)
        
        reviewAlertTotalLabel.frame = CGRect(x: reviewAlertTitle1.frame.midX - 10 * dif, y: reviewAlertTitle2.frame.maxY * 1.3, width: 30 * dif, height: 17 * dif)
        reviewAlertTotalLabel.text = "總計"
        reviewAlertTotalLabel.textAlignment = .left
        reviewAlertTotalLabel.font = UIFont(name: "Helvetica Bold", size: 12)
        reviewAlertTotalLabel.textColor = darkColor
        //reviewAlertTotalLabel.backgroundColor = .gray
        reviewWordBg.addSubview(reviewAlertTotalLabel)
        
        
        reviewAlertCountLabel.frame = CGRect(x: (reviewWordBg.frame.width - 170) / 2, y: reviewAlertTotalLabel.frame.midY, width: 170 * dif, height: 80 * dif)
        reviewAlertCountLabel.text = "1306"
        reviewAlertCountLabel.textAlignment = .center
        reviewAlertCountLabel.font = UIFont(name: "Helvetica Bold", size: 70)
        reviewAlertCountLabel.textColor = darkColor
        //reviewAlertCountLabel.backgroundColor = .gray
        reviewWordBg.addSubview(reviewAlertCountLabel)

        
        reviewAlertUnitLabel.frame = CGRect(x: reviewAlertCountLabel.frame.maxX - 10 * dif, y: reviewAlertCountLabel.frame.maxY - 17 * dif, width: 20 * dif, height: 17 * dif)
        reviewAlertUnitLabel.text = "字"
        reviewAlertUnitLabel.textAlignment = .left
        reviewAlertUnitLabel.font = UIFont(name: "Helvetica Bold", size: 12)
        reviewAlertUnitLabel.textColor = darkColor
        //reviewAlertCountLabel.backgroundColor = .gray
        reviewWordBg.addSubview(reviewAlertUnitLabel)

        
        let attrs0 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 12), NSAttributedStringKey.foregroundColor : darkColor]
        
        
        let title = NSAttributedString(string: "我知道了", attributes: attrs0)
        
        
        reviewOkBtn = UIButton(type: .system)
        //reviewOkBtn.showsTouchWhenHighlighted = true
        reviewOkBtn.frame = CGRect(x: (width - 169 * dif) / 2, y: reviewWordBg.frame.maxY - 27 * dif * 1.5, width: 169 * dif, height: 27 * dif)
        reviewOkBtn.addTarget(self, action: #selector(NewGameViewController.reviewOkBtnClicked), for: .touchUpInside)
        reviewOkBtn.setBackgroundImage(UIImage(named:"reviewOkBtnPng.png"), for: .normal)
        reviewOkBtn.setAttributedTitle(title, for: .normal)
        self.view.addSubview(reviewOkBtn)
        
        
        
        limitTimerLabel.center = CGPoint(x: width / 2 - 25, y: 55)
        limitTimerLabel.frame.size = CGSize(width: 50, height: 20)
        limitTimerLabel.textAlignment = .center
        
        
        //limitTimerLabel.backgroundColor = .red
        


        
        /*
        switch courseReceived {
            
        case 0:
            
            gamePassedDic = gamePassed!
            mapPassedInt = mapPassed!
            increaseNum = 0
            
        case 1:
            
            gamePassedDic = gamePassed2!
            mapPassedInt = mapPassed2!
            increaseNum = 5
            
        default:
            break
        
        }
        */
        // Do any additional setup after loading the view.
       
        //暫時測試畫面使用
        
        //加入alertView
        let lightGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.58)
        ghostBtn.frame = CGRect(x: 0, y: 0, width: width, height: height)
        ghostBtn.backgroundColor = lightGray
        //ghostBtn.addTarget(self, action: #selector(LessonViewController.removeBtns), for: .touchUpInside)
        self.view.addSubview(ghostBtn)
        
        alertBg.frame = CGRect(x: (width - 237 * dif) / 2, y: height * 2 /  5, width: width * 237 / 375, height: height * 140 / 667)
        alertBg.image = UIImage(named: "reviewSelectBg3.png")
        self.view.addSubview(alertBg)
        
        alertText.frame = CGRect(x: 5 * dif , y: 15 * dif, width: alertBg.frame.width - 5 * dif * 2, height: alertBg.frame.height / 2)
        alertText.font = UIFont(name: "Helvetica Bold", size: 16)
        alertText.textColor = .white
        alertText.text = "\n離開目前課程\n學習進度不會儲存!"
        alertText.numberOfLines = 0
        alertText.textAlignment = .center
        alertText.adjustsFontSizeToFitWidth = true
        alertBg.addSubview(alertText)
        
        cancelBtn.frame = CGRect(x: alertBg.frame.minX, y: alertBg.frame.maxY - 40 * dif * xDif, width: alertBg.frame.width / 2, height: height * 44 / 667)
        cancelBtn.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 16)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(orangeColor, for: .normal)
        cancelBtn.addTarget(self, action: #selector(NewGameViewController.removeBtns), for: .touchUpInside)
        self.view.addSubview(cancelBtn)
        
        quitBtn.frame = CGRect(x: cancelBtn.frame.maxX, y: alertBg.frame.maxY - 40 * dif * xDif, width: alertBg.frame.width / 2, height: height * 44 / 667)
        quitBtn.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 16)
        quitBtn.setTitle("離開", for: .normal)
        quitBtn.setTitleColor(orangeColor, for: .normal)
        quitBtn.addTarget(self, action: #selector(NewGameViewController.leaveWithoutSaving), for: .touchUpInside)
        self.view.addSubview(quitBtn)
        
        /*
        leftBtnClickedImg.frame = cancelBtn.frame
        leftBtnClickedImg.image = UIImage(named: "leftBtnClickedImg.png")
        
        rightBtnClickedImg.frame = quitBtn.frame
        rightBtnClickedImg.image = UIImage(named: "rightBtnClickedImg.png")
        
        self.view.addSubview(leftBtnClickedImg)
        self.view.addSubview(rightBtnClickedImg)
        leftBtnClickedImg.alpha = 0
        rightBtnClickedImg.alpha = 0
*/

        coverBg.image = UIImage(named:"coverBg.png")
        resultBg.image = UIImage(named:"resultBg.png")
        
        coverBtn.isHidden = true
        coverBg.isHidden = true
        resultBg.isHidden = true
        firstWordBtn.isHidden = true
        secondWordBtn.isHidden = true
        thirdWordBtn.isHidden = true
        bigOkBtn.isHidden = true
        bigOkBtn.setImage(UIImage(named:"bigOkBtn.png"), for: .normal)
        firstWordBtn.isEnabled = false
        secondWordBtn.isEnabled = false
        thirdWordBtn.isEnabled = false
        
        
        
        sen1Btn.frame = CGRect(x:(width - 350 * btnDif2) / 2, y: height / 2 , width: 350 * btnDif2, height: 57 * btnDif2)
        //sen1Btn.imageView?.contentMode = .scaleAspectFit
        
        sen1Btn.titleLabel?.adjustsFontSizeToFitWidth = true
        sen1Btn.titleLabel?.numberOfLines = 2
        sen1Btn.titleEdgeInsets.left = 8
        
        
        sen2Btn.frame = CGRect(x:(width - 350 * btnDif2) / 2, y: sen1Btn.frame.maxY + 20 * dif, width: 350 * btnDif2, height: 57 * btnDif2)
        sen2Btn.titleLabel?.adjustsFontSizeToFitWidth = true

        sen2Btn.titleLabel?.numberOfLines = 2
        sen2Btn.titleEdgeInsets.left = 8

        
        sen3Btn.frame = CGRect(x:(width - 350 * btnDif2) / 2, y: sen2Btn.frame.maxY + 20 * dif , width: 350 * btnDif2, height: 57 * btnDif2)
        sen3Btn.titleLabel?.adjustsFontSizeToFitWidth = true

        sen3Btn.titleLabel?.numberOfLines = 2
        sen3Btn.titleEdgeInsets.left = 8

        
        sen4Btn.frame = CGRect(x:(width - 350 * btnDif2) / 2, y: sen3Btn.frame.maxY + 20 * dif , width: 350 * btnDif2, height: 57 * btnDif2)
        
        sen4Btn.titleLabel?.adjustsFontSizeToFitWidth = true
     
        sen4Btn.titleLabel?.numberOfLines = 2
        sen4Btn.titleEdgeInsets.left = 8


        allBtns.append(sen1Btn)
        allBtns.append(sen2Btn)
        allBtns.append(sen3Btn)
        allBtns.append(sen4Btn)
        
        for btn in allBtns{
            
            btn.isHidden = true
        }
        
        
        //layOut
        
        
        resultBg.frame = CGRect(x: (width - 280 * dif) / 2, y: height / 8, width: 280 * dif, height: 488 * dif)
        firstWordBtn.frame = CGRect(x: resultBg.frame.origin.x + ((resultBg.frame.width - (519 / 2 * dif)) / 2), y: resultBg.frame.midY - resultBg.frame.height / 20, width: 519 / 2 * dif, height: 57 * dif)

        
        secondWordBtn.frame = CGRect(x: firstWordBtn.frame.origin.x, y: firstWordBtn.frame.maxY +  15 * dif, width: firstWordBtn.frame.width, height: firstWordBtn.frame.height)
        
        thirdWordBtn.frame = CGRect(x: firstWordBtn.frame.origin.x, y: secondWordBtn.frame.maxY + 15 * dif, width: firstWordBtn.frame.width, height: firstWordBtn.frame.height)
        
        
        firstEngWord.frame = CGRect(x: firstWordBtn.frame.minX + 20 * dif, y: firstWordBtn.frame.minY + 12 * dif, width: 208 * dif, height: 35 * dif)
        firstChiWord.frame = CGRect(x: firstWordBtn.frame.maxX - 89 * dif, y: firstWordBtn.frame.minY + 16 * dif, width: 69 * dif, height: 28 * dif)
        
        secondEngWord.frame = CGRect(x: firstWordBtn.frame.minX + 20 * dif, y: secondWordBtn.frame.minY + 12 * dif, width: 208 * dif, height: 35 * dif)
        secondChiWord.frame = CGRect(x: firstWordBtn.frame.maxX - 89 * dif, y: secondWordBtn.frame.minY + 16 * dif, width: 69 * dif, height: 28 * dif)
        
        thirdEngWord.frame = CGRect(x: firstWordBtn.frame.minX + 20 * dif, y: thirdWordBtn.frame.minY + 12 * dif, width: 208 * dif, height: 35 * dif)
        thirdChiWord.frame = CGRect(x: firstWordBtn.frame.maxX - 89 * dif, y: thirdWordBtn.frame.minY + 16 * dif, width: 69 * dif, height: 28 * dif)
        
        
        bigOkBtn.frame = CGRect(x: resultBg.frame.minX + ((resultBg.frame.width - (210 * dif)) / 2), y: resultBg.frame.maxY - 40 * dif * iPadDif, width: 210 * dif, height: 29 * dif)
        
        
        scoreLabel.frame = CGRect(x: resultBg.frame.maxX - 140 * dif, y: resultBg.frame.minY + 53 * dif, width: 106 * dif, height: 21 * dif)
        
        
    /*
        limitTimerLabel.center = CGPoint(x: width / 2, y: 60)
        limitTimerLabel.frame.size = CGSize(width: 50, height: 20)
        limitTimerLabel.textAlignment = .center
      */
        
        //bonusScoreLabel.frame = CGRect(x: scoreLabel.frame.minX, y: scoreLabel.frame.minY, width: scoreLabel.frame.width, height: scoreLabel.frame.height)
        bonusScoreLabel.frame = scoreLabel.frame
        bonusScoreLabel.frame.origin.x = bonusScoreLabel.frame.origin.x - bonusScoreLabel.frame.width / 2
        
        bonusScoreLabel.textColor = .red
        bonusScoreLabel.textAlignment = .right
        bonusScoreLabel.font = UIFont(name: "Helvetica Bold", size: 18)
        bonusScoreLabel.text = "+bonus"
        bonusScoreLabel.alpha = 0
        //bonusScoreLabel.isHidden = true
        view.addSubview(bonusScoreLabel)

        wordCountLabel.frame = CGRect(x: resultBg.frame.minX + 50 * dif, y: resultBg.frame.minY + 140 * dif, width: 157 * dif, height: 95 * dif)
        wordCountLabel.adjustsFontSizeToFitWidth = true
        
        sentenceLabel.frame = CGRect(x: (width - (width - 50 * dif)) / 2, y: height / 10, width: width - 50 * dif, height: height / 4.6 * dif * senLabelHeightDif)
        chiSentenceLabel.frame = CGRect(x: (width - (width - 50 * dif)) / 2, y: sentenceLabel.frame.maxY + 10 * dif, width: sentenceLabel.frame.width, height: height / 10 * dif)
        sentenceLabel.adjustsFontSizeToFitWidth = true
        chiSentenceLabel.adjustsFontSizeToFitWidth = true
        coverBg.frame = CGRect(x: 0, y: 0, width: width, height: height)
        coverBtn.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        
        //改變高度
        recogTextLabel.frame = CGRect(x: 0, y: height * 2 / 5, width: width, height: height / 5.5)
    
       //recogTextLabel.backgroundColor = .yellow
        //做三個對話圓

        /*
        outCircle.frame.size = CGSize(width: 230, height: 230)
        outCircle.center = CGPoint(x: 187, y: 500)
        outCircle.image = UIImage(named:"outCircle.png")
        view.addSubview(outCircle)
        midCircle.frame.size = CGSize(width: 150, height: 150)
        midCircle.center = CGPoint(x: 187, y: 500)
        midCircle.image = UIImage(named:"midCircle.png")
        view.addSubview(midCircle)
        inCircle.frame.size = CGSize(width: 90, height: 90)
        inCircle.center = CGPoint(x: 187, y: 500)
        inCircle.image = UIImage(named:"inCircle.png")
        view.addSubview(inCircle)
        */
        word1Label.frame = CGRect(x: firstWordBtn.frame.width / 3, y: 0, width: firstWordBtn.frame.width / 3, height: firstWordBtn.frame.height)
        word1Label.textColor = .white
        word1Label.font = UIFont(name: "Helvetica Bold", size: 14)
        word1Label.text = "加入最愛"
        word1Label.textAlignment = .center
        word1Label.alpha = 0
        self.firstWordBtn.addSubview(word1Label)
       
        word2Label.frame = CGRect(x: secondWordBtn.frame.width / 3, y: 0, width: secondWordBtn.frame.width / 3, height: secondWordBtn.frame.height)
        word2Label.textColor = .white
        word2Label.font = UIFont(name: "Helvetica Bold", size: 14)
        word2Label.text = "加入最愛"
        word2Label.textAlignment = .center
        word2Label.alpha = 0
        self.secondWordBtn.addSubview(word2Label)

        word3Label.frame = CGRect(x: thirdWordBtn.frame.width / 3, y: 0, width: thirdWordBtn.frame.width / 3, height: thirdWordBtn.frame.height)
        word3Label.textColor = .white
        word3Label.font = UIFont(name: "Helvetica Bold", size: 14)
        word3Label.text = "加入最愛"
        word3Label.textAlignment = .center
        word3Label.alpha = 0
        self.thirdWordBtn.addSubview(word3Label)
        
        recordBtn.frame = CGRect(x: (width - 128 * dif) / 2, y: height - 180 * dif, width: 128 * dif, height: 128 * dif)
        
        
        //載入我的最愛單字

        if let myWordsString = user?["myWords"] as! String?{
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
        tagView.isHidden = true

        tagView.marginY = tagMarginY
        print(tagMarginY)
        
        tagView.frame = CGRect(x: width / 20, y: height * 3 / 5, width: width - width / 10, height: height * 2 / 5)
        
        //tagView.backgroundColor = .red
        
        
       
        
        
       
        //辨識字的大小設定
        recogTextLabel.adjustsFontSizeToFitWidth = true
        //recogTextLabel.backgroundColor = .green
        
        
        //wave畫面設定
        audioView.isHidden = true
        audioView.backgroundColor = .clear
        audioView.density = 1
        audioView.numberOfWaves = 5
        audioView.secondaryLineWidth = 1
        audioView.amplitude = 0.1
        audioView.alpha = 0.7
        audioView.waveColor = recordingPinkColor
        audioView.frame = CGRect(x: 0, y: height - 158 * dif, width: width, height: height / 6.5)
        
        //設定發音鍵
        playSoundBtn.frame = CGRect(x: width - 69 * dif, y: height - 23 * dif * 1.5 + playBtnY, width: 69 * dif - playBtnY, height: 32 * dif - playBtnY)
        
        
        
        


        
        //先隱藏錄音及辨識
        recordBtn.isHidden = true

        recogTextLabel.isHidden = true
        
        
        
        //讀目前課程數字數量
        switch courseReceived {
            
        case 0:

            gamePassedDic = gamePassed!
            mapPassedInt = mapPassed!
            increaseNum = 0
            maxSpotNum = 14
            maxMapNum = 4

            
        case 1:
            
            gamePassedDic = gamePassed2!
            mapPassedInt = mapPassed2!
            increaseNum = 5
            maxSpotNum = 14
            maxMapNum = 5
            
        case 2:
            
            gamePassedDic = gamePassed3!
            mapPassedInt = mapPassed3!
            increaseNum = 11
            maxSpotNum = 14
            maxMapNum = 6

            
        default:
            break
            
        }
        
        //讀取Bundle裡的句子
        var sentenceFile:String?
        
        if gameMode == 0 {
            

        
            //gameMode == 0 才計時
            
            
            limitSeconds = UserDefaults.standard.object(forKey: "limitSeconds") as! Int
            
            //不論如何都啟動, 但是有購買就會invalidate
            print("really start to count down")
            limitTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NewGameViewController.countLimit), userInfo: nil, repeats: true)
           
            
        
            
            
        //這裡的mapNum 已經加過increaseNum
        let sentenceName = "s" + String(mapNumber + 1) + "-" + String(spotNumber + 1)
        
        if let filepath = Bundle.main.path(forResource: sentenceName, ofType: "txt") {
            do {
                sentenceFile = try String(contentsOfFile: filepath)
                let sentences = sentenceFile?.components(separatedBy: "; ")
                
                //把字讀取到wordSets裡
                sentenceSets = sentences!
                //print(contents)
            } catch {
                // contents could not be loaded
                print("catch error")
            }
        } else {
            // example.txt not found!
            print("txt can't be found")
        }
            
        } else if gameMode == 2{
            
            //隨機單字
            //在此抓測驗單字的亂數順序
            var tempGamePassedDic:[Int:Int]?
            
            
            //這裡的maxMapNum + 1 是因為設定問題, 為了判斷剛玩的關卡是不是最後一關
            if mapPassedInt == (maxMapNum + 1) {
                
                tempGamePassedDic = [maxSpotNum:9]
                mapPassedInt -= 1
            } else if mapNumber < mapPassedInt{
                
                tempGamePassedDic = [maxSpotNum:9]
                
                
            } else{
                tempGamePassedDic = gamePassedDic
            }
            
            
            
            for (s,u) in tempGamePassedDic!{
                
                //1. 填入spot上限供亂數選擇
                
                //填入全部
                if s > 0 {
                    
                    allUnitSpotNums = [Array<Any>](repeating: [Int](), count: s + 1) as! [[Int]]
                    
                    for i in 0 ..< (s) {
                        
                        for n in 0 ..< 30{
                            
                            allUnitSpotNums[i].append(n)
                            
                        }
                        
                    }
                    
                    //填入殘值
                    if u > 0 {
                        
                        for i in 0 ..< u * 3 {
                            
                            allUnitSpotNums[allUnitSpotNums.count - 1].append(i)
                            
                        }
                    } else {
                        
                        
                        allUnitSpotNums.remove(at: allUnitSpotNums.count - 1)
                        
                    }
                    
                //    print(allUnitSpotNums)
                    
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
            
            //加數字才能讀到正確數字
            mapPassedInt += increaseNum
            
            
            //Part 2. 讀取所有句子
            
            for (s,_) in tempGamePassedDic!{
                
                //讀取已完整的所有字集
                
                for i in 0 ..< (s + 1){
                    
                    var wordFile:String?
                    //前面的1代表第一張地圖
                    let name = "s" + String(describing: mapPassedInt + 1) + "-" + String(i + 1)
                    
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
            
        //print(allSentenceSets)
            
        
        
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
                    self.recordBtn.isEnabled = false
                    //self.recordingButton.setTitle("User denied access to speech recogniztion", for: .disabled)
                    
                case .restricted:
                    self.recordBtn.isEnabled = false
                    //self.recordingButton.setTitle("Speech recogniztion is restricted on this device", for: .disabled)
                    
                case .notDetermined:
                    self.recordBtn.isEnabled = false
                    //self.recordingButton.setTitle("Speech recognition has not yet been authorized", for: .disabled)
                    
                    
                }
                
                
            })
            
            
        }

        
        //中文句子字顏色
        chiSentenceLabel.textColor = pinkColor
        
        
        //做錄音動畫
        let frame = CGRect(x: recordBtn.frame.origin.x - 8 * dif, y: recordBtn.frame.origin.y - 8 * dif, width:145 * dif, height: 145 * dif)
        recordingIndicator = NVActivityIndicatorView(frame: frame, type: .circleStrokeSpin, color: recordingPinkColor, padding: 2)
        
        
        
        circleOkBtn.frame = recordBtn.frame
        circleOkBtn.isHidden = true
        
        self.view.addSubview(recordingIndicator!)
        self.view.bringSubview(toFront: recordBtn)
  
        //拉到最前方
        self.view.bringSubview(toFront: ghostBtn)
        self.view.bringSubview(toFront: alertBg)
        
        self.view.bringSubview(toFront: cancelBtn)
        self.view.bringSubview(toFront: quitBtn)
       // self.view.bringSubview(toFront: leftBtnClickedImg)
       // self.view.bringSubview(toFront: rightBtnClickedImg)
        self.view.bringSubview(toFront: bonusScoreLabel)
        
        
        self.view.bringSubview(toFront: reviewWordBg)
        self.view.bringSubview(toFront: reviewAlertTitle1)
        self.view.bringSubview(toFront: reviewAlertTitle2)
        self.view.bringSubview(toFront: reviewAlertTotalLabel)
        self.view.bringSubview(toFront: reviewAlertCountLabel)
        self.view.bringSubview(toFront: reviewAlertUnitLabel)
        self.view.bringSubview(toFront: reviewOkBtn)

     
        self.view.bringSubview(toFront: limitTimerLabel)
 

        ghostBtn.isHidden = true
        alertBg.isHidden = true
        cancelBtn.isHidden = true
        quitBtn.isHidden = true
        leftBtnClickedImg.isHidden = true
        rightBtnClickedImg.isHidden = true
        
        reviewWordBg.isHidden = true
        reviewOkBtn.isHidden = true
        
        
      
        //bonusAnimation()

        //moveUpAndGone(label: bonusScoreLabel)
    
        /*
        scoreLabel.text = "0"
        scoreLabel.textColor = .white
        countScore(score: 1500)
        bonusAnimation(repeatCount: 3)
        */
        
        
        
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
        
        
        var newRel = String()
        for rel in relArray {
            
            
            
            newRel = rel.replacingOccurrences(of: "[", with:"")
            newRel = newRel.replacingOccurrences(of: "]", with:"")
            newRel = newRel.replacingOccurrences(of: "\"", with: "")
            newRel = newRel.replacingOccurrences(of: "\\", with: "")
            newRels.append(newRel)
            
        }
        
        hintLabel.textColor = .white
        hintLabel.frame = CGRect(x: (width - 200) / 2, y: recordBtn.frame.minY - 40, width: 200, height: 30)

        hintLabel.frame.size = CGSize(width: 200, height: 30)
        hintLabel.text = ""
        //hintLabel.backgroundColor = .blue
        hintLabel.adjustsFontSizeToFitWidth = true
        hintLabel.textAlignment = .center
        

    }
    
    
    
    @objc func removePronounceBtn(){
        

        
    }
    
    @objc func removePlaySoundBtn(){
        
        
        print("remove pronounceBtn")
        playSoundBtn.isHidden = true
        
        
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
        
               print("button clicked")
      
        self.dismiss(animated: true, completion: nil)
    }
    
    //接收nc
    @objc func pauseGame(){
        

        alertText.text = "\n離開目前課程\n學習進度不會儲存!"
        quitBtn.setTitle("離開", for: .normal)
        cancelBtn.setTitle("取消", for: .normal)
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
        
        limitTimer.invalidate()
        
        UserDefaults.standard.set(limitSeconds, forKey: "limitSeconds")
        
    }
    
    func timerPause(){
        
        
        alertText.text = "\n每日7分鐘免費學習時間到囉!\n立即購買無限學習時間!\n$ 90.00"
        quitBtn.setTitle("前往商城", for: .normal)
        cancelBtn.setTitle("先不買", for: .normal)
        ghostBtn.isHidden = false
        alertBg.isHidden = false
        cancelBtn.isHidden = false
        quitBtn.isHidden = false
        leftBtnClickedImg.isHidden = false
        rightBtnClickedImg.isHidden = false


        quitBtn.removeTarget(self, action: #selector(NewGameViewController.leaveWithoutSaving), for: .touchUpInside)
    

        quitBtn.addTarget(self, action: #selector(NewGameViewController.toPurchaseVc), for: .touchUpInside)
        
        cancelBtn.removeTarget(self, action: #selector(NewGameViewController.removeBtns), for: .touchUpInside)
        cancelBtn.addTarget(self, action: #selector(NewGameViewController.leaveWithoutSaving), for: .touchUpInside)
        
        
        limitTimer.invalidate()
        
        UserDefaults.standard.set(limitSeconds, forKey: "limitSeconds")
        
    }
    
    
    @objc func toPurchaseVc(){
        
        
        performSegue(withIdentifier: "fromGameToPurchase", sender: self)
        
        
        
    }
    
    

    @IBAction func playSoundClicked(_ sender: Any) {
        //bonusAnimation()
        
        //避免空字也發音
        if synWord != String(){
        
          //  print("playSound")
          //  print(synWord)
            synPronounce()
        }
    }
    
    
    @objc func leaveWithoutSaving(){
        
        
        timer?.invalidate()
        
        
        self.dismiss(animated: true, completion: nil)
        
        /*
        UIView.animate(withDuration: 0.06, animations: {[weak self] in
            
           // self!.rightBtnClickedImg.alpha = 1
            
            
        }) {[weak self] (finished:Bool) in
            
            
            if finished {
                /*
                 self!.leftBtnClickedImg.alpha = 0
                 self?.cancelBtn.isEnabled = false
                 self?.quitBtn.isEnabled = false
 
                 //停止動畫
                 self!.recordingIndicator?.stopAnimating()
 
                 //停止辨識
                 self!.audioEngine.stop()
                 self!.recognitionRequest?.endAudio()
                 self!.recognitionTask?.cancel()
                 */
 
                self!.timer?.invalidate()
                

                self!.dismiss(animated: true, completion: nil)
            }
        }
        */
    }

    @objc func removeBtns(){
        
        //send Nc去continue
        
     //   if isCountingTriggered{
            
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "restartCounting"), object: nil, userInfo: nil)
       // }
        

        
        
        ghostBtn.isHidden = true
        alertBg.isHidden = true
        cancelBtn.isHidden = true
        quitBtn.isHidden = true
        leftBtnClickedImg.isHidden = true
        rightBtnClickedImg.isHidden = true
        
        if gameMode == 0 {
            if isPurchased == "0" {
        limitTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NewGameViewController.countLimit), userInfo: nil, repeats: true)
        }
        }

        
    }
    
    @objc func notifyRestartCounting(){
        
    }

    //顯示tagView
    @objc func showTag(){
        
        //避免再次產生hint
        isCheckingSentence = false
        
        tagView.isHidden = false
        recogTextLabel.text = ""
    }

    @objc func notifyReadyToReadSentence(){
        
    }
    
    @objc func readSentence(){
        
        //補足delegate裡沒有enable的功能
        
        if tagView.isHidden {
        recordBtn.isEnabled = true
        
        recordBtn.isHidden = false
        }
        //playSoundBtn.isEnabled = true
        
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
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.showTag), name: NSNotification.Name("showTag"), object: nil)
        
        
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
        
        
        //先確認有沒有購買
        
        if let isPurchasedStatus = user?["isPurchased"] as? String{
            
            //指定好數字
            isPurchased = isPurchasedStatus
            
            if isPurchased == "1"{
                
                //已購買, 不計時
                
                print("no counting time")
                limitTimer.invalidate()
                
                
                limitTimerLabel.text = ""
                removeBtns()
                
                
            } else if isPurchased == "0"{
                
                
                print("start to count time")
                
                if gameMode == 0 {
                    
                    /*
                    limitTimerLabel.center = CGPoint(x: width / 2, y: 60)
                    limitTimerLabel.frame.size = CGSize(width: 50, height: 20)
                    limitTimerLabel.textAlignment = .center
            
                    self.view.bringSubview(toFront: limitTimerLabel)
                    */
                    
                    limitSeconds = UserDefaults.standard.object(forKey: "limitSeconds") as! Int
                    
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
                        
                        print("timesup")
                        
                        limitTimerLabel.text = "0:00"
                        timerPause()
                        
                    }
              
                }
                
            }
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
        
        } else
 
        
        //testing
            if gameMode == 2 {
            
            makeSentence()
            
        }
        
    }
    
    
    @objc func notifyPracticeNextWord(){

        
        //移除tagView
        attrTagsSelected.removeAll(keepingCapacity: false)
        tagView.isHidden = true
        tagView.removeAllTags()
        
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
        //recordBtn.isHidden = true  這應該不用
        }
        
        //輸入重置
        sentenceLabel.text = ""
        chiSentenceLabel.text = ""
        
    }
    
    @objc func notifyBackToSpell(){
        
        //隱藏錄音字欄位
        recogTextLabel.text = ""
        
        recogTextLabel.isHidden = true
        
        //變回錄音鍵
        //recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
        
        recordBtn.isHidden = true
      
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
        firstWordBtn.isHidden = false
        secondWordBtn.isHidden = false
        thirdWordBtn.isHidden = false
        bigOkBtn.isHidden = false
        bigOkBtn.isEnabled = false
        
        firstWordBtn.isEnabled = true
        secondWordBtn.isEnabled = true
        thirdWordBtn.isEnabled = true
        
        firstEngWord.adjustsFontSizeToFitWidth = true
        secondEngWord.adjustsFontSizeToFitWidth = true
        thirdEngWord.adjustsFontSizeToFitWidth = true

        firstChiWord.adjustsFontSizeToFitWidth = true
        secondChiWord.adjustsFontSizeToFitWidth = true
        thirdChiWord.adjustsFontSizeToFitWidth = true
        
        //接收單字數字準備做句子
        
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
                            
                            if let originalScore = user?["score"] as? String{
                                
                                originalPoints = Int(originalScore)!

                                //let currentScore = originalPoints + Int(score[0])!
                               
                                scoreLabel.text = String(originalPoints)
                                
                            } else {
                                //第一次玩的人
                                
                                //最初分數
                                scoreLabel.text = "0"
                                
                                
                                
                            }
                    
                        //scoreLabel.text = score[0]
                    
              
                            moveUpAnimation(label: firstEngWord, text: firstEngWordText)
                    
                            moveUpAnimation(label: secondEngWord, text: secondEngWordText)
                    
                            moveUpAnimation(label: thirdEngWord, text: thirdEngWordText)
                    
                  
                            moveUpAnimation(label: firstChiWord, text: chiWords[0])
                    
                            moveUpAnimation(label: secondChiWord, text: chiWords[1])
                    
                            moveUpAnimation(label: thirdChiWord, text: chiWords[2])
                        
    
                            //popQuiz bonus加分
                            
                           
                            switch popQuizRight[0]{
                                
                            case "-1":
                                print("bonus 0")
                                bigOkBtn.isEnabled = true
                                countScore(score:Int(score[0])!)
                                
                            case "0":
                                print("bonus 1")

                                    
                                bonusAnimation(repeatCount:1)
                                
                                countScore(score: Int(score[0])! + 500)

                                
                                
                            case "1":
                                print("bonus 2")
                                     bonusAnimation(repeatCount:2)
                       
                                countScore(score: Int(score[0])! + 1000)
                                
                                
                            case "2":
                                print("bonus 3")
                                
                                     bonusAnimation(repeatCount:3)
           
                                countScore(score: Int(score[0])! + 1500)
                            default:
                                break
                            }
                            
                                
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "playEndingMusic"), object: nil, userInfo: nil)
                            
                        //如果有錯就不算過關的條件
                        
                        // if wrongWordsCount == 0 {}
                        
                        //目前這裡就先寫成都可以過關

                            //如果玩之前的關卡就不改變---- 現在應該沒有這條件
                   
                        mapNumber -= increaseNum
                    
                        print("increase:\(increaseNum)")
                        
                        print("mapNumer:\(mapNumber)")
                        
                            if user != nil {  // 要保留給第一次進入的玩家
                            
                       //     if mapPassedInt == (mapNumber){   //...
                           //     for (s,u) in gamePassedDic! {      //...
                             //       if s == spotNumber{     //...
                               //         if u == unitNumber{     //...
                                            
                                            print("過關卡")
                                            
                                            //紀錄關卡
                                            if unitNumber == 9{         //代表過一整個課程
                                                
                                                //此探索點已過完, 此探索點要做動態化  ----中級為 14
                                                if spotNumber == maxSpotNum {
                                                    
                                                 
                                                    //備註: 目前map只做4張, 之後要抓正確數字, 以及做全部過關的通知
                                                    
                                                    
                                                    //確認是否為最後一張地圖
                                                    if mapPassedInt == maxMapNum{
                                                        
                                                        
                                                        // 破關訊息
                                                        
                                                        print("破關")
                                                        
                                                        //做破關提示
                                                        
                                                        
                                                        
                                                    
                                                    
                                                        isCelebratingClassPassed = true
                                                        bigOkBtn.setImage(UIImage(named:"classFinishedBtn.png"), for: .normal)
                                                        
                                                        
                                                    } else {
                                                    
              
                                                    
                                                    isCelebratingMapPassed = true
                                                    
                                                    bigOkBtn.setImage(UIImage(named:"unlockOkBtn.png"), for: .normal)

                                                    
                                                    }
                                                    
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

                                                        //有更新地圖才執行
                                                        
                                                        updateMapPassed(course:courseReceived)
                                                        updateGamePassed(course:courseReceived)

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
                                                        
                                                        //pending做一個純粹更新中級的sql
                                                        updateMapPassed(course:courseReceived)
                                                        updateGamePassed(course:courseReceived)
                                                        
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
                                                        
                                                        //pending做一個純粹更新中級的sql
                                                        updateMapPassed(course:courseReceived)
                                                        updateGamePassed(course:courseReceived)
                                                        

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

                                                        
                                                        updateGamePassed(course:courseReceived)
                           
                                                    case 1:
                                        
                                                        gamePassed2 = [spotNumber + 1:0]
                                                        //設定給全部值供上傳後端
                                                        gamePassedDic = gamePassed2
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed2!)
                                                   
                                                        userDefaults.set(encodedObject, forKey: "gamePassed2")
                                                        
                                                        
                                                        //pending update to sql
                                          
                                                        updateGamePassed(course:courseReceived)
                                                        
                                                    case 2:
                                                        
                                                        gamePassed3 = [spotNumber + 1:0]
                                                        //設定給全部值供上傳後端
                                                        gamePassedDic = gamePassed3
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed3!)
                                                       
                                                        userDefaults.set(encodedObject, forKey: "gamePassed3")
                                                       
                                                        
                                                        //pending update to sql
                                                        
                                                        updateGamePassed(course:courseReceived)
                                                        
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
                                                    
                                                    
                                                    updateGamePassed(course:courseReceived)

                                                    
                                                case 1:
                                                    
                                                    print("更新新關卡")
                                                    gamePassed2 = [spotNumber: unitNumber + 1]
                                                    gamePassedDic = gamePassed2
                                                    
                                                    //然後儲存
                                                    let userDefaults = UserDefaults.standard
                                                    let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed2!)
                                              
                                                    userDefaults.set(encodedObject, forKey: "gamePassed2")
                                                    
                                                    //pending update to sql
                                                    updateGamePassed(course:courseReceived)
                                                    
                                                case 2:
                                                    
                                                    print("更新新關卡")
                                                    gamePassed3 = [spotNumber: unitNumber + 1]
                                                    gamePassedDic = gamePassed3
                                                    
                                                    //然後儲存
                                                    let userDefaults = UserDefaults.standard
                                                    let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed3!)
                                                   // mapPassed3 = 0
                                                    userDefaults.set(encodedObject, forKey: "gamePassed3")
                                                   //  UserDefaults.standard.set(mapPassed3!, forKey: "mapPassed3")
                                                    //pending update to sql
                                                    updateGamePassed(course:courseReceived)
                                                    
                                                default:
                                                    break
                                                    
                                                }
                                         
                                            }
                                            
                                            
                                
                                            

                                     //   } else {
                                   //         print("前元素")
                                    
                                 //       }
                               //     } else {
                                        
                             //           print("前探索點")
                           //         }
                         //       }
         
                         //   } else {
                                
                             //   print("前地圖")
                                
                           // }
                        
                        
                                //計算所有字數
                            countWords()
                            } else {
                                
                                
                                //顯示出來
                                wordCountLabel.text = "3"

                                
                            }
                            }
                        }
                }
                    }
                }
            }
        }
    }
    
    

    func countScore(score:Int){
        
        
        //isDragAndPlayEnable = false
        
        let scoreToPass:[String:Int] = ["Score":score]
        //print("score:\(score)")
        countScoreTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(NewGameViewController.startCounting), userInfo: scoreToPass, repeats: true)
        
        
    }
    
    
    @objc func startCounting(){
        
        // print("1")
        if let userInfo = countScoreTimer.userInfo as? Dictionary<String, Int>{
            //print("2")
            if let scoreToAdd = userInfo["Score"]{
                //   print("3")
                
 
                
                //let size = CGSize(width: 100, height: 100)
                
                //print("scoreAdded:\(scoreAdded) and score:\(scoreToAdd)")
                if scoreAdded < scoreToAdd {
                    // print("4")
                    
                    scoreAdded += 10
                    scoreLabel.text = String(Int(scoreLabel.text!)! + 10)
                } else {
                    //   print("5")
                    scoreAdded = 0
                    countScoreTimer.invalidate()
                    
                    //加完分後直接上傳
                    bigOkBtn.isEnabled = true
                    
                    
                }
                
            }
        }
    }
    
    func countWords(){
        //計算所有字數
        
        var wordsCounts = Int()


        switch courseReceived{
            
        case 0:
            
            
            wordsCounts += mapPassed! * 450
            
            
            for (s,u) in gamePassed!{
                
                wordsCounts += s * 30 + u * 3
                
            }
            
         
            
        case 1:
            
            
            wordsCounts += mapPassed2! * 450
            
            
            for (s,u) in gamePassed2!{
                
                wordsCounts += s * 30 + u * 3
                
            }
            
            
        case 2:
            
            
            wordsCounts += mapPassed3! * 450
            
            
            for (s,u) in gamePassed3!{
                
                wordsCounts += s * 30 + u * 3
                
            }
            
        default:
            break
            
        }

        //顯示出來
        wordCountLabel.text = String(wordsCounts)
        
    }
    
    @IBAction func firstWordClicked(_ sender: Any) {
        
        if user != nil {
        
        if isParseEnabled{
               isParseEnabled = false
            addWord(word: firstEngWordText)
            moveUpAndGone(label: word1Label)
            
        }
        } else {
            
                        moveUpAndGone(label: word1Label)
        }
        
    }
    @IBAction func secondWordClicked(_ sender: Any) {
        
        if user != nil {
        
        if isParseEnabled{
            isParseEnabled = false
            addWord(word: secondEngWordText)
            moveUpAndGone(label: word2Label)
            
        }
        } else {
            
                        moveUpAndGone(label: word2Label)
        }
    }
    
    @IBAction func thirdWordClicked(_ sender: Any) {
        
        
        if user != nil {
        if isParseEnabled{
            isParseEnabled = false
            addWord(word: thirdEngWordText)
            moveUpAndGone(label: word3Label)
            
        }
        } else {
            
                        moveUpAndGone(label: word3Label)
        }
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
      
        let originY = bonusScoreLabel.frame.origin.y
        //bonusScoreLabel.frame.origin.y = originY + 20
        

            //UIView.animate(withDuration: 0.3, animations: {[weak self] in
            UIView.animate(withDuration: 0.7, delay: 0.5, options: [.curveEaseIn], animations: {[weak self] in
                
                  // UIView.setAnimationRepeatCount(repeatCount)
                
                self!.bonusScoreLabel.alpha = 1
                self!.bonusScoreLabel.frame.origin.y = originY - 15
                
                
                
            }) { (finished:Bool) in
                UIView.animate(withDuration: 0, delay: 0.5, options: .curveEaseIn, animations: {[weak self] in
                    
                    self!.bonusScoreLabel.alpha = 0
                    
                    }, completion: {[weak self] (true) in
                        
                            self!.bonusScoreLabel.frame.origin.y = originY
               
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
    
    
    /*
    func bonusAnimation(){
        
        
        bonusScoreLabel.alpha = 0.3
        let originY = bonusScoreLabel.frame.origin.y
        bonusScoreLabel.frame.origin.y = originY + 20
        UIView.animate(withDuration: 0.3) {[weak self] in
            self!.bonusScoreLabel.alpha = 1
            self!.bonusScoreLabel.frame.origin.y = originY
            
        }
        
        
    }
    */
    //開始辨識聲音
    @objc func startToRecognize(){

        //顯示按鈕, 顯示label
        recordBtn.isHidden = false

        recogTextLabel.isHidden = false
        
        //回復錄音輸入的單字或句子
        wordRecorded = String()
        
        //對字
        isCheckingSentence = false
        
        //指定答案的字
        wordToReceive = synWord

        
        
        //移除標點符號
        wordToReceive = wordToReceive.removingCharacters(inCharacterSet: CharacterSet.punctuationCharacters)
        
        //改成小寫
        wordToReceive = wordToReceive.lowercased()
        
        hintLabel.text = "請按一下麥克風"
        
       
    }
    
    //接收發音單字
    
    /*
    @objc func pronounceWord(_ notification: NSNotification){

        if let wordToPronunce = notification.userInfo?["wordToPass"] as? String {
                //設訂發音的單字
                synWord = wordToPronunce

        }
        //發音
        synPronounce()
    }
    */
    
    
    var pronounceTime = Int()
    @objc func pronounceWord(_ notification: NSNotification){
        
        //一定要指定要說幾次
        guard let speakTime = notification.userInfo?["pronounceTime"] as? Int else{
            return
        }
        pronounceTime = speakTime
        
        //要發音的單字或句子可有可無
        if let wordToPronunce = notification.userInfo?["wordToPass"] as? String {
            
            //設訂發音的單字
            synWord = wordToPronunce
            
            //確認是否有別的發音
            
            //抓發音錯誤字集
            for i in 0 ..< wrongPronounceWords.count{
                
                for (word,rightWord) in wrongPronounceWords[i]{
                    
                    //假如有抓到的話
                    if word == wordToPronunce{
                        print("found wrond pronounce word")
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
            if isCheckingSentence{
                
                //檢查
                self.checkSentence()
           
                //隱藏Btn, 以便顯示句子得分的img
                recordBtn.isHidden = true
           
            } else {
                self.checkWord()
                
            }

            
        }  else {
            

            hintLabel.text = "請唸單字"
            
            
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
            
            
            
            for new in newRels {
                
                let keyArray = new.components(separatedBy: ":")
                if keyArray[0].replacingOccurrences(of: " ", with: "") ==  wordToReceive{
                    
                    
                    print(" found rel words")
                    let rels = keyArray[1].components(separatedBy: ", ")
                    for r in rels{
                        
                        relWordsFound.append(r)
                    }
                }
                
                
                
                
            }
            
            print(relWordsFound)
            //抓發音錯誤字集
            /*
            for i in 0 ..< relevantWords2.count{
                
                for (word,rels) in relevantWords2[i]{

                    //假如有抓到的話
                    if word == wordToReceive{
                        
                        relWords = rels
  
                    }

                }

                
            }
*/
            //開始辨識
           

            do {
 
                try audioSession.setCategory(AVAudioSessionCategoryRecord)
                try audioSession.setMode(AVAudioSessionModeMeasurement)
                try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
                
          
                if let inputNode = audioEngine.inputNode as AVAudioInputNode?{
                    
                    recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

                    guard let recognitionRequest = recognitionRequest else {
                        fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
                    }
                    
                    recognitionRequest.shouldReportPartialResults = true
                    
                    self.recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: {[weak self] (result, error) in
                        
                        
                        if let result = result {
    
                            if let resultWord = result.bestTranscription.formattedString.lowercased() as String?{
                                
                                
                                self!.hintLabel.text = "再按一下麥克風結束"
                                
                                
                                if relWordsFound.count != 0 {
                                    print("not nil")
                                    if relWordsFound.contains(resultWord){
                                        
                                        
                                        print(relWordsFound)
                                        self!.recogTextLabel.text = self!.wordToReceive
                                        
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
                                
                                //self!.recordBtn.setTitle("Start Recording", for: [])
                                
                                
                            }
                            
                        }
                        
                    })
                    
                    let recordingFormat = inputNode.outputFormat(forBus: 0)
   
                    //先移除之前的
                    inputNode.removeTap(onBus: 0)
                    inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat, block: {[weak self] (buffer, when) in
                        
                        self!
                            .recognitionRequest?.append(buffer)
           
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
        updateScore(score:updatePoints, wrongWordsCount:wrongChineseCounts, proRate:proRate, senRate:senRate)
        
            
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
            
        } else {
            //第一次嘗試玩
            
            print("first time play")
            
            //註冊畫面
            
            performSegue(withIdentifier: "toRegisterVc", sender: self)
            

            
        }
        
        

        
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        
        
        if segue.identifier == "toRegisterVc" {
            
            let registerVc = segue.destination as! RegisterViewController
            
            registerVc.coursePlayed = courseReceived
            registerVc.wrongWordsToAdd = wrongWordsToSend
            registerVc.scoresToAdd = scoresToSend
            registerVc.proRateToAdd = proRate
            registerVc.senRateToAdd = senRate
            registerVc.wrongChineseCount = wrongChineseCounts
            
            
        } else if segue.identifier == "fromGameToPurchase"{
            
            
            let purchaseVc = segue.destination as! PurchaseViewController
            
            purchaseVc.isDirectedFromGame = true
            
        }
        
        
    }

    //檢查句子

    //這裡的func 已經用不到了...
    
    func checkSentence(){
        print("trigger check sentence")
        var attrSentence = NSMutableAttributedString()
        
        let attrs0 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 35), NSAttributedStringKey.foregroundColor : UIColor.white]
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 35), NSAttributedStringKey.foregroundColor : UIColor.magenta]
        
        var recorded = [String]()
        var received = [String]()
        var completeWords = [String]()
        
        recorded = wordRecorded.components(separatedBy: " ")
        received = wordToReceive.components(separatedBy: " ")
        completeWords = completeWordsToShow.components(separatedBy: " ")
        
        
        //寫一個對答案比例的func
        var finalPoints = Int()
        let unitPoint = 100 / received.count
        var pointGet = Int()
        var pointMinus = Int()
        
        //計分算法, 基本上還是要按照順序來計算
        if recorded == received{
            
            finalPoints = 100
            
        } else {
            
            for i in 0 ..< received.count{
                
                
                if i < recorded.count{
                    if recorded[i] == received[i]{
                        if i == 0 {
                            
                            attrSentence = NSMutableAttributedString(string: completeWords[i] + " ", attributes: attrs0)
                        } else {
                            
                            attrSentence.append(NSMutableAttributedString(string: completeWords[i] + " ", attributes: attrs0))
                        }
                        
                    } else {
                        
                        if i == 0 {
                            
                            attrSentence = NSMutableAttributedString(string: completeWords[i] + " ", attributes: attrs1)
                        } else {
                            
                            attrSentence.append(NSMutableAttributedString(string: completeWords[i] + " ", attributes: attrs1))
                        }
                    }
                } else {
                    
                    
                    if i == 0 {
                        
                        attrSentence = NSMutableAttributedString(string: completeWords[i] + " ", attributes: attrs1)
                    } else {
                        
                        attrSentence.append(NSMutableAttributedString(string: completeWords[i] + " ", attributes: attrs1))
                    }
                }
                
                for r in 0 ..< recorded.count{
                    
                    if recorded[r] == received[i]{
                        
                        //假如有字對到
                        
                        pointGet += 1
                        
                    }
                    
                }
                
            }
            
            //顯示label字的正確與否 用顏色分辨
            recogTextLabel.attributedText = attrSentence
            
            //避免分數超過
            if pointGet > received.count{
                pointGet = received.count
            }
            
            finalPoints = pointGet * unitPoint
        }
        
        //如果輸入的字更多要扣分
        if recorded.count > received.count{
            
            pointMinus = recorded.count  - received.count
            finalPoints = finalPoints - pointMinus * unitPoint / 2
            
            if finalPoints < 0 {
                finalPoints = 0
            }
            
        }
        
        //結果決定圖片
        /*
         if finalPoints >= 70 {
         recordBtn.setImage(UIImage(named:"recordCheck.png"), for: .normal)
         } else{
         recordBtn.setImage(UIImage(named:"recordCross.png"), for: .normal)
         }
         */
        
        //計算分數
        var score = Int()
        score = 500 * finalPoints / 100
        
        //卡一下顯示分數
        //之後可以改變分數高低不同的img顏色
 
        let pointImg = UIImageView()
        let pointLabel = UILabel()
     
        pointImg.frame = CGRect(x: recordBtn.frame.origin.x, y: recordBtn.frame.origin.y, width: recordBtn.frame.width, height: recordBtn.frame.height)
        pointImg.image = UIImage(named: "pointImg.png")
        self.view.addSubview(pointImg)
       
        pointLabel.frame = CGRect(x: 0, y: recordBtn.frame.height / 3.5, width: recordBtn.frame.width, height: 60)
        pointLabel.backgroundColor = .clear
        pointLabel.textColor = .white
        pointLabel.font = UIFont(name: "Helvetica Bold", size: 40)
        pointLabel.textAlignment = .center
        pointLabel.text = "\(finalPoints)%"
        pointImg.addSubview(pointLabel)
        
        //pointsIndicator?.startAnimating()
        
        //隱藏recordBtn
        //recordBtn.isHidden = true
        
        //讓分數停留一下後再消失
        let when = DispatchTime.now() + 1.5
        
        //接著做選擇題, 所有顯示的func都包在下方
        DispatchQueue.main.asyncAfter(deadline: when) {[weak self] in
            
            pointImg.removeFromSuperview()

//            self!.pointsIndicator?.stopAnimating()
            
            //製作tags
            self!.sentenceTag = self!.sentence.components(separatedBy: " ")
            
            
            self!.sentenceTag.shuffled()
            
            
            //在此可以決定句子有多少個字
            
            if self!.sentenceTag.count > 10 {
                //10個字以上
                
                
                
            } else {
                
                
            }
            
            
            print("製作句子 check sentence")
            
            
            
            for i in 0 ..< self!.sentenceTag.count{
                
                self!.tagView.addTag(self!.sentenceTag[i] + " " + String(i))
                
                
                
            }
 
            
            //self!.tagView.addTags(self!.sentenceTag)
            
            
            //準備選擇題
            self!.sentenceLabel.text = ""
            
            //算分數 + 啟動tag的機制 (目前修正成nc去啟動倒數）
            let addScore:[String:Int] = ["addScore":score,"finalPoints":finalPoints]
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addScore"), object: nil, userInfo: addScore)
            
            //給暫停使用的
           // self!.isCountingTriggered = true
            
            //隱藏輸入字
            self!.recogTextLabel.text = ""
            
            //顯示出tag
            self!.tagView.isHidden = false
            
            //避免再次產生hint
            self!.isCheckingSentence = false
            
            //發音
            self!.pronounceTime = 1
   
            self!.synPronounce()
            

        }
        
        
    }
    
    
    func checkWord(){
        
        //正確
        if wordRecorded == wordToReceive{
            
            hintLabel.text = "很棒喔！"
            
            recordBtn.setImage(UIImage(named:"recordCheck.png"), for: .normal)
            
            isRecogWordCorrect = true
            
            //正確暫時不改顏色
            proRate += 1

        } else {
            
            hintLabel.text = "Oops！錯了喔!"
       
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
            
                let addScore:[String:Int] = ["addScore":score]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "backToSpell"), object: nil, userInfo: addScore)
                
            } else {
                
                
                if self!.answerTime < 1 {
                    
                    //可以繼續練習
                    
                    self!.hintLabel.text = "再試一次"
                
                    self!.answerTime += 1
                    
                    self!.recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
                    self!.recordBtn.isHidden = false
                    self!.recordBtn.isEnabled = true
                
                } else {
                    //失敗跳離畫面
                    self!.answerTime = 0
                    
                    
                    self!.hintLabel.text = ""
                    let addScore:[String:Int] = ["addScore":0]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "backToSpell"), object: nil, userInfo: addScore)
                    
                    
                }
                
            }
        }
        
    }
    
    @objc func onlyPracticeSentence(_ notification: NSNotification){
        print("接到nc")
        
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
            
            
            //移除
            
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
            print("1")
            
            //英文句子
            sentence = allSentenceSets[randomSpots[Int(wordSequenceToReceive)!]][randomUnits[Int(wordSequenceToReceive)!]]
            
            let halfCount = allSentenceSets[randomSpots[Int(wordSequenceToReceive)!]].count / 2
              print("2")
            
            //中文句子
            chiSentence = allSentenceSets[randomSpots[Int(wordSequenceToReceive)!]][randomUnits[Int(wordSequenceToReceive)!] + halfCount]
              print("3")
            
            /*
            print(sentence)
            print(chiSentence)
            */
            
            //製作4個中文選項Btn
            for btn in allBtns{
                btn.isHidden = false
            }

              print("4")
            //抓好中英文句子答案
            sentenceLabel.text = sentence
            chiSentenceLabel.text = "請選出正確中文翻譯"
            
              print("5")

            //準備做四個選項
            var senBtnTitles = ["","","",""]
           
            //抓一個正確的隨機置放位置, 放中文答案進去
            correctRandom = Int(arc4random_uniform(UInt32(4)))
            senBtnTitles[correctRandom] = chiSentence
            
              print("6")
            
            //填入數字
            allRandomSens = Array(repeating: [Int:Int](), count: 4)
            
            //填入正確句子的數字
            allRandomSens[correctRandom] = [randomSpots[Int(wordSequenceToReceive)!]:randomUnits[Int(wordSequenceToReceive)!]]
            
  print("7")
            //設定好正確的按鈕
            allBtns[correctRandom].addTarget(self, action: #selector(NewGameViewController.rightSenButtonClicked), for: .touchUpInside)
            allBtns[correctRandom].tag = correctRandom

              print("8")

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
            
              print("9")
            
 
            //設定所有案件的中文內文
            for i in 0 ..< allBtns.count {
         
                allBtns[i].contentHorizontalAlignment = .left
               
                allBtns[i].setTitle("\(i + 1). " + senBtnTitles[i], for: .normal)
          
            }
              print("10")

            //避免再次產生hint
            isCheckingSentence = false
            
            //newMakeSentenceTest()
            
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
            guidedSentence()
        }
        
        //句子發音
        synWord = sentence
   

        synPronounce()
    }
    
    
    var isReadingGuidedSentence = false
    
    func guidedSentence(){
        //英文句子
        sentence = sentenceSets[Int(wordSequenceToReceive)!]
        let halfCount = sentenceSets.count / 2
        chiSentence = sentenceSets[halfCount + Int(wordSequenceToReceive)!]
        //抓好中英文句子答案
        sentenceLabel.text = sentence
        chiSentenceLabel.text = chiSentence

        isReadingGuidedSentence = true

        
    }
    
    
    @IBAction func circleOkBtnClicked(_ sender: Any) {
        
        newMakeSentenceTest()
    }
    
    
    
    func newMakeSentenceTest(){
       
        circleOkBtn.isHidden = true
        
        synPronounce()
        
        print("正常製造句子的功能")
        //只練習句子

        //英文句子
        // sentence = sentenceSets[Int(wordSequenceToReceive)!]
        let halfCount = sentenceSets.count / 2
        //chiSentence = sentenceSets[halfCount + Int(wordSequenceToReceive)!]
        

        print(sentence)
        print(chiSentence)

 /*
         print(sentence)
         print(chiSentence)
         */
        
        //製作4個中文選項Btn
        for btn in allBtns{
            btn.isHidden = false
        }
        

        //抓好中英文句子答案
     //   sentenceLabel.text = sentence
       chiSentenceLabel.text = "請選出正確中文翻譯"

        
        //準備做四個選項
        var senBtnTitles = ["","","",""]
        
        //抓一個正確的隨機置放位置, 放中文答案進去
        correctRandom = Int(arc4random_uniform(UInt32(4)))
        senBtnTitles[correctRandom] = chiSentence

        
        //填入數字
   
        //randomSens = Array(repeating: Int(), count: 4)
        
        randomSens = [Int(),Int(),Int(),Int()]
        randomSens[correctRandom] = Int(wordSequenceToReceive)!
        print(randomSens)
        
        /*
        allRandomSens = Array(repeating: [Int:Int](), count: 4)
        
        //填入正確句子的數字
        allRandomSens[correctRandom] = [randomSpots[Int(wordSequenceToReceive)!]:randomUnits[Int(wordSequenceToReceive)!]]
        */
        

        
        
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
            print(i)
        }
        print("randomSens:\(randomSens)")
        
        /*
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
        */
        print("9")
        
        
        //設定所有案件的中文內文
        for i in 0 ..< allBtns.count {
            
            allBtns[i].contentHorizontalAlignment = .left
            
            allBtns[i].setTitle("   \(i + 1). " + senBtnTitles[i], for: .normal)
            
        }
        print("10")
        
        //避免再次產生hint
        isCheckingSentence = false

        
        
    }
    
    @objc func rightSenButtonClicked(sender:UIButton){
        print("correct")
        
        //做圈圈記號
        /*
        correctSign.frame = CGRect(x: allBtns[correctRandom].frame.midX - allBtns[correctRandom].frame.width / 10, y: allBtns[correctRandom].frame.minY - allBtns[correctRandom].frame.height * 0.1, width: allBtns[correctRandom].frame.height * 1.2, height: allBtns[correctRandom].frame.height * 1.2)
        correctSign.image = UIImage(named:"rightCircle.png")
        self.view.addSubview(correctSign)
        self.view.bringSubview(toFront: correctSign)
        */

        //錯誤按鈕改圖片
        sender.setBackgroundImage(UIImage(named:"answerRightBtn.png"), for: .normal)
        
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
        print("wrong")
        
        
        if gameMode == 2 {
        isReviewWrong = true
        }
        //錯誤按鈕改圖片
        sender.setBackgroundImage(UIImage(named:"wrongSenBlock.png"), for: .normal)
        
        
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
        self.view.bringSubview(toFront: wrongSign)
        
        
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
            title = "單字達成"
            unit = "字"
        case 1:
            bgImage = "reviewWordResultBg.png"
            title = "句型達成"
            unit = "句"
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
            print("trigger jumpToTag")
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
            btn.setBackgroundImage(UIImage(named:"senBlock.png"), for: .normal)
        }
        
        sentenceLabel.text = ""
        chiSentenceLabel.text = chiSentence
        recogTextLabel.isHidden = false
        
        makeTag()
        
    }
    
    
    //選擇題
    func makeTag(){
        
        
        print("makeTag 製作句子")
        

        
        
        //製作tags
        sentenceTag = sentence.components(separatedBy: " ")
        
        //亂數
        sentenceTag.shuffled()
        
        //加入tag裡
        
        
        sentenceCounts = sentenceTag.count
        
        
        switch sentenceCounts{
            
        case 0...9:
            senFontSize += 2
            
        case 10 ..< 15:
            print("小於15個字")
            
        case 15 ..< 20:
            print("字數15-20")
            
            senFontSize -= 2
            
        case 20...23:
            
            print("字數20 - 23以上")
            senFontSize -= 4
            
            
            case 24...26:
            print("字數24 - 26")
            
            senFontSize -= 6
            
        case 26...:
            print("字數26以上")
            senFontSize -= 8
            
        default:
            break
   
            
            
        }
        
        
        
        
        tagView.textFont = UIFont.boldSystemFont(ofSize: senFontSize)

        
        
        for i in 0 ..< sentenceTag.count{
            
            //後方加入數字做辨認
            tagView.addTag(sentenceTag[i] + " " + String(i))
            
        }
 
        
        
        
        //tagView.addTags(sentenceTag)
        
        
        
        //準備選擇題
        sentenceLabel.text = ""
        
        //算分數 + 啟動tag的機制 (目前修正成nc去啟動倒數）
        let score = Int()
        let finalPoints = Int()
        
        let addScore:[String:Int] = ["addScore":score,"finalPoints":finalPoints]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addScore"), object: nil, userInfo: addScore)
 
        
        //隱藏輸入字
        
        
        recogTextLabel.text = ""
        
        //做提示
        
        let attrs0 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedStringKey.foregroundColor : UIColor.white]
        
        recogTextLabel.attributedText = NSAttributedString(string: "點擊下列單字來排列句型", attributes: attrs0)
        
        //顯示出tag
        tagView.isHidden = false
        
        //避免再次產生hint
        isCheckingSentence = false
        
        //發音
        pronounceTime = 1

        synPronounce()
        
    }

    
    
    //取亂數不重複的func
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
    
    //新版的getRandom於下
    
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
        recogTextLabel.text = sentenceShown
        
        //抓輸入答案來對
        let answerEntered = recogTextLabel.text?.dropLast()
        
        if answerEntered! == sentence{
            
        //    isCountingTriggered = false
            
            //跳轉下個字
            
            if gameMode == 0 {
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
                    print("結束練習")
                    
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

    
    //倒數結束立即停止快速複習
    /*
    @objc func stopReview(){
        
        if gameMode == 1 {
            reviewResult(type:0)
        } else if gameMode == 2{
        reviewResult(type:1)
        }
    }
    */
    
    @objc func stopReview(_ notification:NSNotification){
        
        //抓分數
        
        if gameMode == 1 {
            
            
            if let wordCount = notification.userInfo?["wordCount"] as? Int{
                
                //在此updateWordCount
                
                print(wordCount)
                updateReviewWordCount(wordCount: wordCount, course:courseReceived)
                
                
            }
            
        } else if gameMode == 2 {
            
            updateReviewSenCount(senCount: senCount, course:courseReceived)
            
        }
        
            /* gameMode == 2 不會從NC過來, 直接在VC裡
        else if gameMode == 2{
            
            if let senCount = notification.userInfo?["senCount"] as? Int{
            
            
                print(senCount)
            updateReviewSenCount(senCount: senCount, course:courseReceived)
        
            
            }
            
            
        }
        */
  
    }
    
    
    func updateReviewWordCount(wordCount:Int, course:Int){
        
        
        let id = user?["id"] as! String
        
        // url to access our php file
        let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/updateWordReviewCount.php")!
        
        // request url
        var request = URLRequest(url: url)
        
        // method to pass data POST - cause it is secured
        request.httpMethod = "POST"
        
        
        // body gonna be appended to url
        let body = "userID=\(id)&wordCount=\(wordCount)&course=\(course)"
        
        // append body to our request that gonna be sent
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {[weak self] data, response, error in
            // no error
            if error == nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    guard let parseJSON = json else {
                        print("Error while parsing")
                        
                        //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                        return
                    }
                    
                    //print("rank")
                    //再次儲存使用者資訊
                    
                    print(parseJSON)
                    
                    var tempCount = Int()
                    var tempJsonName = String()
                    var otherCountName = String()
                    var otherCountName2 = String()
                    var totalCount = Int()
                
                    
                    switch course{
                        
                    case 0:
                        tempJsonName = "wordReviewCount"
                        otherCountName = "wordReviewCount2"
                        otherCountName2 = "wordReviewCount3"

                    case 1:
                        tempJsonName = "wordReviewCount2"
                        otherCountName = "wordReviewCount"
                        otherCountName2 = "wordReviewCount3"
                        
                        
                    case 2:
                        tempJsonName = "wordReviewCount3"
                        otherCountName = "wordReviewCount"
                        otherCountName2 = "wordReviewCount2"
                        
                    default:
                        break
                        
                        
                    }
                    
                    //如果有抓到該更新數字
                    if let resultCount = parseJSON[tempJsonName] as? String{
                        
                        //只有正確更新時會回傳user資訊
                        user = parseJSON
                        //有更新的狀態
                        print("updated Count")
                        tempCount = Int(resultCount)!
                        let otherCount = user?[otherCountName] as! String
                        let otherCount2 = user?[otherCountName2] as! String
                    
                        totalCount = tempCount + Int(otherCount)! + Int(otherCount2)!
                        
                        
                        
                        
                    } else {
                        
                        //無更新的狀態
                        
                        
                        print("original Count")
                        let count = user?["wordReviewCount"] as! String
                        let otherCount = user?["wordReviewCount2"] as! String
                        let otherCount2 = user?["wordReviewCount3"] as! String

                        totalCount = Int(count)! + Int(otherCount)! + Int(otherCount2)!

                    }
                    
         
                    DispatchQueue.main.async(execute: {
                        self!.reviewResult(type:0, count:totalCount)
                    })
                    

                    
                    
                    //抓名次
                    
                    //             if let parseJsonDic = parseJSON as [NSDictionary]?{
                    
                    
                    //       }
                    
                } catch{
                    
                    print("catch error")
                    
                }
            } else {
                
                print("urlsession has error")
                
            }
        }).resume()
        
    }
    
    
    
    func updateReviewSenCount(senCount:Int, course:Int){
        
        
        let id = user?["id"] as! String
        
        // url to access our php file
        let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/updateSenReviewCount.php")!
        
        // request url
        var request = URLRequest(url: url)
        
        // method to pass data POST - cause it is secured
        request.httpMethod = "POST"
        
        
        // body gonna be appended to url
        let body = "userID=\(id)&senCount=\(senCount)&course=\(course)"
        
        // append body to our request that gonna be sent
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {[weak self] data, response, error in
            // no error
            if error == nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    guard let parseJSON = json else {
                        print("Error while parsing")
                        
                        //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                        return
                    }
                    
                    //print("rank")
                    //再次儲存使用者資訊
                    
                    print(parseJSON)
                    
                    var tempCount = Int()
                    var tempJsonName = String()
                    var otherCountName = String()
                    var otherCountName2 = String()
                    var totalCount = Int()
                    
                    
                    switch course{
                        
                    case 0:
                        tempJsonName = "senReviewCount"
                        otherCountName = "senReviewCount2"
                        otherCountName2 = "senReviewCount3"
                        
                    case 1:
                        tempJsonName = "senReviewCount2"
                        otherCountName = "senReviewCount"
                        otherCountName2 = "senReviewCount3"
                        
                        
                    case 2:
                        tempJsonName = "senReviewCount3"
                        otherCountName = "senReviewCount"
                        otherCountName2 = "senReviewCount2"
                        
                    default:
                        break
                        
                        
                    }
                    
                    //如果有抓到該更新數字
                    if let resultCount = parseJSON[tempJsonName] as? String{
                        
                        //只有正確更新時會回傳user資訊
                        user = parseJSON
                        //有更新的狀態
                        print("updated Count")
                        tempCount = Int(resultCount)!
                        let otherCount = user?[otherCountName] as! String
                        let otherCount2 = user?[otherCountName2] as! String
                        
                        totalCount = tempCount + Int(otherCount)! + Int(otherCount2)!
                        
                        
                        
                        
                    } else {
                        
                        //無更新的狀態
                        
                        
                        print("original Count")
                        let count = user?["senReviewCount"] as! String
                        let otherCount = user?["senReviewCount2"] as! String
                        let otherCount2 = user?["senReviewCount3"] as! String
                        
                        totalCount = Int(count)! + Int(otherCount)! + Int(otherCount2)!
                        
                    }
                    
                    
                    DispatchQueue.main.async(execute: {
                        self!.reviewResult(type:1, count:totalCount)
                    })
                    
                    
                    
                    
                    //抓名次
                    
                    //             if let parseJsonDic = parseJSON as [NSDictionary]?{
                    
                    
                    //       }
                    
                } catch{
                    
                    print("catch error")
                    
                }
            } else {
                
                print("urlsession has error")
                
            }
        }).resume()
        
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
            
            try audioSession.setCategory(AVAudioSessionCategoryAmbient)
            try audioSession.setMode(AVAudioSessionModeDefault)
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
          //  print("唸句子")
          //  print(synWord)
            
            //delay要做0, delegate才會發音結束準時告知
            utterance.postUtteranceDelay = 0
            
        } else {
        //    print("唸單字")
        //    print(synWord)
            rateFloat = 0.45
            utterance.postUtteranceDelay = 0
        }
        
        
        utterance2.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance2.rate = rateFloat
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = rateFloat
        
        
        stopSpeech()
        synth.speak(utterance)
        
        
        /* 下方功能為兩次發音先不需要
        //發音等待時間
        let when = DispatchTime.now() + 2.7
        
        DispatchQueue.main.async {[weak self] in
            
            guard let strongSelf = self else{
                return
            }
            //strongSelf.synth.stopSpeaking(at: .immediate)
            strongSelf.synth.speak(utterance)

            
            if strongSelf.pronounceTime == 2 {
                
                DispatchQueue.main.asyncAfter(deadline: when, execute: {
                    strongSelf.synth.speak(utterance2)

                })
                
            }
        }
        
        */
    }

    

    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance){
       
        //print("**start")
        recordBtn.isEnabled = false
        
    }
    
    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance){

        print("**Finish")
       
        if isCheckingSentence{

            
            print("trigger readyToReadSentence")
            //檢查句子前先發hint
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "readyToReadSentence"), object: nil, userInfo: nil)
        }
        
        
        if isReadingGuidedSentence{
            
            
            circleOkBtn.isHidden = false
            isReadingGuidedSentence = false
        }
        
        if !synth.isSpeaking{
            recordBtn.isEnabled = true
            print("really pause")
       
        } else {
        
            //避免delegate不成功...此function可能不需要暫時留著需要注意timer有沒有invalidate..
            print("not yet Paused")
            waitTimer.invalidate()
            waitTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(NewGameViewController.waitTime), userInfo: nil, repeats: true)
        }
        
        
    }
    
    
    //避免delegate不成功的TIMER
    @objc func waitTime(){
        
        print("enter Timer")
        if !synth.isSpeaking{
            recordBtn.isEnabled = true
            print("timer pause")
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

    //更新mapPassed
    
    func updateMapPassed(course:Int){
        
        
        let id = user?["id"] as! String
        
        // url to access our php file
        let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/mapPassed.php")!
        
        // request url
        var request = URLRequest(url: url)
        
        // method to pass data POST - cause it is secured
        request.httpMethod = "POST"
        
        // body gonna be appended to url
        let body = "userID=\(id)&mapPassed=\(mapPassedInt)&course=\(course)"
        
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
                    
                    //再次儲存使用者資訊
                    UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                    user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary

                    print(user!)
                    print("mapPassed updated")
                    
                } catch{
              
                    print("catch error")
                    
                    
                }
            } else {
                print("urlsession has error")
                
            }
        }).resume()

        
        
    }
    
    
    //更新gamePassed
    func updateGamePassed(course:Int){
        
        
        let id = user?["id"] as! String
        
        // url to access our php file
        let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/gamePassed.php")!
        
        // request url
        var request = URLRequest(url: url)
        
        // method to pass data POST - cause it is secured
        request.httpMethod = "POST"
        
        var gamePassedString = String()
        
        
        for (s,u) in gamePassedDic!{
            
            gamePassedString = String(s) + ":" + String(u)
            
        }
        
        // body gonna be appended to url
        let body = "userID=\(id)&gamePassed=\(gamePassedString)&course=\(course)"
        
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
                    
                    //再次儲存使用者資訊
                    UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                    user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                    
                    
                    print("gamePassed updated")
                    
                } catch{
                    
                    print("catch error")
                    
                    
                }
            } else {
                print("urlsession has error")
                
            }
        }).resume()
        

        
    }
    

    
    
    //新增最愛單字
    func addWord(word:String){
        
        //確認該字沒有在最愛之內
        if !myWords.contains(word){
            
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
            
            URLSession.shared.dataTask(with: request, completionHandler: {[weak self] data, response, error in
                // no error
                if error == nil {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        guard let parseJSON = json else {
                            print("Error while parsing")
                            //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                                self?.isParseEnabled = true
                            return
                        }
                        
                        //再次儲存使用者資訊
                        UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                        //載入我的最愛單字
                        if let myWordsString = user!["myWords"] as! String?{
                            self!.myWords = myWordsString.components(separatedBy: ";")
                            
                        }
                        self?.isParseEnabled = true

                    } catch{
                            self?.isParseEnabled = true
                        print("catch error")
                        
                        
                    }
                } else {
                        self?.isParseEnabled = true
                    print("urlsession has error")
                    
                }
            }).resume()
        } else {
            
            print("alreaded added")
            isParseEnabled = true
        }
    }
    
    //刪除最愛單字---這部分要到單字集裡面做
    
    func removeWord(word:String){
        
        if myWords.contains(word) {
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
            
            URLSession.shared.dataTask(with: request, completionHandler: {[weak self] data, response, error in
                // no error
                if error == nil {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        guard let parseJSON = json else {
                            print("Error while parsing")
                                self?.isParseEnabled = true
                            //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                            return
                        }
                        
                        //再次儲存使用者資訊
                        UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                        print(user!)
                        //載入我的最愛單字
                        if let myWordsString = user!["myWords"] as! String?{
                            self!.myWords = myWordsString.components(separatedBy: ";")
                            
                        }

                            self?.isParseEnabled = true
                        
                    } catch{
                        
                            self?.isParseEnabled = true
                        print("catch error")
                        
                    }
                } else {
                        self?.isParseEnabled = true
                    print("urlsession has error")
                    
                }
            }).resume()
        }
    }
    
    func updateScore(score:Int, wrongWordsCount:Int, proRate:Int, senRate:Int){
        
  
            let id = user?["id"] as! String
            
            // url to access our php file
            let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/updateScore.php")!
            
            // request url
            var request = URLRequest(url: url)
            
            // method to pass data POST - cause it is secured
            request.httpMethod = "POST"
            
            // body gonna be appended to url
            let body = "userID=\(id)&score=\(score)&wrongWordsCount=\(wrongWordsCount)&proRate=\(proRate)&senRate=\(senRate)"
            
            // append body to our request that gonna be sent
            request.httpBody = body.data(using: .utf8)
            
            URLSession.shared.dataTask(with: request, completionHandler: {[weak self] data, response, error in
                // no error
                if error == nil {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        guard let parseJSON = json else {
                            print("Error while parsing")
                     
                            //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                            return
                        }
                        
                        print("updateScore")
                        //再次儲存使用者資訊
                        UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                        print(user!)
        
                        
                   
                        
                    } catch{
              
                        print("catch error")
                        
                    }
                } else {
                
                    print("urlsession has error")
                    
                }
            }).resume()
        
    }
    
    /*
    func playSound() {
        guard let url = Bundle.main.url(forResource: sentenceToPronounce, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
*/
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
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
