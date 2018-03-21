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
    let syllableSets = [["ab1","ac1","ad1","a_e1","af1","ai1","al1","am1","an1","any1"],
                        ["ap1","ar1","as1","at1","au1","aw1","ay1","ba1","be1","bi1"],
                        ["bit1","bl1","bo1","br1","bu1","by1","ce1","ch1","ci1","ble1"],
                        ["ck1","cl1","co1","com1","con1","cian1","cr1","ct1","de1","di1"],
                        ["do1","dr1","dy1","dis1","ea1","ee1","el1","em1","en1","er1"],
                        ["et1","ew1","ex1","ey1","fi1","fl1","fo1","fr1","ft1","ful1"],
                        ["ge1","gi1","gl1","go1","gr1","he1","hi1","id1","ie1","igh1"],
                        ["il1","im1","in1","ing1","ir1","is1","ject1","kn1","le1","li1"],
                        ["ly1","mi1","nd1","no1","nt1","oa1","ob1","o_e1","of1","oi1"],
                        ["old1","on1","ong1","oo1","op1","or1","ot1","ou1","ow1","oy1"],
                        ["ph1","pi1","pl1","pr1","cop1","re1","ro1","ry1","sh1","si1"],
                        ["sk1","so1","sp1","st1","sion1","th1","ti1","tion1","tive1","tle1"],
                        ["to1","tr1","ture1","ty1","ub1","u_e1","ui1","um1","un1","up1"],
                        ["ur1","ut1","war1","wh1","ab2","ac2","ad2","a_e2","af2","ai2"]]
    
    //略過數字的整合音節
    var sylArray = [String]()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //設定好segMent
        segControl.frame = CGRect(x: 50, y: 25, width: 300, height: 30)
        self.view.addSubview(segControl)
        
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
        tableView.separatorInset = .init(top: 0, left: 48, bottom: 0, right: 70)
        
        //設定Btn顏色狀態
        autoPlayText.textColor = btnOffColor
        playSenText.textColor = btnOffColor
        playTimesText.textColor = btnOnColor
        playTimesImg.image = UIImage(named:"bookTimes0.png")
        playSpeedImg.image = UIImage(named:"bookSpeed0.png")
        playSpeedText.textColor = btnOffColor
        playSenText.textColor = btnOnColor
        playSenImg.image = UIImage(named:"bookSenOn.png")
        
        //讀取所有syl, 排除相同的再次出現
        for group in syllableSets{
            for syl in group{
                
                let sylBreaks = syl.components(separatedBy: NSCharacterSet.decimalDigits)
                let syl = sylBreaks[0]
                
                if !sylArray.contains(syl){
                    
                    sylArray.append(syl)
                }
            }
            
        }
        
        //建立collectionView按鈕數量
        for _ in 0 ..< sylArray.count{
            
            collectionTouched.append(0)
            
        }
        
        //預設第一個元素
        collectionTouched[0] = 1
        
        //讀取單字
        
        //spot & unit
        gamePassed = [0:9]
        
        for (s,_) in gamePassed!{
            
            //讀取已完整的所有字集
            for i in 0 ..< (s){
                
                var wordFile:String?
                //前面的1代表第一張地圖
                let name = "1-" + String(i + 1)
                let sName = "s1-" + String(i + 1)
                
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
            let name = "1-" + String(s + 1)
            let sName = "s1-" +  String(s + 1)
            
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
                
                let syllableSequence = Int(w / 3)
                syllablesToShow.append(syllableSets[i][syllableSequence])
                
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
        for (s,g) in gamePassed!{
            
            for w in 0 ..< ((g + 1) * 3){
                engWordsToShow.append(tempWordSets[0][w])
                let syllableSequence = Int(w / 3)
                syllablesToShow.append(syllableSets[s][syllableSequence])
                
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
        
        
        //從所有的單字裡去找match到的我的最愛單字
        for i in 0 ..< engWordsToShow.count{
            
            //這個完整字沒有拆音節
            let word = engWordsToShow[i].replacingOccurrences(of: " ", with: "")
            let chiWord = chiWordsToShow[i]
            let partOfSpeech = partOfSpeechToShow[i]
            let syllables = syllablesToShow[i]
            //這個字才有拆音節
            let wordToAppend = engWordsToShow[i]
            let engSenToAppend = engSenToShow[i]
            let chiSenToAppend = chiSenToShow[i]
            
            for myWord in myFavWords{
                
                if myWord == word {
                    
                    myFavEngWordsToShow.append(wordToAppend)
                    myFavChiWordsToShow.append(chiWord)
                    myFavPartOfSpeechToShow.append(partOfSpeech)
                    myFavSyllablesToShow.append(syllables)
                    myFavEngSenToShow.append(engSenToAppend)
                    myFavChiSenToShow.append(chiSenToAppend)
                    
                    //抓全部單字要反紅的部分
                    myFavImgs[i] = 1
                    
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
        engWordsSelected = engWordsToShow
        chiWordsSelected = chiWordsToShow
        partOfSpeechSelected = partOfSpeechToShow
        syllablesSelected = syllablesToShow
        engSenSelected = engSenToShow
        chiSenSelected = chiSenToShow
        
        
        //移除三個多增加的數量, 這三個是可能會錯的部分?? 為什麼只移除engWordsSelected..
        for  _ in 0 ..< 3 {
            engWordsSelected.removeLast()
        }
        
        //預設collectionView的syl
        collectionSelectedIndex = 0
        
        
        
        
    }
    
    //再次載入所有單字裡我的最愛要反紅的字, 使用時機: 在我的最愛裡修改過後跳回所有單字
    func loadAllWordFavs(){
        
        //載入我的最愛單字
        if let myWordsString = user!["myWords"] as! String?{
            myFavWords = myWordsString.components(separatedBy: ";")
        }
        
        myFavImgs.removeAll(keepingCapacity: false)
        
        //填入所有字的數量, 等等準備抓我的最愛的部分
        for _ in 0 ..< engWordsToShow.count - 3{
            myFavImgs.append(0)
            
        }
        
        //去對有沒有符合我的最愛然後將其反紅
        for i in 0 ..< engWordsToShow.count{
            
            let word = engWordsToShow[i].replacingOccurrences(of: " ", with: "")
            
            for myWord in myFavWords{
                
                if myWord == word {
                    
                    //抓全部單字要反紅的部分
                    myFavImgs[i] = 1
                    
                }
                
            }
            
        }
        
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
        myFavImgs.removeAll(keepingCapacity: false)
        
        
        //所有單字反紅
        for _ in 0 ..< myFavWords.count{
            
            myFavImgs.append(1)
            
        }
        
        
        //以所有的單字來match我的最愛單字的資訊
        for i in 0 ..< engWordsToShow.count{
            
            //做比對使用
            let word = engWordsToShow[i].replacingOccurrences(of: " ", with: "")
            for myWord in myFavWords{
                
                if myWord == word {
                    
                    let chiWord = chiWordsToShow[i]
                    let partOfSpeech = partOfSpeechToShow[i]
                    let syllables = syllablesToShow[i]
                    let wordToAppend = engWordsToShow[i]
                    let engSenToAppend = engSenToShow[i]
                    let chiSenToAppend = chiSenToShow[i]
                    
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
        
        
        for i in 0 ..< engWordsToShow.count{
            
            let word = engWordsToShow[i].replacingOccurrences(of: " ", with: "")
            
            //抓我的錯字
            for myWrongWord in myWrongWords{
                
                if myWrongWord == word {
                    
                    let chiWord = chiWordsToShow[i]
                    let partOfSpeech = partOfSpeechToShow[i]
                    let syllables = syllablesToShow[i]
                    let wordToAppend = engWordsToShow[i]
                    let engSenToAppend = engSenToShow[i]
                    let chiSenToAppend = chiSenToShow[i]
                    
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
            engWordsSelected = engWordsToShow
            chiWordsSelected = chiWordsToShow
            partOfSpeechSelected = partOfSpeechToShow
            syllablesSelected = syllablesToShow
            engSenSelected = engSenToShow
            chiSenSelected = chiSenToShow
            
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
        
        
        return engWordsSelected.count
    }
    
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath)
        
        
        
        let syllableLabel = cell.viewWithTag(1) as! UILabel
        let engWordLabel = cell.viewWithTag(2) as! UILabel
        let partOfSpeechLabel = cell.viewWithTag(3) as! UILabel
        let chiWordLabel = cell.viewWithTag(4) as! UILabel
        let engSenLabel = cell.viewWithTag(5) as! UILabel
        let chiSenLabel = cell.viewWithTag(6) as! UILabel
        
        //抓音節的字母 +  數字
        let syllableText = syllablesSelected[indexPath.row].components(separatedBy: .decimalDigits)
        //let syllableNum = syllablesSelected[indexPath.row].replacingOccurrences(of: syllableText[0], with: "")
        
        
        //抓字
        let engWords = engWordsSelected[indexPath.row]
        //拆音節成array
        let engWordArray = engWords.components(separatedBy: " ")
        //定義母音
        let vowels = ["a","e","i","o","u"]
        
        //字型顏色
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 35), NSAttributedStringKey.foregroundColor : UIColor.cyan]
        let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 35), NSAttributedStringKey.foregroundColor : UIColor.white]
        let attrs3 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 35), NSAttributedStringKey.foregroundColor : UIColor.orange]
        
        
        //假如音節是_e, 另外處理
        if syllableText[0].contains("_") {
            
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
                            let word = NSMutableAttributedString(string: String(characters[0]), attributes: attrs3)
                            attrWords.append(word)
                            let word1 = NSMutableAttributedString(string: String(characters[1]), attributes: attrs2)
                            attrWords.append(word1)
                            let word2 = NSMutableAttributedString(string: String(characters[2]), attributes: attrs3)
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
                    if engWord == syllableText[0]{
                        
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
        
        partOfSpeechLabel.adjustsFontSizeToFitWidth = true
        partOfSpeechLabel.text = partOfSpeech
        syllableLabel.adjustsFontSizeToFitWidth = true
        syllableLabel.text = syllableText[0]
        
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
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(NewBookViewController.scrollViewDidEndDecelerating(_:)), object: nil)

        perform(#selector(NewBookViewController.scrollViewDidEndDecelerating(_:)), with: nil, afterDelay: 0.1)
        
    }
    
    
    @objc func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //滾動停止可以選擇
        isCollectionViewSelectabel = true
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(NewBookViewController.scrollViewDidScroll(_:)), object: nil)

        
        //用這個func來決定collectionView Cell要顯示哪個
        findMatchCollectionCell()
        
    }
    
    
    
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
            
            
            //指定一個數字, 去找符合音節的字
            var indexToChange = Int()
         
                for i in 0 ..< sylArray.count{
                    
                    if sylArray[i] == sylTextLabel.text! {
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
        collectionView.reloadData()

    }
    
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return sylArray.count
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
        let sylToDisplay = sylArray[indexPath.row]
        
        sylText.text = sylToDisplay
        sylText.textColor = btnOffColor
        
        sylSelected = sylArray[collectionSelectedIndex!]
        
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
        
        var onlySylTextArray = [String]()
        
        //抓當下的元素
        for i in 0 ..< syllablesSelected.count{
            
            let syllableText = syllablesSelected[i].components(separatedBy: .decimalDigits)
            
            onlySylTextArray.append(syllableText[0])
            
        }
        
        //找對應的row, 並跳過去
        for i in 0 ..< onlySylTextArray.count{
            
            //確認有字可以跳, 因爲有一些是正開放可以學習的單字但是不代表已經過了
            if onlySylTextArray[i] == sylSelected{
                
                if i < tableView.numberOfRows(inSection: 0){
                    
                    if i == 0 {
                        let index = IndexPath(row: 0, section: 0)
                        
                        tableView.scrollToRow(at: index, at: .top, animated: true)
                        
                        
                    } else {
                        
                        let index = IndexPath(row: i - 1, section: 0)
                        tableView.scrollToRow(at: index, at: .bottom, animated: true)
                        
                        
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
        chiWord.rate = 0.5
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
        chiSen.rate = 0.5
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

