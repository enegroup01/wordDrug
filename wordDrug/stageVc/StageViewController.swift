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

struct StageModel {
    var course: Course
    var eachCellMyWordsCount:[Int]
    var elemWordsMax:[Int]
    var locks: [StageLock]
}

class StageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var course: Course?
    
    let stageVC_alreadyLearned = NSLocalizedString("stageVC_alreadyLearned", comment: "")
    let stageVC_alert = NSLocalizedString("stageVC_alert", comment: "")
    
    let stageVC_openAllSwitch = NSLocalizedString("stageVC_openAllSwitch", comment: "")
    
    let orangeColor = UIColor.init(red: 232/255, green: 98/255, blue: 61/255, alpha: 1)
    
    //此兩數字要做動態
    //MARK: must update
    var elemWordsMax:[Int] = []
    var eachCellMyWordsCount:[Int] = []
    
    var courseReceived = Int()
    
    var mapNumToPass = Int()
    
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
        
        return course?.maxMapNumber ?? 0
    }
    
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
        } else if course.isK12Class {
            elemWordsMax = [120,330,330,300,330,330,330,330,390,390,330,330,210,330,300,180,390,390]
        } else {
            elemWordsMax = Array(repeating: 450, count: course.maxMapNumber)
        }
        
        if course.isK12Class { //K12
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
        } else if let gamePass = course.gamePass, let mapPass = course.mapPass { //其他的課程計算方式
            for (s,u) in gamePass {
                wordCounts = s * 30 + u * 3
            }
            //MARK: simVer 改寫原本上方不同的switch方法字數統計
            for i in 0 ..< mapPass + 1 {
                eachCellMyWordsCount[i] = i == mapPass ? wordCounts : elemWordsMax[i]
            }
        }
        
        locks = Array(repeating: .locked, count: 18)
        
        if course.level != .six, let mapPass = course.mapPass {
            let tempMapPassedInt = course.isAllMapPassed ? mapPass : mapPass + 1
            for i in 0 ..< tempMapPassedInt {
                locks[i] = .unlocked
            }
        } else if course.isK12Class {
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
        
        var wordStartIndex = 0
        for i in 0 ..< (course.level.rawValue) {
            wordStartIndex += course.maxMapNumberArray[i]
        }
        wordStartIndex = course.language == .simplified ? wordStartIndex + MissWord.simplifiedStartIndex : wordStartIndex

        let maxRowCount = course.isSimplifiedElementary ? 11 : 15
        
        for i in wordStartIndex ..< wordStartIndex + course.maxMapNumber {
            for j in 0 ..< maxRowCount {
                let file = File(chapter: i + 1, unit: j + 1)
                let word = MissWordUtility.shared.loadWords(file: file)
                wordContainer.append(contentsOf: word)
            }
        }
        
        var wordData = [String]()
        for word in wordContainer {
            wordData.append(word.english)
        }
        
        var sortedWordData = [String]()
        for i in 0 ..< wordData.count / 3 {
            var newString = String()
            for n in 0 ..< 3 {
                let newIndex = i * 3 + n
                let appendedText = n != 2 ? wordData[newIndex] + " " : wordData[newIndex]
                newString += appendedText
            }
            sortedWordData.append(newString)
        }
        
        var remainingWordCount = Int()
        for (s,u) in course.gamePass! { // can force unwrap because level .six won't enter here
            remainingWordCount = s * 10 + u
        }
        
        let fullMapWordCount = maxRowCount * 10
        let rowToJump = course.mapPass! * fullMapWordCount + remainingWordCount // can force unwrap because level .six won't enter here
        
        settingView.selectedIndex = rowToJump
        settingView.pickerData = sortedWordData
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
        
        guard let course = course else { return UICollectionViewCell() }
        let stageDetail = StageModel(course: course, eachCellMyWordsCount: eachCellMyWordsCount, elemWordsMax: elemWordsMax, locks: locks)
        
        cell.builCell(model: stageDetail, indexPath: indexPath)
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
        guard let course = course else { return }
        mapNumToPass = indexPath.row
        course.setMapPassNum(number: mapNumToPass)
        
        guard !course.isK12Class else {
            isClassAllPassed = k12MapPassed[mapNumToPass] == 1 ? true : isClassAllPassed
            performSegue(withIdentifier: "toLessonVc", sender: self)
            return
        }

        guard let mapPass = course.mapPass, mapPass >= indexPath.row else {
            ProgressHUD.showError(stageVC_alert)
            return
        }
        
        isClassAllPassed = mapPass > indexPath.row ? true : isClassAllPassed
        performSegue(withIdentifier: "toLessonVc", sender: self)
    }
    
    
    
    //重送地圖編號
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toLessonVc" {
            let destinationVC = segue.destination as! LessonViewController
            destinationVC.course = course
            destinationVC.modalPresentationStyle = .fullScreen
            
            if #available(iOS 13.0, *) {
                destinationVC.isModalInPresentation = false
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
