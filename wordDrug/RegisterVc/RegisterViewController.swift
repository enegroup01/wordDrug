//
//  RegisterViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/6/4.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit
//import FacebookLogin
import FBSDKLoginKit
//import FacebookCore
import FBSDKCoreKit



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
    
    //MARK: simVer K12 新增變數供註冊紀錄使用
    var k12MapNumber = Int()
    
    var myWrongWords = [String]()
    
    //用來計算錯誤字是否已加入
    var wrongWordsCounts = 0
    
    var activityIndicator = UIActivityIndicatorView()
    
    var attrs: [NSAttributedStringKey: NSObject]!
    
    let regOrPlay = NSLocalizedString("registerVC.regOrPlay", comment: "")
    let isPurchasedTitleLabel = NSLocalizedString("registerVC.isPurchasedTitleLabel", comment: "")
      let startYourLearningPlan = NSLocalizedString("registerVC.startYourLearningPlan", comment: "")
    let accountPlaceholder = NSLocalizedString("registerVC.accountPlaceholder", comment: "")
    let passwordPlaceholder = NSLocalizedString("registerVC.passwordPlaceholder", comment: "")
    let registerBtnLabelText = NSLocalizedString("registerVC.registerBtnLabelText", comment: "")
    
    let fbWechatLoginBtnText = NSLocalizedString("registerVC.fbWechatLoginBtnText", comment: "")

    let commercialLine1 = NSLocalizedString("registerVC.commercialLine1", comment: "")
    let commercialLine2 = NSLocalizedString("registerVC.commercialLine2", comment: "")
    let commercialLine3 = NSLocalizedString("registerVC.commercialLine3", comment: "")
    let commercialLine4 = NSLocalizedString("registerVC.commercialLine4", comment: "")
    let commercialLine5 = NSLocalizedString("registerVC.commercialLine5", comment: "")
    let commercialLine6 = NSLocalizedString("registerVC.commercialLine6", comment: "")
    let commercialLine7 = NSLocalizedString("registerVC.commercialLine7", comment: "")
    
    let errorAccountExist = NSLocalizedString("registerVC.errorAccountExist", comment: "")
    
    let errorText = NSLocalizedString("registerVC.errorText", comment: "")
    
    let errorWrongAccount = NSLocalizedString("registerVC.errorWrongAccount", comment: "")
    
    let errorWrongPassword = NSLocalizedString("registerVC.errorWrongPassword", comment: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        var dif: CGFloat!
        var fontSize: CGFloat!
        var cornerRadiusValue: CGFloat!
        
        switch height {
            
        case 1366, 1336, 1112:
            //print("big iPad")

            dif = 2
            
            fontSize = 28
            cornerRadiusValue = 12
            
        case 1024:
            
   
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
            
          
            dif = 0.8
            fontSize = 12
            cornerRadiusValue = 6
        
        default:
            dif = 1
            fontSize = 14
            cornerRadiusValue = 6
           
            break
          
        }
        
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
        

        registerBg.image = UIImage(named: "launchBg.png")
 
        
        registerBg.frame = CGRect(x: 0, y: 0, width: width * 1.1, height: height * 1.1)
        registerBg.contentMode = .scaleToFill

        
        let logoImg = UIImageView()
        self.view.addSubview(logoImg)
        
        
        logoImg.image = UIImage(named: "logoAlpha.png")
        
        logoImg.translatesAutoresizingMaskIntoConstraints = false
        logoImg.widthAnchor.constraint(equalToConstant: 135 * dif).isActive = true
        logoImg.heightAnchor.constraint(equalToConstant: 131 * dif).isActive = true
        logoImg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImg.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 50 * dif).isActive = true
        
        //titleLabel.frame = CGRect(x: 0, y: height / 11, width: width, height: 98)
        titleLabel.font = UIFont(name: "Helvetica Bold", size: fontSize * 2.5)
        titleLabel.textColor = .white
        titleLabel.text = regOrPlay
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.layer.zPosition = 5
        //titleLabel.backgroundColor = .green
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 98 * dif).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 50 * dif).isActive = true
        
        
         let isPurchased = UserDefaults.standard.object(forKey: "isPurchased") as! Bool
        
        
        //這個購買前要先註冊的code應該也已經用不到了
        if isDirectedHere{
            
            titleLabel.text = "註冊帳號完後\n即可購買無限學習時間"
        }
        
        if isPurchased{
            //有買了
            
            titleLabel.text = isPurchasedTitleLabel
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
        
        
        /*
        doubleLine.frame = CGRect(x: (width - 290) / 2, y: titleLabel.frame.maxY, width: 290, height: 6)
        doubleLine.image = UIImage(named: "doubleLine.png")
        doubleLine.contentMode = .scaleAspectFit
        */
        doubleLine.image = UIImage(named: "doubleLine.png")
        doubleLine.contentMode = .scaleAspectFit
        
        
        
        doubleLine.translatesAutoresizingMaskIntoConstraints = false
        doubleLine.widthAnchor.constraint(equalToConstant: 302 * dif).isActive = true
        doubleLine.heightAnchor.constraint(equalToConstant: 6 * dif).isActive = true
        doubleLine.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doubleLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20 * dif).isActive = true

        /*
        subTitleLabel.text = "英檢初級，中級，多益滿分等\n所有單字任你學習！"
        subTitleLabel.frame = CGRect(x: 0, y: doubleLine.frame.maxY + 10, width: width, height: 50)
        subTitleLabel.font = UIFont(name: "Helvetica Bold", size: 18)
        subTitleLabel.textAlignment = .center
        subTitleLabel.numberOfLines = 0
        */
        
        subTitleLabel.text = startYourLearningPlan
        
        subTitleLabel.font = UIFont(name: "Helvetica Bold", size: fontSize * 1.2)
        subTitleLabel.textAlignment = .center
        subTitleLabel.numberOfLines = 0
        
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.widthAnchor.constraint(equalToConstant: 300 * dif).isActive = true
        subTitleLabel.heightAnchor.constraint(equalToConstant: 50 * dif).isActive = true
        subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subTitleLabel.topAnchor.constraint(equalTo: doubleLine.bottomAnchor, constant: 5 * dif).isActive = true
        
        
        accountPng.image = UIImage(named: "newAccountPng.png")
        
        accountPng.translatesAutoresizingMaskIntoConstraints = false
        accountPng.widthAnchor.constraint(equalToConstant: 302 * dif).isActive = true
        accountPng.heightAnchor.constraint(equalToConstant: 42 * dif).isActive = true
        accountPng.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        accountPng.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 5 * dif).isActive = true

        
        accountTextField.attributedPlaceholder = NSAttributedString(string:accountPlaceholder, attributes:  [NSAttributedStringKey.foregroundColor: darkTextColor,NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSize)])
        accountTextField.font = accountTextField.font?.withSize(fontSize)
        accountTextField.translatesAutoresizingMaskIntoConstraints = false
        accountTextField.widthAnchor.constraint(equalToConstant: 250 * dif).isActive = true
        accountTextField.heightAnchor.constraint(equalToConstant: 42 * dif).isActive = true
        //accountTextField.centerXAnchor.constraint(equalTo: accountPng.centerXAnchor).isActive = true
        
        accountTextField.leadingAnchor.constraint(equalTo: loginBtn.centerXAnchor, constant: -30 * dif).isActive = true
        accountTextField.centerYAnchor.constraint(equalTo: accountPng.centerYAnchor).isActive = true
        //usernameTxt.backgroundColor = .red
        accountTextField.adjustsFontSizeToFitWidth = true
        
        
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
        
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string:passwordPlaceholder, attributes: [NSAttributedStringKey.foregroundColor: darkTextColor,NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSize)])
        passwordTextField.font = passwordTextField.font?.withSize(fontSize)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.widthAnchor.constraint(equalToConstant: 250 * dif).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 42 * dif).isActive = true
        //passwordTextField.centerXAnchor.constraint(equalTo: passwordPng.centerXAnchor).isActive = true
       
        passwordTextField.leadingAnchor.constraint(equalTo: loginBtn.centerXAnchor, constant: -30 * dif).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: passwordPng.centerYAnchor).isActive = true
        //passwordTxt.backgroundColor = .red
        passwordTextField.adjustsFontSizeToFitWidth = true
        
        
        
        
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
        registerBtn.setTitle(registerBtnLabelText, for: .normal)
        
        registerBtn.titleLabel?.font = registerBtn.titleLabel?.font.withSize(fontSize)
        
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        registerBtn.widthAnchor.constraint(equalToConstant: 138 * dif).isActive = true
        registerBtn.heightAnchor.constraint(equalToConstant: 35 * dif).isActive = true
        registerBtn.trailingAnchor.constraint(equalTo: passwordPng.trailingAnchor).isActive = true
        registerBtn.topAnchor.constraint(equalTo: passwordPng.bottomAnchor, constant: 8 * dif).isActive = true
        registerBtn.layer.cornerRadius = cornerRadiusValue
        
        
        
        //fbLoginBtn.frame = CGRect(x: passwordPng.frame.minX, y: registerBtn.frame.maxY * 1.02, width: passwordPng.frame.width, height: 35)
        
        
        //fbLoginBtn.layer.cornerRadius = fbLoginBtn.frame.width / 40
        facebookBtn.clipsToBounds = true
        facebookBtn.titleLabel?.textAlignment = .center
        facebookBtn.setTitle(fbWechatLoginBtnText, for: .normal)
        facebookBtn.titleLabel?.font = facebookBtn.titleLabel?.font.withSize(fontSize)
        
        
        facebookBtn.translatesAutoresizingMaskIntoConstraints = false
        facebookBtn.widthAnchor.constraint(equalToConstant: 302 * dif).isActive = true
        facebookBtn.heightAnchor.constraint(equalToConstant: 42 * dif).isActive = true
        facebookBtn.topAnchor.constraint(equalTo: registerBtn.bottomAnchor, constant: 5 * dif).isActive = true
        facebookBtn.centerXAnchor.constraint(equalTo: passwordPng.centerXAnchor).isActive = true
        facebookBtn.layer.cornerRadius = cornerRadiusValue
        
        
        
        //doubleLine2.frame = CGRect(x: doubleLine.frame.minX, y: fbLoginBtn.frame.maxY + 10, width: doubleLine.frame.width, height: doubleLine.frame.height)
        doubleLine2.image = UIImage(named: "doubleLine.png")
        doubleLine2.contentMode = .scaleAspectFit
        doubleLine2.translatesAutoresizingMaskIntoConstraints = false
        doubleLine2.widthAnchor.constraint(equalToConstant: 302 * dif).isActive = true
        doubleLine2.heightAnchor.constraint(equalToConstant: 6 * dif).isActive = true
        doubleLine2.topAnchor.constraint(equalTo: facebookBtn.bottomAnchor, constant: 5 * dif).isActive = true
        doubleLine2.centerXAnchor.constraint(equalTo: passwordPng.centerXAnchor).isActive = true

        
        //字型顏色
        let attrs0 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: fontSize * 1.2), NSAttributedStringKey.foregroundColor : UIColor.white]
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: fontSize * 1.2), NSAttributedStringKey.foregroundColor : grassGreen]
        let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: fontSize), NSAttributedStringKey.foregroundColor : grassGreen]
        
        
       // doubleLine2.frame = CGRect(x: doubleLine.frame.minX, y: facebookBtn.frame.maxY + 5, width: doubleLine.frame.width, height: doubleLine.frame.height)
        //doubleLine2.image = UIImage(named: "doubleLine.png")
               doubleLine2.contentMode = .scaleAspectFit
        
        //alarmClock.frame = CGRect(x: doubleLine2.frame.minX, y: doubleLine2.frame.maxY + (height - (doubleLine2.frame.maxY)) / 7, width: 30, height: 30)
        
        //textLabel.frame = CGRect(x: alarmClock.frame.maxX + 10, y: alarmClock.frame.minY - 15, width: 256, height: 84)
        
        
        //textLabel.anchor(top: doubleLine2.bottomAnchor, leading: alarmClock.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 5 * dif, left: 5 * dif, bottom: 0, right: 0), size: .init(width: 256 * dif, height: 84 * dif))
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.widthAnchor.constraint(equalToConstant: 256 * dif).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 84 * dif).isActive = true
        textLabel.topAnchor.constraint(equalTo: doubleLine2.bottomAnchor, constant: 5 * dif).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: passwordPng.centerXAnchor, constant: 10 * dif).isActive = true
        
        
        alarmClock.contentMode = .scaleAspectFit
        
        alarmClock.translatesAutoresizingMaskIntoConstraints = false
        alarmClock.widthAnchor.constraint(equalToConstant: 30 * dif).isActive = true
        alarmClock.heightAnchor.constraint(equalToConstant: 30 * dif).isActive = true
        alarmClock.trailingAnchor.constraint(equalTo: textLabel.leadingAnchor, constant: -5 * dif).isActive = true
        alarmClock.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor).isActive = true


        //textLabel.backgroundColor = .red
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 3
        let textContent = NSMutableAttributedString()
        
        let textLabeltext1 = NSMutableAttributedString(string: commercialLine1, attributes: attrs1)
        let textLabelText2 = NSMutableAttributedString(string: commercialLine2, attributes: attrs0)
        let textLabelText3 = NSMutableAttributedString(string: commercialLine3, attributes: attrs2)
        
        textLabel.adjustsFontSizeToFitWidth = true
        textContent.append(textLabeltext1)
        textContent.append(NSAttributedString(string: "\n"))
        textContent.append(textLabelText2)
        textContent.append(NSAttributedString(string: "\n"))
        textContent.append(textLabelText3)
        
        textLabel.attributedText = textContent

        
        
        
        //textLabel2.frame = CGRect(x: textLabel.frame.minX, y: textLabel.frame.maxY + 13, width: textLabel.frame.width, height: 53)
        
        
        textLabel2.translatesAutoresizingMaskIntoConstraints = false
        textLabel2.widthAnchor.constraint(equalToConstant: 256 * dif).isActive = true
        textLabel2.heightAnchor.constraint(equalToConstant: 50 * dif).isActive = true
        textLabel2.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 5 * dif).isActive = true
        textLabel2.centerXAnchor.constraint(equalTo: passwordPng.centerXAnchor, constant: 10 * dif).isActive = true
       
        
        
        //textLabel2.backgroundColor = .blue
        textLabel2.textAlignment = .left
        textLabel2.adjustsFontSizeToFitWidth = true
        let textContent2 = NSMutableAttributedString()
        let textLabel2Text = NSMutableAttributedString(string: commercialLine4, attributes: attrs1)
        let textLabel2Text2 = NSMutableAttributedString(string: commercialLine5, attributes: attrs0)
        textContent2.append(textLabel2Text)
        textContent2.append(textLabel2Text2)
        textLabel2.attributedText = textContent2

        
        //freePng.frame = CGRect(x: alarmClock.frame.minX, y: alarmClock.frame.maxY + alarmClock.frame.height * 2, width: 35, height: 35)

        freePng.contentMode = .scaleAspectFit
        
        freePng.translatesAutoresizingMaskIntoConstraints = false
        freePng.widthAnchor.constraint(equalToConstant: 35 * dif).isActive = true
        freePng.heightAnchor.constraint(equalToConstant: 35 * dif).isActive = true
        freePng.trailingAnchor.constraint(equalTo: textLabel2.leadingAnchor, constant: -5 * dif).isActive = true
        freePng.centerYAnchor.constraint(equalTo: textLabel2.centerYAnchor).isActive = true
    
        
        
        //textLabel3.frame = CGRect(x: textLabel.frame.minX, y: textLabel2.frame.maxY + 20, width: textLabel.frame.width, height: 53)
        //textLabel3.backgroundColor = .green
        textLabel3.textAlignment = .left
        textLabel3.translatesAutoresizingMaskIntoConstraints = false
        textLabel3.widthAnchor.constraint(equalToConstant: 256 * dif).isActive = true
        textLabel3.heightAnchor.constraint(equalToConstant: 50 * dif).isActive = true
        textLabel3.topAnchor.constraint(equalTo: textLabel2.bottomAnchor, constant: 5 * dif).isActive = true
        textLabel3.centerXAnchor.constraint(equalTo: passwordPng.centerXAnchor, constant: 10 * dif).isActive = true
        textLabel3.adjustsFontSizeToFitWidth = true
        
        
        
        let textContent3 = NSMutableAttributedString()
        let textLabel3Text = NSMutableAttributedString(string: commercialLine6, attributes: attrs1)
        let textLabel3Text2 = NSMutableAttributedString(string: commercialLine7, attributes: attrs0)
        textContent3.append(textLabel3Text)
        textContent3.append(textLabel3Text2)
        textLabel3.attributedText = textContent3
        
        
        
        
        
        //freePng2.frame = CGRect(x: alarmClock.frame.minX, y: freePng.frame.maxY + alarmClock.frame.height * 1.5, width: 35, height: 35)
        
        freePng2.contentMode = .scaleAspectFit
        
        freePng2.translatesAutoresizingMaskIntoConstraints = false
        freePng2.widthAnchor.constraint(equalToConstant: 35 * dif).isActive = true
        freePng2.heightAnchor.constraint(equalToConstant: 35 * dif).isActive = true
        freePng2.trailingAnchor.constraint(equalTo: textLabel3.leadingAnchor, constant: -5 * dif).isActive = true
        freePng2.centerYAnchor.constraint(equalTo: textLabel3.centerYAnchor).isActive = true

        
        //print("user:\(user)")
        
        
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
        
        
        
        
        /*  登入按鈕
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
         
         
         loginBtn.frame = CGRect(x: passwordPng.frame.maxX - 142, y: passwordPng.frame.maxY + 10, width: 138, height: 35)
         
         facebookBtn.frame = CGRect(x: passwordPng.frame.minX, y: registerBtn.frame.maxY * 1.02, width: passwordPng.frame.width, height: 35)
         
         */
        
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
            accountTextField.attributedPlaceholder = NSAttributedString(string: accountPlaceholder, attributes: attrs)
            
            if  passwordTextField.text!.isEmpty  || passwordTextField.text!.count < 5{
                
                passwordTextField.text = ""
                
                passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordPlaceholder, attributes: attrs)

                
            }
            
        } else if  passwordTextField.text!.isEmpty  || passwordTextField.text!.count < 5{
            
            passwordTextField.text = ""
            
            passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordPlaceholder, attributes: attrs)
            
            if accountTextField.text!.isEmpty || accountTextField.text!.count < 5 {
                

                accountTextField.text = ""
                accountTextField.attributedPlaceholder = NSAttributedString(string: accountPlaceholder, attributes: attrs)
                
            }
            
        } else {
            
            
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            //print("register")
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
            var body = String()
            
            
            //在此決定後端是否要  + 1
            if isDirectedHere{
                body = "username=\(username)&password=\(password)&fbid=&nickname=\(username)&coursePlayed=&ava="
            } else {
            body = "username=\(username)&password=\(password)&fbid=&nickname=\(username)&coursePlayed=\(coursePlayed)&ava="
            }
            
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
                            
                            
                            
                            
                            /*
                            //第一次玩
                            //儲存mapPassed & gamePassed的初始值
                            
                            
                            mapPassed = 0
                            
                            gamePassed = [0:0]
                            
                            mapPassed2 = 0
                            
                            gamePassed2 = [0:0]
                            
                            mapPassed3 = 0
                            
                            gamePassed3 = [0:0]
                            
                            
                            if self!.isDirectedHere == false{
                            
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
                            } else {
                                
                                print("不需要修改關卡數, 因為沒有玩過")
                                
                                
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
                            */
                            
                            isRegistered = true
                            
                            UserDefaults.standard.set(isRegistered, forKey: "isRegistered")
                            
                            
                            //全新註冊者重新設定秒數
                            UserDefaults.standard.set(420, forKey: "limitSeconds")
                            
                            
                            //MARK: must update
                            //MARK: simVer 增加值


                            // Part 1. 登入者抓所有數值, 在此這些數字應該都為0
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
                            if let mapPassed5String = user?["mapPassed5"] as! String?{
                                
                                mapPassed5 = Int(mapPassed5String)!
                                
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(mapPassed5!, forKey: "mapPassed5")
                                
                                print("retrieve mapPassed:\(mapPassed5!)")
                                
                            }
                            
                            
                            //MARK: simVer K12 特別作法
                            if let mapPassed6String = user?["mapPassed6"] as! String?{
                                var mapPassedStringArray = mapPassed6String.components(separatedBy: ";")
                                
                                for i in 0 ..< mapPassedStringArray.count {
                                    
                                    //避免最後一位空值
                                    if mapPassedStringArray[i] != "" {
                                        
                                        k12MapPassed[i] = Int(mapPassedStringArray[i])!
                                    }
                                    
                                }
                                
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(k12MapPassed, forKey: "mapPassed6")
                                
                                print("retrieve mapPassed:\(k12MapPassed!)")
                                
                            }
                            
//                            if let mapPassed6String = user?["mapPassed6"] as! String?{
//
//                                mapPassed6 = Int(mapPassed6String)!
//
//                                let userDefaults = UserDefaults.standard
//                                userDefaults.set(mapPassed6!, forKey: "mapPassed6")
//
//                                print("retrieve mapPassed:\(mapPassed6!)")
//
//                            }
                            
                            if let mapPassed7String = user?["mapPassed7"] as! String?{
                                
                                mapPassed7 = Int(mapPassed7String)!
                                
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(mapPassed7!, forKey: "mapPassed7")
                                
                                print("retrieve mapPassed:\(mapPassed7!)")
                                
                            }
                            
                            if let mapPassed8String = user?["mapPassed8"] as! String?{
                                
                                mapPassed8 = Int(mapPassed8String)!
                                
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(mapPassed8!, forKey: "mapPassed8")
                                
                                print("retrieve mapPassed:\(mapPassed8!)")
                                
                            }
                            
                            if let mapPassed9String = user?["mapPassed9"] as! String?{
                                
                                mapPassed9 = Int(mapPassed9String)!
                                
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(mapPassed9!, forKey: "mapPassed9")
                                
                                print("retrieve mapPassed:\(mapPassed9!)")
                                
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
                            
                            if let gamePassed5String = user?["gamePassed5"] as! String?{
                                
                                let gamePassed5StringArray = gamePassed5String.components(separatedBy: ":")
                                
                                let s = gamePassed5StringArray[0]
                                let u = gamePassed5StringArray[1]
                                gamePassed5 = [Int(s)!:Int(u)!]
                                
                                let userDefaults = UserDefaults.standard
                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed5!)
                                
                                print("retrieve gamePassed:\(gamePassed5!)")
                                userDefaults.set(encodedObject, forKey: "gamePassed5")
                                
                            }

                            
                            //MARK: simVer K12 特別作法
                            
                            if let gamePassed6String = user?["gamePassed6"] as! String?{
                                
                                
                                
                                let k12GamePassedStringArray = gamePassed6String.components(separatedBy: ";")
                                
                                var gamePassed6StringArray = [String]()
                                
                                for i in 0 ..< k12GamePassedStringArray.count {
                                    
                                    //避免最後一位空值
                                    if k12GamePassedStringArray[i] != "" {
                                        
                                        gamePassed6StringArray = k12GamePassedStringArray[i].components(separatedBy: ":")
                                        
                                        let s = gamePassed6StringArray[0]
                                        let u = gamePassed6StringArray[1]
                                        k12GamePassed[i] = [Int(s)!:Int(u)!]
                                    }
                                    
                                }
                                
                                let userDefaults = UserDefaults.standard
                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: k12GamePassed!)
                                
                                print("retrieve gamePassed:\(k12GamePassed!)")
                                userDefaults.set(encodedObject, forKey: "gamePassed6")
                                
                            }
                            
                            
                            
//                            if let gamePassed6String = user?["gamePassed6"] as! String?{
//
//                                let gamePassed6StringArray = gamePassed6String.components(separatedBy: ":")
//
//                                let s = gamePassed6StringArray[0]
//                                let u = gamePassed6StringArray[1]
//                                gamePassed6 = [Int(s)!:Int(u)!]
//
//                                let userDefaults = UserDefaults.standard
//                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed6!)
//
//                                print("retrieve gamePassed:\(gamePassed6!)")
//                                userDefaults.set(encodedObject, forKey: "gamePassed6")
//
//                            }
                            
                            if let gamePassed7String = user?["gamePassed7"] as! String?{
                                
                                let gamePassed7StringArray = gamePassed7String.components(separatedBy: ":")
                                
                                let s = gamePassed7StringArray[0]
                                let u = gamePassed7StringArray[1]
                                gamePassed7 = [Int(s)!:Int(u)!]
                                
                                let userDefaults = UserDefaults.standard
                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed7!)
                                
                                print("retrieve gamePassed:\(gamePassed7!)")
                                userDefaults.set(encodedObject, forKey: "gamePassed7")
                                
                            }
                            
                            if let gamePassed8String = user?["gamePassed8"] as! String?{
                                
                                let gamePassed8StringArray = gamePassed8String.components(separatedBy: ":")
                                
                                let s = gamePassed8StringArray[0]
                                let u = gamePassed8StringArray[1]
                                gamePassed8 = [Int(s)!:Int(u)!]
                                
                                let userDefaults = UserDefaults.standard
                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed8!)
                                
                                print("retrieve gamePassed:\(gamePassed8!)")
                                userDefaults.set(encodedObject, forKey: "gamePassed8")
                                
                            }
                            
                            if let gamePassed9String = user?["gamePassed9"] as! String?{
                                
                                let gamePassed9StringArray = gamePassed9String.components(separatedBy: ":")
                                
                                let s = gamePassed9StringArray[0]
                                let u = gamePassed9StringArray[1]
                                gamePassed9 = [Int(s)!:Int(u)!]
                                
                                let userDefaults = UserDefaults.standard
                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed9!)
                                
                                print("retrieve gamePassed:\(gamePassed9!)")
                                userDefaults.set(encodedObject, forKey: "gamePassed9")
                                
                            }

                            
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
                                        
                                        self!.activityIndicator.stopAnimating()
                                        UIApplication.shared.endIgnoringInteractionEvents()
                                        
                                        self!.dismiss(animated: false, completion: nil)
                                        
                                        
                                    } else  {
                                       
                                         self!.updateScore(score: self!.scoresToAdd, wrongWordsCount: self!.wrongChineseCount, proRate: self!.proRateToAdd, senRate: self!.senRateToAdd)
                                        
                                        
                                    }
                                })
                                
                                // error
                                
                                
                            } else {
                                
                                // get main queue to communicate back to user
                                DispatchQueue.main.async(execute: {
                                    
                                    self!.activityIndicator.stopAnimating()
                                    UIApplication.shared.endIgnoringInteractionEvents()
                                    
                                    //print("1")
                                    self?.accountTextField.text = ""
                                    self?.passwordTextField.text = ""
                                    self?.accountTextField.attributedPlaceholder = NSAttributedString(string: self!.errorAccountExist, attributes: self!.attrs)
                                    self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: self!.errorText, attributes: self!.attrs)
                                    
                                })
                                return
                                
                            }
                            
                            
                        } catch {
                            
                            // get main queue to communicate back to user
                            DispatchQueue.main.async(execute: {
                                
                                self!.activityIndicator.stopAnimating()
                                UIApplication.shared.endIgnoringInteractionEvents()
                                
                                //print("2")
                                self?.accountTextField.text = ""
                                self?.passwordTextField.text = ""
                                self?.accountTextField.attributedPlaceholder = NSAttributedString(string: self!.errorWrongAccount, attributes: self!.attrs)
                                self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: self!.errorWrongPassword, attributes: self!.attrs)
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
                        
                        //print("3")
                        let message = error!.localizedDescription
                        print(message)
                        self?.accountTextField.text = ""
                        self?.passwordTextField.text = ""
                        self?.accountTextField.attributedPlaceholder = NSAttributedString(string: self!.errorWrongAccount, attributes: self!.attrs)
                        self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: self!.errorWrongPassword, attributes: self!.attrs)
                    })
                    return
                    
                }
                
                // launch prepared session
                }.resume()
            
            
            
        }

        
    }
    
    @IBAction func fbLoginClicked(_ sender: Any) {
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        FBSDKLoginManager().logIn(withReadPermissions: ["public_profile", "email"], from: self) {[weak self] (result, error) in
            
            if error != nil{
                
                print("longinerror =\(error)")
                self!.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()

                return
            }
            
            if (result?.isCancelled)!{
                
                print("user canceled")
                user = nil
                UserDefaults.standard.removeObject(forKey: "parseJSON")
                
                self!.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                
            } else {
            
            self!.getDetails()
            print("user log in")
            //成功時print("user log in")
            
            //self.fetchProfile()
            }
            
        }
        
        
        /*
        let loginManager = FBSDKLoginManager()
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
  
        loginManager.logIn(readPermissions: [.publicProfile,.email], viewController: self) {[weak self] (loginResult) in
            
            switch loginResult{
            case .failed(let error):
                self!.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                print(error)
            //失敗的時候回傳
            case .cancelled:
                self!.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                print("the user cancels login")
            //取消時回傳內容
            case .success(grantedPermissions: _, declinedPermissions: _, token: _):
                self!.getDetails()
                print("user log in")
                //成功時print("user log in")
                
            }
        }
 */
    }

    func getDetails(){
        
        
        let parameters = ["fields": "name, email , picture.width(200).height(200)"]
        
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: {[weak self]
            connection, result, error -> Void in
            
            if error != nil {
                print("登入失敗")
            //    print("longinerror =\(error)")
                self!.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
              //  print(error)

            } else {
                
                
                 if let resultNew = result as? [String:Any]{
                    print(resultNew)
                    let name = resultNew["name"] as? String
                    let id = resultNew["id"] as? String
                    
                    var picURL = String()
                    if let photo = resultNew["picture"] as? NSDictionary{
                        let data = photo["data"] as! NSDictionary
                        picURL = data["url"] as! String
                     //   print(name , picURL)
                    }
                    
                    
                    //register
                    
                    let newURL = picURL.replacingOccurrences(of: "&", with: "__")
                    
                    self!.fbRegister(fbid: id!, nickname: name!, ava:newURL)
                    
                    
                }

                
                
               /*
                if let resultNew = result as? [String:Any]{
                    
                    print("成功登入")
                    
                    let email = resultNew["email"]  as! String
                    print(email)
                    
                    let firstName = resultNew["first_name"] as! String
                    print(firstName)
                    
                    let lastName = resultNew["last_name"] as! String
                    print(lastName)
                    
                    if let picture = resultNew["picture"] as? NSDictionary,
                        let data = picture["data"] as? NSDictionary,
                        let url = data["url"] as? String {
                        print(url) //臉書大頭貼的url, 再放入imageView內秀出來
                    }
                }
                */
            }
        })
        
        
        
        
        
        
        /*
        guard let _ = FBSDKAccessToken.current else{return}
        let param = ["fields":"name, email , picture.width(200).height(200)"]
        let graphRequest = FBSDKGraphRequest(graphPath: "me",parameters: param)
        
        graphRequest?.start { [weak self];(urlResponse, requestResult),<#arg#>  in
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
 */
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
        var body = String()
        
        if isDirectedHere{
            
             body = "username=&password=&fbid=\(fbid)&nickname=\(nickname)&coursePlayed=&ava="
        } else {
        
      
            body = "username=&password=&fbid=\(fbid)&nickname=\(nickname)&coursePlayed=\(coursePlayed)&ava="
        }
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
                            self!.activityIndicator.stopAnimating()
                            UIApplication.shared.endIgnoringInteractionEvents()
                            //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                            return
                        }
                        
                        //先儲存使用者資訊
                        print(parseJSON)
                        UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                        
                        //isRegistered = true
                        //UserDefaults.standard.set(isRegistered, forKey: "isRegistered")
                        
                        //全新註冊者重新設定秒數
                        UserDefaults.standard.set(420, forKey: "limitSeconds")
                        
                    
                        // get id from parseJSON dictionary
                        let id = user?["id"] as? String
                        
                        // successfully registered
                        if id != nil {
                            
                            
                            //設定有註冊
                            isRegistered = true
                            UserDefaults.standard.set(isRegistered, forKey: "isRegistered")
                            
                            
                            //MARK: must update
                            //MARK: simVer 增加值
                            
                            
                            // Part 1. 登入者抓所有數值, 這裡不一定是0因為fb login有可能有玩過
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
                            
                            if let mapPassed5String = user?["mapPassed5"] as! String?{
                                
                                mapPassed5 = Int(mapPassed5String)!
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(mapPassed5!, forKey: "mapPassed5")
                                
                                print("retrieve mapPassed:\(mapPassed5!)")
                                
                            }
                            
                            //MARK: simVer K12 特別作法
                            if let mapPassed6String = user?["mapPassed6"] as! String?{
                                var mapPassedStringArray = mapPassed6String.components(separatedBy: ";")
                                
                                for i in 0 ..< mapPassedStringArray.count {
                                    
                                    //避免最後一位空值
                                    if mapPassedStringArray[i] != "" {
                                        
                                        k12MapPassed[i] = Int(mapPassedStringArray[i])!
                                    }
                                    
                                }
                                
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(k12MapPassed, forKey: "mapPassed6")
                                
                                print("retrieve mapPassed:\(k12MapPassed!)")
                                
                            }
                            
//                            if let mapPassed6String = user?["mapPassed6"] as! String?{
//
//                                mapPassed6 = Int(mapPassed6String)!
//                                let userDefaults = UserDefaults.standard
//                                userDefaults.set(mapPassed6!, forKey: "mapPassed6")
//
//                                print("retrieve mapPassed:\(mapPassed6!)")
//
//                            }
                            
                            if let mapPassed7String = user?["mapPassed7"] as! String?{
                                
                                mapPassed7 = Int(mapPassed7String)!
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(mapPassed7!, forKey: "mapPassed7")
                                
                                print("retrieve mapPassed:\(mapPassed7!)")
                                
                            }
                            
                            if let mapPassed8String = user?["mapPassed8"] as! String?{
                                
                                mapPassed8 = Int(mapPassed8String)!
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(mapPassed8!, forKey: "mapPassed8")
                                
                                print("retrieve mapPassed:\(mapPassed8!)")
                                
                            }
                            
                            if let mapPassed9String = user?["mapPassed9"] as! String?{
                                
                                mapPassed9 = Int(mapPassed9String)!
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(mapPassed9!, forKey: "mapPassed9")
                                
                                print("retrieve mapPassed:\(mapPassed9!)")
                                
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
                            
                            if let gamePassed5String = user?["gamePassed5"] as! String?{
                                
                                let gamePassed5StringArray = gamePassed5String.components(separatedBy: ":")
                                
                                let s = gamePassed5StringArray[0]
                                let u = gamePassed5StringArray[1]
                                gamePassed5 = [Int(s)!:Int(u)!]
                                
                                let userDefaults = UserDefaults.standard
                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed5!)
                                
                                print("retrieve gamePassed:\(gamePassed5!)")
                                userDefaults.set(encodedObject, forKey: "gamePassed5")
                                
                            }
                            
                            //MARK: simVer K12 特別作法
                            
                            if let gamePassed6String = user?["gamePassed6"] as! String?{
                
                                let k12GamePassedStringArray = gamePassed6String.components(separatedBy: ";")
                                
                                var gamePassed6StringArray = [String]()
                                
                                for i in 0 ..< k12GamePassedStringArray.count {
                                    
                                    //避免最後一位空值
                                    if k12GamePassedStringArray[i] != "" {
                                        
                                        gamePassed6StringArray = k12GamePassedStringArray[i].components(separatedBy: ":")
                                        
                                        let s = gamePassed6StringArray[0]
                                        let u = gamePassed6StringArray[1]
                                        k12GamePassed[i] = [Int(s)!:Int(u)!]
                                    }
                                    
                                }
                                
                                let userDefaults = UserDefaults.standard
                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: k12GamePassed!)
                                
                                print("retrieve gamePassed:\(k12GamePassed!)")
                                userDefaults.set(encodedObject, forKey: "gamePassed6")
                                
                            }

                            
//                            if let gamePassed6String = user?["gamePassed6"] as! String?{
//
//                                let gamePassed6StringArray = gamePassed6String.components(separatedBy: ":")
//
//                                let s = gamePassed6StringArray[0]
//                                let u = gamePassed6StringArray[1]
//                                gamePassed6 = [Int(s)!:Int(u)!]
//
//                                let userDefaults = UserDefaults.standard
//                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed6!)
//
//                                print("retrieve gamePassed:\(gamePassed6!)")
//                                userDefaults.set(encodedObject, forKey: "gamePassed6")
//
//                            }
                            
                            if let gamePassed7String = user?["gamePassed7"] as! String?{
                                
                                let gamePassed7StringArray = gamePassed7String.components(separatedBy: ":")
                                
                                let s = gamePassed7StringArray[0]
                                let u = gamePassed7StringArray[1]
                                gamePassed7 = [Int(s)!:Int(u)!]
                                
                                let userDefaults = UserDefaults.standard
                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed7!)
                                
                                print("retrieve gamePassed:\(gamePassed7!)")
                                userDefaults.set(encodedObject, forKey: "gamePassed7")
                                
                            }
                            
                            if let gamePassed8String = user?["gamePassed8"] as! String?{
                                
                                let gamePassed8StringArray = gamePassed8String.components(separatedBy: ":")
                                
                                let s = gamePassed8StringArray[0]
                                let u = gamePassed8StringArray[1]
                                gamePassed8 = [Int(s)!:Int(u)!]
                                
                                let userDefaults = UserDefaults.standard
                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed8!)
                                
                                print("retrieve gamePassed:\(gamePassed8!)")
                                userDefaults.set(encodedObject, forKey: "gamePassed8")
                                
                            }
                            
                            if let gamePassed9String = user?["gamePassed9"] as! String?{
                                
                                let gamePassed9StringArray = gamePassed9String.components(separatedBy: ":")
                                
                                let s = gamePassed9StringArray[0]
                                let u = gamePassed9StringArray[1]
                                gamePassed9 = [Int(s)!:Int(u)!]
                                
                                let userDefaults = UserDefaults.standard
                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed9!)
                                
                                print("retrieve gamePassed:\(gamePassed9!)")
                                userDefaults.set(encodedObject, forKey: "gamePassed9")
                                
                            }


                            
                            
                            // part 2. 判斷是不是從購買畫面轉過來的
                            if self!.isDirectedHere{
                                
                                
                                print("不需要更新關卡")
                                
                                
                                DispatchQueue.main.async(execute: {
                                    //是的話 註冊完就跳掉
                                    self!.activityIndicator.stopAnimating()
                                    UIApplication.shared.endIgnoringInteractionEvents()
                                    self!.dismiss(animated: false, completion: nil)
                                    
                                })
                                

                            } else {

                                
                                DispatchQueue.main.async(execute: {[weak self] in
                                    
                                      self!.updateScore(score: self!.scoresToAdd, wrongWordsCount: self!.wrongChineseCount, proRate: self!.proRateToAdd, senRate: self!.senRateToAdd)
                                    //self!.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                                })

                                
                                
                                /*
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
 
 */
                                
                            }
                            
                            
                        } else {
                            
                            // get main queue to communicate back to user
                            DispatchQueue.main.async(execute: {
                                
                                self!.activityIndicator.stopAnimating()
                                UIApplication.shared.endIgnoringInteractionEvents()
                                
                                print("1")
                                self?.accountTextField.text = ""
                                self?.passwordTextField.text = ""
                                self?.accountTextField.attributedPlaceholder = NSAttributedString(string: "此帳號已存在，請重新輸入", attributes: self!.attrs)
                                self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: self!.attrs)
                                
                            })
                            return
                            
                        }
                        
                        
                    } catch {
                        
                        // get main queue to communicate back to user
                        DispatchQueue.main.async(execute: {
                            
                            self!.activityIndicator.stopAnimating()
                            UIApplication.shared.endIgnoringInteractionEvents()
                            
                            print("2")
                            self?.accountTextField.text = ""
                            self?.passwordTextField.text = ""
                            self?.accountTextField.attributedPlaceholder = NSAttributedString(string: "帳號輸入有誤，請再試一次", attributes: self!.attrs)
                            self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: "密碼輸入有誤，請再試一次", attributes: self!.attrs)
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
                    self?.accountTextField.text = ""
                    self?.passwordTextField.text = ""
                    self?.accountTextField.attributedPlaceholder = NSAttributedString(string: "帳號輸入有誤，請再試一次", attributes: self!.attrs)
                    self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: "密碼輸入有誤，請再試一次", attributes: self!.attrs)
                })
                return
                
            }
            
            // launch prepared session
            }.resume()

        
    }
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        
        
        if accountTextField.text!.isEmpty || accountTextField.text!.count < 5 {
            

            accountTextField.text = ""
            accountTextField.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上帳號", attributes: attrs)
            
            if  passwordTextField.text!.isEmpty  || passwordTextField.text!.count < 5{
                
                passwordTextField.text = ""
                
                passwordTextField.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上密碼", attributes: attrs)
    
            }
            
        } else if  passwordTextField.text!.isEmpty  || passwordTextField.text!.count < 5{
            
            passwordTextField.text = ""
            
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上密碼", attributes:attrs)
            
            if accountTextField.text!.isEmpty || accountTextField.text!.count < 5 {
                
                
                
                accountTextField.text = ""
                accountTextField.attributedPlaceholder = NSAttributedString(string: "請輸入5位數以上帳號", attributes: attrs)
                
                
            }
            
        } else {
            
            
            
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
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
                            
                            self!.activityIndicator.stopAnimating()
                            UIApplication.shared.endIgnoringInteractionEvents()
                            
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
                            
                            //MARK: must update
                            //MARK: simVer增加值

                        
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
                            
        
                            if let mapPassed4String = user?["mapPassed4"] as! String?{
                                
                                mapPassed4 = Int(mapPassed4String)!
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(mapPassed4!, forKey: "mapPassed4")
                                
                                print("retrieve mapPassed:\(mapPassed4!)")
                                
                            }
                            if let mapPassed5String = user?["mapPassed5"] as! String?{
                                
                                mapPassed5 = Int(mapPassed5String)!
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(mapPassed5!, forKey: "mapPassed5")
                                
                                print("retrieve mapPassed:\(mapPassed5!)")
                                
                            }
                            
                            //MARK: simVer K12 特別作法
                            if let mapPassed6String = user?["mapPassed6"] as! String?{
                                var mapPassedStringArray = mapPassed6String.components(separatedBy: ";")
                                
                                for i in 0 ..< mapPassedStringArray.count {
                                    
                                    //避免最後一位空值
                                    if mapPassedStringArray[i] != "" {
                                        
                                        k12MapPassed[i] = Int(mapPassedStringArray[i])!
                                    }
                                    
                                }
                                
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(k12MapPassed, forKey: "mapPassed6")
                                
                                print("retrieve mapPassed:\(k12MapPassed!)")
                                
                            }

                            
//                            if let mapPassed6String = user?["mapPassed6"] as! String?{
//
//                                mapPassed6 = Int(mapPassed6String)!
//                                let userDefaults = UserDefaults.standard
//                                userDefaults.set(mapPassed6!, forKey: "mapPassed6")
//
//                                print("retrieve mapPassed:\(mapPassed6!)")
//
//                            }
                            
                            if let mapPassed7String = user?["mapPassed7"] as! String?{
                                
                                mapPassed7 = Int(mapPassed7String)!
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(mapPassed7!, forKey: "mapPassed7")
                                
                                print("retrieve mapPassed:\(mapPassed7!)")
                                
                            }
                            
                            if let mapPassed8String = user?["mapPassed8"] as! String?{
                                
                                mapPassed8 = Int(mapPassed8String)!
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(mapPassed8!, forKey: "mapPassed8")
                                
                                print("retrieve mapPassed:\(mapPassed8!)")
                                
                            }
                            
                            if let mapPassed9String = user?["mapPassed9"] as! String?{
                                
                                mapPassed9 = Int(mapPassed9String)!
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(mapPassed9!, forKey: "mapPassed9")
                                
                                print("retrieve mapPassed:\(mapPassed9!)")
                                
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
                            
                            if let gamePassed5String = user?["gamePassed5"] as! String?{
                                
                                let gamePassed5StringArray = gamePassed5String.components(separatedBy: ":")
                                
                                let s = gamePassed5StringArray[0]
                                let u = gamePassed5StringArray[1]
                                gamePassed5 = [Int(s)!:Int(u)!]
                                
                                let userDefaults = UserDefaults.standard
                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed5!)
                                
                                print("retrieve gamePassed:\(gamePassed5!)")
                                userDefaults.set(encodedObject, forKey: "gamePassed5")
                                
                            }
                            
                            //MARK: simVer K12 特別作法
                            
                            if let gamePassed6String = user?["gamePassed6"] as! String?{
                                
                                
                                
                                var k12GamePassedStringArray = gamePassed6String.components(separatedBy: ";")
                                
                                //如果有19位數就移除最後一位
                                if k12GamePassedStringArray.count == 19{
                                    k12GamePassedStringArray.removeLast()
                                }

                                
                                for i in 0 ..< k12GamePassedStringArray.count {
                                    
                                 
                                   
                                        let gamePassed6StringArray = k12GamePassedStringArray[i].components(separatedBy: ":")
                                        
                                        let s = gamePassed6StringArray[0]
                                        let u = gamePassed6StringArray[1]
                                        k12GamePassed[i] = [Int(s)!:Int(u)!]
                                
                                    
                                }
                                
                                let userDefaults = UserDefaults.standard
                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: k12GamePassed!)
                                
                                print("retrieve gamePassed:\(k12GamePassed!)")
                                userDefaults.set(encodedObject, forKey: "gamePassed6")
                                
                            }

//                            if let gamePassed6String = user?["gamePassed6"] as! String?{
//
//                                let gamePassed6StringArray = gamePassed6String.components(separatedBy: ":")
//
//                                let s = gamePassed6StringArray[0]
//                                let u = gamePassed6StringArray[1]
//                                gamePassed6 = [Int(s)!:Int(u)!]
//
//                                let userDefaults = UserDefaults.standard
//                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed6!)
//
//                                print("retrieve gamePassed:\(gamePassed6!)")
//                                userDefaults.set(encodedObject, forKey: "gamePassed6")
//
//                            }
                            
                            if let gamePassed7String = user?["gamePassed7"] as! String?{
                                
                                let gamePassed7StringArray = gamePassed7String.components(separatedBy: ":")
                                
                                let s = gamePassed7StringArray[0]
                                let u = gamePassed7StringArray[1]
                                gamePassed7 = [Int(s)!:Int(u)!]
                                
                                let userDefaults = UserDefaults.standard
                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed7!)
                                
                                print("retrieve gamePassed:\(gamePassed7!)")
                                userDefaults.set(encodedObject, forKey: "gamePassed7")
                                
                            }
                            
                            if let gamePassed8String = user?["gamePassed8"] as! String?{
                                
                                let gamePassed8StringArray = gamePassed8String.components(separatedBy: ":")
                                
                                let s = gamePassed8StringArray[0]
                                let u = gamePassed8StringArray[1]
                                gamePassed8 = [Int(s)!:Int(u)!]
                                
                                let userDefaults = UserDefaults.standard
                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed8!)
                                
                                print("retrieve gamePassed:\(gamePassed8!)")
                                userDefaults.set(encodedObject, forKey: "gamePassed8")
                                
                            }
                            
                            if let gamePassed9String = user?["gamePassed9"] as! String?{
                                
                                let gamePassed9StringArray = gamePassed9String.components(separatedBy: ":")
                                
                                let s = gamePassed9StringArray[0]
                                let u = gamePassed9StringArray[1]
                                gamePassed9 = [Int(s)!:Int(u)!]
                                
                                let userDefaults = UserDefaults.standard
                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed9!)
                                
                                print("retrieve gamePassed:\(gamePassed9!)")
                                userDefaults.set(encodedObject, forKey: "gamePassed9")
                                
                            }
                        
                        
                        
                        
                  
                        // part 2. 判斷是不是從購買畫面轉過來的
                        if self!.isDirectedHere{
                            
                            
                            DispatchQueue.main.async(execute: {
                                //是的話 註冊完就跳掉
                                self!.activityIndicator.stopAnimating()
                                UIApplication.shared.endIgnoringInteractionEvents()
                                self!.dismiss(animated: false, completion: nil)
                            })
                            
             
                            
                            
                            
                            
                        } else {
                            
                            //Part 3. 不是的話要看有沒有玩過
                            
                            let scoreSaved = user?["score"] as? String
                            
                            
                            //MARK: must update
                            //MARK: simVer更新數字
                            
                            //沒玩過的話, 要更新所有數字 updateGamePassed/ updateScore / addWrongWords
                            if scoreSaved == "0" {
                                
                                
                                
                                switch self!.coursePlayed{
                                case 0:
                                    
                                    gamePassed = [0:1]
                                    gamePassed2 = [0:0]
                                    gamePassed3 = [0:0]
                                    gamePassed4 = [0:0]
                                    gamePassed5 = [0:0]
                                    k12GamePassed = Array(repeating: [0:0], count: 18)
                                    gamePassed7 = [0:0]
                                    gamePassed8 = [0:0]
                                    gamePassed9 = [0:0]
                                    
                                    
                                case 1:
                                    gamePassed2 = [0:1]
                                    gamePassed = [0:0]
                                    gamePassed3 = [0:0]
                                    gamePassed4 = [0:0]
                                    gamePassed5 = [0:0]
                                    k12GamePassed = Array(repeating: [0:0], count: 18)
                                    gamePassed7 = [0:0]
                                    gamePassed8 = [0:0]
                                    gamePassed9 = [0:0]
                                    
                                    
                                case 2:
                                    gamePassed3 = [0:1]
                                    gamePassed = [0:0]
                                    gamePassed2 = [0:0]
                                    gamePassed4 = [0:0]
                                    gamePassed5 = [0:0]
                                    k12GamePassed = Array(repeating: [0:0], count: 18)
                                    gamePassed7 = [0:0]
                                    gamePassed8 = [0:0]
                                    gamePassed9 = [0:0]
                                    
                                    
                                case 3:
                                    gamePassed3 = [0:0]
                                    gamePassed = [0:0]
                                    gamePassed2 = [0:0]
                                    gamePassed4 = [0:1]
                                    gamePassed5 = [0:0]
                                    k12GamePassed = Array(repeating: [0:0], count: 18)
                                    gamePassed7 = [0:0]
                                    gamePassed8 = [0:0]
                                    gamePassed9 = [0:0]
                                    
                                case 4:
                                    gamePassed3 = [0:0]
                                    gamePassed = [0:0]
                                    gamePassed2 = [0:0]
                                    gamePassed4 = [0:0]
                                    gamePassed5 = [0:1]
                                    k12GamePassed = Array(repeating: [0:0], count: 18)
                                    gamePassed7 = [0:0]
                                    gamePassed8 = [0:0]
                                    gamePassed9 = [0:0]
                                    
                                case 5:
                                    gamePassed3 = [0:0]
                                    gamePassed = [0:0]
                                    gamePassed2 = [0:0]
                                    gamePassed4 = [0:0]
                                    gamePassed5 = [0:0]
                                    
                                    k12GamePassed = Array(repeating: [0:0], count: 18)
                                    k12GamePassed[self!.k12MapNumber] = [0:1]

                                    gamePassed7 = [0:0]
                                    gamePassed8 = [0:0]
                                    gamePassed9 = [0:0]
                                    
                                case 6:
                                    gamePassed3 = [0:0]
                                    gamePassed = [0:0]
                                    gamePassed2 = [0:0]
                                    gamePassed4 = [0:0]
                                    gamePassed5 = [0:0]
                                    k12GamePassed = Array(repeating: [0:0], count: 18)

                                    gamePassed7 = [0:1]
                                    gamePassed8 = [0:0]
                                    gamePassed9 = [0:0]
                                    
                                case 7:
                                    gamePassed3 = [0:0]
                                    gamePassed = [0:0]
                                    gamePassed2 = [0:0]
                                    gamePassed4 = [0:0]
                                    gamePassed5 = [0:0]
                                    k12GamePassed = Array(repeating: [0:0], count: 18)

                                    gamePassed7 = [0:0]
                                    gamePassed8 = [0:1]
                                    gamePassed9 = [0:0]
                                    
                                case 8:
                                    gamePassed3 = [0:0]
                                    gamePassed = [0:0]
                                    gamePassed2 = [0:0]
                                    gamePassed4 = [0:0]
                                    gamePassed5 = [0:0]
                                    k12GamePassed = Array(repeating: [0:0], count: 18)

                                    gamePassed7 = [0:0]
                                    gamePassed8 = [0:0]
                                    gamePassed9 = [0:1]
                                    
        
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
                                
                                let encodedObject4 = NSKeyedArchiver.archivedData(withRootObject: gamePassed4!)
                                userDefaults.set(encodedObject4, forKey: "gamePassed4")
                                
                                let encodedObject5 = NSKeyedArchiver.archivedData(withRootObject: gamePassed5!)
                                userDefaults.set(encodedObject5, forKey: "gamePassed5")
                                
                                //MARK: simVer k12
                                let encodedObject6 = NSKeyedArchiver.archivedData(withRootObject: k12GamePassed!)
                                userDefaults.set(encodedObject6, forKey: "gamePassed6")
                                
                                let encodedObject7 = NSKeyedArchiver.archivedData(withRootObject: gamePassed7!)
                                userDefaults.set(encodedObject7, forKey: "gamePassed7")
                                
                                let encodedObject8 = NSKeyedArchiver.archivedData(withRootObject: gamePassed8!)
                                userDefaults.set(encodedObject8, forKey: "gamePassed8")
                                
                                let encodedObject9 = NSKeyedArchiver.archivedData(withRootObject: gamePassed9!)
                                userDefaults.set(encodedObject9, forKey: "gamePassed9")

                                
                                
                                
                                DispatchQueue.main.async(execute: {
                                    //更新後端
                                    
                                    print("exec updateGamePassed")
                                    self!.updateGamePassed(course: self!.coursePlayed)
                                    
                                })
                                
                                
                                
                            } else {
                                
                                
                                print("scoreSaved != 0")
                        
                                //有玩過的話就跳出畫面, 不重新設定東西
                                
                                
                                DispatchQueue.main.async(execute: {[weak self] in
                                    
                                    self!.activityIndicator.stopAnimating()
                                    UIApplication.shared.endIgnoringInteractionEvents()
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
                                
                                self!.activityIndicator.stopAnimating()
                                UIApplication.shared.endIgnoringInteractionEvents()
                                if let errorStatus = parseJSON["status"] as? String{
                                    
                                    if errorStatus == "403"{
                                        
                                        self?.accountTextField.text = ""
                                        self?.passwordTextField.text = ""
                                        self?.accountTextField.attributedPlaceholder = NSAttributedString(string: "帳號不存在，請再試一次", attributes: self!.attrs)
                                        self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: self!.attrs)
                                        
                                        
                                    } else if errorStatus == "401"{
                                        
                                        self?.accountTextField.text = ""
                                        self?.passwordTextField.text = ""
                                        self?.accountTextField.attributedPlaceholder = NSAttributedString(string: "密碼不正確，請再試一次", attributes: self!.attrs)
                                        self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: self!.attrs)
                                        
                                        
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
                            self?.accountTextField.text = ""
                            self?.passwordTextField.text = ""
                            self?.accountTextField.attributedPlaceholder = NSAttributedString(string: "登入錯誤，請再試一次", attributes: self!.attrs)
                            self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: self!.attrs)
                            
                            
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
                        self?.accountTextField.text = ""
                        self?.passwordTextField.text = ""
                        self?.accountTextField.attributedPlaceholder = NSAttributedString(string: "登入錯誤，請再試一次", attributes: self!.attrs)
                        self?.passwordTextField.attributedPlaceholder = NSAttributedString(string: "錯誤", attributes: self!.attrs)
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
                    
                    URLSession.shared.dataTask(with: request, completionHandler: {[weak self] data, response, error in
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
                                
                                //再次儲存使用者資訊
                                UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                                user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                                print(user!)
                                
                                if user != nil {
                                    
                                   
                                    self!.wrongWordsCounts += 1
                                    
                                    if self!.wrongWordsCounts == self!.wrongWordsToAdd.count {
                                        
                                        
                                        DispatchQueue.main.async(execute: {[weak self] in
                                            
                                            self!.activityIndicator.stopAnimating()
                                            UIApplication.shared.endIgnoringInteractionEvents()

                                            self!.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                                       
                                     
                                        })
                                        
                                    }
                                    
                                }
                                
                            } catch{
                                
                                print("catch error")
                                
                                DispatchQueue.main.async(execute: {[weak self] in
                                    
                                    self!.activityIndicator.stopAnimating()
                                    UIApplication.shared.endIgnoringInteractionEvents()
                                })
                                
                            }
                        } else {
                            
                            print("urlsession has error")
                            
                            DispatchQueue.main.async(execute: {[weak self] in
                                
                                self!.activityIndicator.stopAnimating()
                                UIApplication.shared.endIgnoringInteractionEvents()
                            })
                            
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
                        
                        self!.activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        return
                    }
                    
                    //print("updateScore")
                    //再次儲存使用者資訊
                    UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                    user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                    //print(user!)
                    
                    
                    
                    if user != nil {
                        
                        
                        DispatchQueue.main.async(execute: {
                            
                            if self!.wrongWordsToAdd.count > 0 {
                                
                                self!.addWrongWords()
                           
                            
                                //self!.updateScore(score: self!.scoresToAdd, wrongWordsCount: self!.wrongChineseCount, proRate: self!.proRateToAdd, senRate: self!.senRateToAdd)
                                
                                
                                
                            } else {
                                
                                self!.activityIndicator.stopAnimating()
                                UIApplication.shared.endIgnoringInteractionEvents()
                                
                                self!.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)

                            }
                            
                        })
                        
                    }
               
                } catch{
                    
                    DispatchQueue.main.async(execute: {
                        
                        self!.activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        
                    })

                    
                    print("catch error")
                    
                }
            } else {
                DispatchQueue.main.async(execute: {
                    
                    self!.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                })

                
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
        
        var passed = String()
        //MARK: simVer K12
        
        if coursePlayed == 5 {
            
            for i in 0 ..< k12GamePassed.count{
                
                for (s,u) in k12GamePassed[i] {
                    
                    passed += String(s) + ":" + String(u) + ";"
                    
                }
                
            }
            
        } else {
            
          passed = "0:1"
        }
        
        
        
        // body gonna be appended to url
        let body = "userID=\(id)&gamePassed=\(passed)&course=\(course)"
        //print(body)
        
        // append body to our request that gonna be sent
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {[weak self]data, response, error in
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
                    
             //       print("gamePassed updated")
                    
                } catch{
                    
                    DispatchQueue.main.async(execute: {
                        
                        self!.activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        
                    })
                    
                    print("catch error:\(error)")
                    
                    
                }
            } else {
                print("urlsession has error")
                
                
                DispatchQueue.main.async(execute: {
                    
                    self!.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                })

                
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
