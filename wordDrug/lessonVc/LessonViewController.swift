//
//  LessonViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/4/19.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit
import AVFoundation
import ProgressHUD

class LessonViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    let lessonVC_aboutToLearn3Words = NSLocalizedString("lessonVC_aboutToLearn3Words", comment: "")
    let lessonVC_review3Words = NSLocalizedString("lessonVC_review3Words", comment: "")
    let lessonVC_currentLesson = NSLocalizedString("lessonVC_currentLesson", comment: "")
    let lessonVC_hintLabel = NSLocalizedString("lessonVC_hintLabel", comment: "")
    let lessonVC_reviewBtn = NSLocalizedString("lessonVC_reviewBtn", comment: "")
    let lessonVC_previousBtn = NSLocalizedString("lessonVC_previousBtn", comment: "")
    let lessonVC_allSylBtn = NSLocalizedString("lessonVC_allSylBtn", comment: "")
    let lessonVC_nextBtn = NSLocalizedString("lessonVC_nextBtn", comment: "")
    let lessonVC_enterBtn = NSLocalizedString("lessonVC_enterBtn", comment: "")
    let lessonVC_enterReviewBtn = NSLocalizedString("lessonVC_enterReviewBtn", comment: "")
    let lessonVC_thisIsFirst = NSLocalizedString("lessonVC_thisIsFirst", comment: "") 
    let lessonVC_noPrePage = NSLocalizedString("lessonVC_noPrePage", comment: "")
    let lessonVC_alertNotYet = NSLocalizedString("lessonVC_alertNotYet", comment: "")
    let lessonVC_loading = NSLocalizedString("lessonVC_loading", comment: "")
    let lessonVC_noNextPage = NSLocalizedString("lessonVC_noNextPage", comment: "")
    let lessonVC_pleaseChoose = NSLocalizedString("lessonVC_pleaseChoose", comment: "")
    let lessonVC_wordChallenge = NSLocalizedString("lessonVC_wordChallenge", comment: "")
    let lessonVC_senChallenge = NSLocalizedString("lessonVC_senChallenge", comment: "")
    let lessonVC_alertNoChallenge = NSLocalizedString("lessonVC_alertNoChallenge", comment: "")
    let lessonVC_iKnow = NSLocalizedString("lessonVC_iKnow", comment: "")
    let lessonVC_theLastPage = NSLocalizedString("lessonVC_theLastPage", comment: "")
    let lessonVC_class = NSLocalizedString("lessonVC_class", comment: "")
    let lessonVC_allOpenMode = NSLocalizedString("lessonVC_allOpenMode", comment: "")

    
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var syllableLabel: UILabel!
    @IBOutlet weak var lessonLabel: UILabel!
    @IBOutlet weak var lessonTitleLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    @IBOutlet weak var progressLength: UIImageView!
    @IBOutlet weak var fullLength: UIImageView!
    @IBOutlet weak var enterBtn: UIButton!
    let pinkColor = UIColor.init(red: 247/255, green: 127/255, blue: 124/255, alpha: 1)
    var mapNumToReceive = Int()
    
    @IBOutlet weak var previousBtn: UIButton!
    
    @IBOutlet weak var nextBtn: UIButton!
    //被選擇到的音節
    var syllableSets: [[String]] {
        return course.syllableSets
    }
    
    var wordSets = [String]()
    var wordContainer: [Word] = []
    //做三個字
    var words = [NSMutableAttributedString(),NSMutableAttributedString(),NSMutableAttributedString()]
    
    var mapNum = Int()
//    var spotNum = Int()
//    var unitNum = Int()
    var gameMode = Int()
    
    @IBOutlet weak var reviewBtn: UIButton!
    
    //所有alertView的變數
    var alertBg = UIImageView()
    var alertText = UILabel()
    var ghostBtn = UIButton()
    //var ghost2Btn = UIButton()
    var practiceWordBtn = UIButton()
    var practiceSenBtn = UIButton()
    var leftBtnClickedImg = UIImageView()
    var rightBtnClickedImg = UIImageView()
    var bigQuitBtn = UIButton()
    let darkRed = UIColor.init(red: 192/255, green: 40/255, blue: 75/255, alpha: 1)
    let orangeColor = UIColor.init(red: 232/255, green: 98/255, blue: 61/255, alpha: 1)
    
    @IBOutlet weak var hintLabel: UILabel!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //收到的課程數字
    var courseReceived = Int()
    var isClassAllPassed = false
    
    var maxMapNum = Int()
    var sylFontSize = CGFloat()
    var wordFontSize = CGFloat()
    var titleFontSize = CGFloat()
    
    var hiddenBtn = UIButton()
    
    var lessonTitleFontSize: CGFloat!
    var lessonBigFontSize: CGFloat!
    var lessonSmallFontSize: CGFloat!
    
    var tempS:Int!
    var tempU:Int!
    
    var collectionViewCellSize:CGFloat!
    var smallSylFontSize:CGFloat!
    
    @IBOutlet weak var lessonSylView: UICollectionView!
    
    @IBOutlet weak var allSylBtn: UIButton!
    
    //選擇到的音節
    //var collectionTouched = [Int]()
    var secRowTouched = [[Int]]()
    var maxIndex:Int!
    var maxSpot:Int!
    var maxUnit:Int!
    var iPadSizeDif: CGFloat!
    var collectionViewDif:CGFloat!
    var currentMaxSpotToUse:Int!
    var currentMaxUnitToUse:Int!
    
    //MARK: simVer K12 課程紀錄變數
    //    var k12MapPassed:[Int]!
    //    var k12GamePassed:[[Int:Int]]!
    
    let yellowTextBtnAttr = [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.8666666667, green: 0.8392156863, blue: 0.1960784314, alpha: 1)]

    //單機版
    var isUnlocked = false
    
    var dynamicTitleText = String()
    var syllablesWithoutDigit = String()
    
    var attrs0 = [NSAttributedString.Key: NSObject]()
    var attrs1 = [NSAttributedString.Key: NSObject]()
    var attrs2 = [NSAttributedString.Key: NSObject]()
    var attrs3 = [NSAttributedString.Key: NSObject]()
    
    var level: Level!
    var course: Course!
    var gamePass: [Int: Int]?
    var mapPass: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var dif = CGFloat()
        
        var btnFontSize:CGFloat!
        var hintLabelFontSize:CGFloat!
        
        switch height {
            
        case 1366, 1336:
            
            dif = 0.9
            iPadSizeDif = 2.3
            collectionViewDif = 2.3
            
            sylFontSize = 170
            wordFontSize = 70
            titleFontSize = 45
            lessonTitleFontSize = 25
            lessonBigFontSize = 60
            lessonSmallFontSize = 20
            btnFontSize = 34
            hintLabelFontSize = 30
            
            collectionViewCellSize = 100
            smallSylFontSize = 30
            
        case 1024, 1194, 1112:
            
            dif = 0.9
            iPadSizeDif = 2
            collectionViewDif = 2
            
            
            sylFontSize = 160
            wordFontSize = 60
            titleFontSize = 45
            lessonTitleFontSize = 25
            lessonBigFontSize = 60
            lessonSmallFontSize = 20
            btnFontSize = 30
            hintLabelFontSize = 30
            collectionViewCellSize = 80
            
            smallSylFontSize = 30
            
        case 812:
            
            dif = 1
            iPadSizeDif = 1
            collectionViewDif = 1
            
            sylFontSize = 130
            wordFontSize = 40
            titleFontSize = 28
            lessonTitleFontSize = 14
            lessonBigFontSize = 30
            lessonSmallFontSize = 15
            btnFontSize = 15
            hintLabelFontSize = 16
            
            collectionViewCellSize = 50
            
            smallSylFontSize = 15
            
            
        case 736:
            
            dif = 1.1
            iPadSizeDif = 1
            collectionViewDif = 1
            
            sylFontSize = 130
            wordFontSize = 40
            titleFontSize = 28
            lessonTitleFontSize = 12
            lessonBigFontSize = 30
            lessonSmallFontSize = 15
            btnFontSize = 15
            hintLabelFontSize = 16
            
            collectionViewCellSize = 50
            smallSylFontSize = 15
            
        case 667:
            
            
            dif = 1
            iPadSizeDif = 1
            collectionViewDif = 1
            
            sylFontSize = 120
            wordFontSize = 35
            titleFontSize = 24
            lessonTitleFontSize = 12
            lessonBigFontSize = 30
            lessonSmallFontSize = 15
            btnFontSize = 14
            hintLabelFontSize = 16
            
            collectionViewCellSize = 50
            
            smallSylFontSize = 15
            
            
        case 568:
            
            dif = 0.9
            iPadSizeDif = 1
            collectionViewDif = 0.8
            
            
            sylFontSize = 100
            wordFontSize = 30
            titleFontSize = 20
            lessonTitleFontSize = 12
            lessonBigFontSize = 30
            lessonSmallFontSize = 15
            btnFontSize = 12
            hintLabelFontSize = 16
            
            collectionViewCellSize = 50
            smallSylFontSize = 12
            
            
        default:
            dif = 1
            iPadSizeDif = 1
            collectionViewDif = 1
            
            
            sylFontSize = 130
            wordFontSize = 40
            titleFontSize = 28
            lessonTitleFontSize = 14
            lessonBigFontSize = 30
            lessonSmallFontSize = 15
            btnFontSize = 15
            hintLabelFontSize = 16
            
            collectionViewCellSize = 50
            
            smallSylFontSize = 15
            
            break
        }
        
        
        lessonSylView.delegate = self
        lessonSylView.translatesAutoresizingMaskIntoConstraints = false
        lessonSylView.widthAnchor.constraint(equalToConstant: 320 * collectionViewDif).isActive = true
        lessonSylView.heightAnchor.constraint(equalToConstant: 320 * collectionViewDif).isActive = true
        lessonSylView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lessonSylView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        lessonSylView.layer.cornerRadius = lessonSylView.frame.width / 20
        lessonSylView.backgroundColor = #colorLiteral(red: 0.04737804671, green: 0.1470921287, blue: 0.2021566439, alpha: 1)
        lessonSylView.isHidden = true
        lessonSylView.layer.zPosition = 11
        
        // 建立 UICollectionViewFlowLayout
        let layout = UICollectionViewFlowLayout()
        
        // 設置 section 的間距 四個數值分別代表 上、左、下、右 的間距
        //layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        
        // 設置每一行的間距
        //layout.minimumLineSpacing = 5
        
        // 設置每個 cell 的尺寸
        //  layout.itemSize = CGSize(width:CGFloat(width)/3 - 10.0,height:CGFloat(width)/3 - 10.0)
        
        // 設置 header 及 footer 的尺寸
        layout.headerReferenceSize = CGSize(width: 320 * collectionViewDif, height: 140 * collectionViewDif)
        
        
        //加入alertView
        let lightGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.58)
        ghostBtn.backgroundColor = lightGray
        ghostBtn.addTarget(self, action: #selector(LessonViewController.removeBtns), for: .touchUpInside)
        self.view.addSubview(ghostBtn)
        ghostBtn.fillSupervivew()
        
        //ghostBtn.layer.zPosition = 10
        
        
        
        alertBg.translatesAutoresizingMaskIntoConstraints = false
        alertBg.image = UIImage(named: "reviewSelectBg3.png")
        self.view.addSubview(alertBg)
        alertBg.widthAnchor.constraint(equalToConstant: 237 * iPadSizeDif).isActive = true
        alertBg.heightAnchor.constraint(equalToConstant: 140 * iPadSizeDif).isActive = true
        alertBg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertBg.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        alertText.translatesAutoresizingMaskIntoConstraints = false
        //alertText.backgroundColor = .blue
        alertText.font = UIFont(name: "Helvetica Bold", size: hintLabelFontSize)
        alertText.textColor = .white
        alertText.text = lessonVC_pleaseChoose
        alertText.numberOfLines = 3
        alertText.textAlignment = .center
        alertText.adjustsFontSizeToFitWidth = true
        alertBg.addSubview(alertText)
        alertText.widthAnchor.constraint(equalToConstant: 200 * iPadSizeDif).isActive = true
        alertText.heightAnchor.constraint(equalToConstant: 80 * iPadSizeDif).isActive = true
        alertText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertText.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10).isActive = true
        
        
        
        practiceWordBtn.titleLabel?.font = UIFont(name: "Helvetica Bold", size: hintLabelFontSize)
        practiceWordBtn.setTitle(lessonVC_wordChallenge, for: .normal)
        practiceWordBtn.setTitleColor(orangeColor, for: .normal)
        practiceWordBtn.addTarget(self, action: #selector(LessonViewController.practiceWord), for: .touchUpInside)
        //practiceWordBtn.backgroundColor = .green
        //practiceWordBtn.alpha = 0.5
        //practiceWordBtn.layer.zPosition = 10
        self.view.addSubview(practiceWordBtn)
        
        practiceWordBtn.anchor(top: alertText.bottomAnchor, leading: alertBg.leadingAnchor, bottom: alertBg.bottomAnchor, trailing: nil, size: .init(width: 119 * iPadSizeDif, height: alertBg.frame.height / 3))
        
        //practiceSenBtn.backgroundColor = .brown
        //practiceSenBtn.alpha = 0.5
        practiceSenBtn.titleLabel?.font = UIFont(name: "Helvetica Bold", size: hintLabelFontSize)
        practiceSenBtn.setTitle(lessonVC_senChallenge, for: .normal)
        practiceSenBtn.setTitleColor(orangeColor, for: .normal)
        practiceSenBtn.addTarget(self, action: #selector(LessonViewController.practiceSen), for: .touchUpInside)
        self.view.addSubview(practiceSenBtn)
        practiceSenBtn.anchor(top: alertText.bottomAnchor, leading: practiceWordBtn.trailingAnchor, bottom: alertBg.bottomAnchor, trailing: nil)
        practiceSenBtn.anchorSize(to: practiceWordBtn)
        
        bigQuitBtn = UIButton(type: .system)
        
        
        bigQuitBtn.titleLabel?.font = UIFont(name: "Helvetica Bold", size: hintLabelFontSize)
        bigQuitBtn.setTitle(lessonVC_iKnow, for: .normal)
        bigQuitBtn.setTitleColor(orangeColor, for: .normal)
        //bigQuitBtn.backgroundColor = .blue
        bigQuitBtn.addTarget(self, action:#selector(LessonViewController.removeBtns), for: .touchUpInside)
        self.view.addSubview(bigQuitBtn)
        bigQuitBtn.anchor(top: alertText.bottomAnchor, leading: alertBg.leadingAnchor, bottom: alertBg.bottomAnchor, trailing: alertBg.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        
        
        
        
        backBtn.anchor(top: view.safeTopAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: nil, padding: .init(top: 30, left: 10, bottom: 0, right: 0), size: .init(width: 19 * iPadSizeDif, height: 31 * iPadSizeDif))
        
        
        //backBtn.backgroundColor = .blue
        
        
        lessonTitleLabel.anchor(top: view.safeTopAnchor, leading: nil, bottom: nil, trailing: view.safeRightAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: -20), size: .init(width: 66 * iPadSizeDif, height: 22 * iPadSizeDif))
        
        lessonTitleLabel.textAlignment = .right
        lessonTitleLabel.font = lessonTitleLabel.font.withSize(lessonTitleFontSize)
        lessonTitleLabel.text = lessonVC_currentLesson
        
        
        
        lessonLabel.anchor(top: lessonTitleLabel.bottomAnchor, leading: nil, bottom: nil, trailing: view.safeRightAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: -20), size: .zero)
        
        lessonLabel.anchorSize(to: lessonTitleLabel)
        
        titleLabel.anchor(top: lessonTitleLabel.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: view.safeRightAnchor, size: .init(width: width, height: 72 * dif * iPadSizeDif))
        
        //titleLabel.backgroundColor = .red
        
        titleLabel.numberOfLines = 2
        titleLabel.text = lessonVC_aboutToLearn3Words
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = titleLabel.font.withSize(titleFontSize)
        
        
        
        syllableLabel.anchor(top: titleLabel.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: view.safeRightAnchor, size: .init(width: width, height: height / 3.5 * dif))
        syllableLabel.adjustsFontSizeToFitWidth = true
        syllableLabel.font = syllableLabel.font.withSize(sylFontSize)
        
        syllableLabel.textAlignment = .center
        
        
        firstLabel.anchor(top: syllableLabel.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: view.safeRightAnchor, size: .init(width: width, height: 44 * dif * iPadSizeDif))
        firstLabel.adjustsFontSizeToFitWidth = true
        firstLabel.font = firstLabel.font.withSize(wordFontSize)
        
        
        
        secondLabel.anchor(top: firstLabel.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: view.safeRightAnchor, size: .zero)
        
        secondLabel.anchorSize(to: firstLabel)
        
        secondLabel.adjustsFontSizeToFitWidth = true
        secondLabel.font = secondLabel.font.withSize(wordFontSize)
        
        
        
        thirdLabel.anchor(top: secondLabel.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: view.safeRightAnchor)
        
        thirdLabel.anchorSize(to: secondLabel)
        
        thirdLabel.adjustsFontSizeToFitWidth = true
        thirdLabel.font = thirdLabel.font.withSize(wordFontSize)
        
        
        enterBtn.anchor(top: nil, leading: nil, bottom: view.safeBottomAnchor, trailing: view.safeRightAnchor, size: .init(width: width / 5, height: 50 * iPadSizeDif))
        
        nextBtn.anchor(top: nil, leading: nil, bottom: view.safeBottomAnchor, trailing: enterBtn.leadingAnchor)
        nextBtn.setTitle(lessonVC_nextBtn, for: .normal)
        
        
        allSylBtn.anchor(top: nil, leading: nil, bottom: view.safeBottomAnchor, trailing: nextBtn.leadingAnchor)
        allSylBtn.setTitle(lessonVC_allSylBtn, for: .normal)
        
        
        previousBtn.anchor(top: nil, leading: nil, bottom: view.safeBottomAnchor, trailing: allSylBtn.leadingAnchor)
        previousBtn.setTitle(lessonVC_previousBtn, for: .normal)
        
        
        reviewBtn.anchor(top: nil, leading: view.safeLeftAnchor, bottom: view.safeBottomAnchor, trailing: nil)
        nextBtn.anchorSize(to: enterBtn)
        allSylBtn.anchorSize(to: enterBtn)
        previousBtn.anchorSize(to: enterBtn)
        reviewBtn.anchorSize(to: enterBtn)
        
        let attrs = [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.368627451, green: 0.8117647059, blue: 0.4470588235, alpha: 1)]
        reviewBtn.setAttributedTitle(NSAttributedString(string: lessonVC_reviewBtn, attributes: attrs), for: .normal)
        
        enterBtn.titleLabel?.font = enterBtn.titleLabel?.font.withSize(btnFontSize)
        nextBtn.titleLabel?.font = nextBtn.titleLabel?.font.withSize(btnFontSize)
        allSylBtn.titleLabel?.font = allSylBtn.titleLabel?.font.withSize(btnFontSize)
        
        previousBtn.titleLabel?.font = previousBtn.titleLabel?.font.withSize(btnFontSize)
        reviewBtn.titleLabel?.font = reviewBtn.titleLabel?.font.withSize(btnFontSize)
        
        fullLength.anchor(top: nil, leading: view.safeLeftAnchor, bottom: enterBtn.topAnchor, trailing: view.safeRightAnchor, size: .init(width: width, height: 3))
        
        hintLabel.anchor(top: nil, leading: view.safeLeftAnchor, bottom: fullLength.topAnchor, trailing: view.safeRightAnchor, padding: .init(top: 0, left: 0, bottom: -5, right: 0) ,size: .init(width: width, height: 21 * dif * iPadSizeDif))
        
        hintLabel.font = hintLabel.font.withSize(hintLabelFontSize)
        
        hintLabel.text = lessonVC_hintLabel
        
        progressLength.anchor(top: nil, leading: view.safeLeftAnchor, bottom: enterBtn.topAnchor, trailing: nil, size: .init(width: width, height: 3))
        //拉到最前方
        
        self.view.bringSubviewToFront(ghostBtn)
        self.view.bringSubviewToFront(alertBg)
        
        self.view.bringSubviewToFront(practiceWordBtn)
        self.view.bringSubviewToFront(practiceSenBtn)
        self.view.bringSubviewToFront(leftBtnClickedImg)
        self.view.bringSubviewToFront(rightBtnClickedImg)
        self.view.bringSubviewToFront(bigQuitBtn)
        
        self.view.bringSubviewToFront(lessonSylView)
        
        /*
         firstLabel.backgroundColor = .red
         lessonTitleLabel.backgroundColor = .yellow
         secondLabel.backgroundColor = .green
         thirdLabel.backgroundColor = .yellow
         hintLabel.backgroundColor = .green
         lessonLabel.backgroundColor = .red
         syllableLabel.backgroundColor = .blue
         */
        
        
        //
        
        removeBtns()
        
    }
    
    
    //MARK: CollectionViewLayOut
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSize = CGSize(width: collectionViewCellSize, height: collectionViewCellSize)
        return cellSize
        
    }
    
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return 10
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return secRowTouched.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize(width: 320 * collectionViewDif, height: 40 * collectionViewDif)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 建立 UICollectionReusableView
        var reusableView = UICollectionReusableView()
        
        // header
        if kind == UICollectionView.elementKindSectionHeader {
            // 依據前面註冊設置的識別名稱 "Header" 取得目前使用的 header
            reusableView =
                collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: "Header",
                    for: indexPath)
            
            
            //reusableView.frame = CGRect(x: 0, y: 0, width: 320 * collectionViewDif, height: 40 * collectionViewDif)
            
            // 設置 header 的內容
            let label = reusableView.viewWithTag(3) as! UILabel
            // 顯示文字
            label.frame = CGRect(x: 0, y: 0,width: 320 * collectionViewDif, height: 40 * collectionViewDif)
            label.textAlignment = .center
            
            label.font = label.font.withSize(smallSylFontSize)
            let labelText = indexPath.section + 1
            reusableView.backgroundColor = .darkGray
            label.text = "第\(labelText)\(lessonVC_class)";
            label.textColor = UIColor.white
            
            
        }
        
        //reusableView.addSubview(label)
        return reusableView
    }
    
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = lessonSylView.dequeueReusableCell(withReuseIdentifier: "lessonSylCell", for: indexPath)
        
        
        let blueBall = cell.viewWithTag(2) as! UIImageView
        
        //blueBall.frame.size = CGSize(width: collectionViewCellSize * 0.9, height: collectionViewCellSize * 0.9)
        
        blueBall.translatesAutoresizingMaskIntoConstraints = false
        blueBall.widthAnchor.constraint(equalToConstant: collectionViewCellSize * 0.9).isActive = true
        blueBall.heightAnchor.constraint(equalToConstant: collectionViewCellSize * 0.9).isActive = true
        blueBall.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        blueBall.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        
        let sylText = cell.viewWithTag(1) as!UILabel
        sylText.adjustsFontSizeToFitWidth = true
        //let sylToDisplay = sortedSylArray[indexPath.row]
        
        //sylText.text = sylToDisplay
        //sylText.textColor = btnOffColor
        sylText.font = sylText.font.withSize(smallSylFontSize)
        //sylText.backgroundColor = .green
        sylText.translatesAutoresizingMaskIntoConstraints = false
        sylText.widthAnchor.constraint(equalToConstant: collectionViewCellSize * 0.8).isActive = true
        sylText.heightAnchor.constraint(equalToConstant: collectionViewCellSize * 0.8).isActive = true
        sylText.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        sylText.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        
        //let sylToShow = allSyls[indexPath.row]
        
        
        //MARK: simVer 這兩條code先comment not yet
        
        if lan == "zh-Hans" && isSimVerSingleSyllable {
            //檢體中文
            
            //print("檢體中文關卡數")
            //之後還要用courseReceived來改數值, 因為每個course值不同
            //*****這部分有點複雜可能等之後讀取完syllableSets再來看是否要細分處理
            
            //sylText.text = String(indexPath.row + 1)
            
            //MARK: simVer 這裡沒有數字要自加數字上去
            let sylToShow = syllableSets[indexPath.section][indexPath.row * 3]
            let numbersRange = sylToShow.rangeOfCharacter(from: .decimalDigits)
            
            let hasNumbers = (numbersRange != nil)
            
            if hasNumbers{
                
                sylText.text = sylToShow
            } else {
                sylText.text = sylToShow + "\(indexPath.row + 1)"
            }
            
        } else {
            //其餘語言
            //print("繁體中文關卡數")
            let sylToShow = syllableSets[indexPath.section][indexPath.row]
            sylText.text = sylToShow
            
        }
        
        if !lessonSylView.isHidden{
            
            
            
            if secRowTouched[indexPath.section][indexPath.row] == 1 {
                
                sylText.textColor = .white
                blueBall.isHidden = false
                
            } else {
                blueBall.isHidden = true
                var isSelectable = false
                
                //MARK: simVer Test maxSpot  / maxUnit  為了避免被改變用另一組變數
                if indexPath.section < currentMaxSpotToUse {
                    isSelectable = true
                } else if indexPath.section < currentMaxSpotToUse + 1 && indexPath.row < currentMaxUnitToUse + 1{
                    isSelectable = true
                } else {
                    isSelectable = false
                }
                
                
                
                if isSelectable{
                    sylText.textColor = .lightGray
                } else {
                    sylText.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                }
                
                
                
            }
            
            
            if isScrollable{
                
                isScrollable = false
                let indexToScroll = IndexPath(item: tempU, section: tempS)
                
                lessonSylView.scrollToItem(at: indexToScroll, at: .centeredVertically, animated: false)
            }
            
        }
        
        
        
        return cell
        
    }
    
    var loadingTimer:Timer!
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        //選到後 1. 發亮 2. 隱藏畫面 3. load正確字
        
        //MARK: simVer Test maxSpot  / maxUnit  為了避免被改變用另一組變數
        
        
        var isSelectable = false
        
        if indexPath.section < currentMaxSpotToUse {
            isSelectable = true
        } else if indexPath.section < currentMaxSpotToUse + 1 && indexPath.row < currentMaxUnitToUse + 1{
            isSelectable = true
        } else {
            isSelectable = false
        }
        
        
        if isSelectable{
            
            
            ProgressHUD.colorSpinner(.white)
//            ProgressHUD.spinnerColor(.white)

            ProgressHUD.show(lessonVC_loading)
            
            
            //啟動loading標題及字
            loadingTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(LessonViewController.loading), userInfo: nil, repeats: true)
            
            secRowTouched.removeAll(keepingCapacity: false)
            var smallDic = [Int]()
            
            for _ in  0 ..< 10 {
                
                smallDic.append(0)
            }
            
            
            for _ in 0 ..< course.maxSpotNumber {
                
                secRowTouched.append(smallDic)
            }
            
            
            lessonSylView.reloadData()
            
            //換算tempS & tempU
            //tempU = indexPath.row % 10
            //tempS = indexPath.row / 10
            
            tempS = indexPath.section
            tempU = indexPath.row
            
            secRowTouched[tempS][tempU] = 1
            
            //MARK: simVer K12進不來這裡因為mapPassed不同, 所以要讓他可以進得來
            
            if mapNumToReceive == mapPassedInt || courseReceived == 5{
                
                for (s,u) in gamePassedDic!{
                    
                    //MARK: simVer K12
                    //這裏最後加入一個判斷是!isClassAllPassed來確保k12過關進入後不會有學習新字的情形
                    if s == tempS && u == tempU && !isClassAllPassed{
                        //學習新字
                        if !isUnlocked{
                            enterBtn.setAttributedTitle(NSAttributedString(string: lessonVC_enterBtn, attributes: yellowTextBtnAttr), for: .normal)
                            
                            titleLabel.text = lessonVC_aboutToLearn3Words
                            titleLabel.textColor = .white
                        }
                    } else {
                        
                        //複習機制
                        enterBtn.setAttributedTitle(NSAttributedString(string: lessonVC_enterReviewBtn, attributes: yellowTextBtnAttr), for: .normal)
                        
                        titleLabel.text = dynamicTitleText
                        titleLabel.textColor = #colorLiteral(red: 1, green: 0.027038477, blue: 0.405282959, alpha: 1)
                    }
                    
                }
                
            } else {
                
                //複習機制
                enterBtn.setAttributedTitle(NSAttributedString(string: lessonVC_enterReviewBtn, attributes: yellowTextBtnAttr), for: .normal)
                
                titleLabel.text = dynamicTitleText
                titleLabel.textColor = #colorLiteral(red: 1, green: 0.027038477, blue: 0.405282959, alpha: 1)
                
            }
            
            
            //  }
            
        } else {
            
            ProgressHUD.showError(lessonVC_alertNotYet)
        }
    }
    
    var secondCount = 0
    
    @objc func loading(){
        
        if secondCount < 3 {
            
            secondCount += 1
            
        } else {
            
            ProgressHUD.dismiss()
            secondCount = 0
            loadingTimer.invalidate()
            loadWords(seq: 0)
            lessonSylView.isHidden = true
            ghostBtn.isHidden = true
            
        }
        
    }
    
    @objc func receiveIsUnlockedStatus(_ notification: NSNotification) {
        
        if let isUnlocked = notification.userInfo?["isUnlocked"] as? Bool {
            
            self.isUnlocked = isUnlocked
            print("receive isUnlocked status:\(isUnlocked)")
            
        }
        
    }
    
    @objc func removeBtns(){
        
        alertText.text = lessonVC_pleaseChoose
        ghostBtn.isHidden = true
        alertBg.isHidden = true
        //ghost2Btn.isHidden = true
        practiceWordBtn.isHidden = true
        practiceSenBtn.isHidden = true
        leftBtnClickedImg.isHidden = true
        rightBtnClickedImg.isHidden = true
        bigQuitBtn.isHidden = true
        practiceSenBtn.isEnabled = true
        practiceWordBtn.isEnabled = true
        alertBg.image = UIImage(named: "reviewSelectBg3.png")
        lessonSylView.isHidden = true

    }
    
    
    
    deinit {
        print("lesson deinit")
    }
    
    
    @objc func practiceSen(){
        print("practice Sen")
        
        gameMode = 2
        
        
        practiceWordBtn.isEnabled = false
        practiceSenBtn.isEnabled = false
        
        //有bug, 印出以下兩數字
        
        /*
         print(self!.mapPassedInt)
         print(self!.gamePassedDic)
         */
        
        //這裡沒有大於的可能性
        //MARK: simVer K12 特別作法
        if gamePassedDic == [0:0] && mapNumToReceive == mapPassedInt{
            
            cannotPracticeAlert()
            
        } else if gamePassedDic == [0:0] && courseReceived == 5{
            
            cannotPracticeAlert()
        } else{
            
            performSegue(withIdentifier: "toGameVc", sender: self)
        }
        
    }
    
    @objc func practiceWord(){
        
        gameMode = 1
        
        UIView.animate(withDuration: 0.06, animations: {[weak self] in
            
            self!.leftBtnClickedImg.alpha = 1
            
            
        }) {[weak self] (finished:Bool) in
            
            
            if finished {
                self!.leftBtnClickedImg.alpha = 0
                self?.practiceSenBtn.isEnabled = false
                self?.practiceWordBtn.isEnabled = false
                
                //這裡沒有大於的可能性
                if self!.gamePassedDic == [0:0] && self!.mapNumToReceive == self!.mapPassedInt{
                    
                    self!.cannotPracticeAlert()
                } else if self!.gamePassedDic == [0:0] && self!.courseReceived == 5 {
                    
                    self!.cannotPracticeAlert()
                    
                } else{
                    
                    self!.performSegue(withIdentifier: "toGameVc", sender: self)
                }
            }
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        practiceSenBtn.isEnabled = true
        practiceWordBtn.isEnabled = true
        isUnlocked = false
        removeBtns()
    }
    
    var gamePassedDic:[Int:Int]?
    var mapPassedInt = Int()
    var increaseNum = Int()
    var allSyls = [String]()

    //這裡的已經redeclare了
    //var maxSpot = Int()
    //MARK: simVer 這裡要建立如何建立音節的變數 done
    var isSimVerSingleSyllable = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(LessonViewController.receiveIsUnlockedStatus), name: NSNotification.Name(sendUnlockStatus), object: nil)
        
        enterBtn.setAttributedTitle(NSAttributedString(string: lessonVC_enterBtn, attributes: yellowTextBtnAttr), for: .normal)
        titleLabel.text = lessonVC_aboutToLearn3Words
        titleLabel.textColor = .white
        
        //單機版
        if isUnlocked {
            isClassAllPassed = true // force change?
            dynamicTitleText = lessonVC_allOpenMode
        } else {
            dynamicTitleText = lessonVC_review3Words
        }
        
        mapPass = course.isK12Class ? course.k12MapPass![mapNumToReceive] : course.mapPass
        gamePass = course.isK12Class ? course.k12GamePass![mapNumToReceive] : course.gamePass
        
        
        attrs0 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: lessonBigFontSize), NSAttributedString.Key.foregroundColor : pinkColor]
        attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: lessonSmallFontSize), NSAttributedString.Key.foregroundColor : UIColor.white]
        attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: wordFontSize), NSAttributedString.Key.foregroundColor : UIColor.cyan]
        attrs3 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: wordFontSize), NSAttributedString.Key.foregroundColor : UIColor.white]
                
        let smallDic = Array.init(repeating: 0, count: 10)
        secRowTouched = Array.init(repeating: smallDic, count: course.maxSpotNumber)
                
        //再把數字減回來
        let deductedMapNumber = (course.mapNumberReceived ?? 0) - course.increaseNumber
        
        
        //MARK: simVer 放在外的變數 done
        var threeSyllables = [String]()
        
        if course.isClassAllPassed { //MARK: needed? need to test!
            mapNum = deductedMapNumber
            tempS = course.isSimplifiedElementary ? course.maxSpotNumber - 1 : 14
            tempU = 9
            enterBtn.setAttributedTitle(NSAttributedString(string: lessonVC_enterReviewBtn, attributes: yellowTextBtnAttr), for: .normal)
            titleLabel.text = dynamicTitleText
            titleLabel.textColor = #colorLiteral(red: 1, green: 0.027038477, blue: 0.405282959, alpha: 1)
        } else if let gamePass = gamePass, let mapPass = mapPass {
            for (s,u) in gamePass {
                //這個狀態下mapPassedInt 跟 mapNumToReceive是一樣的
                mapNum = mapPass
                tempS = s
                tempU = u
            }
        }
        
        
        //已確認 : maxSpot  / maxUnit  為了避免被改變用另一組變數
        currentMaxSpotToUse = tempS
        currentMaxUnitToUse = tempU
        
        let lessonText = NSMutableAttributedString(string: String(tempS + 1), attributes: attrs0)
        let maxSpotString = String(course.maxSpotNumber)
        lessonText.append(NSMutableAttributedString(string: " / \(maxSpotString)", attributes: attrs1))
        lessonLabel.attributedText = lessonText
        
        //MARK: simVer K12的地圖讀法要再增加
        let unit = tempS + 1
        var chapter = course.increaseNumber + 1
        let chapterToIncrease = course.isK12Class ? deductedMapNumber : mapNum
        chapter += chapterToIncrease
        
        let file = File(chapter: chapter, unit: unit)
        let word = MissWordUtility.shared.loadWords(file: file)
        wordContainer.append(contentsOf: word)
        
        var allThreeWords = [Word]()
        for i in 0 ..< 3 {
            allThreeWords.append(wordContainer[tempU  * 3 + i])
        }
        
        if course.isSimVersionSingleSyllableSet {
            for i in tempU * 3 ..< tempU * 3 + 3 {
                let syllableChosen = syllableSets[tempS][i]
                let syllableChosenArray = syllableChosen.components(separatedBy: NSCharacterSet.decimalDigits)
                let firstSyllable = syllableChosenArray.first
                threeSyllables.append(firstSyllable ?? "")
            }
            makeSyllableLabelText(syllableText: "Unit " + String(tempU + 1), fontSize: sylFontSize / 2)
        } else {
            let syllableChosen = syllableSets[tempS][tempU]
            let syllableChosenArray = syllableChosen.components(separatedBy: NSCharacterSet.decimalDigits)
            threeSyllables = Array(repeating: syllableChosenArray.first ?? "", count: 3)
            makeSyllableLabelText(syllableText: syllableChosenArray.first ?? "", fontSize: sylFontSize)
        }
        
        let attrWords = generateAttrWords(allThreeWords: allThreeWords, threeSyllables: threeSyllables)
        makeAttributedLabelText(attrWords: attrWords)
        enterBtn.isEnabled = true
    }
    
    private func makeSyllableLabelText(syllableText: String, fontSize: CGFloat) {
        syllableLabel.font = syllableLabel.font.withSize(fontSize)
        syllableLabel.text = syllableText
    }
    
    private func generateAttrWords(allThreeWords: [Word], threeSyllables: [String]) -> [[NSMutableAttributedString]] {
        var attrWords = [[NSMutableAttributedString](),[NSMutableAttributedString](),[NSMutableAttributedString]()]
        for i in 0 ..< threeSyllables.count {
            let currentSyllable = threeSyllables[i]
            if currentSyllable.contains("_") {
                var characters = [Character]()
                for partedEngWord in allThreeWords[i].partedEnglishArray {
                    characters.removeAll(keepingCapacity: false)
                    for character in partedEngWord {
                        characters.append(character)
                    }
                    if characters.count == 3 && characters[2] == "e" && vowels.contains(String(characters[0])) {
                        //剛好是_e部首
                        let word = NSMutableAttributedString(string: String(characters[0]), attributes: attrs2)
                        attrWords[i].append(word)
                        let word1 = NSMutableAttributedString(string: String(characters[1]), attributes: attrs3)
                        attrWords[i].append(word1)
                        let word2 = NSMutableAttributedString(string: String(characters[2]), attributes: attrs2)
                        attrWords[i].append(word2)
                    } else {
                        for c in 0 ..< characters.count {
                            let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs3)
                            attrWords[i].append(word)
                        }
                    }
                }
            } else {
                for partedEngWord in allThreeWords[i].partedEnglishArray {
                    var tempAttr = [NSAttributedString.Key: NSObject]()
                    tempAttr = partedEngWord.lowercased() == currentSyllable ? attrs2 :  attrs3
                    let word = NSMutableAttributedString(string: partedEngWord, attributes: tempAttr)
                    attrWords[i].append(word)
                }
            }
        }
        return attrWords
    }
    
    private func makeAttributedLabelText(attrWords: [[NSMutableAttributedString]]) {
        for w in 0 ..< attrWords.count {
            for i in 0 ..< attrWords[w].count {
                if i == 0 {
                    words[w] = attrWords[w][i]
                } else {
                    words[w].append(attrWords[w][i])
                }
            }
        }
        firstLabel.attributedText = words[0]
        secondLabel.attributedText = words[1]
        thirdLabel.attributedText = words[2]
    }
    
    //寫一個獨立的讀取單字功能
    func loadWords(seq: Int) {
        let deductedMapNumber = (course.mapNumberReceived ?? 0) - course.increaseNumber
        var threeSyllables = [String]()
        
        //首先抓音節
        if seq > 0 {
            if tempU < 9 {
                tempU = tempU + 1
            } else {
                if tempS < course.maxSpotNumber - 1 {
                    tempS = tempS + 1
                    tempU = 0
                } else {
                    ProgressHUD.showError(lessonVC_theLastPage)
                    return //MARK: check if should return
                }
            }
        
            guard let gamePass = gamePass,
                  let mapPass = mapPass,
                  let spot = gamePass.keys.first,
                  let unit = gamePass.values.first,
                  tempU == unit,
                  tempS == spot,
                  (deductedMapNumber == mapPass || course.isK12Class),
                  !isUnlocked
            else {
                return
            }
            
            enterBtn.setAttributedTitle(NSAttributedString(string: lessonVC_enterBtn, attributes: yellowTextBtnAttr), for: .normal)
            titleLabel.text = lessonVC_aboutToLearn3Words
            titleLabel.textColor = .white
        } else if seq < 0 {
            if tempU > 0 {
                tempU = tempU - 1
            } else {
                if tempS > 0 {
                    //直接 -1
                    tempS = tempS - 1
                    tempU = 9
                } else {
                    ProgressHUD.showError(lessonVC_thisIsFirst)
                    return
                }
            }
            enterBtn.setAttributedTitle(NSAttributedString(string: lessonVC_enterReviewBtn, attributes: yellowTextBtnAttr), for: .normal)
            titleLabel.text = dynamicTitleText
            titleLabel.textColor = #colorLiteral(red: 1, green: 0.027038477, blue: 0.405282959, alpha: 1)
        }
        
        
        if course.isSimVersionSingleSyllableSet {
            for i in tempU * 3 ..< tempU * 3 + 3 {
                let syllableChosen = syllableSets[tempS][i]
                let syllableChosenArray = syllableChosen.components(separatedBy: NSCharacterSet.decimalDigits)
                syllablesWithoutDigit = syllableChosenArray[0]
                threeSyllables.append(syllablesWithoutDigit)
            }
            syllableLabel.text = "Unit " + String(tempU + 1)
        } else {
            let syllableChosen = syllableSets[tempS][tempU]
            let syllableChosenArray = syllableChosen.components(separatedBy: NSCharacterSet.decimalDigits)
            syllablesWithoutDigit = syllableChosenArray[0]
            syllableLabel.text = syllablesWithoutDigit
        }
        
        mapNum = course.isClassAllPassed ? deductedMapNumber : mapPass ?? 0
        //MARK: refactoring
        
        let lessonText = NSMutableAttributedString(string: String(tempS + 1), attributes: attrs0)
        lessonText.append(NSMutableAttributedString(string: " / \(String(maxSpot!))", attributes: attrs1))
        lessonLabel.attributedText = lessonText
        
        
        //MARK: 讀取文字檔
        //讀取Bundle裡的文字檔
        var wordFile:String?
        
        //供抓字用 & pass給 gameVc
        // mapNum += increaseNum
        
        var name:String!
        
        if courseReceived == 5 {
            //k12 在這狀況下mapNum = 0 / 1
            name = String(increaseNum + 1 + mapNumToReceive) + "-" + String(tempS + 1)
        }else {
            name = String(increaseNum + mapNum + 1) + "-" + String(tempS + 1)
        }
        
        
        if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
            do {
                wordFile = try String(contentsOfFile: filepath)
                let words = wordFile?.components(separatedBy: "; ")
                
                //把字讀取到wordSets裡
                wordSets = words!
                //print(contents)
            } catch {
                // contents could not be loaded
            }
        } else {
            // example.txt not found!
        }
        
        // mapNum -= increaseNum
        
        //這個engWords是尚未attr的, attr完的是
        var allThreeEngWordsArray = [[String]]()
        var allThreeEngWords = [String]()
        
        let engWord0 = wordSets[tempU * 3].components(separatedBy: " ")
        let engWord1 = wordSets[tempU * 3 + 1].components(separatedBy: " ")
        let engWord2 = wordSets[tempU * 3 + 2].components(separatedBy: " ")
        
        allThreeEngWordsArray.append(engWord0)
        allThreeEngWordsArray.append(engWord1)
        allThreeEngWordsArray.append(engWord2)
        
        
        for i in 0 ..< allThreeEngWordsArray.count{
            var word = String()
            
            for syl in allThreeEngWordsArray[i]{
                
                word = word + syl
            }
            
            allThreeEngWords.append(word)
        }
        
        var attrWords = [[NSMutableAttributedString](),[NSMutableAttributedString](),[NSMutableAttributedString]()]
   
        //MARK: simVer 這裏音節要重做, 下方放有原始作法 done
        //***** 這裏加入判斷式儀即可
        
        if lan == "zh-Hans" && isSimVerSingleSyllable{
            //檢體中文
            
            //print("檢體中文關卡數")
            for i in 0 ..< threeSyllables.count {
                
                if threeSyllables[i].contains("_"){
                    //specialE的作法
                    
                    var characters = [Character]()
                    
                    //每一個英文字節拆字母
                    //      for w in 0 ..< allThreeEngWordsArray.count{
                    
                    for r in 0 ..< allThreeEngWordsArray[i].count{
                        characters.removeAll(keepingCapacity: false)
                        
                        for c in allThreeEngWordsArray[i][r]{
                            
                            characters.append(c)
                        }
                        
                        if characters.count == 3{
                            if characters[2] == "e"{
                                
                                if vowels.contains(String(characters[0])){
                                    
                                    
                                    //剛好是_e部首
                                    let word = NSMutableAttributedString(string: String(characters[0]), attributes: attrs2)
                                    attrWords[i].append(word)
                                    let word1 = NSMutableAttributedString(string: String(characters[1]), attributes: attrs3)
                                    attrWords[i].append(word1)
                                    let word2 = NSMutableAttributedString(string: String(characters[2]), attributes: attrs2)
                                    attrWords[i].append(word2)
                                    
                                    
                                } else {
                                    
                                    for c in 0 ..< characters.count {
                                        
                                        let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs3)
                                        attrWords[i].append(word)
                                    }
                                    
                                }
                                
                            } else {
                                
                                for c in 0 ..< characters.count {
                                    
                                    let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs3)
                                    attrWords[i].append(word)
                                }
                                
                            }
                            
                        } else {
                            
                            for c in 0 ..< characters.count {
                                
                                let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs3)
                                attrWords[i].append(word)
                            }
                            
                        }
                        
                    }
                    //   }
                    
                } else {
                    //非specialE的作法
                    
                    //抓三個字的array
                    //      for w in 0 ..< allThreeEngWordsArray.count{
                    
                    //抓array的音節,  只抓一個字
                    for r in 0 ..< allThreeEngWordsArray[i].count{
                        
                        if let engWord = allThreeEngWordsArray[i][r] as String?{
                            
                            if engWord.lowercased() == threeSyllables[i]{
                                //符合部首字
                                
                                let word = NSMutableAttributedString(string: engWord, attributes: attrs2)
                                attrWords[i].append(word)
                                
                                
                            } else{
                                //一般字元
                                
                                let word = NSMutableAttributedString(string: engWord, attributes: attrs3)
                                
                                attrWords[i].append(word)
                                
                            }
                        }
                        
                    }
                    
                    //     }
                    
                }
                
            }
            
            
            
        } else {
            //其餘語言
            //MARK: 音節變色
            if syllablesWithoutDigit.contains("_"){
                //specialE的作法
                
                var characters = [Character]()
                
                //每一個英文字節拆字母
                for w in 0 ..< allThreeEngWordsArray.count{
                    
                    for i in 0 ..< allThreeEngWordsArray[w].count{
                        
                        characters.removeAll(keepingCapacity: false)
                        
                        for c in allThreeEngWordsArray[w][i]{
                            
                            characters.append(c)
                        }
                        
                        if characters.count == 3{
                            if characters[2] == "e"{
                                
                                if vowels.contains(String(characters[0])){
                                    
                                    
                                    //剛好是_e部首
                                    let word = NSMutableAttributedString(string: String(characters[0]), attributes: attrs2)
                                    attrWords[w].append(word)
                                    let word1 = NSMutableAttributedString(string: String(characters[1]), attributes: attrs3)
                                    attrWords[w].append(word1)
                                    let word2 = NSMutableAttributedString(string: String(characters[2]), attributes: attrs2)
                                    attrWords[w].append(word2)
                                    
                                    
                                } else {
                                    
                                    for c in 0 ..< characters.count {
                                        
                                        let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs3)
                                        attrWords[w].append(word)
                                    }
                                    
                                }
                                
                            } else {
                                
                                for c in 0 ..< characters.count {
                                    
                                    let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs3)
                                    attrWords[w].append(word)
                                }
                                
                            }
                            
                        } else {
                            
                            for c in 0 ..< characters.count {
                                
                                let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs3)
                                attrWords[w].append(word)
                            }
                            
                        }
                        
                    }
                }
                
            } else {
                //非specialE的作法
                
                //抓三個字的array
                for w in 0 ..< allThreeEngWordsArray.count{
                    
                    //抓array的音節,  只抓一個字
                    for i in 0 ..< allThreeEngWordsArray[w].count{
                        
                        if let engWord = allThreeEngWordsArray[w][i] as String?{
                            
                            if engWord == syllablesWithoutDigit{
                                //符合部首字
                                
                                let word = NSMutableAttributedString(string: engWord, attributes: attrs2)
                                attrWords[w].append(word)
                                
                                
                            } else{
                                //一般字元
                                
                                let word = NSMutableAttributedString(string: engWord, attributes: attrs3)
                                
                                attrWords[w].append(word)
                                
                            }
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        
        //*** 以下為共同的造字func, 把字造到words裡
        
        for w in 0 ..< attrWords.count {
            
            for i in 0 ..< attrWords[w].count { //[w]
                
                if i == 0 {
                    words[w] = attrWords[w][i] //[w]
                    
                } else {
                    words[w].append(attrWords[w][i]) //[w]
                }
            }
        }
        
        
        //造完字後顯示出英文部分
        firstLabel.attributedText = words[0]
        secondLabel.attributedText = words[1]
        thirdLabel.attributedText = words[2]
        
        enterBtn.isEnabled = true
        
    }
    
    @IBAction func enterGameClicked(_ sender: Any) {
        
        gameMode = 0
        enterBtn.isEnabled = false
        performSegue(withIdentifier: "toGameVc", sender: self)
    }
    
    @IBAction func reviewBtnClicked(_ sender: Any) {
        
        ghostBtn.isHidden = false
        alertBg.isHidden = false
        //ghost2Btn.isHidden = false
        practiceWordBtn.isHidden = false
        practiceSenBtn.isHidden = false
        leftBtnClickedImg.isHidden = false
        rightBtnClickedImg.isHidden = false
        
    }
    
    func cannotPracticeAlert(){
        
        
        alertText.text = lessonVC_alertNoChallenge
        ghostBtn.isHidden = false
        
        
        alertBg.image = UIImage(named: "reviewQuitBg3.png")
        alertBg.isHidden = false
        bigQuitBtn.isHidden = false
        //ghost2Btn.isHidden = false
        practiceWordBtn.isHidden = true
        practiceSenBtn.isHidden = true
        //leftBtnClickedImg.isHidden = false
        //rightBtnClickedImg.isHidden = false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toGameVc"{
            let destinationVC = segue.destination as! NewGameViewController
            //destinationVC.spotNumber = spotNum
            //destinationVC.unitNumber = unitNum
            
            //#test: 試試看複習模式
            destinationVC.spotNumber = tempS
            destinationVC.unitNumber = tempU
            
            if isUnlocked {
                destinationVC.isReplay = false
                destinationVC.isUnlocked = true
            } else {
                
                for (s,u) in gamePassedDic!{
                    
                    if tempU != u || tempS != s{
                        //不是當下關卡
                        destinationVC.isReplay = true
                    } else {
                        destinationVC.isReplay = false
                    }
                }
            }
            //MARK: simVer K12特別作法
            if courseReceived == 5 {
                destinationVC.mapNumber = mapNumToReceive
            } else {
                destinationVC.mapNumber = mapNum
            }
            
            destinationVC.gameMode = gameMode
            destinationVC.courseReceived = courseReceived
            destinationVC.isUnlocked = isUnlocked
            
            destinationVC.modalPresentationStyle = .fullScreen
            
            if #available(iOS 13.0, *) {
                destinationVC.isModalInPresentation = false
            } else {
                // Fallback on earlier versions
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var indexToJump:Int!
    var isScrollable = false
    //MARK: button actions
    
    
    @IBAction func allSylBtnClicked(_ sender: Any) {
        
        isScrollable = true
        ghostBtn.isHidden = false
        
        indexToJump = tempS * 10 + tempU
        
        //指定好發亮的球
        
        secRowTouched.removeAll(keepingCapacity: false)
        var smallDic = [Int]()
        
        for _ in  0 ..< 10 {
            
            smallDic.append(0)
        }
        
        for _ in 0 ..< maxSpot {
            
            secRowTouched.append(smallDic)
            
        }
        
        secRowTouched[tempS][tempU] = 1
        
        
        lessonSylView.reloadData()
        lessonSylView.isHidden = false
        
    }
    
    @IBAction func preBtnClicked(_ sender: Any) {
        
        //需要排除第一次玩的狀態
        //MARK: simVer K12的例外狀況
        guard let gamePass = gamePass,
              let mapPass = mapPass,
              let spot = gamePass.keys.first,
              let unit = gamePass.values.first else {
            return
        }
        
        if course.isK12Class {
            if spot != 0 || unit != 0 || mapPass == 1 {
                loadWords(seq: -1)
                return
            }
        } else {
            let deductedMapNumber = (course.mapNumberReceived ?? 0) - course.increaseNumber
            if spot != 0 || unit != 0 || mapPass != deductedMapNumber {
                loadWords(seq: -1)
                return
            }
        }
        
        ProgressHUD.showError(lessonVC_noPrePage)
    }
    
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        
        //假如等於當下關卡就不能加１
        
        //MARK: simVer k12此處的mapPassedInt不正確
        
        if courseReceived == 5 {
            //K12
            
            for (s,u) in gamePassedDic!{
                
                if tempU != u || tempS != s || isClassAllPassed{
                    //不是當下關卡
                    
                    loadWords(seq: 1)
                    
                } else if !isClassAllPassed{
                    
                    
                    ProgressHUD.showError(lessonVC_noNextPage)
                    
                    enterBtn.setAttributedTitle(NSAttributedString(string: lessonVC_enterBtn, attributes: yellowTextBtnAttr), for: .normal)
                    
                    
                    titleLabel.text = lessonVC_aboutToLearn3Words
                    titleLabel.textColor = .white
                    
                    
                } else if isUnlocked {
                    loadWords(seq: 1)
                }
                
            }
            
            
            
        } else {
            
            for (s,u) in gamePassedDic!{
                
                if tempU != u || tempS != s || mapNumToReceive != mapPassedInt{
                    //不是當下關卡
                    
                    loadWords(seq: 1)
                    
                } else if !isClassAllPassed{
                    
                    ProgressHUD.showError(lessonVC_noNextPage)
                    
                    enterBtn.setAttributedTitle(NSAttributedString(string: lessonVC_enterBtn, attributes: yellowTextBtnAttr), for: .normal)
                    
                    titleLabel.text = lessonVC_aboutToLearn3Words
                    titleLabel.textColor = .white
                    
                } else if isUnlocked {
                    loadWords(seq: 1)
                }
                
            }
            
            
        }
        
        
        
        
    }
    
    
    
}



extension UIView{
    
    func fillSupervivew(){
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    
    func anchorSize(to view: UIView){
        
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
            
        }
        
        if let leading = leading {
            
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
            
        }
        
        if let bottom = bottom {
            
            bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
            
        }
        if let trailing = trailing {
            
            trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
            
        }
        
        if size.width != 0 {
            
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
            
        }
        
        
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
            
        }
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.leadingAnchor
        }else {
            return self.leadingAnchor
        }
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.trailingAnchor
        }else {
            return self.trailingAnchor
        }
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }
    
    
}
