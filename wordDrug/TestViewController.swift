//
//  TestViewController.swift
//  wordDrug
//
//  Created by Ethan on 2019/7/31.
//  Copyright © 2019年 playplay. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        fetchWord()

   
    }
    

    var wordSets = [String]()

    var mapNum = Int()
    
    func fetchWord(){
        //MARK: simVer K12的地圖讀法要再增加

        let firstLetter = 94
        let secondLetter = 7
        
        var sylSetsToCheck = [[String]]()
        var sylToCheck = [String]()

        
        for f in 93 ..< firstLetter {
            
            for s in 0 ..< secondLetter {
                
                sylToCheck = [String]()
                
                let name = String(f + 1) + "-" + String(s + 1)
                
                sylSetsToCheck = returnSylSets(mapNum: f)
                
                

                
                for syl in sylSetsToCheck[s] {

                    let sylBreaks = syl.components(separatedBy: NSCharacterSet.decimalDigits)
                    let sylOnlyText = sylBreaks[0]
                    sylToCheck.append(sylOnlyText)

                }
                
                var wordFile:String?
                
                if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
                    do {
                        wordFile = try String(contentsOfFile: filepath)
                        let words = wordFile?.components(separatedBy: "; ")
                        
                        //把字讀取到wordSets裡
                        wordSets = words!
                        //print(contents)
                    } catch {
                        // contents could not be loaded
                    }
                } else {
                    // example.txt not found!
                }
                
                
                var engWordSets = [String]()
                for i in 0 ..< 30 {
                    
                    engWordSets.append(wordSets[i])
                    
                }
          
                
                //check each word
                for i in 0 ..< engWordSets.count {
                    


                    
                    
                    var isChecked = false
                    
                    let word = engWordSets[i]
                    
                    let wordArray = word.components(separatedBy: " ")
//                    print("wordArray: \(wordArray)")
                    for seperatedWord in wordArray {
//                        print("checking: \(word) with sylToCheck: \(sylToCheck[i / 3])")
                        
                        if seperatedWord.lowercased() == sylToCheck[i / 3] {
                            //if seperatedWord.lowercased() == sylToCheck[i] {
                            
//                            print("\(word) containts \(sylToCheck[i / 3])")
                            isChecked = true
                        }
                        
                    }
                    
                    //print("isChecked:\(isChecked)")
                    
                    if !isChecked {
                        if !sylToCheck[i / 3].contains(Character("_")){
                        //    if !sylToCheck[i].contains(Character("_")){
                        
                            print("fileName:\(name)")
                            print("\(word) has problem")
                        }
                    }
                    
                }
                
                
            }
            
        }
        
    }
    
    
    func returnSylSets(mapNum:Int) ->[[String]] {
    
    var syllableSets = [[String]]()
    
    
    switch mapNum {
    case 0:
    syllableSets = map1SyllableSets
    case 1:
    syllableSets = map2SyllableSets
    case 2:
    syllableSets = map3SyllableSets
    case 3:
    syllableSets = map4SyllableSets
    case 4:
    syllableSets = map5SyllableSets
    case 5:
    syllableSets = map6SyllableSets
    case 6:
    syllableSets = map7SyllableSets
    case 7:
    syllableSets = map8SyllableSets
    
    case 8:
    syllableSets = map9SyllableSets
    
    case 9:
    syllableSets = map10SyllableSets
    case 10:
    syllableSets = map11SyllableSets
    case 11:
    syllableSets = map12SyllableSets
    case 12:
    syllableSets = map13SyllableSets
    case 13:
    syllableSets = map14SyllableSets
    case 14:
    syllableSets = map15SyllableSets
    case 15:
    syllableSets = map16SyllableSets
    case 16:
    syllableSets = map17SyllableSets
    case 17:
    syllableSets = map18SyllableSets
    case 18:
    syllableSets = map19SyllableSets
    case 19:
    syllableSets = map20SyllableSets
    case 20:
    syllableSets = map21SyllableSets
    case 21:
    syllableSets = map22SyllableSets
    case 22:
    syllableSets = map23SyllableSets
    case 23:
    syllableSets = map24SyllableSets
    case 24:
    syllableSets = map25SyllableSets
    case 25:
    syllableSets = map26SyllableSets
    case 26:
    syllableSets = map27SyllableSets
    
    case 27:
    syllableSets = map28SyllableSets
    case 28:
    syllableSets = map29SyllableSets
    case 29:
    syllableSets = map30SyllableSets
    case 30:
    syllableSets = map31SyllableSets
    case 31:
    syllableSets = map32SyllableSets
    case 32:
    syllableSets = map33SyllableSets
    case 33:
    syllableSets = map34SyllableSets
    case 34:
    syllableSets = map35SyllableSets
    
    //以下為簡體部分
    case 35:
    syllableSets = map36SyllableSets
    case 36:
    syllableSets = map37SyllableSets
    case 37:
    syllableSets = map38SyllableSets
    
    case 38:
    syllableSets = map39SyllableSets
    case 39:
    syllableSets = map40SyllableSets
    case 40:
    syllableSets = map41SyllableSets
    case 41:
    syllableSets = map42SyllableSets
    case 42:
    syllableSets = map43SyllableSets
    case 43:
    syllableSets = map44SyllableSets
    case 44:
    syllableSets = map45SyllableSets
    case 45:
    syllableSets = map46SyllableSets
    case 46:
    syllableSets = map47SyllableSets
    case 47:
    syllableSets = map48SyllableSets
    case 48:
    syllableSets = map49SyllableSets
    case 49:
    syllableSets = map50SyllableSets
    case 50:
    syllableSets = map51SyllableSets
    case 51:
    syllableSets = map52SyllableSets
    case 52:
    syllableSets = map53SyllableSets
    case 53:
    syllableSets = map54SyllableSets
    case 54:
    syllableSets = map55SyllableSets
    case 55:
    syllableSets = map56SyllableSets
    case 56:
    syllableSets = map57SyllableSets
    case 57:
    syllableSets = map58SyllableSets
    case 58:
    syllableSets = map59SyllableSets
    case 59:
    syllableSets = map60SyllableSets
    case 60:
    syllableSets = map61SyllableSets
    case 61:
    syllableSets = map62SyllableSets
    case 62:
    syllableSets = map63SyllableSets
    case 63:
    syllableSets = map64SyllableSets
    case 64:
    syllableSets = map65SyllableSets
    case 65:
    syllableSets = map66SyllableSets
    case 66:
    syllableSets = map67SyllableSets
    case 67:
    syllableSets = map68SyllableSets
    case 68:
    syllableSets = map69SyllableSets
    case 69:
    syllableSets = map70SyllableSets
    
    case 70:
    syllableSets = map71SyllableSets
    case 71:
    syllableSets = map72SyllableSets
    case 72:
    syllableSets = map73SyllableSets
    case 73:
    syllableSets = map74SyllableSets
    case 74:
    syllableSets = map75SyllableSets
    case 75:
    syllableSets = map76SyllableSets
    case 76:
    syllableSets = map77SyllableSets
    case 77:
    syllableSets = map78SyllableSets
    case 78:
    syllableSets = map79SyllableSets
    case 79:
    syllableSets = map80SyllableSets
    
    
    case 80:
    syllableSets = map81SyllableSets
    case 81:
    syllableSets = map82SyllableSets
    case 82:
    syllableSets = map83SyllableSets
    case 83:
    syllableSets = map84SyllableSets
    case 84:
    syllableSets = map85SyllableSets
    case 85:
    syllableSets = map86SyllableSets
    case 86:
    syllableSets = map87SyllableSets
    case 87:
    syllableSets = map88SyllableSets
    case 88:
    syllableSets = map89SyllableSets
    case 89:
    syllableSets = map90SyllableSets
    
    case 90:
    syllableSets = map91SyllableSets
    case 91:
    syllableSets = map92SyllableSets
    case 92:
    syllableSets = map93SyllableSets
    case 93:
    syllableSets = map94SyllableSets
    case 94:
    syllableSets = map95SyllableSets
    case 95:
    syllableSets = map96SyllableSets
    case 96:
    syllableSets = map97SyllableSets
    case 97:
    syllableSets = map98SyllableSets
    case 98:
    syllableSets = map99SyllableSets
    case 99:
    syllableSets = map100SyllableSets
    
    case 100:
    syllableSets = map101SyllableSets
    case 101:
    syllableSets = map102SyllableSets
    case 102:
    syllableSets = map103SyllableSets
    case 103:
    syllableSets = map104SyllableSets
    case 104:
    syllableSets = map105SyllableSets
    case 105:
    syllableSets = map106SyllableSets
    case 106:
    syllableSets = map107SyllableSets
    case 107:
    syllableSets = map108SyllableSets
    case 108:
    syllableSets = map109SyllableSets
    case 109:
    syllableSets = map110SyllableSets
    
    case 110:
    syllableSets = map111SyllableSets
    case 111:
    syllableSets = map112SyllableSets
    case 112:
    syllableSets = map113SyllableSets
    case 113:
    syllableSets = map114SyllableSets
    case 114:
    syllableSets = map115SyllableSets
    
    default:
    break
    }
    
    return syllableSets
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
