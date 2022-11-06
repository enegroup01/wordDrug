//
//  MissWord.swift
//  wordDrug
//
//  Created by Ethan on 2020/5/8.
//  Copyright © 2020 playplay. All rights reserved.
//

import Foundation

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
    var syllables: String
    var chinese: String
    var partOfSpeech: String
    var englishSentence: String
    var chineseSentence: String
    var highlightWord: String
    var english: String {
        return syllables.replacingOccurrences(of: " ", with: "")
    }
        
    init(syllables: String, chinese: String, partOfSpeech: String, englishSentence: String, chineseSentence: String, highlightWord: String) {
        self.syllables = syllables
        self.chinese = chinese
        self.partOfSpeech = partOfSpeech
        self.englishSentence = englishSentence
        self.chineseSentence = chineseSentence
        self.highlightWord = highlightWord
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
    
    private func findSyllableSets(file: File) -> [String]{
        let syllableSets = allSyllableSets[file.chapter - 1][file.unit - 1]
        return syllableSets
    }
}
