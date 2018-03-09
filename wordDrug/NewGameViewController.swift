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


class NewGameViewController: UIViewController, SFSpeechRecognizerDelegate, TagListViewDelegate, AVSpeechSynthesizerDelegate  {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
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
        audioView.numberOfWaves =  1
        audioView.amplitude = 0.1
        audioView.alpha = 0.5
        audioView.waveColor = .darkGray
        
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
    
    
    @objc func leaveGame(){

        self.dismiss(animated: true, completion: nil)
    }
    
    
    //開始辨識聲音
    @objc func startToRecognize(_ notification: NSNotification){

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
    
    @objc func pronounceWord(_ notification: NSNotification){

        if let wordToPronunce = notification.userInfo?["wordToPass"] as? String {
                //設訂發音的單字
                synWord = wordToPronunce

        }
        //發音
        synPronounce()

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
                    
                    self.recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
                        
                        if let result = result {
                            
                            self.recogTextLabel.text = result.bestTranscription.formattedString.lowercased()
                            
                            //對答案的部分要修掉標點符號
                            self.wordRecorded = self.recogTextLabel.text!.removingCharacters(inCharacterSet: CharacterSet.punctuationCharacters)
                          
    
                            if result.isFinal {
                                
                                self.audioEngine.stop()
                                inputNode.removeTap(onBus: 0)
                                
                                //移除掉Request避免Reuse
                                self.recognitionRequest = nil
                                self.recognitionTask = nil
                                
                                self.recordBtn.setTitle("Start Recording", for: [])
                                
                                
                            }
                            
                        }
                        
                    })
                    
                    let recordingFormat = inputNode.outputFormat(forBus: 0)
   
                    //先移除之前的
                    inputNode.removeTap(onBus: 0)
                    inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat, block: { (buffer, when) in
                        
                        self.recognitionRequest?.append(buffer)
           
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
        
        //幾分可以過關
        if finalPoints >= 70 {
            
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
                
                //做選擇題

                //製作tags
                var sentenceTag = self!.sentence.components(separatedBy: " ")
                sentenceTag.shuffled()
                for w in sentenceTag{
                    
                    self!.tagView.addTag(w)
                }
                
                self!.tagView.isHidden = false
                
                self!.synPronounce()
                
                //準備選擇題
                self!.sentenceLabel.text = ""
                self!.recordBtn.isHidden = true
     
                
            } else {
            
            self!.recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
            }
        }
        
        
        print("final:\(finalPoints)")
        
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
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "backToSpell"), object: nil, userInfo: nil)
                
            } else {
                self!.recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
                
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
