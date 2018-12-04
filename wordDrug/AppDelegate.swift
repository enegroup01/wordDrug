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

//MARK: must update
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

var introWatched:Bool?
var isRegistered:Bool?
var seconds:Int?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print("appDelegate called")
       FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
      
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.notifyPauseGame), name: NSNotification.Name("globalPause"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.notifyPurchased), name: NSNotification.Name("purchased"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.notifyFailedToPurchase), name: NSNotification.Name("failedToPurchase"), object: nil)
       
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.notifyTurnOffRedLight), name: NSNotification.Name("turnOffRedLight"), object: nil)

        SKPaymentQueue.default().add(self)
        
        FirebaseApp.configure()

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            
            if error == nil {
                
                print("successful")
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
        

        // if user is once logged in / register, keep him logged in
        if user != nil {
            
            let id = user!["id"] as? String
            
            if id != nil {

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

                //到介紹畫面
                toIntro()
                
                
            } else if introWatched == true{
                
                
                //假如沒有測過

                if isRegistered == true{
                
                    //跳往註冊畫面
           
                    //維持原本initial Vc
                    
                } else {
                    
                    
                    //如果有沒有帳號資訊者給0
                    //抓gamePassed4, 在此對原本玩家來說抓不到值 就賦予值
                    
                    
                    
                    let decodedObject4 = UserDefaults.standard.object(forKey: "gamePassed4") as? NSData
                    
                    if let decoded = decodedObject4 {
                        gamePassed4 = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int : Int]
                    } else {
                        print("give value for nil value")
                        // give value for nil
                        
                        // if user != nil {
                        mapPassed4 = 0
                        
                        userDefaults.set(mapPassed4!, forKey: "mapPassed4")
                        
                        gamePassed4 = [0:0]
                        
                        let encodedObject4 = NSKeyedArchiver.archivedData(withRootObject: gamePassed4!)
                        userDefaults.set(encodedObject4, forKey: "gamePassed4")
                        
                        //   }
                    }
                    
                    //抓mapPassed4
                    mapPassed4 = UserDefaults.standard.object(forKey: "mapPassed4") as? Int
                    
                    
                    
                    //抓gamePassed5, 在此對原本玩家來說抓不到值 就賦予值
                    let decodedObject5 = UserDefaults.standard.object(forKey: "gamePassed5") as? NSData
                    
                    if let decoded = decodedObject5 {
                        gamePassed5 = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int : Int]
                    } else {
                        print("give value for nil value")
                        // give value for nil
                        
                        //if user != nil {
                        mapPassed5 = 0
                        
                        userDefaults.set(mapPassed5!, forKey: "mapPassed5")
                        
                        gamePassed5 = [0:0]
                        
                        let encodedObject5 = NSKeyedArchiver.archivedData(withRootObject: gamePassed5!)
                        userDefaults.set(encodedObject5, forKey: "gamePassed5")
                        
                        //  }
                    }
                    
                    //抓mapPassed5
                    mapPassed5 = UserDefaults.standard.object(forKey: "mapPassed5") as? Int

                    
                toCourse()
                  
                
                }
      
            } 
          
        }
        
        //print("user:\(String(describing: user))")

        
        return true
    }
    
    
    /*
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return UIApplicationDelegate.shared.application(app, open: url,options:options)
        
    }
 */
    
    
    
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
        
        print(dateString)

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
        let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/selectUser.php")!
        
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
                        print("Error while parsing")
                        
                        //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                        return
                    }
                    
                    
                    
                    //print("selectUser:\(parseJSON)")
                    print("become active refresh user status")
                    UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                    user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                    
                    
                    //MARK: must update
                    
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
     
        let refreshToken = InstanceID.instanceID().token()!
        
        print("token:\(refreshToken)")
        
        FBHandler()
    
    }
    
    func FBHandler(){
        
        Messaging.messaging().shouldEstablishDirectChannel = true
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


