//
//  InfoViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/5/18.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    let infoVC_wordAchievement = NSLocalizedString("infoVC_wordAchievement", comment: "")
    let infoVC_proAchievement = NSLocalizedString("infoVC_proAchievement", comment: "")
    let infoVC_senAchievement = NSLocalizedString("infoVC_senAchievement", comment: "")
    let infoVC_spellKing = NSLocalizedString("infoVC_spellKing", comment: "")
    let infoVC_senKing = NSLocalizedString("infoVC_senKing", comment: "")
    let infoVC_spellRate = NSLocalizedString("infoVC_spellRate", comment: "")
    let infoVC_proRate = NSLocalizedString("infoVC_proRate", comment: "")
    let infoVC_writeSenRate = NSLocalizedString("infoVC_writeSenRate", comment: "")
    let infoVC_wordCount = NSLocalizedString("infoVC_wordCount", comment: "")
    
    let infoVC_senCount = NSLocalizedString("infoVC_senCount", comment: "")
    let infoVC_chineseRate = NSLocalizedString("infoVC_chineseRate", comment: "")
    let infoVC_wordUnit = NSLocalizedString("infoVC_wordUnit", comment: "")
    
    let infoVC_senUnit = NSLocalizedString("infoVC_senUnit", comment: "")
    let infoVC_newStudent = NSLocalizedString("infoVC_newStudent", comment: "")
    
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
    
    
    var sub1Rates:[Int] = [0,0,0,0,0]
    var sub2Rates:[Int] = [0,Int(),Int(),Int(),Int()]
    var subTitleFontSize:CGFloat!
    var subValueFontSize:CGFloat!
    var maxSpot:Int!
    
    @IBOutlet weak var alphaLayer: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var titleFontSize: CGFloat!
        var infoFontSize: CGFloat!
        var usernameFontSize: CGFloat!
        var avaYDif:CGFloat!
        
        switch height {
            
            
        case 1366, 1336:
            dif = 1.5
            photoDif = 2
            
            titleFontSize = 40
            infoFontSize = 30
            subTitleFontSize = 35
            subValueFontSize = 35
            usernameFontSize = 60
            avaYDif = 1
            
        case 1024, 1194, 1112:
            dif = 1.1
            photoDif = 1.5
            
            titleFontSize = 35
            infoFontSize = 20
            subTitleFontSize = 28
            subValueFontSize = 22
            usernameFontSize = 40
            avaYDif = 1
        case 812:
            
            //iPhoneX
            dif = 0.8
            photoDif = 1
            
            titleFontSize = 20
            infoFontSize = 16
            subTitleFontSize = 20
            subValueFontSize = 15
            usernameFontSize = 25
            avaYDif = 1
            
        case 736:
            
            //plus
            dif = 0.8
            photoDif = 1
            
            titleFontSize = 24
            infoFontSize = 16
            subTitleFontSize = 20
            subValueFontSize = 16
            usernameFontSize = 26
            avaYDif = 1
            
        case 667:
            
            dif = 0.7
            photoDif = 1
            
            titleFontSize = 20
            infoFontSize = 16
            subTitleFontSize = 18
            subValueFontSize = 14
            usernameFontSize = 22
            avaYDif = 1
        case 568:
            
            dif = 0.8
            photoDif = 0.7
            
            titleFontSize = 16
            infoFontSize = 16
            subTitleFontSize = 16
            subValueFontSize = 14
            usernameFontSize = 18
            avaYDif = 0.6
            
        default:
            dif = 0.8
            photoDif = 1
            
            titleFontSize = 20
            infoFontSize = 16
            subTitleFontSize = 20
            subValueFontSize = 15
            usernameFontSize = 25
            avaYDif = 1
            
            break
            
        }
        
        
        
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
        
        avaImg.contentMode = .scaleAspectFill
        avaImg.layer.cornerRadius = avaImg.frame.width / 2
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
        
//        wordCountLabel.frame = CGRect(x: backBtn.frame.minX + 10 * dif, y: alphaLayer.frame.minY + 5 * dif, width: 90 * dif, height: 23 * dif)
        
        wordCountLabel.frame = CGRect(x: width / 3 - 45 * dif, y: alphaLayer.frame.minY + 5 * dif, width: 90 * dif, height: 23 * dif)
        
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
        
        scoreCountLabel.frame = CGRect(x: width * 2 / 3 - 75 * dif, y: alphaLayer.frame.minY + 5 * dif, width: 150 * dif, height: 23 * dif)
        
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
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        picker.allowsEditing = true
        picker.modalPresentationStyle = .overFullScreen
        
        
        self.present(picker, animated: true, completion: nil)
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoTableViewCell
        
        
        // let attrs0 = [NSAttributedStringKey.font : UIFont(name: "Helvetica Neue", size: 12), NSAttributedStringKey.foregroundColor : lightColor]
        
        let attrs1: [NSAttributedStringKey: NSObject] = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: subValueFontSize), NSAttributedStringKey.foregroundColor : yellowColor]
        
        
        let attrs2: [NSAttributedStringKey: NSObject] = [NSAttributedStringKey.font : UIFont(name: "Helvetica Bold", size: subTitleFontSize)!, NSAttributedStringKey.foregroundColor : darkColor]
        
        
        cell.backgroundColor = .clear
        
        let infoTitles = [infoVC_wordAchievement, infoVC_proAchievement,infoVC_senAchievement, infoVC_spellKing, infoVC_senKing]
        let sub1Titles = [infoVC_spellRate,infoVC_proRate,infoVC_writeSenRate,infoVC_wordCount,infoVC_senCount]
        let sub2Titles = [infoVC_chineseRate,String(),String(),String(),String()]
        let countUnits = ["","","",infoVC_wordUnit,infoVC_senUnit]
        
        var totalRates = [Int(),Int(),Int(),Int(),Int()]
        
        
        //快速複習的數字不show
        if indexPath.row < 3 {
            
            cell.infoTitle.text = infoTitles[indexPath.row]
            
            cell.sub1Rate.text = String(sub1Rates[indexPath.row]) + "%"
            
            
            cell.sub1Title.text = sub1Titles[indexPath.row]
            
            
            cell.bigCountLabel.text = ""
            
            
            cell.countUnitLabel.text = ""
        } else {
            
            cell.infoTitle.attributedText = NSAttributedString(string: infoTitles[indexPath.row], attributes: attrs2)
            
            cell.sub1Rate.attributedText = NSAttributedString(string: sub1Titles[indexPath.row], attributes: attrs1)
            
            cell.sub1Title.text = ""
            
            //show大字
            cell.bigCountLabel.text = String(sub1Rates[indexPath.row])
            
            //cell.bigCountLabel.text = "9999"
            
            cell.countUnitLabel.text = countUnits[indexPath.row]
            
            
        }
        
        if sub2Rates[indexPath.row] != Int(){
            
            cell.sub2Rate.text = String(sub2Rates[indexPath.row]) + "%"
            
        } else {
            
            cell.sub2Rate.text = ""
        }
        
        
        //設定不同顏色的title
        
        cell.sub2Title.text = sub2Titles[indexPath.row]
        
        for i in 0 ..< sub1Rates.count{
            
            let firstRate = sub1Rates[i]
            let secondRate = sub2Rates[i]
            
            if secondRate != Int(){
                
                let avgRate:Int = (firstRate + secondRate) / 2
                
                totalRates[i] = avgRate
                
            } else {
                
                totalRates[i] = firstRate
            }
        }
        
        if indexPath.row < 3 {
            cell.totalRate.text = String(totalRates[indexPath.row]) + "%"
            
            cell.ringView.progress = 0.0
            
            CATransaction.setCompletionBlock {
                
                CATransaction.begin()
                CATransaction.setAnimationDuration(2)
                
                cell.ringView.progress = Double(totalRates[indexPath.row]) / Double(100)
                CATransaction.commit()
                
            }
            
            cell.ringView.isHidden = false
            
        } else {
            
            
            cell.totalRate.text = ""
            cell.ringView.isHidden = true
            
        }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 5
    }
    
    
    override func viewWillAppear(_ animated: Bool) {

        
        //單機版: 不排名
        getUserInfo()
        
    }
    
    
    
    
    func selectUser(){

    }
    
    
    
    func myRank(){

    }
    
    func getUserInfo(){
        
        //print("perform get user")
        //指定個人大頭照
        
        if let avaData = user?[kAva] as? Data {
            
            DispatchQueue.main.async {[weak self] in
                self!.avaImg.image = UIImage(data: avaData)
            }
        } else {
            DispatchQueue.main.async {[weak self] in
                self!.avaImg.image = UIImage(named: "avatar.png")
            }
        }
        
        //取得暱稱
        if let nickname = user?["nickname"] as? String{
            
            self.usernameLabel.text = nickname
        } else {
            
            self.usernameLabel.text = self.infoVC_newStudent
        }
        
        
        //MARK: must update
        //算字數
        //在此有可能遇到user == nil的狀況, 不過在appDelegate已經給值, 稍後應該要修成if user == nil {} else {}
        
        //MARK: simVer 算分數算法要改
        
        var maxWordCount = Int()
        var allMapPassedCount:Int!
        
//        if user != nil {
        
            if lan == "zh-Hans"{
                //檢體中文
                
                //print("檢體中文關卡數")
                //之後還要用courseReceived來改數值, 因為每個course值不同
                
                allMapPassedCount =  mapPassed! * 330 + mapPassed2! * 450 + mapPassed3! * 450 +  mapPassed4! * 450 +  mapPassed5! * 450 + mapPassed7! * 450 + mapPassed8! * 450 + mapPassed9! * 450
                
                //MARK: simVer 另外計算K12的字數
                
                var k12ElemWordsMax = [120,330,330,300,330,330,330,330,390,390,330,330,210,330,300,180,390,390]
                
                //k12
                for i in 0 ..< k12MapPassed.count {
                    
                    //MARK: 這裡要修正
                    if k12MapPassed[i] == 1 {
                        
                        allMapPassedCount += k12ElemWordsMax[i]
                        
                    } else {
                        
                        //eachCellMyWordsCount[i] =
                        
                        for (s,u) in k12GamePassed[i] {
                            
                            allMapPassedCount += s * 30 + u * 3
                        }
                
                    }
                }
 
            } else {
                //其餘語言
                //print("繁體中文關卡數")
                maxWordCount = 450
                
                allMapPassedCount = mapPassed! * maxWordCount + mapPassed2! * maxWordCount + mapPassed3! * maxWordCount + mapPassed4! * maxWordCount + mapPassed5! * maxWordCount
                
            }
            
            var gamePassedCount = Int()
            var gamePassed2Count = Int()
            var gamePassed3Count = Int()
            var gamePassed4Count = Int()
            var gamePassed5Count = Int()
            var gamePassed7Count = Int()
            var gamePassed8Count = Int()
            var gamePassed9Count = Int()
            
            
            for (s,u) in gamePassed!{
                gamePassedCount = s * 30 + u * 3
            }
            for (s,u) in gamePassed2!{
                gamePassed2Count = s * 30 + u * 3
            }
            
            
            for (s,u) in gamePassed3!{
                gamePassed3Count = s * 30 + u * 3
            }
            
            for (s,u) in gamePassed4!{
                gamePassed4Count = s * 30 + u * 3
            }
            
            for (s,u) in gamePassed5!{
                gamePassed5Count = s * 30 + u * 3
            }

            for (s,u) in gamePassed7!{
                gamePassed7Count = s * 30 + u * 3
            }
            for (s,u) in gamePassed8!{
                gamePassed8Count = s * 30 + u * 3
            }
            for (s,u) in gamePassed9!{
                gamePassed9Count = s * 30 + u * 3
            }
            
            let allGamePassedCount = gamePassedCount + gamePassed2Count + gamePassed3Count + gamePassed4Count + gamePassed5Count + gamePassed7Count + gamePassed8Count + gamePassed9Count
            

            let allWordsCount = allMapPassedCount + allGamePassedCount
            
            wordCountLabel.text = String(allWordsCount)
            
            //算拼字正確率
            var wrongWordsCount = Int()
            if let wrongWords = user?["wrongWords"] as? String{
                
                let wrongWordArray = wrongWords.components(separatedBy: ";")
                
                wrongWordsCount = wrongWordArray.count - 1
                
            }

            
            if allWordsCount == 0 {
                //這樣的話比例也是0
                
                sub1Rates[0] = 0
                
            } else {
                
                sub1Rates[0] = Int((1 - (Double(wrongWordsCount) / Double(allWordsCount))) * 100)
                
            }
            
            //中文正確率
            
            //目前中文正確率若設定為0的時候, cellForRow裡面不會顯示0%..雖然不影響但是怪怪的
            
            if let wrongChinese = user?["wrongChinese"] as? Int{
                
                if allWordsCount == 0 {
                    //這樣的話比例也是0
                    
                    sub2Rates[0] = 0
                    
                } else {
                    
                    sub2Rates[0] = Int((1 - (Double(wrongChinese) / Double(allWordsCount))) * 100)
                    
                }
            }
            
            
            
//        } else {
//
//            wordCountLabel.text = "0"
//            // print("user is nil 所產生的值")
//
//        }
        
        
        
        //抓分數
        if let score = user?["score"] as? Int{
            
            scoreCountLabel.text = "\(score)"
            
        } else {
            
            scoreCountLabel.text = infoVC_noScore
//            rankCountLabel.text = infoVC_noRank
        }
        
        
        
        
        //發音正確率
        
        if let proRate = user?["proRate"] as? Int{
            
            if proRate == 200 {
                
                sub1Rates[1] = 0
                
            } else {
                
                sub1Rates[1] = Int(proRate)
                
            }
            
        }
        //句子排列正確率
        
        if let senRate = user?["senRate"] as? Int{
            
            if senRate == 200{
                
                sub1Rates[2] = 0
                
            } else {
                sub1Rates[2] = senRate
            }
        }
        
        
        //MARK: must update
        
        //快速複習單字數
        if let wordCount = user?["wordReviewCount"] as? Int{
            if let wordCount2 = user?["wordReviewCount2"] as? Int{
                if let wordCount3 = user?["wordReviewCount3"] as? Int{
                    if let wordCount4 = user?["wordReviewCount4"] as? Int{
                        if let wordCount5 = user?["wordReviewCount5"] as? Int {
                            if let wordCount6 = user?["wordReviewCount6"] as? Int {
                                if let wordCount7 = user?["wordReviewCount7"] as? Int {
                                    if let wordCount8 = user?["wordReviewCount8"] as? Int {
                                        if let wordCount9 = user?["wordReviewCount9"] as? Int {
                                            
                                            
                                            let totalWordCount = Int(wordCount) + Int(wordCount2) + Int(wordCount3) + Int(wordCount4) + Int(wordCount5) + Int(wordCount6) + Int(wordCount7) + Int(wordCount8) + Int(wordCount9)
                                            
                                            
                                            sub1Rates[3] = totalWordCount
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        //快速複習句型數
        if let senCount = user?["senReviewCount"] as? Int{
            if let senCount2 = user?["senReviewCount2"] as? Int{
                if let senCount3 = user?["senReviewCount3"] as? Int{
                    if let senCount4 = user?["senReviewCount4"] as? Int {
                        if let senCount5 = user?["senReviewCount5"] as? Int {
                            if let senCount6 = user?["senReviewCount6"] as? Int {
                                if let senCount7 = user?["senReviewCount7"] as? Int {
                                    if let senCount8 = user?["senReviewCount8"] as? Int {
                                        if let senCount9 = user?["senReviewCount9"] as? Int {
                                            
                                            
                                            let totalSenCount = Int(senCount) + Int(senCount2) + Int(senCount3) + Int(senCount4) + Int(senCount5) + Int(senCount6) + Int(senCount7) + Int(senCount8) + Int(senCount9)
                                            
                                            sub1Rates[4] = totalSenCount
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        
        infoTableView.reloadData()
        
        
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
        
        //save photo to userdefault
        
        let imageData = UIImageJPEGRepresentation(avaImg.image!, 0.5)
        //let encodedAvaData = NSKeyedArchiver.archivedData(withRootObject: imageData)
        //userDefaults.set(encodedAvaData, forKey: kAva)
        
        
        let copyUser = user?.mutableCopy() as! NSMutableDictionary
        
        copyUser.setValue(imageData, forKey: kAva)
 
        //                    copyUser[kScore] = updatePoints
        //                    copyUser[kWrongChinese] = wrongChineseCounts
        //                    copyUser[kProRate] = proRate
        //                    copyUser[kSenRate] = senRate
        
        user = copyUser
        userDefaults.set(user, forKey: "parseJSON")
        
        print(user)
        
//        // shotcut id
//        let id = user!["id"] as! String
//
//        //let id = "135"
//
//        // url path to php file
//        var url:URL
//        if lan == "zh-Hans" {
//            url = URL(string: "http://ec2-52-198-62-78.ap-northeast-1.compute.amazonaws.com/misswordChina/updateAva.php")!
//        } else {
//            url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/updateAva.php")!
//        }
//        //let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/updateAva.php")!
//
//        // declare request to this file
//        var request = URLRequest(url: url)
//
//        // declare method of passign inf to this file
//        request.httpMethod = "POST"
//
//        // param to be sent in body of request
//        let param = ["id" : id]
//
//        // body
//        let boundary = "Boundary-\(UUID().uuidString)"
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//        // compress image and assign to imageData var
//        let imageData = UIImageJPEGRepresentation(avaImg.image!, 0.5)
//
//        // if not compressed, return ... do not continue to code
//        if imageData == nil {
//            return
//        }
//
//        // ... body
//        request.httpBody = createBodyWithParams(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
//
//
//        // launc session
//        URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
//
//            // get main queue to communicate back to user
//            DispatchQueue.main.async(execute: {
//
//                if error == nil {
//
//                    do {
//                        // json containes $returnArray from php
//                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
//
//                        // declare new parseJSON to store json
//                        guard let parseJSON = json else {
//                            print("Error while parsing")
//                            //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
//
//                            return
//                        }
//
//                        // get id from $returnArray["id"] - parseJSON["id"]
//                        let id = parseJSON["id"]
//
//                        // successfully uploaded
//                        if id != nil {
//                            //print("got Id")
//
//
//                            // save user information we received from our host
//
//                            UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
//                            user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
//
//                        } else {
//                            print("didn't get id")
//                            // get main queue to communicate back to user
//                            DispatchQueue.main.async(execute: {
//                                let message = parseJSON["message"] as! String
//                                //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
//
//                                print(message)
//                            })
//
//                        }
//
//                        // error while jsoning
//                    } catch {
//
//                        if let error = error as? NSError{
//
//                            print(error)
//                        }
//
//                        print("error while parsing")/*
//                         // get main queue to communicate back to user
//                         DispatchQueue.main.async(execute: {
//                         let message = error as! String
//                         print(message)
//                         appDelegate.createAlert(title: self.generalErrorTitleText, message: self.generalErrorMessageText, view: self)
//
//                         })
//                         */
//                    }
//
//                    // error with php
//                } else {
//
//                    // get main queue to communicate back to user
//                    DispatchQueue.main.async(execute: {
//                        let message = error!.localizedDescription
//                        print(message)
//                        //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
//
//
//                    })
//
//                }
//
//
//            })
//
//            }.resume()
//
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

