//
//  AppDelegate.swift
//  wordDrug
//
//  Created by Ethan on 2017/10/18.
//  Copyright © 2017年 playplay. All rights reserved.
//

import UIKit
import FacebookCore
import Firebase
import FirebaseMessaging
import FirebaseInstanceID
import UserNotifications
import StoreKit


var user : NSDictionary?
var mapPassed:Int?
var gamePassed:[Int:Int]?
var mapPassed2:Int?
var gamePassed2:[Int:Int]?
var mapPassed3:Int?
var gamePassed3:[Int:Int]?
var mapPassed4:Int?
var gamePassed4:[Int:Int]?
var introWatched:Bool?
var isRegistered:Bool?
var seconds:Int?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
      
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.notifyPauseGame), name: NSNotification.Name("globalPause"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.notifyPurchased), name: NSNotification.Name("purchased"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.notifyFailedToPurchase), name: NSNotification.Name("failedToPurchase"), object: nil)
       
        
        /*
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.notifyRestored), name: NSNotification.Name("restored"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.notifyStartToRestore), name: NSNotification.Name("startToRestore"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.notifyFailedToRestore), name: NSNotification.Name("failedToRestore"), object: nil)
        */
        
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
        
        
        //抓使用者檔案
        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary 
        
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
        
        
        
        //抓gamePassed4, 在此對原本玩家來說抓不到值 就賦予值
        let decodedObject4 = UserDefaults.standard.object(forKey: "gamePassed4") as? NSData
        
        if let decoded = decodedObject4 {
            gamePassed4 = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int : Int]
        } else {
            print("give value for nil value")
            // give value for nil
            
            if user != nil {
            mapPassed4 = 0
            
            userDefaults.set(mapPassed4!, forKey: "mapPassed4")
            
            gamePassed4 = [0:0]
            
            let encodedObject4 = NSKeyedArchiver.archivedData(withRootObject: gamePassed4!)
            userDefaults.set(encodedObject4, forKey: "gamePassed4")

            }
        }
        
        //抓mapPassed4
        mapPassed4 = UserDefaults.standard.object(forKey: "mapPassed4") as? Int

        
        introWatched = UserDefaults.standard.object(forKey: "introWatched") as? Bool
        isRegistered = UserDefaults.standard.object(forKey: "isRegistered") as? Bool
        

        // if user is once logged in / register, keep him logged in
        if user != nil {
            
            let id = user!["id"] as? String
            if id != nil {

                //跳轉到角色畫面
                
               //mapPassed3 = 0
               //gamePassed3 = [0:0]

              toCourse()
                
                //測試用
                /*
                mapPassed2 = 0
                gamePassed2 = [0:0]
                */
            }
            
        } else {
            
            //首次登入
          
            if introWatched == nil {
                
                introWatched = false
                userDefaults.set(introWatched, forKey: "introWatched")
                
                isRegistered = false
                userDefaults.set(isRegistered, forKey: "isRegistered")
                
                //第一次玩
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

              toIntro()
                
                
            } else if introWatched == true{
                
                
                //假如沒有測過
                
    
                if isRegistered == true{
                
                    //跳往註冊畫面
           
                    //維持原本initial Vc
                    
                } else {
                    
                    
                toCourse()
                
                }
          
                
                
            } else {
                
               toIntro()
                
            }
          
        }
        
        print("user:\(String(describing: user))")

        
        return true
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return SDKApplicationDelegate.shared.application(app, open: url,options:options)
        
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
    
    
    /*
    @objc func notifyRestored(){
        print("appDelegate restored successfully")
        
    }
    
    @objc func notifyStartToRestore(){
         print("appDelegate start to restore")
        
    }
    @objc func notifyFailedToRestore(){
        
         print("appDelegate failed to restore")
    }
 */
 
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    
        print("did become active")
        
        FBHandler()
        AppEventsLogger.activate()
        
      
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        //let date = Date().description(with: .current)
        //let formatter = DateFormatter()

        //formatter.dateFormat = "dd.MM.yyyy"
        //let result = formatter.string(from: date)

        
        
        //1.0.7 BUG fixed
        
        let dateFetch = Date()
        
        print(dateFetch)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: dateFetch)
        
        print(dateString)
        
        
        //print("date:\(date)")
        //let result = date.components(separatedBy: " at")

        //print("result:\(result)")
        

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
                

                /*
            case .restored:
                
                print("restored")
                
                //SKPaymentQueue.default().finishTransaction(transaction)
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: restoredKey), object: nil)
                
                */

                
            default:
                break
                
                
            }
            
            
        }
        
        
    }
    
    

    
    

    /*
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: startToRestoreKey), object: nil)
        print("start To restore")
        
    }
    
    
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: failedToRestoreKey), object: nil)
        
    }
 */
}


