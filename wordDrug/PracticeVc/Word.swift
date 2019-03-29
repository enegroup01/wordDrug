//
//  Word.swift
//  wordDrug
//
//  Created by Ethan on 2019/3/13.
//  Copyright © 2019年 playplay. All rights reserved.
//

import UIKit

class Word{
    
    var engWordElement: String!
    var engWord: String!
    var chiWord: String!
    var isSelected: Bool!
    var partOfSpeech: String!
    var syllable: String!
    var engSen: String!
    var chiSen: String!
    var isReviewWrong: Bool!
    var isReviewWrongLocked: Bool!
    
    
    init() {
        
    }
    
    init(engWordElement:String, engWord:String, chiWord:String, isSelected:Bool, partOfSpeech:String, syllable:String, engSen:String, chiSen:String, isReviewWrong:Bool, isReviewWrongLocked:Bool) {
        self.engWordElement = engWordElement
        self.engWord = engWord
        self.chiWord = chiWord
        self.isSelected = isSelected
        self.partOfSpeech = partOfSpeech
        self.syllable = syllable
        self.engSen = engSen
        self.chiSen = chiSen
        self.isReviewWrong = false
        self.isReviewWrongLocked = false
        
    }
  
    
}

