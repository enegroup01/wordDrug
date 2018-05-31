//
//  IntroViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/5/29.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

import SpriteKit
import GameplayKit
import Speech
import AVFoundation
import SwiftSiriWaveformView
import NVActivityIndicatorView

let recogRight = "recogRight"

class IntroViewController: UIViewController ,SFSpeechRecognizerDelegate,AVSpeechSynthesizerDelegate{
    
    //中文字粉紅色
    let pinkColor = UIColor.init(red: 1, green: 153/255, blue: 212/255, alpha: 1)
    let waveColor = UIColor.init(red: 1, green: 237/255, blue: 241/255, alpha: 1)
    let recordingPinkColor = UIColor.init(red: 1, green: 0, blue: 149/255, alpha: 1)
    @IBOutlet weak var recordBtn: UIButton!
    
    //發音單字
    var synWord = String()
    
    //Text to speech合成器
    var synth = AVSpeechSynthesizer()
    
    
    //辨識聲音用的變數
    
    var speechRecognizer = SFSpeechRecognizer()!
    
    let audioEngine = AVAudioEngine()
    var recognitionRequest:SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask:SFSpeechRecognitionTask?
    
    //音波用的變數
    var timer:Timer?
    var change:CGFloat = 0.01
    @IBOutlet weak var audioView: SwiftSiriWaveformView!
    
    //錄音動畫
    var recordingIndicator:NVActivityIndicatorView?
    
   
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
        var audioSession = AVAudioSession.sharedInstance()
    
    var hintLabel = UILabel()
    
    var recogTextLabel = UILabel()
    
    
    var restultTimer = Timer()
    
    var isRecogRight = Bool()
    var second = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        var dif = CGFloat()

        switch height {
        case 812:
      
            dif = 1.15

        case 736:

            dif = 1.1
            
        case 667:

            dif = 1
            
        case 568:
            
            dif = 0.9
            
        default:
 
            dif = 0.9
       
            
        }
        
        //口試Nc (單字 + 句子)
        NotificationCenter.default.addObserver(self, selector: #selector(IntroViewController.startToRecognize), name: NSNotification.Name("tutorialRecognize"), object: nil)
        
        
        //口試正確
        NotificationCenter.default.addObserver(self, selector: #selector(IntroViewController.notifyRecogRight), name: NSNotification.Name("recogRight"), object: nil)
        
        recordBtn.frame = CGRect(x: (width - 128 * dif) / 2, y: height - 180 * dif, width: 128 * dif, height: 128 * dif)
        
        //先隱藏錄音及辨識
        recordBtn.isHidden = true
        
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
        
        //做錄音動畫
        let frame = CGRect(x: recordBtn.frame.origin.x - 8 * dif, y: recordBtn.frame.origin.y - 8 * dif, width:145 * dif, height: 145 * dif)
        recordingIndicator = NVActivityIndicatorView(frame: frame, type: .circleStrokeSpin, color: recordingPinkColor, padding: 2)
        
        
        hintLabel.frame = CGRect(x: width / 6, y: recordBtn.frame.minY - 70, width: width * 2 / 3, height: 50)
        //hintLabel.backgroundColor = .red
        
        hintLabel.textAlignment = .center
        hintLabel.font = UIFont(name: "Helvetica Bold", size: 24)
        hintLabel.textColor = .cyan
        hintLabel.text = ""
        self.view.addSubview(hintLabel)
        
        
        recogTextLabel.frame = CGRect(x: 0, y: height * 2 / 5, width: width, height: height / 5)
        recogTextLabel.textAlignment = .center
        recogTextLabel.textColor = .orange
        recogTextLabel.font = UIFont(name: "Helvetica Bold", size: 36)
        recogTextLabel.text = ""
        recogTextLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(recogTextLabel)
        
        
        synth.delegate = self
        
        if let scene = GKScene(fileNamed: "IntroScene") {
            
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! IntroScene? {
                
                // Copy gameplay related content over to the scene


                
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
        
        self.view.addSubview(recordingIndicator!)
        self.view.bringSubview(toFront: recordBtn)
        
        //辨識語音的delegate
        speechRecognizer.delegate = self
        
        
        
        //先設定為false之後做開啟
        recordBtn.isEnabled = false
        
        //設定語言
        speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en"))!
        

    }

    
    
    @objc func startToRecognize(){
        
        
        
        sayHi()
        
        
     
        
    }
    
    
    func requestMicAuth(){
        
        
        
        //備註: 請求授權, 之後要做拒絕的機制
        SFSpeechRecognizer.requestAuthorization { [weak self](authStatus) in
            
            OperationQueue.main.addOperation({
                
                switch authStatus {
                    
                case .authorized:
                    
                    self!.authorized()
                    self!.recordBtn.isEnabled = true
                    
                case .denied:
                    
                          self!.recordBtn.isEnabled = true
                       self!.failToAuthorizeMic()
                case .restricted:

                          self!.recordBtn.isEnabled = true
                       self!.failToAuthorizeMic()
                case .notDetermined:
              
                          self!.recordBtn.isEnabled = true
                    self!.failToAuthorizeMic()
                    
                }
                
                
            })
            
            
        }

    }
    
    
    func failToAuthorizeMic(){
        

        recogTextLabel.text = "請到[設定] -> [MissWord] 裡開啟麥克風及語音辨識權限"
        
    }
    
    
    func authorized(){
        
        
        //顯示按鈕, 顯示label
        
        //更改Btn圖示為待錄音
        
        recordBtn.isEnabled = true
        
        recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
        
        recordBtn.isHidden = false
        
        hintLabel.text = "按一下麥克風"
        
    }
    
    
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
            
            
            if recogTextLabel.text == "hi"{
                
                recordBtn.setImage(UIImage(named: "recordCheck.png"), for: .normal)
                hintLabel.text = "發音很棒喔！"
                
                        restultTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(IntroViewController.recogResult), userInfo: nil, repeats: true)
                isRecogRight = true
            } else {
                
                recordBtn.setImage(UIImage(named: "recordCross.png"), for: .normal)
                
                hintLabel.text = "唸錯了!再試一次喔!"
                
                restultTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(IntroViewController.recogResult), userInfo: nil, repeats: true)
                isRecogRight = false
            
                
            }
            
        }  else {
            
            
            
            hintLabel.text = "請對麥克風說「Hi」!"
            
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
                                
                                
                                self!.recogTextLabel.text = resultWord
                                
                                self!.hintLabel.text = "再按一下麥克風來結束"
                                /*
                                if relWords != nil {
                                    
                                    if relWords!.contains(resultWord){
                                        
                                        self!.recogTextLabel.text = self!.wordToReceive
                                        
                                    } else {
                                        
                                        self!.recogTextLabel.text = resultWord
                                    }
                                } else {
                                    
                                    self!.recogTextLabel.text = resultWord
                                    
                                }
                                */
                            }
                            
                            //對答案的部分要修掉標點符號
                           // self!.wordRecorded = self!.recogTextLabel.text!.removingCharacters(inCharacterSet: CharacterSet.punctuationCharacters)
                            
                            
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
                   // playSoundBtn.isEnabled = false
                }
                
                
            } catch {
                
                //Handle error
                
            }
            
        }

        
    }
    
    
    
    @objc func notifyRecogRight(){
        
        
    }
    
    @objc func recogResult(){
        
        
        second += 1
        
        if second > 3 {
            
            
            restultTimer.invalidate()
            second = 0
            
            if isRecogRight{
                
                recordBtn.isHidden = true
                recogTextLabel.text = ""
                hintLabel.text = ""
                
                
                  NotificationCenter.default.post(name: NSNotification.Name(rawValue: "recogRight"), object: nil, userInfo: nil)
                
                
                
            } else {
                
                
                hintLabel.text = "按一下麥克風"
                recogTextLabel.text = ""
                recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
                recordBtn.isHidden = false
                recordBtn.isEnabled = true
                
                
            }
            
            
        }
        
    }
    
    
    //wave動畫
    @objc internal func refreshAudioView(_:Timer) {
        if self.audioView.amplitude <= self.audioView.idleAmplitude || self.audioView.amplitude > 1.0 {
            self.change *= -1.0
        }
        // Simply set the amplitude to whatever you need and the view will update itself.
        self.audioView.amplitude += self.change
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //syn發音
    func sayHi(){
        
        
        do {
            
            //設置成ambient看能不能避免任何interruption 造成當機
            
            try audioSession.setCategory(AVAudioSessionCategoryAmbient)
            try audioSession.setMode(AVAudioSessionModeDefault)
            try audioSession.setActive(true)
            
        } catch  {
            print("error")
        }


        let utterance = AVSpeechUtterance(string: "hi")

        let rateFloat = 0.45
            utterance.postUtteranceDelay = 0
        
        
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = Float(rateFloat)
        synth.speak(utterance)
        
      
    }
    
    
    
    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance){
        
        print("**start")
       
        
    }
    
    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance){
        
        print("**Finish")
        
    
        
        requestMicAuth()
        

        
        print("nc received")
        
    }

    
    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance){
        print("**pause")
    }
    
    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance){
        print("**continue")
   
    }
    
    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance){
        print("**cancel")
     
        
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