//
//  CoursesViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/2/21.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController {
    
    
    @IBOutlet weak var block0: UIImageView!
    @IBOutlet weak var block2: UIImageView!
    @IBOutlet weak var block0LBtn: UIButton!
    
    @IBOutlet weak var block0RBtn: UIButton!
    @IBOutlet weak var block1: UIImageView!
    
    @IBOutlet weak var block1LBtn: UIButton!
    
    @IBOutlet weak var block2RBtn: UIButton!
    @IBOutlet weak var block2LBtn: UIButton!
    @IBOutlet weak var block1RBtn: UIButton!
    
    
    @IBOutlet weak var block0WordCountLabel: UILabel!
    
    @IBOutlet weak var block1WordCountLabel: UILabel!
    
    @IBOutlet weak var block2WordCountLabel: UILabel!
    
   
    
    @IBOutlet weak var block0TitleImg: UIImageView!
    
    @IBOutlet weak var block1TitleImg: UIImageView!
    

  
    @IBOutlet weak var block2TitleImg: UIImageView!
    
    

    
    @IBOutlet weak var logOutBtn: UIButton!

 
 var courseSent = Int()
    
    
    
    //layOut
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    @IBOutlet weak var toInfoVcBtn: UIButton!
    

    
    var recommendedClass:String?
    
    @IBOutlet weak var sepLine0: UIImageView!
    
    @IBOutlet weak var sepLine1: UIImageView!
    
    
    @IBOutlet weak var sepLine2: UIImageView!
    

    
    @IBOutlet weak var bottomBg: UIImageView!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var unitLabel1: UILabel!
    
    @IBOutlet weak var unitLabel2: UILabel!
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        // Do any additional setup after loading the view.
        //print("coursesVC:\(user!)")
        
        
        
        var xPos = CGFloat()
        var iPadFix = CGFloat()
        var titleDif = CGFloat()
        var dif = CGFloat()
        var iPadDif = CGFloat()
        var wordCountX = CGFloat()
        var btnDif = CGFloat()
        var btnY = CGFloat()
        var iPadSmall = CGFloat()
        
        var fontSize = CGFloat()
        
        switch height {
            
        case 812:
            iPadFix = 1
            xPos = -22
            titleDif = 1
            dif = 1.15
            iPadDif = 1
            wordCountX = 1.03
            btnDif = 1
            btnY = -5
            fontSize = 60
            iPadSmall = 0
            
        case 736:
            
            iPadFix = 1
            xPos = 0
            titleDif = 1
            dif = 1.1
            iPadDif = 1
             wordCountX = 1
            btnDif = 1
            btnY = 0
            fontSize = 60
            iPadSmall = 0
            
        case 667:
            
            iPadFix = 1
            xPos = 0
            titleDif = 0.9
            dif = 1
            iPadDif = 1
             wordCountX = 1.03
            btnDif = 0.95
            btnY = 0
            fontSize = 60
            iPadSmall = 0
            
        case 568:
            iPadFix = 1
            xPos = 0
            titleDif = 0.8
            dif = 0.9
            iPadDif = 1
             wordCountX = 1.03
            btnDif = 0.8
            btnY = 0
            fontSize = 60
            iPadSmall = 0
            
        default:
            iPadFix = 0.8
            xPos = 0
            titleDif = 0.8
            dif = 0.9
            iPadDif = 0.9
             wordCountX = 1
            btnDif = 1
            btnY = 0
            
            fontSize = 40
            iPadSmall = 20
            
        }
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.layer.zPosition = 15
        let alphaGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.layer.cornerRadius = activityIndicator.frame.width / 20
        activityIndicator.backgroundColor = alphaGray
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.addSubview(activityIndicator)
        
        //這部分的顯示還沒安排位置
        var nickname = String()
        //測試用
        
        if user != nil {
            nickname = user?["username"] as! String
        } else {
            nickname = "新學生"
        }
        
        
        
        block0.frame = CGRect(x: xPos, y: 0, width: width, height: height / 4)
        block0.contentMode = .scaleAspectFill
        block1.frame = CGRect(x: xPos, y: height / 4, width: width, height: height / 4)
        block2.frame = CGRect(x: xPos, y: height / 2, width: width, height: height / 4)
       
        //新位置
        
        block0TitleImg.frame = CGRect(x: block0.frame.width / 26, y: height / 3.5 * iPadDif, width: 136 * titleDif * iPadFix * iPadFix, height: 94 * titleDif)
        

   
        
        
        //新位置
        block1TitleImg.frame = CGRect(x: block0.frame.width / 26, y: height / 2 , width: 136 * titleDif * iPadFix * iPadFix, height: 97 * titleDif)
        
        
        
        
        //新位置
        block2TitleImg.frame = CGRect(x: block0.frame.width / 40, y: height / 1.38
            * iPadDif + iPadSmall, width: 146 * titleDif * iPadFix * iPadFix, height: 92 * titleDif)

        
        //新位置
        block0LBtn.frame = CGRect(x: width / 2.5, y: block0TitleImg.frame.maxY * 0.95 - btnY - iPadSmall, width: 105 * btnDif * iPadDif, height: 35 * btnDif * iPadDif)
        block0RBtn.frame = CGRect(x: block0LBtn.frame.maxX + 10, y: block0LBtn.frame.minY, width: 105 * btnDif * iPadFix, height: 35 * btnDif * iPadDif)
        
        
    
        //新位置
        block1LBtn.frame = CGRect(x: width / 2.5, y: block1TitleImg.frame.maxY * 0.95 - btnY - iPadSmall, width: 105 * btnDif * iPadDif, height: 35 * btnDif * iPadDif)
        
     
        //新位置
        block1RBtn.frame = CGRect(x: block1LBtn.frame.maxX + 10, y: block1LBtn.frame.minY, width: 105 * btnDif * iPadFix, height: 35 * btnDif * iPadDif)
        
   
        
        //新位置
       block2LBtn.frame = CGRect(x: width / 2.5, y: block2TitleImg.frame.maxY * 0.97 - btnY - iPadSmall, width: 105 * btnDif * iPadDif, height: 35 * btnDif * iPadDif)
        
   
        block2RBtn.frame = CGRect(x: block2LBtn.frame.maxX + 10, y: block2LBtn.frame.minY, width: 105 * btnDif * iPadFix, height: 35 * btnDif * iPadDif)
  
        //新位置
        
        bottomBg.frame = CGRect(x: 0, y: height - 80 * dif * btnDif, width: width, height: 80 * dif)
       
        
        toInfoVcBtn.frame = CGRect(x: width / 7 , y: bottomBg.frame.minY + 5, width: 37 * dif, height: 48 * dif)
        
        toInfoVcBtn.center = CGPoint(x: width / 6, y: bottomBg.frame.midY - 4)
     
        
        toChartVcBtn.frame = CGRect(x: width * 3 / 7, y: bottomBg.frame.minY + 3, width: 43 * dif, height: 49 * dif)
        toChartVcBtn.center = CGPoint(x: width / 2, y: bottomBg.frame.midY - 5)
     
        
        toShopVcBtn.frame = CGRect(x: width * 5 / 7, y: bottomBg.frame.minY + 5, width: 43 * dif, height: 43 * dif)

        toShopVcBtn.center = CGPoint(x: width * 5 / 6, y: bottomBg.frame.midY - 4)
        
        toInfoLabel.center = CGPoint(x: toInfoVcBtn.frame.midX, y: toInfoVcBtn.frame.maxY + 15)
        toChartLabel.center = CGPoint(x: toChartVcBtn.frame.midX, y: toInfoLabel.frame.midY)
        toShopLabel.center = CGPoint(x: toShopVcBtn.frame.midX, y: toInfoLabel.frame.midY)
        
        toInfoLabel.isHidden = true
        toChartLabel.isHidden = true
        toShopLabel.isHidden = true
        
        hiddenInfoBtn.frame = toInfoLabel.frame
        hiddenInfoBtn.addTarget(self, action: #selector(CoursesViewController.toInfoVcClicked(_:)), for: .touchUpInside)
        self.view.addSubview(hiddenInfoBtn)
        
        hiddenChartBtn.frame = toChartLabel.frame
        hiddenChartBtn.addTarget(self, action: #selector(CoursesViewController.toChartVcBtnClicked(_:)), for: .touchUpInside)
        self.view.addSubview(hiddenChartBtn)
        
        hiddenShopBtn.frame = toShopLabel.frame
        hiddenShopBtn.addTarget(self, action: #selector(CoursesViewController.toShopVcBtnClicked(_:)), for: .touchUpInside)
        self.view.addSubview(hiddenShopBtn)
        
        
        
        logOutBtn.frame = CGRect(x: width / 18, y: height / 24, width: 30 * dif * iPadDif, height: 21 * dif * iPadDif)
        
      
        
        block0WordCountLabel.font = block0WordCountLabel.font.withSize(fontSize)
        block0WordCountLabel.adjustsFontSizeToFitWidth = true

        //新位置
        block0WordCountLabel.frame = CGRect(x: width * 2 / 3 * 0.85, y: block0TitleImg.frame.minY * 1.05, width: width / 2.8, height: block0.frame.height / 3 * iPadDif)
        
        
      
        //新位置
          block1WordCountLabel.font = block1WordCountLabel.font.withSize(fontSize)
        block1WordCountLabel.frame = CGRect(x: width * 2 / 3 * 0.85, y: block1TitleImg.frame.minY * 1.02, width: width / 2.8, height: block0.frame.height / 3 * iPadDif)

        block1WordCountLabel.adjustsFontSizeToFitWidth = true
       
     
         block2WordCountLabel.font = block2WordCountLabel.font.withSize(fontSize)
        block2WordCountLabel.adjustsFontSizeToFitWidth = true
        //新位置
         block2WordCountLabel.frame = CGRect(x: width * 2 / 3 * 0.85, y: block2TitleImg.frame.minY, width: width / 2.8, height: block0.frame.height / 3 * iPadDif)
        
        
        unitLabel.frame = CGRect(x: block0WordCountLabel.frame.maxX * 0.98 * wordCountX, y: block0WordCountLabel.frame.maxY - 20, width: 14, height: 20)
        
                unitLabel1.frame = CGRect(x: block1WordCountLabel.frame.maxX * 0.98 * wordCountX, y: block1WordCountLabel.frame.maxY - 20, width: 14, height: 20)
                unitLabel2.frame = CGRect(x: block2WordCountLabel.frame.maxX * 0.98 * wordCountX
                    , y: block2WordCountLabel.frame.maxY - 20, width: 14, height: 20)
        
        
        // Do any additional setup after loading the view.
        

      
        
        sepLine0.frame = CGRect(x: 0, y: height / 4.2, width: width, height: 1)
        sepLine1.frame = CGRect(x: 0, y: height / 2.2, width: width, height: 1)
        sepLine2.frame = CGRect(x: 0, y: height / 1.5, width: width, height: 1)
        

        
        bigNameLabel.frame = CGRect(x: logOutBtn.frame.minX, y: logOutBtn.frame.maxY * 1.5 * titleDif * titleDif, width:  190 * iPadFix, height: 42 * iPadFix)


        bigNameLabel.adjustsFontSizeToFitWidth = true
        userStatusLabel.frame = CGRect(x: bigNameLabel.frame.minX, y: bigNameLabel.frame.maxY, width: 190 * iPadFix, height: 55 * iPadFix)
     
        dayTitleLabel.frame = CGRect(x: block0WordCountLabel.frame.minX * titleDif, y: bigNameLabel.frame.midY - 3, width: 160 * iPadFix, height: 25 * iPadFix)
     
        daysLabel.frame = CGRect(x: block0WordCountLabel.frame.minX * titleDif, y: dayTitleLabel.frame.maxY, width: 160 * iPadFix, height: 55 * iPadFix)
    
        daysLabel.adjustsFontSizeToFitWidth = true
        
        bigNameLabel.text = ""
        userStatusLabel.text = "免費用戶\n新課程：每天7分鐘\n單字集/挑戰模式：不限時間"
        userStatusLabel.adjustsFontSizeToFitWidth = true
        
        dayTitleLabel.text = "學習天數"
        daysLabel.text = ""
        
        
        //稍稍靠右邊
        logoImg.center = CGPoint(x: width / 2 + 5, y: height / 8)
        logoImg.frame.size = CGSize(width: 135 * dif * iPadFix, height: 131 * dif * iPadFix)


       
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
                
            default:
                break
                
                
            }
            
            finger.frame = CGRect(x: posX, y: posY, width: 67, height: 88)
     
            point.center = CGPoint(x: finger.frame.midX, y: finger.frame.minY)
            point.frame.size = CGSize(width: 45, height: 45)
          
            
            fingerAnimation()
           
        
        }
    }
    
    

    
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
        performSegue(withIdentifier: "toChartVc", sender: self)

    }
    @IBAction func toShopVcBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "toShopVc", sender: self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
    
        
        finger.alpha = 0
        point.alpha = 0
       
        
         var nickname = String()
         var purchaseStatus = String()
         //測試用
         
         if user != nil {
            
         nickname = user?["nickname"] as! String
            
         let isPurchased = user?["isPurchased"] as? String
            
            if isPurchased == "0"{
                
                purchaseStatus = "免費用戶\n新課程：每天7分鐘\n單字集/挑戰模式：不限時間"
            } else if isPurchased == "1"{
                
                purchaseStatus = "付費用戶\n新課程：不限時間\n單字集/挑戰模式：不限時間"
            }
            
            
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
            purchaseStatus = "免費用戶\n新課程：每天7分鐘\n單字集/挑戰模式：不限時間"
            daysLabel.text = "0"
            
         }


        bigNameLabel.text = "Hi!" + nickname
        userStatusLabel.text = purchaseStatus
        
        if isRegistered == false{
            
            logOutBtn.isHidden = true
        } else {
            
            logOutBtn.isHidden = false
        }
       
        
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
        
        performSegue(withIdentifier: "toInfoVc", sender: self)
    }
    
    
    
    @IBAction func logOutClicked(_ sender: Any) {
        
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
