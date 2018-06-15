//
//  RegisterViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/6/4.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore


class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var registerBg: UIImageView!
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var doubleLine: UIImageView!
    @IBOutlet weak var star: UIImageView!
    
    @IBOutlet weak var freeTilted: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    let grassGreen = UIColor.init(red: 179/255, green: 1, blue: 60/255, alpha: 1)
    let darkTextColor = UIColor.init(red: 39/255, green: 48/255, blue: 86/255, alpha: 1)
    
    @IBOutlet weak var accountPng: UIImageView!
    
    @IBOutlet weak var passwordPng: UIImageView!
    
    @IBOutlet weak var accountTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let lightPurple = UIColor.init(red: 173/255, green: 124/255, blue: 158/255, alpha: 1)
    
    let darkPurple = UIColor.init(red: 75/255, green: 52/255, blue: 82/255, alpha: 1)
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    
    @IBOutlet weak var orLabel: UILabel!
    
    @IBOutlet weak var doubleLine2: UIImageView!
    
    @IBOutlet weak var alarmClock: UIImageView!
    
    @IBOutlet weak var freePng: UIImageView!
    
    @IBOutlet weak var freePng2: UIImageView!
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var textLabel2: UILabel!
    
    @IBOutlet weak var textLabel3: UILabel!
    
    var coursePlayed = Int()
    
    var isDirectedHere = false
    
    var wrongWordsToAdd = [String]()
    var scoresToAdd = Int()
    var proRateToAdd = Int()
    var senRateToAdd = Int()
    var wrongChineseCount = Int()
    var text = String()
    
    var myWrongWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        switch height {
        case 812:
            
            
            text = "複習挑戰模式。"
            
            
        case 736:
            
            text = "複習挑戰模式。"
           
            
        case 667:
            
            text = "複習挑戰模式。"
   
            
        case 568:
            
            
            text = "單字本及複習挑戰模式。"
        
        default:
            text = "複習挑戰模式。"
          
            
        }
        
        registerBg.frame = CGRect(x: 0, y: 0, width: width, height: height)
        registerBg.image = UIImage(named: "newRegisterBg.png")
        registerBg.contentMode = .scaleToFill
        
        titleLabel.frame = CGRect(x: 0, y: height / 11, width: width, height: 98)
        titleLabel.font = UIFont(name: "Helvetica Bold", size: 30)
        titleLabel.textColor = .white
        titleLabel.text = "註冊帳號\n繼續免費學習"
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        if isDirectedHere{
            
            titleLabel.text = "註冊帳號完後\n即可購買無限學習時間"
        }
        
        /*
        freeTilted.frame = CGRect(x: width / 7, y: height / 14, width: 55, height: 53)
        freeTilted.image = UIImage(named: "freeTiltedPng.png")
        freeTilted.contentMode = .scaleAspectFit
        */
        /*
        star.frame = CGRect(x: width * 5 / 7, y: height / 10, width: 22, height: 22)
        star.image = UIImage(named: "starPng.png")
        star.contentMode = .scaleAspectFit
        */
        doubleLine.frame = CGRect(x: (width - 290) / 2, y: titleLabel.frame.maxY, width: 290, height: 6)
        doubleLine.image = UIImage(named: "doubleLine.png")
        doubleLine.contentMode = .scaleAspectFit
        
        subTitleLabel.text = "英檢初級，中級，多益滿分等\n所有單字任你學習！"
        subTitleLabel.frame = CGRect(x: 0, y: doubleLine.frame.maxY + 10, width: width, height: 50)
        subTitleLabel.font = UIFont(name: "Helvetica Bold", size: 18)
        subTitleLabel.textAlignment = .center
        subTitleLabel.numberOfLines = 0
        
        accountPng.frame = CGRect(x: (width - 302) / 2, y: subTitleLabel.frame.maxY + 10, width: 302, height: 42)
        
        accountPng.image = UIImage(named: "newAccountPng.png")
        
        passwordPng.frame = CGRect(x: accountPng.frame.minX, y: accountPng.frame.maxY + 10, width: 302, height: 42)
        passwordPng.image = UIImage(named: "newPasswordPng.png")
        
        accountTextField.frame = CGRect(x: accountPng.frame.minX + accountPng.frame.width / 7, y: accountPng.frame.minY, width: accountPng.frame.width * 4 / 5, height: accountPng.frame.height)
        
        
        accountTextField.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上帳號", attributes: [NSAttributedStringKey.foregroundColor: darkTextColor])
        
        
        passwordTextField.frame = CGRect(x: accountTextField.frame.minX, y: passwordPng.frame.minY, width:
            accountTextField.frame.width, height: passwordPng.frame.height)
        
        
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上密碼", attributes: [NSAttributedStringKey.foregroundColor: darkTextColor])
        
        accountTextField.delegate = self
        passwordTextField.delegate = self
        
        registerBtn.frame = CGRect(x: passwordPng.frame.minX, y: passwordPng.frame.maxY + 10, width: 138, height: 35)
        
        
        loginBtn.frame = CGRect(x: passwordPng.frame.maxX - 142, y: registerBtn.frame.minY, width: 142, height: 35)
        
        facebookBtn.frame = CGRect(x: passwordPng.frame.minX, y: registerBtn.frame.maxY * 1.02, width: passwordPng.frame.width, height: 35)
        
        
        //orLabel.frame = CGRect(x: width / 2 - 13, y: registerBtn.frame.minY + 11, width: 26, height: 22)
        orLabel.center = CGPoint(x: width / 2, y: registerBtn.frame.midY - 2)
        
        orLabel.frame.size = CGSize(width: 26, height: 22)
        
        //orLabel.backgroundColor = .gray
        
        
        doubleLine2.frame = CGRect(x: doubleLine.frame.minX, y: facebookBtn.frame.maxY + 5, width: doubleLine.frame.width, height: doubleLine.frame.height)
        doubleLine2.image = UIImage(named: "doubleLine.png")
               doubleLine2.contentMode = .scaleAspectFit
        
        alarmClock.frame = CGRect(x: doubleLine2.frame.minX, y: doubleLine2.frame.maxY + (height - (doubleLine2.frame.maxY)) / 7, width: 30, height: 30)
        
        alarmClock.contentMode = .scaleAspectFit
        
        freePng.frame = CGRect(x: alarmClock.frame.minX, y: alarmClock.frame.maxY + alarmClock.frame.height * 2, width: 35, height: 35)

        freePng.contentMode = .scaleAspectFit
        
        
        freePng2.frame = CGRect(x: alarmClock.frame.minX, y: freePng.frame.maxY + alarmClock.frame.height * 1.5, width: 35, height: 35)
        
        freePng2.contentMode = .scaleAspectFit
        
        
        //字型顏色
        let attrs0 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedStringKey.foregroundColor : UIColor.white]
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedStringKey.foregroundColor : grassGreen]
        let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 12), NSAttributedStringKey.foregroundColor : grassGreen]
        
        
        textLabel.frame = CGRect(x: alarmClock.frame.maxX + 10, y: alarmClock.frame.minY - 15, width: 256, height: 84)
        
        //textLabel.backgroundColor = .red
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 3
        var textContent = NSMutableAttributedString()
        let textLabeltext1 = NSMutableAttributedString(string: "每日免費7分鐘，學習9個新單字", attributes: attrs1)
        let textLabelText2 = NSMutableAttributedString(string: "聽說拼讀一把罩！", attributes: attrs0)
        let textLabelText3 = NSMutableAttributedString(string: "*可至購物商城購買無限學習時間", attributes: attrs2)
        textLabel.adjustsFontSizeToFitWidth = true
        textContent.append(textLabeltext1)
        textContent.append(NSAttributedString(string: "\n"))
        textContent.append(textLabelText2)
        textContent.append(NSAttributedString(string: "\n"))
        textContent.append(textLabelText3)
        
        
        textLabel.attributedText = textContent
        
        textLabel2.frame = CGRect(x: textLabel.frame.minX, y: textLabel.frame.maxY + 13, width: textLabel.frame.width, height: 53)
        //textLabel2.backgroundColor = .blue
        textLabel2.textAlignment = .left
        textLabel2.adjustsFontSizeToFitWidth = true
        let textContent2 = NSMutableAttributedString()
        let textLabel2Text = NSMutableAttributedString(string: "無限時間", attributes: attrs1)
        let textLabel2Text2 = NSMutableAttributedString(string: text, attributes: attrs0)
        textContent2.append(textLabel2Text)
        textContent2.append(textLabel2Text2)
        textLabel2.attributedText = textContent2

        textLabel3.frame = CGRect(x: textLabel.frame.minX, y: textLabel2.frame.maxY + 20, width: textLabel.frame.width, height: 53)
        //textLabel3.backgroundColor = .green
        textLabel3.textAlignment = .left
        
        
        let textContent3 = NSMutableAttributedString()
        let textLabel3Text = NSMutableAttributedString(string: "無限時間", attributes: attrs1)
        let textLabel3Text2 = NSMutableAttributedString(string: "單字本聽力複習。", attributes: attrs0)
        textContent3.append(textLabel3Text)
        textContent3.append(textLabel3Text2)
        textLabel3.attributedText = textContent3

        
        
        print("user:\(user)")
        
        
        if let myWrongWordsString = user?["wrongWords"] as! String?{
            myWrongWords = myWrongWordsString.components(separatedBy: ";")
            //    print("myWrongWords:\(myWrongWords)")
        }
        
        
        
        switch senRateToAdd{
            
        case 0:
            senRateToAdd = 0
        case 1:
            senRateToAdd = 33
        case 2:
            senRateToAdd = 66
        case 3:
            senRateToAdd = 100
        default:
            break
        }
        
        switch proRateToAdd{
            
        case 0:
            proRateToAdd = 0
        case 1:
            proRateToAdd = 33
        case 2:
            proRateToAdd = 66
        case 3:
            proRateToAdd = 100
        default:
            break
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }


    @IBAction func registerClicked(_ sender: Any) {
        
        if accountTextField.text!.isEmpty || accountTextField.text!.count < 5 {
            
            
            
            accountTextField.text = ""
            accountTextField.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上帳號", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            
            if  passwordTextField.text!.isEmpty  || passwordTextField.text!.count < 5{
                
                passwordTextField.text = ""
                
                passwordTextField.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上密碼", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])

                
            }
            
        } else if  passwordTextField.text!.isEmpty  || passwordTextField.text!.count < 5{
            
            passwordTextField.text = ""
            
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上密碼", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            
            if accountTextField.text!.isEmpty || accountTextField.text!.count < 5 {
                

                accountTextField.text = ""
                accountTextField.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上帳號", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                
            }
            
        } else {
            
            
            print("register")
            // shortcuts
            let username = accountTextField.text!.lowercased()
            let password = passwordTextField.text!
            
            //檢查註冊
            // url to php file
            let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/register.php")!
            
            // request to this file
            var request = URLRequest(url: url)
            
            // method to pass data to this file (e.g. via POST)
            request.httpMethod = "POST"
            
            // body to be appended to url, 讓nickname = 註冊帳號
            let body = "username=\(username)&password=\(password)&fbid=&nickname=\(username)&coursePlayed=\(coursePlayed)&ava="
            
            request.httpBody = body.data(using: .utf8)
            //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // proceed request
            URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
                
                
                if error == nil {
                    
                    // get main queue in code process to communicate back to UI
                    DispatchQueue.main.async(execute: {
                        
                        do {
                            // get json result
                            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            
                            
                            // assign json to new var parseJSON in guard/secured way
                            guard let parseJSON = json else {
                                print("Error while parsing")
                                //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                                return
                            }
                            
                            //先儲存使用者資訊
                            
                            UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                            user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                            
                            //第一次玩
                            //儲存mapPassed & gamePassed的初始值
                            
                            
                            mapPassed = 0
                            
                            gamePassed = [0:0]
                            
                            mapPassed2 = 0
                            
                            gamePassed2 = [0:0]
                            
                            mapPassed3 = 0
                            
                            gamePassed3 = [0:0]
                            
                            
                            switch self!.coursePlayed{
                            case 0:
                                gamePassed = [0:1]
                            case 1:
                                gamePassed2 = [0:1]
                                case 2:
                                gamePassed3 = [0:1]
                                
                            default:
                                break
           
                                
                            }
      
                            let userDefaults = UserDefaults.standard
                            
                            userDefaults.set(mapPassed!, forKey: "mapPassed")
             
                            
                            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed!)
                            userDefaults.set(encodedObject, forKey: "gamePassed")
       
               
                            userDefaults.set(mapPassed2!, forKey: "mapPassed2")
        
                            
                            let encodedObject2 = NSKeyedArchiver.archivedData(withRootObject: gamePassed2!)
                            userDefaults.set(encodedObject2, forKey: "gamePassed2")
                            
                            
                            userDefaults.set(mapPassed3!, forKey: "mapPassed3")
                            
                            
                            let encodedObject3 = NSKeyedArchiver.archivedData(withRootObject: gamePassed3!)
                            userDefaults.set(encodedObject3, forKey: "gamePassed3")
                            
                            
                            isRegistered = true
                            
                            UserDefaults.standard.set(isRegistered, forKey: "isRegistered")
                            
                            
                            //全新註冊者重新設定秒數
                            UserDefaults.standard.set(420, forKey: "limitSeconds")

                            
                            /*
                            //登入
                            DispatchQueue.main.async(execute: {
                                
                                
                                //dimiss掉3個VCs
                 
                                self!.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                            })
                            
                            */
                            // get id from parseJSON dictionary
                            let id = user?["id"] as? String
                            
                            // successfully registered
                            if id != nil {
                                
                                
                                //登入
                                DispatchQueue.main.async(execute: {
                                    
                                
                                    //首先更新分數及確認有沒有錯字

                                    
                                    //dimiss掉3個VCs
                                    if self!.isDirectedHere {
                                        
                                        self!.dismiss(animated: false, completion: nil)
                                        
                                        
                                    } else  {
                                       
                                         self!.updateScore(score: self!.scoresToAdd, wrongWordsCount: self!.wrongChineseCount, proRate: self!.proRateToAdd, senRate: self!.senRateToAdd)
                                        
                                        
                                    }
                                })
                                
                                // error
                                
                                
                            } else {
                                
                                // get main queue to communicate back to user
                                DispatchQueue.main.async(execute: {
                                    
                                    print("1")
                                    self?.accountTextField.text = ""
                                    self?.passwordTextField.text = ""
                                    self?.accountTextField.attributedPlaceholder = NSAttributedString(string: "此帳號已存在，請重新輸入", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                                    self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                                    
                                })
                                return
                                
                            }
                            
                            
                        } catch {
                            
                            // get main queue to communicate back to user
                            DispatchQueue.main.async(execute: {
                                
                                print("2")
                                self?.accountTextField.text = ""
                                self?.passwordTextField.text = ""
                                self?.accountTextField.attributedPlaceholder = NSAttributedString(string: "帳號輸入有誤，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                                self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: "密碼輸入有誤，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                            })
                            return
                            
                        }
                        
                    })
                    
                    // if unable to proceed request
                } else {
                    
                    // get main queue to communicate back to user
                    DispatchQueue.main.async(execute: {
                        
                        print("3")
                        let message = error!.localizedDescription
                        print(message)
                        self?.accountTextField.text = ""
                        self?.passwordTextField.text = ""
                        self?.accountTextField.attributedPlaceholder = NSAttributedString(string: "帳號輸入有誤，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                        self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: "密碼輸入有誤，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                    })
                    return
                    
                }
                
                // launch prepared session
                }.resume()
            
            
            
        }

        
    }
    
    @IBAction func fbLoginClicked(_ sender: Any) {
        
        let loginManager = LoginManager()
        
  
        loginManager.logIn(readPermissions: [.publicProfile,.email], viewController: self) {[weak self] (loginResult) in
            
            switch loginResult{
            case .failed(let error):
                print(error)
            //失敗的時候回傳
            case .cancelled:
                print("the user cancels login")
            //取消時回傳內容
            case .success(grantedPermissions: _, declinedPermissions: _, token: _):
                self!.getDetails()
                print("user log in")
                //成功時print("user log in")
                
            }
        }
    }

    func getDetails(){
        guard let _ = AccessToken.current else{return}
        let param = ["fields":"name, email , picture.width(200).height(200)"]
        let graphRequest = GraphRequest(graphPath: "me",parameters: param)
        
        graphRequest.start { [weak self](urlResponse, requestResult) in
            switch requestResult{
            case .failed(let error):
                print(error)
            case .success(response: let graphResponse):
                if let responseDictionary = graphResponse.dictionaryValue{
                    print(responseDictionary)
                    let name = responseDictionary["name"] as? String
                    let id = responseDictionary["id"] as? String
                    
                    var picURL = String()
                    if let photo = responseDictionary["picture"] as? NSDictionary{
                        let data = photo["data"] as! NSDictionary
                        picURL = data["url"] as! String
                        print(name , picURL)
                    }
                    
                    
                    //register
                   
                    let newURL = picURL.replacingOccurrences(of: "&", with: "__")
                    
                    self!.fbRegister(fbid: id!, nickname: name!, ava:newURL)
                  
                    
                }
            }
        }
    }
    
    
    
    func fbRegister(fbid:String,nickname:String, ava:String){
        
        print("register")
        // shortcuts

        //檢查註冊
        // url to php file
        let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/register.php")!
        
        // request to this file
        var request = URLRequest(url: url)
        
        // method to pass data to this file (e.g. via POST)
        request.httpMethod = "POST"
        
        // body to be appended to url, 讓nickname = 註冊帳號
        let body = "username=&password=&fbid=\(fbid)&nickname=\(nickname)&coursePlayed=\(coursePlayed)&ava=\(ava)"
        print(body)
        request.httpBody = body.data(using: .utf8)
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // proceed request
        URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            
            
            if error == nil {
                
                // get main queue in code process to communicate back to UI
                DispatchQueue.main.async(execute: {
                    
                    do {
                        // get json result
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        
                        // assign json to new var parseJSON in guard/secured way
                        guard let parseJSON = json else {
                            print("Error while parsing")
                            //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                            return
                        }
                        
                        //先儲存使用者資訊
                        print(parseJSON)
                        UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                        
                        isRegistered = true
                        
                        UserDefaults.standard.set(isRegistered, forKey: "isRegistered")
                        
                    
                        // get id from parseJSON dictionary
                        let id = user?["id"] as? String
                        
                        // successfully registered
                        if id != nil {
                            
                            
                            //設定有註冊
                            isRegistered = true
                            UserDefaults.standard.set(isRegistered, forKey: "isRegistered")
                            
                            
                            
                            // Part 1. 登入者抓所有數值
                            if let mapPassedString = user?["mapPassed"] as! String?{
                                
                                mapPassed = Int(mapPassedString)!
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(mapPassed!, forKey: "mapPassed")
                                
                                print("retrieve mapPassed:\(mapPassed!)")
                                
                            }
                            if let mapPassed2String = user?["mapPassed2"] as! String?{
                                
                                mapPassed2 = Int(mapPassed2String)!
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(mapPassed2!, forKey: "mapPassed2")
                                
                                print("retrieve mapPassed:\(mapPassed2!)")
                                
                            }
                            
                            if let mapPassed3String = user?["mapPassed3"] as! String?{
                                
                                mapPassed3 = Int(mapPassed3String)!
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(mapPassed3!, forKey: "mapPassed3")
                                
                                print("retrieve mapPassed:\(mapPassed3!)")
                                
                            }
                            
                            
                            if let gamePassedString = user?["gamePassed"] as! String?{
                                
                                let gamePassedStringArray = gamePassedString.components(separatedBy: ":")
                                
                                let s = gamePassedStringArray[0]
                                let u = gamePassedStringArray[1]
                                gamePassed = [Int(s)!:Int(u)!]
                                
                                let userDefaults = UserDefaults.standard
                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed!)
                                
                                print("retrieve gamePassed:\(gamePassed!)")
                                userDefaults.set(encodedObject, forKey: "gamePassed")
                                
                            }
                            
                            if let gamePassed2String = user?["gamePassed2"] as! String?{
                                
                                let gamePassed2StringArray = gamePassed2String.components(separatedBy: ":")
                                
                                let s = gamePassed2StringArray[0]
                                let u = gamePassed2StringArray[1]
                                gamePassed2 = [Int(s)!:Int(u)!]
                                
                                let userDefaults = UserDefaults.standard
                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed2!)
                                
                                print("retrieve gamePassed:\(gamePassed2!)")
                                userDefaults.set(encodedObject, forKey: "gamePassed2")
                                
                            }
                            
                            if let gamePassed3String = user?["gamePassed3"] as! String?{
                                
                                let gamePassed3StringArray = gamePassed3String.components(separatedBy: ":")
                                
                                let s = gamePassed3StringArray[0]
                                let u = gamePassed3StringArray[1]
                                gamePassed3 = [Int(s)!:Int(u)!]
                                
                                let userDefaults = UserDefaults.standard
                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed3!)
                                
                                print("retrieve gamePassed:\(gamePassed3!)")
                                userDefaults.set(encodedObject, forKey: "gamePassed3")
                                
                            }

                            
                            
                            // part 2. 判斷是不是從購買畫面轉過來的
                            if self!.isDirectedHere{
                                
                                
                                DispatchQueue.main.async(execute: {
                                    //是的話 註冊完就跳掉
                                    self!.dismiss(animated: false, completion: nil)
                                    
          

                                    
                                    
                                })
                                

                                
                            } else {
                                
                                //Part 3. 不是的話要看有沒有玩過
                                
                                let scoreSaved = user?["score"] as? String
                                
                                
                                
                                //沒玩過的話, 要更新所有數字 updateGamePassed/ updateScore / addWrongWords
                                if scoreSaved == "0" {
                                    
                                    
                                    
                                    switch self!.coursePlayed{
                                    case 0:
                                        
                                        gamePassed = [0:1]
                                        gamePassed2 = [0:0]
                                        gamePassed3 = [0:0]
                                    case 1:
                                        gamePassed2 = [0:1]
                                        gamePassed = [0:0]
                                        gamePassed3 = [0:0]
                                        
                                        
                                    case 2:
                                        gamePassed3 = [0:1]
                                        gamePassed = [0:0]
                                        gamePassed2 = [0:0]
                                        
                                    default:
                                        break
                                        
                                    }
                                    
                                    
                                    
                                    //改變userdefault
                                    
                                    let userDefaults = UserDefaults.standard
                                    
                                    let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed!)
                                    userDefaults.set(encodedObject, forKey: "gamePassed")
                                    
                                    let encodedObject2 = NSKeyedArchiver.archivedData(withRootObject: gamePassed2!)
                                    userDefaults.set(encodedObject2, forKey: "gamePassed2")
                                    
                                    let encodedObject3 = NSKeyedArchiver.archivedData(withRootObject: gamePassed3!)
                                    userDefaults.set(encodedObject3, forKey: "gamePassed3")
                                    
                                    
                                    
                                    DispatchQueue.main.async(execute: {
                                        //更新後端
                                        
                                        print("exec updateGamePassed")
                                        self!.updateGamePassed(course: self!.coursePlayed)
                                        
                                    })
                                    
                    
                                } else {
                                    
                                    
                                    print("scoreSaved != 0")
                                    
                                    //有玩過的話就跳出畫面, 不重新設定東西
                                    
                                    
                                    DispatchQueue.main.async(execute: {[weak self] in
                                        self!.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                                    })
                                    
                                    
                                }
                                
                                
                            }
                            
                            
                        } else {
                            
                            // get main queue to communicate back to user
                            DispatchQueue.main.async(execute: {
                                
                                print("1")
                                self?.accountTextField.text = ""
                                self?.passwordTextField.text = ""
                                self?.accountTextField.attributedPlaceholder = NSAttributedString(string: "此帳號已存在，請重新輸入", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                                self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                                
                            })
                            return
                            
                        }
                        
                        
                    } catch {
                        
                        // get main queue to communicate back to user
                        DispatchQueue.main.async(execute: {
                            
                            print("2")
                            self?.accountTextField.text = ""
                            self?.passwordTextField.text = ""
                            self?.accountTextField.attributedPlaceholder = NSAttributedString(string: "帳號輸入有誤，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                            self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: "密碼輸入有誤，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                        })
                        return
                        
                    }
                    
                })
                
                // if unable to proceed request
            } else {
                
                // get main queue to communicate back to user
                DispatchQueue.main.async(execute: {
                    
                    print("3")
                    let message = error!.localizedDescription
                    print(message)
                    self?.accountTextField.text = ""
                    self?.passwordTextField.text = ""
                    self?.accountTextField.attributedPlaceholder = NSAttributedString(string: "帳號輸入有誤，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                    self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: "密碼輸入有誤，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                })
                return
                
            }
            
            // launch prepared session
            }.resume()

        
    }
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        
        
        if accountTextField.text!.isEmpty || accountTextField.text!.count < 5 {
            

            accountTextField.text = ""
            accountTextField.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上帳號", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            
            if  passwordTextField.text!.isEmpty  || passwordTextField.text!.count < 5{
                
                passwordTextField.text = ""
                
                passwordTextField.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上密碼", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
    
            }
            
        } else if  passwordTextField.text!.isEmpty  || passwordTextField.text!.count < 5{
            
            passwordTextField.text = ""
            
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上密碼", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            
            if accountTextField.text!.isEmpty || accountTextField.text!.count < 5 {
                
                
                
                accountTextField.text = ""
                accountTextField.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上帳號", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                
                
            }
            
        } else {
            
            
            // shortcuts
            let username = accountTextField.text!.lowercased()
            let password = passwordTextField.text!
            
            // send request to mysql db
            // url to access our php file
            let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/login.php")!
            
            // request url
            var request = URLRequest(url: url)
            
            // method to pass data POST - cause it is secured
            request.httpMethod = "POST"
            
            // body gonna be appended to url
            let body = "username=\(username)&password=\(password)"
            
            // append body to our request that gonna be sent
            request.httpBody = body.data(using: .utf8)
            
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                
                // no error
                if error == nil {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        guard let parseJSON = json else {
                            print("Error while parsing")
                            //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                            return
                        }
                      
                        
                    
                        
                        //儲存user資訊
                        UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                        
                    
                        let id = user?["id"] as? String
                        
                        
                        // successfully logged in
                        if id != nil {
                            
                            //設定有註冊
                            isRegistered = true
                            UserDefaults.standard.set(isRegistered, forKey: "isRegistered")
                            

                        
                        // Part 1. 登入者抓所有數值
                        if let mapPassedString = user?["mapPassed"] as! String?{
                            
                            mapPassed = Int(mapPassedString)!
                            let userDefaults = UserDefaults.standard
                            userDefaults.set(mapPassed!, forKey: "mapPassed")
                            
                            print("retrieve mapPassed:\(mapPassed!)")
                            
                        }
                        if let mapPassed2String = user?["mapPassed2"] as! String?{
                            
                            mapPassed2 = Int(mapPassed2String)!
                            let userDefaults = UserDefaults.standard
                            userDefaults.set(mapPassed2!, forKey: "mapPassed2")
                            
                            print("retrieve mapPassed:\(mapPassed2!)")
                            
                        }
                        
                        if let mapPassed3String = user?["mapPassed3"] as! String?{
                            
                            mapPassed3 = Int(mapPassed3String)!
                            let userDefaults = UserDefaults.standard
                            userDefaults.set(mapPassed3!, forKey: "mapPassed3")
                            
                            print("retrieve mapPassed:\(mapPassed3!)")
                            
                        }
                        
                        
                        if let gamePassedString = user?["gamePassed"] as! String?{
                            
                            let gamePassedStringArray = gamePassedString.components(separatedBy: ":")
                            
                            let s = gamePassedStringArray[0]
                            let u = gamePassedStringArray[1]
                            gamePassed = [Int(s)!:Int(u)!]
                            
                            let userDefaults = UserDefaults.standard
                            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed!)
                            
                            print("retrieve gamePassed:\(gamePassed!)")
                            userDefaults.set(encodedObject, forKey: "gamePassed")
                            
                        }
                        
                        if let gamePassed2String = user?["gamePassed2"] as! String?{
                            
                            let gamePassed2StringArray = gamePassed2String.components(separatedBy: ":")
                            
                            let s = gamePassed2StringArray[0]
                            let u = gamePassed2StringArray[1]
                            gamePassed2 = [Int(s)!:Int(u)!]
                            
                            let userDefaults = UserDefaults.standard
                            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed2!)
                            
                            print("retrieve gamePassed:\(gamePassed2!)")
                            userDefaults.set(encodedObject, forKey: "gamePassed2")
                            
                        }
                        
                        if let gamePassed3String = user?["gamePassed3"] as! String?{
                            
                            let gamePassed3StringArray = gamePassed3String.components(separatedBy: ":")
                            
                            let s = gamePassed3StringArray[0]
                            let u = gamePassed3StringArray[1]
                            gamePassed3 = [Int(s)!:Int(u)!]
                            
                            let userDefaults = UserDefaults.standard
                            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed3!)
                            
                            print("retrieve gamePassed:\(gamePassed3!)")
                            userDefaults.set(encodedObject, forKey: "gamePassed3")
                            
                        }
                        
                        
                        
                        
                        
                        
                        
                  
                        // part 2. 判斷是不是從購買畫面轉過來的
                        if self!.isDirectedHere{
                            
                            
                            DispatchQueue.main.async(execute: {
                                //是的話 註冊完就跳掉
                                self!.dismiss(animated: false, completion: nil)
                            })
                            
             
                            
                            
                            
                            
                        } else {
                            
                            //Part 3. 不是的話要看有沒有玩過
                            
                            let scoreSaved = user?["score"] as? String
                            
                            
                            
                            //沒玩過的話, 要更新所有數字 updateGamePassed/ updateScore / addWrongWords
                            if scoreSaved == "0" {
                                
                                
                                
                                switch self!.coursePlayed{
                                case 0:
                                    
                                    gamePassed = [0:1]
                                    gamePassed2 = [0:0]
                                    gamePassed3 = [0:0]
                                case 1:
                                    gamePassed2 = [0:1]
                                    gamePassed = [0:0]
                                    gamePassed3 = [0:0]
                                    
                                    
                                case 2:
                                    gamePassed3 = [0:1]
                                    gamePassed = [0:0]
                                    gamePassed2 = [0:0]
                                    
                                default:
                                    break
                                    
                                }
                                
                                
                                
                                //改變userdefault
                                
                                let userDefaults = UserDefaults.standard
                                
                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed!)
                                userDefaults.set(encodedObject, forKey: "gamePassed")
                                
                                let encodedObject2 = NSKeyedArchiver.archivedData(withRootObject: gamePassed2!)
                                userDefaults.set(encodedObject2, forKey: "gamePassed2")
                                
                                let encodedObject3 = NSKeyedArchiver.archivedData(withRootObject: gamePassed3!)
                                userDefaults.set(encodedObject3, forKey: "gamePassed3")
                                
                                
                                
                                DispatchQueue.main.async(execute: {
                                    //更新後端
                                    
                                    print("exec updateGamePassed")
                                    self!.updateGamePassed(course: self!.coursePlayed)
                                    
                                })
                                
                                
                                
                            } else {
                                
                                
                                print("scoreSaved != 0")
                        
                                //有玩過的話就跳出畫面, 不重新設定東西
                                
                                
                                DispatchQueue.main.async(execute: {[weak self] in
                                    self!.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                                })
                                
                                
                            }
                            
                            
                        }
                        
                        
                        
                        /*
                        
                        //抓mapPassed & gamePassed
                        
                        //如果分數是0分代表從未註冊過
                        let scoreSaved = user?["score"] as? String
                        
       
                        if scoreSaved == "0" {

                            print("scoreSaved == 0")
                            
                            //如果不是直接轉過來的畫面才需要幫忙加過一關, 否則也等於是重來
                            
                         
                            if self!.isDirectedHere == false {
                        
                      

                                
                                
                            }    else {
                                //從購買畫面跳過來
                                
                                
                                
                                
                                
                                
                                
                                
                            }
                            
                            
                        }  else {

                            

                            
                            DispatchQueue.main.async(execute: {
                                print("successfully logged in")
                                //dimiss掉3個VCs
                                if self!.isDirectedHere{
                                    
                                    self!.dismiss(animated: false, completion: nil)
                                    
                                } else {
                                    
                                    self!.updateScore(score: self!.scoresToAdd, wrongWordsCount: self!.wrongChineseCount, proRate: self!.proRateToAdd, senRate: self!.senRateToAdd)                                }
                                
                                
                            })
                            
                            
                            
                        }
                        
                        //先儲存使用者資訊
                        print(user!)
                        */
                        
                        
                        
                        
                        }else {
                            
                            // 抓錯誤訊息
                            DispatchQueue.main.async(execute: {
                                if let errorStatus = parseJSON["status"] as? String{
                                    
                                    if errorStatus == "403"{
                                        
                                        self?.accountTextField.text = ""
                                        self?.passwordTextField.text = ""
                                        self?.accountTextField.attributedPlaceholder = NSAttributedString(string: "帳號不存在，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                                        self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                                        
                                        
                                    } else if errorStatus == "401"{
                                        
                                        self?.accountTextField.text = ""
                                        self?.passwordTextField.text = ""
                                        self?.accountTextField.attributedPlaceholder = NSAttributedString(string: "密碼不正確，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                                        self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                                        
                                        
                                    }
                                    
                                    
                                }
                            })
                            return
                            
                        }

                    } catch {
                        
                        // get main queue to communicate back to user
                        DispatchQueue.main.async(execute: {
                            self?.accountTextField.text = ""
                            self?.passwordTextField.text = ""
                            self?.accountTextField.attributedPlaceholder = NSAttributedString(string: "登入錯誤，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                            self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                            
                            
                        })
                        return
                        
                    }
                    
                } else {
                    
                    // get main queue to communicate back to user
                    DispatchQueue.main.async(execute: {
                        let message = error!.localizedDescription
                        print(message)
                        self?.accountTextField.text = ""
                        self?.passwordTextField.text = ""
                        self?.accountTextField.attributedPlaceholder = NSAttributedString(string: "登入錯誤，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                        self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                    })
                    return
                    
                }
                
                }.resume()
        }

        
    }
    
    
    func addWrongWords(){
        
        print("final wrongWords\(wrongWordsToAdd)")
            //確認有錯字
            
            for word in wrongWordsToAdd{
                
                //避免重複
                if !myWrongWords.contains(word){
                    
                    print("wrongword:\(word)")
                    
                    let id = user?["id"] as! String
                    
                    // url to access our php file
                    let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/addWrongWord.php")!
                    
                    // request url
                    var request = URLRequest(url: url)
                    
                    // method to pass data POST - cause it is secured
                    request.httpMethod = "POST"
                    
                    // body gonna be appended to url
                    let body = "userID=\(id)&wrongWord=\(word)"
                    
                    // append body to our request that gonna be sent
                    request.httpBody = body.data(using: .utf8)
                    
                    URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
                        // no error
                        if error == nil {
                            
                            do {
                                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                                
                                guard let parseJSON = json else {
                                    print("Error while parsing")
                                    //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                                    return
                                }
                                
                                //再次儲存使用者資訊
                                UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                                user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                                print(user!)
                                
                                if user != nil {
                                    
                                   
                                    DispatchQueue.main.async(execute: {[weak self] in
                                        self!.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                                    })
                                    
                                    
                                }
                                
                            } catch{
                                
                                print("catch error")
                                
                            }
                        } else {
                            
                            print("urlsession has error")
                            
                        }
                    }).resume()
                    
                }
            }
        
        
    }

    
    
    func updateScore(score:Int, wrongWordsCount:Int, proRate:Int, senRate:Int){
        
        
        
        
        
        let id = user?["id"] as! String
        
        // url to access our php file
        let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/updateScore.php")!
        
        // request url
        var request = URLRequest(url: url)
        
        // method to pass data POST - cause it is secured
        request.httpMethod = "POST"
        
        // body gonna be appended to url
        let body = "userID=\(id)&score=\(score)&wrongWordsCount=\(wrongWordsCount)&proRate=\(proRate)&senRate=\(senRate)"
        
        // append body to our request that gonna be sent
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {[weak self] data, response, error in
            // no error
            if error == nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    guard let parseJSON = json else {
                        print("Error while parsing")
                        
                        //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                        return
                    }
                    
                    print("updateScore")
                    //再次儲存使用者資訊
                    UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                    user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                    print(user!)
                    
                    
                    
                    if user != nil {
                        
                        
                        DispatchQueue.main.async(execute: {
                            
                            if self!.wrongWordsToAdd.count > 0 {
                                
                                self!.addWrongWords()
                           
                            
                                //self!.updateScore(score: self!.scoresToAdd, wrongWordsCount: self!.wrongChineseCount, proRate: self!.proRateToAdd, senRate: self!.senRateToAdd)
                                
                                
                                
                            } else {
                                
                                
                                self!.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                                
                                
                                
                                
                            }

                            
                            
                            
                        })
                        
                        
                        
                    }
                    
                    
                    
                } catch{
                    
                    print("catch error")
                    
                }
            } else {
                
                print("urlsession has error")
                
            }
        }).resume()
        
    }

    
    
    //更新gamePassed
    func updateGamePassed(course:Int){
        
        print("enter updateGame")
        
        let id = user?["id"] as! String
        
        // url to access our php file
        let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/gamePassed.php")!
        
        // request url
        var request = URLRequest(url: url)
        
        // method to pass data POST - cause it is secured
        request.httpMethod = "POST"
        
        /*
        var gamePassedString = String()
        
        
        for (s,u) in gamePassedDic!{
            
            gamePassedString = String(s) + ":" + String(u)
            
        }
        */
        
        let passed = "0:1"
        
        // body gonna be appended to url
        let body = "userID=\(id)&gamePassed=\(passed)&course=\(course)"
        print(body)
        
        // append body to our request that gonna be sent
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            // no error
            
            
            if error == nil {
                
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    guard let parseJSON = json else {
                        print("Error while parsing")
                        //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                        
                        return
                    }
                    
                    //再次儲存使用者資訊
                    UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                    user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                    
                    
                    if user != nil {
                        
                        DispatchQueue.main.async(execute: {[weak self] in
                            
                            //updateScore
                         
                            
                            
      

                            
                            
                            
                            
                            self!.updateScore(score: self!.scoresToAdd, wrongWordsCount: self!.wrongChineseCount, proRate: self!.proRateToAdd, senRate: self!.senRateToAdd)
                            
                            /*
                            if self!.wrongWordsToAdd.count > 0 {
                                
                                self!.addWrongWords()
                                
                                
                                
                                
                            } else {
                                self!.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
               
                                
                            }
                            */
                        })

                        
                        
                        
                    }
                    
                    print("gamePassed updated")
                    
                } catch{
                    
                    print("catch error:\(error)")
                    
                    
                }
            } else {
                print("urlsession has error")
                
            }
        }).resume()
        
        
        
    }

    
    
    
    deinit {
        print("registerVc deinit")
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
