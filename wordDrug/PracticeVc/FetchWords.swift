//
//  FetchWords.swift
//  wordDrug
//
//  Created by Ethan on 2019/3/13.
//  Copyright © 2019年 playplay. All rights reserved.
//
import UIKit

class FetchWords {
    
  
    static let shared = FetchWords()

    var wordSets = [[String]]()
    var sentenceSets = [[String]]()
    var wordArray = [Word]()



    
    func FetchWordFunc(completion: @escaping([Word]) ->()){
        
        var s = 0
        for eachLevel in 0 ..< publicMaxSpotNumArrayDic.count {
            for eachMap in 0 ..< publicMaxSpotNumArrayDic[eachLevel].count {

                s += 1
                
                if lan == "zh-Hans"{
                    s += 35
                }

                for eachTxt in 0 ..< publicMaxSpotNumArrayDic[eachLevel][eachMap]{
                    
                    var wordFile:String?

                //裡面的檔名也要加上increaseNum
                let name = String(s) + "-" + String(eachTxt + 1)
                let sName = "s" + String(s) + "-" + String(eachTxt + 1)
                
                    
                    //抓字
                    if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
                        do {
                            wordFile = try String(contentsOfFile: filepath)
                            let words = wordFile?.components(separatedBy: "; ")
                            
                            //把字讀取到wordSets裡
                            wordSets.append(words!)
                            //print(contents)
                        } catch {
                            // contents could not be loaded
                        }
                    } else {
                        // example.txt not found!
                    }
                    
                    var sentenceFile:String?
                    
                    //抓句子
                    if let filepath = Bundle.main.path(forResource: sName, ofType: "txt") {
                        do {
                            sentenceFile = try String(contentsOfFile: filepath)
                            let words = sentenceFile?.components(separatedBy: "; ")
                            
                            //把字讀取到wordSets裡
                            sentenceSets.append(words!)
                            //print(contents)
                            
                        } catch {
                            // contents could not be loaded
                        }
                    } else {
                        // example.txt not found!
                    }

                }
            }
            
        }
        

//        for s in 0 ..< 35{
//            for u in 0 ..< 15 {
//                var wordFile:String?
//                //前面的1代表第一張地圖
//
//                //裡面的檔名也要加上increaseNum
//                let name = String(s + 1) + "-" + String(u + 1)
//                let sName = "s" + String(s + 1) + "-" + String(u + 1)
//
//                //抓字
//                if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
//                    do {
//                        wordFile = try String(contentsOfFile: filepath)
//                        let words = wordFile?.components(separatedBy: "; ")
//
//                        //把字讀取到wordSets裡
//                        wordSets.append(words!)
//                        //print(contents)
//
//                    } catch {
//                        // contents could not be loaded
//                    }
//
//                } else {
//                    // example.txt not found!
//                }
//
//                var sentenceFile:String?
//
//                //抓句子
//                if let filepath = Bundle.main.path(forResource: sName, ofType: "txt") {
//                    do {
//                        sentenceFile = try String(contentsOfFile: filepath)
//                        let words = sentenceFile?.components(separatedBy: "; ")
//
//                        //把字讀取到wordSets裡
//                        sentenceSets.append(words!)
//                        //print(contents)
//
//                    } catch {
//                        // contents could not be loaded
//                    }
//                } else {
//                    // example.txt not found!
//                }
//            }
//        }
        
        mapPassed = 0
        gamePassed = [0:0]
        mapPassed2 = 1
        gamePassed2 = [0:0]
        mapPassed3 = 0
        gamePassed3 = [0:0]
        mapPassed4 = 0
        gamePassed4 = [0:0]
        mapPassed5 = 0
        gamePassed5 = [0:0]
//        k12MapPassed = [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
//        k12GamePassed = [[0: 0], [0: 2], [0: 1], [0: 1], [0: 1], [0: 1], [0: 1], [0: 1], [0: 1], [0: 1], [0: 1], [0: 1], [0: 1], [0: 0], [0: 1], [0: 1], [0: 0], [0: 0]]
        mapPassed6 = 0
        gamePassed6 = [0:0]
        mapPassed7 = 0
        gamePassed7 = [0:0]
        mapPassed8 = 0
        gamePassed8 = [0:0]
        mapPassed9 = 0
        gamePassed9 = [0:0]

        print("wordSets count:\(wordSets.count)")
        
        for i in 0 ..< wordSets.count{
            
            //抓單字
            for w in 0 ..< 30{
                
                //確認是否有過關
                
                let sequence = w + i * 30

                var maxUnits = Int()
                for i in 0 ..< publicMaxSpotNumArrayDic[0].count{
                    if mapPassed! > i {
                        maxUnits += publicMaxSpotNumArrayDic[0][i] * 30
                        
                    }
                }

                
                    //第一張地圖
                    if sequence < maxUnits {
                         loadWords(w: w, i: i)
                   
                    }
                    for (s,u) in gamePassed!{
                        if sequence > maxUnits - 1 && sequence < maxUnits + (s * 30) + u * 3 {
                            print("+++++++++++++++++++++++++")
                            loadWords(w: w, i: i)
        
                        }
                }
                
                
                var maxUnits2 = Int()
                for i in 0 ..< publicMaxSpotNumArrayDic[1].count{
                    if mapPassed2! > i {
                        maxUnits2 += publicMaxSpotNumArrayDic[1][i] * 30
                    }
                }
                
                
                var totalNum = Int()
                for i in 0 ..< publicMaxSpotNumArrayDic[0].count {
                    
                    totalNum += publicMaxSpotNumArrayDic[0][i] * 30
                    
                }
                
                    
                    //第2張地圖
                    if sequence > totalNum - 1 && sequence < totalNum + maxUnits2 {
                        loadWords(w: w, i: i)
                    }
                
                
                    for (s,u) in gamePassed2!{
                        if sequence > totalNum + maxUnits2 - 1 && sequence < totalNum + maxUnits2 + (s * 30) + u * 3 {
                            loadWords(w: w, i: i)
                        }
                    }
                
                
                var maxUnits3 = Int()
                for i in 0 ..< publicMaxSpotNumArrayDic[2].count{
                    if mapPassed3! > i {
                        maxUnits3 += publicMaxSpotNumArrayDic[2][i] * 30
                        
                    }
                }
                
                var totalNum2 = Int()
                for i in 0 ..< publicMaxSpotNumArrayDic[1].count {
                    
                    totalNum2 += publicMaxSpotNumArrayDic[1][i] * 30
                    
                }
  
                //第3張地圖
                if sequence > totalNum + totalNum2 - 1 && sequence < totalNum + totalNum2 + maxUnits3 {
                    loadWords(w: w, i: i)
                }
                for (s,u) in gamePassed3!{
                    if sequence > totalNum + totalNum2 + maxUnits3 - 1 && sequence < totalNum + totalNum2 + maxUnits3 + (s * 30) + u * 3 {
                        loadWords(w: w, i: i)
                    }
                }
                
                
                var maxUnits4 = Int()
                for i in 0 ..< publicMaxSpotNumArrayDic[3].count{
                    if mapPassed4! > i {
                        maxUnits4 += publicMaxSpotNumArrayDic[3][i] * 30
                        
                    }
                }
                
                var totalNum3 = Int()
                for i in 0 ..< publicMaxSpotNumArrayDic[2].count {
                    
                    totalNum3 += publicMaxSpotNumArrayDic[2][i] * 30
                    
                }

                
                
                
                //第4張地圖
                if sequence > totalNum + totalNum2 + totalNum3 - 1 && sequence < totalNum + totalNum2 + totalNum3 + maxUnits4 {
                    loadWords(w: w, i: i)
                }
                for (s,u) in gamePassed4!{
                    if sequence > totalNum + totalNum2 + totalNum3 + maxUnits4 - 1 && sequence < totalNum + totalNum2 + totalNum3 + maxUnits4 + (s * 30) + u * 3 {
                        loadWords(w: w, i: i)
                    }
                }
                
                
                var maxUnits5 = Int()
                for i in 0 ..< publicMaxSpotNumArrayDic[4].count{
                    if mapPassed5! > i {
                        maxUnits5 += publicMaxSpotNumArrayDic[4][i] * 30
                        
                    }
                }
                
                var totalNum4 = Int()
                for i in 0 ..< publicMaxSpotNumArrayDic[3].count {
                    
                    totalNum4 += publicMaxSpotNumArrayDic[3][i] * 30
                    
                }

                
                
                
                //第5張地圖
                if sequence > totalNum + totalNum2 + totalNum3 + totalNum4 - 1 && sequence < totalNum + totalNum2 + totalNum3 + totalNum4 + maxUnits5 {
                    loadWords(w: w, i: i)
                }
                for (s,u) in gamePassed5!{
                    if sequence > totalNum + totalNum2 + totalNum3 + totalNum4 + maxUnits5 - 1 && sequence < totalNum + totalNum2 + totalNum3 + totalNum4 + maxUnits5 + (s * 30) + u * 3 {
                        loadWords(w: w, i: i)
                    }
                }
                
                
                //3.27 繼續往大陸版寫下去
                   //第6張地圖
                var maxUnits6 = Int()
                for i in 0 ..< publicMaxSpotNumArrayDic[5].count{
                    if mapPassed6! > i {
                        maxUnits6 += publicMaxSpotNumArrayDic[5][i] * 30
                        
                    }
                }
                
                var totalNum5 = Int()
                for i in 0 ..< publicMaxSpotNumArrayDic[4].count {
                    
                    totalNum5 += publicMaxSpotNumArrayDic[4][i] * 30
                    
                }
              
                if sequence > totalNum + totalNum2 + totalNum3 + totalNum4 + totalNum5 - 1 && sequence < totalNum + totalNum2 + totalNum3 + totalNum4 + totalNum5 + maxUnits6 {
                    loadWords(w: w, i: i)
                }
                
                for (s,u) in gamePassed6!{
                    if sequence > totalNum + totalNum2 + totalNum3 + totalNum4 + totalNum5 + maxUnits6 - 1 && sequence < totalNum + totalNum2 + totalNum3 + totalNum4 + totalNum5 + maxUnits6 + (s * 30) + u * 3 {
                        loadWords(w: w, i: i)
                    }
                }
            
                //第7張地圖
                
                var maxUnits7 = Int()
                for i in 0 ..< publicMaxSpotNumArrayDic[6].count{
                    if mapPassed7! > i {
                        maxUnits7 += publicMaxSpotNumArrayDic[6][i] * 30
                        
                    }
                }
                
                var totalNum6 = Int()
                for i in 0 ..< publicMaxSpotNumArrayDic[5].count {
                    
                    totalNum6 += publicMaxSpotNumArrayDic[5][i] * 30
                    
                }
                
                if sequence > totalNum + totalNum2 + totalNum3 + totalNum4 + totalNum5 + totalNum6 - 1 && sequence < totalNum + totalNum2 + totalNum3 + totalNum4 + totalNum5 + totalNum6 + maxUnits7 {
                    loadWords(w: w, i: i)
                }
                for (s,u) in gamePassed7!{
                    if sequence > totalNum + totalNum2 + totalNum3 + totalNum4 + totalNum5 + totalNum6 + maxUnits7 - 1 && sequence < totalNum + totalNum2 + totalNum3 + totalNum4 + totalNum5 + totalNum6 + maxUnits7 + (s * 30) + u * 3 {
                        loadWords(w: w, i: i)
                    }
                }
                
                //第8張地圖
                
                var maxUnits8 = Int()
                for i in 0 ..< publicMaxSpotNumArrayDic[7].count{
                    if mapPassed8! > i {
                        maxUnits8 += publicMaxSpotNumArrayDic[7][i] * 30
                        
                    }
                }
                
                var totalNum7 = Int()
                for i in 0 ..< publicMaxSpotNumArrayDic[6].count {
                    
                    totalNum7 += publicMaxSpotNumArrayDic[6][i] * 30
                    
                }
                
                if sequence > totalNum + totalNum2 + totalNum3 + totalNum4 + totalNum5 + totalNum6 + totalNum7 - 1 && sequence < totalNum + totalNum2 + totalNum3 + totalNum4 + totalNum5 + totalNum6 + totalNum7 + maxUnits8 {
                    loadWords(w: w, i: i)
                }
                for (s,u) in gamePassed8!{
                    if sequence > totalNum + totalNum2 + totalNum3 + totalNum4 + totalNum5 + totalNum6 + totalNum7 + maxUnits8 - 1 && sequence < totalNum + totalNum2 + totalNum3 + totalNum4 + totalNum5 + totalNum6 + totalNum7 + maxUnits8 + (s * 30) + u * 3 {
                        loadWords(w: w, i: i)
                    }
                }
                
                //第9張地圖
                
                var maxUnits9 = Int()
                for i in 0 ..< publicMaxSpotNumArrayDic[8].count{
                    if mapPassed9! > i {
                        maxUnits9 += publicMaxSpotNumArrayDic[8][i] * 30
                        
                    }
                }
                
                var totalNum8 = Int()
                for i in 0 ..< publicMaxSpotNumArrayDic[7].count {
                    totalNum8 += publicMaxSpotNumArrayDic[7][i] * 30
                }
                
                if sequence > totalNum + totalNum2 + totalNum3 + totalNum4 + totalNum5 + totalNum6 + totalNum7 + totalNum8 - 1 && sequence < totalNum + totalNum2 + totalNum3 + totalNum4 + totalNum5 + totalNum6 + totalNum7 + totalNum8 + maxUnits9 {
                    loadWords(w: w, i: i)
                }
                for (s,u) in gamePassed9!{
                    if sequence > totalNum + totalNum2 + totalNum3 + totalNum4 + totalNum5 + totalNum6 + totalNum7 + totalNum8 + maxUnits9 - 1 && sequence < totalNum + totalNum2 + totalNum3 + totalNum4 + totalNum5 + totalNum6 + totalNum7 + totalNum8 + maxUnits9 + (s * 30) + u * 3 {
                        loadWords(w: w, i: i)
                    }
                }

                //抓出正確的順序
                //MARK: simVer 這裡的syllables 要更改
                
//                var syllableSequence = Int()
//
//                if lan == "zh-Hans" && isSimVerSingleSyllable{
//                    //檢體中文
//
//                    syllableSequence = Int(i * 30) +  Int(w)
//
//
//                } else {
//                    //其餘語言
//                    //print("繁體中文關卡數")
//                    syllableSequence = Int(i * 10) +  Int(w / 3)
//
//                }
//
//                //排除掉K12, 到後方抓殘字時再處理, 這裡先保留著之後再check
//                syllablesToShow.append(sylArray[syllableSequence])
//
//
                
            }
        }
        
//        print("how many words:\(wordArray.count)")
//        print("word loaded:\(wordArray)")
        

        completion(wordArray)
        
    }
    
    func loadWords(w:Int, i:Int){
        
        var engWordElement = String()
        var engWord = String()
        var engSen = String()
        var chiWord = String()
        var chiSen = String()
        var partOfSpeechToShow = String()
        var syllable = String()
        var syllableSets = [[String]]()
        let word = Word()
        
        wordArray.append(word)
       print("start 1")
        engWordElement = wordSets[i][w]
        engWord = engWordElement.replacingOccurrences(of: " ", with: "")
        engSen = sentenceSets[i][w]
        chiWord = wordSets[i][w + 30]
        chiSen = sentenceSets[i][w + 30]
        partOfSpeechToShow = wordSets[i][w + 60]
        print("receive i :\(i)")

        var numberI = Int()
        if lan == "zh-Hans"{
            numberI = i + 525
            print("簡體找音節")
        }
        
        var syllableSetsNumber = Int()
        var syllableGroupNumber = Int()
        switch numberI{
        case 0 ... 14:
            syllableSets = map1SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
            
        case 15 ... 29:
            syllableSets = map2SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 30 ... 44:
            syllableSets = map3SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 45 ... 59:
            syllableSets = map4SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 60 ... 74:
            syllableSets = map5SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 75 ... 89:
            syllableSets = map6SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 90 ... 104:
            syllableSets = map7SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 105 ... 119:
            syllableSets = map8SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 120 ... 134:
            syllableSets = map9SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
            
        case 135 ... 149:
            syllableSets = map10SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 150 ... 164:
            syllableSets = map11SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 165 ... 179:
            syllableSets = map12SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 180 ... 194:
            syllableSets = map13SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 195 ... 209:
            syllableSets = map14SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 210 ... 224:
            syllableSets = map15SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 225 ... 239:
            syllableSets = map16SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 240 ... 254:
            syllableSets = map17SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 255 ... 269:
            syllableSets = map18SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 270 ... 284:
            syllableSets = map19SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 285 ... 299:
            syllableSets = map20SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 300 ... 314:
            syllableSets = map21SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 315 ... 329:
            syllableSets = map22SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 330 ... 344:
            syllableSets = map23SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 345 ... 359:
            syllableSets = map24SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 360 ... 374:
            syllableSets = map25SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 375 ... 389:
            syllableSets = map26SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 390 ... 404:
            syllableSets = map27SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 405 ... 419:
            syllableSets = map28SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 420 ... 434:
            syllableSets = map29SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 435 ... 449:
            syllableSets = map30SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 450 ... 464:
            syllableSets = map31SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 465 ... 479:
            syllableSets = map32SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 480 ... 494:
            syllableSets = map33SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 495 ... 509:
            syllableSets = map34SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 510 ... 524:
            syllableSets = map35SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
            
        //以下為簡體部分
        case 525 ... 535:
            syllableSets = map36SyllableSets
            syllableSetsNumber = 11
            syllableGroupNumber = 1
        case 536 ... 546:
            syllableSets = map37SyllableSets
            syllableSetsNumber = 11
            syllableGroupNumber = 1
        case 547 ... 557:
            syllableSets = map38SyllableSets
            syllableSetsNumber = 11
            syllableGroupNumber = 1

            
        case 558 ... 572:
            syllableSets = map39SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3

        case 573 ... 587:
            syllableSets = map40SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3

        case 588 ... 602:
            syllableSets = map41SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3

        case 603 ... 617:
            syllableSets = map42SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3

        case 618 ... 632:
            syllableSets = map43SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3

       
        
        case 633 ... 647:
            syllableSets = map44SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3

        case 648 ... 662:
            syllableSets = map45SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3

        case 663 ... 677:
            syllableSets = map46SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 678 ... 692:
            syllableSets = map47SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 693 ... 707:
            syllableSets = map48SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 708 ... 722:
            syllableSets = map49SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
       
            
            
        case 723 ... 737:
            syllableSets = map50SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3

        case 738 ... 752:
            syllableSets = map51SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 753 ... 767:
            syllableSets = map52SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 768 ... 782:
            syllableSets = map53SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 783 ... 797:
            syllableSets = map54SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 798 ... 812:
            syllableSets = map55SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 813 ... 827:
            syllableSets = map56SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 828 ... 842:
            syllableSets = map57SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 843 ... 857:
            syllableSets = map58SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 858 ... 872:
            syllableSets = map59SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 873 ... 887:
            syllableSets = map60SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
       
        
        case 888 ... 902:
            syllableSets = map61SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 903 ... 917:
            syllableSets = map62SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 918 ... 932:
            syllableSets = map63SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 933 ... 947:
            syllableSets = map64SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 948 ... 962:
            syllableSets = map65SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 963 ... 977:
            syllableSets = map66SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 978 ... 992:
            syllableSets = map67SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 993 ... 1007:
            syllableSets = map68SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1008 ... 1022:
            syllableSets = map69SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1023 ... 1037:
            syllableSets = map70SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1038 ... 1052:
            syllableSets = map71SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1053 ... 1067:
            syllableSets = map72SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1068 ... 1082:
            syllableSets = map73SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
      
        
        
        case 1083 ... 1086:
            syllableSets = map74SyllableSets
            syllableSetsNumber = 4
            syllableGroupNumber = 1

  
        case 1087 ... 1097:
            syllableSets = map75SyllableSets
            syllableSetsNumber = 11
            syllableGroupNumber = 1
        case 1098 ... 1108:
            syllableSets = map76SyllableSets
            syllableSetsNumber = 11
            syllableGroupNumber = 1
        
        
        
        case 1109 ... 1118:
            syllableSets = map77SyllableSets
            syllableSetsNumber = 10
            syllableGroupNumber = 1
            
            
        case 1119 ... 1129:
            syllableSets = map78SyllableSets
            syllableSetsNumber = 11
            syllableGroupNumber = 1
        case 1130 ... 1140:
            syllableSets = map79SyllableSets
            syllableSetsNumber = 11
            syllableGroupNumber = 1
        case 1141 ... 1151:
            syllableSets = map80SyllableSets
            syllableSetsNumber = 11
            syllableGroupNumber = 1
        case 1152 ... 1162:
            syllableSets = map81SyllableSets
            syllableSetsNumber = 11
            syllableGroupNumber = 1
     
        
        
        case 1163 ... 1175:
            syllableSets = map82SyllableSets
            syllableSetsNumber = 13
            syllableGroupNumber = 1
        case 1176 ... 1188:
            syllableSets = map83SyllableSets
            syllableSetsNumber = 13
            syllableGroupNumber = 1
        
        
        
        
        case 1189 ... 1199:
            syllableSets = map84SyllableSets
            syllableSetsNumber = 11
            syllableGroupNumber = 1
        case 1200 ... 1210:
            syllableSets = map85SyllableSets
            syllableSetsNumber = 11
            syllableGroupNumber = 1
        
        
        
        case 1211 ... 1217:
            syllableSets = map86SyllableSets
            syllableSetsNumber = 7
            syllableGroupNumber = 1
       
        
        
        case 1218 ... 1228:
            syllableSets = map87SyllableSets
            syllableSetsNumber = 11
            syllableGroupNumber = 1
        case 1229 ... 1239:
            syllableSets = map88SyllableSets
            syllableSetsNumber = 11
            syllableGroupNumber = 1
        
        
        
        case 1240 ... 1245:
            syllableSets = map89SyllableSets
            syllableSetsNumber = 6
            syllableGroupNumber = 1
      
        
        
        case 1246 ... 1258:
            syllableSets = map90SyllableSets
            syllableSetsNumber = 13
            syllableGroupNumber = 1

        case 1259 ... 1271:
            syllableSets = map91SyllableSets
            syllableSetsNumber = 13
            syllableGroupNumber = 1
      
        
        //接著15個到底
            
        case 1272 ... 1286:
            syllableSets = map92SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1287 ... 1301:
            syllableSets = map93SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1302 ... 1316:
            syllableSets = map94SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1317 ... 1331:
            syllableSets = map95SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1332 ... 1346:
            syllableSets = map96SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1347 ... 1361:
            syllableSets = map97SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1362 ... 1376:
            syllableSets = map98SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1377 ... 1391:
            syllableSets = map99SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1392 ... 1406:
            syllableSets = map100SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3

        case 1407 ... 1421:
            syllableSets = map101SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1422 ... 1436:
            syllableSets = map102SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1437 ... 1451:
            syllableSets = map103SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1452 ... 1466:
            syllableSets = map104SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1467 ... 1481:
            syllableSets = map105SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1482 ... 1496:
            syllableSets = map106SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1497 ... 1511:
            syllableSets = map107SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1512 ... 1526:
            syllableSets = map108SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1527 ... 1541:
            syllableSets = map109SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1542 ... 1556:
            syllableSets = map110SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3

        case 1557 ... 1571:
            syllableSets = map111SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1572 ... 1586:
            syllableSets = map112SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1587 ... 1601:
            syllableSets = map113SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1602 ... 1616:
            syllableSets = map114SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3
        case 1617 ... 1631:
            syllableSets = map115SyllableSets
            syllableSetsNumber = 15
            syllableGroupNumber = 3

        default:
            break
        }
        
        syllable = syllableSets[i % syllableSetsNumber][w / syllableGroupNumber]
        
        
        let sylBreaks = syllable.components(separatedBy: NSCharacterSet.decimalDigits)
        let sylOnlyText = sylBreaks[0]

        wordArray[wordArray.count - 1].engWordElement = engWordElement
        wordArray[wordArray.count - 1].engWord = engWord
        wordArray[wordArray.count - 1].engSen = engSen
        wordArray[wordArray.count - 1].chiWord = chiWord
        wordArray[wordArray.count - 1].chiSen = chiSen
        wordArray[wordArray.count - 1].partOfSpeech = partOfSpeechToShow
        wordArray[wordArray.count - 1].isSelected = false
        wordArray[wordArray.count - 1].syllable = sylOnlyText
        wordArray[wordArray.count - 1].isReviewWrong = false
        wordArray[wordArray.count - 1].isReviewWrongLocked = false
        
        
    }

}

    
    

