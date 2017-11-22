//
//  LoginViewController.swift
//  wordDrug
//
//  Created by Ethan on 2017/11/21.
//  Copyright © 2017年 playplay. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var middleLine: UIView!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //指定delegate才能return
        usernameTxt.delegate = self
        passwordTxt.delegate = self
        
        //placeholder顏色
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "請輸入帳號", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "請輸入密碼", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func registerClick(_ sender: Any) {
    }
    
    //登入功能
    @IBAction func loginclick(_ sender: Any) {
        
        // shortcuts
        let username = usernameTxt.text!.lowercased()
        let password = passwordTxt.text!
        
        // send request to mysql db
        // url to access our php file
        let url = URL(string: "http://ec2-52-199-122-149.ap-northeast-1.compute.amazonaws.com/wordDrug/login.php")!
        
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
                    
                    
                    let id = parseJSON["id"] as? String
                    
                    //先儲存使用者資訊
                    UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                    user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                    print(user!)
                    
                    // successfully logged in
                    if id != nil {
                        
                                print("successfully logged in")
                                self!.toMap()

                    } else {
                        
                        // 抓錯誤訊息
                        DispatchQueue.main.async(execute: {
                            if let errorStatus = parseJSON["status"] as? String{
                                
                                
                                
                                if errorStatus == "403"{
                                    
                                    self?.usernameTxt.text = ""
                                    self?.passwordTxt.text = ""
                                    self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "Error", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                                    self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "Error", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                                    
                                    
                                } else if errorStatus == "401"{
                                    
                                    self?.usernameTxt.text = ""
                                    self?.passwordTxt.text = ""
                                    self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "Error", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                                    self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "Error", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                                    
                                    
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
                        self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "Error", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                        self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "Error", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                        
                        
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
                    self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: "Error", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                    self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: "Error", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                })
                return
                
            }
            
            }.resume()
        
        
        
    }
    
    
    func toMap(){
        performSegue(withIdentifier: "toMap", sender: self)
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

    
}
