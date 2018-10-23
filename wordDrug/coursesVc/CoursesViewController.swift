//
//  CoursesViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/2/21.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit



class CoursesViewController: UIViewController, CourseTableViewCellDelegate, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var block0LBtn: UIButton!
    
    @IBOutlet weak var block0RBtn: UIButton!
    
    @IBOutlet weak var block1LBtn: UIButton!
    
    @IBOutlet weak var block2RBtn: UIButton!
    @IBOutlet weak var block2LBtn: UIButton!
    @IBOutlet weak var block1RBtn: UIButton!
    
    @IBOutlet weak var logOutBtn: UIButton!
 
    var courseSent = Int()
    
    //layOut
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    @IBOutlet weak var toInfoVcBtn: UIButton!

    var recommendedClass:String?

    @IBOutlet weak var toChartVcBtn: UIButton!
    
    @IBOutlet weak var toInfoLabel: UILabel!
    
    @IBOutlet weak var toShopLabel: UILabel!
    @IBOutlet weak var toChartLabel: UILabel!
    @IBOutlet weak var toShopVcBtn: UIButton!
    
    var hiddenInfoBtn = UIButton()
    var hiddenChartBtn = UIButton()
    var hiddenShopBtn = UIButton()
    
    //從loginVc過來的變數暫時保留, 以後可以做歡迎畫面
    var isWelcome = false
    
    @IBOutlet weak var bigNameLabel: UILabel!
    
    @IBOutlet weak var dayTitleLabel: UILabel!
    @IBOutlet weak var userStatusLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBOutlet weak var finger: UIImageView!
    
    @IBOutlet weak var point: UIImageView!
    
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
            
        case 1366, 1336, 1112:
            print("iPad pro 2nd generation")
    
            dif = 1
            iPadDif = 2
    
            bigNameFontSize = 60
            dynamicCellHeight = 250
            logOutBtnLabelFontSize = 30
            dayFontSize = 100
            dayTitleFontSize = 24
            statusFontSize = 24
 
        case 1024:
            print("9.7 iPad or 7.9 iPad mini, iPad(5th), iPad air, iPad air 2")
        
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
        
        
        //MARK: UI Setting
        
        //登出鍵 & 登入按鍵
  
        logoImg.anchor(top: view.safeTopAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: width / 2 - (135 * dif * iPadDif) / 2, bottom: 0, right: 0), size: .init(width: 135 * dif * iPadDif, height: 131 * dif * iPadDif))
        
        logOutBtn.backgroundColor = #colorLiteral(red: 0.9389395118, green: 0.3498239517, blue: 0.1933075488, alpha: 1)
        logOutBtn.titleLabel?.font = logOutBtn.titleLabel?.font.withSize(logOutBtnLabelFontSize)
        logOutBtn.anchor(top: view.safeTopAnchor, leading: nil, bottom: nil, trailing: view.safeRightAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: -10), size: .init(width: 50 * iPadDif * dif, height: 22 * iPadDif * dif))
        logOutBtn.layer.cornerRadius = 50 * iPadDif * dif / 15
        
        
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

        

        toInfoVcBtn.frame = CGRect(x: width / 6 - (27 * dif * iPadDif) / 2, y: height - 44 * dif * iPadDif, width: 27 * dif * iPadDif, height: 36 * dif * iPadDif)
       
        
        toChartVcBtn.frame = CGRect(x: width / 2 - (32 * dif * iPadDif) / 2, y: height - 44 * dif * iPadDif, width: 32 * dif * iPadDif, height: 36 * dif * iPadDif)
    
        
        
        toShopVcBtn.frame = CGRect(x: width * 5 / 6 - (32 * dif * iPadDif) / 2, y: height - 40 * dif * iPadDif, width: 32 * dif * iPadDif, height: 32 * dif * iPadDif)

 
        
        toInfoLabel.center = CGPoint(x: toInfoVcBtn.frame.midX, y: toInfoVcBtn.frame.maxY + 15)
        toChartLabel.center = CGPoint(x: toChartVcBtn.frame.midX, y: toInfoLabel.frame.midY)
        toShopLabel.center = CGPoint(x: toShopVcBtn.frame.midX, y: toInfoLabel.frame.midY)
        
        toInfoLabel.isHidden = true
        toChartLabel.isHidden = true
        toShopLabel.isHidden = true
        
        let btnColumn = UIView()
        btnColumn.backgroundColor = .darkGray
        self.view.addSubview(btnColumn)
        btnColumn.anchor(top: courseTableView.bottomAnchor, leading: view.safeLeftAnchor, bottom: view.bottomAnchor, trailing: nil, padding: .init(top: 0, left: width / 3, bottom: 0, right: 0), size: .init(width: 1, height: 50 * iPadDif * dif))
        
        let btnColumn1 = UIView()
        btnColumn1.backgroundColor = .darkGray
        self.view.addSubview(btnColumn1)
        btnColumn1.anchor(top: courseTableView.bottomAnchor, leading: view.safeLeftAnchor, bottom: view.bottomAnchor, trailing: nil, padding: .init(top: 0, left: width / 3 * 2, bottom: 0, right: 0))
        btnColumn1.anchorSize(to: btnColumn)
        
   
        hiddenInfoBtn.addTarget(self, action: #selector(CoursesViewController.toInfoVcClicked(_:)), for: .touchUpInside)
        self.view.addSubview(hiddenInfoBtn)
        
        hiddenInfoBtn.anchor(top: courseTableView.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing:nil, size: .init(width: width / 3, height: 50 * iPadDif * dif))
        
   
        hiddenChartBtn.addTarget(self, action: #selector(CoursesViewController.toChartVcBtnClicked(_:)), for: .touchUpInside)
        self.view.addSubview(hiddenChartBtn)
        hiddenChartBtn.anchor(top: courseTableView.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: width / 3, bottom: 0, right: 0))
        hiddenChartBtn.anchorSize(to: hiddenInfoBtn)
        
        
   
        hiddenShopBtn.addTarget(self, action: #selector(CoursesViewController.toShopVcBtnClicked(_:)), for: .touchUpInside)
        self.view.addSubview(hiddenShopBtn)
        hiddenShopBtn.anchor(top: courseTableView.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: width / 3 * 2, bottom: 0, right: 0))
        hiddenShopBtn.anchorSize(to: hiddenInfoBtn)

        
        
        
        self.view.bringSubview(toFront: toInfoVcBtn)
        self.view.bringSubview(toFront: toShopVcBtn)
        self.view.bringSubview(toFront: toChartVcBtn)

        bigNameLabel.text = ""
        userStatusLabel.text = "免費用戶\n新課程：每天7分鐘\n單字集/挑戰模式：不限時間"
        userStatusLabel.adjustsFontSizeToFitWidth = true
        
        dayTitleLabel.text = "學習天數"
        daysLabel.text = ""
        daysLabel.adjustsFontSizeToFitWidth = true
    

        /*
        
        if recommendedClass != nil {
        
            //假如尚未註冊者, 就是開始引導
            
            var posX = CGFloat()
            var posY = CGFloat()
         
            // recommendedClass = "英檢初級"
            
            switch recommendedClass{
                
            case "英檢初級":
                print("初級")
                posX = block0LBtn.frame.minX
                posY = block0LBtn.frame.midY
         
            case "英檢中級":
                print("中級")
                posX = block1LBtn.frame.minX
                posY = block1LBtn.frame.midY
         
            case "多益滿分":
                print("多益")
                posX = block2LBtn.frame.minX
                posY = block2LBtn.frame.midY
         
            case "雅思IELTS":
                print("多益")
                posX = block2LBtn.frame.minX
                posY = block2LBtn.frame.midY
            
   
            default:
                break
                
                
            }
            
            finger.frame = CGRect(x: posX, y: posY, width: 67, height: 88)
     
            point.center = CGPoint(x: finger.frame.midX, y: finger.frame.minY)
            point.frame.size = CGSize(width: 45, height: 45)
          
            
            fingerAnimation()
           
        
        }
 */
    }
    
    
    //用不到
    func fingerAnimation(){
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveLinear, animations: {[weak self] in
            
            self!.finger.alpha = 1
            self!.point.alpha = 1
       
        
        }) { (finished:Bool) in
            
            if finished {
                
                UIView.animate(withDuration: 0.6, animations: {[weak self] in
                 
                    self!.point.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                    self!.point.alpha = 0
                }, completion: {[weak self] (finished:Bool) in
                    
          
                    self!.point.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self!.point.alpha = 1
                    
                    UIView.animate(withDuration: 0.6, animations: {[weak self] in
                        self!.point.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                        self!.point.alpha = 0
                        self!.finger.alpha = 0
                        }, completion: {[weak self] (finished:Bool) in

                            self!.point.transform = CGAffineTransform(scaleX: 1, y: 1)
                            
 
                           
                            self!.repeatTimes += 1
                            
                            
                            //重複5次
                            if self!.repeatTimes < 6{
                             self!.fingerAnimation()
                            }
                            
                    
                    })
               
                })
       
            }

            
        }
        
        
        
    }
    
    
    //MARK: TableView delegate
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        //MARK: must update
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        return dynamicCellHeight
    }
    
    func didTapEnterClass(indexPath: IndexPath) {
        print("enter class: \(indexPath.row)")
        
        courseSent = indexPath.row
        performSegue(withIdentifier: "toStageVc", sender: self)
        
    }
    
    func didTapEnterBook(indexPath: IndexPath) {
        print("enter book: \(indexPath.row)")
        
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
        let titleImg = ["block0Title","block1Title","block2Title","block3Title", "block4Title"]
        let wordCounts = [2250,2700, 3150, 4050, 3600]

        cell.wordCountOutlet.text = "\(wordCounts[indexPath.row])"
        cell.courseTitleImg.image = UIImage(named: titleImg[indexPath.row] + ".png")
        cell.courseTitleImg.contentMode = .scaleAspectFill
        cell.generateCell(indexPath: indexPath)
        cell.backgroundColor = .clear
        
        
        
        cell.delegate = self
        return cell
    }
    

    
    override func viewWillDisappear(_ animated: Bool) {
        

        finger.alpha = 0
        point.alpha = 0
        
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
    
    @IBAction func toChartVcBtnClicked(_ sender: Any) {
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        performSegue(withIdentifier: "toChartVc", sender: self)

    }
    @IBAction func toShopVcBtnClicked(_ sender: Any) {
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        performSegue(withIdentifier: "toShopVc", sender: self)
    }
    
    @IBAction func toLoginVcBtnClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "fromCourseToLogin", sender: self)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
    
        
        finger.alpha = 0
        point.alpha = 0
       
        
         var nickname = String()
         var purchaseStatus = String()
         //測試用
        
    
        let isPurchased = UserDefaults.standard.object(forKey: "isPurchased") as! Bool
        
        if isPurchased{
            //買了
            purchaseStatus = "付費用戶\n新課程：不限時間\n單字集/挑戰模式：不限時間"
        } else {
            //還沒買
            purchaseStatus = "免費用戶\n新課程：每天7分鐘\n單字集/挑戰模式：不限時間"
            
        }
        
        
         if user != nil {
            
         nickname = user?["nickname"] as! String
            

            /*
         let isPurchased = user?["isPurchased"] as? String
            
            if isPurchased == "0"{
                
                purchaseStatus = "免費用戶\n新課程：每天7分鐘\n單字集/挑戰模式：不限時間"
            } else if isPurchased == "1"{
                
                purchaseStatus = "付費用戶\n新課程：不限時間\n單字集/挑戰模式：不限時間"
            }
            */
            
            //計算天數
            let startDateString = user?["date"] as! String
            let startDate = startDateString.components(separatedBy: " ")
            let start = dateFormatter.date(from: startDate[0])
            let todayString = Date()
            let today = dateFormatter.string(from: todayString)
         
            
            let todayDate = dateFormatter.date(from: today)
            
            
            let days = daysBetween(start: start!, end: todayDate!)

            daysLabel.text = String(days)
            
            
         } else {
            
         nickname = "新學生"
            //purchaseStatus = "免費用戶\n新課程：每天7分鐘\n單字集/挑戰模式：不限時間"
            daysLabel.text = "0"
            
            toLoginVcBtn.isHidden = false
         }


        bigNameLabel.text = "Hi!" + nickname
        userStatusLabel.text = purchaseStatus
        
        if isRegistered == false{
            
            logOutBtn.isHidden = true
              toLoginVcBtn.isHidden = false
        } else {
            
            logOutBtn.isHidden = false
              toLoginVcBtn.isHidden = true
        }
       
        //MARK: must update
        
        //抓gamePassed
        let decodedObject = UserDefaults.standard.object(forKey: "gamePassed") as? NSData
        
        if let decoded = decodedObject {
            gamePassed = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int : Int]
        }
        //抓mapPassed
        mapPassed = UserDefaults.standard.object(forKey: "mapPassed") as? Int
        
        
        
        //抓gamePassed2
        let decodedObject2 = UserDefaults.standard.object(forKey: "gamePassed2") as? NSData
        
        if let decoded = decodedObject2 {
            gamePassed2 = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int : Int]
        }
        
        //抓mapPassed2
        mapPassed2 = UserDefaults.standard.object(forKey: "mapPassed2") as? Int
        
        //抓gamePassed3
        let decodedObject3 = UserDefaults.standard.object(forKey: "gamePassed3") as? NSData
        
        if let decoded = decodedObject3 {
            gamePassed3 = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int : Int]
        }
        
        //抓mapPassed3
        mapPassed3 = UserDefaults.standard.object(forKey: "mapPassed3") as? Int
        
        //抓gamePassed4
        let decodedObject4 = UserDefaults.standard.object(forKey: "gamePassed4") as? NSData
        
        if let decoded = decodedObject4 {
            gamePassed4 = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int : Int]
        }
        
        //抓mapPassed4
        mapPassed4 = UserDefaults.standard.object(forKey: "mapPassed4") as? Int
        
        
        //抓gamePassed5
        let decodedObject5 = UserDefaults.standard.object(forKey: "gamePassed5") as? NSData
        
        if let decoded = decodedObject5 {
            gamePassed5 = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int : Int]
        }
        
        //抓mapPassed5
        mapPassed5 = UserDefaults.standard.object(forKey: "mapPassed5") as? Int

        
        
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func elementaryClicked(_ sender: Any) {
        courseSent = 0
        performSegue(withIdentifier: "toStageVc", sender: self)
    }
    
    @IBAction func intermedaiteClicked(_ sender: Any) {
        courseSent = 1
        performSegue(withIdentifier: "toStageVc", sender: self)
        
    }
    
    @IBAction func toeicClicked(_ sender: Any) {
        courseSent = 2
        performSegue(withIdentifier: "toStageVc", sender: self)
        
    }
  
    
    @IBAction func toNewBookBtn(_ sender: Any) {
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        let time = DispatchTime.now() + 0.1
        DispatchQueue.main.asyncAfter(deadline: time) {[weak self] in
            self!.courseSent = 0
            self!.performSegue(withIdentifier: "toNewBookVc", sender: self)
        }
        
 
    }
    
    
    deinit {
        print("course deinit")
    }
    
    
    @IBAction func toNewBook2Btn(_ sender: Any) {
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        let time = DispatchTime.now() + 0.1
        DispatchQueue.main.asyncAfter(deadline: time) {[weak self] in
            self!.courseSent = 1
            self!.performSegue(withIdentifier: "toNewBookVc", sender: self)
        }
        
        
    }
    @IBAction func toNewBook3Btn(_ sender: Any) {
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        let time = DispatchTime.now() + 0.1
        DispatchQueue.main.asyncAfter(deadline: time) {[weak self] in
            self!.courseSent = 2
            self!.performSegue(withIdentifier: "toNewBookVc", sender: self)
        }
    }
    
    @IBAction func toInfoVcClicked(_ sender: Any) {
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        performSegue(withIdentifier: "toInfoVc", sender: self)
    }
    
    
    
    @IBAction func logOutClicked(_ sender: Any) {
        
        user = nil
        UserDefaults.standard.removeObject(forKey: "parseJSON")
        
        /*
        UserDefaults.standard.removeObject(forKey: "mapPassed")
        UserDefaults.standard.removeObject(forKey: "gamePassed")
        UserDefaults.standard.removeObject(forKey: "mapPassed2")
        UserDefaults.standard.removeObject(forKey: "gamePassed2")
        UserDefaults.standard.removeObject(forKey: "mapPassed3")
        UserDefaults.standard.removeObject(forKey: "gamePassed3")
 */
        //UserDefaults.standard.removeObject(forKey: "isIntroWatched")
        //UserDefaults.standard.removeObject(forKey: "isRegistered")
        //UserDefaults.standard.removeObject(forKey: "previousDate")
        //UserDefaults.standard.removeObject(forKey: "limitSeconds")
        

        
        let loginVc = storyboard?.instantiateViewController(withIdentifier: "loginVc")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginVc!
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "toNewBookVc"{
            
            let destinationVc = segue.destination as! NewBookViewController
            
            //之後這裡要傳送的是課程名稱
            destinationVc.courseReceived = courseSent
            
            
        }
        
        
        if segue.identifier == "toStageVc"{
            
            let destinationVc = segue.destination as! StageViewController
            
            destinationVc.courseReceived = courseSent
        }
        
        
        if segue.identifier == "fromCourseToLogin"{
            
            let destinationVc = segue.destination as! LoginViewController
            
            destinationVc.isFromCourse = true
            
        }
        
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
