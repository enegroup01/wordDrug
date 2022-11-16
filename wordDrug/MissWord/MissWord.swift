//
//  MissWord.swift
//  wordDrug
//
//  Created by Ethan on 2020/5/8.
//  Copyright © 2020 playplay. All rights reserved.
//

/*
nothing
 big 1
 small 1
 small 2
 */

import Foundation

struct MissWord {
    static let simplifiedElementaryWordCount = 330
    static let generalWordCount = 450
}

enum StageLock {
    case locked
    case unlocked
}

enum Language {
    case traditional
    case simplified
    
    init(rawValue: String) {
        switch rawValue {
        case "zh-Hans": self = .simplified
        default: self = .traditional
        }
    }
}

enum Level: Int {
    case one = 0
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
}

struct Course {
    var language: Language
    var level: Level
    var mapNumberReceived: Int?
    var isClassAllPassed: Bool // needed?
    var isUnlocked: Bool
    
    init(language: String, level: Level, mapNumberReceive: Int?, isClassAllPassed: Bool, isUnlocked: Bool) {
        self.language = Language(rawValue: language)
        self.level = level
        self.mapNumberReceived = mapNumberReceive
        self.isClassAllPassed = isClassAllPassed
        self.isUnlocked = isUnlocked
    }
    
    var isTraditional: Bool {
        return language == .traditional
    }
    
    var increaseNumber: Int {
        switch level {
        case .one:
            return isTraditional ? 0 : 35
        case .two:
            return isTraditional ? 5 : 38
        case .three:
            return isTraditional ? 11 : 43
        case .four:
            return isTraditional ? 18 : 49
        case .five:
            return isTraditional ? 27 : 60
        case .six:
            return isTraditional ? 0 : 73
        case .seven:
            return isTraditional ? 0 : 91
        case .eight:
            return isTraditional ? 0 : 98
        case .nine:
            return isTraditional ? 0 : 107
        }
    }
    
    var maxMapNumber: Int {
        switch level {
        case .one:
            return isTraditional ? 5 : 3
        case .two:
            return isTraditional ? 6 : 5
        case .three:
            return isTraditional ? 7 : 6
        case .four:
            return isTraditional ? 9 : 11
        case .five:
            return isTraditional ? 8 : 13
        case .six:
            return isTraditional ? 0 : 18
        case .seven:
            return isTraditional ? 0 : 7
        case .eight:
            return isTraditional ? 0 : 9
        case .nine:
            return isTraditional ? 0 : 8
        }
    }
    var isSimVersionSingleSyllableSet: Bool {
        switch level {
        case .one, .six:
            return true
        default:
            return false
        }
    }
    
    var maxStageCount: Int {
        switch language {
        case .simplified: return 13
        case .traditional: return 9
        }
    }
    
    var isAllMapPassed: Bool {
        return maxStageCount == mapPass ? true : false
    }
        
    /*
     //MARK: simVer K12 課程紀錄變數
     var k12MapPassed:[Int]!
     var k12GamePassed:[[Int:Int]]!
     */
    //MARK: 11/10 start refact gamePass
    var gamePass: [Int:Int]? {
        switch level {
        case .one: return gamePassed
        case .two: return gamePassed2
        case .three: return gamePassed3
        case .four: return gamePassed4
        case .five: return gamePassed5
        case .six: return nil
        case .seven: return gamePassed7
        case .eight: return gamePassed8
        case .nine: return gamePassed9
        }
    }
    
    var mapPass: Int? {
        switch level {
        case .one: return mapPassed
        case .two: return mapPassed2
        case .three: return mapPassed3
        case .four: return mapPassed4
        case .five: return mapPassed5
        case .six: return nil
        case .seven: return mapPassed7
        case .eight: return mapPassed8
        case .nine: return mapPassed9
        }
    }
}




struct File {
    var chapter: Int
    var unit: Int
    var wordFileName: String {
        return String(chapter) + "-" + String(unit)
    }
    var sentenceFileName: String {
        return "s" + String(chapter) + "-" + String(unit)
    }
    
    init(chapter: Int, unit: Int) {
        self.chapter = chapter
        self.unit = unit
    }
}

struct Word {
    var partedEnglish: String
    var partedEnglishArray: [String] {
        return partedEnglish.components(separatedBy: " ")
    }
    var chinese: String
    var partOfSpeech: String
    var englishSentence: String
    var chineseSentence: String
    var syllable: String
    var english: String {
        return partedEnglish.replacingOccurrences(of: " ", with: "")
    }
        
    init(syllables: String, chinese: String, partOfSpeech: String, englishSentence: String, chineseSentence: String, highlightWord: String) {
        self.partedEnglish = syllables
        self.chinese = chinese
        self.partOfSpeech = partOfSpeech
        self.englishSentence = englishSentence
        self.chineseSentence = chineseSentence
        self.syllable = highlightWord
    }
}

extension Course {
    var syllableSets: [[String]] {
        switch mapNumberReceived ?? 0 + increaseNumber {
        case 0:
            return map1SyllableSets
        case 1:
            return map2SyllableSets
        case 2:
            return map3SyllableSets
        case 3:
            return map4SyllableSets
        case 4:
            return map5SyllableSets
        case 5:
            return map6SyllableSets
        case 6:
            return map7SyllableSets
        case 7:
            return map8SyllableSets
        case 8:
            return map9SyllableSets
        case 9:
            return map10SyllableSets
        case 10:
            return map11SyllableSets
        case 11:
            return map12SyllableSets
        case 12:
            return map13SyllableSets
        case 13:
            return map14SyllableSets
        case 14:
            return map15SyllableSets
        case 15:
            return map16SyllableSets
        case 16:
            return map17SyllableSets
        case 17:
            return map18SyllableSets
        case 18:
            return map19SyllableSets
        case 19:
            return map20SyllableSets
        case 20:
            return map21SyllableSets
        case 21:
            return map22SyllableSets
        case 22:
            return map23SyllableSets
        case 23:
            return map24SyllableSets
        case 24:
            return map25SyllableSets
        case 25:
            return map26SyllableSets
        case 26:
            return map27SyllableSets
        case 27:
            return map28SyllableSets
        case 28:
            return map29SyllableSets
        case 29:
            return map30SyllableSets
        case 30:
            return map31SyllableSets
        case 31:
            return map32SyllableSets
        case 32:
            return map33SyllableSets
        case 33:
            return map34SyllableSets
        case 34:
            return map35SyllableSets
            //以下為簡體部分
        case 35:
            return map36SyllableSets
        case 36:
            return map37SyllableSets
        case 37:
            return map38SyllableSets
        case 38:
            return map39SyllableSets
        case 39:
            return map40SyllableSets
        case 40:
            return map41SyllableSets
        case 41:
            return map42SyllableSets
        case 42:
            return map43SyllableSets
        case 43:
            return map44SyllableSets
        case 44:
            return map45SyllableSets
        case 45:
            return map46SyllableSets
        case 46:
            return map47SyllableSets
        case 47:
            return map48SyllableSets
        case 48:
            return map49SyllableSets
        case 49:
            return map50SyllableSets
        case 50:
            return map51SyllableSets
        case 51:
            return map52SyllableSets
        case 52:
            return map53SyllableSets
        case 53:
            return map54SyllableSets
        case 54:
            return map55SyllableSets
        case 55:
            return map56SyllableSets
        case 56:
            return map57SyllableSets
        case 57:
            return map58SyllableSets
        case 58:
            return map59SyllableSets
        case 59:
            return map60SyllableSets
        case 60:
            return map61SyllableSets
        case 61:
            return map62SyllableSets
        case 62:
            return map63SyllableSets
        case 63:
            return map64SyllableSets
        case 64:
            return map65SyllableSets
        case 65:
            return map66SyllableSets
        case 66:
            return map67SyllableSets
        case 67:
            return map68SyllableSets
        case 68:
            return map69SyllableSets
        case 69:
            return map70SyllableSets
        case 70:
            return map71SyllableSets
        case 71:
            return map72SyllableSets
        case 72:
            return map73SyllableSets
        case 73:
            return map74SyllableSets
        case 74:
            return map75SyllableSets
        case 75:
            return map76SyllableSets
        case 76:
            return map77SyllableSets
        case 77:
            return map78SyllableSets
        case 78:
            return map79SyllableSets
        case 79:
            return map80SyllableSets
        case 80:
            return map81SyllableSets
        case 81:
            return map82SyllableSets
        case 82:
            return map83SyllableSets
        case 83:
            return map84SyllableSets
        case 84:
            return map85SyllableSets
        case 85:
            return map86SyllableSets
        case 86:
            return map87SyllableSets
        case 87:
            return map88SyllableSets
        case 88:
            return map89SyllableSets
        case 89:
            return map90SyllableSets
        case 90:
            return map91SyllableSets
        case 91:
            return map92SyllableSets
        case 92:
            return map93SyllableSets
        case 93:
            return map94SyllableSets
        case 94:
            return map95SyllableSets
        case 95:
            return map96SyllableSets
        case 96:
            return map97SyllableSets
        case 97:
            return map98SyllableSets
        case 98:
            return map99SyllableSets
        case 99:
            return map100SyllableSets
        case 100:
            return map101SyllableSets
        case 101:
            return map102SyllableSets
        case 102:
            return map103SyllableSets
        case 103:
            return map104SyllableSets
        case 104:
            return map105SyllableSets
        case 105:
            return map106SyllableSets
        case 106:
            return map107SyllableSets
        case 107:
            return map108SyllableSets
        case 108:
            return map109SyllableSets
        case 109:
            return map110SyllableSets
        case 110:
            return map111SyllableSets
        case 111:
            return map112SyllableSets
        case 112:
            return map113SyllableSets
        case 113:
            return map114SyllableSets
        case 114:
            return map115SyllableSets
        default:
            return [[String]()]
        }
    }
}

class MissWordUtility:NSObject {
   
    public static let shared = MissWordUtility()
    
    func sortWords(data: [[String]]) -> [Word] {
        var wordSets:[Word] = []
        let offSets:Int = 30
        //TODO: check if highlightword index is correct?
        for i in 0 ..< 30 {
            let word = Word(syllables: data[0][i], chinese: data[0][i + offSets], partOfSpeech: data[0][i + offSets * 2], englishSentence: data[1][i], chineseSentence: data[1][i + offSets], highlightWord: data[2][i / 3].removingCharacters(inCharacterSet: .decimalDigits))
            wordSets.append(word)
        }
        return wordSets
    }
   
    func loadWords(file: File) -> [Word] {
        var texts:[String]
        var sentenceTexts:[String]
        var syllableSets:[String]
        var allTexts:[[String]] = [[]]
        texts = loadFile(fileName: file.wordFileName)
        sentenceTexts = loadFile(fileName: file.sentenceFileName)
        syllableSets = findSyllableSets(file: file)
        
        allTexts.removeFirst()
        allTexts.append(texts)
        allTexts.append(sentenceTexts)
        allTexts.append(syllableSets)
        
        let words = sortWords(data: allTexts)
        return words
    }
    
    private func loadFile(fileName:String) -> [String] {
        var textfile:String?
        var textSets:[String] = []
        if let filepath = Bundle.main.path(forResource: fileName, ofType: "txt") {
            do {
                textfile = try String(contentsOfFile: filepath)
                guard let text = textfile?.components(separatedBy: "; ") else {
                    return []
                }
                textSets.append(contentsOf: text)
                
            } catch {
                return []
            }
        }
        return textSets
        
    }
    
    private func findSyllableSets(file: File) -> [String] {
        let syllableSets = allSyllableSets[file.chapter - 1][file.unit - 1]
        return syllableSets
    }
}
