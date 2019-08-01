//
//  AppDelegate.swift
//  wordDrug
//
//  Created by Ethan on 2017/10/18.
//  Copyright © 2017年 playplay. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import FirebaseInstanceID
import UserNotifications
import StoreKit
import ProgressHUD


//MARK: must update
//MARK: simVer要增加簡體變數

//存在userDefault裡
var user : NSMutableDictionary?

//存取出來使用
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

var seconds:Int?
var lan:String!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        //MARK: simVer
        let array = Bundle.main.preferredLocalizations
        lan = array.first

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
        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSMutableDictionary

        //確認有沒有看過介紹
        introWatched = UserDefaults.standard.object(forKey: "introWatched") as? Bool

        if user != nil {
            
            //單機版: 把原本的資料儲存到userDefaults裡
            selectCurrentUser()
            toCourse()

        } else {
            print("enter here 1")
            //首次登入, 沒有user的話
          
            if introWatched == nil {
                
                
                
                //沒看過的話
                
                introWatched = false
                userDefaults.set(introWatched, forKey: "introWatched")
                
                //第一次玩
                //MARK: must update
                //MARK: simVer 一起賦予值
                giveNewUserValue()
                
             
                //到介紹畫面
                toIntro()
                
            } else if introWatched == true{
                
                   print("enter here 2")
                //假如沒有測過
                if user == nil {
                    giveNewUserValue()
                }
                toCourse()
            }
        }
 
        return true
    }
    
    
    func giveNewUserValue(){
        mapPassed = 0
        userDefaults.set(mapPassed!, forKey: kMapPassed)
        gamePassed = [0:0]
        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed!)
        userDefaults.set(encodedObject, forKey: kGamePassed)
        
        
        mapPassed2 = 0
        userDefaults.set(mapPassed2!, forKey: kMapPassed2)
        gamePassed2 = [0:0]
        let encodedObject2 = NSKeyedArchiver.archivedData(withRootObject: gamePassed2!)
        userDefaults.set(encodedObject2, forKey: kGamePassed2)
        
        mapPassed3 = 0
        userDefaults.set(mapPassed3!, forKey: kMapPassed3)
        gamePassed3 = [0:0]
        let encodedObject3 = NSKeyedArchiver.archivedData(withRootObject: gamePassed3!)
        userDefaults.set(encodedObject3, forKey: kGamePassed3)
        
        mapPassed4 = 0
        userDefaults.set(mapPassed4!, forKey: kMapPassed4)
        gamePassed4 = [0:0]
        let encodedObject4 = NSKeyedArchiver.archivedData(withRootObject: gamePassed4!)
        
        userDefaults.set(encodedObject4, forKey: kGamePassed4)
        
        
        mapPassed5 = 0
        userDefaults.set(mapPassed5!, forKey: kMapPassed5)
        gamePassed5 = [0:0]
        let encodedObject5 = NSKeyedArchiver.archivedData(withRootObject: gamePassed5!)
        
        userDefaults.set(encodedObject5, forKey: kGamePassed5)
        
        //MARK: simVer K12特別作法
        k12MapPassed = Array(repeating: 0, count: 18)
        k12GamePassed = Array(repeating: [0:0], count: 18)
        
        let encodeK12Map = NSKeyedArchiver.archivedData(withRootObject: k12MapPassed!)
        userDefaults.set(encodeK12Map, forKey: kMapPassed6)
        
        let encodeK12Game = NSKeyedArchiver.archivedData(withRootObject: k12GamePassed!)
        userDefaults.set(encodeK12Game, forKey: kGamePassed6)
        
        mapPassed7 = 0
        userDefaults.set(mapPassed7!, forKey: kMapPassed7)
        gamePassed7 = [0:0]
        let encodedObject7 = NSKeyedArchiver.archivedData(withRootObject: gamePassed7!)
        userDefaults.set(encodedObject7, forKey: kGamePassed7)
        
        mapPassed8 = 0
        userDefaults.set(mapPassed8!, forKey: kMapPassed8)
        gamePassed8 = [0:0]
        let encodedObject8 = NSKeyedArchiver.archivedData(withRootObject: gamePassed8!)
        userDefaults.set(encodedObject8, forKey: kGamePassed8)
        
        mapPassed9 = 0
        userDefaults.set(mapPassed9!, forKey: kMapPassed9)
        gamePassed9 = [0:0]
        let encodedObject9 = NSKeyedArchiver.archivedData(withRootObject: gamePassed9!)
        userDefaults.set(encodedObject9, forKey: kGamePassed9)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let todayString = Date()
        let today = dateFormatter.string(from: todayString)
        
        let tempDict = [kWordReviewCount:0,kWordReviewCount2:0,kWordReviewCount3:0,kWordReviewCount4:0,kWordReviewCount5:0,kWordReviewCount6:0,kWordReviewCount7:0,kWordReviewCount8:0,kWordReviewCount9:0,kSenReviewCount:0,kSenReviewCount2:0,kSenReviewCount3:0,kSenReviewCount4:0,kSenReviewCount5:0,kSenReviewCount6:0,kSenReviewCount7:0,kSenReviewCount8:0,kSenReviewCount9:0,kWrongChinese:0,kProRate:200,kSenRate:200,kMyWords:"",kWrongWords:"",kAva:"",kNickname:"單機版學生",kScore:0, kDate:today] as NSMutableDictionary
        user = tempDict
        
        userDefaults.set(user, forKey: "parseJSON")
        
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

    }
    
    
    //單機版: 抓取使用者資訊
    
    func selectCurrentUser(){
        
        
        //retrieve and deCode
        

        
        mapPassed = userDefaults.object(forKey: kMapPassed) as? Int
        let decodedObject = UserDefaults.standard.object(forKey: kGamePassed) as? NSData

        if let decoded = decodedObject{
            gamePassed = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int:Int]
        }
        mapPassed2 = userDefaults.object(forKey: kMapPassed2) as? Int
        let decodedObject2 = UserDefaults.standard.object(forKey: kGamePassed2) as? NSData
        
        if let decoded = decodedObject2{
            gamePassed2 = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int:Int]
        }
        mapPassed3 = userDefaults.object(forKey: kMapPassed3) as? Int
        let decodedObject3 = UserDefaults.standard.object(forKey: kGamePassed3) as? NSData
        
        if let decoded = decodedObject3{
            gamePassed3 = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int:Int]
        }
        mapPassed4 = userDefaults.object(forKey: kMapPassed4) as? Int
        let decodedObject4 = UserDefaults.standard.object(forKey: kGamePassed4) as? NSData
        
        if let decoded = decodedObject4{
            gamePassed4 = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int:Int]
        }
        mapPassed5 = userDefaults.object(forKey: kMapPassed5) as? Int
        let decodedObject5 = UserDefaults.standard.object(forKey: kGamePassed5) as? NSData
        
        if let decoded = decodedObject5{
            gamePassed5 = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int:Int]
        }
        
 
        //MARK: simVer K12 特別作法
        print("start checking k12Map: \(k12MapPassed)")
        
        let decodeK12Map = userDefaults.object(forKey: kMapPassed6) as? NSData
        //k12MapPassed = userDefaults.object(forKey: kMapPassed6) as? [Int]
        
        
        print("app delegate k12MapPassed: \(k12MapPassed)")
        if let decoded = decodeK12Map {
            print("appDelegate decoded successful")
            k12MapPassed = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int]
            print("appDelegate k12MapPassed:\(k12MapPassed)")
        }
       
        let decodeK12Game = userDefaults.object(forKey: kGamePassed6) as? NSData
        if let decoded = decodeK12Game {
            k12GamePassed = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [[Int:Int]]
             print("appDelegate k12GamePassed:\(k12GamePassed)")
        }
        
        if k12MapPassed == nil {
            print("create new k12")
            //MARK: simVer K12特別作法
            k12MapPassed = Array(repeating: 0, count: 18)
           
            let encodeK12Map = NSKeyedArchiver.archivedData(withRootObject: k12MapPassed!)
            userDefaults.set(encodeK12Map, forKey: kMapPassed6)
            
        }
        
        if k12GamePassed == nil {
            k12GamePassed = Array(repeating: [0:0], count: 18)
            
            let encodeK12Game = NSKeyedArchiver.archivedData(withRootObject: k12GamePassed!)
            userDefaults.set(encodeK12Game, forKey: kGamePassed6)
            
        }
        
        
        mapPassed7 = userDefaults.object(forKey: kMapPassed7) as? Int
        let decodedObject7 = UserDefaults.standard.object(forKey: kGamePassed7) as? NSData
        
        if let decoded = decodedObject7{
            gamePassed7 = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int:Int]
        }
        mapPassed8 = userDefaults.object(forKey: kMapPassed8) as? Int
        let decodedObject8 = UserDefaults.standard.object(forKey: kGamePassed8) as? NSData
        
        if let decoded = decodedObject8{
            gamePassed8 = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int:Int]
        }
        
        mapPassed9 = userDefaults.object(forKey: kMapPassed9) as? Int
        let decodedObject9 = UserDefaults.standard.object(forKey: kGamePassed9) as? NSData
        
        if let decoded = decodedObject9{
            gamePassed9 = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Int:Int]
        }
        

        
        //user裡有的資料要轉換
        guard let wr = user?[kWordReviewCount] as? String else{
            print("it's not the first transition")
            return
        }
      
        guard let wr2 = user?[kWordReviewCount2] as? String else{
            return
        }
        guard let wr3 = user?[kWordReviewCount3] as? String else{
            return
        }
        guard let wr4 = user?[kWordReviewCount4] as? String else{
            return
        }
        guard let wr5 = user?[kWordReviewCount5] as? String else{
            return
        }
        guard let wr6 = user?[kWordReviewCount6] as? String else{
            return
        }
        guard let wr7 = user?[kWordReviewCount7] as? String else{
            return
        }
        guard let wr8 = user?[kWordReviewCount8] as? String else{
            return
        }
        guard let wr9 = user?[kWordReviewCount9] as? String else{
            return
        }
        
        guard let sr = user?[kSenReviewCount] as? String else{
            return
        }
        guard let sr2 = user?[kSenReviewCount2] as? String else{
            return
        }
        guard let sr3 = user?[kSenReviewCount3] as? String else{
            return
        }
        guard let sr4 = user?[kSenReviewCount4] as? String else{
            return
        }
        guard let sr5 = user?[kSenReviewCount5] as? String else{
            return
        }
        guard let sr6 = user?[kSenReviewCount6] as? String else{
            return
        }
        guard let sr7 = user?[kSenReviewCount7] as? String else{
            return
        }
        guard let sr8 = user?[kSenReviewCount8] as? String else{
            return
        }
        guard let sr9 = user?[kSenReviewCount9] as? String else{
            return
        }

        guard let wch = user?[kWrongChinese] as? String else {
            return
        }
        
        guard let proRate = user?[kProRate] as? String else {
            return
        }
        
        guard let senRate = user?[kSenRate] as? String else {
            return
        }
        
        guard let myWords = user?[kMyWords] as? String else {
            return
        }
        
        guard let wrongWords = user?[kWrongWords] as? String else {
            return
        }
        
        //ava 跳過
        guard let nickName = user?[kNickname] as? String else {
            return
        }
        
        guard let score = user?[kScore] as? String else {
            return
        }
        
        guard let date = user?[kDate] as? String else {
            return
        }

        print("come here and replace self")
        let replaceSelf = [kWordReviewCount:Int(wr)!,kWordReviewCount2:Int(wr2)!,kWordReviewCount3:Int(wr3)!,kWordReviewCount4:Int(wr4)!,kWordReviewCount5:Int(wr5)!,kWordReviewCount6:Int(wr6)!,kWordReviewCount7:Int(wr7)!,kWordReviewCount8:Int(wr8)!,kWordReviewCount9:Int(wr9)!,kSenReviewCount:Int(sr)!,kSenReviewCount2:Int(sr2)!,kSenReviewCount3:Int(sr3)!,kSenReviewCount4:Int(sr4)!,kSenReviewCount5:Int(sr5)!,kSenReviewCount6:Int(sr6)!,kSenReviewCount7:Int(sr7)!,kSenReviewCount8:Int(sr8)!,kSenReviewCount9:Int(sr9)!,kWrongChinese:Int(wch)!,kProRate:Int(proRate)!,kSenRate:Int(senRate)!,kMyWords:myWords,kWrongWords:wrongWords,kAva:"",kNickname:nickName,kScore:Int(score)!, kDate:date] as NSMutableDictionary
        
        user = replaceSelf
        userDefaults.set(user, forKey: "parseJSON")
       
        
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


