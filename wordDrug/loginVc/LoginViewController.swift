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
    
    var activityIndicator = UIActivityIndicatorView()

    @IBOutlet weak var registerLaterBtn: UIButton!
    
    var isFromCourse = false
    
    var orLabel = UILabel()
    var attrs: [NSAttributedStringKey: NSObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dif: CGFloat!
        var fontSize: CGFloat!
        var cornerRadiusValue: CGFloat!
        
        switch height {
            
        case 1366, 1336, 1112:
            print("big iPad")
            
            
            dif = 2

            fontSize = 28
            cornerRadiusValue = 12
            
            
        case 1024:
            
            print("small iPad")
            
            dif = 1.5

            fontSize = 22
            cornerRadiusValue = 12
            
        case 812:
            
            
            dif = 1
            fontSize = 14
            cornerRadiusValue = 6

            
            
        case 736:
            
            dif = 1
            fontSize = 14
            cornerRadiusValue = 6
            

            
            
        case 667:
            
            
            dif = 1
            fontSize = 14
            cornerRadiusValue = 6
 
            
            
        case 568:
            
            dif = 0.9
            fontSize = 14
            cornerRadiusValue = 6

            
        default:
            
            break
        }
        

        //指定delegate才能return
        usernameTxt.delegate = self
        passwordTxt.delegate = self
        
        //placeholder顏色
        /*
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "請輸入帳號", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "請輸入密碼", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        */
        
       
        // Do any additional setup after loading the view.
        
        
        //設定好attrs給其他error使用
        attrs = [NSAttributedStringKey.foregroundColor: UIColor.red,NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSize)]
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100 * dif, height: 100 * dif))
        activityIndicator.layer.zPosition = 15
        let alphaGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.layer.cornerRadius = activityIndicator.frame.width / 20
        activityIndicator.backgroundColor = alphaGray
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.addSubview(activityIndicator)
        
        //bgView是必要的
        bgView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        bgImg.frame = CGRect(x: 0, y: 0, width: width * 1.1, height: height * 1.1)
        bgImg.contentMode = .scaleToFill
        
        
        let logoImg = UIImageView()
        self.view.addSubview(logoImg)
        
        
        logoImg.image = UIImage(named: "launchLogo.png")
        
        logoImg.translatesAutoresizingMaskIntoConstraints = false
        logoImg.widthAnchor.constraint(equalToConstant: 98 * dif).isActive = true
        logoImg.heightAnchor.constraint(equalToConstant: 130 * dif).isActive = true
        logoImg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImg.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 50 * dif).isActive = true

        
       
        
        /* 之後整個outLet 要刪掉
        logoLabel.frame = CGRect(x: 0, y: height / 11, width: width, height: 98)
        logoLabel.font = UIFont(name: "Helvetica Bold", size: 30)
        logoLabel.textColor = .clear
        logoLabel.text = "MissWord\n我的單字老師"
        logoLabel.textAlignment = .center
        logoLabel.numberOfLines = 0
 */
        
        
        
        
        
        //doubleLine.frame = CGRect(x: (width - 290) / 2, y: logoLabel.frame.maxY, width: 290, height: 6)
        doubleLine.image = UIImage(named: "doubleLine.png")
        doubleLine.contentMode = .scaleAspectFit
        
        
        
        doubleLine.translatesAutoresizingMaskIntoConstraints = false
        doubleLine.widthAnchor.constraint(equalToConstant: 302 * dif).isActive = true
        doubleLine.heightAnchor.constraint(equalToConstant: 6 * dif).isActive = true
        doubleLine.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doubleLine.topAnchor.constraint(equalTo: logoImg.bottomAnchor, constant: 20 * dif).isActive = true
        
        
        
        subTitleLabel.text = "立即註冊新帳號\n每日免費7分鐘學習新單字！"
        //subTitleLabel.frame = CGRect(x: 0, y: doubleLine.frame.maxY + 10, width: width, height: 50)
        subTitleLabel.font = UIFont(name: "Helvetica Bold", size: fontSize * 1.2)
        subTitleLabel.textAlignment = .center
        subTitleLabel.numberOfLines = 0
        
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.widthAnchor.constraint(equalToConstant: 300 * dif).isActive = true
        subTitleLabel.heightAnchor.constraint(equalToConstant: 50 * dif).isActive = true
        subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subTitleLabel.topAnchor.constraint(equalTo: doubleLine.bottomAnchor, constant: 5 * dif).isActive = true


        
        
        //accountPng.frame = CGRect(x: (width - 302) / 2, y: subTitleLabel.frame.maxY + 10, width: 302, height: 42)
        
        accountPng.image = UIImage(named: "newAccountPng.png")
        
        accountPng.translatesAutoresizingMaskIntoConstraints = false
        accountPng.widthAnchor.constraint(equalToConstant: 302 * dif).isActive = true
        accountPng.heightAnchor.constraint(equalToConstant: 42 * dif).isActive = true
        accountPng.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        accountPng.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 5 * dif).isActive = true
        
       // usernameTxt.frame = CGRect(x: accountPng.frame.minX + accountPng.frame.width / 7, y: accountPng.frame.minY, width: accountPng.frame.width * 4 / 5, height: accountPng.frame.height)
        
        
     
        
        
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上帳號", attributes:  [NSAttributedStringKey.foregroundColor: darkTextColor,NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSize)])
        usernameTxt.font = usernameTxt.font?.withSize(fontSize)
        usernameTxt.translatesAutoresizingMaskIntoConstraints = false
        usernameTxt.widthAnchor.constraint(equalToConstant: 220 * dif).isActive = true
        usernameTxt.heightAnchor.constraint(equalToConstant: 42 * dif).isActive = true
        usernameTxt.centerXAnchor.constraint(equalTo: accountPng.centerXAnchor).isActive = true
        usernameTxt.centerYAnchor.constraint(equalTo: accountPng.centerYAnchor).isActive = true
        //usernameTxt.backgroundColor = .red
        usernameTxt.adjustsFontSizeToFitWidth = true
        
        
        //passwordPng.frame = CGRect(x: accountPng.frame.minX, y: accountPng.frame.maxY + 10, width: 302, height: 42)
        passwordPng.image = UIImage(named: "newPasswordPng.png")
 
        passwordPng.translatesAutoresizingMaskIntoConstraints = false
        passwordPng.widthAnchor.constraint(equalToConstant: 302 * dif).isActive = true
        passwordPng.heightAnchor.constraint(equalToConstant: 42 * dif).isActive = true
        passwordPng.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordPng.topAnchor.constraint(equalTo: accountPng.bottomAnchor, constant: 5 * dif).isActive = true
        
        
     
        /*
        passwordTxt.frame = CGRect(x: usernameTxt.frame.minX, y: passwordPng.frame.minY, width:
            usernameTxt.frame.width, height: passwordPng.frame.height)
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上密碼", attributes: [NSAttributedStringKey.foregroundColor: darkTextColor])
        */
        
        
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上帳號", attributes: [NSAttributedStringKey.foregroundColor: darkTextColor,NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSize)])
        passwordTxt.font = passwordTxt.font?.withSize(fontSize)
        passwordTxt.translatesAutoresizingMaskIntoConstraints = false
        passwordTxt.widthAnchor.constraint(equalToConstant: 220 * dif).isActive = true
        passwordTxt.heightAnchor.constraint(equalToConstant: 42 * dif).isActive = true
        passwordTxt.centerXAnchor.constraint(equalTo: passwordPng.centerXAnchor).isActive = true
        passwordTxt.centerYAnchor.constraint(equalTo: passwordPng.centerYAnchor).isActive = true
        //passwordTxt.backgroundColor = .red
        passwordTxt.adjustsFontSizeToFitWidth = true

        
        
        
        //loginBtn.frame = CGRect(x: passwordPng.frame.maxX - 142, y: passwordPng.frame.maxY + 10, width: 138, height: 35)

        loginBtn.clipsToBounds = true
        loginBtn.titleLabel?.textAlignment = .center
        loginBtn.setTitle("登入", for: .normal)
        loginBtn.titleLabel?.font = loginBtn.titleLabel?.font.withSize(fontSize)
        
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.widthAnchor.constraint(equalToConstant: 138 * dif).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 35 * dif).isActive = true
        loginBtn.leadingAnchor.constraint(equalTo: passwordPng.leadingAnchor).isActive = true
        loginBtn.topAnchor.constraint(equalTo: passwordPng.bottomAnchor, constant: 8 * dif).isActive = true
        loginBtn.layer.cornerRadius = cornerRadiusValue
        
        
        
        //registerBtn.frame = CGRect(x: passwordPng.frame.minX, y: passwordPng.frame.maxY + 10, width: 138, height: 35)
        
        //registerBtn.layer.cornerRadius = registerBtn.frame.width / 40
        registerBtn.clipsToBounds = true
        registerBtn.titleLabel?.textAlignment = .center
        registerBtn.setTitle("註冊", for: .normal)
        
        registerBtn.titleLabel?.font = registerBtn.titleLabel?.font.withSize(fontSize)
        
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        registerBtn.widthAnchor.constraint(equalToConstant: 138 * dif).isActive = true
        registerBtn.heightAnchor.constraint(equalToConstant: 35 * dif).isActive = true
        registerBtn.trailingAnchor.constraint(equalTo: passwordPng.trailingAnchor).isActive = true
        registerBtn.topAnchor.constraint(equalTo: passwordPng.bottomAnchor, constant: 8 * dif).isActive = true
        registerBtn.layer.cornerRadius = cornerRadiusValue
        
        
        
        //fbLoginBtn.frame = CGRect(x: passwordPng.frame.minX, y: registerBtn.frame.maxY * 1.02, width: passwordPng.frame.width, height: 35)
        
        
        //fbLoginBtn.layer.cornerRadius = fbLoginBtn.frame.width / 40
        fbLoginBtn.clipsToBounds = true
        fbLoginBtn.titleLabel?.textAlignment = .center
        fbLoginBtn.setTitle("使用facebook登入", for: .normal)
        fbLoginBtn.titleLabel?.font = fbLoginBtn.titleLabel?.font.withSize(fontSize)
        
        
        fbLoginBtn.translatesAutoresizingMaskIntoConstraints = false
        fbLoginBtn.widthAnchor.constraint(equalToConstant: 302 * dif).isActive = true
        fbLoginBtn.heightAnchor.constraint(equalToConstant: 42 * dif).isActive = true
        fbLoginBtn.topAnchor.constraint(equalTo: registerBtn.bottomAnchor, constant: 5 * dif).isActive = true
        fbLoginBtn.centerXAnchor.constraint(equalTo: passwordPng.centerXAnchor).isActive = true
        fbLoginBtn.layer.cornerRadius = cornerRadiusValue

      
        
        //doubleLine2.frame = CGRect(x: doubleLine.frame.minX, y: fbLoginBtn.frame.maxY + 10, width: doubleLine.frame.width, height: doubleLine.frame.height)
        doubleLine2.image = UIImage(named: "doubleLine.png")
        doubleLine2.contentMode = .scaleAspectFit
        doubleLine2.translatesAutoresizingMaskIntoConstraints = false
        doubleLine2.widthAnchor.constraint(equalToConstant: 302 * dif).isActive = true
        doubleLine2.heightAnchor.constraint(equalToConstant: 6 * dif).isActive = true
        doubleLine2.topAnchor.constraint(equalTo: fbLoginBtn.bottomAnchor, constant: 5 * dif).isActive = true
        doubleLine2.centerXAnchor.constraint(equalTo: passwordPng.centerXAnchor).isActive = true

        
        

        //orLabel.frame = CGRect(x: doubleLine2.frame.minX, y: doubleLine2.frame.maxY + 10, width: doubleLine2.frame.width, height: 10)
 
        orLabel.textColor = .white
        orLabel.font = orLabel.font.withSize(fontSize)
        orLabel.textAlignment = .center
        orLabel.text = "或"
        self.view.addSubview(orLabel)
        //orLabel.backgroundColor = .green
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        orLabel.widthAnchor.constraint(equalToConstant: 60 * dif).isActive = true
        orLabel.heightAnchor.constraint(equalToConstant: 20 * dif).isActive = true
        orLabel.topAnchor.constraint(equalTo: doubleLine2.bottomAnchor, constant: 5 * dif).isActive = true
        orLabel.centerXAnchor.constraint(equalTo: passwordPng.centerXAnchor).isActive = true
        
        
        
        
        //registerLaterBtn.center = CGPoint(x: width / 2, y: orLabel.frame.maxY + 23)
        //registerLaterBtn.frame.size = CGSize(width: 183 , height: 33)
        registerLaterBtn.setTitle("先試用，晚點再註冊", for: .normal)
        registerLaterBtn.titleLabel?.font = registerLaterBtn.titleLabel?.font.withSize(fontSize)

        registerLaterBtn.translatesAutoresizingMaskIntoConstraints = false
        registerLaterBtn.widthAnchor.constraint(equalToConstant: 183 * dif).isActive = true
        registerLaterBtn.heightAnchor.constraint(equalToConstant: 33 * dif).isActive = true
        registerLaterBtn.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 5 * dif).isActive = true
        registerLaterBtn.centerXAnchor.constraint(equalTo: passwordPng.centerXAnchor).isActive = true
        
        
        
        /*
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
         
         */
        
        
   
        
        
        
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        if isFromCourse{
            orLabel.isHidden = false
            registerLaterBtn.isHidden = false
        } else {
            

            orLabel.isHidden = true
            registerLaterBtn.isHidden = true
            
        }
    }

    
    //註冊功能
    @IBAction func registerClick(_ sender: Any) {
        
        
        if usernameTxt.text!.isEmpty || usernameTxt.text!.count < 5 {
            

            usernameTxt.text = ""
            usernameTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上帳號", attributes: attrs)
            
            if  passwordTxt.text!.isEmpty  || passwordTxt.text!.count < 5{
                
                passwordTxt.text = ""
                
                passwordTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上密碼", attributes: attrs)

                
            }
            
        } else if  passwordTxt.text!.isEmpty  || passwordTxt.text!.count < 5{
            
            passwordTxt.text = ""
            
            passwordTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上密碼", attributes: attrs)
            
            if usernameTxt.text!.isEmpty || usernameTxt.text!.count < 5 {
                
                
                
                usernameTxt.text = ""
                usernameTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上帳號", attributes: attrs)
                
                
            }
            
        } else {
            
      
            
          
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            

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
                            
                            
                            self!.activityIndicator.stopAnimating()
                            UIApplication.shared.endIgnoringInteractionEvents()
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
        
                        userDefaults.set(mapPassed3!, forKey: "mapPassed3")
                        
                        gamePassed3 = [0:0]
                        
                        let encodedObject3 = NSKeyedArchiver.archivedData(withRootObject: gamePassed3!)
                        userDefaults.set(encodedObject3, forKey: "gamePassed3")
                        
                        
                        mapPassed4 = 0
                        
                        userDefaults.set(mapPassed4!, forKey: "mapPassed4")
                        
                        gamePassed4 = [0:0]
                        
                        let encodedObject4 = NSKeyedArchiver.archivedData(withRootObject: gamePassed4!)
                        userDefaults.set(encodedObject4, forKey: "gamePassed4")

                        
                        //全新註冊者重新算秒數
                        UserDefaults.standard.set(420, forKey: "limitSeconds")
                        
                        
                        isRegistered = true
                        
                        UserDefaults.standard.set(isRegistered, forKey: "isRegistered")

                        
                        // get id from parseJSON dictionary
                        let id = user?["id"] as? String

                        // successfully registered
                        if id != nil {

                            //登入
                                DispatchQueue.main.async(execute: {
                                    
                                    self!.activityIndicator.stopAnimating()
                                    UIApplication.shared.endIgnoringInteractionEvents()
                             
                                    //暫時留著之後可能可以使用
                                    self!.isWelcome = true
                                 
                                    if self!.isFromCourse{
                                        
                                        self!.dismiss(animated: true, completion: nil)
                                        
                                    } else {
                                    
                                    self!.toCourses()
                                    }
                                    
                                })
                                
                            // error
                            
                            
                        } else {
                            
                            // get main queue to communicate back to user
                            DispatchQueue.main.async(execute: {
                                
                                self!.activityIndicator.stopAnimating()
                                UIApplication.shared.endIgnoringInteractionEvents()
                                
                                self?.usernameTxt.text = ""
                                self?.passwordTxt.text = ""
                                self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "此帳號已存在，請重新輸入", attributes: self!.attrs)
                                self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: self!.attrs)
                                
                            })
                            return
                            
                        }
                        
                        
                    } catch {
                        
                        // get main queue to communicate back to user
                        DispatchQueue.main.async(execute: {
                            
                            self!.activityIndicator.stopAnimating()
                            UIApplication.shared.endIgnoringInteractionEvents()
                            
                                     print("2")
                            self?.usernameTxt.text = ""
                            self?.passwordTxt.text = ""
                            self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "帳號輸入有誤，請再試一次", attributes: self!.attrs)
                            self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "密碼輸入有誤，請再試一次", attributes: self!.attrs)
                        })
                        return
                        
                    }
                    
                })
                
                // if unable to proceed request
            } else {
                
                // get main queue to communicate back to user
                DispatchQueue.main.async(execute: {
                    
                    
                    self!.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                             print("3")
                    let message = error!.localizedDescription
                    print(message)
                    self?.usernameTxt.text = ""
                    self?.passwordTxt.text = ""
                    self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "帳號輸入有誤，請再試一次", attributes: self!.attrs)
                    self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "密碼輸入有誤，請再試一次", attributes: self!.attrs)
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
            usernameTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上帳號", attributes: attrs)
            
            if  passwordTxt.text!.isEmpty  || passwordTxt.text!.count < 5{
                
                passwordTxt.text = ""
                
                passwordTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上密碼", attributes: attrs)

            }
            
        } else if  passwordTxt.text!.isEmpty  || passwordTxt.text!.count < 5{
            
            passwordTxt.text = ""
            
            passwordTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上密碼", attributes: attrs)
            
            if usernameTxt.text!.isEmpty || usernameTxt.text!.count < 5 {
                
                
                
                usernameTxt.text = ""
                usernameTxt.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上帳號", attributes: attrs)
                
                
            }
            
        } else {
        
            
        
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
        
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
                        self!.activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        return
                    }
                    
                    
                    isRegistered = true
                    
                    UserDefaults.standard.set(isRegistered, forKey: "isRegistered")
                    
                    
                             //先儲存使用者資訊
                    UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                    user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                    
             
                    
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
                    
                    if let mapPassed4String = user?["mapPassed4"] as! String?{
                        
                        mapPassed4 = Int(mapPassed4String)!
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(mapPassed4!, forKey: "mapPassed4")
                        
                        print("retrieve mapPassed:\(mapPassed4!)")
                        
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
                    
                    
                    if let gamePassed4String = user?["gamePassed4"] as! String?{
                        
                        let gamePassed4StringArray = gamePassed4String.components(separatedBy: ":")
                        
                        let s = gamePassed4StringArray[0]
                        let u = gamePassed4StringArray[1]
                        gamePassed4 = [Int(s)!:Int(u)!]
                        
                        let userDefaults = UserDefaults.standard
                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed4!)
                        
                        print("retrieve gamePassed:\(gamePassed4!)")
                        userDefaults.set(encodedObject, forKey: "gamePassed4")
                        
                    }
                    
                    
           
                    print(user!)
                    
                    
                  
                    let id = user?["id"] as? String
                    
                    // successfully logged in
                    if id != nil {
                      
                        DispatchQueue.main.async(execute: {
                            print("successfully logged in")
                            
                            self!.activityIndicator.stopAnimating()
                            UIApplication.shared.endIgnoringInteractionEvents()
                   
                            
                            if self!.isFromCourse{
                                
                                self!.dismiss(animated: true, completion: nil)
                                
                            } else {
                                
                                self!.toCourses()
                            }
                        })
                    

                    } else {
                        
                        // 抓錯誤訊息
                        DispatchQueue.main.async(execute: {
                            
                            self!.activityIndicator.stopAnimating()
                            UIApplication.shared.endIgnoringInteractionEvents()
                            
                            if let errorStatus = parseJSON["status"] as? String{
                                
                                if errorStatus == "403"{
                                    
                                    self?.usernameTxt.text = ""
                                    self?.passwordTxt.text = ""
                                    self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "帳號不存在，請再試一次", attributes: self!.attrs)
                                    self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: self!.attrs)
                                    
                                    
                                } else if errorStatus == "401"{
                                    
                                    self?.usernameTxt.text = ""
                                    self?.passwordTxt.text = ""
                                    self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "密碼不正確，請再試一次", attributes: self!.attrs)
                                    self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: self!.attrs)
                                    
                                    
                                }
                                
                                
                            }
                        })
                        return
                        
                    }
                    
                } catch {
                    
                    // get main queue to communicate back to user
                    DispatchQueue.main.async(execute: {
                        
                        self!.activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        
                        
                        self?.usernameTxt.text = ""
                        self?.passwordTxt.text = ""
                        self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "登入錯誤，請再試一次", attributes: self!.attrs)
                        self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: self!.attrs)
                        
                        
                    })
                    return
                    
                }
                
            } else {
                
                // get main queue to communicate back to user
                DispatchQueue.main.async(execute: {
                    
                    self!.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    let message = error!.localizedDescription
                    print(message)
                    self?.usernameTxt.text = ""
                    self?.passwordTxt.text = ""
                    self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "登入錯誤，請再試一次", attributes: self!.attrs)
                    self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: self!.attrs)
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
            
            //暫時保留以後可以做歡迎畫面
            let destineVc = segue.destination as! CoursesViewController
            destineVc.isWelcome = isWelcome
            
        }
    }
    
    @IBAction func fbLoginClicked(_ sender: Any) {
        
        
        let loginManager = LoginManager()
        
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        loginManager.logIn(readPermissions: [.publicProfile,.email], viewController: self) { [weak self](loginResult) in
            
            switch loginResult{
            case .failed(let error):
                print(error)
                self!.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
            //失敗的時候回傳
            case .cancelled:
                print("the user cancels login")
                self!.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
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
                self!.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
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
    
    
    
    @IBAction func registerLaterBtnClicked(_ sender: Any) {
        
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func fbRegister(fbid:String,nickname:String, ava:String){

        // shortcuts
        
        //檢查註冊
        // url to php file
        let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/register.php")!
        
        // request to this file
        var request = URLRequest(url: url)
        
        // method to pass data to this file (e.g. via POST)
        request.httpMethod = "POST"
        
        // body to be appended to url, 讓nickname = 註冊帳號
        let body = "username=&password=&fbid=\(fbid)&nickname=\(nickname)&coursePlayed=&ava="
        
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
                            self!.activityIndicator.stopAnimating()
                            UIApplication.shared.endIgnoringInteractionEvents()
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

                        
                        let mapPassedInt4 = user?["mapPassed4"] as? String
                        let gamePassedInt4 = user?["gamePassed4"] as? String
                        
                        var gp4:[Int:Int]?
                        gp4 = [Int((gamePassedInt4?.components(separatedBy: ":")[0])!)!:Int((gamePassedInt4?.components(separatedBy: ":")[1])!)!]
                        
                        
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
                        
                        
                        userDefaults.set(Int(mapPassedInt4!), forKey: "mapPassed4")
                        
                        
                        let encodedObject4 = NSKeyedArchiver.archivedData(withRootObject: gp4!)
                        userDefaults.set(encodedObject4, forKey: "gamePassed4")
                        
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
                                self!.activityIndicator.stopAnimating()
                                UIApplication.shared.endIgnoringInteractionEvents()
                          
                                
                                if self!.isFromCourse{
                                    
                                    self!.dismiss(animated: true, completion: nil)
                                    
                                } else {
                                    
                                    self!.toCourses()
                                }
                                
                              
                            })
                            
                            // error
                            
                            print(user)
                            
                        } else {
                            
                            // get main queue to communicate back to user
                            DispatchQueue.main.async(execute: {
                                self!.activityIndicator.stopAnimating()
                                UIApplication.shared.endIgnoringInteractionEvents()
                                
                                print("1")
                                self?.usernameTxt.text = ""
                                self?.passwordTxt.text = ""
                                self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "此帳號已存在，請重新輸入", attributes: self!.attrs)
                                self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: self!.attrs)
                                
                            })
                            return
                            
                        }
                        
                        
                    } catch {
                        
                        // get main queue to communicate back to user
                        DispatchQueue.main.async(execute: {
                            
                            self!.activityIndicator.stopAnimating()
                            UIApplication.shared.endIgnoringInteractionEvents()
                            
                            print("2")
                            self?.usernameTxt.text = ""
                            self?.passwordTxt.text = ""
                            self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "帳號輸入有誤，請再試一次", attributes: self!.attrs)
                            self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "密碼輸入有誤，請再試一次", attributes: self!.attrs)
                        })
                        return
                        
                    }
                    
                })
                
                // if unable to proceed request
            } else {
                
                // get main queue to communicate back to user
                DispatchQueue.main.async(execute: {
                    
                    self!.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    print("3")
                    let message = error!.localizedDescription
                    print(message)
                    self?.usernameTxt.text = ""
                    self?.passwordTxt.text = ""
                    self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "帳號輸入有誤，請再試一次", attributes: self!.attrs)
                    self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "密碼輸入有誤，請再試一次", attributes: self!.attrs)
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
    
    deinit {
        print("login deinit")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }

    
}
