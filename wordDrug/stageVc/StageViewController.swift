//
//  StageViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/2/21.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit
import ProgressHUD

let width = UIScreen.main.bounds.width
let height = UIScreen.main.bounds.height

class StageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var course: Course?
    
    let stageVC_alreadyLearned = NSLocalizedString("stageVC_alreadyLearned", comment: "")
    let stageVC_alert = NSLocalizedString("stageVC_alert", comment: "")
    
    let stageVC_openAllSwitch = NSLocalizedString("stageVC_openAllSwitch", comment: "")
    
    let orangeColor = UIColor.init(red: 232/255, green: 98/255, blue: 61/255, alpha: 1)
    
    //此兩數字要做動態
    //MARK: must update
    var stageCount:Int!
    var elemWordsMax:[Int]!
    
    var courseReceived = Int()
    
    var mapNumToPass = Int()
    
    //MARK: must update
    //MARK: simVer 這部分需要做到18個
    var eachCellMyWordsCount:[Int]!
    
    var wordCounts = Int()
    
    //上方單字總計label
    @IBOutlet weak var topWordsNumberLabel: UILabel!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    //MARK: must update
    //MARK: simVer 這裡要看最多有多少map.. 這裡看起來有最多有18個課程 done
    var locks:[StageLock]!
    var tempLocks:[StageLock]!
    
    var alertBg = UIImageView()
    var alertText = UILabel()
    var isClassAllPassed = false
    var ghostBtn = UIView()
    
    @IBOutlet weak var alreadyLearnedLabel: UILabel!

    @IBOutlet weak var classTitle: UIImageView!
    
    //MARK: simVer K12 課程紀錄變數
    //    var k12MapPassed:[Int]!
    //    var k12GamePassed:[[Int:Int]]!
    
    var isUnlocked = false
    
    @IBOutlet weak var unlockSwitch: UISwitch!

    
    let greenColor = #colorLiteral(red: 0.3254901961, green: 0.8431372549, blue: 0.4117647059, alpha: 1)
    
    var settingView = SetView()
    
    var wordSets = [[String]]()
    var wordContainer: [Word] = []
    var settingBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var iPadDif:CGFloat!
        var wordCountTitleLabelFontSize: CGFloat!
        var wordCountLabelFontSize: CGFloat!
        var dif = CGFloat()
        
        switch height {
            
        case 1366, 1336:
            
            dif = 1
            iPadDif = 2
            
            wordCountTitleLabelFontSize = 30
            wordCountLabelFontSize = 80
            
        case 1024, 1194, 1112:
            
            dif = 1
            iPadDif = 1.5
            
            wordCountTitleLabelFontSize = 25
            wordCountLabelFontSize = 60
            
        case 812:
            
            dif = 1.1
            iPadDif = 1
            
            wordCountTitleLabelFontSize = 20
            wordCountLabelFontSize = 45
            
        case 736:
            
            dif = 1.1
            iPadDif = 1
            
            wordCountTitleLabelFontSize = 20
            wordCountLabelFontSize = 45
            
        case 667:
            
            dif = 1
            iPadDif = 1
            
            wordCountTitleLabelFontSize = 20
            wordCountLabelFontSize = 45
            
        case 568:
            
            dif = 0.9
            iPadDif = 1
            
            wordCountTitleLabelFontSize = 20
            wordCountLabelFontSize = 45
            
        default:
            
            dif = 1.1
            iPadDif = 1
            
            wordCountTitleLabelFontSize = 20
            wordCountLabelFontSize = 45
            break
            
        }
        
        // Do any additional setup after loading the view.
        
        var bgColor = UIColor()
        var titleImg = String()
        
        //MARK: must update
        //MARK: simVer 這裡要製造正確的背景顏色以及title block
        
        if lan == "zh-Hans"{
            //檢體中文
            
            //print("檢體中文關卡數")
            //之後還要用courseReceived來改數值, 因為每個course值不同
            switch courseReceived{
            case 0:
                
                bgColor = UIColor.init(red: 22/255, green: 51/255, blue: 87/255, alpha: 1)
                
                titleImg = "simBlock0.png"
            case 1:
                bgColor = UIColor.init(red: 30/255, green: 36/255, blue: 83/255, alpha: 1)
                
                titleImg = "simBlock1.png"
            case 2:
                bgColor = UIColor.init(red: 59/255, green: 5/255, blue: 27/255, alpha: 1)
                
                titleImg = "simBlock2.png"
            case 3:
                //color literal
                bgColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                titleImg = "simBlock3.png"
            case 4:
                bgColor = #colorLiteral(red: 0.07085690866, green: 0.1181558561, blue: 0.03652065598, alpha: 1)
                titleImg = "simBlock4.png"
            case 5:
                bgColor = #colorLiteral(red: 0.07085690866, green: 0.1181558561, blue: 0.03652065598, alpha: 1)
                titleImg = "simBlock5.png"
                
            case 6:
                bgColor = #colorLiteral(red: 0.07085690866, green: 0.1181558561, blue: 0.03652065598, alpha: 1)
                titleImg = "simBlock6.png"
                
            case 7:
                bgColor = #colorLiteral(red: 0.07085690866, green: 0.1181558561, blue: 0.03652065598, alpha: 1)
                titleImg = "simBlock7.png"
                
            case 8:
                bgColor = #colorLiteral(red: 0.07085690866, green: 0.1181558561, blue: 0.03652065598, alpha: 1)
                titleImg = "simBlock8.png"
                
            default:
                break
            }
          
        } else {
            //其餘語言
            //print("繁體中文關卡數")
            switch courseReceived{
            case 0:
                
                bgColor = UIColor.init(red: 22/255, green: 51/255, blue: 87/255, alpha: 1)
                
                titleImg = "block0Title.png"
            case 1:
                bgColor = UIColor.init(red: 30/255, green: 36/255, blue: 83/255, alpha: 1)
                
                titleImg = "block1Title.png"
            case 2:
                bgColor = UIColor.init(red: 59/255, green: 5/255, blue: 27/255, alpha: 1)
                
                titleImg = "block2Title.png"
            case 3:
                //color literal
                bgColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                titleImg = "block3Title.png"
            case 4:
                bgColor = #colorLiteral(red: 0.07085690866, green: 0.1181558561, blue: 0.03652065598, alpha: 1)
                titleImg = "block4Title.png"
                
            default:
                break
                
            }
            
        }
        
        
        collectionView.backgroundColor = bgColor
        collectionView.delegate = self
        
        //MARK: layOut
        
        backBtn.anchor(top: view.safeTopAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: nil, padding: .init(top: 35 * iPadDif * dif, left: 25 * iPadDif * dif, bottom: 0, right: 0), size: .init(width: 19 * iPadDif * dif, height: 31 * iPadDif * dif))
        
        let topView = UIView()
        topView.backgroundColor = #colorLiteral(red: 0.1260408759, green: 0.101865299, blue: 0.1016356722, alpha: 1)
        self.view.addSubview(topView)

        topView.anchor(top: view.topAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: view.safeRightAnchor, size: .init(width: width, height: height / 5))
        collectionView.anchor(top: view.topAnchor, leading: view.safeLeftAnchor, bottom: view.bottomAnchor, trailing: view.safeRightAnchor, padding: .init(top: height / 5, left: 0, bottom: 0, right: 0))
//        collectionView.addSubview(settingView)
//        collectionView.bringSubviewToFront(settingView)
       
        
        classTitle.image = UIImage(named: titleImg)
        classTitle.contentMode = .scaleAspectFill
        
        classTitle.anchor(top: view.safeTopAnchor, leading: backBtn.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15 * dif * iPadDif, left: 30 * dif * iPadDif, bottom: 0, right: 0), size: .init(width: 73 * dif * iPadDif, height: 78 * dif * iPadDif))
        
 
        settingBtn = UIButton(type: UIButton.ButtonType.system)
        self.view.addSubview(settingBtn)
        //settingBtn.anchor(top: backBtn.topAnchor, leading: classTitle.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0), size: .init(width: 84, height: 37))
       
        settingBtn.setBackgroundImage(UIImage(named: "openSettingBtn.png"), for: .normal)
        settingBtn.addTarget(self, action: #selector(StageViewController.openSettingView), for: .touchUpInside)
        
        if lan == "zh-Hans" && courseReceived == 5 {
            settingBtn.isHidden = true
        }

        //alreadyLearnedLabel.font = alreadyLearnedLabel.font.withSize(wordCountTitleLabelFontSize)
        
        //alreadyLearnedLabel.anchor(top: view.safeTopAnchor, leading: nil, bottom: nil, trailing: view.safeRightAnchor, padding: .init(top: 25 * dif * iPadDif, left: 0, bottom: 0, right: -20 * dif * iPadDif), size: .init(width: 100 * dif * iPadDif, height: 28 * dif * iPadDif))
    
        //alreadyLearnedLabel.text = stageVC_openAllSwitch
        
        //wordCountsLabel.backgroundColor = .red
//        wordCountsLabel.font = wordCountsLabel.font.withSize(wordCountLabelFontSize)
//        wordCountsLabel.anchor(top: alreadyLearnedLabel.bottomAnchor, leading: nil, bottom: nil, trailing: view.safeRightAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -20 * dif * iPadDif), size: .init(width: 150 * dif * iPadDif, height: 55 * dif * iPadDif))
//        wordCountsLabel.adjustsFontSizeToFitWidth = true
//     wordCountsLabel.isHidden = true
        
        
//         unlockSwitch.anchor(top: alreadyLearnedLabel.bottomAnchor, leading: nil, bottom: nil, trailing: view.safeRightAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: -20 * dif * iPadDif), size: .init(width: 49 * dif * iPadDif, height: 31 * dif * iPadDif))
        
        settingBtn.anchor(top: alreadyLearnedLabel.bottomAnchor, leading: nil, bottom: nil, trailing: view.safeRightAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: -20 * dif * iPadDif), size: .init(width: 84 * dif * iPadDif, height: 37 * dif * iPadDif))
        
        self.view.addSubview(ghostBtn)
        let alphaGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.58)
        ghostBtn.backgroundColor = alphaGray
        ghostBtn.anchor(top: view.safeTopAnchor, leading: view.safeLeftAnchor, bottom: view.safeBottomAnchor, trailing: view.safeRightAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: width, height: height))
        ghostBtn.layer.zPosition = 2
        ghostBtn.addSubview(settingView)
        ghostBtn.bringSubviewToFront(settingView)
        ghostBtn.isHidden = true

        settingView.isHidden = true
        settingView.center = self.view.center
        

        
        //self.view.bringSubviewToFront(alreadyLearnedLabel)
//        self.view.bringSubview(toFront: wordCountsLabel)
        self.view.bringSubviewToFront(backBtn)
        self.view.bringSubviewToFront(classTitle)
        
        //self.view.bringSubviewToFront(unlockSwitch)
        self.view.bringSubviewToFront(settingBtn)
        self.view.bringSubviewToFront(ghostBtn)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unlockSwitchTapped(_ sender: Any) {
        if unlockSwitch.isOn {
            //打開
            isUnlocked = true
            for i in 0 ..< 18{
                locks[i] = .unlocked
            }
            alreadyLearnedLabel.textColor = greenColor

        } else {
            
            isUnlocked = false
            locks = tempLocks
            alreadyLearnedLabel.textColor = .white
        }
        
         collectionView.reloadData()
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return stageCount
    }
    
    //即時更新學習單字字數
    
    var gamePassedDic: [Int:Int]?
    var mapPassedInt: Int?
    
    override func viewWillAppear(_ animated: Bool) {
       
        setupButtonFunctions()
        
        isUnlocked = false // needed?
        //unlockSwitch.isEnabled = true
        //unlockSwitch.setOn(false, animated: false)
        //alreadyLearnedLabel.textColor = .white
        //MARK: simVer 要製造足夠數量的
        isClassAllPassed = false // needed?
        
        course = Course(language: lan,
                        level: Level(rawValue: courseReceived) ?? .one,
                        mapNumberReceive: nil,
                        isClassAllPassed: isClassAllPassed,
                        isUnlocked: isUnlocked)
        
        settingView.initCourse(course: course)
        countStageNumbers()
        
        collectionView.reloadData()
    }
    
    private func setupButtonFunctions() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(StageViewController.closeSettingView), name: NSNotification.Name(closeSettingViewKey), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(StageViewController.reloadCollectionView), name: NSNotification.Name(reloadCollectionViewKey), object: nil)
    }
    
    private func countStageNumbers() {
        //MARK:
        guard let course = course else { return }
        
        eachCellMyWordsCount = Array(repeating: 0, count: 18)
        
        if course.language == .simplified && course.level == .one {
            elemWordsMax = Array(repeating: 330, count: course.maxMapNumber)
        } else if course.level == .six {
            elemWordsMax = [120,330,330,300,330,330,330,330,390,390,330,330,210,330,300,180,390,390]
        } else {
            elemWordsMax = Array(repeating: 450, count: course.maxMapNumber)
        }

        stageCount = course.maxMapNumber
        gamePassedDic = course.gamePass
        mapPassedInt = course.mapPass
        
        if course.level == .six { //K12
            for i in 0 ..< k12MapPassed.count {
                if k12MapPassed[i] == 1 {
                    eachCellMyWordsCount[i] = elemWordsMax[i]
                } else {
                    for (s,u) in k12GamePassed[i] {
                        wordCounts = s * 30 + u * 3
                    }
                    eachCellMyWordsCount[i] = wordCounts
                }
            }
        } else { //其他的課程計算方式
            for (s,u) in gamePassedDic!{
                wordCounts = s * 30 + u * 3
            }
            //MARK: simVer 改寫原本上方不同的switch方法字數統計
            for i in 0 ..< mapPassedInt! + 1{
                eachCellMyWordsCount[i] = i == mapPassedInt ? wordCounts : elemWordsMax[i]
            }
        }
        
        locks = Array(repeating: .locked, count: 18)
        
        if course.level != .six, let mapPassedInt = mapPassedInt {
            let tempMapPassedInt = course.isAllMapPassed ? mapPassedInt : mapPassedInt + 1
            for i in 0 ..< tempMapPassedInt {
                locks[i] = .unlocked
            }
        } else if course.level == .six {
            locks = Array(repeating: .unlocked, count: 18)
        }
        
        tempLocks = locks // needed?
    }
    
    @objc
    func reloadCollectionView(){
        countStageNumbers()
        collectionView.reloadData()
        tempLocks = locks //needed?
        closeSettingView()
    }
    
    @objc
    func closeSettingView(){
        collectionView.isScrollEnabled = true
        settingView.isHidden = true
        ghostBtn.isHidden = true
        backBtn.isEnabled = true
        settingBtn.isEnabled = true
        //unlockSwitch.isEnabled = true
    }
    
    @objc
    func openSettingView() {
        
        collectionView.isScrollEnabled = false
        settingView.isHidden = false
        ghostBtn.isHidden = false
        backBtn.isEnabled = false
        settingBtn.isEnabled = false
        //unlockSwitch.isEnabled = false
        
        guard let course = course else { return }
        
        var wordData = [String]()
        var wordStartIndex = 0
        for i in 0 ..< (course.level.rawValue) {
            wordStartIndex += course.maxMapNumberArray[i]
        }
        wordStartIndex = course.language == .simplified ? wordStartIndex + MissWord.simplifiedStartIndex : wordStartIndex

        
        var maxPageNumber = Int()
        if lan == "zh-Hans" && courseReceived == 0{
            maxPageNumber = 11
        } else {
            maxPageNumber = 15
        }
        
        for i in wordStartIndex ..< wordStartIndex + stageCount{
            for j in 0 ..< maxPageNumber {
                
                let file = File(chapter: i + 1, unit: j + 1)
                let word = MissWordUtility.shared.loadWords(file: file)
                wordContainer.append(contentsOf: word)
//                name = "\(i+1)-\(j+1)"
//                //print("load file name :\(name)")
//
//                if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
//                    do {
//                        wordFile = try String(contentsOfFile: filepath)
//                        let words = wordFile?.components(separatedBy: "; ")
//
//                        //把字讀取到wordSets裡
//
//                        wordSets.append(words!)
//
//                    } catch {
//                        // contents could not be loaded
//                    }
//                } else {
//                    // example.txt not found!
//                }
            }
        }
        
        var finalWordData = [String]()
        for word in wordContainer {
            wordData.append(word.english)
        }
        
        var sortedWordData = [String]()
        for i in 0 ..< wordData.count / 3 {
            var newString = String()
            for n in 0 ..< 3 {
                let newIndex = i * 3 + n
                if n != 2 {
                    newString += wordData[newIndex] + " "
                } else {
                    newString += wordData[newIndex]
                }
            }
            sortedWordData.append(newString)
        }
        finalWordData = sortedWordData
        
        
        
//        for set in wordSets {
//            for i in 0 ..< set.count{
//                if i < 30 {
//                    wordData.append(set[i].replacingOccurrences(of: " ", with: ""))
//                }
//            }
//            var sortedWordData = [String]()
//            for i in 0 ..< wordData.count / 3 {
//                var newString = String()
//                for n in 0 ..< 3 {
//                    let newIndex = i * 3 + n
//                    if n != 2 {
//                        newString += wordData[newIndex] + " "
//                    } else {
//                        newString += wordData[newIndex]
//                    }
//                }
//                sortedWordData.append(newString)
//            }
//            finalWordData = sortedWordData
//        }
        
        var tempNumber = Int()
        for (s,u) in gamePassedDic! {
            tempNumber = s * 10 + u
        }
        
        let numberToJump = maxPageNumber * 10
        let rowToJump = mapPassedInt! * numberToJump + tempNumber
        
        settingView.selectedIndex = rowToJump
        settingView.pickerData = finalWordData
        settingView.courseReceived = courseReceived
        settingView.picker.selectRow(rowToJump, inComponent: 0, animated: true)
    }
    
    deinit {
        print("bookVc deinit")
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: "stageCell", for: indexPath as IndexPath) as! StageCollectionViewCell
        
        let lockImg = cell.viewWithTag(3) as! UIImageView
//        if locks[indexPath.row] == 0 {
//            lockImg.isHidden = true
//        } else {
//            lockImg.isHidden = false
//        }
        lockImg.isHidden = locks[indexPath.row] == .unlocked
        cell.stageLabel.adjustsFontSizeToFitWidth = true
        cell.stageLabel.text = String(indexPath.row + 1)
        
        //cell.wordCountLabel.adjustsFontSizeToFitWidth = true

        let wordCounts = eachCellMyWordsCount[indexPath.row]
        
        //單機版: 測試
        cell.wordCountLabel.text = "\(wordCounts) / \(elemWordsMax[indexPath.row])"

        
        //MARK: simVer 這裡要看課程最大值
        
        var p1Color = UIColor()
        var p2Color = UIColor()
        var p3Color = UIColor()
        var p4Color = UIColor()
        var p5Color = UIColor()
        var p6Color = UIColor()
        var p7Color = UIColor()
        var p8Color = UIColor()
        var p9Color = UIColor()
        var p10Color = UIColor()
        var p11Color = UIColor()
        var p12Color = UIColor()
        var p13Color = UIColor()
        var p14Color = UIColor()
        var p15Color = UIColor()
        var p16Color = UIColor()
        var p17Color = UIColor()
        var p18Color = UIColor()
        
        var colors = [UIColor]()
        
        //設定cell的顏色
        
        //MARK: simVer 顏色數量更新 3/5/6/11/13/18/7/9/8
        //應製造對應數量 4/6/6/12/14/18/8/10/8
        //MARK: must update
        switch courseReceived{
            
        case 0:
            
            p1Color = UIColor.init(red: 123/255, green: 177/255, blue: 247/255, alpha: 1)
            p2Color = UIColor.init(red: 83/255, green: 153/255, blue: 243/255, alpha: 1)
            p3Color = UIColor.init(red: 44/255, green: 124/255, blue: 216/255, alpha: 1)
            p4Color = UIColor.init(red: 47/255, green: 99/255, blue: 165/255, alpha: 1)
            p5Color = UIColor.init(red: 19/255, green: 61/255, blue: 113/255, alpha: 1)
            p6Color = UIColor.init(red: 22/255, green: 51/255, blue: 87/255, alpha: 1)
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color]
        case 1:
            
            p1Color = UIColor.init(red: 147/255, green: 152/255, blue: 194/255, alpha: 1)
            p2Color = UIColor.init(red: 98/255, green: 104/255, blue: 152/255, alpha: 1)
            p3Color = UIColor.init(red: 87/255, green: 91/255, blue: 127/255, alpha: 1)
            p4Color = UIColor.init(red: 72/255, green: 79/255, blue: 129/255, alpha: 1)
            p5Color = UIColor.init(red: 52/255, green: 59/255, blue: 111/255, alpha: 1)
            p6Color = UIColor.init(red: 30/255, green: 36/255, blue: 83/255, alpha: 1)
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color]
        case 2:
            
            p1Color = UIColor.init(red: 247/255, green: 128/255, blue: 176/255, alpha: 1)
            p2Color = UIColor.init(red: 230/255, green: 88/255, blue: 145/255, alpha: 1)
            p3Color = UIColor.init(red: 196/255, green: 63/255, blue: 116/255, alpha: 1)
            p4Color = UIColor.init(red: 189/255, green: 39/255, blue: 99/255, alpha: 1)
            p5Color = UIColor.init(red: 195/255, green: 20/255, blue: 90/255, alpha: 1)
            p6Color = UIColor.init(red: 146/255, green: 0/255, blue: 59/255, alpha: 1)
            p7Color = UIColor.init(red: 88/255, green: 2/255, blue: 37/255, alpha: 1)
            p8Color = UIColor.init(red: 59/255, green: 5/255, blue: 27/255, alpha: 1)
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color, p7Color, p8Color]
            
            
        case 3:
            
            p1Color = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            p2Color = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            p3Color = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            p4Color = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            p5Color = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
            p6Color = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            p7Color = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
            p8Color = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
            p9Color = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
            p10Color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
            p11Color = #colorLiteral(red: 0.3137254902, green: 0.07450980392, blue: 0.03921568627, alpha: 1)
            p12Color = #colorLiteral(red: 0.3058823529, green: 0.2039215686, blue: 0.05882352941, alpha: 1)
            
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color, p7Color, p8Color, p9Color, p10Color, p11Color, p12Color]
            
        case 4:
            
            p1Color = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            p2Color = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            p3Color = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            p4Color = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            p5Color = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            p6Color = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
            p7Color = #colorLiteral(red: 0.1044694025, green: 0.1742056197, blue: 0.05384501217, alpha: 1)
            p8Color = #colorLiteral(red: 0.05588630746, green: 0.09319196429, blue: 0.02880459573, alpha: 1)
            
            p9Color = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            p10Color = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            p11Color = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            p12Color = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            p13Color = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            p14Color = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)

            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color, p7Color, p8Color, p9Color, p10Color, p11Color, p12Color, p13Color, p14Color]
        case 5:
            
            p1Color = #colorLiteral(red: 0.8, green: 0.8470588235, blue: 0.862745098, alpha: 1)
            p2Color = #colorLiteral(red: 0.7176470588, green: 0.7607843137, blue: 0.7764705882, alpha: 1)
            p3Color = #colorLiteral(red: 0.6392156863, green: 0.6745098039, blue: 0.6901960784, alpha: 1)
            p4Color = #colorLiteral(red: 0.5490196078, green: 0.5921568627, blue: 0.6039215686, alpha: 1)
            p5Color = #colorLiteral(red: 0.4784313725, green: 0.5058823529, blue: 0.5176470588, alpha: 1)
            p6Color = #colorLiteral(red: 0.4352941176, green: 0.5294117647, blue: 0.5411764706, alpha: 1)
            p7Color = #colorLiteral(red: 0.4117647059, green: 0.5882352941, blue: 0.6, alpha: 1)
            p8Color = #colorLiteral(red: 0.4235294118, green: 0.5490196078, blue: 0.6078431373, alpha: 1)
            
            p9Color = #colorLiteral(red: 0.4549019608, green: 0.4588235294, blue: 0.5647058824, alpha: 1)
            p10Color = #colorLiteral(red: 0.3254901961, green: 0.3764705882, blue: 0.4862745098, alpha: 1)
            p11Color = #colorLiteral(red: 0.6274509804, green: 0.6235294118, blue: 0.8392156863, alpha: 1)
            p12Color = #colorLiteral(red: 0.5921568627, green: 0.537254902, blue: 0.7725490196, alpha: 1)
            p13Color = #colorLiteral(red: 0.5843137255, green: 0.4509803922, blue: 0.6352941176, alpha: 1)
            p14Color = #colorLiteral(red: 0.5254901961, green: 0.2784313725, blue: 0.4745098039, alpha: 1)
            p15Color = #colorLiteral(red: 0.4588235294, green: 0.2156862745, blue: 0.3254901961, alpha: 1)
            p16Color = #colorLiteral(red: 0.3254901961, green: 0.2274509804, blue: 0.3921568627, alpha: 1)
            p17Color = #colorLiteral(red: 0.2392156863, green: 0.168627451, blue: 0.2862745098, alpha: 1)
            p18Color = #colorLiteral(red: 0.168627451, green: 0.1137254902, blue: 0.2, alpha: 1)
            
            
            
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color, p7Color, p8Color, p9Color, p10Color, p11Color, p12Color, p13Color, p14Color, p15Color, p16Color, p17Color, p18Color]
        case 6:
            
            p1Color = #colorLiteral(red: 0.6823529412, green: 0.8431372549, blue: 0.8862745098, alpha: 1)
            p2Color = #colorLiteral(red: 0.5960784314, green: 0.7921568627, blue: 0.8862745098, alpha: 1)
            p3Color = #colorLiteral(red: 0.5490196078, green: 0.662745098, blue: 0.8901960784, alpha: 1)
            p4Color = #colorLiteral(red: 0.5450980392, green: 0.5568627451, blue: 0.9215686275, alpha: 1)
            p5Color = #colorLiteral(red: 0.5490196078, green: 0.4745098039, blue: 0.8078431373, alpha: 1)
            p6Color = #colorLiteral(red: 0.6823529412, green: 0.5058823529, blue: 0.6509803922, alpha: 1)
            p7Color = #colorLiteral(red: 0.537254902, green: 0.3176470588, blue: 0.568627451, alpha: 1)
            p8Color = #colorLiteral(red: 0.4862745098, green: 0.2705882353, blue: 0.431372549, alpha: 1)
            
            
            
            
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color, p7Color, p8Color]
        case 7:
            
            p1Color = #colorLiteral(red: 0.3568627451, green: 0.8352941176, blue: 0.7764705882, alpha: 1)
            p2Color = #colorLiteral(red: 0.2941176471, green: 0.6705882353, blue: 0.7529411765, alpha: 1)
            p3Color = #colorLiteral(red: 0.3176470588, green: 0.4941176471, blue: 0.7333333333, alpha: 1)
            p4Color = #colorLiteral(red: 0.2666666667, green: 0.3098039216, blue: 0.7176470588, alpha: 1)
            p5Color = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.6274509804, alpha: 1)
            p6Color = #colorLiteral(red: 0.08235294118, green: 0.2549019608, blue: 0.8235294118, alpha: 1)
            p7Color = #colorLiteral(red: 0.05490196078, green: 0.2, blue: 0.6941176471, alpha: 1)
            p8Color = #colorLiteral(red: 0.05882352941, green: 0.1960784314, blue: 0.5450980392, alpha: 1)
            
            p9Color = #colorLiteral(red: 0.07843137255, green: 0.05490196078, blue: 0.4196078431, alpha: 1)
            p10Color = #colorLiteral(red: 0.02745098039, green: 0.05098039216, blue: 0.2745098039, alpha: 1)
            
            
            
            
            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color, p7Color, p8Color, p9Color, p10Color]
        case 8:
            
            p1Color = #colorLiteral(red: 0.8235294118, green: 0.8, blue: 0.7882352941, alpha: 1)
            p2Color = #colorLiteral(red: 0.6941176471, green: 0.6901960784, blue: 0.6705882353, alpha: 1)
            p3Color = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
            p4Color = #colorLiteral(red: 0.6235294118, green: 0.4862745098, blue: 0.4196078431, alpha: 1)
            p5Color = #colorLiteral(red: 0.4784313725, green: 0.3215686275, blue: 0.3019607843, alpha: 1)
            p6Color = #colorLiteral(red: 0.3568627451, green: 0.231372549, blue: 0.2274509804, alpha: 1)
            p7Color = #colorLiteral(red: 0.2509803922, green: 0.1529411765, blue: 0.168627451, alpha: 1)
            p8Color = #colorLiteral(red: 0.1529411765, green: 0.09411764706, blue: 0.1098039216, alpha: 1)
            

            colors = [p1Color,p2Color,p3Color,p4Color,p5Color,p6Color, p7Color, p8Color]
        default:
            break
        }
        cell.backgroundColor = colors[indexPath.row % colors.count]
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: width / 2, height: width / 2)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //傳送地圖數字
        mapNumToPass = indexPath.row
        
        //在此先暫時預設mapPassed...之後要寫在過關時做儲存
        //MARK: simVer 這裏要做K12的單獨各個判斷 決定是否isClassAllPassed
        
        //有過地圖才能進關卡

        
        //單機版: 以下的篩選模式都先comment掉
        
        if isUnlocked {
            
            performSegue(withIdentifier: "toLessonVc", sender: self)
            
        } else {
        
        if courseReceived == 5 {
            //ＭARK: simVer K12特別作法

            //確認該單元是否全過

            if k12MapPassed[mapNumToPass] == 1 {

                isClassAllPassed = true
            }

            performSegue(withIdentifier: "toLessonVc", sender: self)

        } else {

            if mapPassedInt == indexPath.row {

                performSegue(withIdentifier: "toLessonVc", sender: self)

            } else if mapPassedInt! > indexPath.row {

                //show已過關訊息

                isClassAllPassed = true

                performSegue(withIdentifier: "toLessonVc", sender: self)


            } else if mapPassedInt! < indexPath.row {

                ProgressHUD.showError(stageVC_alert)

                //performSegue(withIdentifier: "toLessonVc", sender: self)


            }

        }
        }
    }
    
    
    
    //重送地圖編號
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toLessonVc"{
            let destinationVC = segue.destination as! LessonViewController
            destinationVC.course = course
            
            destinationVC.courseReceived = courseReceived
            destinationVC.mapNumToReceive = mapNumToPass
            destinationVC.isClassAllPassed = isClassAllPassed
            destinationVC.isUnlocked = isUnlocked
            
            destinationVC.modalPresentationStyle = .fullScreen
            
            if #available(iOS 13.0, *) {
                destinationVC.isModalInPresentation = false
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
