//
//  RegisterViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/6/4.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

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
    
    @IBOutlet weak var accountPng: UIImageView!
    
    @IBOutlet weak var passwordPng: UIImageView!
    
    @IBOutlet weak var accountTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let lightPurple = UIColor.init(red: 173/255, green: 124/255, blue: 158/255, alpha: 1)
    
    let darkPurple = UIColor.init(red: 75/255, green: 52/255, blue: 82/255, alpha: 1)
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var facebookBtn: UIButton!
    
    @IBOutlet weak var orLabel: UILabel!
    
    @IBOutlet weak var doubleLine2: UIImageView!
    
    @IBOutlet weak var alarmClock: UIImageView!
    
    @IBOutlet weak var freePng: UIImageView!
    
    @IBOutlet weak var freePng2: UIImageView!
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var textLabel2: UILabel!
    
    @IBOutlet weak var textLabel3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        registerBg.frame = CGRect(x: 0, y: 0, width: width, height: height)
        registerBg.image = UIImage(named: "registerBg.png")
        
        titleLabel.frame = CGRect(x: 0, y: height / 11, width: width, height: 98)
        titleLabel.font = UIFont(name: "Helvetica Bold", size: 30)
        titleLabel.textColor = .white
        titleLabel.text = "立刻登入\n開始免費學習"
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        freeTilted.frame = CGRect(x: width / 7, y: height / 14, width: 55, height: 53)
        freeTilted.image = UIImage(named: "freeTiltedPng.png")
        freeTilted.contentMode = .scaleAspectFit
        
        star.frame = CGRect(x: width * 5 / 7, y: height / 10, width: 22, height: 22)
        star.image = UIImage(named: "starPng.png")
        star.contentMode = .scaleAspectFit
        
        doubleLine.frame = CGRect(x: (width - 290) / 2, y: titleLabel.frame.maxY, width: 290, height: 6)
        doubleLine.image = UIImage(named: "doubleLine.png")
        doubleLine.contentMode = .scaleAspectFit
        
        subTitleLabel.text = "英檢初級，中級，多益滿分等\n所有單字任你學習！"
        subTitleLabel.frame = CGRect(x: 0, y: doubleLine.frame.maxY + 10, width: width, height: 50)
        subTitleLabel.font = UIFont(name: "Helvetica Bold", size: 18)
        subTitleLabel.textAlignment = .center
        subTitleLabel.numberOfLines = 0
        
        accountPng.frame = CGRect(x: (width - 302) / 2, y: subTitleLabel.frame.maxY + 10, width: 302, height: 42)
        
        accountPng.image = UIImage(named: "accountPng.png")
        
        passwordPng.frame = CGRect(x: accountPng.frame.minX, y: accountPng.frame.maxY + 10, width: 302, height: 42)
        passwordPng.image = UIImage(named: "passwordPng.png")
        
        accountTextField.frame = CGRect(x: accountPng.frame.minX + accountPng.frame.width / 7, y: accountPng.frame.minY, width: accountPng.frame.width * 4 / 5, height: accountPng.frame.height)
        
        
        accountTextField.attributedPlaceholder = NSAttributedString(string: "請輸入5個字母以上帳號", attributes: [NSAttributedStringKey.foregroundColor: lightPurple])
        
        
        passwordTextField.frame = CGRect(x: accountTextField.frame.minX, y: passwordPng.frame.minY, width: accountTextField.frame.width, height: passwordPng.frame.height)
        
        
                passwordTextField.attributedPlaceholder = NSAttributedString(string: "請輸入5個字母以上密碼", attributes: [NSAttributedStringKey.foregroundColor: lightPurple])
        
        accountTextField.delegate = self
        passwordTextField.delegate = self
        
        registerBtn.frame = CGRect(x: passwordPng.frame.minX, y: passwordPng.frame.maxY + 10, width: 111, height: 35)
        
        facebookBtn.frame = CGRect(x: passwordPng.frame.maxX - 142, y: registerBtn.frame.minY, width: 142, height: 35)
        
        
        //orLabel.frame = CGRect(x: width / 2 - 13, y: registerBtn.frame.minY + 11, width: 26, height: 22)
        orLabel.center = CGPoint(x: width / 2 - 13, y: registerBtn.frame.midY)
        
        orLabel.frame.size = CGSize(width: 26, height: 22)
        
        //orLabel.backgroundColor = .gray
        
        
        doubleLine2.frame = CGRect(x: doubleLine.frame.minX, y: registerBtn.frame.maxY + 15, width: doubleLine.frame.width, height: doubleLine.frame.height)
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
        let textLabel2Text2 = NSMutableAttributedString(string: "複習挑戰模式。", attributes: attrs0)
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


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
