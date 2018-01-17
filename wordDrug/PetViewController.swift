//
//  PetViewController.swift
//  wordDrug
//
//  Created by Ethan on 2017/11/27.
//  Copyright © 2017年 playplay. All rights reserved.
//

import UIKit

//各背包是否裝滿的全球變數
var normalElemsFull = Bool()
var metalElemsFull = Bool()
var woodElemsFull = Bool()
var waterElemsFull = Bool()
var fireElemsFull = Bool()
var earthElemsFull = Bool()
var combineElemsFull = Bool()
var rareElemsFull = Bool()

//var upgradeElems = [String]()
//所有的合併元素array
var upgradeElemsInfo = [String:String]()
//var petElems : NSMutableDictionary?

//這個要刪除
//var elemSaved : [Int]?

//元素紀錄
var exactElemSaved : [[Int:Int]]?

class PetViewController: UIViewController {
    //怪物資訊
    let monsters =
        [["monId":"1-1-1","monName":"","monHp":100,"monAtt":35,"monDef":10,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-1-2","monName":"","monHp":100,"monAtt":40,"monDef":10,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-1-3","monName":"","monHp":100,"monAtt":40,"monDef":10,"monMag":0,"monType":"water","monImg":"r1"],["monId":"1-1-4","monName":"","monHp":150,"monAtt":50,"monDef":15,"monMag":0,"monType":"fire","monImg":"r1"],["monId":"1-1-5","monName":"","monHp":150,"monAtt":50,"monDef":15,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-1-6","monName":"","monHp":150,"monAtt":50,"monDef":15,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-1-7","monName":"","monHp":200,"monAtt":60,"monDef":20,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-1-8","monName":"","monHp":200,"monAtt":60,"monDef":20,"monMag":0,"monType":"water","monImg":"r1"],["monId":"1-1-9","monName":"","monHp":200,"monAtt":60,"monDef":20,"monMag":0,"monType":"fire","monImg":"r1"],["monId":"1-1-10","monName":"球球","monHp":300,"monAtt":70,"monDef":30,"monMag":5,"monType":"metal","monImg":"1-1-10"],["monId":"1-2-1","monName":"","monHp":250,"monAtt":70,"monDef":25,"monMag":0,"monType":"water","monImg":"r1"],["monId":"1-2-2","monName":"","monHp":250,"monAtt":70,"monDef":25,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-2-3","monName":"","monHp":250,"monAtt":70,"monDef":25,"monMag":0,"monType":"fire","monImg":"r1"],["monId":"1-2-4","monName":"","monHp":300,"monAtt":80,"monDef":30,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-2-5","monName":"","monHp":300,"monAtt":80,"monDef":30,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-2-6","monName":"","monHp":300,"monAtt":80,"monDef":30,"monMag":0,"monType":"fire","monImg":"r1"],["monId":"1-2-7","monName":"","monHp":350,"monAtt":90,"monDef":35,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-2-8","monName":"","monHp":350,"monAtt":90,"monDef":35,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-2-9","monName":"","monHp":350,"monAtt":90,"monDef":35,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-2-10","monName":"螳螂拳","monHp":400,"monAtt":100,"monDef":45,"monMag":10,"monType":"water","monImg":"1-2-10"],["monId":"1-3-1","monName":"","monHp":350,"monAtt":100,"monDef":40,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-3-2","monName":"","monHp":350,"monAtt":100,"monDef":40,"monMag":0,"monType":"water","monImg":"r1"],["monId":"1-3-3","monName":"","monHp":350,"monAtt":100,"monDef":40,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-3-4","monName":"","monHp":400,"monAtt":110,"monDef":45,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-3-5","monName":"","monHp":400,"monAtt":110,"monDef":45,"monMag":0,"monType":"fire","monImg":"r1"],["monId":"1-3-6","monName":"","monHp":400,"monAtt":110,"monDef":45,"monMag":0,"monType":"water","monImg":"r1"],["monId":"1-3-7","monName":"","monHp":450,"monAtt":120,"monDef":50,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-3-8","monName":"","monHp":450,"monAtt":120,"monDef":50,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-3-9","monName":"","monHp":450,"monAtt":120,"monDef":50,"monMag":0,"monType":"fire","monImg":"r1"], ["monId":"1-3-10","monName":"蘑菇怪","monHp":500,"monAtt":130,"monDef":55,"monMag":15,"monType":"earth","monImg":"1-3-10"],["monId":"1-4-1","monName":"","monHp":450,"monAtt":130,"monDef":55,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-4-2","monName":"","monHp":450,"monAtt":130,"monDef":55,"monMag":0,"monType":"water","monImg":"r1"], ["monId":"1-4-3","monName":"","monHp":450,"monAtt":130,"monDef":55,"monMag":0,"monType":"wood","monImg":"r1"], ["monId":"1-4-4","monName":"","monHp":500,"monAtt":140,"monDef":60,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-4-5","monName":"","monHp":500,"monAtt":140,"monDef":60,"monMag":0,"monType":"fire","monImg":"r1"],["monId":"1-4-6","monName":"","monHp":500,"monAtt":140,"monDef":60,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-4-7","monName":"","monHp":550,"monAtt":150,"monDef":65,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-4-8","monName":"","monHp":550,"monAtt":150,"monDef":65,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-4-9","monName":"","monHp":550,"monAtt":150,"monDef":65,"monMag":0,"monType":"fire","monImg":"r1"], ["monId":"1-4-10","monName":"劇毒狼","monHp":600,"monAtt":160,"monDef":70,"monMag":20,"monType":"water","monImg":"1-4-10"],["monId":"1-5-1","monName":"","monHp":600,"monAtt":160,"monDef":70,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-5-2","monName":"","monHp":600,"monAtt":160,"monDef":70,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-5-3","monName":"","monHp":600,"monAtt":160,"monDef":70,"monMag":0,"monType":"fire","monImg":"r1"],["monId":"1-5-4","monName":"","monHp":650,"monAtt":170,"monDef":75,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-5-5","monName":"","monHp":650,"monAtt":170,"monDef":75,"monMag":0,"monType":"water","monImg":"r1"],["monId":"1-5-6","monName":"","monHp":650,"monAtt":170,"monDef":75,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-5-7","monName":"","monHp":700,"monAtt":180,"monDef":80,"monMag":0,"monType":"water","monImg":"r1"],["monId":"1-5-8","monName":"","monHp":700,"monAtt":180,"monDef":80,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-5-9","monName":"","monHp":700,"monAtt":180,"monDef":80,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-5-10","monName":"千年樹妖","monHp":750,"monAtt":190,"monDef":85,"monMag":25,"monType":"fire","monImg":"1-5-10"],["monId":"1-6-1","monName":"","monHp":750,"monAtt":190,"monDef":85,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-6-2","monName":"","monHp":750,"monAtt":190,"monDef":85,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-6-3","monName":"","monHp":750,"monAtt":190,"monDef":85,"monMag":0,"monType":"water","monImg":"r1"],["monId":"1-6-4","monName":"","monHp":800,"monAtt":200,"monDef":90,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-6-5","monName":"","monHp":800,"monAtt":200,"monDef":90,"monMag":0,"monType":"fire","monImg":"r1"],["monId":"1-6-6","monName":"","monHp":800,"monAtt":200,"monDef":90,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-6-7","monName":"","monHp":850,"monAtt":210,"monDef":95,"monMag":0,"monType":"water","monImg":"r1"],["monId":"1-6-8","monName":"","monHp":850,"monAtt":210,"monDef":95,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-6-9","monName":"","monHp":850,"monAtt":210,"monDef":95,"monMag":0,"monType":"fire","monImg":"r1"],["monId":"1-6-10","monName":"銀翼飛馬","monHp":900,"monAtt":220,"monDef":100,"monMag":30,"monType":"metal","monImg":"1-6-10"],["monId":"1-7-1","monName":"","monHp":900,"monAtt":220,"monDef":100,"monMag":0,"monType":"water","monImg":"r1"],["monId":"1-7-2","monName":"","monHp":900,"monAtt":220,"monDef":100,"monMag":0,"monType":"wood","monImg":"r1"], ["monId":"1-7-3","monName":"","monHp":900,"monAtt":220,"monDef":100,"monMag":0,"monType":"fire","monImg":"r1"],["monId":"1-7-4","monName":"","monHp":950,"monAtt":230,"monDef":105,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-7-5","monName":"","monHp":950,"monAtt":230,"monDef":105,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-7-6","monName":"","monHp":950,"monAtt":230,"monDef":105,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-7-7","monName":"","monHp":1000,"monAtt":240,"monDef":110,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-7-8","monName":"","monHp":1000,"monAtt":240,"monDef":110,"monMag":0,"monType":"water","monImg":"r1"],["monId":"1-7-9","monName":"","monHp":1000,"monAtt":240,"monDef":110,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-7-10","monName":"恐龍博士","monHp":1050,"monAtt":250,"monDef":115,"monMag":35,"monType":"fire","monImg":"1-7-10"],["monId":"1-8-1","monName":"","monHp":1050,"monAtt":250,"monDef":115,"monMag":0,"monType":"water","monImg":"r1"],["monId":"1-8-2","monName":"","monHp":1050,"monAtt":250,"monDef":115,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-8-3","monName":"","monHp":1050,"monAtt":250,"monDef":115,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-8-4","monName":"","monHp":1100,"monAtt":260,"monDef":120,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-8-5","monName":"","monHp":1100,"monAtt":260,"monDef":120,"monMag":0,"monType":"fire","monImg":"r1"],["monId":"1-8-6","monName":"","monHp":1100,"monAtt":260,"monDef":120,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-8-7","monName":"","monHp":1150,"monAtt":270,"monDef":125,"monMag":0,"monType":"fire","monImg":"r1"],["monId":"1-8-8","monName":"","monHp":1150,"monAtt":270,"monDef":125,"monMag":0,"monType":"water","monImg":"r1"],["monId":"1-8-9","monName":"","monHp":1150,"monAtt":270,"monDef":125,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-8-10","monName":"冰雪犀牛","monHp":1200,"monAtt":280,"monDef":130,"monMag":40,"monType":"earth","monImg":"1-8-10"],["monId":"1-9-1","monName":"","monHp":1200,"monAtt":280,"monDef":130,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-9-2","monName":"","monHp":1200,"monAtt":280,"monDef":130,"monMag":0,"monType":"water","monImg":"r1"],["monId":"1-9-3","monName":"","monHp":1200,"monAtt":280,"monDef":130,"monMag":0,"monType":"fire","monImg":"r1"],["monId":"1-9-4","monName":"","monHp":1250,"monAtt":290,"monDef":135,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-9-5","monName":"","monHp":1250,"monAtt":290,"monDef":135,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-9-6","monName":"","monHp":1250,"monAtt":290,"monDef":135,"monMag":0,"monType":"water","monImg":"r1"],["monId":"1-9-7","monName":"","monHp":1300,"monAtt":300,"monDef":140,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-9-8","monName":"","monHp":1300,"monAtt":300,"monDef":140,"monMag":0,"monType":"fire","monImg":"r1"],["monId":"1-9-9","monName":"","monHp":1300,"monAtt":300,"monDef":140,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-9-10","monName":"美洲豹","monHp":1350,"monAtt":310,"monDef":145,"monMag":45,"monType":"earth","monImg":"1-9-10"],["monId":"1-10-1","monName":"","monHp":1350,"monAtt":310,"monDef":145,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-10-2","monName":"","monHp":1350,"monAtt":310,"monDef":145,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-10-3","monName":"","monHp":1350,"monAtt":310,"monDef":145,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-10-4","monName":"","monHp":1400,"monAtt":320,"monDef":150,"monMag":0,"monType":"water","monImg":"r1"],["monId":"1-10-5","monName":"","monHp":1400,"monAtt":320,"monDef":150,"monMag":0,"monType":"fire","monImg":"r1"],["monId":"1-10-6","monName":"","monHp":1400,"monAtt":320,"monDef":150,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-10-7","monName":"","monHp":1450,"monAtt":330,"monDef":155,"monMag":0,"monType":"fire","monImg":"r1"],["monId":"1-10-8","monName":"","monHp":1450,"monAtt":330,"monDef":155,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-10-9","monName":"","monHp":1450,"monAtt":330,"monDef":155,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-10-10","monName":"梅杜莎","monHp":1500,"monAtt":340,"monDef":160,"monMag":50,"monType":"water","monImg":"1-10-10"],["monId":"1-11-1","monName":"","monHp":1500,"monAtt":340,"monDef":160,"monMag":0,"monType":"fire","monImg":"r1"],["monId":"1-11-2","monName":"","monHp":1500,"monAtt":340,"monDef":160,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-11-3","monName":"","monHp":1500,"monAtt":340,"monDef":160,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-11-4","monName":"","monHp":1550,"monAtt":350,"monDef":165,"monMag":0,"monType":"water","monImg":"r1"],["monId":"1-11-5","monName":"","monHp":1550,"monAtt":350,"monDef":165,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-11-6","monName":"","monHp":1550,"monAtt":350,"monDef":165,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-11-7","monName":"","monHp":1600,"monAtt":360,"monDef":170,"monMag":0,"monType":"water","monImg":"r1"],["monId":"1-11-8","monName":"","monHp":1600,"monAtt":360,"monDef":170,"monMag":0,"monType":"fire","monImg":"r1"],["monId":"1-11-9","monName":"","monHp":1600,"monAtt":360,"monDef":170,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-11-10","monName":"治癒菇神","monHp":1650,"monAtt":370,"monDef":175,"monMag":55,"monType":"wood","monImg":"1-11-10"],["monId":"1-12-1","monName":"","monHp":1650,"monAtt":370,"monDef":175,"monMag":0,"monType":"water","monImg":"r1"],["monId":"1-12-2","monName":"","monHp":1650,"monAtt":370,"monDef":175,"monMag":0,"monType":"fire","monImg":"r1"],["monId":"1-12-3","monName":"","monHp":1650,"monAtt":370,"monDef":175,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-12-4","monName":"","monHp":1700,"monAtt":380,"monDef":180,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-12-5","monName":"","monHp":1700,"monAtt":380,"monDef":180,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-12-6","monName":"","monHp":1700,"monAtt":380,"monDef":180,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-12-7","monName":"","monHp":1750,"monAtt":390,"monDef":185,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-12-8","monName":"","monHp":1750,"monAtt":390,"monDef":185,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-12-9","monName":"","monHp":1750,"monAtt":390,"monDef":185,"monMag":0,"monType":"water","monImg":"r1"],["monId":"1-12-10","monName":"眼鏡蛇王","monHp":1800,"monAtt":400,"monDef":190,"monMag":60,"monType":"fire","monImg":"1-12-10"],["monId":"1-13-1","monName":"","monHp":1800,"monAtt":400,"monDef":190,"monMag":0,"monType":"earth","monImg":"r1"], ["monId":"1-13-2","monName":"","monHp":1800,"monAtt":400,"monDef":190,"monMag":0,"monType":"metal","monImg":"r1"],
         ["monId":"1-13-3","monName":"","monHp":1800,"monAtt":400,"monDef":190,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-13-4","monName":"","monHp":1850,"monAtt":410,"monDef":195,"monMag":0,"monType":"water","monImg":"r1"],["monId":"1-13-5","monName":"","monHp":1850,"monAtt":410,"monDef":195,"monMag":0,"monType":"fire","monImg":"r1"], ["monId":"1-13-6","monName":"","monHp":1850,"monAtt":410,"monDef":195,"monMag":0,"monType":"metal","monImg":"r1"],["monId":"1-13-7","monName":"","monHp":1900,"monAtt":420,"monDef":200,"monMag":0,"monType":"wood","monImg":"r1"],["monId":"1-13-8","monName":"","monHp":1900,"monAtt":420,"monDef":200,"monMag":0,"monType":"fire","monImg":"r1"],["monId":"1-13-9","monName":"","monHp":1900,"monAtt":420,"monDef":200,"monMag":0,"monType":"earth","monImg":"r1"],["monId":"1-13-10","monName":"被感染的劇毒狼","monHp":1950,"monAtt":430,"monDef":205,"monMag":65,"monType":"water","monImg":"1-13-10"],
         ["monId":"1-14-1","monName":"","monHp":1950,"monAtt":430,"monDef":205,"monMag":0,"monType":"earth","monImg":"r1"],
         ["monId":"1-14-2","monName":"","monHp":1950,"monAtt":430,"monDef":205,"monMag":0,"monType":"fire","monImg":"r1"],
         ["monId":"1-14-3","monName":"","monHp":1950,"monAtt":430,"monDef":205,"monMag":0,"monType":"metal","monImg":"r1"],
         ["monId":"1-14-4","monName":"","monHp":2000,"monAtt":440,"monDef":210,"monMag":0,"monType":"water","monImg":"r1"],
         ["monId":"1-14-5","monName":"","monHp":2000,"monAtt":440,"monDef":210,"monMag":0,"monType":"wood","monImg":"r1"],
         ["monId":"1-14-6","monName":"","monHp":2000,"monAtt":440,"monDef":210,"monMag":0,"monType":"fire","monImg":"r1"],
         ["monId":"1-14-7","monName":"","monHp":2050,"monAtt":450,"monDef":215,"monMag":0,"monType":"metal","monImg":"r1"],
         ["monId":"1-14-8","monName":"","monHp":2050,"monAtt":450,"monDef":215,"monMag":0,"monType":"wood","monImg":"r1"],
         ["monId":"1-14-9","monName":"","monHp":2050,"monAtt":450,"monDef":215,"monMag":0,"monType":"water","monImg":"r1"],
         ["monId":"1-14-10","monName":"海賊之王","monHp":2100,"monAtt":460,"monDef":220,"monMag":70,"monType":"earth","monImg":"1-14-10"]]
    
    let monsterNames = [["可利鴨","可利鴨戰士","可利鴨指揮官","可利鴨招喚師","王者可利鴨"],["灰狼","灰狼戰士","灰狼指揮官","灰狼招喚師","王者灰狼"],["雕像","雕像戰士","雕像指揮官","雕像招喚師","王者雕像"],["水晶蠍","水晶蠍戰士","水晶蠍指揮官","水晶蠍招喚師","王者水晶蠍"],["龍獸","龍獸戰士","龍獸指揮官","龍獸招喚師","王者龍獸"],["巨熊","巨熊戰士"," 巨熊指揮官"," 巨熊招喚師","王者巨熊"],["暴雷龍","暴雷龍戰士","暴雷龍指揮官"," 暴雷龍招喚師","王者暴雷龍"],["石化獸","石化獸戰士"," 石化獸指揮官"," 石化獸招喚師","王者石化獸"],["靈馴鹿","靈馴鹿戰士"," 靈馴鹿指揮官"," 靈馴鹿招喚師","王者靈馴鹿"]]
    
    
    /*
     //測試用的元素符號
    let elements = [["name":"ab1","func":"def","value":"1"],
                    ["name":"ac1","func":"att","value":"100"],
                    ["name":"ad1","func":"att","value":"5000"],
                    ["name":"a_e1","func":"att","value":"10"],
                    ["name":"af1","func":"att","value":"10"],
                    ["name":"ai1","func":"att","value":"10"],
                    ["name":"al1","func":"att","value":"10"],
                    ["name":"am1","func":"att","value":"10"],
                    ["name":"an1","func":"att","value":"10"],
                    ["name":"any1","func":"att","value":"110"],
                    
                    ["name":"ap1","func":"att","value":"10"],
                    ["name":"ar1","func":"att","value":"100"],
                    ["name":"as1","func":"att","value":"110"],
                    ["name":"at1","func":"earth","value":"110"],
                    ["name":"au1","func":"upgrade","value":"1-2-10"],
                    ["name":"aw1","func":"upgrade","value":"1-2-10"],
                    ["name":"ay1","func":"upgrade","value":"1-2-10"],
                    ["name":"ba1","func":"upgrade","value":"1-2-10"],
                    ["name":"be1","func":"upgrade","value":"1-2-10"],
                    ["name":"bi1","func":"upgrade","value":"1-2-10"]]
    */
    
    //元素資料
    let elements = [["name":"ab1","func":"hp","value":"50"],
                    ["name":"ac1","func":"att","value":"20"],
                    ["name":"ad1","func":"def","value":"5"],
                    ["name":"a_e1","func":"upgrade","value":"1-1-10"],
                    ["name":"af1","func":"upgrade","value":"1-1-10"],
                    ["name":"ai1","func":"wood","value":"10"],
                    ["name":"al1","func":"earth","value":"10"],
                    ["name":"am1","func":"water","value":"10"],
                    ["name":"an1","func":"fire","value":"10"],
                    ["name":"any1","func":"upgrade","value":"1-1-10"],
                    
                    ["name":"ap1","func":"metal","value":"10"],
                    ["name":"ar1","func":"hp","value":"100"],
                    ["name":"as1","func":"att","value":"40"],
                    ["name":"at1","func":"upgrade","value":"1-2-10"],
                    ["name":"au1","func":"upgrade","value":"1-2-10"],
                    ["name":"aw1","func":"heal","value":"20"],
                    ["name":"ay1","func":"wood","value":"30"],
                    ["name":"ba1","func":"earth","value":"30"],
                    ["name":"be1","func":"water","value":"30"],
                    ["name":"bi1","func":"upgrade","value":"1-2-10"],
                    
                    ["name":"bit1","func":"fire","value":"30"],
                    ["name":"bl1","func":"metal","value":"30"],
                    ["name":"bo1","func":"hp","value":"150"],
                    ["name":"br1","func":"att","value":"60"],
                    ["name":"bu1","func":"def","value":"15"],
                    ["name":"by1","func":"hit","value":"2"],
                    ["name":"ce1","func":"upgrade","value":"1-3-10"],
                    ["name":"ch1","func":"upgrade","value":"1-3-10"],
                    ["name":"ci1","func":"wood","value":"50"],
                    ["name":"ble1","func":"upgrade","value":"1-3-10"],
                    
                    ["name":"ck1","func":"earth","value":"50"],
                    ["name":"cl1","func":"water","value":"50"],
                    ["name":"co1","func":"fire","value":"50"],
                    ["name":"com1","func":"upgrade","value":"1-4-10"],
                    ["name":"con1","func":"heal","value":"40"],
                    ["name":"cian1","func":"metal","value":"50"],
                    ["name":"cr1","func":"hp","value":"200"],
                    ["name":"ct1","func":"att","value":"80"],
                    ["name":"de1","func":"upgrade","value":"1-4-10"],
                    ["name":"di1","func":"upgrade","value":"1-4-10"],
                    
                    ["name":"do1","func":"def","value":"20"],
                    ["name":"dr1","func":"hit","value":"4"],
                    ["name":"dy1","func":"wood","value":"70"],
                    ["name":"dis1","func":"earth","value":"70"],
                    ["name":"ea1","func":"upgrade","value":"1-6-10"],
                    ["name":"ee1","func":"water","value":"70"],
                    ["name":"el1","func":"fire","value":"70"],
                    ["name":"em1","func":"metal","value":"70"],
                    ["name":"en1","func":"hp","value":"250"],
                    ["name":"er1","func":"hp,att","value":"350,140"],
                    
                    ["name":"et1","func":"upgrade","value":"1-11-10"],
                    ["name":"ew1","func":"def","value":"25"],
                    ["name":"ex1","func":"heal","value":"60"],
                    ["name":"ey1","func":"upgrade","value":"1-7-10"],
                    ["name":"fi1","func":"wood","value":"90"],
                    ["name":"fl1","func":"earth","value":"90"],
                    ["name":"fo1","func":"upgrade","value":"1-6-10"],
                    ["name":"fr1","func":"water","value":"90"],
                    ["name":"ft1","func":"fire","value":"90"],
                    ["name":"ful1","func":"upgrade","value":"1-6-10"],
                    
                    ["name":"ge1","func":"metal","value":"90"],
                    ["name":"gi1","func":"hp","value":"300"],
                    ["name":"gl1","func":"att","value":"120"],
                    ["name":"go1","func":"def","value":"30"],
                    ["name":"gr1","func":"upgrade","value":"1-7-10"],
                    ["name":"he1","func":"wood","value":"110"],
                    ["name":"hi1","func":"earth","value":"110"],
                    ["name":"id1","func":"water","value":"110"],
                    ["name":"ie1","func":"hit","value":"6"],
                    ["name":"igh1","func":"upgrade","value":"1-7-10"],
                    
                    ["name":"il1","func":"fire","value":"110"],
                    ["name":"im1","func":"metal","value":"110"],
                    ["name":"in1","func":"upgrade","value":"1-8-10"],
                    ["name":"ing1","func":"heal","value":"80"],
                    ["name":"ir1","func":"hp","value":"350"],
                    ["name":"is1","func":"att","value":"140"],
                    ["name":"ject1","func":"upgrade","value":"1-8-10"],
                    ["name":"kn1","func":"def","value":"35"],
                    ["name":"le1","func":"wood","value":"130"],
                    ["name":"li1","func":"upgrade","value":"1-8-10"],
                    
                    ["name":"ly1","func":"earth","value":"130"],
                    ["name":"mil1","func":"water","value":"130"],
                    ["name":"nd1","func":"fire","value":"130"],
                    ["name":"no1","func":"metal","value":"130"],
                    ["name":"nt1","func":"upgrade","value":"1-9-10"],
                    ["name":"oa1","func":"hit","value":"8"],
                    ["name":"ob1","func":"hp","value":"400"],
                    ["name":"o_e1","func":"upgrade","value":"1-9-10"],
                    ["name":"of1","func":"att","value":"160"],
                    ["name":"oi1","func":"upgrade","value":"1-9-10"],
                    
                    ["name":"old1","func":"def","value":"40"],
                    ["name":"on1","func":"wood","value":"150"],
                    ["name":"ong1","func":"earth","value":"150"],
                    ["name":"oo1","func":"heal","value":"100"],
                    ["name":"op1","func":"upgrade","value":"1-11-10"],
                    ["name":"or1","func":"water","value":"150"],
                    ["name":"ot1","func":"fire","value":"150"],
                    ["name":"ou1","func":"metal","value":"150"],
                    ["name":"ow1","func":"hp","value":"450"],
                    //["name":"oy1","func":"att,hit,upgrade","value":"210,9,1-12-10"],
        ["name":"oy1","func":"upgrade","value":"1-12-10"],
        

                    ["name":"ph1","func":"att","value":"180"],
                    ["name":"pi1","func":"def","value":"45"],
                    ["name":"pl1","func":"hit","value":"10"],
                    ["name":"pr1","func":"wood","value":"170"],
                    ["name":"cop1","func":"upgrade","value":"1-12-10"],
                    ["name":"re1","func":"earth","value":"170"],
                    ["name":"ro1","func":"water","value":"170"],
                    ["name":"ry1","func":"fire","value":"170"],
                    ["name":"sh1","func":"metal","value":"170"],
                    ["name":"si1","func":"upgrade","value":"1-12-10"],
                    
                    ["name":"sk1","func":"hp","value":"500"],
                    ["name":"so1","func":"att","value":"200"],
                    ["name":"sp1","func":"def","value":"50"],
                    ["name":"st1","func":"heal","value":"120"],
                    ["name":"sion1","func":"upgrade","value":"1-13-10"],
                    ["name":"th1","func":"wood","value":"190"],
                    ["name":"ti1","func":"earth","value":"190"],
                    ["name":"tion1","func":"upgrade","value":"2-1-10"],
                    ["name":"tive1","func":"water","value":"190"],
                    ["name":"tle1","func":"upgrade","value":"1-12-10"],
                    
                    ["name":"to1","func":"fire","value":"190"],
                    ["name":"tr1","func":"metal","value":"190"],
                    ["name":"ture1","func":"upgrade","value":"1-13-10"],
                    ["name":"ty1","func":"hit","value":"12"],
                    ["name":"ub1","func":"hp","value":"550"],
                    ["name":"u_e1","func":"att","value":"220"],
                    ["name":"ui1","func":"def","value":"55"],
                    ["name":"um1","func":"wood","value":"210"],
                    ["name":"un1","func":"earth","value":"210"],
                    ["name":"up1","func":"upgrade","value":"1-13-10"],
                    
                    ["name":"ur1","func":"water","value":"210"],
                    ["name":"ut1","func":"fire","value":"210"],
                    ["name":"war1","func":"heal","value":"140"],
                    ["name":"wh1","func":"metal;","value":"210"],
                    ["name":"ab2","func":"upgrade","value":"2-1-10"],
                    ["name":"ac2","func":"hp","value":"600"],
                    ["name":"ad2","func":"att","value":"230"],
                    ["name":"a_e2","func":"def","value":"60"],
                    ["name":"af2","func":"wood;","value":"230"],
                    //["name":"ai2","func":"def,heal,upgrade","value":"80,200,2-3-10"]]
    
    ["name":"ai2","func":"def,heal","value":"80,200"]]
    
    
    
    //大項分類
    @IBOutlet weak var typeSeg: UISegmentedControl!
    //調整分類的高度constraint
    @IBOutlet weak var elemTypeSegHeight: NSLayoutConstraint!
    
    let lightOrange = UIColor.init(red: 1, green: 169/255, blue: 77/255, alpha: 1)
    
    @IBOutlet weak var petAva: UIImageView!
    @IBOutlet weak var selElem1Img: UIImageView!
    @IBOutlet weak var selElem2Img: UIImageView!
    @IBOutlet weak var selElem3Img: UIImageView!
    @IBOutlet weak var petInfoBg: UIImageView!
    @IBOutlet weak var petTitle: UILabel!
    @IBOutlet weak var petLevelLabel: UILabel!
    @IBOutlet weak var petLifeLabel: UILabel!
    @IBOutlet weak var petAttackLabel: UILabel!
    @IBOutlet weak var petExtraAttackLabel: UILabel!
    @IBOutlet weak var petDoubleAttackLabel: UILabel!
    @IBOutlet weak var petDefenseLabel: UILabel!
    @IBOutlet weak var petCureLabel: UILabel!
    @IBOutlet weak var elementBg: UIImageView!
    @IBOutlet weak var elem1: UIImageView!
    @IBOutlet weak var elem2: UIImageView!
    @IBOutlet weak var elem3: UIImageView!
    @IBOutlet weak var elem4: UIImageView!
    @IBOutlet weak var elem5: UIImageView!
    @IBOutlet weak var elem6: UIImageView!
    @IBOutlet weak var elem7: UIImageView!
    @IBOutlet weak var elem8: UIImageView!
    @IBOutlet weak var elem9: UIImageView!
    @IBOutlet weak var elem10: UIImageView!
    @IBOutlet weak var elem11: UIImageView!
    @IBOutlet weak var elem12: UIImageView!
    
    @IBOutlet weak var backToMapBtn: UIButton!
    
    //上方的三個元素空格, 因為怕被覆蓋後來再加入
    var elem13 = UIImageView()
    var elem14 = UIImageView()
    var elem15 = UIImageView()
    
    //寵物的類型顯示圖片
    @IBOutlet weak var petTypeImg: UIImageView!
    
    //進入遊戲按鈕
    @IBOutlet weak var playNowBtn: UIButton!
    
    //提示按鈕
    @IBOutlet weak var hintBtn: UIButton!
    
    //滑鼠的位置
    var location = CGPoint()
    //畫面上所有元素
    var elems = [UIImageView]()
    //記憶所有元素的原始位置
    var elemCgPoints = [CGPoint]()
    //碰觸到的元素
    var touchedElem = UIImageView()
    
    //碰觸到的選項元素
    var selTouchedElem = UIImageView()
    
    //記憶碰觸到元素的原始位置
    var originalPosition = CGPoint()
    
    //記憶碰到元素的當下位置
    var currentPosition = CGPoint()
    
    //記憶selElem的原始位置
    var selOriginalPosition = CGPoint()
    
    //畫面上選項的元素
    var selElems = [UIImageView]()
    
    //選項的後面一層
    var selElemsBack = [UIImageView]()
    
    //暫時抓正確選項位置
    var selElemsCgs = [[35,258],[100.5,258],[164.5,258]]
    
    //目前選到的元素Index
    var currentElemIndex = -1
    var exactCurrentElemIndex = [-1:-1]
    
    //紀錄三個選項元素的數字
    //var selOccupiedByElemIndex = [-1,-1,-1]
    var exactSelOccupiedByElemIndex = [[-1:-1],[-1:-1],[-1:-1]]
    
    //元素註解
    let elemInfoBg = UIView()
    let elemInfoAva = UIImageView()
    let elemTitleLabel = UILabel()
    let elemInfoLabel = UILabel()
    let elemInfoPetAva = UIImageView()
    
    //有抓到的元素資訊儲存於此
    var allGetElements = [String]()    //純名字
    var allGetElemsInfo = [[String:String]()]    //內含數值
    
    //指定給所有的func使用的變數
    var infoToShow = [[String:String]()]
    
    //抓元素描述的變數
    var functionChinese = [String]()
    var titleChinese = [String]()
    var values = [String]()
    var elemNames = [String]()
    
    //selElem所有的描述
    var selFunctionChinese = [String]()
    var selTitleChinese = [String]()
    var selValues = [String]()
    var selElemNames = [String]()
    
    //接收spot&unitNumber來判斷怪的屬性
    var spotNumber = Int()
    var unitNumber = Int()
    
    //暫時使用的單字
    var wordSets = [String]()
    
    //用來判斷提示
    var monsterType = String()
    
    //提示怪物屬性畫面
    let hintView = UIView()
    let ghostButton = UIButton()
    
    //目前單字的順位
    var currentWordSequence = 0
    
    //是否要準備進入比賽
    var isReadyToEnterBattle = Bool()
    
    //是否可以按元素
    var isElementTouchable = Bool()
    
    //提示內容
    var hintText = String()
    
    //分類元素
    var normalElems = [[String:String]()]
    var metalElems = [[String:String]()]
    var woodElems = [[String:String]()]
    var waterElems = [[String:String]()]
    var fireElems = [[String:String]()]
    var earthElems = [[String:String]()]
    var combineElems = [[String:String]()]
    var rareElems = [[String:String]()]
    
    //用來顯示元素的資訊
    var elemImg = ""
    //分析元素名字及數字
    var elemName:[String]?
    var elemNum:String?
    
    //元素的頁數變數及所有頁數, 背包的分頁數
    var elemPage = 0   //預設為第0頁
    var elemPages = [0,1,2,3,4,5,6,7]
    
    //提供儲存的變數
    var selIndex = Int()
    var selPage = Int()
    var selElemValue = Int()
    var elemValue = Int()
    var elemIndex = Int()
    var elemInfoBackUp = String() //刪除元素的內容說明
    var elemNameToDelete = String()
    var elemIndexToDelete = Int()
    
    //避免被重置的變數, 因為touchesEnd會把elemValue重置, 這是用來刪除大eLem時為了避免影響到selElem使用
    var elemValueToKeep = Int()
    
    
    //通知刪除元素的時候接收到NC的變數
    var defaultPage:Int?
    var defaultSeg:Int?
    var defaultTypeSeg:Int?
    var isBackpackFull = false
    var isElemAttachable = true
    var defaultElemToGet:String?
    
    //提示刪除elem的圖案
    let arrow = UIImageView()
    let deleteHint = UILabel()
    let ghost = UIButton()
    
    //屬性元素的控制器
    @IBOutlet weak var elemTypeSeg: UISegmentedControl!
    
    //垃圾桶圖示
    @IBOutlet weak var trashCanImg: UIImageView!
    
    var canMoveElem = true
    
    //稀有的dictionary
    var rareElemDict = [[String:Int]]()
    var rareSelElemDict = [[String:Int]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        /*
        //測試畫面用, 測試刪除畫面
        //做一個檔selElem的ghost button
        let ghost = UIButton()
        ghost.frame = CGRect(x: 0, y: 55, width: self.view.frame.width, height: self.view.frame.height / 2.28)
        ghost.backgroundColor = .black
        ghost.alpha = 0.5
        self.view.addSubview(ghost)
        

        arrow.frame.size = CGSize(width: 116, height: 116)
        arrow.center = CGPoint(x: 95, y: 150)
 
        arrow.image = UIImage(named: "arrow.png")
        self.view.addSubview(arrow)
        
        deleteHint.frame = CGRect(x: 70, y: 200, width: 300, height: 100)
        deleteHint.textColor = .cyan
        deleteHint.font = UIFont(name: "Helvetica Bold", size: 20)
        deleteHint.text = "請拖曳欲刪除的元素至垃圾桶"
        self.view.addSubview(deleteHint)
        */
      
        
        
        //預設
        elemTypeSeg.selectedSegmentIndex = 0
        //設定高度
        elemTypeSegHeight.constant = 50
        
        //設定按鈕背景
        let segImg = UIImage(named: "elemTypeBtn.png")
        elemTypeSeg.setBackgroundImage(segImg, for: .normal, barMetrics: .default)
        
        
        //設定字的顏色
        elemTypeSeg.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.lightGray], for: .normal)
        elemTypeSeg.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : lightOrange], for: .selected)
        
        let typeSegImg = UIImage(named:"typeSegBg.png")
        typeSeg.setBackgroundImage(typeSegImg, for: .normal, barMetrics: .default)
        typeSeg.selectedSegmentIndex = 0
        
        typeSeg.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.darkGray], for: .normal)
        typeSeg.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.yellow], for: .selected )
        typeSeg.isHidden = true
        
        
        //設定Action
        elemTypeSeg.addTarget(self, action: #selector(PetViewController.typeSelected), for: .valueChanged)
        typeSeg.addTarget(self, action: #selector(PetViewController.attriTypeSelected), for: .valueChanged)
        
        //抓所有寵物資訊
        let petAvaImg = pet!["petImg"] as! String

        //寵物大頭照
        petAva.image = UIImage(named: petAvaImg)
        
        //使用的元素
        let selElemImage = UIImage(named: "selElem.png")
        selElem1Img.image = selElemImage
        selElem2Img.image = selElemImage
        selElem3Img.image = selElemImage
        
        //寵物資訊背景
        petInfoBg.image = UIImage(named: "petInfoBg.png")
        

        //元素列表背景
        elementBg.image = UIImage(named: "elemBg.png")
        
        //加入選項元素UIView為了讓selElem可以偵測
        
        let sel1 = UIImageView()
        let sel2 = UIImageView()
        let sel3 = UIImageView()
        
        sel1.frame.size = CGSize(width: 60, height: 60)
        sel1.center = CGPoint(x: 35, y: 258)
        self.view.addSubview(sel1)
        
        
        sel2.frame.size = CGSize(width: 60, height: 60)
        sel2.center = CGPoint(x: 100.5, y: 258)
        self.view.addSubview(sel2)
        
        
        sel3.frame.size = CGSize(width: 60, height: 60)
        sel3.center = CGPoint(x: 164.5, y: 258)
        self.view.addSubview(sel3)
        
        selElemsBack.append(sel1)
        selElemsBack.append(sel2)
        selElemsBack.append(sel3)
        
        
        //上方elem空間
        elem13.frame.size = CGSize(width: 60, height: 60)
        elem13.center = CGPoint(x: selElemsCgs[0][0], y: selElemsCgs[0][1])
        self.view.addSubview(elem13)
        
        elem14.frame.size = CGSize(width: 60, height: 60)
        elem14.center = CGPoint(x: selElemsCgs[1][0], y: selElemsCgs[1][1])
        self.view.addSubview(elem14)
        
        elem15.frame.size = CGSize(width: 60, height: 60)
        elem15.center = CGPoint(x: selElemsCgs[2][0], y: selElemsCgs[2][1])
        self.view.addSubview(elem15)
        
        //加到選項元素
        selElems.append(elem13)
        selElems.append(elem14)
        selElems.append(elem15)
        
        //加到下方物品元素
        elems.append(elem1)
        elems.append(elem2)
        elems.append(elem3)
        elems.append(elem4)
        elems.append(elem5)
        elems.append(elem6)
        elems.append(elem7)
        elems.append(elem8)
        elems.append(elem9)
        elems.append(elem10)
        elems.append(elem11)
        elems.append(elem12)
        

        //抓取所有使用者元素的func
        //upgradeElems = [String]()
        upgradeElemsInfo = [String:String]()
        
        //在此處抓取元素之前不用empty所有元素, viewDidLoad會載入
        getUserElementFunc()
        
        
        //加入元素位置, 固定原本位置使用
        elemCgPoints.append(elem1.center)
        elemCgPoints.append(elem2.center)
        elemCgPoints.append(elem3.center)
        elemCgPoints.append(elem4.center)
        elemCgPoints.append(elem5.center)
        elemCgPoints.append(elem6.center)
        elemCgPoints.append(elem7.center)
        elemCgPoints.append(elem8.center)
        elemCgPoints.append(elem9.center)
        elemCgPoints.append(elem10.center)
        elemCgPoints.append(elem11.center)
        elemCgPoints.append(elem12.center)
        
        //做註解View
        elemInfoBg.backgroundColor = .black
        elemInfoBg.alpha = 0
        elemInfoBg.frame = CGRect(x: 100, y: 90, width: 200, height: 100)
        elemInfoBg.layer.cornerRadius = elemInfoBg.frame.width / 50
        self.view.addSubview(elemInfoBg)
        
        //註解裡元素圖
        elemInfoAva.frame = CGRect(x: 10, y: 10, width: 80, height: 80)
        elemInfoBg.addSubview(elemInfoAva)
        
        //註解裡的
        elemInfoPetAva.frame = CGRect(x: 160, y: 60, width: 35, height: 35)
        elemInfoBg.addSubview(elemInfoPetAva)
        
        //註解title
        elemTitleLabel.textColor = .cyan
        elemTitleLabel.font = UIFont(name: "Helvetica Bold", size: 15)
        elemTitleLabel.text = ""
        elemTitleLabel.frame = CGRect(x: 90, y: 3, width: 100, height: 50)
        elemInfoBg.addSubview(elemTitleLabel)
        
        //註解Info
        elemInfoLabel.textColor = .white
        elemInfoLabel.font = UIFont(name: "Helvetica Bold", size: 15)
        elemInfoLabel.text = ""
        elemInfoLabel.frame = CGRect(x: 90, y: 25, width: 120, height: 50)
        elemInfoLabel.adjustsFontSizeToFitWidth = true
        elemInfoBg.addSubview(elemInfoLabel)
        
        //先抓這隻寵物原始的數值
        pet = petOriginal
        
        //抓取目前元素的資訊, 以infoToShow判別類別
        fetchElementInfo()
        
        //抓取本機儲存的已使用元素
        //elemSaved = UserDefaults.standard.object(forKey: "elemSaved") as? [Int]
        
        //用decode方式抓取本機儲存的使用元素
        let decodedObject = UserDefaults.standard.object(forKey: "exactElemSaved") as? NSData
        
        if let decoded = decodedObject {
            exactElemSaved = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [[Int : Int]]
        }
        
        
        //指定之前所存檔的使用元素
        /*
        if elemSaved == nil {
            
            elemSaved = selOccupiedByElemIndex
            
        } else {
            selOccupiedByElemIndex = elemSaved!
            
        }
 */
        //第一次登入為nil就給予空值
        if exactElemSaved == nil {
            exactElemSaved = exactSelOccupiedByElemIndex
            
        } else {
            //非空值就把儲存值給予
            exactSelOccupiedByElemIndex = exactElemSaved!
            
        }
        
        //沒有值的話, 就預設為第一頁
        if defaultPage == nil{
            defaultPage = 0
        }
        
        //顯示背包內容
        elemPage = defaultPage!
        showElems(segSelected:normalElems,img:"normalGem",delay:0.1)
  
        //先隱藏玩跟提示的按鈕
        playNowBtn.isHidden = true
        hintBtn.isHidden = true
        
        //如果要進入遊戲就顯示提示
        if isReadyToEnterBattle{
            showHint()
        }

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        //測試畫面用. 假如一開始就要動畫也建議在這裡
/*
        UIView.animate(withDuration: 0.8, delay: 0.5, options: [.repeat,.curveEaseOut], animations: {[weak self] in
            
            
            self!.arrow.isHidden = false
               self!.arrow.frame.origin.y = 60
            
            
        }) {[weak self] (finished:Bool) in
            
            
        self!.arrow.frame.origin.y = 150
            self!.arrow.isHidden = true
            
        }
        */
        
    }
    
    //快速抓圖片
    func makeImage(name:String) ->UIImage{
        let image = UIImage(named: name + ".png")
        return image!
    }
    

    //最主要處理必須刪掉元素才能得到新元素的畫面及function
    override func viewWillAppear(_ animated: Bool) {

        canMoveElem = true
        
        //如果背包滿的話
        if isBackpackFull{
            
          //重置selElemIndex
            saveElemIndex(index: 0, page: -1, elem: -1)
            saveElemIndex(index: 1, page: -1, elem: -1)
            saveElemIndex(index: 2, page: -1, elem: -1)
            
            //做一個檔selElem的ghost button
            ghost.frame = CGRect(x: 0, y: 55, width: self.view.frame.width, height: self.view.frame.height / 2.28)
            ghost.backgroundColor = .black
            ghost.alpha = 0.5
            self.view.addSubview(ghost)
            
            //做箭頭
            arrow.frame.size = CGSize(width: 116, height: 116)
            arrow.center = CGPoint(x: 95, y: 150)
            arrow.image = UIImage(named: "arrow.png")
            self.view.addSubview(arrow)
            
            //刪除提示文字
            deleteHint.frame = CGRect(x: 70, y: 200, width: 300, height: 100)
            deleteHint.textColor = .cyan
            deleteHint.font = UIFont(name: "Helvetica Bold", size: 20)
            deleteHint.text = "請拖曳欲刪除的元素至垃圾桶"
            self.view.addSubview(deleteHint)
            
            //箭頭動畫
            UIView.animate(withDuration: 0.8, delay: 0.5, options: [.repeat,.curveEaseOut], animations: {[weak self] in

                self!.arrow.isHidden = false
                self!.arrow.frame.origin.y = 60
                
                
            }) {[weak self] (finished:Bool) in

                self!.arrow.frame.origin.y = 150
                self!.arrow.isHidden = true
                
            }
            
            //暫時不能回地圖, 按鈕取消
            backToMapBtn.isUserInteractionEnabled = false
            
            //重新取得所有元素array才會更新
            emptyAllElemsInfo()
            getUserElementFunc()

            
            //準備showElem, 下方皆為showElem的功能
            elemPage = defaultPage!
            
            //判斷是哪一頁, 然後showElem
            if defaultTypeSeg == -1 {
                //大項目
                typeSeg.isHidden = true
                
                //抓大頁
                switch defaultSeg!{
                case 0:
                    showElems(segSelected: normalElems, img: "normalGem", delay: 0.01)
                    elemTypeSeg.selectedSegmentIndex = 0
                case 1:
                    showElems(segSelected: metalElems, img: "metalGem", delay: 0.01)
                    elemTypeSeg.selectedSegmentIndex = 1
                    typeSeg.isHidden = false
                case 2:
                    showElems(segSelected: combineElems, img: "combineGem", delay: 0.01)
                    elemTypeSeg.selectedSegmentIndex = 2
                case 3:
                    showElems(segSelected: rareElems, img: "rareGem", delay: 0.01)
                    elemTypeSeg.selectedSegmentIndex = 3
                    
                default:
                    break
                }
   
            } else {
                //小項目
                
                typeSeg.isHidden = false
                
                //抓屬性小項目
                switch defaultTypeSeg!{
                    
                case 0:
                    showElems(segSelected: metalElems, img: "metalGem", delay: 0.01)
                    typeSeg.selectedSegmentIndex = 0
 
                case 1:
                    showElems(segSelected: woodElems, img: "woodGem", delay: 0.01)
                    typeSeg.selectedSegmentIndex = 1
                case 2:
                    showElems(segSelected: waterElems, img: "waterGem", delay: 0.01)
                    typeSeg.selectedSegmentIndex = 2
                case 3:
                    showElems(segSelected: fireElems, img: "fireGem", delay: 0.01)
                    typeSeg.selectedSegmentIndex = 3
                case 4:
                    showElems(segSelected: earthElems, img: "earthGem", delay: 0.01)
                    typeSeg.selectedSegmentIndex = 4
 
                    
                default:
                    break
                }
                
                
            }
            
            
            
        } else {
            
            //一般進入
            
            print("normal entry")
            
            self.view.isUserInteractionEnabled = false
             //換寵物的話要及時更換頭像
            //抓所有寵物資訊
            let petAvaImg = pet!["petImg"] as! String
       
            //寵物大頭照
            petAva.image = UIImage(named: petAvaImg)
            print(exactSelOccupiedByElemIndex)
            //抓取所儲存的selElem, 因為如果已有選擇寵物就會更改成全部-1
            exactSelOccupiedByElemIndex = exactElemSaved!
            

            //用elemPage來抓seg及顯示圖, 因為如果已有選擇寵物就會更改到normal
            switch elemPage{
            case 0:
                showElems(segSelected: normalElems, img: "normalGem", delay: 0.01)
                elemTypeSeg.selectedSegmentIndex = 0
                typeSeg.isHidden = true
            case 1:
                showElems(segSelected: metalElems, img: "metalGem", delay: 0.01)
                elemTypeSeg.selectedSegmentIndex = 1
                typeSeg.isHidden = false

                
            case 2:
                showElems(segSelected: woodElems, img: "woodGem", delay: 0.01)
                typeSeg.selectedSegmentIndex = 1
                typeSeg.isHidden = false
                
            case 3:
                showElems(segSelected: waterElems, img: "waterGem", delay: 0.01)
                typeSeg.selectedSegmentIndex = 2
                typeSeg.isHidden = false
            case 4:
                showElems(segSelected: fireElems, img: "fireGem", delay: 0.01)
                typeSeg.selectedSegmentIndex = 3
                typeSeg.isHidden = false
            case 5:
                showElems(segSelected: earthElems, img: "earthGem", delay: 0.01)
                typeSeg.selectedSegmentIndex = 4
                typeSeg.isHidden = false

            case 6:
                showElems(segSelected: combineElems, img: "combineGem", delay: 0.01)
                elemTypeSeg.selectedSegmentIndex = 2
                  typeSeg.isHidden = true
            case 7:
                showElems(segSelected: rareElems, img: "rareGem", delay: 0.01)
                elemTypeSeg.selectedSegmentIndex = 3
                  typeSeg.isHidden = true
            default:
                break

            }

                        
            //必須重新計算, 因為寵物會改變
            calculatePetValue()
 
        }

    }
    
    //選擇seg
    @objc func typeSelected(sender:UISegmentedControl){
        
        //抓index
        let index = elemTypeSeg.selectedSegmentIndex
        
        switch index{
        case 0:
            
            elemPage = 0
            //隱藏元素屬性的seg
            typeSeg.isHidden = true
            //顯示normal的elem
            showElems(segSelected: normalElems,img:"normalGem",delay:0.01)
            //指定頁數
            
            
        case 1:
            //顯示元素選擇
            elemPage = 1
            typeSeg.isHidden = false
            //設定元素預設值為金, 以及顏色黃色
            typeSeg.selectedSegmentIndex = 0
            typeSeg.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.yellow], for: .selected )
            showElems(segSelected: metalElems,img:"metalGem",delay:0.01)
            
            
        case 2:
            
            elemPage = 6
            typeSeg.isHidden = true
            showElems(segSelected: combineElems, img:"combineGem",delay:0.01)
            
            
        case 3:
            elemPage = 7
            typeSeg.isHidden = true
            showElems(segSelected: rareElems, img:"rareGem",delay:0.01)
            
            
        default:
            break
        }
        
        
        
    }
    
    //屬性元素的Seg
    @objc func attriTypeSelected(sender:UISegmentedControl){
        
        let index = typeSeg.selectedSegmentIndex
        
        switch index{
        case 0:
            elemPage = 1
            typeSeg.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.yellow], for: .selected )
            showElems(segSelected: metalElems,img:"metalGem",delay:0.01)
            
            
        case 1:
            elemPage = 2
            typeSeg.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.brown], for: .selected )
            showElems(segSelected: woodElems,img:"woodGem",delay:0.01)
            
            
        case 2:
            elemPage = 3
            typeSeg.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.blue], for: .selected )
            showElems(segSelected: waterElems,img:"waterGem",delay:0.01)
            
            
        case 3:
            elemPage = 4
            typeSeg.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.red], for: .selected )
            showElems(segSelected: fireElems,img:"fireGem",delay:0.01)
            
            
        case 4:
            elemPage = 5
            typeSeg.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.orange], for: .selected )
            showElems(segSelected: earthElems,img:"earthGem",delay:0.01)
            
            
        default:
            break
        }
        

    }
    
    
    //顯示背包的function
    func showElems(segSelected:[[String:String]],img:String,delay:TimeInterval){
        
        //這個可以看出目前的選項裡有哪些elem
        print("exactElemSaved:\(String(describing: exactElemSaved))")

        //先重置資訊, 這種方式跟下方的方式應該是一樣的
        functionChinese.removeAll(keepingCapacity: false)
        titleChinese.removeAll(keepingCapacity: false)
        values.removeAll(keepingCapacity: false)
        elemNames.removeAll(keepingCapacity: false)
        
        //以目前狀態來說只會有三格
        selFunctionChinese = ["","",""]
        selTitleChinese = ["","",""]
        selValues = ["","",""]
        selElemNames = ["","",""]
        
        
        //重置選項elem圖及字
        for s in selElems{
            s.image = nil
            
            for i in s.subviews{
                
                //圖及字都移除
                if i.tag == 0 || i.tag == 1{
                    
                    i.removeFromSuperview()
                }
            }
            
        }
        
        //重置下方elem位置, 圖及字
        for i in  0 ..< elems.count{
            
            //必須回覆所有elem的位置
            elems[i].frame.size = CGSize(width: 80, height: 80)
            elems[i].center = elemCgPoints[i]
            
            //把圖片重置到nil, 避免空按
            elems[i].image = nil
            
            //移除name跟num的infoLabel
            for s in elems[i].subviews{
                
                if s.tag == 0 || s.tag == 1{
                    
                    s.removeFromSuperview()
                    
                }
                
            }
            
        }
        
        //抓該頁主元素圖片
        elemImg = img
        
        //確認此頁有元素
        if segSelected.count > 0 {
            
            //指定好所選擇的類別
            infoToShow = segSelected
            
            //抓資訊
            for i in 0 ..< segSelected.count{
                
                if let name = segSelected[i]["name"] as String?{
                    
                    elems[i].image = makeImage(name: elemImg)
                    
                    //抓字母 +  數字
                    elemName = name.components(separatedBy: .decimalDigits)
                    elemNum = name.replacingOccurrences(of: elemName![0], with: "")
                    
                    //做字母的label
                    
                    let elemNameLabel = UILabel()
                    
                    elemNameLabel.frame = CGRect(x: elems[i].frame.width / 5, y: elems[i].frame.height / 3, width: 45, height: 25)
                    elemNameLabel.textAlignment = .center
                    elemNameLabel.font = UIFont(name: "Helvetica Bold", size: 20)
                    elemNameLabel.text = elemName![0]
                    elemNameLabel.textColor = .black
                    elemNameLabel.tag = 0
                    elems[i].addSubview(elemNameLabel)
                    
                    //做數字的Label
                    
                    let elemNumLabel = UILabel()
                    elemNumLabel.frame = CGRect(x: elems[i].frame.width / 2, y: elems[i].frame.height / 1.7, width: 20, height: 20)
                    elemNumLabel.textAlignment = .center
                    elemNumLabel.font = UIFont(name: "Helvetica Bold", size: 12)
                    elemNumLabel.text = elemNum
                    elemNumLabel.textColor = .black
                    elemNumLabel.tag = 1
                    
                    elems[i].addSubview(elemNumLabel)
                    
                }
                
            }
            
        }
        
        //抓取資訊, append進去
        fetchElementInfo()
        
        //*** 處理selElems的部分 ***
        //做選項裡的圖, 包含該頁及非該頁
        //跑每一頁, 用意在於要確認每組第一個值為頁數, 然後抓取他們的value
        
        for i in 0 ..< exactSelOccupiedByElemIndex.count{
            
            for (page,elem) in exactSelOccupiedByElemIndex[i]{
                
                //如果不是該頁的或是不是沒選擇的就要做別頁的圖片來顯示元素
                var selElemPage = [[String:String]()]
                var selImageName = String()

                if page != -1{
                if page != elemPage{
                    
                    //找出正確的頁面以及元素圖片

                    switch page {
                        
                    case 0:
                        
                        selElemPage = normalElems
                        selImageName = "normalGem"
                        
                    case 1:
                        
                        selElemPage = metalElems
                        selImageName = "metalGem"
                    case 2:
                        
                        selElemPage = woodElems
                        selImageName = "woodGem"
                        
                    case 3:
                        
                        selElemPage = waterElems
                        selImageName = "waterGem"
                    case 4:
                        
                        selElemPage = fireElems
                        selImageName = "fireGem"
                    case 5:
                        
                        selElemPage = earthElems
                        selImageName = "earthGem"
                    case 6:
                        
                        selElemPage = combineElems
                        selImageName = "combineGem"
                    case 7:
                        
                        selElemPage = rareElems
                        selImageName = "rareGem"
                        
                    default:
                        break
                    }
                    
                    //做選項圖片名字的Label
                    
                    //做出該選項元素的圖片

                    selElems[i].image = makeImage(name: selImageName)
                    selElems[i].center = CGPoint(x: selElemsCgs[i][0], y:selElemsCgs[i][1])
                    //必須紀錄elemPage讓之後可以detect
                    
                    //在此append selElem的資訊
                    
                    if let function = selElemPage[elem]["func"] as String?{
                        
                        if !function.contains(","){
                            
                            switch function{
                                
                            case "hp":
                                selTitleChinese[i] = "魔法元素"
                                selFunctionChinese[i] = "血量"
                            case "att":
                                
                                selTitleChinese[i] = "魔法元素"
                                selFunctionChinese[i] = "攻擊力"
                                
                            case "def":
                                
                                selTitleChinese[i] = "魔法元素"
                                selFunctionChinese[i] = "防禦力"
                                
                            case "hit":
                                
                                selTitleChinese[i] = "魔法元素"
                                selFunctionChinese[i] = "爆擊率"
                                
                            case "heal":
                                
                                selTitleChinese[i] = "魔法元素"
                                selFunctionChinese[i] = "治癒"
                                
                            case "wood":
                                
                                selTitleChinese[i] = "屬性元素"
                                selFunctionChinese[i] = "木屬性魔攻"
                                
                            case "earth":
                                
                                selTitleChinese[i] = "屬性元素"
                                selFunctionChinese[i] = "土屬性魔攻"
                                
                            case "water":
                                
                                selTitleChinese[i] = "屬性元素"
                                selFunctionChinese[i] = "水屬性魔攻"
                                
                            case "fire":
                                
                                selTitleChinese[i] = "屬性元素"
                                selFunctionChinese[i] = "火屬性魔攻"
                                
                            case "metal":
                                
                                selTitleChinese[i] = "屬性元素"
                                selFunctionChinese[i] = "金屬性魔攻"
                                
                                
                            case "upgrade":
                                //需重寫升級方法
                                
                                selTitleChinese[i] = "寵物碎片"
                                selFunctionChinese[i] = "蒐集3片碎片合成寵物"
                                
                            default:
                                break
                                
                            }
                        }else {
                            
                            //還需要寫分析多元素的功能
                            
                            selTitleChinese[i] = "稀有元素"
                            //還需要寫分析多元素的功能
                            let functionArray = function.components(separatedBy: ",")
                            
                            //分別填入功能說明
                            for f in 0 ..< functionArray.count {
                                
                                switch functionArray[f]{
                                    
                                case "hp":
                                    if f != 0 {
                                        selFunctionChinese[i] = selFunctionChinese[i] + "血量+"}else {
                                        
                                        selFunctionChinese[i] = ("血量+")
                                    }
                                case "att":
                                    if f != 0 {
                                        selFunctionChinese[i] = selFunctionChinese[i] + "攻擊力+"}else {
                                        
                                        selFunctionChinese[i] = ("攻擊力+")
                                    }
                                    
                                case "def":
                                    if f != 0 {
                                        selFunctionChinese[i] = selFunctionChinese[i] + "防禦力+"}else {
                                        
                                        selFunctionChinese[i] = ("防禦力+")
                                    }
                                    
                                case "hit":
                                    if f != 0  {
                                        selFunctionChinese[i] = selFunctionChinese[i] + "爆擊率+"}else {
                                        
                                        selFunctionChinese[i] = ("爆擊率+")
                                    }
                                    
                                case "heal":
                                    if f != 0  {
                                        selFunctionChinese[i] = selFunctionChinese[i] + "治癒+"}else {
                                        
                                        selFunctionChinese[i] = ("治癒+")
                                    }
                                    
                                default:
                                    break
                                    
                                }
                                
                            }

                            
                        }
                        
                    }
                    
                    //抓數值
                    if let value = selElemPage[elem]["value"] as String?{
                        
                        selValues[i] = value
                        
                    }
                    
                    //抓名字
                    if let name = selElemPage[elem]["name"] as String?{
                        
                        //填入名字
                        selElemNames[i] = name
                        
                        
                        //抓字母 +  數字
                        elemName = name.components(separatedBy: .decimalDigits)
                        elemNum = name.replacingOccurrences(of: elemName![0], with: "")
                        
                        
                        //做字母的label
                        let elemNameLabel = UILabel()
                        
                        elemNameLabel.frame = CGRect(x: 5, y: 10, width: 40, height:40)
                        elemNameLabel.textAlignment = .center
                        elemNameLabel.font = UIFont(name: "Helvetica Bold", size: 20)
                        elemNameLabel.text = elemName![0]
                        elemNameLabel.textColor = .black
                        elemNameLabel.tag = 0
                        selElems[i].addSubview(elemNameLabel)
                        
                        //做數字的Label
                        let elemNumLabel = UILabel()
                        
                        elemNumLabel.frame = CGRect(x: 15, y: 15, width: 15, height: 15)
                        elemNumLabel.textAlignment = .center
                        elemNumLabel.font = UIFont(name: "Helvetica Bold", size: 12)
                        elemNumLabel.text = elemNum
                        elemNumLabel.textColor = .black
                        elemNumLabel.tag = 1
                        selElems[i].addSubview(elemNumLabel)
                        
                    }

                    
                    //假設是該頁的元素就要把elem放到正確位置
                } else if page == elemPage{
                    
                    //幫選項填入空值
                    selTitleChinese[i] = ""
                    selFunctionChinese[i] = ""
                    selValues[i] = ""
                    selElemNames[i] = ""
                    
                    //延遲delay秒後顯示
                    
                    let when = DispatchTime.now() + delay
                    
                    DispatchQueue.main.asyncAfter(deadline: when) {[weak self] in
                        
                        //固定元素在選項裡
                        self!.elems[elem].frame.size = CGSize(width: 60, height: 60)
                        self!.elems[elem].center = CGPoint(x: self!.selElemsCgs[i][0], y: self!.selElemsCgs[i][1])
                        
                        
                    }
                    
                }
                }
                
            }
            
        }
        
        //計算寵物數值
        calculatePetValue()

 
        
    
        /*
        for p in 0 ..< elemPages.count{
            
            //跑儲存的數字
            for s in 0 ..< exactSelOccupiedByElemIndex.count{
                
                
                //抓頁面元素
                if let elem = exactSelOccupiedByElemIndex[s][elemPages[p]]{
                    
                    //以下留著做參考
                    
                    
                    //如果不是該頁的或是不是沒選擇的就要做別頁的圖片來顯示元素
                    
                    var selElemPage = [[String:String]()]
                    var selImageName = String()
                    
                    
                    if p != elemPage{
                        
                        //找出正確的頁面以及元素圖片
                        
                        
                        switch p {
                            
                        case 0:
                            
                            selElemPage = normalElems
                            selImageName = "normalGem"
                            
                            
                        case 1:
                            
                            selElemPage = metalElems
                            selImageName = "metalGem"
                        case 2:
                            
                            selElemPage = woodElems
                            selImageName = "woodGem"
                            
                        case 3:
                            
                            selElemPage = waterElems
                            selImageName = "waterGem"
                        case 4:
                            
                            selElemPage = fireElems
                            selImageName = "fireGem"
                        case 5:
                            
                            selElemPage = earthElems
                            selImageName = "earthGem"
                        case 6:
                            
                            selElemPage = combineElems
                            selImageName = "combineGem"
                        case 7:
                            
                            selElemPage = rareElems
                            selImageName = "rareGem"
                            
                        default:
                            break
                        }
                        
                        //做選項圖片名字的Label
                        
                        //做出該選項元素的圖片
                        
                        
                        selElems[s].image = makeImage(name: selImageName)
                        selElems[s].center = CGPoint(x: selElemsCgs[s][0], y:selElemsCgs[s][1])
                        //必須紀錄elemPage讓之後可以detect
                        
                        //在此append selElem的資訊
                        
                        if let function = selElemPage[elem]["func"] as String?{
                            
                            if !function.contains(","){
                                
                                switch function{
                                    
                                case "hp":
                                    selTitleChinese[s] = "魔法元素"
                                    selFunctionChinese[s] = "血量"
                                case "att":
                                    
                                    selTitleChinese[s] = "魔法元素"
                                    selFunctionChinese[s] = "攻擊力"
                                    
                                case "def":
                                    
                                    selTitleChinese[s] = "魔法元素"
                                    selFunctionChinese[s] = "防禦力"
                                    
                                case "hit":
                                    
                                    selTitleChinese[s] = "魔法元素"
                                    selFunctionChinese[s] = "爆擊率"
                                    
                                case "heal":
                                    
                                    selTitleChinese[s] = "魔法元素"
                                    selFunctionChinese[s] = "治癒"
                                    
                                case "wood":
                                    
                                    selTitleChinese[s] = "屬性元素"
                                    selFunctionChinese[s] = "木屬性魔攻"
                                    
                                case "earth":
                                    
                                    selTitleChinese[s] = "屬性元素"
                                    selFunctionChinese[s] = "土屬性魔攻"
                                    
                                case "water":
                                    
                                    selTitleChinese[s] = "屬性元素"
                                    selFunctionChinese[s] = "水屬性魔攻"
                                    
                                case "fire":
                                    
                                    selTitleChinese[s] = "屬性元素"
                                    selFunctionChinese[s] = "火屬性魔攻"
                                    
                                case "metal":
                                    
                                    selTitleChinese[s] = "屬性元素"
                                    selFunctionChinese[s] = "金屬性魔攻"
                                    
                                    
                                case "upgrade":
                                    //需重寫升級方法
                                    
                                    selTitleChinese[s] = "寵物碎片"
                                    selFunctionChinese[s] = "蒐集3片碎片合成寵物"
                                    
                                    
                                default:
                                    break
                                    
                                }
                            }else {
                                
                                
                                //還需要寫分析多元素的功能
                                
                                selTitleChinese[s] = "稀有元素"
                                selFunctionChinese[s] = "稀有元素"
                                
                                
                            }
                            
                            
                        }
                        
                        
                        //抓數值
                        if let value = selElemPage[elem]["value"] as String?{
                            
                            selValues[s] = value
                            
                            
                        }
                        
                        //抓名字
                        if let name = selElemPage[elem]["name"] as String?{
                            
                            //填入名字
                            selElemNames[s] = name
        
                            
                            //抓字母 +  數字
                            elemName = name.components(separatedBy: .decimalDigits)
                            elemNum = name.replacingOccurrences(of: elemName![0], with: "")
                            
                            
                            //做字母的label
                            let elemNameLabel = UILabel()
                            
                            elemNameLabel.frame = CGRect(x: 5, y: 10, width: 40, height:40)
                            elemNameLabel.textAlignment = .center
                            elemNameLabel.font = UIFont(name: "Helvetica Bold", size: 20)
                            elemNameLabel.text = elemName![0]
                            elemNameLabel.textColor = .black
                            elemNameLabel.tag = 0
                            selElems[s].addSubview(elemNameLabel)
                            
                            //做數字的Label
                            let elemNumLabel = UILabel()
                            
                            elemNumLabel.frame = CGRect(x: 15, y: 15, width: 15, height: 15)
                            elemNumLabel.textAlignment = .center
                            elemNumLabel.font = UIFont(name: "Helvetica Bold", size: 12)
                            elemNumLabel.text = elemNum
                            elemNumLabel.textColor = .black
                            elemNumLabel.tag = 1
                            selElems[s].addSubview(elemNumLabel)
                            
                        }
                        
                        
                        
                        //假設是該頁的元素就要把elem放到正確位置
                    } else if p == elemPage{
                        
                        //幫選項填入空值
                        selTitleChinese[s] = ""
                        selFunctionChinese[s] = ""
                        selValues[s] = ""
                        selElemNames[s] = ""
                        
                        //延遲delay秒後顯示
                        
                        let when = DispatchTime.now() + delay
                        
                        DispatchQueue.main.asyncAfter(deadline: when) {[weak self] in
                            
                            //固定元素在選項裡
                            self!.elems[elem].frame.size = CGSize(width: 60, height: 60)
                            self!.elems[elem].center = CGPoint(x: self!.selElemsCgs[s][0], y: self!.selElemsCgs[s][1])
                       
                            
                        }
                        
                        
                    }
                    
                    
                }
                
     
            }
            
        }
         
         //計算寵物數值
         calculatePetValue()
        */
        
        
    }
    
    //關掉暗示鍵
    @objc func dismissHintButton(){
        
        for subview in hintView.subviews{
            
            subview.removeFromSuperview()
        }
        
        hintView.removeFromSuperview()
        ghostButton.removeFromSuperview()
        
        //開啟元素按鍵
        isElementTouchable = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playNowClicked(_ sender: Any) {
        
        //把play鍵隱藏起來為了跳回背包時不顯示
        playNowBtn.isHidden = true
        
        performSegue(withIdentifier: "toGame", sender: self)

        canMoveElem = false
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toGame" {
            
            let destinationVC = segue.destination as! GameViewController
            destinationVC.spotNumber = spotNumber
            destinationVC.unitNumber = unitNumber
        }
        
    }

    
    func showHint(){
        
        playNowBtn.isHidden = false
        hintBtn.isHidden = false
        
        //建立不可按鍵蓋背景
        
        ghostButton.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        ghostButton.backgroundColor = .black
        ghostButton.alpha = 0.5
        self.view.addSubview(ghostButton)
        
        //建立提示對話框
        hintView.frame = CGRect(x: 80, y: 300, width: 200, height: 130)
        hintView.backgroundColor = .black
        hintView.alpha = 1
        hintView.layer.zPosition = 6
        
        self.view.addSubview(hintView)
        
        //建立提示標題
        let hintTitle = UILabel()
        hintTitle.font = UIFont(name: "Helvetica Bold", size: 20)
        hintTitle.adjustsFontSizeToFitWidth = true
        hintTitle.text = "[ 提示 ]"
        hintTitle.textColor = .cyan
        hintTitle.frame = CGRect(x: 10, y: -20, width: 180, height: 80)
        hintTitle.textAlignment = .center
        hintView.addSubview(hintTitle)
        
        let coverPurple = UIColor.init(red: 98/255, green: 44/255, blue: 85/255, alpha: 1)
        
        //建立提示按鈕
        let hintButton = UIButton(type: .system)
        hintButton.frame = CGRect(x: 80, y: 90, width:40, height: 20)
        hintButton.backgroundColor = coverPurple
        hintButton.setTitle("OK", for: .normal)
        hintButton.addTarget(self, action: #selector(PetViewController.dismissHintButton), for: .touchUpInside)
        hintButton.tintColor = .white
        hintButton.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 14)
        hintView.addSubview(hintButton)
        
        //抓正確unit
        currentWordSequence = 3 * unitNumber
        
        //讀取Bundle裡的文字檔, 為了抓怪物的屬性
        var wordFile:String?
        
        let name = "1-" + String(spotNumber + 1)
        
        if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
            do {
                wordFile = try String(contentsOfFile: filepath)
                let words = wordFile?.components(separatedBy: "; ")
                
                //把字讀取到wordSets裡
                wordSets = words!
                //print(contents)
                
                //找目前sequence的英文+中文字
                let halfCount = wordSets.count / 2
                let monsterId = wordSets[halfCount + currentWordSequence]
                // let monsterIdInt = Int(monsterId)
                //var monsterName = String()
                
                
                //抓monster資訊
                for monster in monsters{
                    
                    if monsterId == monster["monId"] as! String{
                        //monsterName = monster["name"] as! String
                        monsterType = monster["monType"] as! String
                        //monsterHp = monster["hp"] as! Int
                        //monsterAtt = monster["att"] as! Int
                        //monsterMagic = monster["magic"] as! Int
                        
                        
                        var elementSuggest = String()
                        var fontColorSuggest = UIColor() //顏色有指定, 尚未使用
                        
                        //
                        switch monsterType{
                            
                        case "wood":
                            elementSuggest = "金"
                            fontColorSuggest = .yellow
                            
                        case "earth":
                            
                            elementSuggest = "木"
                            fontColorSuggest = .orange
                            
                        case "water":
                            
                            elementSuggest = "土"
                            fontColorSuggest = .brown
                            
                        case "fire":
                            elementSuggest = "水"
                            fontColorSuggest = .blue
                            
                            
                        case "metal":
                            
                            elementSuggest = "火"
                            fontColorSuggest = .red
                            
                        default:
                            
                            break
                            
                        }
                        
                        //建立提示文字
                        let hintText = UILabel()
                        hintText.font = UIFont(name: "Helvetica Bold", size: 14)
                        hintText.adjustsFontSizeToFitWidth = true
                        hintText.text = "此元素怪物為\(monsterType)屬性，建議裝備\(elementSuggest)元素"
                        hintText.textColor = .white
                        hintText.frame = CGRect(x: 10, y: 15, width: 180, height: 80)
                        hintText.textAlignment = .center
                        hintText.numberOfLines = 2
                        hintView.addSubview(hintText)
                        
                    }
                }
                
            } catch {
                // contents could not be loaded
            }
        } else {
            // example.txt not found!
        }
        
        
        
        
    }
    
    @IBAction func hintClicked(_ sender: Any) {
        
        showHint()
        //關閉元素按鍵
        isElementTouchable = false
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            location = touch.location(in: self.view)
            
            //都沒碰到元素的話就隱藏info
            elemInfoBg.alpha = 0
            
            //點擊到petAva連結到寵物
            if petAva.frame.contains(location){
                
                performSegue(withIdentifier: "petToAllPetsVc", sender: self)
                
            }
            
            //按到Elem時
            //跑所有Elem元素
            for i in 0 ..< elems.count{
                
                //指定所按到的下方或是上方的該頁元素
                if let elemTouch = elems[i] as UIImageView?{
                    
                    //該elem不是空的
                    if elemTouch.image != nil {
                        
                        //假如手指有碰到該元素
                        if elemTouch.frame.contains(location){
                            
                            //抓title
                            let title = titleChinese[i]
                            elemTitleLabel.text = "Lv1 " + title
                            
                            //寵物圖片
                            
                            //先重置
                            elemInfoPetAva.image = UIImage()
                            
                            if title == "寵物碎片"{
                                //顯示寵物圖片
                                let imgName = infoToShow[i]["value"] as String?
                                elemInfoPetAva.image = makeImage(name: imgName!)
                            }
                            
                            //抓能力值
                            let function = functionChinese[i]
                            
                            //讓爆擊率＋%
                            if function == "爆擊率" {
                                elemInfoLabel.text = function + " +\(values[i])%"
                            } else if title == "寵物碎片"{
                                elemInfoLabel.text = function
                                
                            } else if function.contains("+"){
                                //稀有元素顯示
                                //let rareValueArray = values[i].components.(separatedBy: ",")
                                let rareValue = values[i]
                                let rareValueArray = rareValue.components(separatedBy: ",")
                                var functionArray = function.components(separatedBy: "+")
                                functionArray.removeLast()

                                elemInfoLabel.numberOfLines = 2
                                /*
                                elemInfoLabel.text = functionArray[0] + " +" + rareValueArray[0] + "\n" + functionArray[1] + " +" + rareValueArray[1]
                                  */
                                elemInfoLabel.text = ""
                                for i in 0 ..< rareValueArray.count{
                                    elemInfoLabel.text = elemInfoLabel.text! + functionArray[i] + " +" + rareValueArray[i]
                                }
                                
                                
                            } else {
                                
                                elemInfoLabel.text = function + " +\(values[i])"
                                
                            }
                            
                            //刪除使用
                            elemInfoBackUp = elemInfoLabel.text!
                            elemNameToDelete = elemNames[i]
                  
                            //顯示元素照片, 還沒有寫顯示元素資訊在圖片上
                            let elemAva = elems[i].image
                            elemInfoAva.image = elemAva
                            elemInfoBg.alpha = 0.8
                            
                            touchedElem = elemTouch
                            
                            //儲存原始位置, 回復使用
                            originalPosition = elemCgPoints[i]
                            
                            //儲存目前碰到的touchedElem的位置, 可以在交換位置時使用
                            currentPosition = touchedElem.center
                            
                            elemValue = i
                            
                            //刪除大elem時用來比較的變數
                            elemValueToKeep = i
                            
                            
                            //利用selElemsBack不改變位置的特性決定選elemIndex處於occupied的哪個位置儲存給後面使用
                            if selElemsBack[0].frame.contains(location){
                                elemIndex = 0
                                
                            } else if selElemsBack[1].frame.contains(location){
                                elemIndex = 1
                                
                            } else if selElemsBack[2].frame.contains(location){
                                
                                elemIndex = 2
                            }
                            
                            
                        }
                        
                    }
                    
                }
                
            }
            
            //按到selElem時
            //跑有可能存在的selElem元素
            
            for i in 0 ..< selElems.count{
                
                if let selElemTouch = selElems[i] as UIImageView?{
                    
                    if selElemTouch.image != nil {
                        
                        if selElemTouch.frame.contains(location){
                            
                            
                            //抓title
                            let title = selTitleChinese[i]
                            elemTitleLabel.text = "Lv1 " + title
                            
                            //寵物圖片
                            
                            //先重置
                            elemInfoPetAva.image = UIImage()
                            
                            if title == "寵物碎片"{
                                //顯示寵物圖片
                                //let imgName = selValues[i] as String?
                                //elemInfoPetAva.image = makeImage(name: imgName!)
                            }
                            
                            //抓能力值
                            let function = selFunctionChinese[i]
                            
                            //讓爆擊率＋%
                            if function == "爆擊率" {
                                elemInfoLabel.text = function + " +\(selValues[i])%"
                            } else if title == "寵物碎片"{
                                elemInfoLabel.text = function
                                
                            } else if function.contains("+"){
                                
                                //稀有元素顯示
                                //let rareValueArray = values[i].components.(separatedBy: ",")
                                let rareValue = selValues[i]
                                let rareValueArray = rareValue.components(separatedBy: ",")
                                var functionArray = function.components(separatedBy: "+")
                                functionArray.removeLast()
                                
                                elemInfoLabel.numberOfLines = 2
                                /*
                                 elemInfoLabel.text = functionArray[0] + " +" + rareValueArray[0] + "\n" + functionArray[1] + " +" + rareValueArray[1]
                                 */
                                elemInfoLabel.text = ""
                                for i in 0 ..< rareValueArray.count{
                                    elemInfoLabel.text = elemInfoLabel.text! + functionArray[i] + " +" + rareValueArray[i]
                                }
                                
                                
                            } else {
                                
                                elemInfoLabel.text = function + " +\(selValues[i])"
                                
                            }
                            
                            //刪除使用
                            elemInfoBackUp = elemInfoLabel.text!
                            elemNameToDelete = selElemNames[i]

                            
                            //顯示元素照片, 還沒有寫顯示元素資訊在圖片上
                            let elemAva = selElemTouch.image
                            elemInfoAva.image = elemAva
                            elemInfoBg.alpha = 0.8
                            
                            
                            selTouchedElem = selElemTouch
                            selOriginalPosition = selTouchedElem.center
                            
                            //提供給後面儲存用
                            
                            //利用selElemsBack不改變位置的特性決定選selElem處於occupied的哪個位置儲存給後面使用
                            if selElemsBack[0].frame.contains(location){
                                selIndex = 0
                                
                            } else if selElemsBack[1].frame.contains(location){
                                selIndex = 1
                                
                            } else if selElemsBack[2].frame.contains(location){
                                
                                selIndex = 2
                            }
                            
                            
                            for p in 0 ..< elemPages.count{
                                
                                //抓頁面元素
                                if let elem = exactSelOccupiedByElemIndex[selIndex][elemPages[p]]{
                                    
                                    //提供給後面儲存用
                                    selPage = p
                                    selElemValue = elem
                                    
                                }
                                
                            }
                            
                        }
                        
                        
                    }
                    
                    
                }
                
                
            }
            
            
        }
        
     
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            location = touch.location(in: self.view)
            //移動元素
            touchedElem.center = location
            
            //移動選項元素
            selTouchedElem.center = location
            
        }
        
    }
    
    //儲存選項的func
    func saveElemIndex(index:Int, page:Int, elem:Int){
        
        exactSelOccupiedByElemIndex[index] = [page:elem]
        exactElemSaved![index] = [page:elem]
        
        
        let userDefaults = UserDefaults.standard
        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: exactElemSaved!)
        userDefaults.set(encodedObject, forKey: "exactElemSaved")
        //userDefaults.synchronize()
        
        //計算寵物數值
        calculatePetValue()
    }
    
    
    //只儲存exactElemSaved的func, 也不跑calculate, 這裡是為了讓selElem可以多次下降數值, 所以先不存exactSelOccupiedByElemIndex, 數字改變過後在來改變
    func onlyExactElemSavedNoCalculate(index:Int, page:Int, elem:Int){
        
        //exactSelOccupiedByElemIndex[index] = [page:elem]
        exactElemSaved![index] = [page:elem]
        
        
        let userDefaults = UserDefaults.standard
        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: exactElemSaved!)
        userDefaults.set(encodedObject, forKey: "exactElemSaved")
        //userDefaults.synchronize()
        
        
    }
    
    
    //準備刪除元素
    func deleteElem(elem:UIImageView){

        //取消移動任何元素
        isElementTouchable = false
        
        //建立不可按鍵蓋背景
        
        ghostButton.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        ghostButton.backgroundColor = .black
        ghostButton.alpha = 0.5
        self.view.addSubview(ghostButton)
        
        //建立提示對話框
        hintView.frame = CGRect(x: 80, y: 300, width: 240, height: 180)
        hintView.backgroundColor = .black
        hintView.alpha = 1
        hintView.layer.zPosition = 6
        
        self.view.addSubview(hintView)
        
        //建立提示標題
        let hintTitle = UILabel()
        hintTitle.font = UIFont(name: "Helvetica Bold", size: 20)
        hintTitle.adjustsFontSizeToFitWidth = true
        hintTitle.text = "[ 刪除元素 ]"
        hintTitle.textColor = .cyan
        hintTitle.frame = CGRect(x: 30, y: -20, width: 180, height: 80)
        hintTitle.textAlignment = .center
        hintView.addSubview(hintTitle)
        
        let coverPurple = UIColor.init(red: 98/255, green: 44/255, blue: 85/255, alpha: 1)
        
        //建立提示按鈕
        let okButton = UIButton(type: .system)
        okButton.frame = CGRect(x: 130, y: 140, width:40, height: 20)
        okButton.backgroundColor = coverPurple
        okButton.setTitle("刪除", for: .normal)
        okButton.addTarget(self, action: #selector(PetViewController.performDelete), for: .touchUpInside)
        okButton.tintColor = .red
        okButton.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 14)
        hintView.addSubview(okButton)
        
        let cancelButton = UIButton(type: .system)
        cancelButton.frame = CGRect(x: 70, y: 140, width:40, height: 20)
        cancelButton.backgroundColor = coverPurple
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.addTarget(self, action: #selector(PetViewController.cancelDelete), for: .touchUpInside)
        cancelButton.tintColor = .white
        cancelButton.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 14)
        hintView.addSubview(cancelButton)
        
        
        //建立提示文字
        let hintText = UILabel()
        hintText.font = UIFont(name: "Helvetica Bold", size: 14)
        hintText.adjustsFontSizeToFitWidth = true
        hintText.text = "確定永久刪除此元素?"
        hintText.textColor = .white
        hintText.frame = CGRect(x: 30, y: 85, width: 180, height: 80)
        hintText.textAlignment = .center
        hintText.numberOfLines = 2
        hintView.addSubview(hintText)

        let elemImage = UIImageView()
        elemImage.frame.size = CGSize(width: 60, height: 60)
        elemImage.center = CGPoint(x: 50, y: 80)
        elemImage.image = elem.image
        hintView.addSubview(elemImage)
        

        let elemInfo = UILabel()
        elemInfo.font = UIFont(name: "Helvetica Bold", size: 14)
        elemInfo.adjustsFontSizeToFitWidth = true
        elemInfo.text = elemInfoBackUp
        elemInfo.textColor = UIColor.magenta
        elemInfo.frame = CGRect(x: 50, y: 50, width: 180, height: 80)
        elemInfo.textAlignment = .center
        elemInfo.numberOfLines = 2
        hintView.addSubview(elemInfo)

    }
    
    //取消刪除
    @objc func cancelDelete(elem:UIImageView){

        for subview in hintView.subviews{
            subview.removeFromSuperview()
            
        }
 
        hintView.removeFromSuperview()
        ghostButton.removeFromSuperview()
        
        isElementTouchable = true
    }
    
    
    func emptyAllElemsInfo(){
        //重置所有元素資訊
        normalElems = [[String:String]()]
        metalElems = [[String:String]()]
        woodElems = [[String:String]()]
        waterElems = [[String:String]()]
        fireElems = [[String:String]()]
        earthElems = [[String:String]()]
        combineElems = [[String:String]()]
        rareElems = [[String:String]()]
        //allGetElemsInfo = [[String:String]()]
        allGetElements = [String]()
        //upgradeElems = [String]()
        upgradeElemsInfo = [String:String]()
    }
    
    
    //執行刪除元素的主功能
   @objc func performDelete(){
    
    //part 1. 後端刪掉元素
    //part 2. 更新前端user資訊
    //part 3. 重置所有元素array
    //part 4. dismiss刪除畫面
    //***假如背包滿了, 刪除完後另外處理

    
    //假如是選項中的elem要刪除的話
    if elemIndexToDelete != -1{
        
        //比較整個selOccupiedElemIndex裡, 假如有同類型的, 又假如要刪除的數字較小, 所有較大的數字都必須 -1
        var key = [Int]()
        var keys = [[Int]]()
        
        for i in 0 ..< exactSelOccupiedByElemIndex.count{
            
            key = Array(exactSelOccupiedByElemIndex[i].keys)
            keys.append(key)
            
        }
        

        //設定按到要刪除的是哪個index
        let indexToDelete = elemIndexToDelete
        
        var indexToCompare = [Int]()
        
        //跑所有的key
        for i in 0 ..< keys.count{
            
            //避免比較到自己
            if i != indexToDelete {
                
                if keys[i][0] == keys[indexToDelete][0]{

                    //append需要比較的位置
                    indexToCompare.append(i)
                }
            }
        }
        
    
        //再比大小
        //先確認有需要比較的位置, 有了再比較
        if indexToCompare.count > 0 {
            
        for p in elemPages{
            
            for i in 0 ..< indexToCompare.count{
            
            if let value = exactSelOccupiedByElemIndex[indexToDelete][p] as Int?{
                if let value2 = exactSelOccupiedByElemIndex[indexToCompare[i]][p] as Int?{
                    
                    if value < value2{
                        
                        //要做這件事情
                        onlyExactElemSavedNoCalculate(index: indexToCompare[i], page: p, elem: value2 - 1)
                        onlyExactElemSavedNoCalculate(index: elemIndexToDelete, page: -1, elem: -1)
                    
                    } else {

                        onlyExactElemSavedNoCalculate(index: elemIndexToDelete, page: -1, elem: -1)

                    }
                    
                }
                
            }
            }

        }
        
            
            //如果沒有數字需要比較
          } else {
            
             onlyExactElemSavedNoCalculate(index: elemIndexToDelete, page: -1, elem: -1)
            
        }
 
        //****變化完再來儲存, 因為前方只儲存了exactElemSaved***
        exactSelOccupiedByElemIndex = exactElemSaved!

        
    //假如要刪除的是下方的elem
        
    } else {
        
        //用elemPage來跑全部的Key, 如果有遇到一樣的key就要比較數值的大小, 如果數字比較小的話, 就要修改selElemIndex的數值 - 1
        
        var key = [Int]()
        var keys = [[Int]]()
        
        //以下為所有的key
        for i in 0 ..< exactSelOccupiedByElemIndex.count{
            
            key = Array(exactSelOccupiedByElemIndex[i].keys)
            
            keys.append(key)
            
        }
        
        //抓需要compare的key
        let pageToCheck = elemPage
        var indexToCompare = [Int]()
        
        for i in 0 ..< keys.count{
       
                if keys[i][0] == pageToCheck{
                    
                    indexToCompare.append(i)
                    
                }

        }

        //接著來比較大小
        
        //假如有要比較的話
        if indexToCompare.count > 0{
        
            for i in 0 ..< indexToCompare.count{
                
                    if let value2 = exactSelOccupiedByElemIndex[indexToCompare[i]][pageToCheck] as Int?{
                        
                        //不會被重置的大elem數值
                        if elemValueToKeep < value2{
                            
                            //要做這件事情, 只儲存exactElemSaved, 為了避免有兩個以上需要改變數值
                            onlyExactElemSavedNoCalculate(index: indexToCompare[i], page: pageToCheck, elem: value2 - 1)
                            
                        } else {
                            
                            //在此不需要做任何事, 因為沒有任何selElem的數值需要改變
                            
                        }
                        
                    }

            }
        
        //****變化完再來儲存, 因為前方只儲存了exactElemSaved
        exactSelOccupiedByElemIndex = exactElemSaved!

    }

    }
    
    
    //****上方前方動作做完後, 接著連接後端修改
    
    //指定得到元素及使用者id
    let element = elemNameToDelete
    let id = user?["id"] as! String
    
    
    // url to access our php file
    let url = URL(string: "http://ec2-52-199-122-149.ap-northeast-1.compute.amazonaws.com/wordDrug/deleteElement.php")!
    
    // request url
    var request = URLRequest(url: url)
    
    // method to pass data POST - cause it is secured
    request.httpMethod = "POST"
    
    // body gonna be appended to url
    let body = "userID=\(id)&element=\(element)"
    
    // append body to our request that gonna be sent
    request.httpBody = body.data(using: .utf8)
    
    URLSession.shared.dataTask(with: request, completionHandler: {[weak self] data, response, error in
        // no error
        if error == nil {
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                guard let parseJSON = json else {
                    print("Error while parsing")
                    //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                    return
                }
                
                //再次儲存使用者資訊
                UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                print(user!)
       
                //前端畫面作業
                DispatchQueue.main.async(execute: {

                    //再次取得目前的元素, 並且分類好
                    self!.emptyAllElemsInfo()
                    self!.getUserElementFunc()

                    
                    //用seg來判斷目前頁面然後showElem
                    var page = Int()
                    var selElemPage = [[String : String]]()
                    var selImageName = String()
                    
                    if self!.typeSeg.isHidden{
                        //大項目

                        page = self!.elemTypeSeg.selectedSegmentIndex
                        
                        switch page{
                        case 0:
                            
                            selElemPage = self!.normalElems
                            selImageName = "normalGem"
                            
                        case 2:
                            selElemPage = self!.combineElems
                            selImageName = "combineGem"
                            
                        case 3:
                            selElemPage = self!.rareElems
                            selImageName = "rareGem"
                            
                            
                        default:
                            break
                            
                        }
                        
  
                    } else {
                        //屬性元素小項目
                        
                        page = self!.typeSeg.selectedSegmentIndex
                        
                        switch page{
                        case 0:
                            
                            selElemPage = self!.metalElems
                            selImageName = "metalGem"
                        case 1:
                            
                            selElemPage = self!.woodElems
                            selImageName = "woodGem"
                            
                        case 2:
                            selElemPage = self!.waterElems
                            selImageName = "waterGem"
                            
                        case 3:
                            selElemPage = self!.fireElems
                            selImageName = "fireGem"
                            
                        case 4:
                            selElemPage = self!.earthElems
                            selImageName = "earthGem"
                            
                            
                        default:
                            break
                            
                        }
                        
                    }

                    self!.showElems(segSelected: selElemPage, img: selImageName, delay: 0.01)
 
                    //最後在來計算數值
                    self!.calculatePetValue()
                    
                    //移除畫面
                    for subview in self!.hintView.subviews{
                        subview.removeFromSuperview()
                    }
                    self!.hintView.removeFromSuperview()
                    self!.ghostButton.removeFromSuperview()
                    
                    //回到畫面後可繼續移動元素
                    self!.isElementTouchable = true
                    
                   
                    //可按回地圖按鈕
                    self!.backToMapBtn.isUserInteractionEnabled = true

                    // *** 因為背包滿刪除元素後該做的事情 ***
                    if self!.isBackpackFull{
                        
                        //要移除刪除提示
                        self!.arrow.removeFromSuperview()
                        self!.deleteHint.removeFromSuperview()
                        self!.ghost.removeFromSuperview()
                        
                        //後端getElement,
                        let element = self!.defaultElemToGet!
                        let id = user?["id"] as! String

                        
                        // url to access our php file
                        let url = URL(string: "http://ec2-52-199-122-149.ap-northeast-1.compute.amazonaws.com/wordDrug/getElement.php")!
                        
                        // request url
                        var request = URLRequest(url: url)
                        
                        // method to pass data POST - cause it is secured
                        request.httpMethod = "POST"
                        
                        // body gonna be appended to url
                        let body = "userID=\(id)&element=\(element)"
                        
                        // append body to our request that gonna be sent
                        request.httpBody = body.data(using: .utf8)
                        
                        URLSession.shared.dataTask(with: request, completionHandler: {[weak self] data, response, error in
                            // no error
                            if error == nil {
                                
                                do {
                                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                                    
                                    guard let parseJSON = json else {
                                        print("Error while parsing")
                                        //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                                        return
                                    }
                                    
                                    //再次儲存使用者資訊
                                    UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                                    user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                                    print(user!)
                                    
                                    
                                    //抓出那個最後加入的elem然後做動畫
                                    DispatchQueue.main.async(execute: {
                                      
                                        
                                        //再次取得目前的元素, 並且分類好
                                        //重新取得所有更新的元素
                                        self!.emptyAllElemsInfo()
                                        self!.getUserElementFunc()
                                        
                                        
                                       //準備showElem
                                        self!.elemPage = self!.defaultPage!
                                        
                                        if self!.defaultTypeSeg == -1 {
                                            //大項目
                                            self!.typeSeg.isHidden = true
                                            
                                            switch self!.defaultSeg!{
                                            case 0:
                                                self!.showElems(segSelected: self!.normalElems, img: "normalGem", delay: 0.01)
                                                self!.elemTypeSeg.selectedSegmentIndex = 0
                                            case 1:
                                                self!.showElems(segSelected: self!.metalElems, img: "metalGem", delay: 0.01)
                                                self!.elemTypeSeg.selectedSegmentIndex = 1
                                                self!.typeSeg.isHidden = false
                                            case 2:
                                                self!.showElems(segSelected: self!.combineElems, img: "combineGem", delay: 0.01)
                                                self!.elemTypeSeg.selectedSegmentIndex = 2
                                            case 3:
                                                self!.showElems(segSelected: self!.rareElems, img: "rareGem", delay: 0.01)
                                                self!.elemTypeSeg.selectedSegmentIndex = 3
                                                
                                            default:
                                                break
                                            }
                                            
                                        } else {
                                            //小項目
                                            
                                            self!.typeSeg.isHidden = false
                                            
                                            switch self!.defaultTypeSeg!{
                                                
                                            case 0:
                                                self!.showElems(segSelected: self!.metalElems, img: "metalGem", delay: 0.01)
                                                self!.typeSeg.selectedSegmentIndex = 0
                                                
                                            case 1:
                                                self!.showElems(segSelected: self!.woodElems, img: "woodGem", delay: 0.01)
                                                self!.typeSeg.selectedSegmentIndex = 1
                                            case 2:
                                                self!.showElems(segSelected: self!.waterElems, img: "waterGem", delay: 0.01)
                                                self!.typeSeg.selectedSegmentIndex = 2
                                            case 3:
                                                self!.showElems(segSelected: self!.fireElems, img: "fireGem", delay: 0.01)
                                                self!.typeSeg.selectedSegmentIndex = 3
                                            case 4:
                                                self!.showElems(segSelected: self!.earthElems, img: "earthGem", delay: 0.01)
                                                self!.typeSeg.selectedSegmentIndex = 0
                                                
                                                
                                            default:
                                                break
                                            }
                                            
                                            
                                        }

                                        
                                        //最後一個給予動畫

                                        let elemToShow = self!.elems[self!.elems.count - 1]
                                    
                                        elemToShow.center = CGPoint(x: 180, y: 370)
                                        
                                        //跳入動畫
                                        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
                                            
                                         elemToShow.center = CGPoint(x: 200, y: 340)

                                            
                                        }) {[weak self] (finished:Bool) in
                                            
                                  
                                            if finished{
                                            UIView.animate(withDuration: 0.3, animations: {
                                                
                                                elemToShow.center = self!.elemCgPoints[self!.elems.count - 1]
                                                
                                                //回復按鈕 ＆ 鑲上selElem的
                                                self!.backToMapBtn.isUserInteractionEnabled = true
                                                self!.isElemAttachable = true
                                                self!.isBackpackFull = false
                                                
                                                
                                            })
                                            
                                            }
                                            
                                            
                                        }
                                        
                             
                                        
                                    })
                                    

                                    
                                } catch{
                                    
                                    print("catch error")
                                    
                                    
                                }
                            } else {
                                
                                print("urlsession has error")
                                
                            }
                        }).resume()
  
                    }
                    
                })

                
            } catch{
                
                print("catch error")
                
                
            }
        } else {
            
            print("urlsession has error")
            
        }
    }).resume()

    }
    
    //抓元素, 分類元素的功能
    func getUserElementFunc(){
        
        //抓使用者得到的元素
        let getElements = user?["getElement"] as! String

        //做成新的array
        allGetElements = getElements.components(separatedBy: ";")
        
        //移除最後一個空白值, 以目前寫法來說會分出一個空的""
        allGetElements.removeLast()
        
        //抓有得到的元素, append他們的資訊
        for i in 0 ..< allGetElements.count{
            if let name = allGetElements[i] as String?{
                
                //比對所有的元素名字相等的抓他們的資訊, append到各個分類
                for e in 0 ..< elements.count{
                    
                    if let n = elements[e]["name"] as String?{
                        
                        if n == name{
                            
                            //抓func來判定顯示圖片
                            if let function = elements[e]["func"]{
                                
                                //不包含雙元素的稀有元素
                                if !function.contains(","){
                                    
                                    switch function{
                                        
                                    case "hp":
                                        
                                        normalElems.append(elements[e])
                                        //allGetElemsInfo.append(elements[e])
                                        
                                    case "att":
                                        
                                        normalElems.append(elements[e])
                                        //allGetElemsInfo.append(elements[e])
                                    case "def":
                                        
                                        normalElems.append(elements[e])
                                        //allGetElemsInfo.append(elements[e])
                                        
                                    case "hit":
                                        
                                        normalElems.append(elements[e])
                                        //allGetElemsInfo.append(elements[e])
                                        
                                    case "heal":
                                        
                                        normalElems.append(elements[e])
                                        //allGetElemsInfo.append(elements[e])
                                    case "wood":
                                        
                                        woodElems.append(elements[e])
                                        //allGetElemsInfo.append(elements[e])
                                        
                                    case "earth":
                                        
                                        earthElems.append(elements[e])
                                        //allGetElemsInfo.append(elements[e])
                                        
                                    case "water":
                                        
                                        waterElems.append(elements[e])
                                        //allGetElemsInfo.append(elements[e])
                                        
                                    case "fire":
                                        
                                        fireElems.append(elements[e])
                                        //allGetElemsInfo.append(elements[e])
                                        
                                    case "metal":
                                        
                                        metalElems.append(elements[e])
                                        //allGetElemsInfo.append(elements[e])
                                        
                                    case "upgrade":
                                        
                                        combineElems.append(elements[e])
                                        //allGetElemsInfo.append(elements[e])
                                        
                                        //append合併元素
                                        //把合併元素append到array裡供後方檢查
                                        if let elemValue = elements[e]["value"] as String?{
                                            if let elemName = elements[e]["name"] as String?{
                                            //upgradeElems.append(elemValue)
                                                upgradeElemsInfo.updateValue(elemValue, forKey: elemName)
                                               
                                            }
                                            
                                        }
                                      
                                    default:
                                        break
                                    }
                                    
                                } else {
                                    
                                    //稀有元素
                                    rareElems.append(elements[e])
                                    //allGetElemsInfo.append(elements[e])
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }

            }
        }
        
        //移除第一組空值
        //allGetElemsInfo.remove(at: 0)
        normalElems.remove(at: 0)
        metalElems.remove(at: 0)
        woodElems.remove(at: 0)
        waterElems.remove(at: 0)
        fireElems.remove(at: 0)
        earthElems.remove(at: 0)
        combineElems.remove(at: 0)
        rareElems.remove(at: 0)
        
        //確認各頁元素有沒有滿
        if normalElems.count == 12{
            
            normalElemsFull = true
            
        } else {
            
            normalElemsFull = false
            
        }
        if metalElems.count == 12{
            
            metalElemsFull = true
        } else {
            
                  metalElemsFull = false
            
        }
        if woodElems.count == 12{
                  woodElemsFull = true
            
        } else {
            
                woodElemsFull = false
            
        }
        if waterElems.count == 12{
            
            waterElemsFull = true
        } else {
            
            waterElemsFull = false
            
        }
        
        if fireElems.count == 12{
            fireElemsFull = true
            
        } else {
            
            fireElemsFull = false
            
        }
        if earthElems.count == 12{
            
            earthElemsFull = true
            
        } else {
            earthElemsFull = false
            
        }
        
        if combineElems.count == 12{
            combineElemsFull = true
            
        } else {
            combineElemsFull = false
            
        }
        
        if rareElems.count == 12{
            
            rareElemsFull = true
            
        } else {
            
            rareElemsFull = false
        }
        
 }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //當離開畫面時需要鎖定此功能, 因為會在別的VC操控到他
        if canMoveElem{
        
        for touch in touches {
            
            location = touch.location(in: self.view)
            
            //放掉手指就不顯示info
            elemInfoBg.alpha = 0
            
            //首先先讓元素回原位
            touchedElem.center = originalPosition
            
            calculatePetValue()
            
            //卻認selElem是否有固定, 沒有就消失
            var selTouchedAnyImage = false
            
            //確認所移動的元素為何
            
            if touch.tapCount < 2{
                
                //***如果是selElem
                
                if touchedElem.image == nil && selTouchedElem.image != nil{
                
                    //part 1. 遇到小elem就交換
                    //part 2. 碰到大elem就被大elem取代, 自己消失
                    //part 3. 碰到其他selElem就交換
                    //part 4. 碰到其他空格就固定住
                    //part 5. 碰到刪除鍵就回復原位等指令
                    //part 5. 移動到其他地方就消失
                    
                    
                    for i in 0 ..< elems.count{
                        
                        if let elem = elems[i] as UIImageView?{
                            
                            if elem.image != nil{
                                
                                //part 1
                                if elem.frame.contains(location){
                                    
                                    if elem.frame.width == 60 {
                                        
                                        print("遇到小elem就交換")
                                        selTouchedAnyImage = true
                                        
                                        elem.center = selOriginalPosition
                                        
                                        
                                        //如果碰到的是本頁的小elem
                                        saveElemIndex(index: selIndex, page: elemPage, elem: i)

                                        
                                        //part 2
                                    } else {
                                        
                                        
                                        print("遇到碰到大elem就被大elem取代, 自己消失")
                                        selTouchedAnyImage = true
                                        
                                        elem.center = selOriginalPosition
                                        elem.frame.size = CGSize(width:60, height: 60)
                                        
                                        
                                        selTouchedElem.image = nil
                                        
                                        for subview in selTouchedElem.subviews{
                                            
                                            subview.removeFromSuperview()
                                        }
                                        
                                        saveElemIndex(index: selIndex, page: elemPage, elem: i)
                                    }
                                    
                                }
                                
                            }
                        }
                        
                    }
                    
                    
                    //part 3.
                    
                    for i in 0 ..< selElems.count{
                        
                        
                        if let selElem = selElems[i] as UIImageView?{
                            
                            //確認不是讀取空值
                            if selElem.image != nil {
                                //避開自己
                                if selElem != selTouchedElem{
                                    
                                    if selElem.frame.contains(location) {
                                        
                                        print("遇到別的selElem就交換及固定")
                                        
                                        //固定的部分在下方sel碰到selElemsBack處理
                                        //selTouchedElem.center = selElem.center
                                        
                                        selElem.center = selOriginalPosition
                                        
                                        selTouchedAnyImage = true
                                        
                                        //抓被換sel的頁數及elem
                                        var replacedSelIndex = Int()
                                        var replacedSelPage = Int()
                                        var replacedSelElem = Int()
                                        
                                        //利用selElemsBack不改變位置的特性決定選selElem處於occupied的哪個位置儲存給後面使用
                                        if selElemsBack[0].frame.contains(location){
                                            replacedSelIndex = 0
                                            
                                        } else if selElemsBack[1].frame.contains(location){
                                            replacedSelIndex = 1
                                            
                                        } else if selElemsBack[2].frame.contains(location){
                                            
                                            replacedSelIndex = 2
                                        }
                                        
                                        for p in 0 ..< elemPages.count{
                                            
                                            //抓頁面元素
                                            if let elem = exactSelOccupiedByElemIndex[replacedSelIndex][elemPages[p]]{
                                                
                                                //提供給後面儲存用
                                                replacedSelPage = p
                                                replacedSelElem = elem
                                                
                                            }
                                            
                                        }
                                        
                                        //儲存交換位置的index
                                        saveElemIndex(index: selIndex, page: replacedSelPage, elem: replacedSelElem)
                                        
                                    }
                                    
                                }
                                
                            }
                        }
                        
                        
                    }
                    

                    
                    for i in 0 ..< selElemsBack.count{
                        
                        if let selElemBack = selElemsBack[i] as UIImageView?{
                            
                            //part 4.
                            if selElemBack.frame.contains(location){
                                
                                print("碰到其他空格就固定住")
                                
                                selTouchedAnyImage = true
                                
                                selTouchedElem.center = selElemBack.center
                                
                                
                                //先確認儲存位置是否有任何elem
                                
                                if exactSelOccupiedByElemIndex[i] == [-1: -1]{
                                    
                                    saveElemIndex(index:selIndex, page:-1, elem:-1)
                                    saveElemIndex(index: i, page: selPage, elem: selElemValue)
                                    
                                } else {
                                    
                                    saveElemIndex(index: i, page: selPage, elem: selElemValue)
                                    
                                }
                                
                            }
                            
                        }
                        
                        
                    }
                    
                    //part 5.
                    if trashCanImg.frame.contains(location){
                        
                        
                        print("碰到刪除鍵就回復到原位")
                        
                        //刪除的function
                        deleteElem(elem:selTouchedElem)
                        
                        selTouchedElem.center = selOriginalPosition
                        
                        selTouchedAnyImage = true
                        
                        //抓取欲刪除的index
                        elemIndexToDelete = selIndex
                        
                    }
                    
                    
                    
                    //part 6.
                    if selTouchedAnyImage == false{
                        
                        print("移動到其他地方就消失")
                        
                        selTouchedElem.image = nil
                        
                        for subview in selTouchedElem.subviews{
                            
                            subview.removeFromSuperview()
                        }
                        
                        saveElemIndex(index: selIndex, page: -1, elem: -1)
                        
                    }
                    
                    

                    
                    
                    //***如果是小Elem
                } else if touchedElem.frame.width == 60 && touchedElem.image != nil{
                    
                    //part 1. 遇到別的elem就交換及固定, 並確認大小
                    //part 2. 遇到別的selElem就交換及固定
                    //part 3. 遇到空的selElemBack就固定
                    //part 4. 碰到刪除鍵就回復到原位
                    //part 4. 沒有固定在任何地方的話就等於會回復到原位大小改成80
                    
                    //預設小元素沒有固定在任何地方
                    var smallElemTouchedAnyImage = false
                    
                    //part 1.
                    for i in 0 ..< elems.count{
                        
                        if let elem = elems[i] as UIImageView?{
                            
                            if elem != touchedElem{
                                
                                if elem.frame.contains(location) {
                                    
                                    //幾如碰到的是小的elem, 就交換位置
                                    if elem.frame.width == 60 {
                                        print("幾假如碰到的是小的elem, 就交換位置")
                                        
                                        //此固定位置下方有做到
                                        //touchedElem.center = elem.center
                                        
                                        elem.center = currentPosition
                                        
                                        smallElemTouchedAnyImage = true
                                        
                                        saveElemIndex(index: elemIndex, page: elemPage, elem: i)
                                        
                                        //假如遇到的是大的elem, 交換位置及變大小
                                        
                                    } else {
                                        
                                        print("假如遇到的是大的elem, 交換位置及變大小")
                                        
                                        
                                        touchedElem.center = originalPosition
                                        touchedElem.frame.size = CGSize(width:80, height: 80)
                                        
                                        elem.center = currentPosition
                                        elem.frame.size = CGSize(width:60, height: 60)
                                        smallElemTouchedAnyImage = true
                                        
                                        saveElemIndex(index: elemIndex, page: elemPage, elem: i)
                                        
                                        
                                    }
                                    
                                }
                            }
                        }
                        
                        
                    }
                    
                    //Part 2
                    
                    for i in 0 ..< selElems.count{
                        
                        if let selElem = selElems[i] as UIImageView?{
                            
                            if selElem.image != nil{
                                
                                if selElem.frame.contains(location) {
                                    
                                    print("小elem遇到別的selElem就交換及固定")
                                    
                                    //此固定位置下方有做到
                                    //touchedElem.center = selElem.center
                                    
                                    selElem.center = currentPosition
                                    
                                    smallElemTouchedAnyImage = true
                                    
                                    //抓被換sel的頁數及elem
                                    var replacedSelIndex = Int()
                                    var replacedSelPage = Int()
                                    var replacedSelElem = Int()
                                    //利用selElemsBack不改變位置的特性決定選selElem處於occupied的哪個位置儲存給後面使用
                                    if selElemsBack[0].frame.contains(location){
                                        replacedSelIndex = 0
                                        
                                    } else if selElemsBack[1].frame.contains(location){
                                        replacedSelIndex = 1
                                        
                                    } else if selElemsBack[2].frame.contains(location){
                                        
                                        replacedSelIndex = 2
                                    }
                                    
                                    for p in 0 ..< elemPages.count{
                                        
                                        //抓頁面元素
                                        if let elem = exactSelOccupiedByElemIndex[replacedSelIndex][elemPages[p]]{
                                            
                                            //提供給後面儲存用
                                            replacedSelPage = p
                                            replacedSelElem = elem
                                            
                                        }
                                        
                                    }
                                    
                                    //儲存交換位置的index
                                    saveElemIndex(index: elemIndex, page: replacedSelPage, elem: replacedSelElem)
                                    
                                    
                                    
                                }
                                
                            }
                            
                        }
                        
                        
                    }
                    
                    //part 3. 遇到空的selElemBack就固定
                    
                    for i in 0 ..< selElemsBack.count{
                        
                        if let selElemBack = selElemsBack[i] as UIImageView?{
                            
                            if selElemBack.frame.contains(location) {
                                
                                print("小elem遇到別的selElemsBack就交換及固定")
                                
                                touchedElem.center = selElemBack.center
                                
                                
                                smallElemTouchedAnyImage = true
                                
                                //檢查此位置是否為-1
                                
                                if exactSelOccupiedByElemIndex[i] == [-1: -1]{
                                    
                                    saveElemIndex(index:elemIndex, page:-1, elem:-1)
                                    saveElemIndex(index: i, page: elemPage, elem: elemValue)
                                } else {
                                    
                          
                                    saveElemIndex(index: i, page: elemPage, elem: elemValue)
                                }
                                
                            }
                            
                            
                            
                        }
                        
                        
                    }
                    
                    // part 4. 碰到刪除鍵就回復到原位
                    
                    if trashCanImg.frame.contains(location){
                        
                        deleteElem(elem:touchedElem)
                        
                        touchedElem.center = currentPosition
                        
                        smallElemTouchedAnyImage = true
                        
                        elemIndexToDelete = elemIndex
                        
                        
                    }
                    
                    
                    //part 5. 沒有固定在任何地方的話就等於會回復到原位大小改成80
                    
                    if smallElemTouchedAnyImage == false{
                        
                        print("沒有固定在任何地方的話就等於會回復到原位大小改成80")
                        
                        touchedElem.frame.size = CGSize(width:80, height: 80)
                        
                        saveElemIndex(index: elemIndex, page: -1, elem: -1)
                        
                    }
                    
             
                    
                    //***如果是大Elem
                } else if touchedElem.frame.width == 80{
                    
                    // part 1. 碰到小elem就替換及固定及改大小
                    // part 2. 碰到selElem就取代及改大小
                    // part 3. 碰到selElemsBack就固定及改大小
                    // part 4. 碰到刪除鍵就啟動刪除
                    
                    
                    
                    //如果非刪除模式
                    if isElemAttachable {
                    //Part 1.
                    for i in 0 ..< elems.count{
                        if let elem = elems[i] as UIImageView?{
                            
                            if elem != touchedElem{
                                
                                //碰到小的
                                if elem.frame.width == 60{
                                    
                                    if elem.frame.contains(location){
                                        
                                        print("碰到小elem就替換及固定及改大小")
                                        
                                        
                                        elem.center = elemCgPoints[i]
                                        elem.frame.size = CGSize(width:80, height: 80)
                                        
                                    }
                                    
                                    
                                }
                            }
                        }
                        
                        
                    }
                    
                    //Part 2. 碰到selElem就取代及改大小
                    
                    for i in 0 ..< selElems.count{
                        
                        if let selElem = selElems[i] as UIImageView?{
                            
                            //要確認有圖片才算
                            if selElem.image != nil {
                                
                                if selElem.frame.contains(location){
                                    
                                    print("碰到selElem就取代及改大小")
                                    
                                    //selElem消失
                                    
                                    selElem.image = nil
                                    
                                    for subview in selElem.subviews{
                                        
                                        subview.removeFromSuperview()
                                        
                                    }
                                    
                                    
                                }
                                
                            }
                        }
                        
                    }
                    
                    // part 3. 碰到selElemsBack就固定及改大小
                    
                    for i in 0 ..< selElemsBack.count{
                        
                        if let selElemBack = selElemsBack[i] as UIImageView?{
                            
                            if selElemBack.frame.contains(location){
                                
                                print("碰到selElemsBack就固定及改大小")
                                
                                touchedElem.center = selElemBack.center
                                touchedElem.frame.size = CGSize(width:60, height: 60)
                                
                                saveElemIndex(index: i, page: elemPage, elem: elemValue)
                                
                            }
                            
                            
                        }
                        
                    }
                    }
                    
                    // part 4. 碰到刪除鍵就啟動刪除
                    if trashCanImg.frame.contains(location){
                        
                        deleteElem(elem:touchedElem)
                        
                        //設為-1讓其辨認此為大Elem
                        elemIndexToDelete = -1

                        
                    }
                    
                }
                
            } else {
                
                // part 1. selElem按兩下會消失
                // part 2. 小elem按兩下會回原位
                
                //按兩下sel元素會消失
                if selTouchedElem.image != nil && touchedElem.image == nil {
                    
                    print("sel元素消失")
                    
                    selTouchedElem.image = nil
                    
                    for subview in selTouchedElem.subviews{
                        
                        subview.removeFromSuperview()
                    }
                    
                    saveElemIndex(index: selIndex, page: -1, elem: -1)
                    
                }
                
                if touchedElem.image != nil && selTouchedElem.image == nil && touchedElem.frame.width == 60{
                    
                    print("小elem回到原始元素位置")
                    
                    touchedElem.center = originalPosition
                    touchedElem.frame.size = CGSize(width:80, height: 80)
                    
                    saveElemIndex(index: elemIndex, page: -1, elem: -1)
                    
                    
                }
                
                
            }
           
            //重置
            touchedElem = UIImageView()
            selTouchedElem = UIImageView()

            //提供儲存的變數重置
            selIndex = Int()
            selPage = Int()
            selElemValue = Int()
            elemValue = Int()
            
        }

    }
    }
    
    
    
    //抓取元素資訊
    func fetchElementInfo(){
        
        //準備元素資訊供顯示
        for i in 0 ..< infoToShow.count{
            
            if let functions = infoToShow[i]["func"] as String?{
                
                //非稀有元素
                if !functions.contains(","){
                    
                    //填入資訊
                    switch functions{
                        
                    case "hp":
                        titleChinese.append("魔法元素")
                        functionChinese.append("血量")
                    case "att":
                        titleChinese.append("魔法元素")
                        functionChinese.append("攻擊力")
                    case "def":
                        titleChinese.append("魔法元素")
                        functionChinese.append("防禦力")
                    case "hit":
                        titleChinese.append("魔法元素")
                        functionChinese.append("爆擊率")
                    case "heal":
                        titleChinese.append("魔法元素")
                        functionChinese.append("治癒")
                    case "wood":
                        titleChinese.append("屬性元素")
                        functionChinese.append("木屬性魔攻")
                    case "earth":
                        titleChinese.append("屬性元素")
                        functionChinese.append("土屬性魔攻")
                    case "water":
                        titleChinese.append("屬性元素")
                        functionChinese.append("水屬性魔攻")
                    case "fire":
                        titleChinese.append("屬性元素")
                        functionChinese.append("火屬性魔攻")
                    case "metal":
                        titleChinese.append("屬性元素")
                        functionChinese.append("金屬性魔攻")
                        
                    case "upgrade":
                        //需重寫升級方法
                        titleChinese.append("寵物碎片")
                        functionChinese.append("蒐集3片碎片合成寵物")
                        
                    default:
                        break
                        
                    }
                }else {
                    
                    titleChinese.append("稀有元素")
                    
                    //分析多元素的功能
                     let functionArray = functions.components(separatedBy: ",")
                    
                    for f in 0 ..< functionArray.count {
                    
                        switch functionArray[f]{
                            
                            //依序填入功能說明
                        case "hp":
                            if f != 0 {
                                functionChinese[i] = functionChinese[i] + "血量+"
                                
                            }else {
                                functionChinese.append("血量+")
                            }
                        case "att":
                            if f != 0 {
                                functionChinese[i] = functionChinese[i] + "攻擊力+"
                                
                            }else {
                                
                                functionChinese.append("攻擊力+")
                            }

                        case "def":
                            if f != 0 {
                                functionChinese[i] = functionChinese[i] + "防禦力+"
                                
                            }else {
                                
                                functionChinese.append("防禦力+")
                            }

                        case "hit":
                            if f != 0  {
                                functionChinese[i] = functionChinese[i] + "爆擊率+"
                                
                            }else {
                                
                                functionChinese.append("爆擊率+")
                            }

                        case "heal":
                            if f != 0  {
                                functionChinese[i] = functionChinese[i] + "治癒+"}else {
                                
                                functionChinese.append("治癒+")
                            }

                        default:
                            break
                            
                        }
                        
                    }
                    
                }
            }
            
            //新增數值供info顯示
            if let value = infoToShow[i]["value"] as String?{
                values.append(value)
                
            }
            
            //新增名稱供顯示及刪除使用
            if let name = infoToShow[i]["name"] as String?{
                elemNames.append(name)
                
            }
            
        }
        
    }
    
    //計算寵物數值的func
    func calculatePetValue(){

        //抓數值, 之後這個數值要從一個可以固定及升級改數值的地方抓數字過來.
        //寵物資訊重置
        pet = petOriginal
        
        //抓數值來顯示, 計算
        let petHpValue = pet!["petHp"] as! Int
        let petAttValue = pet!["petAtt"] as! Int
        if let petDefValue = pet!["petDef"] {
            petDefenseLabel.text = String(describing: petDefValue)
        }
        let petHealValue = pet!["petHeal"] as! Int
        //let petTypeValue = pet!["petType"] as! String //用不到
        let petHitValue = pet!["petHit"] as! Int
        let petMagValue = pet!["petMag"] as! Int
    
        //顯示
        petCureLabel.text = String(describing: petHealValue)
        petLifeLabel.text = String(describing: petHpValue)
        petAttackLabel.text = String(describing: petAttValue)
        petDoubleAttackLabel.text = String(describing: petHitValue) + "%"
        petExtraAttackLabel.text = String(describing: petMagValue)
        
        //顏色先重置白色
        petLifeLabel.textColor = .white
        petAttackLabel.textColor = .white
        petDefenseLabel.textColor = .white
        petExtraAttackLabel.textColor = .white
        petDoubleAttackLabel.textColor = .white
        petCureLabel.textColor = .white
        
        //寵物屬性小圖示先重置
        petTypeImg.image = UIImage()
        
        // 機制: 這裡的數字不改, 每一次都check selOccupied有沒有任何值會影響
        
        for i in 0 ..< exactSelOccupiedByElemIndex.count{
            
            for (page,elem) in exactSelOccupiedByElemIndex[i]{
                
                //抓取所有元素的func 及value
                var function = String()
                var value = String()
                
                switch page {
                    
                case 0:
                    
                    function = getValues(group: normalElems, type: "func", elem: elem)
                    value = getValues(group: normalElems, type: "value", elem: elem)
                    
                case 1:
                    
                    function = "metal"
                    value = getValues(group: metalElems, type: "value", elem: elem)
                    
                case 2:
                    
                    function = "wood"
                    value = getValues(group: woodElems, type: "value", elem: elem)
                    
                case 3:
                    
                    function = "water"
                    value = getValues(group: waterElems, type: "value", elem: elem)
                    
                case 4:
                    
                    function = "fire"
                    value = getValues(group: fireElems, type: "value", elem: elem)
                    
                case 5:
                    
                    function = "earth"
                    value = getValues(group: earthElems, type: "value", elem: elem)
                    
                case 6:
                    
                    function = "upgrade"
                    value = getValues(group: combineElems, type: "value", elem: elem)
                    
                case 7:
                    
                    //在此計算稀有元素
                    function = getValues(group: rareElems, type: "func", elem: elem)
                    value = getValues(group: rareElems, type: "value", elem: elem)
                    
                    //抓出所有的func
                    let functionArray = function.components(separatedBy: ",")
                    let valueArray = value.components(separatedBy: ",")
                    
                    //跑所有的稀有func
                    for f in 0 ..< functionArray.count{
                        
                        switch functionArray[f]{
                        case "hp":
                            
                            petLifeLabel.textColor = .green
                            
                            petLifeLabel.text = String(Int(petLifeLabel.text!)! + Int(valueArray[f])!)
                            
                            pet?["petHp"] = Int(petLifeLabel.text!)!
                            
                        case "att":
                            petAttackLabel.textColor = .green
                            
                            petAttackLabel.text = String(Int(petAttackLabel.text!)! + Int(valueArray[f])!)
                            
                            //pet?["petAtt"] = Int(Int(petAttackLabel.text!)! + Int(value)!)
                            pet?["petAtt"] = Int(petAttackLabel.text!)!
                            
                            
                        case "def":
                            petDefenseLabel.textColor = .green
                            
                            petDefenseLabel.text = String(Float(petDefenseLabel.text!)! + Float(valueArray[f])!)
                            
                            pet?["petDef"] = Float(petDefenseLabel.text!)!
                            
                            
                        case "hit":
                            petDoubleAttackLabel.textColor = .green
                            
                            
                            let doubleAttackNumber = petDoubleAttackLabel.text?.replacingOccurrences(of: "%", with: "")
                            
                            petDoubleAttackLabel.text = String(Int(doubleAttackNumber!)! + Int(valueArray[f])!) + "%"
                            
                            pet?["petHit"] = Int(petDoubleAttackLabel.text!.replacingOccurrences(of: "%", with: ""))!
                            
                            
                        case "heal":
                            petCureLabel.textColor = .green
                            
                            petCureLabel.text = String(Int(petCureLabel.text!)! + Int(valueArray[f])!)
                            
                            pet?["petHeal"] = Int(petCureLabel.text!)!
                            
                       
                        default:
                            break
                            
                            
                        }
                        
                    }
                    
                    
                    
                    
                default:
                    break
                }
                
                switch function{
                    
                case "hp":
                    
                    petLifeLabel.textColor = .green
                    
                    petLifeLabel.text = String(Int(petLifeLabel.text!)! + Int(value)!)
                    
                    pet?["petHp"] = Int(petLifeLabel.text!)!
                    
                case "att":
                    petAttackLabel.textColor = .green
                    
                    petAttackLabel.text = String(Int(petAttackLabel.text!)! + Int(value)!)
                    
                    //pet?["petAtt"] = Int(Int(petAttackLabel.text!)! + Int(value)!)
                    pet?["petAtt"] = Int(petAttackLabel.text!)!
                    
                    
                case "def":
                    petDefenseLabel.textColor = .green
                    
                    petDefenseLabel.text = String(Float(petDefenseLabel.text!)! + Float(value)!)
                    
                    pet?["petDef"] = Float(petDefenseLabel.text!)!
                    
                    
                case "hit":
                    petDoubleAttackLabel.textColor = .green
                    
                
                    let doubleAttackNumber = petDoubleAttackLabel.text?.replacingOccurrences(of: "%", with: "")
                    
                    petDoubleAttackLabel.text = String(Int(doubleAttackNumber!)! + Int(value)!) + "%"
                    
                    pet?["petHit"] = Int(petDoubleAttackLabel.text!.replacingOccurrences(of: "%", with: ""))!
                    
                    
                case "heal":
                    petCureLabel.textColor = .green
                    
                    petCureLabel.text = String(Int(petCureLabel.text!)! + Int(value)!)
                    
                    pet?["petHeal"] = Int(petCureLabel.text!)!
                    
                case "wood":
                    
                    petExtraAttackLabel.textColor = .green
                    petExtraAttackLabel.text = String(petMagValue + Int(value)!)
                    pet?["petMag"] = Int(petMagValue + Int(value)!)
                    
                    pet?["petType"] = "wood"
                    
                    petTypeImg.image = UIImage(named: "wood.png")
                    
                    
                case "earth":
                    
                    petExtraAttackLabel.textColor = .green
                    petExtraAttackLabel.text = String(petMagValue + Int(value)!)
                    pet?["petMag"] = Int(petMagValue + Int(value)!)
                    pet?["petType"] = "earth"
                    
                    petTypeImg.image = UIImage(named: "earth.png")
                    
                    
                case "water":
                    
                    
                    petExtraAttackLabel.textColor = .green
                    petExtraAttackLabel.text = String(petMagValue + Int(value)!)
                    pet?["petMag"] = Int(petMagValue + Int(value)!)
                    pet?["petType"] = "water"
                    
                    petTypeImg.image = UIImage(named: "water.png")
                    
                case "fire":
                    
                    petExtraAttackLabel.textColor = .green
                    petExtraAttackLabel.text = String(petMagValue + Int(value)!)
                    pet?["petMag"] = Int(petMagValue + Int(value)!)
                    pet?["petType"] = "fire"
                    petTypeImg.image = UIImage(named: "fire.png")
                    
                    
                case "metal":
                    
                    
                    petExtraAttackLabel.textColor = .green
                    petExtraAttackLabel.text = String(petMagValue + Int(value)!)
                    pet?["petMag"] = Int(petMagValue + Int(value)!)
                    pet?["petType"] = "metal"
                    
                    petTypeImg.image = UIImage(named: "metal.png")
                    
                    
                case "upgrade":
                    break
                default:
                    break
                    
                    
                }
                
            }

            //儲存改變數值
            UserDefaults.standard.set(pet, forKey: "pet")
            
            //可以點擊畫面
            self.view.isUserInteractionEnabled = true
        }
        
        /*
        
        for p in 0 ..< elemPages.count{
         
         for s in 0 ..< exactSelOccupiedByElemIndex.count{
         
         if let elem = exactSelOccupiedByElemIndex[s][elemPages[p]]{
         
            //抓取所有元素的func 及value
            var function = String()
            var value = String()
            
            switch p {
                
            case 0:
               
                function = getValues(group: normalElems, type: "func", elem: elem)
                value = getValues(group: normalElems, type: "value", elem: elem)
                
            case 1:
                
                function = "metal"
                value = getValues(group: metalElems, type: "value", elem: elem)
                
                
            case 2:
                
                function = "wood"
                value = getValues(group: woodElems, type: "value", elem: elem)
                
            case 3:
                
                function = "water"
                value = getValues(group: waterElems, type: "value", elem: elem)
                
            case 4:
                
                function = "fire"
                value = getValues(group: fireElems, type: "value", elem: elem)
                
            case 5:
                
                function = "earth"
                value = getValues(group: earthElems, type: "value", elem: elem)
                
            case 6:
         
                function = "upgrade"
                value = getValues(group: combineElems, type: "value", elem: elem)
                
            case 7:
                
                function = "rare"
                value = getValues(group: rareElems, type: "value", elem: elem)
                
            default:
                break
            }

            switch function{
                
            case "hp":
                
                
                petLifeLabel.textColor = .green
                
                
                petLifeLabel.text = String(Int(petLifeLabel.text!)! + Int(value)!)
                
                pet?["petHp"] = Int(petLifeLabel.text!)!
                
            case "att":
                petAttackLabel.textColor = .green
                

                petAttackLabel.text = String(Int(petAttackLabel.text!)! + Int(value)!)
                
                //pet?["petAtt"] = Int(Int(petAttackLabel.text!)! + Int(value)!)
                pet?["petAtt"] = Int(petAttackLabel.text!)!

                
            case "def":
                petDefenseLabel.textColor = .green
                
                
                petDefenseLabel.text = String(Float(petDefenseLabel.text!)! + Float(value)!)
                
                pet?["petDef"] = Float(petDefenseLabel.text!)!
                

                
                
            case "hit":
                petDoubleAttackLabel.textColor = .green
                
                
                petDoubleAttackLabel.text = String(Int(petDoubleAttackLabel.text!)! + Int(value)!)
                
                pet?["petHit"] = Int(petDoubleAttackLabel.text!)!

                
                
            case "heal":
                petCureLabel.textColor = .green
                
                
                petCureLabel.text = String(Int(petCureLabel.text!)! + Int(value)!)
                
                pet?["petHeal"] = Int(petCureLabel.text!)!
                

                
            case "wood":
                
                petExtraAttackLabel.textColor = .green
                petExtraAttackLabel.text = String(petMagValue + Int(value)!)
                pet?["petMag"] = Int(petMagValue + Int(value)!)
                
                pet?["petType"] = "wood"
                
                petTypeImg.image = UIImage(named: "wood.png")
                
                
            case "earth":
                
                petExtraAttackLabel.textColor = .green
                petExtraAttackLabel.text = String(petMagValue + Int(value)!)
                pet?["petMag"] = Int(petMagValue + Int(value)!)
                pet?["petType"] = "earth"
                
                petTypeImg.image = UIImage(named: "earth.png")
                
                
            case "water":
                
                
                petExtraAttackLabel.textColor = .green
                petExtraAttackLabel.text = String(petMagValue + Int(value)!)
                pet?["petMag"] = Int(petMagValue + Int(value)!)
                pet?["petType"] = "water"
                
                petTypeImg.image = UIImage(named: "water.png")
                
            case "fire":
                
                
                
                petExtraAttackLabel.textColor = .green
                petExtraAttackLabel.text = String(petMagValue + Int(value)!)
                pet?["petMag"] = Int(petMagValue + Int(value)!)
                pet?["petType"] = "fire"
                petTypeImg.image = UIImage(named: "fire.png")
                
                
            case "metal":
                
                
                petExtraAttackLabel.textColor = .green
                petExtraAttackLabel.text = String(petMagValue + Int(value)!)
                pet?["petMag"] = Int(petMagValue + Int(value)!)
                pet?["petType"] = "metal"
                
                petTypeImg.image = UIImage(named: "metal.png")
                
                
            case "upgrade":
                break
            default:
                break
                
                
            }


         
         }
         
         }
         
            
            //儲存改變數值
            UserDefaults.standard.set(pet, forKey: "pet")

         }
*/
        
    }
    
    //從各頁裡取得元素資訊的小func
    func getValues(group:[[String:String]],type:String,elem:Int) -> String{
        

        var stringGet = String()
        
        if let stringToReturn = group[elem][type] as String?{
  
            
            stringGet = stringToReturn
            
        }
     
        return stringGet
    }
    
    
    @IBAction func backToMapClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
