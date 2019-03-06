//
//  FetchStudentInfo.swift
//  wordDrug
//
//  Created by Ethan on 2019/2/25.
//  Copyright © 2019年 playplay. All rights reserved.
//

import Foundation
import UIKit


class Service {
    
    static let shared = Service()

    var values = [Value]()
    var avatarHeaderData = [AvatarHeader]()
    var stageScores = [10000,50000,200000,500000,1000000,2000000,3000000,4000000,5000000]
    var barLengths:[CGFloat] = [0,0,0,0,0,0,0,0,0]
    var stagePassed:[Int]?
    
    let infoVC_wordAchievement = NSLocalizedString("infoVC_wordAchievement", comment: "")
    let infoVC_proAchievement = NSLocalizedString("infoVC_proAchievement", comment: "")
    let infoVC_senAchievement = NSLocalizedString("infoVC_senAchievement", comment: "")
    let infoVC_spellKing = NSLocalizedString("infoVC_spellKing", comment: "")
    let infoVC_senKing = NSLocalizedString("infoVC_senKing", comment: "")
    let infoVC_spellRate = NSLocalizedString("infoVC_spellRate", comment: "")
    let infoVC_proRate = NSLocalizedString("infoVC_proRate", comment: "")
    let infoVC_writeSenRate = NSLocalizedString("infoVC_writeSenRate", comment: "")
    let infoVC_wordCount = NSLocalizedString("infoVC_wordCount", comment: "")
    let infoVC_senCount = NSLocalizedString("infoVC_senCount", comment: "")
    let infoVC_chineseRate = NSLocalizedString("infoVC_chineseRate", comment: "")
    let infoVC_wordUnit = NSLocalizedString("infoVC_wordUnit", comment: "")
    let infoVC_senUnit = NSLocalizedString("infoVC_senUnit", comment: "")

    
    func selectUser(completion: @escaping(Student, [Value], [AvatarHeader]) -> ()) {
        
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
            
            URLSession.shared.dataTask(with: request, completionHandler: {[weak self] data, response, error in
                // no error
                
                if error == nil {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        guard let parseJSON = json else {
                            print("Error while parsing")
                            return
                        }

                        UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
       
                        var avaImg:String?
                        var nickName:String?
                        var score:String?
                        var allWordsCount:Int?
                        var stagePassed = [0,0,0,0,0,0,0,0,0]
      
                        
                        if let avaImgResult = user?["ava"] as? String{
                            avaImg = avaImgResult
                        }
                        if let nickNameString = user?["nickname"] as? String{
                            nickName = nickNameString
                        }
                        
                        allWordsCount = self!.countWord(user: user as! [String : AnyObject])
                        
                        if let scoreString = user?["score"] as? String{
                            
                            score = scoreString
                            
                            //在此整理score給avatarHeader
                            var avatarHeader:AvatarHeader?
                            
                            for i in 0 ..< self!.stageScores.count {
                                
                                if Int(scoreString)! >= self!.stageScores[i] {
                                    
                                    let scString = String(self!.stageScores[i]) + "/" + String(self!.stageScores[i])
                                    
                                    avatarHeader = AvatarHeader(scoreString: scString, barLength: 1, colorIndex:i)
                                    stagePassed[i] = 1
                                    
                                } else {
                                    
                                    let scString = scoreString + "/" + String(self!.stageScores[i])
                                    let barLengthRate = CGFloat(Double(scoreString)! / Double(self!.stageScores[i]))
                                    
                                    avatarHeader = AvatarHeader(scoreString: scString, barLength: barLengthRate, colorIndex:i)
                                    stagePassed[i] = 0
                                   
                                }
                                
                                self!.avatarHeaderData.append(avatarHeader!)
                                
                            }
                        }
                        
                        
                        
                        let student = Student(avaImg: "m16.png", nickName: nickName!, allWordsCount: allWordsCount!, score: score!, stagePassed:stagePassed)
                        
                        //稍後回傳此個student, 接著configureValue
                        
                        DispatchQueue.main.async {
                            self!.configureValues(user: user as! [String:AnyObject], allWordsCount: allWordsCount! ,completion: { (values) in
                                
                                guard let values = values as [Value]? else {return}
                                completion(student, values, self!.avatarHeaderData)
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
    
    
    func configureValues(user:[String:AnyObject], allWordsCount:Int, completion:@escaping([Value]) ->()){
        
    
        var correctRate:Int?
        var chiRate:Int?
        var avgRate:Int?
        
        var wrongWordsCount = Int()
        print("configure 1")
        if let wrongWords = user["wrongWords"] as? String{
            let wrongWordArray = wrongWords.components(separatedBy: ";")
            wrongWordsCount = wrongWordArray.count - 1
        }
        print("configure 2")
        //wrongChinese
        var wrongChineseInt:Int?
        if let wrongChinese = user["wrongChinese"] as? String{
            
            //student.wrongChinese = Int(wrongChinese)
            wrongChineseInt = Int(wrongChinese)
        }
        
        print("configure 3")
        
        if allWordsCount == 0 {
            correctRate = 0
            chiRate = 0
        } else {
            
            
            correctRate = Int((1 - (Double(wrongWordsCount) / Double(allWordsCount))) * 100)
            chiRate = Int((1 - (Double(wrongChineseInt!) / Double(allWordsCount))) * 100)
   
        }
        

        avgRate = Int(Double(correctRate! + chiRate!) / 2)
        
        let value1 = Value(infoTitle: infoVC_wordAchievement, sub1Title: infoVC_spellRate, sub1Value: String(correctRate!) + "%", sub2Title: infoVC_chineseRate, sub2Value: String(chiRate!) + "%"
            , avgValue: String(avgRate!) + "%", bigCountValue: "", bigCountUnit: "")
        

        values.append(value1)
        
                //發音正確率
        
        var proRate = String()

                if let proRateString = user["proRate"] as? String{
        
                    if proRateString == "200" {
        
                        proRate = "0"
        
                    } else {
        
                    proRate = proRateString
        
                    }
        
                }
        

        let value2 = Value(infoTitle: infoVC_proAchievement, sub1Title: infoVC_proRate, sub1Value: proRate + "%", sub2Title: "", sub2Value: "", avgValue: proRate + "%", bigCountValue: "", bigCountUnit: "")
        
        values.append(value2)
        
             var senRate = String()
                //句子排列正確率
        
                if let senRateString = user["senRate"] as? String{
        
                    if senRate == "200"{
        
                        senRate = "0"
        
                    } else {
        
                    senRate = senRateString
        
                    }
        
                }
        
        let value3 = Value(infoTitle: infoVC_senAchievement, sub1Title: infoVC_writeSenRate, sub1Value: senRate + "%", sub2Title: "", sub2Value: "", avgValue: senRate + "%", bigCountValue: "", bigCountUnit: "")
        values.append(value3)
        
        
        let totalWordCount = countReviewWord(user: user)
        let value4 = Value(infoTitle: infoVC_spellKing, sub1Title: "", sub1Value: infoVC_wordCount, sub2Title: "", sub2Value: "", avgValue: "", bigCountValue: String(totalWordCount), bigCountUnit: infoVC_wordUnit)
        values.append(value4)
        
        let totalSenCount = countReviewSen(user: user)
        let value5 = Value(infoTitle: infoVC_senKing, sub1Title: "", sub1Value: infoVC_senCount, sub2Title: "", sub2Value: "", avgValue: "", bigCountValue: String(totalSenCount), bigCountUnit: infoVC_senUnit)
        values.append(value5)
        
        completion(values)
    }
    
    
    func countReviewWord(user:[String:AnyObject]) -> Int{
        
                //MARK: must update
        
        var totalWordCount = Int()
      
        
               //快速複習單字數
        if let wordCount = user["wordReviewCount"] as? String{
                    if let wordCount2 = user["wordReviewCount2"] as? String{
                        if let wordCount3 = user["wordReviewCount3"] as? String{
                            if let wordCount4 = user["wordReviewCount4"] as? String{
                                if let wordCount5 = user["wordReviewCount5"] as? String {
                                    if let wordCount6 = user["wordReviewCount6"] as? String {
                                        if let wordCount7 = user["wordReviewCount7"] as? String {
                                            if let wordCount8 = user["wordReviewCount8"] as? String {
                                                if let wordCount9 = user["wordReviewCount9"] as? String {
        
        
                                totalWordCount = Int(wordCount)! + Int(wordCount2)! + Int(wordCount3)! + Int(wordCount4)! + Int(wordCount5)! + Int(wordCount6)! + Int(wordCount7)! + Int(wordCount8)! + Int(wordCount9)!
        
        
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
        return totalWordCount
        
    }
    
    func countReviewSen(user:[String:AnyObject]) -> Int{
        var totalSenCount = Int()
        //快速複習句型數
        if let senCount = user["senReviewCount"] as? String{
            if let senCount2 = user["senReviewCount2"] as? String{
                if let senCount3 = user["senReviewCount3"] as? String{
                    if let senCount4 = user["senReviewCount4"] as? String {
                        if let senCount5 = user["senReviewCount5"] as? String {
                            if let senCount6 = user["senReviewCount6"] as? String {
                                if let senCount7 = user["senReviewCount7"] as? String {
                                    if let senCount8 = user["senReviewCount8"] as? String {
                                        if let senCount9 = user["senReviewCount9"] as? String {
                                            
                                            
                                            totalSenCount = Int(senCount)! + Int(senCount2)! + Int(senCount3)! + Int(senCount4)! + Int(senCount5)! + Int(senCount6)! + Int(senCount7)! + Int(senCount8)! + Int(senCount9)!
                                            
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return totalSenCount
        
        
    }
    
    func countWord(user:[String:AnyObject]) ->(Int){
        
        
        var maxWordCount = Int()
        var allMapPassedCount = Int()
        var allWordsCount = Int()
        
        if let mapPassedString = user["mapPassed"] as! String?{
            
            mapPassed = Int(mapPassedString)!
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(mapPassed!, forKey: "mapPassed")
            
            print("retrieve mapPassed:\(mapPassed!)")
            
        }
        
        if let mapPassed2String = user["mapPassed2"] as! String?{
            
            mapPassed2 = Int(mapPassed2String)!
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(mapPassed2!, forKey: "mapPassed2")
            
            print("retrieve mapPassed:\(mapPassed2!)")
            
        }
        
        if let mapPassed3String = user["mapPassed3"] as! String?{
            
            mapPassed3 = Int(mapPassed3String)!
            let userDefaults = UserDefaults.standard
            userDefaults.set(mapPassed3!, forKey: "mapPassed3")
            
            print("retrieve mapPassed:\(mapPassed3!)")
            
        }
        
        if let mapPassed4String = user["mapPassed4"] as! String?{
            
            mapPassed4 = Int(mapPassed4String)!
            let userDefaults = UserDefaults.standard
            userDefaults.set(mapPassed4!, forKey: "mapPassed4")
            
            print("retrieve mapPassed:\(mapPassed4!)")
            
        }
        
        if let mapPassed5String = user["mapPassed5"] as! String?{
            
            mapPassed5 = Int(mapPassed5String)!
            let userDefaults = UserDefaults.standard
            userDefaults.set(mapPassed5!, forKey: "mapPassed5")
            
            print("retrieve mapPassed:\(mapPassed5!)")
            
        }
        
        //MARK: simVer K12 特別作法
        
        if let mapPassed6String = user["mapPassed6"] as! String?{
            print("enter 1")
            var mapPassedStringArray = mapPassed6String.components(separatedBy: ";")
            print("enter 2 :\(mapPassedStringArray)")
            for i in 0 ..< mapPassedStringArray.count {
                
                print("enter 3")
                //避免最後一位空值
                if mapPassedStringArray[i] != "" {
                    
                    k12MapPassed[i] = Int(mapPassedStringArray[i])!
                }
                
                print("enter 4 value:\(k12MapPassed)")
                
            }
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(k12MapPassed, forKey: "mapPassed6")
            
            print("retrieve k12MapPassed:\(k12MapPassed!)")
            
        }
        
        
        
        if let mapPassed7String = user["mapPassed7"] as! String?{
            
            mapPassed7 = Int(mapPassed7String)!
            let userDefaults = UserDefaults.standard
            userDefaults.set(mapPassed7!, forKey: "mapPassed7")
            
            print("retrieve mapPassed:\(mapPassed7!)")
            
        }
        
        if let mapPassed8String = user["mapPassed8"] as! String?{
            
            mapPassed8 = Int(mapPassed8String)!
            let userDefaults = UserDefaults.standard
            userDefaults.set(mapPassed8!, forKey: "mapPassed8")
            
            print("retrieve mapPassed:\(mapPassed8!)")
            
        }
        
        if let mapPassed9String = user["mapPassed9"] as! String?{
            
            mapPassed9 = Int(mapPassed9String)!
            let userDefaults = UserDefaults.standard
            userDefaults.set(mapPassed9!, forKey: "mapPassed9")
            
            print("retrieve mapPassed:\(mapPassed9!)")
            
        }
        
        
        
        if let gamePassedString = user["gamePassed"] as! String?{
            
            let gamePassedStringArray = gamePassedString.components(separatedBy: ":")
            
            let s = gamePassedStringArray[0]
            let u = gamePassedStringArray[1]
            gamePassed = [Int(s)!:Int(u)!]
            
            let userDefaults = UserDefaults.standard
            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed!)
            
            print("retrieve gamePassed:\(gamePassed!)")
            userDefaults.set(encodedObject, forKey: "gamePassed")
            
        }
        
        if let gamePassed2String = user["gamePassed2"] as! String?{
            
            let gamePassed2StringArray = gamePassed2String.components(separatedBy: ":")
            
            let s = gamePassed2StringArray[0]
            let u = gamePassed2StringArray[1]
            gamePassed2 = [Int(s)!:Int(u)!]
            
            let userDefaults = UserDefaults.standard
            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed2!)
            
            print("retrieve gamePassed:\(gamePassed2!)")
            userDefaults.set(encodedObject, forKey: "gamePassed2")
            
        }
        
        if let gamePassed3String = user["gamePassed3"] as! String?{
            
            let gamePassed3StringArray = gamePassed3String.components(separatedBy: ":")
            
            let s = gamePassed3StringArray[0]
            let u = gamePassed3StringArray[1]
            gamePassed3 = [Int(s)!:Int(u)!]
            
            let userDefaults = UserDefaults.standard
            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed3!)
            
            print("retrieve gamePassed:\(gamePassed3!)")
            userDefaults.set(encodedObject, forKey: "gamePassed3")
            
        }
        
        
        if let gamePassed4String = user["gamePassed4"] as! String?{
            
            let gamePassed4StringArray = gamePassed4String.components(separatedBy: ":")
            
            let s = gamePassed4StringArray[0]
            let u = gamePassed4StringArray[1]
            gamePassed4 = [Int(s)!:Int(u)!]
            
            let userDefaults = UserDefaults.standard
            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed4!)
            
            print("retrieve gamePassed:\(gamePassed4!)")
            userDefaults.set(encodedObject, forKey: "gamePassed4")
            
        }
        
        if let gamePassed5String = user["gamePassed5"] as! String?{
            
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
        
        if let gamePassed6String = user["gamePassed6"] as! String?{
            
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
        
        
        
        if let gamePassed7String = user["gamePassed7"] as! String?{
            
            let gamePassed7StringArray = gamePassed7String.components(separatedBy: ":")
            
            let s = gamePassed7StringArray[0]
            let u = gamePassed7StringArray[1]
            gamePassed7 = [Int(s)!:Int(u)!]
            
            let userDefaults = UserDefaults.standard
            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed7!)
            
            print("retrieve gamePassed:\(gamePassed7!)")
            userDefaults.set(encodedObject, forKey: "gamePassed7")
            
        }
        
        if let gamePassed8String = user["gamePassed8"] as! String?{
            
            let gamePassed8StringArray = gamePassed8String.components(separatedBy: ":")
            
            let s = gamePassed8StringArray[0]
            let u = gamePassed8StringArray[1]
            gamePassed8 = [Int(s)!:Int(u)!]
            
            let userDefaults = UserDefaults.standard
            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed8!)
            
            print("retrieve gamePassed:\(gamePassed8!)")
            userDefaults.set(encodedObject, forKey: "gamePassed8")
            
        }
        
        if let gamePassed9String = user["gamePassed9"] as! String?{
            
            let gamePassed9StringArray = gamePassed9String.components(separatedBy: ":")
            
            let s = gamePassed9StringArray[0]
            let u = gamePassed9StringArray[1]
            gamePassed9 = [Int(s)!:Int(u)!]
            
            let userDefaults = UserDefaults.standard
            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed9!)
            
            print("retrieve gamePassed:\(gamePassed9!)")
            userDefaults.set(encodedObject, forKey: "gamePassed9")
            
        }
        
        if lan == "zh-Hans"{
            //檢體中文
            
            //print("檢體中文關卡數")
            //之後還要用courseReceived來改數值, 因為每個course值不同
            
            allMapPassedCount =  mapPassed! * 330 + mapPassed2! * 450 + mapPassed3! * 450 +  mapPassed4! * 450 +  mapPassed5! * 450 + mapPassed7! * 450 + mapPassed8! * 450 + mapPassed9! * 450
            
            //MARK: simVer 另外計算K12的字數
            
            var k12ElemWordsMax = [120,330,330,300,330,330,330,330,390,390,330,330,210,330,300,180,390,390]
            
            //k12
            for i in 0 ..< k12MapPassed.count {
                
                if k12MapPassed[i] == 1 {
                    
                    allMapPassedCount += k12ElemWordsMax[i]
                    
                } else {
                    
                    //eachCellMyWordsCount[i] =
                    
                    for (s,u) in k12GamePassed[i] {
                        
                        allMapPassedCount += s * 30 + u * 3
                    }
                    
                    
                }
            }
            
            
            
        } else {
            //其餘語言
            //print("繁體中文關卡數")
            maxWordCount = 450
            
            allMapPassedCount = mapPassed! * maxWordCount + mapPassed2! * maxWordCount + mapPassed3! * maxWordCount + mapPassed4! * maxWordCount + mapPassed5! * maxWordCount
            
        }
        
        var gamePassedCount = Int()
        var gamePassed2Count = Int()
        var gamePassed3Count = Int()
        var gamePassed4Count = Int()
        var gamePassed5Count = Int()
        var gamePassed7Count = Int()
        var gamePassed8Count = Int()
        var gamePassed9Count = Int()
        
        
        for (s,u) in gamePassed!{
            gamePassedCount = s * 30 + u * 3
        }
        for (s,u) in gamePassed2!{
            gamePassed2Count = s * 30 + u * 3
        }
        
        
        for (s,u) in gamePassed3!{
            gamePassed3Count = s * 30 + u * 3
        }
        
        for (s,u) in gamePassed4!{
            gamePassed4Count = s * 30 + u * 3
        }
        
        for (s,u) in gamePassed5!{
            gamePassed5Count = s * 30 + u * 3
        }
        
        for (s,u) in gamePassed7!{
            gamePassed7Count = s * 30 + u * 3
        }
        for (s,u) in gamePassed8!{
            gamePassed8Count = s * 30 + u * 3
        }
        for (s,u) in gamePassed9!{
            gamePassed9Count = s * 30 + u * 3
        }
        
        let allGamePassedCount = gamePassedCount + gamePassed2Count + gamePassed3Count + gamePassed4Count + gamePassed5Count + gamePassed7Count + gamePassed8Count + gamePassed9Count
        allWordsCount = allMapPassedCount + allGamePassedCount
        
    
        return(allWordsCount)
        
        
        
    }
    
    

//
//    private func getUserInfo(completion: @escaping(Student) -> ()){
//
//        var student:Student?
//
//
//
//
//
//
//           // print("wrongWordsCount:\(wrongWordsCount)")
//
//            //外面做
////            if allWordsCount == 0 {
////                //這樣的話比例也是0
////
////                sub1Rates[0] = 0
////
////            } else {
////
////                sub1Rates[0] = Int((1 - (Double(wrongWordsCount) / Double(allWordsCount))) * 100)
////
////            }
//
//            //中文正確率
//
//            //目前中文正確率若設定為0的時候, cellForRow裡面不會顯示0%..雖然不影響但是怪怪的
//
//            if let wrongChinese = user?["wrongChinese"] as? String{
//
//                //外面做
////                if allWordsCount == 0 {
////                    //這樣的話比例也是0
////
////                    sub2Rates[0] = 0
////
////                } else {
////
////                    sub2Rates[0] = Int((1 - (Double(wrongChinese)! / Double(allWordsCount))) * 100)
////
////                }
//
//
//                student?.wrongChinese = wrongChinese
//
//            }
//
//
//
//        }
//
//
//
//
//
//        //抓分數
//        if let score = user?["score"] as? String{
//
//            userScore = score
//            scoreCountLabel.text = score
//
//        } else {
//
//            scoreCountLabel.text = infoVC_noScore
//            rankCountLabel.text = infoVC_noRank
//        }
//
//
//
//        //抓到分數後執行下方func
//
//        //MARK: simVer newVer
//
//
//        for i in 0 ..< stageScores.count{
//
//
//        }
//
//
//
//
//        FetchImage.shared.fetchAvatar(stagePassed:stagePassed) {[weak self] (avatar) in
//
//            self!.avatar = avatar
//            self!.avatarCollectionView.reloadData()
//
//        }
//
//
//
//
//
//        //print("stagePassed :\(stagePassed)")
//
//
//
//
//        //發音正確率
//
//        if let proRate = user?["proRate"] as? String{
//
//            if proRate == "200" {
//
//                sub1Rates[1] = 0
//
//            } else {
//
//                sub1Rates[1] = Int(proRate)!
//
//            }
//
//        }
//
//
//        //句子排列正確率
//
//        if let senRate = user?["senRate"] as? String{
//
//            if senRate == "200"{
//
//                sub1Rates[2] = 0
//
//            } else {
//
//                sub1Rates[2] = Int(senRate)!
//
//            }
//
//        }
//
//
//        //MARK: must update
//
//        //快速複習單字數
//        if let wordCount = user?["wordReviewCount"] as? String{
//            if let wordCount2 = user?["wordReviewCount2"] as? String{
//                if let wordCount3 = user?["wordReviewCount3"] as? String{
//                    if let wordCount4 = user?["wordReviewCount4"] as? String{
//                        if let wordCount5 = user?["wordReviewCount5"] as? String {
//                            if let wordCount6 = user?["wordReviewCount6"] as? String {
//                                if let wordCount7 = user?["wordReviewCount7"] as? String {
//                                    if let wordCount8 = user?["wordReviewCount8"] as? String {
//                                        if let wordCount9 = user?["wordReviewCount9"] as? String {
//
//
//                                            let totalWordCount = Int(wordCount)! + Int(wordCount2)! + Int(wordCount3)! + Int(wordCount4)! + Int(wordCount5)! + Int(wordCount6)! + Int(wordCount7)! + Int(wordCount8)! + Int(wordCount9)!
//
//
//                                            sub1Rates[3] = totalWordCount
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//
//        //快速複習句型數
//        if let senCount = user?["senReviewCount"] as? String{
//            if let senCount2 = user?["senReviewCount2"] as? String{
//                if let senCount3 = user?["senReviewCount3"] as? String{
//                    if let senCount4 = user?["senReviewCount4"] as? String {
//                        if let senCount5 = user?["senReviewCount5"] as? String {
//                            if let senCount6 = user?["senReviewCount6"] as? String {
//                                if let senCount7 = user?["senReviewCount7"] as? String {
//                                    if let senCount8 = user?["senReviewCount8"] as? String {
//                                        if let senCount9 = user?["senReviewCount9"] as? String {
//
//
//                                            let totalSenCount = Int(senCount)! + Int(senCount2)! + Int(senCount3)! + Int(senCount4)! + Int(senCount5)! + Int(senCount6)! + Int(senCount7)! + Int(senCount8)! + Int(senCount9)!
//
//                                            sub1Rates[4] = totalSenCount
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//
//
//        infoTableView.reloadData()
//
//
//
//        completion(student)
//
//    }
}
