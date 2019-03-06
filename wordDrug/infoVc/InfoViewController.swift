//
//  InfoViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/5/18.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit


var subTitleFontSize:CGFloat!
var subValueFontSize:CGFloat!

class InfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate , UICollectionViewDelegate, UICollectionViewDataSource, InfoAvatarViewCellDelegate{
    
    var activityIndicator = UIActivityIndicatorView()
    
    let infoVC_wordAchievement = NSLocalizedString("infoVC_wordAchievement", comment: "")
    let infoVC_proAchievement = NSLocalizedString("infoVC_proAchievement", comment: "")
    let infoVC_senAchievement = NSLocalizedString("infoVC_senAchievement", comment: "")
    let infoVC_spellKing = NSLocalizedString("infoVC_spellKing", comment: "")
    let infoVC_senKing = NSLocalizedString("infoVC_senKing", comment: "")
    let infoVC_spellRate = NSLocalizedString("infoVC_spellRate", comment: "")
    let infoVC_proRate = NSLocalizedString("infoVC_proRate", comment: "")
    let infoVC_writeSenRate = NSLocalizedString("infoVC_writeSenRate", comment: "")
    let infoVC_wordCount = NSLocalizedString("infoVC_wordCount", comment: "")
    let infoVC_newStudent = NSLocalizedString("infoVC_newStudent", comment: "")
    let infoVC_senCount = NSLocalizedString("infoVC_senCount", comment: "")
    let infoVC_chineseRate = NSLocalizedString("infoVC_chineseRate", comment: "")
    let infoVC_wordUnit = NSLocalizedString("infoVC_wordUnit", comment: "")
    
    let infoVC_senUnit = NSLocalizedString("infoVC_senUnit", comment: "")
    let infoVC_noScore = NSLocalizedString("infoVC_noScore", comment: "")
    let infoVC_noRank = NSLocalizedString("infoVC_noRank", comment: "")
    
    let infoVC_titleLabel = NSLocalizedString("infoVC_titleLabel", comment: "")
    let infoVC_wordLabel = NSLocalizedString("infoVC_wordLabel", comment: "")
    let infoVC_scoreLabel = NSLocalizedString("infoVC_scoreLabel", comment: "")
    let infoVC_rankLabel = NSLocalizedString("infoVC_rankLabel", comment: "")

    
    let darkColor = UIColor.init(red: 41/255, green: 56/255, blue: 87/255, alpha: 1)
    let midColor = UIColor.init(red: 138/255, green: 152/255, blue: 170/255, alpha: 1)
    let lightColor = UIColor.init(red: 196/255, green: 203/255, blue: 213/255, alpha: 1)
    let yellowColor = UIColor.init(red: 255/255, green: 182/255, blue: 13/255, alpha: 1)
    let lightBlueColor = UIColor.init(red: 97/255, green: 136/255, blue: 216/255, alpha: 1)
    let darkRed = UIColor.init(red: 192/255, green: 40/255, blue: 75/255, alpha: 1)
    let orangeColor = UIColor.init(red: 232/255, green: 98/255, blue: 61/255, alpha: 1)

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rankCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreCountLabel: UILabel!
    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var changePhotoBtn: UIButton!
    @IBOutlet weak var avaImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var infoTableView: UITableView!
    @IBOutlet weak var chartUpBg: UIImageView!
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    var dif = CGFloat()
    var photoDif = CGFloat()

    var maxSpot:Int!
    
    @IBOutlet weak var avatarCollectionView: UICollectionView!

    @IBOutlet weak var alphaLayer: UIImageView!
    
    @IBOutlet weak var avatarOkBtn: UIButton!
    
    @IBOutlet weak var avatarBgView: UIView!

    //MARK: simVer newVer
    var stageScores = [10000,50000,200000,500000,1000000,2000000,3000000,4000000,5000000]
    var avatarColorBars = [String()]
    var userScore = String()
    //var stagePassed = [0,0,0,0,0,0,0,0,0]
    var barLengths:[CGFloat] = [130,550,230,40,250,110,70,30,89]
    var avatar:[Avatar]?
    var student:Student?
    var values:[Value]?
    var avatarHeaderData:[AvatarHeader]?
    
    var collectionViewDif:CGFloat!
    var collectionViewCellSize:CGFloat!
    var smallSylFontSize:CGFloat!
    var selectedAvatarImageName:String?
    
    var shouldShowAvatarAlert = false

    override func viewDidLoad() {
        super.viewDidLoad()

     
        let array = Bundle.main.preferredLocalizations
        lan = array.first
      
        var titleFontSize: CGFloat!
        var infoFontSize: CGFloat!
        var usernameFontSize: CGFloat!
        var avaYDif:CGFloat!
        var iPadDif = CGFloat()

        
        switch height {
            
        
        case 1366, 1336, 1112:
                dif = 1.5
                photoDif = 2
                collectionViewDif = 2.3
                collectionViewCellSize = 150
                iPadDif = 2
        
                titleFontSize = 40
                infoFontSize = 30
                subTitleFontSize = 35
                subValueFontSize = 35
            usernameFontSize = 60
            avaYDif = 1
            smallSylFontSize = 30

        case 1024:
                dif = 1.1
                photoDif = 1.5
                collectionViewDif = 2
                collectionViewCellSize = 130
                iPadDif = 1.5
                titleFontSize = 35
                infoFontSize = 20
                subTitleFontSize = 28
                subValueFontSize = 22
                usernameFontSize = 40
                avaYDif = 1
                smallSylFontSize = 30
        case 812:
            
            //iPhoneX
            dif = 0.8
            photoDif = 1
            collectionViewDif = 1
            collectionViewCellSize = 100
            iPadDif = 1
     
            titleFontSize = 20
            infoFontSize = 16
            subTitleFontSize = 20
            subValueFontSize = 15
            usernameFontSize = 25
             avaYDif = 1
            smallSylFontSize = 15
            
        case 736:
            
            //plus
            dif = 0.8
            photoDif = 1
            collectionViewDif = 1
            collectionViewCellSize = 100
            iPadDif = 1
     
            titleFontSize = 24
            infoFontSize = 16
            subTitleFontSize = 20
            subValueFontSize = 16
            usernameFontSize = 26
             avaYDif = 1
            
            smallSylFontSize = 15
            
        case 667:
            
            dif = 0.7
            photoDif = 1
            collectionViewDif = 1
            collectionViewCellSize = 100
            iPadDif = 1
        
            titleFontSize = 20
            infoFontSize = 16
            subTitleFontSize = 18
            subValueFontSize = 14
            usernameFontSize = 22
             avaYDif = 1
            smallSylFontSize = 15
            
        case 568:
            
            dif = 0.8
            photoDif = 0.7
            collectionViewDif = 0.8
            collectionViewCellSize = 100
            iPadDif = 1
      
            titleFontSize = 16
            infoFontSize = 16
            subTitleFontSize = 16
            subValueFontSize = 14
            usernameFontSize = 18
             avaYDif = 0.6
            smallSylFontSize = 12
            
        default:
            dif = 0.8
            photoDif = 1
            collectionViewDif = 1
            collectionViewCellSize = 100
            iPadDif = 1
         
            titleFontSize = 20
            infoFontSize = 16
            subTitleFontSize = 20
            subValueFontSize = 15
            usernameFontSize = 25
            avaYDif = 1
            smallSylFontSize = 15
    
            break
            
        }
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100 * iPadDif, height: 100 * iPadDif))
        activityIndicator.layer.zPosition = 15
        let alphaGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.layer.cornerRadius = activityIndicator.frame.width / 20
        activityIndicator.backgroundColor = alphaGray
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge

        view.addSubview(activityIndicator)
        
        avatarBgView.translatesAutoresizingMaskIntoConstraints = false
        avatarBgView.widthAnchor.constraint(equalToConstant: 320 * collectionViewDif).isActive = true
        avatarBgView.heightAnchor.constraint(equalToConstant: 500 * collectionViewDif).isActive = true
        avatarBgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        avatarBgView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50 * collectionViewDif).isActive = true
        avatarBgView.layer.cornerRadius = avatarBgView.frame.width / 20
        avatarBgView.backgroundColor = #colorLiteral(red: 0.2823529412, green: 0.3647058824, blue: 0.4392156863, alpha: 1)
        //avatarCollectionView.isHidden = true
        avatarBgView.layer.zPosition = 10
        
        avatarCollectionView.delegate = self


        avatarCollectionView.anchor(top: avatarBgView.topAnchor, leading: avatarBgView.leadingAnchor, bottom: nil, trailing: avatarBgView.trailingAnchor, size: CGSize(width: avatarBgView.frame.width, height: 420))
        
        avatarCollectionView.layer.cornerRadius = avatarCollectionView.frame.width / 20
        avatarCollectionView.backgroundColor = #colorLiteral(red: 0.2823529412, green: 0.3647058824, blue: 0.4392156863, alpha: 1)
        //avatarCollectionView.isHidden = true
        avatarCollectionView.layer.zPosition = 11
        
        avatarOkBtn.layer.zPosition = 12
        avatarOkBtn.translatesAutoresizingMaskIntoConstraints = false
        avatarOkBtn.widthAnchor.constraint(equalToConstant: avatarBgView.frame.width / 2).isActive = true
        avatarOkBtn.heightAnchor.constraint(equalToConstant: 40 * collectionViewDif).isActive = true
        avatarOkBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        avatarOkBtn.bottomAnchor.constraint(equalTo: avatarBgView.bottomAnchor, constant: -15 * collectionViewDif).isActive = true
        
        
        //加入alertView
//        let lightGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.58)
//        ghostBtn.backgroundColor = lightGray
//        ghostBtn.addTarget(self, action: #selector(InfoViewController.removeBtns), for: .touchUpInside)
//        self.view.addSubview(ghostBtn)
//        ghostBtn.fillSupervivew()
        
        // Do any additional setup after loading the view.
        chartUpBg.frame = CGRect(x: 0, y: 0, width: width, height: height / 2.2)
        
        //backBtn.frame = CGRect(x: width / 30, y: height / 30 + iPadSmall, width: 19 * dif, height: 31 * dif)

        
        backBtn.anchor(top: view.safeTopAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: nil, padding: .init(top: 30 * dif * avaYDif, left: 20 * dif, bottom: 0, right: 0), size: .init(width: 19 * dif, height: 31 * dif))

        
        //titleLabel.frame = CGRect(x: backBtn.frame.maxX , y: backBtn.frame.maxY / 2, width: width - backBtn.frame.maxX * 2, height: 28 * dif)
        titleLabel.textAlignment = .center
        //titleLabel.backgroundColor = .red

        titleLabel.font = titleLabel.font.withSize(titleFontSize)
      
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalToConstant: 200 * dif).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40 * dif).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.safeTopAnchor, constant: 50 * dif * avaYDif).isActive = true
        
        titleLabel.text = infoVC_titleLabel
        
        
        //avaImg.frame = CGRect(x: width / 2 - (120 * dif * photoDif) / 2, y: titleLabel.frame.maxY * 1.7 * photoDif + iPadSmall, width: 120 * dif * photoDif, height: 120 * dif * photoDif)
        
        avaImg.translatesAutoresizingMaskIntoConstraints = false
        avaImg.widthAnchor.constraint(equalToConstant: 120 * photoDif).isActive = true
        avaImg.heightAnchor.constraint(equalToConstant: 120 * photoDif).isActive = true
        avaImg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        avaImg.centerYAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 110 * dif * avaYDif).isActive = true
        
        avaImg.frame.size = CGSize(width: 120 * photoDif, height: 120 * photoDif)
        
        avaImg.contentMode = .scaleAspectFit
        avaImg.layer.cornerRadius = avaImg.frame.width / 5
        avaImg.layer.masksToBounds = true
        
        let cgWhite = UIColor.white.cgColor
        
        avaImg.layer.borderColor = cgWhite
        avaImg.layer.borderWidth = 3
        
        
        //usernameLabel.frame = CGRect(x: 50, y: avaImg.frame.maxY + 25 * dif / 2 - iPadSmall, width: width - 100, height: 40 * dif)
        //usernameLabel.backgroundColor = .red
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.widthAnchor.constraint(equalToConstant: 300 * photoDif).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 50 * photoDif).isActive = true
        usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameLabel.centerYAnchor.constraint(equalTo: avaImg.bottomAnchor, constant: 35 * dif).isActive = true

        usernameLabel.adjustsFontSizeToFitWidth = true
        usernameLabel.font = usernameLabel.font.withSize(usernameFontSize)
        
        
        //changePhotoBtn.frame = CGRect(x: avaImg.frame.maxX - 28 * dif, y: avaImg.frame.maxY - 28 * dif, width: 28 * dif, height: 28 * dif)
        
        
        changePhotoBtn.anchor(top: nil, leading: nil, bottom: avaImg.bottomAnchor, trailing: avaImg.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -8 * dif) ,size: CGSize(width: 28 * dif, height: 28 * dif))
        
        
        alphaLayer.frame = CGRect(x: 0, y: chartUpBg.frame.maxY - 60 * dif, width: width, height: 60 * dif)
        
        //alphaLayer.anchor(top: nil, leading: chartUpBg.leadingAnchor, bottom: chartUpBg.bottomAnchor, trailing: chartUpBg.trailingAnchor, size: CGSize(width: width, height: 70 * dif))
        
        infoTableView.frame = CGRect(x: 0, y: chartUpBg.frame.maxY, width: width, height: height - chartUpBg.frame.height)
        
        
        wordCountLabel.frame = CGRect(x: backBtn.frame.minX + 10 * dif, y: alphaLayer.frame.minY + 5 * dif, width: 90 * dif, height: 23 * dif)
        
        
        //wordCountLabel.backgroundColor = .green
        wordCountLabel.textAlignment = .center
        wordCountLabel.adjustsFontSizeToFitWidth = true
        wordCountLabel.font = wordCountLabel.font.withSize(infoFontSize)
        
        wordLabel.frame = CGRect(x: wordCountLabel.frame.minX, y: wordCountLabel.frame.maxY + 5 * dif, width: 90 * dif, height: 23 * dif)
         wordLabel.font = wordLabel.font.withSize(infoFontSize)
        wordLabel.text = infoVC_wordLabel
        
        
        
        //wordLabel.backgroundColor = .green
        wordLabel.textAlignment = .center
        wordLabel.adjustsFontSizeToFitWidth = true
        
        scoreCountLabel.frame = CGRect(x: width / 2 - 75 * dif, y: alphaLayer.frame.minY + 5 * dif, width: 150 * dif, height: 23 * dif)
        
        //scoreCountLabel.backgroundColor = .red
        scoreCountLabel.textAlignment = .center
        scoreCountLabel.adjustsFontSizeToFitWidth = true
        scoreCountLabel.font = scoreCountLabel.font.withSize(infoFontSize)
        
        
        scoreLabel.frame = CGRect(x: scoreCountLabel.frame.midX - (90 * dif / 2), y: wordCountLabel.frame.maxY + 5 * dif, width: 90 * dif, height: 23 * dif)
        
        //scoreLabel.backgroundColor = .green
        scoreLabel.textAlignment = .center
        scoreLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.font = scoreLabel.font.withSize(infoFontSize)
        scoreLabel.text = infoVC_scoreLabel
        
        
        rankCountLabel.frame = CGRect(x: scoreCountLabel.frame.maxX + scoreCountLabel.frame.minX - wordCountLabel.frame.maxX, y: alphaLayer.frame.minY + 5 * dif, width: 90 * dif, height: 23 * dif)
        
        //rankCountLabel.backgroundColor = .green
        rankCountLabel.textAlignment = .center
        rankCountLabel.adjustsFontSizeToFitWidth = true
        rankCountLabel.font = rankCountLabel.font.withSize(infoFontSize)
        
        rankLabel.frame = CGRect(x: rankCountLabel.frame.minX, y: wordCountLabel.frame.maxY + 5 * dif, width: 90 * dif, height: 23 * dif)
        
        //rankLabel.backgroundColor = .green
        rankLabel.textAlignment = .center
        rankLabel.adjustsFontSizeToFitWidth = true
        rankLabel.font = rankLabel.font.withSize(infoFontSize)
        rankLabel.text = infoVC_rankLabel
        
        for i in 0 ..< 9{
            avatarColorBars.append("avatarColor" + String(i) + ".png")
        }
        avatarBgView.isHidden = true

//        let nib = UINib(nibName: \(InfoViewController.self), bundle: nil)
//        avatarCollectionView.register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "AvatarHeader")
        
    }
    

    //MARK: CollectionViewLayOut
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: collectionViewCellSize, height: collectionViewCellSize)
        return cellSize
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 8
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 9
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize(width: 320 * collectionViewDif, height: 40 * collectionViewDif)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 建立 UICollectionReusableView
 
        switch kind {
        case UICollectionElementKindSectionHeader:
            
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "AvatarHeader",
                for: indexPath) as? InfoAvatarCollectionReusableView else {fatalError("Invalid view type")
            }
            
            headerView.backgroundColor = .black
            if avatarHeaderData != nil {
            headerView.header = avatarHeaderData![indexPath.section]
                

            }
            
            return headerView
        default:
            assert(false, "Invalid element type")
        }
        
      
//
//        // header
//        if kind == UICollectionElementKindSectionHeader {
//            // 依據前面註冊設置的識別名稱 "Header" 取得目前使用的 header
//            reusableView =
//                collectionView.dequeueReusableSupplementaryView(
//                    ofKind: kind,
//                    withReuseIdentifier: "AvatarHeader",
//                    for: indexPath) as! InfoAvatarCollectionReusableView
//
//
//
//
        
        
            
        
            
//
//            let avatarColorBarImage = reusableView.viewWithTag(1) as! UIImageView
//            //avatarColorBarImage.anchor(top: reusableView.topAnchor, leading: reusableView.leadingAnchor, bottom: reusableView.bottomAnchor, trailing: reusableView.trailingAnchor, padding:.init(top: 0, left: 0, bottom: 0, right: 0))
//            avatarColorBarImage.image = UIImage(named: avatarColorBars[indexPath.section])
//
//            let avatarScoreLabel = reusableView.viewWithTag(7) as! UILabel
//
//
//            if let scoreString = student?.score{
//                if Int(scoreString)! >= stageScores[indexPath.section] {
//
//                    avatarScoreLabel.text = String(stageScores[indexPath.section]) + "/" + String(stageScores[indexPath.section])
//
//                } else {
//
//                    avatarScoreLabel.text = scoreString + "/" + String(stageScores[indexPath.section])
//
//
//                }
//
//            }
            
//
//            //mark: simVer temp comment
//            if userScore != "" {
//
//            if Int(userScore)! >= stageScores.stageScores[indexPath.section] {
//
//                    avatarScoreLabel.text = String(stageScores[indexPath.section]) + "/" + String(stageScores[indexPath.section])
//
//            } else {
//
//                avatarScoreLabel.text = userScore + "/" + String(stageScores[indexPath.section])
//
//
//                }
//
//            }
            
            
        

            
            //avatarColorBarImage.anchor(top: reusableView.topAnchor, leading: reusableView.leadingAnchor, bottom: reusableView.bottomAnchor, trailing: reusableView.trailingAnchor, padding:.init(top: 0, left: 0, bottom: 0, right: barLengths[indexPath.section]))


//            avatarColorBarImage.translatesAutoresizingMaskIntoConstraints = false
//            avatarColorBarImage.leadingAnchor.constraint(equalTo: reusableView.leadingAnchor).isActive = true
//            avatarColorBarImage.topAnchor.constraint(equalTo: reusableView.topAnchor).isActive = true
//            avatarColorBarImage.heightAnchor.constraint(equalTo: reusableView.heightAnchor).isActive = true
//            avatarColorBarImage.widthAnchor.constraint(equalTo: reusableView.widthAnchor, constant: barLengths[indexPath.section]).isActive = true
            
            //reusableView.frame = CGRect(x: 0, y: 0, width: 320 * collectionViewDif, height: 40 * collectionViewDif)
            
            // 設置 header 的內容
//            let label = reusableView.viewWithTag(3) as! UILabel
//            // 顯示文字
//            label.frame = CGRect(x: 0, y: 0,width: 320 * collectionViewDif, height: 40 * collectionViewDif)
//            label.textAlignment = .center
//
//            label.font = label.font.withSize(smallSylFontSize)
////            let labelText = indexPath.section + 1
//            reusableView.backgroundColor = .black
////            label.text = "Level \(labelText)";
////            label.textColor = UIColor.white
//
//        }
//
//        //reusableView.addSubview(label)
//
//        return reusableView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = avatarCollectionView.dequeueReusableCell(withReuseIdentifier: "AvatarCell", for: indexPath) as! InfoAvatarViewCell

        cell.delegate = self
        cell.generateCell(indexPath: indexPath)
      
        if avatar != nil {
        let arrayIndex = indexPath.section * 8 + indexPath.row
        cell.avatar = avatar![arrayIndex]
        }
        
        var selectableNumber = Int()
        if student != nil {
            for i in 0 ..< student!.stagePassed.count{
                if student?.stagePassed[i] == 1 {
                    selectableNumber += 1
                }
            }
            if indexPath.section < selectableNumber {
                cell.isUserInteractionEnabled = true
            } else {
                cell.isUserInteractionEnabled = false
              
            }
        } else {
            cell.isUserInteractionEnabled = false
        }
        
        return cell
        
    }
    
    
    
    func didTapAvatar(indexPath: IndexPath) {
        
    }
    
    @IBAction func avatarOkBtnClicked(_ sender: Any) {
        
        avatarBgView.isHidden = true
        if selectedAvatarImageName != nil {
            
            //上傳後端
            
        }
      

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        if avatar != nil {
            let arrayIndex = indexPath.section * 8 + indexPath.row
              avaImg.image = avatar![arrayIndex].image
              student?.avaImg = avatar![arrayIndex].imageName
              selectedAvatarImageName = avatar![arrayIndex].imageName
            
        }
    }
    
    
    //之後做ghostBtn使用
    @objc func removeBtns(){
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let heightForRow = height / 4
        return heightForRow
        
    }
    
    
    deinit {
        print("info deinit")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func changePhotoClicked(_ sender: Any) {
        
//        let picker = UIImagePickerController()
//        picker.delegate = self
//        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
//        picker.allowsEditing = true
//        picker.modalPresentationStyle = .overFullScreen
//
//
//        self.present(picker, animated: true, completion: nil)

        
        
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
     
        
        let time = DispatchTime.now() + 0.1
        DispatchQueue.main.asyncAfter(deadline: time) {[weak self] in
            FetchImage.shared.fetchAvatar(stagePassed:self!.student!.stagePassed) {(avatar) in
                self!.avatar = avatar
                self!.avatarCollectionView.reloadData()
                
                
                self!.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                self!.avatarBgView.isHidden = false
                
                
            }

        }
    }
    
  
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        

         let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoTableViewCell
        
            
            let attrs1: [NSAttributedStringKey: NSObject] = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: subValueFontSize), NSAttributedStringKey.foregroundColor : yellowColor]


            let attrs2: [NSAttributedStringKey: NSObject] = [NSAttributedStringKey.font : UIFont(name: "Helvetica Bold", size: subTitleFontSize)!, NSAttributedStringKey.foregroundColor : darkColor]
        
        cell.backgroundColor = .clear
        
        cell.value = values?[indexPath.row]
        
            //快速複習的數字不show
            if indexPath.row < 3 {
                
                //cell.infoTitle.text = infoTitles[indexPath.row]
                
                //cell.sub1Rate.text = String(sub1Rates[indexPath.row]) + "%"
                
                
                //cell.sub1Title.text = sub1Titles[indexPath.row]
                
                
                //cell.bigCountLabel.text = ""
                
                
                //cell.countUnitLabel.text = ""
            } else {
                
            
             //   cell.infoTitle.attributedText = NSAttributedString(string: cell.infoTitle.text!, attributes: attrs2)
              //  cell.infoTitle.attributedText = NSAttributedString(string: infoTitles[indexPath.row], attributes: attrs2)
                
              //  cell.sub1Rate.attributedText = NSAttributedString(string: cell.sub1Rate.text!, attributes: attrs1)
                
                //cell.sub1Title.text = ""
                
                //show大字
                //cell.bigCountLabel.text = String(sub1Rates[indexPath.row])
                
                //cell.bigCountLabel.text = "9999"
                
                //cell.countUnitLabel.text = countUnits[indexPath.row]
                
                
            }
            
//            if sub2Rates[indexPath.row] != Int(){
//
//                cell.sub2Rate.text = String(sub2Rates[indexPath.row]) + "%"
//
//            } else {
//
//                cell.sub2Rate.text = ""
//            }
        
            
            //設定不同顏色的title
            
            //cell.sub2Title.text = sub2Titles[indexPath.row]
            
//            for i in 0 ..< sub1Rates.count{
//
//                let firstRate = sub1Rates[i]
//                let secondRate = sub2Rates[i]
//
//                if secondRate != Int(){
//
//                    let avgRate:Int = (firstRate + secondRate) / 2
//
//                    totalRates[i] = avgRate
//
//                } else {
//
//                    totalRates[i] = firstRate
//                }
//            }
        
            if indexPath.row < 3 {
                //cell.totalRate.text = String(totalRates[indexPath.row]) + "%"

                cell.ringView.isHidden = false

            } else {
                cell.infoTitle.attributedText = NSAttributedString(string: cell.infoTitle.text!, attributes: attrs2)
                cell.sub1Rate.attributedText = NSAttributedString(string: cell.sub1Rate.text!, attributes: attrs1)
                cell.totalRate.text = ""
                cell.ringView.isHidden = true

            }
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 5
    }

    
    //var avatarCache = NSCache<AnyObject, AnyObject>()
    
    override func viewWillAppear(_ animated: Bool) {
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        if user != nil {

            
            Service.shared.selectUser { [weak self](student, values, headers) in
                
                self!.student = student
                self!.avatarHeaderData = headers
                //self!.stagePassed = (self!.student?.stagePassed)!
                
                
                DispatchQueue.main.async {
                   
                    self!.showStudentBasicInfo()
                    self!.myRank()
                    self!.values = values
         
                    self!.infoTableView.reloadData()
                    
                    self!.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()

                }
            }

        } else {
          print("user is nil")
            //create empty student & rank
            student = Student(avaImg: "avatar", nickName: infoVC_newStudent, allWordsCount: 0, score: infoVC_noScore, stagePassed: [0,0,0,0,0,0,0,0,0])
            rankCountLabel.text = infoVC_noRank
            showStudentBasicInfo()
     
            //create empty values
            createEmptyValues { [weak self] (values) in
                self!.values = values
                self!.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
            }

            //create avatarColectionView
//            FetchImage.shared.fetchAvatar(stagePassed: student!.stagePassed) {[weak self] (avatar) in
//                self!.avatar = avatar
//
//            }

            
        }
  
    }

    
    func showStudentBasicInfo(){
        
        self.avaImg.image = UIImage(named:student!.avaImg + ".png")
        self.usernameLabel.text = student!.nickName
        self.wordCountLabel.text = String(student!.allWordsCount)
        self.scoreCountLabel.text = String(student!.score)
        
    }
    
    func createEmptyValues(completion:@escaping ([Value]) -> ()){
        
        var tempValue = [Value]()
        let value1 = Value(infoTitle: infoVC_wordAchievement, sub1Title: infoVC_spellRate, sub1Value: "0%", sub2Title: infoVC_chineseRate, sub2Value: "0%"
            , avgValue: "0%", bigCountValue: "", bigCountUnit: "")
        tempValue.append(value1)
        
        let value2 = Value(infoTitle: infoVC_proAchievement, sub1Title: infoVC_proRate, sub1Value: "0%", sub2Title: "", sub2Value: "", avgValue: "0%", bigCountValue: "", bigCountUnit: "")
        tempValue.append(value2)
        
        let value3 = Value(infoTitle: infoVC_senAchievement, sub1Title: infoVC_writeSenRate, sub1Value: "0%", sub2Title: "", sub2Value: "", avgValue: "0%", bigCountValue: "", bigCountUnit: "")
        tempValue.append(value3)
        
        let value4 = Value(infoTitle: infoVC_spellKing, sub1Title: "", sub1Value: infoVC_wordCount, sub2Title: "", sub2Value: "", avgValue: "", bigCountValue: "0", bigCountUnit: infoVC_wordUnit)
        tempValue.append(value4)
        
        let value5 = Value(infoTitle: infoVC_senKing, sub1Title: "", sub1Value: infoVC_senCount, sub2Title: "", sub2Value: "", avgValue: "", bigCountValue: "0", bigCountUnit: infoVC_senUnit)
        tempValue.append(value5)
        
        completion(tempValue)
    }
    

    func myRank(){
        
        
        // url to access our php file
        let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/myRank.php")!
        
        // request url
        var request = URLRequest(url: url)
        
        // method to pass data POST - cause it is secured
        request.httpMethod = "GET"
        
        // append body to our request that gonna be sent
        //request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {[weak self] data, response, error in
            // no error
            if error == nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [NSDictionary]
                    
                    guard let parseJSON = json else {
                        print("Error while parsing")
                        
                        //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                        return
                    }
                    
                    
                    for i in 0 ..< parseJSON.count{
                        
                        if let id = parseJSON[i]["id"] as? Int{
                            
                            if user != nil {
                                
                                let userId = user?["id"] as! String
                                
                                //找到該使用者
                                if String(id) == userId{
                                    
                                    //抓他的分數
                                    let score = parseJSON[i]["score"] as! Int
                                    
                                    if score == 0 {
                                        
                                        DispatchQueue.main.async(execute: {
                                            
                                            self!.rankCountLabel.text = self!.infoVC_noRank
                                            
                                        })
                                        
                                    } else {
                                        
                                        DispatchQueue.main.async(execute: {
                                            
                                            self!.rankCountLabel.text = String(i + 1)
                                            
                                        })
                                        
                                    }
                                }
                            }
                        }
                    }
                    
                    
                } catch{
                    
                    print("catch error")
                    
                }
            } else {
                
                print("urlsession has error")
                
            }
        }).resume()
        
    }
    

    
    
    // selected image
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
  //  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        avaImg.image = info[UIImagePickerControllerEditedImage] as? UIImage
        
        
         self.dismiss(animated: false, completion: nil)
        
        /*
        self.dismiss(animated: true) {
            /*
            let value = UIInterfaceOrientation.landscapeLeft.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
 */
        }
        */
        
        
        // call func of uploading file to server
        if user != nil {
        uploadAva()
        
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
        /*
        self.dismiss(animated: true) {
            let value = UIInterfaceOrientation.landscapeLeft.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        }
        */
    }
    

    // custom body of HTTP request to upload image file
    func createBodyWithParams(_ parameters: [String: String]?, filePathKey: String?, imageDataKey: Data, boundary: String) -> Data {
        
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "ava.jpg"
        
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey)
        body.appendString("\r\n")
        
        body.appendString("--\(boundary)--\r\n")
        
        return body as Data
        
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // upload image to serve
    func uploadAva() {
        
        // shotcut id
        let id = user!["id"] as! String
        
        //let id = "135"
        
        // url path to php file
        let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/updateAva.php")!
        
        // declare request to this file
        var request = URLRequest(url: url)
        
        // declare method of passign inf to this file
        request.httpMethod = "POST"
        
        // param to be sent in body of request
        let param = ["id" : id]
        
        // body
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // compress image and assign to imageData var
        let imageData = UIImageJPEGRepresentation(avaImg.image!, 0.5)
        
        // if not compressed, return ... do not continue to code
        if imageData == nil {
            return
        }
        
        // ... body
        request.httpBody = createBodyWithParams(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        
        
        // launc session
        URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            
            // get main queue to communicate back to user
            DispatchQueue.main.async(execute: {
                
                if error == nil {
                    
                    do {
                        // json containes $returnArray from php
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        // declare new parseJSON to store json
                        guard let parseJSON = json else {
                            print("Error while parsing")
                            //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                            
                            return
                        }
                        
                        // get id from $returnArray["id"] - parseJSON["id"]
                        let id = parseJSON["id"]
                        
                        // successfully uploaded
                        if id != nil {
                            //print("got Id")
                            
                            
                            // save user information we received from our host
                            
                            UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                            user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                            
                            print(user)
                        } else {
                            print("didn't get id")
                            // get main queue to communicate back to user
                            DispatchQueue.main.async(execute: {
                                let message = parseJSON["message"] as! String
                                //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                                
                                print(message)
                            })
                            
                        }
                        
                        // error while jsoning
                    } catch {
                        
                        if let error = error as? NSError{
                            
                            print(error)
                        }
                        
                        print("error while parsing")/*
                         // get main queue to communicate back to user
                         DispatchQueue.main.async(execute: {
                         let message = error as! String
                         print(message)
                         appDelegate.createAlert(title: self.generalErrorTitleText, message: self.generalErrorMessageText, view: self)
                         
                         })
                         */
                    }
                    
                    // error with php
                } else {
                    
                    // get main queue to communicate back to user
                    DispatchQueue.main.async(execute: {
                        let message = error!.localizedDescription
                        print(message)
                        //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                        
                        
                    })
                    
                }
                
                
            })
            
            }.resume()
        
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
// Creating protocol of appending string to var of type data
extension NSMutableData {
    
    func appendString(_ string : String) {
        
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
        
    }
    
}
