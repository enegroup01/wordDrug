//
//  LoginViewController.swift
//  wordDrug
//
//  Created by Ethan on 2017/11/21.
//  Copyright © 2017年 playplay. All rights reserved.
//

import UIKit
import SSBouncyButton
import FacebookLogin
import FacebookCore

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var logoLabel: UILabel!
 
    @IBOutlet weak var fbLoginBtn: SSBouncyButton!
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var loginBtn: SSBouncyButton!
    @IBOutlet weak var registerBtn: SSBouncyButton!
    
    
    @IBOutlet weak var accountPng: UIImageView!
    
    @IBOutlet weak var passwordPng: UIImageView!
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    @IBOutlet weak var doubleLine: UIImageView!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
        let darkTextColor = UIColor.init(red: 39/255, green: 48/255, blue: 86/255, alpha: 1)
    
    
    @IBOutlet weak var doubleLine2: UIImageView!
    
    
    var isWelcome = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //指定delegate才能return
        usernameTxt.delegate = self
        passwordTxt.delegate = self
        
        //placeholder顏色
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "請輸入帳號", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "請輸入密碼", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        // Do any additional setup after loading the view.
        
        
       
        
        
        logoLabel.frame = CGRect(x: 0, y: height / 11, width: width, height: 98)
        logoLabel.font = UIFont(name: "Helvetica Bold", size: 30)
        logoLabel.textColor = .clear
        logoLabel.text = "MissWord\n我的單字老師"
        logoLabel.textAlignment = .center
        logoLabel.numberOfLines = 0
 
        
        
        doubleLine.frame = CGRect(x: (width - 290) / 2, y: logoLabel.frame.maxY, width: 290, height: 6)
        doubleLine.image = UIImage(named: "doubleLine.png")
        doubleLine.contentMode = .scaleAspectFit
        
        subTitleLabel.text = "英檢初級，中級，多益滿分等\n所有單字任你學習！"
        subTitleLabel.frame = CGRect(x: 0, y: doubleLine.frame.maxY + 10, width: width, height: 50)
        subTitleLabel.font = UIFont(name: "Helvetica Bold", size: 18)
        subTitleLabel.textAlignment = .center
        subTitleLabel.numberOfLines = 0

        
        
        /*
         logoLabel.frame = CGRect(x: (width - 106 * dif) / 2, y: height / 10, width: 106 * dif, height: 43 * dif)
         */
        
        
        accountPng.frame = CGRect(x: (width - 302) / 2, y: subTitleLabel.frame.maxY + 10, width: 302, height: 42)
        
        accountPng.image = UIImage(named: "newAccountPng.png")
        
        passwordPng.frame = CGRect(x: accountPng.frame.minX, y: accountPng.frame.maxY + 10, width: 302, height: 42)
        passwordPng.image = UIImage(named: "newPasswordPng.png")
 
       var iphoneWidth = CGFloat()
       var fontSize = CGFloat()
        var dif = CGFloat()
     
        switch  height {
        case 812:
            iphoneWidth = height * 375/667
            fontSize = 20
            dif = 1.15
      
        case 736:
            iphoneWidth = width
            fontSize = 18
            dif = 1.1
        case 667:
            iphoneWidth = width
            fontSize = 18
     
dif = 1
        case 568:
            iphoneWidth = width
            fontSize = 16
 dif = 0.9

        default:
            iphoneWidth = width
            fontSize = 16
            dif = 0.9

            
        }
        
        

        
        bgView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        bgImg.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
       // usernameTxt.frame = CGRect(x: width / 6, y: height / 3.4, width: width * 2 / 3, height: 30)
        
        
      
     
        //usernameTxt.font = UIFont(name: "Helvetica Neue", size: 18)
        //usernameTxt.backgroundColor = .red
        
        
        /*
        passwordTxt.frame = CGRect(x: width / 6, y: height / 2.5, width: width * 2 / 3, height: 30)
        passwordTxt.font = UIFont(name: "Helvetica Neue", size: 18)
 */
 //passwordTxt.backgroundColor = .blue
        
        
    
        

        
        loginBtn.frame = CGRect(x: passwordPng.frame.maxX - 142, y: passwordPng.frame.maxY + 10, width: 138, height: 35)
        loginBtn.layer.cornerRadius = loginBtn.frame.width / 40
        loginBtn.clipsToBounds = true
        loginBtn.titleLabel?.textAlignment = .center
        loginBtn.setTitle("登入", for: .normal)
        
        
        
        registerBtn.frame = CGRect(x: passwordPng.frame.minX, y: passwordPng.frame.maxY + 10, width: 138, height: 35)
        
        registerBtn.layer.cornerRadius = registerBtn.frame.width / 40
        registerBtn.clipsToBounds = true
        registerBtn.titleLabel?.textAlignment = .center
        registerBtn.setTitle("註冊", for: .normal)
        
        fbLoginBtn.frame = CGRect(x: passwordPng.frame.minX, y: registerBtn.frame.maxY * 1.02, width: passwordPng.frame.width, height: 35)
        
        
        fbLoginBtn.layer.cornerRadius = fbLoginBtn.frame.width / 40
        fbLoginBtn.clipsToBounds = true
        fbLoginBtn.titleLabel?.textAlignment = .center
        fbLoginBtn.setTitle("使用facebook登入", for: .normal)

        usernameTxt.frame = CGRect(x: accountPng.frame.minX + accountPng.frame.width / 7, y: accountPng.frame.minY, width: accountPng.frame.width * 4 / 5, height: accountPng.frame.height)
        
        
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上帳號", attributes: [NSAttributedStringKey.foregroundColor: darkTextColor])
        
        passwordTxt.frame = CGRect(x: usernameTxt.frame.minX, y: passwordPng.frame.minY, width:
            usernameTxt.frame.width, height: passwordPng.frame.height)
          passwordTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上密碼", attributes: [NSAttributedStringKey.foregroundColor: darkTextColor])
        
        
        doubleLine2.frame = CGRect(x: doubleLine.frame.minX, y: fbLoginBtn.frame.maxY + 10, width: doubleLine.frame.width, height: doubleLine.frame.height)
        doubleLine2.image = UIImage(named: "doubleLine.png")
        doubleLine2.contentMode = .scaleAspectFit
        
        
        
    }

    

    
    //註冊功能
    @IBAction func registerClick(_ sender: Any) {
        
        
        if usernameTxt.text!.isEmpty || usernameTxt.text!.count < 5 {
            
            
            
            usernameTxt.text = ""
            usernameTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上帳號", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            
            if  passwordTxt.text!.isEmpty  || passwordTxt.text!.count < 5{
                
                passwordTxt.text = ""
                
                passwordTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上密碼", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])

                
                
                
            }
            
        } else if  passwordTxt.text!.isEmpty  || passwordTxt.text!.count < 5{
            
            passwordTxt.text = ""
            
            passwordTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上密碼", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            
            if usernameTxt.text!.isEmpty || usernameTxt.text!.count < 5 {
                
                
                
                usernameTxt.text = ""
                usernameTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上帳號", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                
                
            }
            
        } else {
            
        
        print("register")
        // shortcuts
        let username = usernameTxt.text!.lowercased()
        let password = passwordTxt.text!
        
        //檢查註冊
        // url to php file
        let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/register.php")!
        
        // request to this file
        var request = URLRequest(url: url)
        
        // method to pass data to this file (e.g. via POST)
        request.httpMethod = "POST"
        
        // body to be appended to url, 讓nickname = 註冊帳號
        let body = "username=\(username)&password=\(password)&fbid=&nickname=\(username)&coursePlayed=&ava="
        
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
                       
                        let userDefaults = UserDefaults.standard
                        
                        userDefaults.set(mapPassed!, forKey: "mapPassed")
             
                        gamePassed = [0:0]
                        
                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed!)
                        userDefaults.set(encodedObject, forKey: "gamePassed")
                        
                        mapPassed2 = 0
                        
                      
                        
                        userDefaults.set(mapPassed2!, forKey: "mapPassed2")
                        
                        gamePassed2 = [0:0]
                        
                        let encodedObject2 = NSKeyedArchiver.archivedData(withRootObject: gamePassed2!)
                        userDefaults.set(encodedObject2, forKey: "gamePassed2")

                        
                        mapPassed3 = 0
                        
                        
                        
                        userDefaults.set(mapPassed2!, forKey: "mapPassed3")
                        
                        gamePassed3 = [0:0]
                        
                        let encodedObject3 = NSKeyedArchiver.archivedData(withRootObject: gamePassed3!)
                        userDefaults.set(encodedObject2, forKey: "gamePassed3")
                        
                        //全新註冊者重新算秒數
                        UserDefaults.standard.set(420, forKey: "limitSeconds")

                        
                        // get id from parseJSON dictionary
                        let id = user?["id"] as? String

                        // successfully registered
                        if id != nil {


                            //登入
                                DispatchQueue.main.async(execute: {
                             
                                    self!.isWelcome = true
                                 
                                    self!.toCourses()
                                    
                                    
                                })
                                
                            // error
                            
                            
                        } else {
                            
                            // get main queue to communicate back to user
                            DispatchQueue.main.async(execute: {
                                
                                print("1")
                                self?.usernameTxt.text = ""
                                self?.passwordTxt.text = ""
                                self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "此帳號已存在，請重新輸入", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                                self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                                
                            })
                            return
                            
                        }
                        
                        
                    } catch {
                        
                        // get main queue to communicate back to user
                        DispatchQueue.main.async(execute: {
                            
                                     print("2")
                            self?.usernameTxt.text = ""
                            self?.passwordTxt.text = ""
                            self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "帳號輸入有誤，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                            self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "密碼輸入有誤，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
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
                    self?.usernameTxt.text = ""
                    self?.passwordTxt.text = ""
                    self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "帳號輸入有誤，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                    self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "密碼輸入有誤，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                })
                return
                
            }
            
            // launch prepared session
            }.resume()
        
        

        }
        
        
    }
    
    //登入功能
    @IBAction func loginclick(_ sender: Any) {
        
        
        
        if usernameTxt.text!.isEmpty || usernameTxt.text!.count < 5 {
            
            
            
            usernameTxt.text = ""
            usernameTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上帳號", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            
            if  passwordTxt.text!.isEmpty  || passwordTxt.text!.count < 5{
                
                passwordTxt.text = ""
                
                passwordTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上密碼", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                
                
                
                
            }
            
        } else if  passwordTxt.text!.isEmpty  || passwordTxt.text!.count < 5{
            
            passwordTxt.text = ""
            
            passwordTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上密碼", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            
            if usernameTxt.text!.isEmpty || usernameTxt.text!.count < 5 {
                
                
                
                usernameTxt.text = ""
                usernameTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上帳號", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                
                
            }
            
        } else {
        
        
        // shortcuts
        let username = usernameTxt.text!.lowercased()
        let password = passwordTxt.text!
        
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
                    
                    
                    isRegistered = true
                    
                    UserDefaults.standard.set(isRegistered, forKey: "isRegistered")
                    
                    UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                    user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                    
                    let id = user?["id"] as? String
                    
                    //抓mapPassed & gamePassed
                    
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
                    
                    
                    //先儲存使用者資訊
                    print(user!)
                    
                    // successfully logged in
                    if id != nil {
                      
                        DispatchQueue.main.async(execute: {
                            print("successfully logged in")
                   
                                  self!.toCourses()
                            
                        })
                    

                    } else {
                        
                        // 抓錯誤訊息
                        DispatchQueue.main.async(execute: {
                            if let errorStatus = parseJSON["status"] as? String{
                                
                                if errorStatus == "403"{
                                    
                                    self?.usernameTxt.text = ""
                                    self?.passwordTxt.text = ""
                                    self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "帳號不存在，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                                    self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                                    
                                    
                                } else if errorStatus == "401"{
                                    
                                    self?.usernameTxt.text = ""
                                    self?.passwordTxt.text = ""
                                    self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "密碼不正確，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                                    self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                                    
                                    
                                }
                                
                                
                            }
                        })
                        return
                        
                    }
                    
                } catch {
                    
                    // get main queue to communicate back to user
                    DispatchQueue.main.async(execute: {
                        self?.usernameTxt.text = ""
                        self?.passwordTxt.text = ""
                        self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "登入錯誤，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                        self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                        
                        
                    })
                    return
                    
                }
                
            } else {
                
                // get main queue to communicate back to user
                DispatchQueue.main.async(execute: {
                    let message = error!.localizedDescription
                    print(message)
                    self?.usernameTxt.text = ""
                    self?.passwordTxt.text = ""
                    self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "登入錯誤，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                    self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                })
                return
                
            }
            
            }.resume()
        }
    }
    
    func toCourses(){
        
        performSegue(withIdentifier: "toCoursesVc", sender: self)
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "toCoursesVc"{
            
            let destineVc = segue.destination as! CoursesViewController
            destineVc.isWelcome = isWelcome
            
            
        }
    }
    
    @IBAction func fbLoginClicked(_ sender: Any) {
        
        
        let loginManager = LoginManager()
        
        
        
        
        loginManager.logIn(readPermissions: [.publicProfile,.email], viewController: self) { [weak self](loginResult) in
            
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
        let body = "username=&password=&fbid=\(fbid)&nickname=\(nickname)&coursePlayed=&ava=\(ava)"
        
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
                        
                        //第一次玩
                        //儲存mapPassed & gamePassed的初始值
                        

                        let mapPassedInt = user?["mapPassed"] as? String
                        let gamePassedInt = user?["gamePassed"] as? String

                        var gp:[Int:Int]?
                        gp = [Int((gamePassedInt?.components(separatedBy: ":")[0])!)!:Int((gamePassedInt?.components(separatedBy: ":")[1])!)!]
                        let mapPassedInt2 = user?["mapPassed2"] as? String
                        let gamePassedInt2 = user?["gamePassed2"] as? String
                        
                        var gp2:[Int:Int]?
                        gp2 = [Int((gamePassedInt2?.components(separatedBy: ":")[0])!)!:Int((gamePassedInt2?.components(separatedBy: ":")[1])!)!]

                        let mapPassedInt3 = user?["mapPassed3"] as? String
                        let gamePassedInt3 = user?["gamePassed3"] as? String
                        
                        var gp3:[Int:Int]?
                        gp3 = [Int((gamePassedInt3?.components(separatedBy: ":")[0])!)!:Int((gamePassedInt3?.components(separatedBy: ":")[1])!)!]

                        
                        
                        
                        let userDefaults = UserDefaults.standard
                        
                        userDefaults.set(Int(mapPassedInt!), forKey: "mapPassed")
                        
                        
                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gp!)
                        userDefaults.set(encodedObject, forKey: "gamePassed")
                        
                        
                        userDefaults.set(Int(mapPassedInt2!), forKey: "mapPassed2")
                        
                        
                        let encodedObject2 = NSKeyedArchiver.archivedData(withRootObject: gp2!)
                        userDefaults.set(encodedObject2, forKey: "gamePassed2")
                        

                        userDefaults.set(Int(mapPassedInt3!), forKey: "mapPassed3")
                        
                        
                        let encodedObject3 = NSKeyedArchiver.archivedData(withRootObject: gp3!)
                        userDefaults.set(encodedObject3, forKey: "gamePassed3")
                        
                        isRegistered = true
                        
                        UserDefaults.standard.set(isRegistered, forKey: "isRegistered")
                        
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
                          
                                self!.toCourses()
                                
                              
                            })
                            
                            // error
                            
                            print(user)
                            
                        } else {
                            
                            // get main queue to communicate back to user
                            DispatchQueue.main.async(execute: {
                                
                                print("1")
                                self?.usernameTxt.text = ""
                                self?.passwordTxt.text = ""
                                self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "此帳號已存在，請重新輸入", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                                self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                                
                            })
                            return
                            
                        }
                        
                        
                    } catch {
                        
                        // get main queue to communicate back to user
                        DispatchQueue.main.async(execute: {
                            
                            print("2")
                            self?.usernameTxt.text = ""
                            self?.passwordTxt.text = ""
                            self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "帳號輸入有誤，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                            self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "密碼輸入有誤，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
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
                    self?.usernameTxt.text = ""
                    self?.passwordTxt.text = ""
                    self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "帳號輸入有誤，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                    self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "密碼輸入有誤，請再試一次", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                })
                return
                
            }
            
            // launch prepared session
            }.resume()
        
        
        
        
        
        
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        usernameTxt.placeholder = nil
        passwordTxt.placeholder = nil
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }

    
}
