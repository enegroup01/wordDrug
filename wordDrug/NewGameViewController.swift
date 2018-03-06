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
let prounounceSentenceKey = "pronounceSentence"
let practiceNextWordKey = "practiceNextWord"
let tagQuestionKey = "tagQuestion"

class NewGameViewController: UIViewController, SFSpeechRecognizerDelegate  {
    
    //中文字粉紅色
    let pinkColor = UIColor.init(red: 1, green: 153/255, blue: 212/255, alpha: 1)
    
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
    var recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask = SFSpeechRecognitionTask()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        
        //辨識字的大小設定
        recogTextLabel.adjustsFontSizeToFitWidth = true
        
        //wave畫面設定
        audioView.isHidden = true
        audioView.backgroundColor = .clear
        audioView.density = 1
        audioView.numberOfWaves =  1
        audioView.amplitude = 0.1
        audioView.alpha = 0.5
        audioView.waveColor = .darkGray
        
        
        //離開遊戲
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.leaveGame), name: NSNotification.Name("leaveGame"), object: nil)
        
        //接收口試NC (單字 + 句子)
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.startToRecognize), name: NSNotification.Name("startToRecognize"), object: nil)
        
        //啟動聽考拼寫
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyBackToSpell), name: NSNotification.Name("backToSpell"), object: nil)
        
        //接收做句子
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.showSentence), name: NSNotification.Name("showSentence"), object: nil)
        
        //啟動句子發音
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyPronounceSentence), name: NSNotification.Name("pronounceSentence"), object: nil)
        
        
        //啟動選擇題
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyTagQuestion), name: NSNotification.Name("tagQuestion"), object: nil)
        
        //啟動下個單字
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyPracticeNextWord), name: NSNotification.Name("practiceNextWord"), object: nil)
        
        

        
        
        //先隱藏錄音及辨識
        recordBtn.isHidden = true
        recogTextLabel.isHidden = true
        
        //讀取Bundle裡的句子
        var sentenceFile:String?
        
        let sentenceName = "s" + String(mapNumber) + "-" + String(spotNumber + 1)
        
        print("sName:\(sentenceName)")
        
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
        
        
        chiSentenceLabel.textColor = pinkColor
        
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
    @objc func showSentence(){
        
        recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
        recordBtn.isHidden = true
        //製作句子
        makeSentence()
        
    }
    
    @objc func notifyPronounceSentence(){
        
        
    }
    
    @objc func notifyPracticeNextWord(){
        //開啟聲音
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSessionCategoryAmbient)
        } catch  {
            
        }
        
        recogTextLabel.isHidden = true
        recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
        recordBtn.isHidden = true
        sentenceLabel.text = ""
        chiSentenceLabel.text = ""
        
    }
    
    @objc func notifyBackToSpell(){
        
        
        //開啟聲音
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSessionCategoryAmbient)
        } catch  {
            
        }
        
        //隱藏錄音字欄位
        recogTextLabel.isHidden = true
        
        //變回錄音鍵
        recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
        recordBtn.isHidden = true
        
    }
    
    
    @objc func leaveGame(){
        
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
     @objc func startToRecognize(){
     
     recordBtn.isHidden = false
     recogTextLabel.isHidden = false
     }
     */
    
    
    
    //開始辨識聲音
    @objc func startToRecognize(_ notification: NSNotification){
        
        //顯示按鈕, 顯示label
        recordBtn.isHidden = false
        recogTextLabel.isHidden = false
        
        //回復輸入的單字或句子
        wordRecorded = String()
        
        //抓數值
        if let wordToCheck = notification.userInfo?["wordToPass"] as? String {
        
            //要分辨需要確認的是單字還是句子
            if wordToCheck != "" {
                
                //單字
                
                wordToReceive = wordToCheck
                
                if let sequenceToReceive = notification.userInfo?["currentWordSequence"] as? String{
                    
                    wordSequenceToReceive = sequenceToReceive
                    
                    isCheckingSentence = false
                    
                }
                
            } else {
                
                //句子
                wordToReceive = sentence
                
                isCheckingSentence = true
                
            }
            
            //移除標點符號
            wordToReceive = wordToReceive.removingCharacters(inCharacterSet: CharacterSet.punctuationCharacters)
            
            //改成小寫
            wordToReceive = wordToReceive.lowercased()
            
        }
        
    }
    
    
    //啟動選擇題
    @objc func notifyTagQuestion(){
        //隱藏英文句子 + 錄音鍵
        
        //開啟聲音
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSessionCategoryAmbient)
        } catch  {
            
        }

        sentenceLabel.text = ""
        recordBtn.isHidden = true
        
        
        
        
    }
    
    //按鈕
    @IBAction func recordClicked(_ sender: Any) {
        
        //停止
        if audioEngine.isRunning {
            
            //wave 消失停止
            audioView.isHidden = true
            timer?.invalidate()
            
            audioEngine.stop()
            recognitionRequest.endAudio()
            recognitionTask.cancel()
            
            //辨識的字消失
            self.recogTextLabel.text = ""
            
            //recordBtn.setTitle("Start Recording", for: [])
            
            //檢查答案
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
            
            
            //開始辨識
            do {
                
                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setCategory(AVAudioSessionCategoryRecord)
                try audioSession.setMode(AVAudioSessionModeMeasurement)
                try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
                
                
                if let inputNode = audioEngine.inputNode as AVAudioInputNode?{
                    
                    
                    recognitionRequest.shouldReportPartialResults = true
                    
                    self.recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
                        
                        if let result = result {
                            
                            self.recogTextLabel.text = result.bestTranscription.formattedString.lowercased()
                            
                            self.wordRecorded = self.recogTextLabel.text!
                            
                            if result.isFinal {
                                
                                self.audioEngine.stop()
                                inputNode.removeTap(onBus: 0)
                                
                                self.recordBtn.setTitle("Start Recording", for: [])
                                
                                
                            }
                            
                        }
                        
                    })
                    
                    let recordingFormat = inputNode.outputFormat(forBus: 0)
                    
                    inputNode.removeTap(onBus: 0)
                    inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat, block: { (buffer, when) in
                        
                        self.recognitionRequest.append(buffer)
                        
                        
                    })
                    
                    audioEngine.prepare()
                    try audioEngine.start()
                    
                }
                
                
                
            } catch {
                
                //Handle error
                
            }
            
            
            
        }
        
    }
    
    
    func checkSentence(){
        
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
        
        if finalPoints >= 80 {
            
            print("passed")
            //下一個字
            
            recordBtn.setImage(UIImage(named:"recordCheck.png"), for: .normal)
            isRecogWordCorrect = true
            
            
        } else{
            
            print("failed")
            //重來一次
              recordBtn.setImage(UIImage(named:"recordCross.png"), for: .normal)
            isRecogWordCorrect = false

        }
        
        
        //都等一下反應
        let when = DispatchTime.now() + 0.5
        
        DispatchQueue.main.asyncAfter(deadline: when) {[weak self] in
            
            if self!.isRecogWordCorrect{
                
                /*
                //過關進入下個字
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "practiceNextWord"), object: nil, userInfo: nil)
*/
                
                //進入選擇題
                  NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tagQuestion"), object: nil, userInfo: nil)
                
                
            } else {
            
            self!.recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
            }
        }
        
        
        print(finalPoints)
        
    }
    
    func checkWord(){
        
        
        
        if wordRecorded == wordToReceive{
            
            print("correct")
            
            recordBtn.setImage(UIImage(named:"recordCheck.png"), for: .normal)
            isRecogWordCorrect = true
        } else {
            
            print("try again")
            recordBtn.setImage(UIImage(named:"recordCross.png"), for: .normal)
            isRecogWordCorrect = false
            
        }
        
        //都等一下反應
        let when = DispatchTime.now() + 0.5
        
        DispatchQueue.main.asyncAfter(deadline: when) {[weak self] in
            
            if self!.isRecogWordCorrect{
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "backToSpell"), object: nil, userInfo: nil)
                
            } else {
                self!.recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
                
            }
        }
        
    }
    
    //做句子, 傳送nc去發音
    func makeSentence(){
        
        
        //開啟聲音
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSessionCategoryAmbient)
        } catch  {
            
        }
        
        //英文句子
        sentence = sentenceSets[Int(wordSequenceToReceive)!]
        let halfCount = sentenceSets.count / 2
        let chiSentence = sentenceSets[halfCount + Int(wordSequenceToReceive)!]
        
        //此數字要加1, 因為編檔關係,  地圖已加過1
        sentenceToPronounce = "s\(mapNumber)-\(spotNumber + 1)-\(Int(wordSequenceToReceive)! + 1)"
        
        sentenceLabel.text = sentence
        chiSentenceLabel.text = chiSentence
        
        
        //句子發音NC, 傳送句子的檔名
        let sentenceToPass:[String:String] = ["sentenceToPass":sentenceToPronounce]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pronounceSentence"), object: nil, userInfo: sentenceToPass)
        
        
    }
    
    
    
    func recordTimerFunc(){
       
        
    }
    
    //單純發音功能
    
    func pronounce(finished: @escaping () -> Void){
        //    let pronounceAction = SKAction.playSoundFileNamed(sentenceToPronounce + ".mp3", waitForCompletion: true)
        //  run(pronounceAction)
        
        //finished()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
