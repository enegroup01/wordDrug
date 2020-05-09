//
//  MissWord.swift
//  wordDrug
//
//  Created by Ethan on 2020/5/8.
//  Copyright © 2020 playplay. All rights reserved.
//

import Foundation

struct Word {
    
    var wordSyllables: String
    var chinese: String
    var partOfSpeech: String
    var englishSentence: String
    var chineseSentence: String
    var fullWord: String {
        return wordSyllables.replacingOccurrences(of: " ", with: "")
    }
        
    init(wordSyllables: String, chinese: String, partOfSpeech: String, englishSentence: String, chineseSentence: String ) {
        self.wordSyllables = wordSyllables
        self.chinese = chinese
        self.partOfSpeech = partOfSpeech
        self.englishSentence = englishSentence
        self.chineseSentence = chineseSentence
    }
    
}

class MissWord {
    
    func loadTextFile(fileName:String) -> [String] {
        var texts:[String]
        texts = loadText(fileName: fileName)
        return texts
    }
    
    private func loadText(fileName:String) -> [String] {
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
}
