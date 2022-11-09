//
//  CoursesViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/2/21.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController, CourseTableViewCellDelegate, UITableViewDataSource, UITableViewDelegate{
    
    //courseReceived 0國小 1初中 2高中 3CET4 4CET6 5K12 6toeic 7ielts 8tofel

    let courseVC_purchasedState = NSLocalizedString("courseVC_purchasedState", comment: "")
    let courseVC_freeState = NSLocalizedString("courseVC_freeState", comment: "")
    let courseVC_learningDays = NSLocalizedString("courseVC_learningDays", comment: "")
    let courseVC_newStudent = NSLocalizedString("courseVC_newStudent", comment: "")
    let courseVC_logOutBtnText = NSLocalizedString("courseVC_logOutBtnText", comment: "")
  
    @IBOutlet weak var logOutBtn: UIButton!
 
    var courseSent = Int()
    
    //layOut
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    @IBOutlet weak var toInfoVcBtn: UIButton!
    
    @IBOutlet weak var toShopVcBtn: UIButton!
    
    var hiddenInfoBtn = UIButton()

    var hiddenShopBtn = UIButton()
    
    @IBOutlet weak var bigNameLabel: UILabel!
    
    @IBOutlet weak var dayTitleLabel: UILabel!
    @IBOutlet weak var userStatusLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!

    @IBOutlet weak var logoImg: UIImageView!

    var activityIndicator = UIActivityIndicatorView()
    
    var repeatTimes = 0
    
    @IBOutlet weak var courseTableView: UITableView!
    
    @IBOutlet weak var toLoginVcBtn: UIButton!
    var dynamicCellHeight:CGFloat!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dif = CGFloat()
        var iPadDif = CGFloat()
        var bigNameFontSize: CGFloat!
        var logOutBtnLabelFontSize:CGFloat!
        var dayFontSize:CGFloat!
        var dayTitleFontSize:CGFloat!
        var statusFontSize: CGFloat!

        switch height {
            
        case 1366, 1336:
            //print("iPad pro 2nd generation")
            
            dif = 1
            iPadDif = 2
    
            bigNameFontSize = 60
            dynamicCellHeight = 250
            logOutBtnLabelFontSize = 30
            dayFontSize = 100
            dayTitleFontSize = 24
            statusFontSize = 24

        case 1024, 1194, 1112:
            //print("9.7 iPad or 7.9 iPad mini, iPad(5th), iPad air, iPad air 2")
        
            dif = 1
            iPadDif = 1.5
            
            bigNameFontSize = 40
            dynamicCellHeight = 180
            logOutBtnLabelFontSize = 20
            dayFontSize = 70
            dayTitleFontSize = 20
            statusFontSize = 20
 
        case 812:
           //iPhoneX
            dif = 1.1
            iPadDif = 1
            dynamicCellHeight = 120
            
            bigNameFontSize = 30
            logOutBtnLabelFontSize = 12
            dayFontSize = 50
            dayTitleFontSize = 12
            statusFontSize = 12

        case 736:
            //plus
            dif = 1
            iPadDif = 1
            dynamicCellHeight = 120
            
            bigNameFontSize = 30
            logOutBtnLabelFontSize = 12
            dayFontSize = 46
            dayTitleFontSize = 12
            statusFontSize = 12
   
        case 667:
            //iphone 7
            dif = 1
            iPadDif = 1
            dynamicCellHeight = 110
            
            bigNameFontSize = 30
            logOutBtnLabelFontSize = 12
            dayFontSize = 44
            dayTitleFontSize = 12
            statusFontSize = 12
   
        case 568:
    
            //Se
            dif = 0.9
            iPadDif = 1
            dynamicCellHeight = 90
            
            bigNameFontSize = 24
            logOutBtnLabelFontSize = 12
            dayFontSize = 36
            dayTitleFontSize = 12
            statusFontSize = 12
         
        default:
            dif = 1.1
            iPadDif = 1
            dynamicCellHeight = 120
            
            bigNameFontSize = 30
            logOutBtnLabelFontSize = 12
            dayFontSize = 50
            dayTitleFontSize = 12
            statusFontSize = 12

            break
        }
     
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100 * iPadDif, height: 100 * iPadDif))
        activityIndicator.layer.zPosition = 15
        let alphaGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.layer.cornerRadius = activityIndicator.frame.width / 20
        activityIndicator.backgroundColor = alphaGray
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        view.addSubview(activityIndicator)
        
        
        //MARK: UI Setting

  
        logoImg.anchor(top: view.safeTopAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: width / 2 - (135 * dif * iPadDif) / 2, bottom: 0, right: 0), size: .init(width: 135 * dif * iPadDif, height: 131 * dif * iPadDif))
        

        logOutBtn.anchor(top: view.safeTopAnchor, leading: nil, bottom: nil, trailing: view.safeRightAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: -10), size: .init(width: 50 * iPadDif * dif, height: 22 * iPadDif * dif))

        
        toLoginVcBtn.anchor(top: view.safeTopAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: nil, padding: .init(top: 5, left: 5, bottom: 0, right: 0), size: .init(width: 63 * iPadDif * dif, height: 24 * iPadDif * dif))
    
        bigNameLabel.font = bigNameLabel.font.withSize(bigNameFontSize)
        
        bigNameLabel.adjustsFontSizeToFitWidth = true

        bigNameLabel.anchor(top: toLoginVcBtn.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0), size: .init(width: 200 * iPadDif * dif, height: 35 * iPadDif * dif))
       //bigNameLabel.backgroundColor = .green
        
  
        userStatusLabel.font = userStatusLabel.font.withSize(statusFontSize)
        
        userStatusLabel.anchor(top: bigNameLabel.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0), size: .init(width: 200 * iPadDif * dif, height: 55 * iPadDif * dif))

        
        dayTitleLabel.font = dayTitleLabel.font.withSize(dayTitleFontSize)
        dayTitleLabel.anchor(top: logOutBtn.bottomAnchor, leading: nil, bottom: nil, trailing: view.safeRightAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: -10), size: .init(width: 60 * iPadDif * dif, height: 25 * iPadDif * dif))
    
        daysLabel.font = daysLabel.font.withSize(dayFontSize)
        daysLabel.anchor(top: dayTitleLabel.bottomAnchor, leading: nil, bottom: nil, trailing: view.safeRightAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: -10), size: .init(width: 200 * iPadDif * dif, height: 65 * iPadDif * dif))
        daysLabel.adjustsFontSizeToFitWidth = true
        //daysLabel.backgroundColor = .red
        
   
        
    
        //設定tableview高度
        courseTableView.backgroundColor = .clear
        
        courseTableView.separatorColor = .lightGray
        courseTableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)

        courseTableView.anchor(top: userStatusLabel.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: view.safeRightAnchor, size: .init(width: width, height: 490 * iPadDif * dif))
        
        
        let borderLine = UIView()
        borderLine.backgroundColor = .lightGray
        self.view.addSubview(borderLine)
        
        borderLine.anchor(top: nil, leading: view.safeLeftAnchor, bottom: courseTableView.topAnchor, trailing: view.safeRightAnchor, size: .init(width: width, height: 0.5))

        
        //底部選項的背景
        
        let bottomView = UIView()
        bottomView.backgroundColor = #colorLiteral(red: 0.1972360313, green: 0.1450089514, blue: 0.1361441612, alpha: 1)
        self.view.addSubview(bottomView)
        bottomView.anchor(top: courseTableView.bottomAnchor, leading: view.safeLeftAnchor, bottom: view.bottomAnchor, trailing: view.safeRightAnchor)

        

        toInfoVcBtn.frame = CGRect(x: width / 4 - (27 * dif * iPadDif) / 2, y: height - 44 * dif * iPadDif, width: 27 * dif * iPadDif, height: 36 * dif * iPadDif)
 
        toShopVcBtn.frame = CGRect(x: width * 3 / 4 - (32 * dif * iPadDif) / 2, y: height - 40 * dif * iPadDif, width: 32 * dif * iPadDif, height: 32 * dif * iPadDif)

        
        let btnColumn = UIView()
        btnColumn.backgroundColor = .darkGray
        self.view.addSubview(btnColumn)
        btnColumn.anchor(top: courseTableView.bottomAnchor, leading: view.safeLeftAnchor, bottom: view.bottomAnchor, trailing: nil, padding: .init(top: 0, left: width / 2, bottom: 0, right: 0), size: .init(width: 1, height: 50 * iPadDif * dif))
        
        hiddenInfoBtn.addTarget(self, action: #selector(CoursesViewController.toInfoVcClicked(_:)), for: .touchUpInside)
        self.view.addSubview(hiddenInfoBtn)
        
        hiddenInfoBtn.anchor(top: courseTableView.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing:nil, size: .init(width: width / 2, height: 50 * iPadDif * dif))
        

        hiddenShopBtn.addTarget(self, action: #selector(CoursesViewController.toShopVcBtnClicked(_:)), for: .touchUpInside)
        self.view.addSubview(hiddenShopBtn)
        hiddenShopBtn.anchor(top: courseTableView.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: width / 2, bottom: 0, right: 0))
        hiddenShopBtn.anchorSize(to: hiddenInfoBtn)


        self.view.bringSubviewToFront(toInfoVcBtn)
        self.view.bringSubviewToFront(toShopVcBtn)

        bigNameLabel.text = ""
        userStatusLabel.text = courseVC_freeState
        userStatusLabel.adjustsFontSizeToFitWidth = true
        
        dayTitleLabel.text = courseVC_learningDays
        daysLabel.text = ""
        daysLabel.adjustsFontSizeToFitWidth = true
        
        
    }

    
    //MARK: TableView delegate
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        //MARK: must update
        //MARK: simVer
        
        var rows:Int!
        
        if lan == "zh-Hans"{
            //檢體中文
            
            //print("檢體中文關卡數")
            //之後還要用courseReceived來改數值, 因為每個course值不同
            
            rows = 9
            
        } else {
            //其餘語言
            //print("繁體中文關卡數")
            rows = 5
            
        }
        return rows
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return dynamicCellHeight
    }
    
    func didTapEnterClass(indexPath: IndexPath) {
       
        courseSent = indexPath.row
        performSegue(withIdentifier: "toStageVc", sender: self)
        
    }
    
    func didTapEnterBook(indexPath: IndexPath) {
 
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        let time = DispatchTime.now() + 0.1
        DispatchQueue.main.asyncAfter(deadline: time) {[weak self] in
            self!.courseSent = indexPath.row
            self!.performSegue(withIdentifier: "toNewBookVc", sender: self)
        }
    }

    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoursesCell", for: indexPath) as! CourseTableViewCell
        
        //MARK: must update
        //MARK: simVer 這裡要增加簡體版的方塊圖 & 字數
        
        var titleImg = [String]()
        var wordCounts = [Int]()
        
        if lan == "zh-Hans"{
            //檢體中文
            
            //print("檢體中文關卡數")
            //之後還要用courseReceived來改數值, 因為每個course值不同
            
            titleImg = ["simBlock0","simBlock1","simBlock2","simBlock3", "simBlock4","simBlock5","simBlock6","simBlock7","simBlock8"]
            
            wordCounts = [990, 2250, 2700, 4950, 5850, 5670, 3150, 4050, 3600]
            
            
        } else {
            //其餘語言
            //print("繁體中文關卡數")
            
            titleImg = ["block0Title","block1Title","block2Title","block3Title", "block4Title"]
            wordCounts = [2250,2700, 3150, 4050, 3600]
        }
        

        cell.wordCountOutlet.text = "\(wordCounts[indexPath.row])"
        cell.courseTitleImg.image = UIImage(named: titleImg[indexPath.row] + ".png")
        cell.courseTitleImg.contentMode = .scaleAspectFill
        cell.generateCell(indexPath: indexPath)
        cell.backgroundColor = .clear
        
        cell.delegate = self
        return cell
    }
    

    
    override func viewWillDisappear(_ animated: Bool) {

        
        //停止打開單字集的loadingView
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    
        self.view.subviews.forEach({$0.layer.removeAllAnimations()})
        self.view.layer.removeAllAnimations()
        self.view.layoutIfNeeded()

    }
    
    
    func daysBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    
    @IBAction func toShopVcBtnClicked(_ sender: Any) {
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        performSegue(withIdentifier: "toShopVc", sender: self)
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        
        //print("Course:\(user)")
        
         var nickname = String()
         var purchaseStatus = String()
         //測試用
        
        let isPurchased = UserDefaults.standard.object(forKey: "isPurchased") as! Bool
        
        if isPurchased{
            //買了
            //purchaseStatus = "付費用戶\n新課程：不限時間\n單字集/挑戰模式：不限時間"
            
            purchaseStatus = courseVC_purchasedState
        } else {
            //還沒買
            purchaseStatus = courseVC_freeState
            
        }

         if user != nil {
            
         nickname = user?["nickname"] as! String
    
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            
            //計算天數
            let startDateString = user?["date"] as! String
            //之後是否會有空白要check
            let startDate = startDateString.components(separatedBy: " ")
            let start = dateFormatter.date(from: startDate[0])
            let todayString = Date()
            let today = dateFormatter.string(from: todayString)
         
            
            let todayDate = dateFormatter.date(from: today)
            let days = daysBetween(start: start!, end: todayDate!)
            daysLabel.text = String(days)

         }


        bigNameLabel.text = "Hi!" + nickname
        userStatusLabel.text = purchaseStatus
        
         //用不到的按鈕hidden起來
        toLoginVcBtn.isHidden = true
        logOutBtn.isHidden = true
    }

    

    @IBAction func toInfoVcClicked(_ sender: Any) {
        performSegue(withIdentifier: "toInfoVc", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toNewBookVc" {
            
            let destinationVc = segue.destination as! NewBookViewController
            
            //之後這裡要傳送的是課程名稱
            destinationVc.courseReceived = courseSent
            destinationVc.modalPresentationStyle = .fullScreen
            
            if #available(iOS 13.0, *) {
                destinationVc.isModalInPresentation = false
            } else {
                // Fallback on earlier versions
            }
        }
        
        
        if segue.identifier == "toStageVc"{
            
            let destinationVc = segue.destination as! StageViewController
            destinationVc.courseReceived = courseSent
            destinationVc.modalPresentationStyle = .fullScreen
            
            if #available(iOS 13.0, *) {
                destinationVc.isModalInPresentation = false
            } else {
                // Fallback on earlier versions
            }
        }
        
        if segue.identifier == "toInfoVc"{
            
            let destinationVc = segue.destination as! InfoViewController
         
            destinationVc.modalPresentationStyle = .fullScreen
            
            if #available(iOS 13.0, *) {
                destinationVc.isModalInPresentation = false
            } else {
                // Fallback on earlier versions
            }
        }
        
        if segue.identifier == "toShopVc"{
            
            let destinationVc = segue.destination as! PurchaseViewController
         
            destinationVc.modalPresentationStyle = .fullScreen
            
            if #available(iOS 13.0, *) {
                destinationVc.isModalInPresentation = false
            } else {
                // Fallback on earlier versions
            }
        }
        

    }
    

    
//    func startFetchingData(){
//
//
//
//        if usernameTxt.text!.isEmpty || usernameTxt.text!.count < 5 {
//
//
//
//            usernameTxt.text = ""
//            usernameTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上帳號", attributes: attrs)
//
//            if  passwordTxt.text!.isEmpty  || passwordTxt.text!.count < 5{
//
//                passwordTxt.text = ""
//
//                passwordTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上密碼", attributes: attrs)
//
//            }
//
//        } else if  passwordTxt.text!.isEmpty  || passwordTxt.text!.count < 5{
//
//            passwordTxt.text = ""
//
//            passwordTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上密碼", attributes: attrs)
//
//            if usernameTxt.text!.isEmpty || usernameTxt.text!.count < 5 {
//
//
//
//                usernameTxt.text = ""
//                usernameTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上帳號", attributes: attrs)
//
//
//            }
//
//        } else {
//
//
//
//            activityIndicator.startAnimating()
//            UIApplication.shared.beginIgnoringInteractionEvents()
//
//
//            // shortcuts
//            let username = usernameTxt.text!.lowercased()
//            let password = passwordTxt.text!
//
//            // send request to mysql db
//            // url to access our php file
//            let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/login.php")!
//
//            // request url
//            var request = URLRequest(url: url)
//
//            // method to pass data POST - cause it is secured
//            request.httpMethod = "POST"
//
//            // body gonna be appended to url
//            let body = "username=\(username)&password=\(password)"
//
//            // append body to our request that gonna be sent
//            request.httpBody = body.data(using: .utf8)
//
//
//            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
//
//                // no error
//                if error == nil {
//
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
//
//                        guard let parseJSON = json else {
//                            print("Error while parsing")
//                            //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
//                            self!.activityIndicator.stopAnimating()
//                            UIApplication.shared.endIgnoringInteractionEvents()
//                            return
//                        }
//
//
//                        isRegistered = true
//
//                        UserDefaults.standard.set(isRegistered, forKey: "isRegistered")
//
//
//                        //先儲存使用者資訊
//                        UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
//                        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
//
//
//                        //MARK: must update
//
//                        //抓mapPassed & gamePassed
//
//                        if let mapPassedString = user?["mapPassed"] as! String?{
//
//                            mapPassed = Int(mapPassedString)!
//
//                            let userDefaults = UserDefaults.standard
//                            userDefaults.set(mapPassed!, forKey: "mapPassed")
//
//                            print("retrieve mapPassed:\(mapPassed!)")
//
//                        }
//
//                        if let mapPassed2String = user?["mapPassed2"] as! String?{
//
//                            mapPassed2 = Int(mapPassed2String)!
//
//                            let userDefaults = UserDefaults.standard
//                            userDefaults.set(mapPassed2!, forKey: "mapPassed2")
//
//                            print("retrieve mapPassed:\(mapPassed2!)")
//
//                        }
//
//                        if let mapPassed3String = user?["mapPassed3"] as! String?{
//
//                            mapPassed3 = Int(mapPassed3String)!
//                            let userDefaults = UserDefaults.standard
//                            userDefaults.set(mapPassed3!, forKey: "mapPassed3")
//
//                            print("retrieve mapPassed:\(mapPassed3!)")
//
//                        }
//
//                        if let mapPassed4String = user?["mapPassed4"] as! String?{
//
//                            mapPassed4 = Int(mapPassed4String)!
//                            let userDefaults = UserDefaults.standard
//                            userDefaults.set(mapPassed4!, forKey: "mapPassed4")
//
//                            print("retrieve mapPassed:\(mapPassed4!)")
//
//                        }
//
//                        if let mapPassed5String = user?["mapPassed5"] as! String?{
//
//                            mapPassed5 = Int(mapPassed5String)!
//                            let userDefaults = UserDefaults.standard
//                            userDefaults.set(mapPassed5!, forKey: "mapPassed5")
//
//                            print("retrieve mapPassed:\(mapPassed5!)")
//
//                        }
//
//                        if let mapPassed6String = user?["mapPassed6"] as! String?{
//
//                            mapPassed6 = Int(mapPassed6String)!
//                            let userDefaults = UserDefaults.standard
//                            userDefaults.set(mapPassed6!, forKey: "mapPassed6")
//
//                            print("retrieve mapPassed:\(mapPassed6!)")
//
//                        }
//
//                        if let mapPassed7String = user?["mapPassed7"] as! String?{
//
//                            mapPassed7 = Int(mapPassed7String)!
//                            let userDefaults = UserDefaults.standard
//                            userDefaults.set(mapPassed7!, forKey: "mapPassed7")
//
//                            print("retrieve mapPassed:\(mapPassed7!)")
//
//                        }
//
//                        if let mapPassed8String = user?["mapPassed8"] as! String?{
//
//                            mapPassed8 = Int(mapPassed8String)!
//                            let userDefaults = UserDefaults.standard
//                            userDefaults.set(mapPassed8!, forKey: "mapPassed8")
//
//                            print("retrieve mapPassed:\(mapPassed8!)")
//
//                        }
//
//                        if let mapPassed9String = user?["mapPassed9"] as! String?{
//
//                            mapPassed9 = Int(mapPassed9String)!
//                            let userDefaults = UserDefaults.standard
//                            userDefaults.set(mapPassed9!, forKey: "mapPassed9")
//
//                            print("retrieve mapPassed:\(mapPassed9!)")
//
//                        }
//
//
//
//
//                        if let gamePassedString = user?["gamePassed"] as! String?{
//
//                            let gamePassedStringArray = gamePassedString.components(separatedBy: ":")
//
//                            let s = gamePassedStringArray[0]
//                            let u = gamePassedStringArray[1]
//                            gamePassed = [Int(s)!:Int(u)!]
//
//                            let userDefaults = UserDefaults.standard
//                            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed!)
//
//                            print("retrieve gamePassed:\(gamePassed!)")
//                            userDefaults.set(encodedObject, forKey: "gamePassed")
//
//                        }
//
//                        if let gamePassed2String = user?["gamePassed2"] as! String?{
//
//                            let gamePassed2StringArray = gamePassed2String.components(separatedBy: ":")
//
//                            let s = gamePassed2StringArray[0]
//                            let u = gamePassed2StringArray[1]
//                            gamePassed2 = [Int(s)!:Int(u)!]
//
//                            let userDefaults = UserDefaults.standard
//                            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed2!)
//
//                            print("retrieve gamePassed:\(gamePassed2!)")
//                            userDefaults.set(encodedObject, forKey: "gamePassed2")
//
//                        }
//
//                        if let gamePassed3String = user?["gamePassed3"] as! String?{
//
//                            let gamePassed3StringArray = gamePassed3String.components(separatedBy: ":")
//
//                            let s = gamePassed3StringArray[0]
//                            let u = gamePassed3StringArray[1]
//                            gamePassed3 = [Int(s)!:Int(u)!]
//
//                            let userDefaults = UserDefaults.standard
//                            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed3!)
//
//                            print("retrieve gamePassed:\(gamePassed3!)")
//                            userDefaults.set(encodedObject, forKey: "gamePassed3")
//
//                        }
//
//
//                        if let gamePassed4String = user?["gamePassed4"] as! String?{
//
//                            let gamePassed4StringArray = gamePassed4String.components(separatedBy: ":")
//
//                            let s = gamePassed4StringArray[0]
//                            let u = gamePassed4StringArray[1]
//                            gamePassed4 = [Int(s)!:Int(u)!]
//
//                            let userDefaults = UserDefaults.standard
//                            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed4!)
//
//                            print("retrieve gamePassed:\(gamePassed4!)")
//                            userDefaults.set(encodedObject, forKey: "gamePassed4")
//
//                        }
//                        if let gamePassed5String = user?["gamePassed5"] as! String?{
//
//                            let gamePassed5StringArray = gamePassed5String.components(separatedBy: ":")
//
//                            let s = gamePassed5StringArray[0]
//                            let u = gamePassed5StringArray[1]
//                            gamePassed5 = [Int(s)!:Int(u)!]
//
//                            let userDefaults = UserDefaults.standard
//                            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed5!)
//
//                            print("retrieve gamePassed:\(gamePassed5!)")
//                            userDefaults.set(encodedObject, forKey: "gamePassed5")
//
//                        }
//
//
//                        if let gamePassed6String = user?["gamePassed6"] as! String?{
//
//                            let gamePassed6StringArray = gamePassed6String.components(separatedBy: ":")
//
//                            let s = gamePassed6StringArray[0]
//                            let u = gamePassed6StringArray[1]
//                            gamePassed6 = [Int(s)!:Int(u)!]
//
//                            let userDefaults = UserDefaults.standard
//                            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed6!)
//
//                            print("retrieve gamePassed:\(gamePassed6!)")
//                            userDefaults.set(encodedObject, forKey: "gamePassed6")
//
//                        }
//
//                        if let gamePassed7String = user?["gamePassed7"] as! String?{
//
//                            let gamePassed7StringArray = gamePassed7String.components(separatedBy: ":")
//
//                            let s = gamePassed7StringArray[0]
//                            let u = gamePassed7StringArray[1]
//                            gamePassed7 = [Int(s)!:Int(u)!]
//
//                            let userDefaults = UserDefaults.standard
//                            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed7!)
//
//                            print("retrieve gamePassed:\(gamePassed7!)")
//                            userDefaults.set(encodedObject, forKey: "gamePassed7")
//
//                        }
//
//                        if let gamePassed8String = user?["gamePassed8"] as! String?{
//
//                            let gamePassed8StringArray = gamePassed8String.components(separatedBy: ":")
//
//                            let s = gamePassed8StringArray[0]
//                            let u = gamePassed8StringArray[1]
//                            gamePassed8 = [Int(s)!:Int(u)!]
//
//                            let userDefaults = UserDefaults.standard
//                            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed8!)
//
//                            print("retrieve gamePassed:\(gamePassed8!)")
//                            userDefaults.set(encodedObject, forKey: "gamePassed8")
//
//                        }
//
//                        if let gamePassed9String = user?["gamePassed9"] as! String?{
//
//                            let gamePassed9StringArray = gamePassed9String.components(separatedBy: ":")
//
//                            let s = gamePassed9StringArray[0]
//                            let u = gamePassed9StringArray[1]
//                            gamePassed9 = [Int(s)!:Int(u)!]
//
//                            let userDefaults = UserDefaults.standard
//                            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed9!)
//
//                            print("retrieve gamePassed:\(gamePassed9!)")
//                            userDefaults.set(encodedObject, forKey: "gamePassed9")
//
//                        }
//
//
//
//                        print(user!)
//
//
//
//                        let id = user?["id"] as? String
//
//                        // successfully logged in
//                        if id != nil {
//
//                            DispatchQueue.main.async(execute: {
//                                print("successfully logged in")
//
//                                self!.activityIndicator.stopAnimating()
//                                UIApplication.shared.endIgnoringInteractionEvents()
//
//
//                                if self!.isFromCourse{
//
//                                    self!.dismiss(animated: true, completion: nil)
//
//                                } else {
//
//                                    self!.toCourses()
//                                }
//                            })
//
//
//                        } else {
//
//                            // 抓錯誤訊息
//                            DispatchQueue.main.async(execute: {
//
//                                self!.activityIndicator.stopAnimating()
//                                UIApplication.shared.endIgnoringInteractionEvents()
//
//                                if let errorStatus = parseJSON["status"] as? String{
//
//                                    if errorStatus == "403"{
//
//                                        self?.usernameTxt.text = ""
//                                        self?.passwordTxt.text = ""
//                                        self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "帳號不存在，請再試一次", attributes: self!.attrs)
//                                        self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: self!.attrs)
//
//
//                                    } else if errorStatus == "401"{
//
//                                        self?.usernameTxt.text = ""
//                                        self?.passwordTxt.text = ""
//                                        self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "密碼不正確，請再試一次", attributes: self!.attrs)
//                                        self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: self!.attrs)
//
//
//                                    }
//
//
//                                }
//                            })
//                            return
//
//                        }
//
//                    } catch {
//
//                        // get main queue to communicate back to user
//                        DispatchQueue.main.async(execute: {
//
//                            self!.activityIndicator.stopAnimating()
//                            UIApplication.shared.endIgnoringInteractionEvents()
//
//
//                            self?.usernameTxt.text = ""
//                            self?.passwordTxt.text = ""
//                            self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "登入錯誤，請再試一次", attributes: self!.attrs)
//                            self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: self!.attrs)
//
//
//                        })
//                        return
//
//                    }
//
//                } else {
//
//                    // get main queue to communicate back to user
//                    DispatchQueue.main.async(execute: {
//
//                        self!.activityIndicator.stopAnimating()
//                        UIApplication.shared.endIgnoringInteractionEvents()
//
//                        let message = error!.localizedDescription
//                        print(message)
//                        self?.usernameTxt.text = ""
//                        self?.passwordTxt.text = ""
//                        self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "登入錯誤，請再試一次", attributes: self!.attrs)
//                        self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: self!.attrs)
//                    })
//                    return
//
//                }
//
//                }.resume()
//        }
//    }
    
}
