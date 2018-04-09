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

let showSentenceKey = "showSentence"
let backToSpellKey = "backToSpell"
let practiceNextWordKey = "practiceNextWord"
let startCountDownKey = "startCountDown"
let timesUpKey = "timesUp"
let showTagKey = "showTag"


class NewGameViewController: UIViewController, SFSpeechRecognizerDelegate, TagListViewDelegate, AVSpeechSynthesizerDelegate  {
    
    //中文字粉紅色
    let pinkColor = UIColor.init(red: 1, green: 153/255, blue: 212/255, alpha: 1)
    let waveColor = UIColor.init(red: 1, green: 237/255, blue: 241/255, alpha: 1)
    
    //顯示辨識字的label
    @IBOutlet weak var recogTextLabel: UILabel!
    
    //句子中文label
    @IBOutlet weak var chiSentenceLabel: UILabel!
    
    //句子英文label
    @IBOutlet weak var sentenceLabel: UILabel!
    
    //錄音鍵
    @IBOutlet weak var recordBtn: UIButton!
    
    //接收數字
    var spotNumber = Int()
    var unitNumber = Int()
    var mapNumber = Int()

    
    //辨識聲音用的變數
    
    var speechRecognizer = SFSpeechRecognizer()!
    
    let audioEngine = AVAudioEngine()
    var recognitionRequest:SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask:SFSpeechRecognitionTask?
 
    
    //暫時使用的句子
    var sentenceSets = [String]()
    
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
    var tagsSelected = [String]()

    //製作tag
    @IBOutlet weak var tagView: TagListView!

    //這兩個應該用不到
    var player: AVAudioPlayer?
    var mp3FileName = String()
    
    
    //發音單字
    var synWord = String()
    
    //Text to speech合成器
    let synth = AVSpeechSynthesizer()
    
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
    
    
    let word1Label = UILabel()
    let word2Label = UILabel()
    let word3Label = UILabel()

    let inCircle = UIImageView()
    let midCircle = UIImageView()
    let outCircle = UIImageView()
    
    
    //用來顯示正確答案的變數, 保留標點符號大小寫
    var completeWordsToShow = String()
    
    var sentenceTag = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       
        //暫時測試畫面使用
       
        coverBg.image = UIImage(named:"coverBg.png")
        resultBg.image = UIImage(named:"resultBg.png")
        coverBtn.isHidden = true
        coverBg.isHidden = true
        resultBg.isHidden = true
        firstWordBtn.isHidden = true
        secondWordBtn.isHidden = true
        thirdWordBtn.isHidden = true
        bigOkBtn.isHidden = true
        firstWordBtn.isEnabled = false
        secondWordBtn.isEnabled = false
        thirdWordBtn.isEnabled = false
        
        
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
        
        
        //載入我的最愛單字
        if let myWordsString = user!["myWords"] as! String?{
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
        
        tagView.textFont = UIFont.boldSystemFont(ofSize: 30)
       
        //辨識字的大小設定
        recogTextLabel.adjustsFontSizeToFitWidth = true
        
        //wave畫面設定
        audioView.isHidden = true
        audioView.backgroundColor = .clear
        audioView.density = 1
        audioView.numberOfWaves =  2
        audioView.secondaryLineWidth = 0.5
        audioView.amplitude = 0.1
        audioView.alpha = 0.7
        audioView.waveColor = waveColor
        
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

        
        //先隱藏錄音及辨識
        recordBtn.isHidden = true
        recogTextLabel.isHidden = true
        
        //讀取Bundle裡的句子
        var sentenceFile:String?
        
        let sentenceName = "s" + String(mapNumber) + "-" + String(spotNumber + 1)
        
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
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
        
        //辨識語音的delegate
        speechRecognizer.delegate = self
        
        //先設定為false之後做開啟
        recordBtn.isEnabled = false
        
        //設定語言
        speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en"))!
        
        
        //請求授權, 之後要做拒絕的機制
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
  
        
    }
    
    
    //顯示tagView
    @objc func showTag(){
        
        tagView.isHidden = false
        recogTextLabel.text = ""
    }

    
    //最後選字的func
    /*
    @objc func wordTapped(gestureRcognizer:UITapGestureRecognizer){
        
        let number = gestureRcognizer.numberOfTouches
        for i in 0 ..< number {
            let point = gestureRcognizer.location(
                ofTouch: i, in: self.view)
            
            if firstWordBtn.frame.contains(point){
                
                print("1st tapped")
                
                
            } else if secondWordBtn.frame.contains(point){
                
                print("2nd tapped")
                
            } else if thirdWordBtn.frame.contains(point){
                
                print("3rd tapped")
                
            }
        }
        

    }
 */

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
    
    
    //造句子
    @objc func showSentence(_ notification: NSNotification){
        
        //接收單字數字準備做句子
        
        if let sequenceToReceive = notification.userInfo?["currentWordSequence"] as? String{
            
             //指定好數字
             wordSequenceToReceive = sequenceToReceive
            
        }
        
        recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
        recordBtn.isHidden = true
        //製作句子
        makeSentence()
        
    }
    
    
    @objc func notifyPracticeNextWord(){


        //移除tagView
        tagsSelected.removeAll(keepingCapacity: false)
        tagView.isHidden = true
        tagView.removeAllTags()
        
        //移除輸入字
        recogTextLabel.text = ""
        recogTextLabel.isHidden = true
        
        //回復recordBtn
        recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
        recordBtn.isHidden = true
        
        //輸入重置
        sentenceLabel.text = ""
        chiSentenceLabel.text = ""
        
      
    }
    
    @objc func notifyBackToSpell(){
        

        //隱藏錄音字欄位
        recogTextLabel.isHidden = true
        
        //變回錄音鍵
        recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
        recordBtn.isHidden = true
        
    }
    
    
    //result畫面
    @objc func leaveGame(_ notification: NSNotification){
        
        /*
        //啟動成果畫面, 此處在加recognizer才不會跟GameScene互打到
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(NewGameViewController.wordTapped(gestureRcognizer:)))
        self.view.addGestureRecognizer(tapGesture)
        */
        coverBtn.isHidden = false
        coverBg.isHidden = false
        resultBg.isHidden = false
        firstWordBtn.isHidden = false
        secondWordBtn.isHidden = false
        thirdWordBtn.isHidden = false
        bigOkBtn.isHidden = false
        
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
        
        if let engWords = notification.userInfo?["engWords"] as? [String]{
            if let chiWords = notification.userInfo?["chiWords"] as? [String]{
                if let score = notification.userInfo?["score"] as? [String] {
                    if let results = notification.userInfo?["correctResults"] as? [String]{
                        
                    
                        
                        for i in 0 ..< results.count{
                            
                            if results[i] == "1"{
      
                                wordBtns[i].setImage(UIImage(named:"wrongWordBtn.png"), for: .normal)
                                
                                
                            } else {
                                
                                wordBtns[i].setImage(UIImage(named:"rightWordBtn.png"), for: .normal)
          
                            }
                        }
                    //抓字
                        firstEngWordText = engWords[0]
                        secondEngWordText = engWords[1]
                        thirdEngWordText = engWords[2]
                        
                    //做分數動畫+ 單字動畫
                    scoreLabel.text = score[0]
                    
                    moveUpAnimation(label: firstEngWord, text: firstEngWordText)
                    moveUpAnimation(label: secondEngWord, text: secondEngWordText)
                    moveUpAnimation(label: thirdEngWord, text: thirdEngWordText)
                    
                    moveUpAnimation(label: firstChiWord, text: chiWords[0])
                    moveUpAnimation(label: secondChiWord, text: chiWords[1])
                    moveUpAnimation(label: thirdChiWord, text: chiWords[2])

                }
                }
            }
        }
    }
    @IBAction func firstWordClicked(_ sender: Any) {
        
        if isParseEnabled{
               isParseEnabled = false
            addWord(word: firstEngWordText)
            moveUpAndGone(label: word1Label)
            
        }
        
    }
    @IBAction func secondWordClicked(_ sender: Any) {
        if isParseEnabled{
            isParseEnabled = false
            addWord(word: secondEngWordText)
            moveUpAndGone(label: word2Label)
            
        }
    }
    
    @IBAction func thirdWordClicked(_ sender: Any) {
        
        if isParseEnabled{
            isParseEnabled = false
            addWord(word: thirdEngWordText)
            moveUpAndGone(label: word3Label)
            
        }
        
    }
    
    
    
    
    override func viewDidDisappear(_ animated: Bool) {

        NotificationCenter.default.removeObserver(self)
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

            //wave 消失停止
            audioView.isHidden = true
            timer?.invalidate()
            
            //停止辨識
            audioEngine.stop()
            recognitionRequest?.endAudio()
            recognitionTask?.cancel()
            
            //辨識的字消失
            self.recogTextLabel.text = ""
            
            
            //檢查答案, 句子/單字
            if isCheckingSentence{
                self.checkSentence()
            } else {
                self.checkWord()
            }
            
        }  else {
            
            //開啟錄音
            
            //siriWave
            audioView.isHidden = false
            timer = Timer.scheduledTimer(timeInterval: 0.009, target: self, selector: #selector(NewGameViewController.refreshAudioView(_:)), userInfo: nil, repeats: true)
            
            
            //如果Task還在, 就取消task 等待再次開啟
            if recognitionTask != nil {
                recognitionTask?.cancel()
                recognitionTask = nil
            }

            
            //開始辨識
           
            let audioSession = AVAudioSession.sharedInstance()
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
                            
                            self!.recogTextLabel.text = result.bestTranscription.formattedString.lowercased()
                            
                            //對答案的部分要修掉標點符號
                            self!.wordRecorded = self!.recogTextLabel.text!.removingCharacters(inCharacterSet: CharacterSet.punctuationCharacters)
                          
    
                            if result.isFinal {
                                
                                self!.audioEngine.stop()
                                inputNode.removeTap(onBus: 0)
                                
                                //移除掉Request避免Reuse
                                self!.recognitionRequest = nil
                                self!.recognitionTask = nil
                                
                                self!.recordBtn.setTitle("Start Recording", for: [])
                                
                                
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
        
            self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    func checkSentence1(){
        
        var recorded = [String]()
        var received = [String]()
        
        recorded = wordRecorded.components(separatedBy: " ")
        received = wordToReceive.components(separatedBy: " ")
        
        print(recorded)
        print(received)
        
        //寫一個對答案比例的func
        var finalPoints = Int()
        let unitPoint = 100 / received.count
        var pointGet = Int()
        var pointMinus = Int()
        
        if recorded == received{
            
            finalPoints = 100
        } else {
            
            for i in 0 ..< recorded.count{
                for r in 0 ..< received.count{
                    
                    if recorded[i] == received[r]{
                        
                        //假如有字對到
                        
                        pointGet += 1
      
                    }
                    
                }
            }
            
            if pointGet > received.count{
                pointGet = received.count
            }
            
            finalPoints = pointGet * unitPoint
        }
        
        if recorded.count > received.count{
            
            pointMinus = recorded.count  - received.count
            finalPoints = finalPoints - pointMinus * unitPoint / 2
            
            if finalPoints < 0 {
                finalPoints = 0
            }
            
        }
        
        //結果決定圖片
        if finalPoints >= 70 {

            recordBtn.setImage(UIImage(named:"recordCheck.png"), for: .normal)
            
            
        } else{
 
              recordBtn.setImage(UIImage(named:"recordCross.png"), for: .normal)


        }
        
        //計算分數
        var score = Int()
        score = 500 * finalPoints / 100
        
        
        
        
        //都等一下反應
        let when = DispatchTime.now() + 0.5
        
        DispatchQueue.main.asyncAfter(deadline: when) {[weak self] in
  
                
                //做選擇題

                //製作tags
                var sentenceTag = self!.sentence.components(separatedBy: " ")
            print("tags:\(sentenceTag)")
            sentenceTag.shuffled()
                for w in sentenceTag{
                    
                    self!.tagView.addTag(w)
                }
                
                self!.tagView.isHidden = false
                
                self!.synPronounce()
                
                //準備選擇題
                self!.sentenceLabel.text = ""
                self!.recordBtn.isHidden = true
            
            //算分數
            let addScore:[String:Int] = ["addScore":score]
    
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addScore"), object: nil, userInfo: addScore)
        
            //開始tag Question倒數
               NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startCountDown"), object: nil, userInfo: nil)
            
            
        }
        
        
        print("final:\(score)")
        
    }
    
    //檢查句子
    
    func checkSentence(){
        
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
            
            //顯示正確與否
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
        
        //都等一下反應
        let when = DispatchTime.now() + 0.5
        
        //做選擇題
        DispatchQueue.main.asyncAfter(deadline: when) {[weak self] in
            
            //製作tags
            self!.sentenceTag = self!.sentence.components(separatedBy: " ")
            
            
            self!.sentenceTag.shuffled()
            for i in 0 ..< self!.sentenceTag.count{
                
                self!.tagView.addTag(self!.sentenceTag[i])
            }
            
            //準備選擇題
            self!.sentenceLabel.text = ""
            //self!.recordBtn.isHidden = true
            
            //算分數 + 啟動tag的機制
            let addScore:[String:Int] = ["addScore":score,"finalPoints":finalPoints]
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addScore"), object: nil, userInfo: addScore)
            
            
            //隱藏recordBtn
            self!.recordBtn.isHidden = true
        }
        
        
    }
    
    
    func checkWord(){
        
        if wordRecorded == wordToReceive{
            
            recordBtn.setImage(UIImage(named:"recordCheck.png"), for: .normal)
            isRecogWordCorrect = true
        } else {
            
            recordBtn.setImage(UIImage(named:"recordCross.png"), for: .normal)
            isRecogWordCorrect = false
            
        }
        
        //都等一下反應
        let when = DispatchTime.now() + 0.5
        
        DispatchQueue.main.asyncAfter(deadline: when) {[weak self] in
            
            if self!.isRecogWordCorrect{
                
                
                var score = Int()
                if self!.answerTime == 0 {
                    
                    score = 200
                } else if self!.answerTime == 1 {
                    
                    score = 100
                    self?.answerTime = 0
                }
                
                let addScore:[String:Int] = ["addScore":score]
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "backToSpell"), object: nil, userInfo: addScore)
                
            } else {
                
                
                if self!.answerTime < 1 {
                    
                    //可以繼續練習
                self!.answerTime += 1
                    self!.recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
                } else {
                    //失敗跳離畫面
                    self!.answerTime = 0
                    
                    let addScore:[String:Int] = ["addScore":0]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "backToSpell"), object: nil, userInfo: addScore)
                    
                    
                }
                
     
                
            }
        }
        
    }
    
    //做句子, 傳送nc去發音
    func makeSentence(){
        
        
        //英文句子
        sentence = sentenceSets[Int(wordSequenceToReceive)!]
        let halfCount = sentenceSets.count / 2
        let chiSentence = sentenceSets[halfCount + Int(wordSequenceToReceive)!]
        
        //做好句子檔名: 此數字要加1, 因為編檔關係,  地圖已加過1
        //sentenceToPronounce = "s\(mapNumber)-\(spotNumber + 1)-\(Int(wordSequenceToReceive)! + 1)"
        
        //顯示句子文字
        sentenceLabel.text = sentence
        chiSentenceLabel.text = chiSentence
        
        
        //句子發音
        synWord = sentence
        synPronounce()
        
        //接著要辨認句子
        isCheckingSentence = true
        wordToReceive = sentence
        
        //提供顯示用的答案, 包含標點符號及大小寫
        completeWordsToShow = sentence
        
        //移除標點符號
        wordToReceive = wordToReceive.removingCharacters(inCharacterSet: CharacterSet.punctuationCharacters)
        
        //改成小寫
        wordToReceive = wordToReceive.lowercased()
        
       
        //準備練習句子
        //顯示按鈕, 顯示label
        recordBtn.isHidden = false
        
        recogTextLabel.isHidden = false
        
        //回復錄音輸入的單字或句子
        wordRecorded = String()
        
        //對句子
        isCheckingSentence = true

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //確認tag的答案
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
       
        tagView.isSelected = !tagView.isSelected
        
        var sentenceShown = String()
        
        if tagsSelected.count > 0 {

            if tagsSelected.contains(title){
                
                for i in 0 ..< tagsSelected.count{
                    
                    if tagsSelected[i] == title{
                        print(i)
                        tagsSelected[i] = ""
                        
                    }
                }
                
            } else {
                
                tagsSelected.append(title)
            }
        
        } else {
        tagsSelected.append(title)
        }
        
        for tag in tagsSelected{
            
            if tag != ""{
            sentenceShown += tag + " "
            }
        }
        
        recogTextLabel.text = sentenceShown
        
        let answerEntered = recogTextLabel.text?.dropLast()
        
        if answerEntered! == sentence{
            
            
            //跳轉下個字
            //過關進入下個字
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "practiceNextWord"), object: nil, userInfo: nil)
    
        } else {
            
            print("not yet correct")
        }
    }

    
    //syn發音
    func synPronounce(){
        

        
        do {
            
            //設置成ambient看能不能避免任何interruption 造成當機
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setMode(AVAudioSessionModeDefault)
            try AVAudioSession.sharedInstance().setActive(true)
            
        } catch  {
            print("error")
        }
        
        
        let string = synWord
        
        var rateFloat = Float()
        
        let utterance = AVSpeechUtterance(string: string)
        let utterance2 = AVSpeechUtterance(string: string)
        
        if string.contains(" "){
            
            rateFloat = 0.4
            print("唸句子")
            
            utterance.postUtteranceDelay = 1
            
        } else {
            print("唸單字")
            rateFloat = 0.45
            utterance.postUtteranceDelay = 0
        }
        
        
        utterance2.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance2.rate = rateFloat
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = rateFloat
        
        //發音等待時間
        let when = DispatchTime.now() + 2.7
        
        DispatchQueue.main.async {[weak self] in
            
            guard let strongSelf = self else{
                return
            }
            
            strongSelf.synth.speak(utterance)
            
            
            if strongSelf.pronounceTime == 2 {
                
                DispatchQueue.main.asyncAfter(deadline: when, execute: {
                    strongSelf.synth.speak(utterance2)
                })
                
            }
        }
        
        
    }

    
    /*
    //syn發音
    func synPronounce(){
        
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
            
        } catch  {
            
        }
        
        let string = synWord
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.45
      
        synth.speak(utterance)

    }
 
 */
    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance){
     
        recordBtn.isEnabled = false
    }
    
    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance){
     
         recordBtn.isEnabled = true
        
    }
    
    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance){
        
        recordBtn.isEnabled = true
    }
    
    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance){
          recordBtn.isEnabled = false
    }
    
    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance){
        recordBtn.isEnabled = true
        
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
