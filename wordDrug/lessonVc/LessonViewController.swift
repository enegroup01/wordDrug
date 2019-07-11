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
    var syllableSets = [[String]()]
    
    var wordSets = [String]()
    //做三個字
    var words = [NSMutableAttributedString(),NSMutableAttributedString(),NSMutableAttributedString()]
    
    var mapNum = Int()
    var spotNum = Int()
    var unitNum = Int()
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
    
    let attrsBtn = [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.8666666667, green: 0.8392156863, blue: 0.1960784314, alpha: 1)]
    
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
        
        let attrs = [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.368627451, green: 0.8117647059, blue: 0.4470588235, alpha: 1)]
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
        
        //拉到最前方
        
        self.view.bringSubview(toFront: ghostBtn)
        self.view.bringSubview(toFront: alertBg)
        
        self.view.bringSubview(toFront: practiceWordBtn)
        self.view.bringSubview(toFront: practiceSenBtn)
        self.view.bringSubview(toFront: leftBtnClickedImg)
        self.view.bringSubview(toFront: rightBtnClickedImg)
        self.view.bringSubview(toFront: bigQuitBtn)
        
        self.view.bringSubview(toFront: lessonSylView)
        
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
        if kind == UICollectionElementKindSectionHeader {
            // 依據前面註冊設置的識別名稱 "Header" 取得目前使用的 header
            reusableView =
                collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionElementKindSectionHeader,
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
        
        if lan == "zh-Hans" && isSimVerSingleSyllable{
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
            

            
            ProgressHUD.spinnerColor(.white)
            
            ProgressHUD.show(lessonVC_loading)
            
            
            //啟動loading標題及字
            loadingTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(LessonViewController.loading), userInfo: nil, repeats: true)
            
            secRowTouched.removeAll(keepingCapacity: false)
            var smallDic = [Int]()
            
            for _ in  0 ..< 10 {
                
                smallDic.append(0)
            }
            
            
            for _ in 0 ..< maxSpot {
                
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
                        
                        enterBtn.setAttributedTitle(NSAttributedString(string: lessonVC_enterBtn, attributes: attrsBtn), for: .normal)
                        
                        titleLabel.text = lessonVC_aboutToLearn3Words
                        titleLabel.textColor = .white
                        
                    } else {
                        
                        //複習機制
                        enterBtn.setAttributedTitle(NSAttributedString(string: lessonVC_enterReviewBtn, attributes: attrsBtn), for: .normal)
                        
                        titleLabel.text = lessonVC_review3Words
                        titleLabel.textColor = #colorLiteral(red: 1, green: 0.027038477, blue: 0.405282959, alpha: 1)
                    }
                    
                }
                
            } else {
                
                //複習機制
                enterBtn.setAttributedTitle(NSAttributedString(string: lessonVC_enterReviewBtn, attributes: attrsBtn), for: .normal)
                
                titleLabel.text = lessonVC_review3Words
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
        
        
        //MARK: must update
        //就算user == nil, gamePassed & mapPassed都已經設定初始值了
        //測試用
        
        //mapNumToReceive = 0
        //gamePassed = [4:3]
        //mapPassed = 0
        
        //重置
        //這兩個變數感覺重複了...
        let lessonVC_enterBtn1 = NSLocalizedString("lessonVC_enterBtn", comment: "")
        let attrsBtn = [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.8666666667, green: 0.8392156863, blue: 0.1960784314, alpha: 1)]
        
        enterBtn.setAttributedTitle(NSAttributedString(string: lessonVC_enterBtn1, attributes: attrsBtn), for: .normal)
        
        titleLabel.text = lessonVC_aboutToLearn3Words
        titleLabel.textColor = .white
        
        
        //MARK: simVer 這裏要更新最大數字 & increaseNum & isSimVerSingleSyllable done
        
        //******** maxMapNum應該用不到 可以刪了 **********
        
        
        switch courseReceived {
        case 0:
            gamePassedDic = gamePassed!
            mapPassedInt = mapPassed!
            isSimVerSingleSyllable = true
            
            
            
            if lan == "zh-Hans"{
                //檢體中文
                //國小
                //print("檢體中文關卡數")
                maxMapNum = 3
                increaseNum = 35
                
            } else {
                //其餘語言
                //print("繁體中文關卡數")
                maxMapNum = 5
                increaseNum = 0
                
            }
            
            
        case 1:
            gamePassedDic = gamePassed2!
            mapPassedInt = mapPassed2!
            
            isSimVerSingleSyllable = false
            
            
            if lan == "zh-Hans"{
                //檢體中文
                //初中
                //print("檢體中文關卡數")
                maxMapNum = 5
                increaseNum = 38
                
            } else {
                //其餘語言
                //print("繁體中文關卡數")
                increaseNum = 5
                maxMapNum = 6
                
            }
            
            
        case 2:
            gamePassedDic = gamePassed3!
            mapPassedInt = mapPassed3!
            
            
            isSimVerSingleSyllable = false
            
            if lan == "zh-Hans"{
                //檢體中文
                //高中
                //print("檢體中文關卡數")
                maxMapNum = 6
                increaseNum = 43
                
            } else {
                //其餘語言
                //print("繁體中文關卡數")
                increaseNum = 11
                maxMapNum = 7
                
            }
            
            
            
        case 3:
            gamePassedDic = gamePassed4!
            mapPassedInt = mapPassed4!
            
            
            isSimVerSingleSyllable = false
            
            if lan == "zh-Hans"{
                //檢體中文
                //CET4
                //print("檢體中文關卡數")
                maxMapNum = 11
                increaseNum = 49
                
            } else {
                //其餘語言
                
                //print("繁體中文關卡數")
                increaseNum = 18
                maxMapNum = 9
                
            }
            
            
        case 4:
            gamePassedDic = gamePassed5!
            mapPassedInt = mapPassed5!
            
            isSimVerSingleSyllable = false
            
            if lan == "zh-Hans"{
                //檢體中文
                //CET6
                //print("檢體中文關卡數")
                maxMapNum = 13
                increaseNum = 60
                
            } else {
                //其餘語言
                
                //print("繁體中文關卡數")
                increaseNum = 27
                maxMapNum = 8
                
            }
            
            
            //以下為簡體版需求
            //要確認繁體版進不來
            
        case 5:
            
            //MARK: simVer k12紀錄
            //測試用
            //            k12MapPassed = Array(repeating: 0, count: 18)
            //            k12GamePassed = Array(repeating: [0:0], count: 18)
            
            //k12MapPassed[1] = 2
            //k12GamePassed[0] = [0:2]
            //k12GamePassed[2] = [1:0]
            //print(k12MapPassed)
            //print(k12GamePassed)
            
            //重新設定成k12裡各關的過關情形
            //            gamePassedDic = gamePassed6!
            //            mapPassedInt = mapPassed6!
            gamePassedDic = k12GamePassed[mapNumToReceive]
            mapPassedInt = k12MapPassed[mapNumToReceive]
            //print(gamePassedDic)
            //print(mapPassedInt)
            
            isSimVerSingleSyllable = true
            
            if lan == "zh-Hans"{
                //檢體中文
                //K12
                //print("檢體中文關卡數")
                maxMapNum = 18
                
                increaseNum = 73
                
            }
            
        case 6:
            gamePassedDic = gamePassed7!
            mapPassedInt = mapPassed7!
            
            isSimVerSingleSyllable = false
            
            if lan == "zh-Hans"{
                //檢體中文
                //toiec
                //print("檢體中文關卡數")
                maxMapNum = 7
                increaseNum = 91
                
            }
            
        case 7:
            gamePassedDic = gamePassed8!
            mapPassedInt = mapPassed8!
            
            isSimVerSingleSyllable = false
            
            if lan == "zh-Hans"{
                //檢體中文
                //ielts
                //print("檢體中文關卡數")
                maxMapNum = 9
                increaseNum = 98
                
            }
            
        case 8:
            gamePassedDic = gamePassed9!
            mapPassedInt = mapPassed9!
            
            isSimVerSingleSyllable = false
            
            if lan == "zh-Hans"{
                //檢體中文
                //tofel
                //print("檢體中文關卡數")
                maxMapNum = 8
                increaseNum = 107
                
            }
            
            
        default:
            break
        }
        
        
        
        
        //   if isClassAllPassed == false{
        
        
        let attrs0 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: lessonBigFontSize), NSAttributedStringKey.foregroundColor : pinkColor]
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: lessonSmallFontSize), NSAttributedStringKey.foregroundColor : UIColor.white]
        let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: wordFontSize), NSAttributedStringKey.foregroundColor : UIColor.cyan]
        let attrs3 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: wordFontSize), NSAttributedStringKey.foregroundColor : UIColor.white]
        
        //增加數字來抓正確的值
        mapNumToReceive += increaseNum
        
        //MARK: must update
        //MARK: simVer 這裡要加入檢體音節檔案 done
        
        switch mapNumToReceive {
        case 0:
            syllableSets = map1SyllableSets
        case 1:
            syllableSets = map2SyllableSets
        case 2:
            syllableSets = map3SyllableSets
        case 3:
            syllableSets = map4SyllableSets
        case 4:
            syllableSets = map5SyllableSets
        case 5:
            syllableSets = map6SyllableSets
        case 6:
            syllableSets = map7SyllableSets
        case 7:
            syllableSets = map8SyllableSets
            
        case 8:
            syllableSets = map9SyllableSets
            
        case 9:
            syllableSets = map10SyllableSets
        case 10:
            syllableSets = map11SyllableSets
        case 11:
            syllableSets = map12SyllableSets
        case 12:
            syllableSets = map13SyllableSets
        case 13:
            syllableSets = map14SyllableSets
        case 14:
            syllableSets = map15SyllableSets
        case 15:
            syllableSets = map16SyllableSets
        case 16:
            syllableSets = map17SyllableSets
        case 17:
            syllableSets = map18SyllableSets
        case 18:
            syllableSets = map19SyllableSets
        case 19:
            syllableSets = map20SyllableSets
        case 20:
            syllableSets = map21SyllableSets
        case 21:
            syllableSets = map22SyllableSets
        case 22:
            syllableSets = map23SyllableSets
        case 23:
            syllableSets = map24SyllableSets
        case 24:
            syllableSets = map25SyllableSets
        case 25:
            syllableSets = map26SyllableSets
        case 26:
            syllableSets = map27SyllableSets
            
        case 27:
            syllableSets = map28SyllableSets
        case 28:
            syllableSets = map29SyllableSets
        case 29:
            syllableSets = map30SyllableSets
        case 30:
            syllableSets = map31SyllableSets
        case 31:
            syllableSets = map32SyllableSets
        case 32:
            syllableSets = map33SyllableSets
        case 33:
            syllableSets = map34SyllableSets
        case 34:
            syllableSets = map35SyllableSets
            
        //以下為簡體部分
        case 35:
            syllableSets = map36SyllableSets
        case 36:
            syllableSets = map37SyllableSets
        case 37:
            syllableSets = map38SyllableSets
            
        case 38:
            syllableSets = map39SyllableSets
        case 39:
            syllableSets = map40SyllableSets
        case 40:
            syllableSets = map41SyllableSets
        case 41:
            syllableSets = map42SyllableSets
        case 42:
            syllableSets = map43SyllableSets
        case 43:
            syllableSets = map44SyllableSets
        case 44:
            syllableSets = map45SyllableSets
        case 45:
            syllableSets = map46SyllableSets
        case 46:
            syllableSets = map47SyllableSets
        case 47:
            syllableSets = map48SyllableSets
        case 48:
            syllableSets = map49SyllableSets
        case 49:
            syllableSets = map50SyllableSets
        case 50:
            syllableSets = map51SyllableSets
        case 51:
            syllableSets = map52SyllableSets
        case 52:
            syllableSets = map53SyllableSets
        case 53:
            syllableSets = map54SyllableSets
        case 54:
            syllableSets = map55SyllableSets
        case 55:
            syllableSets = map56SyllableSets
        case 56:
            syllableSets = map57SyllableSets
        case 57:
            syllableSets = map58SyllableSets
        case 58:
            syllableSets = map59SyllableSets
        case 59:
            syllableSets = map60SyllableSets
        case 60:
            syllableSets = map61SyllableSets
        case 61:
            syllableSets = map62SyllableSets
        case 62:
            syllableSets = map63SyllableSets
        case 63:
            syllableSets = map64SyllableSets
        case 64:
            syllableSets = map65SyllableSets
        case 65:
            syllableSets = map66SyllableSets
        case 66:
            syllableSets = map67SyllableSets
        case 67:
            syllableSets = map68SyllableSets
        case 68:
            syllableSets = map69SyllableSets
        case 69:
            syllableSets = map70SyllableSets
            
        case 70:
            syllableSets = map71SyllableSets
        case 71:
            syllableSets = map72SyllableSets
        case 72:
            syllableSets = map73SyllableSets
        case 73:
            syllableSets = map74SyllableSets
        case 74:
            syllableSets = map75SyllableSets
        case 75:
            syllableSets = map76SyllableSets
        case 76:
            syllableSets = map77SyllableSets
        case 77:
            syllableSets = map78SyllableSets
        case 78:
            syllableSets = map79SyllableSets
        case 79:
            syllableSets = map80SyllableSets
            
            
        case 80:
            syllableSets = map81SyllableSets
        case 81:
            syllableSets = map82SyllableSets
        case 82:
            syllableSets = map83SyllableSets
        case 83:
            syllableSets = map84SyllableSets
        case 84:
            syllableSets = map85SyllableSets
        case 85:
            syllableSets = map86SyllableSets
        case 86:
            syllableSets = map87SyllableSets
        case 87:
            syllableSets = map88SyllableSets
        case 88:
            syllableSets = map89SyllableSets
        case 89:
            syllableSets = map90SyllableSets
            
        case 90:
            syllableSets = map91SyllableSets
        case 91:
            syllableSets = map92SyllableSets
        case 92:
            syllableSets = map93SyllableSets
        case 93:
            syllableSets = map94SyllableSets
        case 94:
            syllableSets = map95SyllableSets
        case 95:
            syllableSets = map96SyllableSets
        case 96:
            syllableSets = map97SyllableSets
        case 97:
            syllableSets = map98SyllableSets
        case 98:
            syllableSets = map99SyllableSets
        case 99:
            syllableSets = map100SyllableSets
            
        case 100:
            syllableSets = map101SyllableSets
        case 101:
            syllableSets = map102SyllableSets
        case 102:
            syllableSets = map103SyllableSets
        case 103:
            syllableSets = map104SyllableSets
        case 104:
            syllableSets = map105SyllableSets
        case 105:
            syllableSets = map106SyllableSets
        case 106:
            syllableSets = map107SyllableSets
        case 107:
            syllableSets = map108SyllableSets
        case 108:
            syllableSets = map109SyllableSets
        case 109:
            syllableSets = map110SyllableSets
            
        case 110:
            syllableSets = map111SyllableSets
        case 111:
            syllableSets = map112SyllableSets
        case 112:
            syllableSets = map113SyllableSets
        case 113:
            syllableSets = map114SyllableSets
        case 114:
            syllableSets = map115SyllableSets
            
            
        default:
            break
        }
        
        
        var syllablesWithoutDigit = String()
        
        var progressFloat = CGFloat()
        

        
        //建立目錄數字
        var smallDic = [Int]()
        
        for _ in  0 ..< 10 {
            
            smallDic.append(0)
        }
        
        //MARK: simVer 這部分要動態有幾個30 done
        //***照理講這裡設定好maxSpot之後就不用設定了, 所以目前後面出現過的已經comment起來了
        
        //var maxNum = Int()
        if lan == "zh-Hans"{
            //檢體中文
            
            
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
                
                //這裡要用減去increaseNum的方式來找數值
                switch (mapNumToReceive - increaseNum){
                    
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
            //其餘語言
           
            maxSpot = 15
            
        }
        
        //原始
        //for _ in 0 ..< 15 {
        
        
        //新增出正確組數的音節
        for _ in 0 ..< maxSpot {
            
            secRowTouched.append(smallDic)
            
        }
        
        
        //再把數字減回來
        mapNumToReceive -= increaseNum
        
        //      if mapNumToReceive == mapPassedInt || mapNumToReceive < mapPassedInt{
        //抓目前的元素
        
        
        //MARK: simVer 放在外的變數 done
        var threeSyllables = [String]()
        
        
        
        if isClassAllPassed {
            
            //設定gamePassed給予該關卡最大值 全開
            
            mapNum = mapNumToReceive
            
            if lan == "zh-Hans"{
                //檢體中文
                
       
                //之後還要用courseReceived來改數值, 因為每個course值不同
                //***** 這部分的動態做法之前已做過數字只差1 ****所以不用Switch了
                tempS = maxSpot - 1
                
            } else {
                //其餘語言
 
                tempS = 14
                
            }
            tempU = 9
            
            enterBtn.setAttributedTitle(NSAttributedString(string: lessonVC_enterReviewBtn, attributes: attrsBtn), for: .normal)
            
            titleLabel.text = lessonVC_review3Words
            titleLabel.textColor = #colorLiteral(red: 1, green: 0.027038477, blue: 0.405282959, alpha: 1)
            
            
        }else {
            
            for (s,u) in gamePassedDic! {
                
            
                //這個狀態下mapPassedInt 跟 mapNumToReceive是一樣的
                mapNum = mapPassedInt
                
                
                tempS = s
                tempU = u
                
            }
            
        }
        
        
        //這裡的做法有不需要的環迴圈, check android版本是不是也一樣
        //            for (s,u) in gamePassedDic! {
        //
        //
        //                //MARK: simVer 這裡 (tempS = 要做不一樣的最大值)
        //                if isClassAllPassed {
        //
        //
        //
        //                } else {
        //
        //                }
        
        // print("enter 2")
        
        //MARK: simVer 在這裡做三個音節, 要先判斷要怎麼做, 要指定好一個變數來判斷 done
        
        if lan == "zh-Hans"{
            
            //   print("enter 3")
            if isSimVerSingleSyllable{
                
                
                
                //檢體中文 單一音節作法
                
                //print("檢體中文關卡數")
                for i in tempU * 3 ..< tempU * 3 + 3{
                    
                    let syllableChosen = syllableSets[tempS][i]
                    let syllableChosenArray = syllableChosen.components(separatedBy: NSCharacterSet.decimalDigits)
                    
                    syllablesWithoutDigit = syllableChosenArray[0]
                    threeSyllables.append(syllablesWithoutDigit)
                    
                }
                //****這裡的labelText fontSize要因此變小
                syllableLabel.font = syllableLabel.font.withSize(sylFontSize / 2)
                syllableLabel.text = "Unit " + String(tempU + 1)
                
            } else {
                
                // 檢體中文 音節三字作法
                let syllableChosen = syllableSets[tempS][tempU]
                let syllableChosenArray = syllableChosen.components(separatedBy: NSCharacterSet.decimalDigits)
                syllablesWithoutDigit = syllableChosenArray[0]
                syllableLabel.text = syllablesWithoutDigit
                
                
            }
            
            
        } else {
            //其餘語言
            //print("繁體中文關卡數")
            
            let syllableChosen = syllableSets[tempS][tempU]
            let syllableChosenArray = syllableChosen.components(separatedBy: NSCharacterSet.decimalDigits)
            syllablesWithoutDigit = syllableChosenArray[0]
            syllableLabel.text = syllablesWithoutDigit
            
            
        }
        
        spotNum = tempS
        unitNum = tempU
        progressFloat = CGFloat(tempU + 1)
        
        //}
        //  print("############got mapnum:\(mapNum)")
        //}
        
        //MARK: simVer 這條好像用不到, 這也跟traVer沒有什麼關係...所以之後確認玩應該可以刪掉
        //maxIndex = tempS * 10 + tempU
        
        
        //?????這裡為什麼要這樣不懂??? 應該要刪掉....試試看, 好像tempS & tempU會更改!
        //已確認 : maxSpot  / maxUnit  為了避免被改變用另一組變數
        currentMaxSpotToUse = tempS
        currentMaxUnitToUse = tempU
        
        
        
        //第幾課
        
        //MARK: simVer 這裡的課程總數要動態
        
        //明天改個名字, 以下的變數應該更上方一樣
        
        //        var maxNum = Int()
        //
        //        if lan == "zh-Hans"{
        //            //檢體中文
        //
        //            print("檢體中文關卡數")
        //            //之後還要用courseReceived來改數值, 因為每個course值不同
        //
        //            maxNum = 11
        //
        //        } else {
        //            //其餘語言
        //            print("繁體中文關卡數")
        //            maxNum = 15
        //
        //        }
        
        
        
        let lessonText = NSMutableAttributedString(string: String(spotNum + 1), attributes: attrs0)
        let maxSpotString = String(maxSpot!)
        lessonText.append(NSMutableAttributedString(string: " / \(maxSpotString)", attributes: attrs1))
        lessonLabel.attributedText = lessonText
        
        //進度條
        //   print("讀取進度條")
        //progressLength.frame = CGRect(x: 0, y: fullLength.frame.minY, width: width * progressFloat / 10, height: 3)
        progressLength.anchor(top: nil, leading: view.safeLeftAnchor, bottom: enterBtn.topAnchor, trailing: nil, size: .init(width: width * progressFloat / 10, height: 3))
        
        
        //MARK: 讀取文字檔
        //讀取Bundle裡的文字檔
        var wordFile:String?
        
        //供抓字用 & pass給 gameVc
        //mapNum += increaseNum
        
        //MARK: simVer K12的地圖讀法要再增加
        var name:String!
        
        if courseReceived == 5 {
            //k12 在這狀況下mapNum = 0
            
            name = String(increaseNum + 1 + mapNumToReceive) + "-" + String(spotNum + 1)
        } else {
            
            name = String(mapNum  + increaseNum + 1) + "-" + String(spotNum + 1)
            
        }
        
        
        
        //print(name)
        
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
        
        let engWord0 = wordSets[unitNum * 3].components(separatedBy: " ")
        let engWord1 = wordSets[unitNum * 3 + 1].components(separatedBy: " ")
        let engWord2 = wordSets[unitNum * 3 + 2].components(separatedBy: " ")
        
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
        
        
        //MARK: simVer 新造字方式, 下方有原本的造字放方式 done
        //**** 在這裡也要用 isSimVerSingleSyllable的變數來判斷怎麼造字
        
        if lan == "zh-Hans" && isSimVerSingleSyllable{
            
            
            //檢體中文
            
            for i in 0 ..< threeSyllables.count {
                
                
                if threeSyllables[i].contains("_"){
                    //specialE的作法
                    
                    var characters = [Character]()
                    let vowels = ["a","e","i","o","u"]
                    
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
            //其餘語言 或者是簡體用3音節造字方式
            
            //MARK: 音節變色
            if syllablesWithoutDigit.contains("_"){
                //specialE的作法
                
                var characters = [Character]()
                let vowels = ["a","e","i","o","u"]
                
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
        
      
        
        //}
        
        
    
    }
    
    //寫一個獨立的讀取單字功能
    func loadWords(seq:Int){
        
        let attrs0 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: lessonBigFontSize), NSAttributedStringKey.foregroundColor : pinkColor]
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: lessonSmallFontSize), NSAttributedStringKey.foregroundColor : UIColor.white]
        let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: wordFontSize), NSAttributedStringKey.foregroundColor : UIColor.cyan]
        let attrs3 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: wordFontSize), NSAttributedStringKey.foregroundColor : UIColor.white]
        
        
        var syllablesWithoutDigit = String()
        
        //進度條動不了先不用了
        //var progressFloat = CGFloat()
        
        //MARK: simVer 放在外面的音節變數 done
        var threeSyllables = [String]()
        
        
        //首先抓音節
        
        
        if seq > 0 {
            
            //下一課
            
            if tempU < 9 {
                //直接加一
                tempU = tempU + 1
                
            } else {

                
                //if tempS < 14 {
                
                //MARK: simVer這裏直接取用之前的maxSpot done
                // **** 這裡的maxSpot要 - 1
                if tempS < maxSpot - 1 {
                    //直接 +1
                    
                    
                    tempS = tempS + 1
                    tempU = 0
                    
                    
                } else {
                    //全部練完
                    //print("全部練完")
                    
                    ProgressHUD.showError(lessonVC_theLastPage)
                    
                    
                }
                
                
            }
            
            
            for (s,u) in gamePassedDic!{
                
                if tempU == u && tempS == s && mapNumToReceive == mapPassedInt{
                    
                    enterBtn.setAttributedTitle(NSAttributedString(string: lessonVC_enterBtn, attributes: attrsBtn), for: .normal)
                    titleLabel.text = lessonVC_aboutToLearn3Words
                    titleLabel.textColor = .white
                    
                }  else if tempU == u && tempS == s && courseReceived == 5{
                    enterBtn.setAttributedTitle(NSAttributedString(string: lessonVC_enterBtn, attributes: attrsBtn), for: .normal)
                    titleLabel.text = lessonVC_aboutToLearn3Words
                    titleLabel.textColor = .white
                    
                }
            }
            
            
        } else if seq == 0 {
            
            print("畫面跳轉")
            
        } else {
            
            //上一課
            
            if tempU > 0 {
                //直接減一
                tempU = tempU - 1
                
                
            } else {
                //假入u == 0,  要扣 s
                
                if tempS > 0 {
                    //直接 -1
                    
                    tempS = tempS - 1
                    tempU = 9
                    
                    
                } else {
                    
                    ProgressHUD.showError(lessonVC_thisIsFirst)
                    print("全部練完")
                }
                
                
            }
            
            
        }
        
        //MARK: simVer 這裏要寫新的音節讀取  加個判斷式done
        
        if lan == "zh-Hans" && isSimVerSingleSyllable{
            //檢體中文
            
            //print("檢體中文關卡數")
            
            //以下為新修正
            
            for i in tempU * 3 ..< tempU * 3 + 3{
                
                let syllableChosen = syllableSets[tempS][i]
                let syllableChosenArray = syllableChosen.components(separatedBy: NSCharacterSet.decimalDigits)
                
                syllablesWithoutDigit = syllableChosenArray[0]
                threeSyllables.append(syllablesWithoutDigit)
                
            }
            syllableLabel.text = "Unit " + String(tempU + 1)
            
            
        } else {
            //其餘語言
            //print("繁體中文關卡數")
            
            let syllableChosen = syllableSets[tempS][tempU]
            
            let syllableChosenArray = syllableChosen.components(separatedBy: NSCharacterSet.decimalDigits)
            
            syllablesWithoutDigit = syllableChosenArray[0]
            syllableLabel.text = syllablesWithoutDigit
            
            
        }
        
        
        if isClassAllPassed {
            
            mapNum = mapNumToReceive
        } else {
            mapNum = mapPassedInt
        }
        spotNum = tempS
        unitNum = tempU
        //progressFloat = CGFloat(tempU + 1)
        
        
        //print("progressFloat\(progressFloat)")
        
        
        let lessonText = NSMutableAttributedString(string: String(spotNum + 1), attributes: attrs0)
        lessonText.append(NSMutableAttributedString(string: " / \(String(maxSpot!))", attributes: attrs1))
        lessonLabel.attributedText = lessonText
        
        //進度條
        //print("讀取進度條")
        //progressLength.frame = CGRect(x: 0, y: fullLength.frame.minY, width: width * progressFloat / 10, height: 3)
        // progressLength.anchor(top: nil, leading: view.safeLeftAnchor, bottom: enterBtn.topAnchor, trailing: nil, size: .init(width: width * progressFloat / 10, height: 3))
        
        //print("widthChange:\(width * progressFloat / 10)")
        
        //MARK: 讀取文字檔
        //讀取Bundle裡的文字檔
        var wordFile:String?
        
        //供抓字用 & pass給 gameVc
        // mapNum += increaseNum
        
        var name:String!
        
        if courseReceived == 5 {
            //k12 在這狀況下mapNum = 0 / 1
            name = String(increaseNum + 1 + mapNumToReceive) + "-" + String(spotNum + 1)
        }else {
            name = String(increaseNum + mapNum + 1) + "-" + String(spotNum + 1)
        }
        
        
        //print(name)
        
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
        
        let engWord0 = wordSets[unitNum * 3].components(separatedBy: " ")
        let engWord1 = wordSets[unitNum * 3 + 1].components(separatedBy: " ")
        let engWord2 = wordSets[unitNum * 3 + 2].components(separatedBy: " ")
        
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
                    let vowels = ["a","e","i","o","u"]
                    
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
                let vowels = ["a","e","i","o","u"]
                
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
            // print("sentTempS:\(tempS)")
            // print("sentTempU:\(tempU)")
            
            
            for (s,u) in gamePassedDic!{
                
                if tempU != u || tempS != s{
                    //不是當下關卡
       
                    destinationVC.isReplay = true
                } else {
                    
                    destinationVC.isReplay = false
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
        
        if courseReceived == 5 {
            
            for (s,u) in gamePassedDic!{
                
                if s != 0 || u != 0 || mapPassedInt == 1{
                    
                    loadWords(seq: -1)
                    enterBtn.setAttributedTitle(NSAttributedString(string: lessonVC_enterReviewBtn, attributes: attrsBtn), for: .normal)
                    
                    titleLabel.text = lessonVC_review3Words
                    titleLabel.textColor = #colorLiteral(red: 1, green: 0.027038477, blue: 0.405282959, alpha: 1)
                } else {
        
                    ProgressHUD.showError(lessonVC_noPrePage)
                }
            }
            
        } else{
            
            for (s,u) in gamePassedDic!{
                
                if s != 0 || u != 0 || mapPassedInt != mapNumToReceive {
                    
                    loadWords(seq: -1)
                    
                    enterBtn.setAttributedTitle(NSAttributedString(string: lessonVC_enterReviewBtn, attributes: attrsBtn), for: .normal)
                    titleLabel.text = lessonVC_review3Words
                    titleLabel.textColor = #colorLiteral(red: 1, green: 0.027038477, blue: 0.405282959, alpha: 1)
                } else {
                    //print("這是第一關")
                    ProgressHUD.showError(lessonVC_noPrePage)
                }
            }
        }
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
                    
                    enterBtn.setAttributedTitle(NSAttributedString(string: lessonVC_enterBtn, attributes: attrsBtn), for: .normal)
                    titleLabel.text = lessonVC_aboutToLearn3Words
                    titleLabel.textColor = .white
                    
                }
                
            }
            
            
            
        } else {
            
            for (s,u) in gamePassedDic!{
                
                if tempU != u || tempS != s || mapNumToReceive != mapPassedInt{
                    //不是當下關卡
                    
                    loadWords(seq: 1)
                    
                } else if !isClassAllPassed{
                    
                    ProgressHUD.showError(lessonVC_noNextPage)
                    
                    enterBtn.setAttributedTitle(NSAttributedString(string: lessonVC_enterBtn, attributes: attrsBtn), for: .normal)
                    titleLabel.text = lessonVC_aboutToLearn3Words
                    titleLabel.textColor = .white
                    
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
