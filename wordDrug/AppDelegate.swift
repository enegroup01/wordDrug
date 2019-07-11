//
//  AppDelegate.swift
//  wordDrug
//
//  Created by Ethan on 2017/10/18.
//  Copyright © 2017年 playplay. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Firebase
import FirebaseMessaging
import FirebaseInstanceID
import UserNotifications
import StoreKit
import ProgressHUD

//MARK: must update
//MARK: simVer要增加簡體變數

var user : NSDictionary?
var mapPassed:Int?
var gamePassed:[Int:Int]?
var mapPassed2:Int?
var gamePassed2:[Int:Int]?
var mapPassed3:Int?
var gamePassed3:[Int:Int]?
var mapPassed4:Int?
var gamePassed4:[Int:Int]?
var mapPassed5:Int?
var gamePassed5:[Int:Int]?


//MARK: simVer K12 課程紀錄變數
var k12MapPassed:[Int]!
var k12GamePassed:[[Int:Int]]!


var mapPassed7:Int?
var gamePassed7:[Int:Int]?
var mapPassed8:Int?
var gamePassed8:[Int:Int]?
var mapPassed9:Int?
var gamePassed9:[Int:Int]?

var introWatched:Bool?
var isRegistered:Bool?


var seconds:Int?
var lan:String!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WXApiDelegate{

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Register Wechat
        WXApi.registerApp("wx6908874b5cdb2067")
        
        //MARK: simVer
        let array = Bundle.main.preferredLocalizations
        lan = array.first

        
        //避免後面補不到值
        k12MapPassed = Array(repeating: 0, count: 18)
        k12GamePassed = Array(repeating: [0:0], count: 18)

       
        
       FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
      
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.notifyPauseGame), name: NSNotification.Name("globalPause"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.notifyPurchased), name: NSNotification.Name("purchased"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.notifyFailedToPurchase), name: NSNotification.Name("failedToPurchase"), object: nil)
       
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.notifyTurnOffRedLight), name: NSNotification.Name("turnOffRedLight"), object: nil)

        SKPaymentQueue.default().add(self)
        
        FirebaseApp.configure()

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            
            if error == nil {
                
                //print("successful")
            }
            
        }
        
        application.registerForRemoteNotifications()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshToken(notification:)), name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)
        
        //設定購買狀態
        
        if (UserDefaults.standard.object(forKey: "isPurchased") as! Bool?) != nil{
            
            print("非第一次玩")
            
        } else {
            print("第一次玩")
            
            UserDefaults.standard.set(false, forKey: "isPurchased")
        }
        
        
        //MARK: must update
        //抓使用者檔案
        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary

        //確認有沒有看過介紹
        introWatched = UserDefaults.standard.object(forKey: "introWatched") as? Bool
        isRegistered = UserDefaults.standard.object(forKey: "isRegistered") as? Bool
        
        //print("intro watched:\(introWatched)")

        //print("user\(user)")
        // if user is once logged in / register, keep him logged in
        if user != nil {
            
            //let id = user!["id"] as? String
            
            if let _ = user!["id"] as? String {
                
            //}
            
            //if id != nil {

                //跳轉到角色畫面
                //測試用
                //mapPassed3 = 0
                //gamePassed3 = [0:0]
                toCourse()

            }
            
        } else {
            
            //首次登入, 沒有user的話
          
            if introWatched == nil {
                
                //沒看過的話
                
                introWatched = false
                userDefaults.set(introWatched, forKey: "introWatched")
                
                isRegistered = false
                userDefaults.set(isRegistered, forKey: "isRegistered")
                
                //第一次玩
                //MARK: must update
                //MARK: simVer 一起賦予值
                //儲存mapPassed & gamePassed的初始值
                
                mapPassed = 0
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
                

                mapPassed5 = 0
                userDefaults.set(mapPassed5!, forKey: "mapPassed5")
                gamePassed5 = [0:0]
                let encodedObject5 = NSKeyedArchiver.archivedData(withRootObject: gamePassed5!)
                userDefaults.set(encodedObject5, forKey: "gamePassed5")
                
                
                //MARK: simVer K12特別作法
                k12MapPassed = Array(repeating: 0, count: 18)
                k12GamePassed = Array(repeating: [0:0], count: 18)
                //mapPassed6 = 0
                userDefaults.set(k12MapPassed, forKey: "mapPassed6")
                //gamePassed6 = [0:0]
                let encodedObject6 = NSKeyedArchiver.archivedData(withRootObject: k12GamePassed!)
                userDefaults.set(encodedObject6, forKey: "gamePassed6")

                
                mapPassed7 = 0
                userDefaults.set(mapPassed7!, forKey: "mapPassed7")
                gamePassed7 = [0:0]
                let encodedObject7 = NSKeyedArchiver.archivedData(withRootObject: gamePassed7!)
                userDefaults.set(encodedObject7, forKey: "gamePassed7")

                
                mapPassed8 = 0
                userDefaults.set(mapPassed8!, forKey: "mapPassed8")
                gamePassed8 = [0:0]
                let encodedObject8 = NSKeyedArchiver.archivedData(withRootObject: gamePassed8!)
                userDefaults.set(encodedObject8, forKey: "gamePassed8")

                
                mapPassed9 = 0
                userDefaults.set(mapPassed9!, forKey: "mapPassed9")
                gamePassed9 = [0:0]
                let encodedObject9 = NSKeyedArchiver.archivedData(withRootObject: gamePassed9!)
                userDefaults.set(encodedObject9, forKey: "gamePassed9")

                //到介紹畫面
                toIntro()
                
                
            } else if introWatched == true{
                
                
                //假如沒有測過

                if isRegistered == true{
                
                    //跳往註冊畫面
                    //維持原本initial Vc
                    
                } else {
                    
                    //MARK: 所有更新時的檔案保險使用
                    //如果有沒有帳號資訊者給0
                    //抓gamePassed4, 在此對原本玩家來說抓不到值 就賦予值
                    
                    //MARK: simVer這裏也補上去 避免之前就用簡體手機的人突然之間更新不到數字
           
                    let decodedObject4 = UserDefaults.standard.object(forKey: "gamePassed4") as? NSData
                    
                    if let decoded = decodedObject4 {
                        gamePassed4 = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int : Int]
                    } else {
            
                        // give value for nil
                        
         
                        mapPassed4 = 0
                        userDefaults.set(mapPassed4!, forKey: "mapPassed4")
                        
                        gamePassed4 = [0:0]
                        
                        let encodedObject4 = NSKeyedArchiver.archivedData(withRootObject: gamePassed4!)
                        userDefaults.set(encodedObject4, forKey: "gamePassed4")
      
                    }
                    
                    //抓mapPassed4
                    mapPassed4 = UserDefaults.standard.object(forKey: "mapPassed4") as? Int
                    
                    //抓gamePassed5, 在此對原本玩家來說抓不到值 就賦予值
                    let decodedObject5 = UserDefaults.standard.object(forKey: "gamePassed5") as? NSData
                    
                    if let decoded = decodedObject5 {
                        gamePassed5 = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int : Int]
                    } else {
   
                        // give value for nil
                        
                        mapPassed5 = 0
                        
                        userDefaults.set(mapPassed5!, forKey: "mapPassed5")
                        
                        gamePassed5 = [0:0]
                        
                        let encodedObject5 = NSKeyedArchiver.archivedData(withRootObject: gamePassed5!)
                        userDefaults.set(encodedObject5, forKey: "gamePassed5")
       
                    }
                    
                    //抓mapPassed5
                    mapPassed5 = UserDefaults.standard.object(forKey: "mapPassed5") as? Int
                    
                    
                    //MARK: simVer k12特別做法
                    
                    //抓gamePassed6, 在此對原本玩家來說抓不到值 就賦予值
                    let decodedObject6 = UserDefaults.standard.object(forKey: "gamePassed6") as? NSData
                    
                    if let decoded = decodedObject6 {
                        k12GamePassed = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [[Int : Int]]
                    } else {
             
                        // give value for nil
                        
    
                        k12MapPassed = Array(repeating: 0, count: 18)
                        k12GamePassed = Array(repeating: [0:0], count: 18)
                        
                        userDefaults.set(k12MapPassed, forKey: "mapPassed6")
                        

                        let encodedObject6 = NSKeyedArchiver.archivedData(withRootObject: k12GamePassed!)
                        userDefaults.set(encodedObject6, forKey: "gamePassed6")

                    }
                    

                    k12MapPassed = UserDefaults.standard.object(forKey: "mapPassed6") as? [Int]
                    
                    
                    
                    //抓gamePassed7, 在此對原本玩家來說抓不到值 就賦予值
                    let decodedObject7 = UserDefaults.standard.object(forKey: "gamePassed7") as? NSData
                    
                    if let decoded = decodedObject7 {
                        gamePassed7 = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int : Int]
                    } else {
    
                        // give value for nil

                        mapPassed7 = 0
                        
                        userDefaults.set(mapPassed7!, forKey: "mapPassed7")
                        
                        gamePassed7 = [0:0]
                        
                        let encodedObject7 = NSKeyedArchiver.archivedData(withRootObject: gamePassed7!)
                        userDefaults.set(encodedObject7, forKey: "gamePassed7")
                    }
                    
                    //抓mapPassed7
                    mapPassed7 = UserDefaults.standard.object(forKey: "mapPassed7") as? Int
                    
                    //抓gamePassed8, 在此對原本玩家來說抓不到值 就賦予值
                    let decodedObject8 = UserDefaults.standard.object(forKey: "gamePassed8") as? NSData
                    
                    if let decoded = decodedObject8 {
                        gamePassed8 = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int : Int]
                    } else {
           
                        // give value for nil
          
                        mapPassed8 = 0
                        
                        userDefaults.set(mapPassed8!, forKey: "mapPassed8")
                        
                        gamePassed8 = [0:0]
                        
                        let encodedObject8 = NSKeyedArchiver.archivedData(withRootObject: gamePassed8!)
                        userDefaults.set(encodedObject8, forKey: "gamePassed8")
   
                    }
                    
                    //抓mapPassed8
                    mapPassed8 = UserDefaults.standard.object(forKey: "mapPassed8") as? Int
                    
                    //抓gamePassed9, 在此對原本玩家來說抓不到值 就賦予值
                    let decodedObject9 = UserDefaults.standard.object(forKey: "gamePassed9") as? NSData
                    
                    if let decoded = decodedObject9 {
                        gamePassed9 = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int : Int]
                    } else {
               
                        // give value for nil
           
                        mapPassed9 = 0
                        
                        userDefaults.set(mapPassed9!, forKey: "mapPassed9")
                        
                        gamePassed9 = [0:0]
                        
                        let encodedObject9 = NSKeyedArchiver.archivedData(withRootObject: gamePassed9!)
                        userDefaults.set(encodedObject9, forKey: "gamePassed9")
                     
                    }
                    
                    //抓mapPassed9
                    mapPassed9 = UserDefaults.standard.object(forKey: "mapPassed9") as? Int
 
                toCourse()
                  
                
                }
      
            } else {
                
                toIntro()
            
            }
          
        }
 
        return true
    }
    
    
    //MARK: wechat info
    private let appID = "wx6908874b5cdb2067"
    private let appSecret = "60267992075223409ecb4b4b1e9d6893"
    
    private let accessTokenPrefix = "https://api.weixin.qq.com/sns/oauth2/access_token?"
    
    private func buildAccessTokenLink(withCode code: String) -> String {
        

        return accessTokenPrefix + "appid=" + appID + "&secret=" + appSecret + "&code=" + code + "&grant_type=authorization_code"
        
    }
    
    private let userInfoPrefix = "https://api.weixin.qq.com/sns/userinfo?"
    
    private func buildUserInfoLink(withOpenID openID: String, accessToken: String) -> String {
        
        return userInfoPrefix + "access_token=" + accessToken + "&openid=" + openID
        
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return WXApi.handleOpen(url, delegate: self)

    }
 

    //weChat Delegate
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
     
        return WXApi.handleOpen(url, delegate: self)
    }

    func application(application: UIApplication, openURL url: URL, sourceApplication: String?, annotation: AnyObject) -> Bool {

        return WXApi.handleOpen(url, delegate: self)
    }

    
    func onReq(_ req: BaseReq) {
        // do optional stuff
        
     
    
    }
    
    func onResp(_ resp: BaseResp) {
        // do optional stuff
      
        ProgressHUD.show("读取微信信息")
        print("we chat login")
        if let authResp = resp as? SendAuthResp {
            
            if authResp.code != nil {
                
                let dict = ["response": authResp.code]
              
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "WeChatAuthCodeResp"), object: nil, userInfo: dict as [AnyHashable : Any])
                
                
                let url = URL(string: buildAccessTokenLink(withCode: authResp.code!))
                
                var request = URLRequest(url: url!)
                request.httpMethod = "GET"
                URLSession.shared.dataTask(with: request) {[weak self] (data, response, error) in
                    
                    if error == nil {
                        
                        DispatchQueue.main.async(execute: {
                            
                            do {
                                
                                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                                
                                guard let parseJSON = json else {return}
                                
                                if let openID = parseJSON["openid"] as? String{
                                    if let accessToken = parseJSON["access_token"] as? String{
                                        
                                        let url = URL(string: self!.buildUserInfoLink(withOpenID: openID, accessToken: accessToken))
                                        
                                        
                                        var request = URLRequest(url: url!)
                                        request.httpMethod = "GET"
                                        
                                        URLSession.shared.dataTask(with: request, completionHandler: {[weak self] (data, response, error) in
                                            
                                            if error == nil {
                                                
                                                DispatchQueue.main.async(execute: {
                                                    
                                                    do{
                                                        
                                                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                                                        
                                                        guard let parseJSON = json else {return}
                                                        
                                                        print(parseJSON)
                                                        
                                                        if let nickName = parseJSON["nickname"] as? String{
                                                            if let wechatId = parseJSON["openid"] as? String {
                                                                
                                                                    
                                                                    self!.fbRegister(fbid: wechatId, nickname: nickName, ava: "")
                                                                
                                                                
                                                            }
                                                            
                                                            print("nickname:\(nickName)")
                                                        }
                                                        
                                                    }catch {
                                                        
                                                        
                                                    }
                                                    
                                                    
                                                })
                                                
                                                
                                            }
                                            
                                            
                                        }).resume()
                                        
                                        
                                        
                                        
                                    }
                                }
                                
                                
                            }catch {
                                
                            }
                          
                            
                        })
                        
                    }
                }.resume()
                
            } else {
                
                let dict = ["response": "Fail"]
              
                
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "WeChatAuthCodeResp"), object: nil, userInfo: dict)
            }
            
        } else {
            
            let dict = ["response": "Fail"]
              NotificationCenter.default.post(name: NSNotification.Name(rawValue: "WeChatAuthCodeResp"), object: nil, userInfo: dict)
            
        }
    }
    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    
    @objc func notifyPauseGame(){
        
        
    }
    

    
    func toCourse(){
        
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let statsVc = mainStoryBoard.instantiateViewController(withIdentifier: "coursesVc")
        window?.rootViewController = statsVc
        
    }
    
    func toIntro(){
        
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let statsVc = mainStoryBoard.instantiateViewController(withIdentifier: "introVc")
        window?.rootViewController = statsVc
        
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
      
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "globalPause"), object: nil, userInfo: nil)
        Messaging.messaging().shouldEstablishDirectChannel = false
        
       
        //確認BookVc Cell裡的紅燈會關起來
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "turnOffRedLight"), object: nil)
        

        print("did enter background")
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    @objc func notifyFailedToPurchase(){
        
        print("appDelegate failed to purchased")
    }
    @objc func notifyPurchased(){
         print("appDelegate purchased successfully")
        
    }
    @objc func notifyTurnOffRedLight(){
        print("appDelegate turn off red light")
    }
    
    

 
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    
        print("did become active")
        
        FBHandler()
        //AppEventsLogger.activate()
        FBSDKAppEvents.activateApp()
        
      
        UIApplication.shared.applicationIconBadgeNumber = 0
        
          //確認BookVc Cell裡的紅燈會關起來
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "turnOffRedLight"), object: nil)
        
        
        //1.0.7 BUG fixed
        
        let dateFetch = Date()
        
        //print(dateFetch)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: dateFetch)


        let previousDate = UserDefaults.standard.object(forKey: "previousDate") as? String
        
        if previousDate == nil {
            //第一次玩的話給7分鐘, 並且設定時間
            
            UserDefaults.standard.set(dateString, forKey: "previousDate")
            UserDefaults.standard.set(420, forKey: "limitSeconds")
            
            print("第一次玩給7分鐘")
            
        } else {
            
            //非第一次玩, 比較日期
            
            if previousDate != dateString{
                //換一天, 就給7分鐘, 並且改變時間
                
                UserDefaults.standard.set(dateString, forKey: "previousDate")
                UserDefaults.standard.set(420, forKey: "limitSeconds")
                print("換一天給7分鐘")
                
            } else {
                    print("不加時間")
            }
    
        }
        
        
        
        //如果有user就抓user狀態
        
        
        if user != nil{
            
            //沒網路測試comment掉
            selectUser()
        } else {
            print("沒有user不需要refresh")
        }
 

    }

    func selectUser(){
        
        
        // url to access our php file
        var url:URL!
        if lan == "zh-Hans" {
            url = URL(string: "http://ec2-52-198-62-78.ap-northeast-1.compute.amazonaws.com/misswordChina/selectUser.php")!
        } else {
            url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/selectUser.php")!
        }
        //let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/selectUser.php")!
        
        let id = user?["id"] as! String
        
        // request url
        var request = URLRequest(url: url)
        
        // method to pass data POST - cause it is secured
        request.httpMethod = "POST"
        
        
        // body gonna be appended to url
        let body = "id=\(id)"
        
        // append body to our request that gonna be sent
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            // no error
            if error == nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    guard let parseJSON = json else {
           
                        //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                        return
                    }
                    
                    
                    
                    //print("selectUser:\(parseJSON)")
            
                    UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                    user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
 
                    //MARK: must update
                    //MARK: simVer增加值
//                    k12MapPassed = Array(repeating: 0, count: 18)
//                    k12GamePassed = Array(repeating: [0:0], count: 18)
                    
                    
                    if let mapPassedString = user?["mapPassed"] as! String?{
                        
                        mapPassed = Int(mapPassedString)!
                        
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(mapPassed!, forKey: "mapPassed")
        
                    }
                    
                    if let mapPassed2String = user?["mapPassed2"] as! String?{
                        
                        mapPassed2 = Int(mapPassed2String)!
                        
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(mapPassed2!, forKey: "mapPassed2")
                        
                    }
                    
                    if let mapPassed3String = user?["mapPassed3"] as! String?{
                        
                        mapPassed3 = Int(mapPassed3String)!
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(mapPassed3!, forKey: "mapPassed3")

                        
                    }
                    
                    if let mapPassed4String = user?["mapPassed4"] as! String?{
                        
                        mapPassed4 = Int(mapPassed4String)!
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(mapPassed4!, forKey: "mapPassed4")
                        
                    }
                    
                    if let mapPassed5String = user?["mapPassed5"] as! String?{
                        
                        mapPassed5 = Int(mapPassed5String)!
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(mapPassed5!, forKey: "mapPassed5")

                        
                    }
                    
                    //MARK: simVer K12 特別作法
                  
                    if let mapPassed6String = user?["mapPassed6"] as! String?{
            
                        if mapPassed6String != "0" {
                        var mapPassedStringArray = mapPassed6String.components(separatedBy: ";")
         
                        for i in 0 ..< mapPassedStringArray.count {

                            //避免最後一位空值
                            if mapPassedStringArray[i] != "" {

                            k12MapPassed[i] = Int(mapPassedStringArray[i])!
                            }
                      
                        }

                        let userDefaults = UserDefaults.standard
                        userDefaults.set(k12MapPassed, forKey: "mapPassed6")

                        print("retrieve k12MapPassed:\(k12MapPassed!)")
                        }

                    }
                    
                    
                    
                    if let mapPassed7String = user?["mapPassed7"] as! String?{
                        
                        mapPassed7 = Int(mapPassed7String)!
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(mapPassed7!, forKey: "mapPassed7")
                    
                    }
                    
                    if let mapPassed8String = user?["mapPassed8"] as! String?{
                        
                        mapPassed8 = Int(mapPassed8String)!
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(mapPassed8!, forKey: "mapPassed8")
              
                        
                    }
                    
                    if let mapPassed9String = user?["mapPassed9"] as! String?{
                        
                        mapPassed9 = Int(mapPassed9String)!
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(mapPassed9!, forKey: "mapPassed9")
                        
                        
                    }
                    
                    
                    
                    if let gamePassedString = user?["gamePassed"] as! String?{
                        
                        let gamePassedStringArray = gamePassedString.components(separatedBy: ":")
                        
                        let s = gamePassedStringArray[0]
                        let u = gamePassedStringArray[1]
                        gamePassed = [Int(s)!:Int(u)!]
                        
                        let userDefaults = UserDefaults.standard
                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed!)
                 
                        userDefaults.set(encodedObject, forKey: "gamePassed")
                        
                    }
                    
                    if let gamePassed2String = user?["gamePassed2"] as! String?{
                        
                        let gamePassed2StringArray = gamePassed2String.components(separatedBy: ":")
                        
                        let s = gamePassed2StringArray[0]
                        let u = gamePassed2StringArray[1]
                        gamePassed2 = [Int(s)!:Int(u)!]
                        
                        let userDefaults = UserDefaults.standard
                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed2!)
               
                        userDefaults.set(encodedObject, forKey: "gamePassed2")
                        
                    }
                    
                    if let gamePassed3String = user?["gamePassed3"] as! String?{
                        
                        let gamePassed3StringArray = gamePassed3String.components(separatedBy: ":")
                        
                        let s = gamePassed3StringArray[0]
                        let u = gamePassed3StringArray[1]
                        gamePassed3 = [Int(s)!:Int(u)!]
                        
                        let userDefaults = UserDefaults.standard
                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed3!)
            
                        userDefaults.set(encodedObject, forKey: "gamePassed3")
                        
                    }
                    
                    
                    if let gamePassed4String = user?["gamePassed4"] as! String?{
                        
                        let gamePassed4StringArray = gamePassed4String.components(separatedBy: ":")
                        
                        let s = gamePassed4StringArray[0]
                        let u = gamePassed4StringArray[1]
                        gamePassed4 = [Int(s)!:Int(u)!]
                        
                        let userDefaults = UserDefaults.standard
                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed4!)
          
                        userDefaults.set(encodedObject, forKey: "gamePassed4")
                        
                    }
                    
                    if let gamePassed5String = user?["gamePassed5"] as! String?{
                        
                        let gamePassed5StringArray = gamePassed5String.components(separatedBy: ":")
                        
                        let s = gamePassed5StringArray[0]
                        let u = gamePassed5StringArray[1]
                        gamePassed5 = [Int(s)!:Int(u)!]
                        
                        let userDefaults = UserDefaults.standard
                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed5!)
                     
                        userDefaults.set(encodedObject, forKey: "gamePassed5")
                        
                    }
                    
                    //MARK: simVer K12 特別作法
                    
                    if let gamePassed6String = user?["gamePassed6"] as! String?{
                        
                        
                        
                        if gamePassed6String != "0:0" {
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
                    }
                    
                    
                    
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
            
                        userDefaults.set(encodedObject, forKey: "gamePassed8")
                        
                    }
                    
                    if let gamePassed9String = user?["gamePassed9"] as! String?{
                        
                        let gamePassed9StringArray = gamePassed9String.components(separatedBy: ":")
                        
                        let s = gamePassed9StringArray[0]
                        let u = gamePassed9StringArray[1]
                        gamePassed9 = [Int(s)!:Int(u)!]
                        
                        let userDefaults = UserDefaults.standard
                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed9!)
                    
                        userDefaults.set(encodedObject, forKey: "gamePassed9")
                        
                    }
                    
                    
                    
                } catch{
                    
                    print("catch error")
                    
                }
            } else {
                
                print("urlsession has error")
                
            }
        }).resume()
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        print("will terminate")
        
        SKPaymentQueue.default().remove(self)
    }


    @objc func refreshToken(notification: NSNotification){
     
        //let refreshToken = InstanceID.instanceID().token()!
        
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
            }
        }
        
        FBHandler()
    
    }
    
    func FBHandler(){
        
        Messaging.messaging().shouldEstablishDirectChannel = true
    }


    func fbRegister(fbid:String,nickname:String,ava:String){
        
        // shortcuts
        
        //檢查註冊
        // url to php file
       // var url:URL!
        
        
        let url = URL(string: "http://ec2-52-198-62-78.ap-northeast-1.compute.amazonaws.com/misswordChina/register2.php")!

        //let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/register2.php")!
        
        // request to this file
        var request = URLRequest(url: url)
        
        // method to pass data to this file (e.g. via POST)
        request.httpMethod = "POST"
        
        // body to be appended to url, 讓nickname = 註冊帳號
        let body = "username=&password=&fbid=\(fbid)&nickname=\(nickname)&coursePlayed=&ava=&mapPlayed="
        
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
//                            self!.activityIndicator.stopAnimating()
//                            UIApplication.shared.endIgnoringInteractionEvents()
                            ProgressHUD.dismiss()
                            return
                        }
                        
                        //先儲存使用者資訊
                        //print(parseJSON)
                        UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                        
                        //第一次玩
                        //儲存mapPassed & gamePassed的初始值
                        
                        //MARK: simVer 要增加值
                        //MARK: must update
                        
                        
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
                        
                        
                        
                        let mapPassedInt5 = user?["mapPassed5"] as? String
                        let gamePassedInt5 = user?["gamePassed5"] as? String
                        
                        var gp5:[Int:Int]?
                        gp5 = [Int((gamePassedInt5?.components(separatedBy: ":")[0])!)!:Int((gamePassedInt5?.components(separatedBy: ":")[1])!)!]
                        
                        
                        //MARK: simVer K12特別作法
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
                        //MARK: simVer K12 特別作法
                        
                        if let gamePassed6String = user?["gamePassed6"] as! String?{
                            
                            
                            
                            var k12GamePassedStringArray = gamePassed6String.components(separatedBy: ";")
                            
                            //如果有19位數就移除最後一位
                            if k12GamePassedStringArray.count == 19{
                                k12GamePassedStringArray.removeLast()
                            }
                            
                            for i in 0 ..< k12GamePassedStringArray.count {
                                
                                //避免最後一位空值
                                
                                
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
                        
                        
                        
                        //                        let mapPassedInt6 = user?["mapPassed6"] as? String
                        //                        let gamePassedInt6 = user?["gamePassed6"] as? String
                        //
                        //                        var gp6:[Int:Int]?
                        //                        gp6 = [Int((gamePassedInt6?.components(separatedBy: ":")[0])!)!:Int((gamePassedInt6?.components(separatedBy: ":")[1])!)!]
                        
                        let mapPassedInt7 = user?["mapPassed7"] as? String
                        let gamePassedInt7 = user?["gamePassed7"] as? String
                        
                        var gp7:[Int:Int]?
                        gp7 = [Int((gamePassedInt7?.components(separatedBy: ":")[0])!)!:Int((gamePassedInt7?.components(separatedBy: ":")[1])!)!]
                        
                        let mapPassedInt8 = user?["mapPassed8"] as? String
                        let gamePassedInt8 = user?["gamePassed8"] as? String
                        
                        var gp8:[Int:Int]?
                        gp8 = [Int((gamePassedInt8?.components(separatedBy: ":")[0])!)!:Int((gamePassedInt8?.components(separatedBy: ":")[1])!)!]
                        
                        let mapPassedInt9 = user?["mapPassed9"] as? String
                        let gamePassedInt9 = user?["gamePassed9"] as? String
                        
                        var gp9:[Int:Int]?
                        gp9 = [Int((gamePassedInt9?.components(separatedBy: ":")[0])!)!:Int((gamePassedInt9?.components(separatedBy: ":")[1])!)!]
                        

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
                        
                        
                        userDefaults.set(Int(mapPassedInt5!), forKey: "mapPassed5")
                        
                        let encodedObject5 = NSKeyedArchiver.archivedData(withRootObject: gp5!)
                        userDefaults.set(encodedObject5, forKey: "gamePassed5")
                        
                        
                        //                        userDefaults.set(Int(mapPassedInt6!), forKey: "mapPassed6")
                        //
                        //                        let encodedObject6 = NSKeyedArchiver.archivedData(withRootObject: gp6!)
                        //                        userDefaults.set(encodedObject6, forKey: "gamePassed6")
                        
                        
                        userDefaults.set(Int(mapPassedInt7!), forKey: "mapPassed7")
                        
                        let encodedObject7 = NSKeyedArchiver.archivedData(withRootObject: gp7!)
                        userDefaults.set(encodedObject7, forKey: "gamePassed7")
                        
                        
                        userDefaults.set(Int(mapPassedInt8!), forKey: "mapPassed8")
                        
                        let encodedObject8 = NSKeyedArchiver.archivedData(withRootObject: gp8!)
                        userDefaults.set(encodedObject8, forKey: "gamePassed8")
                        
                        
                        userDefaults.set(Int(mapPassedInt9!), forKey: "mapPassed9")
                        
                        let encodedObject9 = NSKeyedArchiver.archivedData(withRootObject: gp9!)
                        userDefaults.set(encodedObject9, forKey: "gamePassed9")
                        
                        
                        
                        
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

                                ProgressHUD.dismiss()
                                
                                self!.toCourse()
                                
                            })
                            
                            // error
                            
                            //print(user)
                            
                        } else {
                            
                            ProgressHUD.dismiss()
//                            // get main queue to communicate back to user
//                            DispatchQueue.main.async(execute: {
//                                self!.activityIndicator.stopAnimating()
//                                UIApplication.shared.endIgnoringInteractionEvents()
//
//                                print("1")
//                                self?.usernameTxt.text = ""
//                                self?.passwordTxt.text = ""
//                                self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: self!.loginVC_accountExisted, attributes: self!.attrs)
//                                self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: self!.loginVC_error, attributes: self!.attrs)
//
//                            })
                            return
                            
                        }
                        
                        
                    } catch {
                        
                        ProgressHUD.dismiss()
//                        // get main queue to communicate back to user
//                        DispatchQueue.main.async(execute: {
//
//                            self!.activityIndicator.stopAnimating()
//                            UIApplication.shared.endIgnoringInteractionEvents()
//
//                            print("2")
//                            self?.usernameTxt.text = ""
//                            self?.passwordTxt.text = ""
//                            self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: self!.loginVC_wrongAccount, attributes: self!.attrs)
//                            self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: self!.loginVC_wrongPassword, attributes: self!.attrs)
//                        })
                        return
                        
                    }
                    
                })
                
                // if unable to proceed request
            } else {
                
                ProgressHUD.dismiss()
//                // get main queue to communicate back to user
//                DispatchQueue.main.async(execute: {
//
//                    self!.activityIndicator.stopAnimating()
//                    UIApplication.shared.endIgnoringInteractionEvents()
//
//                    print("3")
//                    let message = error!.localizedDescription
//                    print(message)
//                    self?.usernameTxt.text = ""
//                    self?.passwordTxt.text = ""
//                    self?.usernameTxt.attributedPlaceholder = NSAttributedString(string: self!.loginVC_wrongAccount, attributes: self!.attrs)
//                    self?.passwordTxt.attributedPlaceholder = NSAttributedString(string: self!.loginVC_wrongPassword, attributes: self!.attrs)
//                })
                return
                
            }
            
            // launch prepared session
            }.resume()
        
        
        
        
        
        
        
    }

    
    

}

extension AppDelegate: SKPaymentTransactionObserver {
    
    // the `SKPaymentTransactionObserver` methods here
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        
        for transaction in transactions{
            
            switch (transaction.transactionState){
            case .purchased:
                
                
                SKPaymentQueue.default().finishTransaction(transaction)
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: purchasedKey), object: nil)
                

                print("purchased")
            case .failed:
                
                print("failed to purchase")
                SKPaymentQueue.default().finishTransaction(transaction)
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: failedToPurchaseKey), object: nil)
                

                
            default:
                break
                
                
            }
            
            
        }
        
        
    }
    

}


