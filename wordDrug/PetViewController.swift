//
//  PetViewController.swift
//  wordDrug
//
//  Created by Ethan on 2017/11/27.
//  Copyright © 2017年 playplay. All rights reserved.
//

import UIKit


var petElems : NSMutableDictionary?
var elemSaved : [Int]?
//元素紀錄
var exactElemSaved : [[Int:Int]]?


class PetViewController: UIViewController {
    //所有元素屬性數值
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
                    ["name":"oy1","func":"att,hit,upgrade","value":"210,9,1-12-10"],
                    
                    ["name":"ph1","func":"att","value":"180"],
                    ["name":"pi1","func":"def","value":"45"],
                    ["name":"pl1","func":"hit","value":"10"],
                    ["name":"pr1","func":"wood","value":"170"],
                    ["name":"rare1","func":"upgrade","value":"1-12-10"],
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
                    ["name":"ai2","func":"def,heal,upgrade","value":"80,200,2-3-10"]]
    
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
    //記憶碰觸到元素的原始位置
    var originalPosition = CGPoint()
    //畫面上選項的元素
    var selElems = [UIImageView]()
    
    //暫時抓正確選項位置
    var selElemsCgs = [[35,258],[100.5,258],[164.5,258]]
    
    //目前選到的元素Index
    var currentElemIndex = -1
    var exactCurrentElemIndex = [-1:-1]
    
    //紀錄三個選項元素的數字
    var selOccupiedByElemIndex = [-1,-1,-1]
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
    
    //元素的頁數變數及所有頁數
    var elemPage = 0   //預設為第0頁
    var elemPages = [0,1,2,3,4,5,6,7]
    
    //屬性元素的控制器
    @IBOutlet weak var elemTypeSeg: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
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
        
        //抓使用者得到的元素
        let getElemets = user?["getElement"] as! String
        
        //做成新的array
        allGetElements = getElemets.components(separatedBy: ";")
        
        //移除最後一個空白值, 以目前寫法來說會分出一個空的""
        allGetElements.removeLast()
        
        //元素列表背景
        elementBg.image = UIImage(named: "elemBg.png")
        
        
        
        //加入選項元素UIView為了彌補位置錯誤
        /*
         let sel1 = UIView()
         sel1.frame.size = CGSize(width: 55, height: 55)
         sel1.center = CGPoint(x: 35, y: 258)
         self.view.addSubview(sel1)
         
         let sel2 = UIView()
         sel2.frame.size = CGSize(width: 55, height: 55)
         sel2.center = CGPoint(x: 100.5, y: 258)
         self.view.addSubview(sel2)
         
         let sel3 = UIView()
         sel3.frame.size = CGSize(width: 55, height: 55)
         sel3.center = CGPoint(x: 164.5, y: 258)
         self.view.addSubview(sel3)
         */
        
        
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
        
        /*
         elems.append(elem13)
         elems.append(elem14)
         elems.append(elem15)
         */
        
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
                                        allGetElemsInfo.append(elements[e])
                                        
                                    case "att":
                                        
                                        normalElems.append(elements[e])
                                        allGetElemsInfo.append(elements[e])
                                    case "def":
                                        
                                        normalElems.append(elements[e])
                                        allGetElemsInfo.append(elements[e])
                                        
                                    case "hit":
                                        
                                        normalElems.append(elements[e])
                                        allGetElemsInfo.append(elements[e])
                                        
                                    case "heal":
                                        
                                        normalElems.append(elements[e])
                                        allGetElemsInfo.append(elements[e])
                                    case "wood":
                                        
                                        woodElems.append(elements[e])
                                        allGetElemsInfo.append(elements[e])
                                        
                                    case "earth":
                                        
                                        earthElems.append(elements[e])
                                        allGetElemsInfo.append(elements[e])
                                        
                                    case "water":
                                        
                                        waterElems.append(elements[e])
                                        allGetElemsInfo.append(elements[e])
                                        
                                    case "fire":
                                        
                                        fireElems.append(elements[e])
                                        allGetElemsInfo.append(elements[e])
                                        
                                    case "metal":
                                        
                                        metalElems.append(elements[e])
                                        allGetElemsInfo.append(elements[e])
                                        
                                    case "upgrade":
                                        
                                        combineElems.append(elements[e])
                                        allGetElemsInfo.append(elements[e])
                                        
                                    default:
                                        break
                                    }
                                    
                                } else {
                                    
                                    //稀有元素
                                    rareElems.append(elements[e])
                                    allGetElemsInfo.append(elements[e])
                                }
                                
                                
                            }
                            
                            
                        }
                        
                    }
                    
                }
                
                
            }
        }
        
        //移除第一組空值
        allGetElemsInfo.remove(at: 0)
        normalElems.remove(at: 0)
        metalElems.remove(at: 0)
        woodElems.remove(at: 0)
        waterElems.remove(at: 0)
        fireElems.remove(at: 0)
        earthElems.remove(at: 0)
        combineElems.remove(at: 0)
        rareElems.remove(at: 0)
        
        
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
        elemSaved = UserDefaults.standard.object(forKey: "elemSaved") as? [Int]
        
        //用decode方式抓取本機儲存的使用元素
        let decodedObject = UserDefaults.standard.object(forKey: "exactElemSaved") as? NSData
        
        if let decoded = decodedObject {
            exactElemSaved = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [[Int : Int]]
            
        }
        
        print("exactElemSaved:\(String(describing: exactElemSaved))")
        
        //指定之前所存檔的使用元素
        if elemSaved == nil {
            
            elemSaved = selOccupiedByElemIndex
            
        } else {
            selOccupiedByElemIndex = elemSaved!
            
        }
        if exactElemSaved == nil {
            exactElemSaved = exactSelOccupiedByElemIndex
        } else {
            exactSelOccupiedByElemIndex = exactElemSaved!
        }
        
        
        //顯示背包內容
        elemPage = 0
        showElems(segSelected:normalElems,img:"normalGem",delay:0.1)
        
        //計算寵物數值
        calculatePetValue()
        
        
        playNowBtn.isHidden = true
        hintBtn.isHidden = true
        
        if isReadyToEnterBattle{
            showHint()
        }
    }
    
    //快速抓圖片
    func makeImage(name:String) ->UIImage{
        let image = UIImage(named: name + ".png")
        return image!
    }
    
    
    @objc func typeSelected(sender:UISegmentedControl){
        
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
        
        //先重置資訊
        functionChinese.removeAll(keepingCapacity: false)
        titleChinese.removeAll(keepingCapacity: false)
        values.removeAll(keepingCapacity: false)
        
        
        for s in selElems{
            s.image = nil
            
            for i in s.subviews{
                
                if i.tag == 0 || i.tag == 1{
                    
                    i.removeFromSuperview()
                }
            }
            
        }
        
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
        
        //抓元素圖片
        elemImg = img
        
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
        
        //抓取資訊
        fetchElementInfo()
        
        //做選項裡的圖, 包含該頁及非該頁
        //跑每一頁, 用意在於要確認每組第一個值為頁數, 然後抓取他們的value
        for p in 0 ..< elemPages.count{
            
            //跑儲存的數字
            for s in 0 ..< exactSelOccupiedByElemIndex.count{
                
                //
                //抓頁面元素
                if let value = exactSelOccupiedByElemIndex[s][elemPages[p]]{
                    
                    //以下留著做參考
                    //print("index:\(s)")
                    //print("page:\(p)")
                    //print("elem:\(value)")
                    
                    //如果不是該頁的或是不是沒選擇的就要做別頁的圖片來顯示元素
                    
                    var selElemPage = [[String:String]()]
                    var selImageName = String()
                    
                    if p != elemPage && p != -1{
                        
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
                        
                        
                        //抓名字
                        if let name = selElemPage[value]["name"] as String?{
                            
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
                        
                        
                        //延遲delay秒後顯示
                        
                        let when = DispatchTime.now() + delay
                        
                        DispatchQueue.main.asyncAfter(deadline: when) {[weak self] in
                            print("movedElem")
                            //固定元素在選項裡
                            self!.elems[value].frame.size = CGSize(width: 60, height: 60)
                            self!.elems[value].center = CGPoint(x: self!.selElemsCgs[s][0], y: self!.selElemsCgs[s][1])
                            
                        }
                        
                        
                    }
                    
                    
                }
                
                
            }
            
        }
        
        
    }
    
    
    @objc func dismissHintButton(){
        
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
        
        performSegue(withIdentifier: "toGame", sender: self)
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
                        var fontColorSuggest = UIColor()
                        
                        
                        //再做一個判斷怪屬性攻擊倍數的switch
                        switch monsterType{
                            
                        case "wood":
                            elementSuggest = "metal"
                            fontColorSuggest = .yellow
                            
                        case "earth":
                            
                            elementSuggest = "wood"
                            fontColorSuggest = .orange
                            
                        case "water":
                            
                            elementSuggest = "earth"
                            fontColorSuggest = .brown
                            
                        case "fire":
                            elementSuggest = "water"
                            fontColorSuggest = .blue
                            
                            
                        case "metal":
                            
                            elementSuggest = "fire"
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
            
            
            //顯示元素資訊
            if isElementTouchable{
                
                //跑所有元素
                for e in 0 ..< elems.count{
                    //有碰到元素的話
                    if elems[e].frame.contains(location){
                        print("some elems touched")
                        if elems[e].image != nil {
                            print("touched elems")
                            
                            //抓title
                            
                            let title = titleChinese[e]
                            elemTitleLabel.text = "Lv1 " + title
                            
                            //寵物圖片
                            
                            //先重置
                            elemInfoPetAva.image = UIImage()
                            
                            if title == "寵物碎片"{
                                //顯示寵物圖片
                                let imgName = infoToShow[e]["value"] as String?
                                elemInfoPetAva.image = makeImage(name: imgName!)
                            }
                            
                            
                            //抓能力值
                            let function = functionChinese[e]
                            
                            //讓爆擊率＋%
                            if function == "爆擊率" {
                                elemInfoLabel.text = function + " +\(values[e])%"
                            } else if title == "寵物碎片"{
                                elemInfoLabel.text = function
                                
                            } else {
                                
                                elemInfoLabel.text = function + " +\(values[e])"
                                
                            }
                            
                            //顯示元素照片
                            let elemAva = elems[e].image
                            elemInfoAva.image = elemAva
                            elemInfoBg.alpha = 0.8
                            
                            
                            
                            //確認e是否為occupied當中的index, 是的話把數字還原-1,讓其可以繼續填入其他元素
                            //解釋：確認所按到的元素是不是已經在使用當中的, 是的話就移除index
                            switch e {
                            case selOccupiedByElemIndex[0]:
                                selOccupiedByElemIndex[0] = -1
                                
                                elemSaved![0] = -1
                                
                                exactSelOccupiedByElemIndex[0] = [-1:-1]
                                exactElemSaved![0] = [-1:-1]
                                
                            case selOccupiedByElemIndex[1]:
                                selOccupiedByElemIndex[1] = -1
                                elemSaved![1] = -1
                                
                                exactSelOccupiedByElemIndex[1] = [-1:-1]
                                exactElemSaved![1] = [-1:-1]
                                
                            case selOccupiedByElemIndex[2]:
                                selOccupiedByElemIndex[2] = -1
                                elemSaved![2] = -1
                                
                                exactSelOccupiedByElemIndex[2] = [-1:-1]
                                exactElemSaved![2] = [-1:-1]
                                
                            default:
                                break
                            }
                            
                            //指定該元素的原始位置
                            originalPosition = elemCgPoints[e]
                            //移動
                            //elems[e].center = location
                            //指定該元素
                            
                            touchedElem = elems[e]
                            /*
                             if let exactName = infoToShow[e]["name"] as String?{
                             
                             for i in 0 ..< allGetElemsInfo.count{
                             
                             if let name = allGetElemsInfo[i]["name"] as String?{
                             if exactName == name {
                             
                             //指定該元素Index
                             currentElemIndex = i
                             
                             }
                             
                             
                             }
                             
                             
                             }
                             
                             
                             }
                             */
                            //指定該元素Index
                            currentElemIndex = e
                            exactCurrentElemIndex = [elemPage:e]
                            
                            //假如按兩次就回原位
                            //基本上只要有回原位就要計算寵物數值
                            if touch.tapCount == 2{
                                
                                touchedElem.frame.size = CGSize(width: 80, height: 80)
                                touchedElem.center = originalPosition
                                elemInfoBg.alpha = 0
                                
                                //計算寵物數值
                                calculatePetValue()
                                
                            }
                            UserDefaults.standard.set(elemSaved, forKey: "elemSaved")
                            // UserDefaults.standard.set(exactElemSaved,forKey: "exactElemSaved")
                            
                            
                            let userDefaults = UserDefaults.standard
                            let encodedObject = NSKeyedArchiver.archivedData(withRootObject: exactElemSaved!)
                            userDefaults.set(encodedObject, forKey: "exactElemSaved")
                            userDefaults.synchronize()
                            
                        }
                    }
                    
                }
            }
        }
        
        
        for s in selElems{
            
            if s.frame.contains(location){
                
                print("selElems touched")
            }
            
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            location = touch.location(in: self.view)
            //移動元素
            touchedElem.center = location
            
        }
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            location = touch.location(in: self.view)
            
            //Part 1. 首先先讓元素回原位
            touchedElem.frame.size = CGSize(width: 80, height: 80)
            touchedElem.center = originalPosition
            
            //放掉手指就不顯示info
            elemInfoBg.alpha = 0
            
            //計算寵物數值
            calculatePetValue()
            
            //Part 2. 下方假如元素有碰到選項, 就移至選項位置
            
            if touch.tapCount < 2{
                
                //跑所有的選項元素
                for s in 0 ..< selElems.count{
                    
                    //假如碰到了其中之一
                    if selElems[s].frame.contains(location){
                        
                        //***假如選項上有元素的話才啟動以下改變及計分機制***
                        if touchedElem.image != nil{
                            
                            //先檢查有沒有任何元素
                            if selOccupiedByElemIndex[s] != -1 {
                                
                                //之前的元素回原位
                                let preElem = elems[selOccupiedByElemIndex[s]]
                                preElem.frame.size = CGSize(width: 80, height: 80)
                                preElem.center = elemCgPoints[selOccupiedByElemIndex[s]]
                                
                                //要回到-1
                                selOccupiedByElemIndex[s] = -1
                                elemSaved![s] = -1
                                
                                exactSelOccupiedByElemIndex[s] = [-1:-1]
                                exactElemSaved![s] = [-1:-1]
                            }
                            //沒有的話固定元素在選項裡
                            touchedElem.frame.size = CGSize(width: 60, height: 60)
                            touchedElem.center = CGPoint(x: selElemsCgs[s][0], y: selElemsCgs[s][1])
                            
                            //因為有碰到所以設定數字
                            
                            selOccupiedByElemIndex[s] = currentElemIndex
                            exactSelOccupiedByElemIndex[s] = exactCurrentElemIndex
                            
                            elemSaved![s] = currentElemIndex
                            exactElemSaved![s] = exactCurrentElemIndex
                            
                            //計算寵物數值
                            calculatePetValue()
                            
                        }
                    }
                    
                    UserDefaults.standard.set(elemSaved, forKey: "elemSaved")
                    //UserDefaults.standard.set(exactElemSaved,forKey: "exactElemSaved")
                    
                    let userDefaults = UserDefaults.standard
                    let encodedObject = NSKeyedArchiver.archivedData(withRootObject: exactElemSaved!)
                    userDefaults.set(encodedObject, forKey: "exactElemSaved")
                    userDefaults.synchronize()
                }
                
            }
            
            //初始化剛指定的element
            touchedElem = UIImageView()
        }
    }
    
    //抓取元素資訊
    func fetchElementInfo(){
        
        //準備元素資訊供顯示
        for i in 0 ..< infoToShow.count{
            
            if let functions = infoToShow[i]["func"] as String?{
                
                if !functions.contains(","){
                    
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
                    
                    //還需要寫分析多元素的功能
                    
                    functionChinese.append("")
                    
                }
            }
            
            //新增數值供info顯示
            if let value = infoToShow[i]["value"] as String?{
                values.append(value)
                
            }
            
        }
        
    }
    
    //計算寵物數值的func
    func calculatePetValue(){
        
        /*
         
         print(selOccupiedByElemIndex)
         print(exactSelOccupiedByElemIndex)
         //抓數值, 之後這個數值要從一個可以固定及升級改數值的地方抓數字過來.
         //寵物資訊重置
         //pet = ["petLife":100,"petAttack":40,"petDefense":10,"petDoubleAttack":20,"petExtraAttack":0,"petHeal":0,"petType":""]
         pet = petOriginal
         print("petOriginal:\(petOriginal)")
         
         let petHpValue = pet!["petHp"] as! Int
         let petAttValue = pet!["petAtt"] as! Int
         let petDefValue = pet!["petDef"] as! Int
         let petHealValue = pet!["petHeal"] as! Int
         //let petTypeValue = pet!["petType"] as! String
         let petHitValue = pet!["petHit"] as! Int
         let petMagValue = pet!["petMag"] as! Int
         
         /*
         let petCure = pet?["petHeal"] as! Int
         let petLife = pet?["petLife"] as! Int
         let petAttack = pet?["petAttack"] as! Int
         let petDefense = pet?["petDefense"] as! Int
         let petDouble = pet?["petDoubleAttack"] as! Int
         let petExtra = pet?["petExtraAttack"] as! Int
         */
         petCureLabel.text = String(describing: petHealValue)
         petLifeLabel.text = String(describing: petHpValue)
         petAttackLabel.text = String(describing: petAttValue)
         petDefenseLabel.text = String(describing: petDefValue)
         petDoubleAttackLabel.text = String(describing: petHitValue) + "%"
         petExtraAttackLabel.text = String(describing: petMagValue)
         
         //顏色先重置白色
         petLifeLabel.textColor = .white
         petAttackLabel.textColor = .white
         petDefenseLabel.textColor = .white
         petExtraAttackLabel.textColor = .white
         petDoubleAttackLabel.textColor = .white
         petCureLabel.textColor = .white
         petTypeImg.image = UIImage()
         
         
         // 機制: 這裡的數字不改, 每一次都check selOccupied有沒有任何值會影響
         
         
         /*
         for p in 0 ..< elemPages.count{
         
         for s in 0 ..< exactSelOccupiedByElemIndex.count{
         
         if let value = exactSelOccupiedByElemIndex[s][elemPages[p]]{
         
         print("index:\(s)")
         print("page:\(p)")
         print("elem:\(value)")
         
         
         }
         
         
         
         }
         
         
         
         }
         */
         //抓數字
         for s in 0 ..< selOccupiedByElemIndex.count{
         
         //加數值上去
         if selOccupiedByElemIndex[s] > -1 {
         
         let index = selOccupiedByElemIndex[s]
         let selElem = infoToShow[index]
         
         if let function = selElem["func"] as String?{
         
         switch function{
         
         case "hp":
         
         petLifeLabel.textColor = .green
         petLifeLabel.text = String(petHpValue + Int(selElem["value"]!)!)
         pet?["petHp"] = Int(petHpValue + Int(selElem["value"]!)!)
         
         
         case "att":
         petAttackLabel.textColor = .green
         petAttackLabel.text = String(petAttValue + Int(selElem["value"]!)!)
         pet?["petAtt"] = Int(petAttValue + Int(selElem["value"]!)!)
         
         case "def":
         petDefenseLabel.textColor = .green
         petDefenseLabel.text = String(petDefValue + Int(selElem["value"]!)!)
         pet?["petDef"] = Int(petDefValue + Int(selElem["value"]!)!)
         
         
         case "hit":
         petDoubleAttackLabel.textColor = .green
         petDoubleAttackLabel.text = String(petHitValue + Int(selElem["value"]!)!) + "%"
         pet?["petHit"] = Int(petHitValue + Int(selElem["value"]!)!)
         
         
         case "heal":
         petCureLabel.textColor = .green
         petCureLabel.text = String(petHealValue + Int(selElem["value"]!)!)
         pet?["petHeal"] = Int(petHealValue + Int(selElem["value"]!)!)
         
         case "wood":
         
         petExtraAttackLabel.textColor = .green
         petExtraAttackLabel.text = String(petMagValue + Int(selElem["value"]!)!)
         pet?["petMag"] = Int(petMagValue + Int(selElem["value"]!)!)
         
         pet?["petType"] = "wood"
         
         petTypeImg.image = UIImage(named: "wood.png")
         
         
         case "earth":
         
         petExtraAttackLabel.textColor = .green
         petExtraAttackLabel.text = String(petMagValue + Int(selElem["value"]!)!)
         pet?["petMag"] = Int(petMagValue + Int(selElem["value"]!)!)
         pet?["petType"] = "earth"
         
         petTypeImg.image = UIImage(named: "earth.png")
         
         
         case "water":
         
         
         petExtraAttackLabel.textColor = .green
         petExtraAttackLabel.text = String(petMagValue + Int(selElem["value"]!)!)
         pet?["petMag"] = Int(petMagValue + Int(selElem["value"]!)!)
         pet?["petType"] = "water"
         
         petTypeImg.image = UIImage(named: "water.png")
         
         case "fire":
         
         
         
         petExtraAttackLabel.textColor = .green
         petExtraAttackLabel.text = String(petMagValue + Int(selElem["value"]!)!)
         pet?["petMag"] = Int(petMagValue + Int(selElem["value"]!)!)
         pet?["petType"] = "fire"
         petTypeImg.image = UIImage(named: "fire.png")
         
         
         case "metal":
         
         
         petExtraAttackLabel.textColor = .green
         petExtraAttackLabel.text = String(petMagValue + Int(selElem["value"]!)!)
         pet?["petMag"] = Int(petMagValue + Int(selElem["value"]!)!)
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
    
    @IBAction func backToMapClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}

/*
 //做選項裡的圖, 包含p0及非p0
 //跑每一頁, 用意在於要確認每組第一個值為頁數, 然後抓取他們的value
 for p in 0 ..< elemPages.count{
 
 //跑儲存的數字
 for s in 0 ..< exactElemSaved!.count{
 
 //
 //抓頁面元素
 if let value = exactElemSaved![s][elemPages[p]]{
 
 //以下留著做參考
 //print("index:\(s)")
 //print("page:\(p)")
 //print("elem:\(value)")
 
 //如果不是第一頁的或是不是沒選擇的就要做別頁的圖片來顯示元素
 if p != 0 && p != -1{
 
 //找出正確的頁面以及元素圖片
 
 var selElemPage = [[String:String]()]
 var selImageName = String()
 
 switch p {
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
 
 //抓名字
 if let name = selElemPage[value]["name"] as String?{
 
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
 
 //做出該選項元素的圖片
 selElems[s].image = makeImage(name: selImageName)
 
 
 //假設是第一頁的元素就要把elem放到正確位置
 } else if p == 0{
 
 //延遲0.1秒後顯示
 
 let when = DispatchTime.now() + 0.1
 
 DispatchQueue.main.asyncAfter(deadline: when) {[weak self] in
 
 //固定元素在選項裡
 self!.elems[value].frame.size = CGSize(width: 60, height: 60)
 self!.elems[value].center = CGPoint(x: self!.selElemsCgs[s][0], y: self!.selElemsCgs[s][1])
 
 }
 
 
 }
 
 
 }
 
 
 }
 
 }
 */
//製作顯示元素的字母+數字+圖片

/*
 //作圖片的底, 第一頁預設為normalGem
 elemImg = "normalGem"
 
 if normalElems.count > 0 {
 
 //指定好會出現的類型是normalElems, 提供做資訊使用
 infoToShow = normalElems
 
 for i in 0 ..< normalElems.count{
 
 //找出名字
 if let name = normalElems[i]["name"] as String?{
 
 //全部都做normalGem
 elems[i].image = makeImage(name: elemImg)
 
 //抓字母 + 數字
 elemName = name.components(separatedBy: .decimalDigits)
 elemNum = name.replacingOccurrences(of: elemName![0], with: "")
 
 //做字母的label
 let elemNameLabel = UILabel()
 
 elemNameLabel.frame = CGRect(x: elems[i].frame.width / 5, y:
 elems[i].frame.height / 3, width: 45, height: 25)
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
 */


