//
//  GameScene.swift
//  wordDrug
//
//  Created by Ethan on 2017/10/18.
//  Copyright © 2017年 playplay. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //node按鈕位置
    var location = CGPoint()
    
    //特殊顏色
    let pinkColor = UIColor.init(red: 240/255, green: 31/255, blue: 249/255, alpha: 1)
    let lightBlue = UIColor.init(red: 151/255, green: 224/255, blue: 255/255, alpha: 1)
    let coverPurple = UIColor.init(red: 98/255, green: 44/255, blue: 85/255, alpha: 1)
    let lightPinkColor = UIColor.init(red: 251/255, green: 154/255, blue: 255/255, alpha: 1)
    let tiffanyColor = UIColor.init(red: 9/255, green: 255/255, blue: 218/255, alpha: 1)
    let diamondGreen = UIColor.init(red: 0/255, green: 215/255, blue: 58/255, alpha: 1)
    let darkYellow = UIColor.init(red: 1, green: 156/255, blue: 0, alpha:1)
    let specialPink = UIColor.init(red: 240/255, green: 150/255, blue: 149/255, alpha: 1)
    
    //暫時使用的單字
    var wordSets = [String]()
    
    //此元素頁面裡所有的音節
    var syllables = [String]()
    
    //一張地圖裡的所有音節
    //音節
    /*
    let syllableSets = [["ab1","ac1","ad1","a_e1","af1","ai1","al1","am1","an1","any1"],["ap1","ar1","as1","at1","au1","aw1","ay1","ba1","be1","bi1"],["bit1","bl1","bo1","br1","bu1","by1","ce1","ch1","ci1","ble1"],["ck1","cl1","co1","com1","con1","cian1","cr1","ct1","de1","di1"],["do1","dr1","dy1","dis1","ea1","ee1","el1","em1","en1","er1"],["et1","ew1","ex1","ey1","fi1","fl1","fo1","fr1","ft1","ful1"],["ge1","gi1","gl1","go1","gr1","he1","hi1","id1","ie1","igh1"],["il1","im1","in1","ing1","ir1","is1","ject1","kn1","le1","li1"],["ly1","mi1","nd1","no1","nt1","oa1","ob1","oe1","of1","oi1"],["old1","on1","ong1","oo1","op1","or1","ot1","ou1","ow1","oy1"],["ph1","pi1","pl1","pr1","rare1","re1","ro1","ry1","sh1","si1"],["sk1","so1","sp1","st1","sion1","th1","ti1","tion1","tive1","tle1"],["to1","tr1","ture1","ty1","ub1","ue1","ui1","um1","un1","up1"],["ur1","ut1","war1","wh1","ab2","ac2","ad2","a_e2","af2","ai2"]]
    */
    
        let partOnePets:[[String:Any]] = [["petId":"1-1-0","petName":"幼龍","petHp":110,"petAtt":40,"petDef":10,"petHit":20,"petHeal":0,"petType":"","petImg":"1-1-0","petMag":0], ["petId":"1-1-10","petName":"球球","petHp":120,"petAtt":50,"petDef":15,"petHit":25,"petHeal":0,"petType":"","petImg":"1-1-10","petMag":0], ["petId":"1-2-10","petName":"螳螂拳","petHp":130,"petAtt":60,"petDef":15,"petHit":15,"petHeal":0,"petType":"","petImg":"1-2-10","petMag":0],["petId":"1-3-10","petName":"蘑菇怪","petHp":165,"petAtt":60,"petDef":15,"petHit":23,"petHeal":0,"petType":"","petImg":"1-3-10","petMag":0], ["petId":"1-4-10","petName":"劇毒狼","petHp":140,"petAtt":70,"petDef":20,"petHit":25,"petHeal":0,"petType":"","petImg":"1-4-10","petMag":0], ["petId":"1-6-10","petName":"銀翼飛馬","petHp":150,"petAtt":70,"petDef":20,"petHit":20,"petHeal":0,"petType":"","petImg":"1-6-10","petMag":0], ["petId":"1-7-10","petName":"恐龍博士","petHp":180,"petAtt":75,"petDef":22.5,"petHit":28,"petHeal":0,"petType":"","petImg":"1-7-10","petMag":0], ["petId":"1-8-10","petName":"冰雪犀牛","petHp":160,"petAtt":80,"petDef":25,"petHit":25,"petHeal":0,"petType":"","petImg":"1-8-10","petMag":0], ["petId":"1-9-10","petName":"美洲豹","petHp":195,"petAtt":90,"petDef":22.5,"petHit":18,"petHeal":0,"petType":"","petImg":"1-9-10","petMag":0], ["petId":"1-11-10","petName":"治癒菇神","petHp":170,"petAtt":90,"petDef":25,"petHit":20,"petHeal":0,"petType":"","petImg":"1-11-10","petMag":0], ["petId":"1-12-10","petName":"眼鏡蛇王","petHp":180,"petAtt":100,"petDef":30,"petHit":15,"petHeal":0,"petType":"","petImg":"1-12-10","petMag":0], ["petId":"1-13-10","petName":"被感染的劇毒狼","petHp":210,"petAtt":105,"petDef":30,"petHit":28,"petHeal":0,"petType":"","petImg":"1-13-10","petMag":0]]
    
    /*
    let syllableSets = [["ab1","ac1","ad1","a_e1","af1","ai1","al1","am1","an1","any1"],["ap1","ar1","as1","at1","au1","aw1","ay1","ba1","be1","bi1"],["bit1","bl1","bo1","br1","bu1","by1","ce1","ch1","ci1","ble1"],["ck1","cl1","co1","com1","con1","cian1","cr1","ct1","de1","di1"],["do1","dr1","dy1","dis1","ea1","ee1","el1","em1","en1","er1"],["et1","ew1","ex1","ey1","fi1","fl1","fo1","fr1","ft1","ful1"],["ge1","gi1","gl1","go1","gr1","he1","hi1","id1","ie1","igh1"],["il1","im1","in1","ing1","ir1","is1","ject1","kn1","le1","li1"],["ly1","mi1","nd1","no1","nt1","oa1","ob1","o_e1","of1","oi1"],["old1","on1","ong1","oo1","op1","or1","ot1","ou1","ow1","oy1"],["ph1","pi1","pl1","pr1","rare1","re1","ro1","ry1","sh1","si1"],["sk1","so1","sp1","st1","sion1","th1","ti1","tion1","tive1","tle1"],["to1","tr1","ture1","ty1","ub1","u_e1","ui1","um1","un1","up1"],["ur1","ut1","war1","wh1","ab2","ac2","ad2","a_e2","af2","ai2"]]
    */
    
    
    let syllableSets = [["ab1","ac1","ad1","a_e1","af1","ai1","al1","am1","an1","any1"],
    ["ap1","ar1","as1","at1","au1","aw1","ay1","ba1","be1","bi1"],
    ["bit1","bl1","bo1","br1","bu1","by1","ce1","ch1","ci1","ble1"],
    ["ck1","cl1","co1","com1","con1","cian1","cr1","ct1","de1","di1"],
    ["do1","dr1","dy1","dis1","ea1","ee1","el1","em1","en1","er1"],
    ["et1","ew1","ex1","ey1","fi1","fl1","fo1","fr1","ft1","ful1"],
    ["ge1","gi1","gl1","go1","gr1","he1","hi1","id1","ie1","igh1"],
    ["il1","im1","in1","ing1","ir1","is1","ject1","kn1","le1","li1"],
    ["ly1","mi1","nd1","no1","nt1","oa1","ob1","o_e1","of1","oi1"],
    ["old1","on1","ong1","oo1","op1","or1","ot1","ou1","ow1","oy1"],
    ["ph1","pi1","pl1","pr1","cop1","re1","ro1","ry1","sh1","si1"],
    ["sk1","so1","sp1","st1","sion1","th1","ti1","tion1","tive1","tle1"],
    ["to1","tr1","ture1","ty1","ub1","u_e1","ui1","um1","un1","up1"],
    ["ur1","ut1","war1","wh1","ab2","ac2","ad2","a_e2","af2","ai2"]]
    
    
    var syllablesToCheck = String()
    
    var syllablesWithoutDigit = String()
    
    //母音
    let vowels = ["a","e","i","o","u"]
    
    //是否是_e音節
    var isSpecialE = false
    
    //做名字供下方使用
    var syllableWordName = String()
    
    //做名字給上方的第一個字母用
    var normalSyllableName = String()
    
    //_e使用
    var characters = [Character]()
    
    //下一個顯示單字的順序
    var nextWordSequence = Int()
    
    //目前單字的順位
    var currentWordSequence = 0
    
    //發音單字
    var wordsToPronounce = String()
    
    //避免重複發音
    var isScanning = true
    
    //選項單字
    var shownWords = [String]()
    
    //已經正確輸入的音節數
    var alreadyCorrectsyllables = 0
    //輸入的答案
    var wordEntered = [String]()
    //正確的答案
    var currentWordArray = [String]()
    
    //是否能作答
    var isDragAndPlayEnable = false
    
    //是否能按功能button
    var isButtonEnable = false
    
    //autoPlay使用變數
    var isPracticeMode = false
    var playSoundTime = 0
    var correctTime = 0
    
    //battleMode變數
    var isBattleMode = false
    //確認贏幾次來算combo
    var battleComboTime = 0
    
    //確認回合是否結束, 暫時用不到
    var isRoundEnd = false
    
    //動態怪物及玩家血
    var monsterBlood = CGFloat()
    var playerBlood = CGFloat()
    
    //怪物及玩家滿血
    var fullMonsterBlood = CGFloat()
    var fullPlayerBlood = CGFloat()
    
    //答案正確時的自我爆炸特效
    var explodeEmitter:SKEmitterNode?
    
    //怪物攻擊Emiiter特效
    var monsterExplode:SKEmitterNode?
    var monsterAttack:SKEmitterNode?
    
    //治癒效果
    var healEffect:SKEmitterNode?
    
    //怪物變數
    //var monsters = ["flatMonster1","flatMonster2","flatMonster3"]
    //輪流順序
    var monsterSequence = 0
    /*
     var monsters = [["id":101,"name":"毛毛蟲"],["id":201,"name":"蘑菇怪"],["id":301,"name":"球球"],["id":401,"name":"史帝奇"],["id":501,"name":"青螳螂"],["id":601,"name":"被污染的鹿"],["id":701,"name":"田鼠"],["id":801,"name":"涡蝙蝠"],["id":901,"name":"鬍狗"],["id":1001,"name":"鋼牙鯊"],["id":1101,"name":"偵查哥八犬"],["id":1201,"name":"變異鹿"],["id":1301,"name":"眼鏡蛇"],["id":1401,"name":"三頭地獄犬"],["id":1501,"name":"獨眼觸手"],["id":1601,"name":"荊棘豬"],["id":1701,"name":"長毛犀牛"],["id":1801,"name":"王者翼獸"],["id":1901,"name":"巨爪虎"],["id":2001,"name":"海蛇王"],["id":2101,"name":"水晶蠍"],["id":2201,"name":"幽靈劍齒虎"],["id":2301,"name":"飛行焰馬"],["id":2401,"name":"恐龍"],["id":2501,"name":"老樹精"],["id":2601,"name":"污染的惡狼"],["id":2701,"name":"變異蜥蜴"],["id":2801,"name":"恐龍博士"],["id":2901,"name":"獅龍獸"],["id":3001,"name":"尖齒龍"],["id":3101,"name":"元素熊"],["id":3201,"name":"狐狸人"],["id":3301,"name":"咕魯"],["id":3401,"name":"食屍鬼"],["id":3501,"name":"泰坦星人"],["id":3601,"name":"納瑟斯"],["id":3701,"name":"翰墨丁格"],["id":3801,"name":"小小"],["id":3901,"name":"菲斯"],["id":4001,"name":"梅杜莎"],["id":4101,"name":"骷顱王"],["id":4201,"name":"死亡之握"]]
     */
    
    /*
    var monsters = [["id":101,"name":"毛毛蟲","hp":100,"att":35,"def":10,"magic":0,"type":"wood"],
                    ["id":201,"name":"蘑菇怪","hp":100,"att":40,"def":10,"magic":0,"type":"earth"],
                    ["id":301,"name":"球球","hp":100,"att":40,"def":10,"magic":0,"type":"water"],
                    ["id":401,"name":"史帝奇","hp":150,"att":50,"def":15,"magic":0,"type":"fire"],
                    ["id":501,"name":"青螳螂","hp":150,"att":50,"def":15,"magic":0,"type":"metal"],
                    ["id":601,"name":"被污染的鹿","hp":150,"att":50,"def":15,"magic":0,"type":"wood"],
                    ["id":701,"name":"田鼠","hp":200,"att":60,"def":20,"magic":0,"type":"earth"],
                    ["id":801,"name":"涡蝙蝠","hp":200,"att":60,"def":20,"magic":0,"type":"water"],
                    ["id":901,"name":"鬍狗","hp":200,"att":60,"def":20,"magic":0,"type":"fire"],
                    ["id":1001,"name":"鋼牙鯊","hp":300,"att":70,"def":30,"magic":10,"type":"metal"]]
    */
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
    
    //測試用的假元素
    /*
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
    
    var monsterHp = Int()
    var monsterAtt = Int()
    var monsterDef = Int()
    var monsterMagic = Int()
    var monsterType = String()
    var monsterImg = String()
    
    //dragAndPlay需要變數
    //線條
    var line:SKShapeNode?
    
    //路徑
    var path:CGMutablePath = CGMutablePath()
    
    //第一點
    var firstTouch = CGPoint()
    
    //未確認的點
    var movingTouch = CGPoint()
    
    //確認點
    var fixedSecondTouch = CGPoint()
    var fixedThirdTouch = CGPoint()
    var fixedFourthTouch = CGPoint()
    var fixedFifthTouch = CGPoint()
    
    //紀錄已經按到的node
    var nodesTouched = [SKSpriteNode]()
    
    //紀錄按到了幾次node
    var touchTimes = 0
    
    //是否是按第一下
    var isFirstTouch = false
    //有沒有按畫面
    var isTouched = false
    //結束有沒有在node上
    var isEndOnNode = false
    //node有沒有移除
    var isRemoved = false
    
    //所有node的名稱
    var selNodeNames = ["se0","se1","se2","se3","se4"]
    
    //被設定好的頁數
    var spotNumber = Int()
    var unitNumber = Int()
    
    var petLife = Int()
    var petAttack = Int()
    var petDefense = Float()
    var petHeal = Int()
    var petExtra = Int()
    var petDouble = Int()
    var petType = String()
    
    //準備傳給NC的頁碼
    var elemPageToPass = Int()
    var segIndexToPass = Int()
    var typeSegToPass = Int()
    
    //合併升級寵物使用
    var upgradeCount = Int()
    var isUpgrade = false
    var upgradeNames = [String]()
    var upgradeValue = String()
    
    //中文字左右對錯
    var leftOrRight = Int()
    let leftChiNode = SKLabelNode()
    let rightChiNode = SKLabelNode()
    
    //紀錄第一個sequence
    var firstSequence = Int()
    
    //紀錄單字有沒有加入最愛
    var wordsLoved = [0,0,0]
   
    override func didMove(to view: SKView) {
        
        print("petValue:\(pet)")
        
        //元素單位練習完後的key
        NotificationCenter.default.addObserver(self, selector: #selector(GameScene.notifyEndUnit), name: NSNotification.Name("endUnit"), object: nil)
        
        //要通知刪除元素的key
        NotificationCenter.default.addObserver(self, selector: #selector(GameScene.notifyBackToBackpack), name: NSNotification.Name("backToBackpack"), object: nil)

        
        //抓正確unit
        currentWordSequence = 3 * unitNumber
        firstSequence = currentWordSequence
        
        //抓正確的音節
        syllables = syllableSets[spotNumber]
        
        //建立整個背景
        makeImageNode(name: "bg", image: "newBg", x: 0, y: 0, width: 750, height: 1334, z: 0, alpha: 1, isAnchoring: false)
        
        //建立任務版子
        makeImageNode(name: "questBoard", image: "testQuestBoardDark", x: 0, y: 380, width: 610, height: 0, z: 1, alpha: 1, isAnchoring: false)
        
        //建立任務標題
        makeLabelNode(x: -100, y:500, alignMent: .left, fontColor: .white, fontSize: 50, text: "", zPosition: 2, name: "questTitle", fontName: "Helvetica Bold", isHidden: false, alpha:1)
        
        //任務板子動畫 + 標題動畫
        openQuest()
        
        //建立怪物畫面背景
        // makeImageNode(name: "screenBg", image: "screenBg", x: 0, y: 500, width: 750, height: 431, z: 1, alpha: 1, isAnchoring: false)
        
        //建立開啟按鈕
        makeNode(name: "button", color: .clear, x: 0, y: -575, width: 150, height: 150, z: 2, isAnchoring: false, alpha: 1)
        
        //讀取Bundle裡的文字檔
        var wordFile:String?
        
        let name = "1-" + String(spotNumber + 1)
        
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
        
        //製作按鈕
        let lightWidth:CGFloat = 170
        let lightHeight:CGFloat = 168
        let darkWidth:CGFloat = 155
        let darkHeight:CGFloat = 155
        let positions = [[-160,-360],[-260,-80],[160,-360],[260,-80],[0,110]]
        
        //選項按鈕
        
        makeNode(name: "se0", color: .clear, x:CGFloat(positions[0][0]) , y: CGFloat(positions[0][1]), width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se1", color: .clear, x:CGFloat(positions[1][0]) , y: CGFloat(positions[1][1]), width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se2", color: .clear, x:CGFloat(positions[2][0]) , y: CGFloat(positions[2][1]), width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se3", color: .clear, x:CGFloat(positions[3][0]) , y: CGFloat(positions[3][1]), width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se4", color: .clear, x:CGFloat(positions[4][0]) , y: CGFloat(positions[4][1]), width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        
        //填滿按鈕
        
        makeImageNode(name: "0filledButton", image: "lightD", x:CGFloat(positions[0][0]) , y: CGFloat(positions[0][1]), width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "1filledButton", image: "lightD", x:CGFloat(positions[1][0]), y: CGFloat(positions[1][1]), width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "2filledButton", image: "lightD", x:CGFloat(positions[2][0]) , y: CGFloat(positions[2][1]), width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "3filledButton", image: "lightD", x:CGFloat(positions[3][0]) , y: CGFloat(positions[3][1]), width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "4filledButton", image: "lightD", x:CGFloat(positions[4][0]) , y: CGFloat(positions[4][1]), width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        
        
        //空的按鈕
        makeImageNode(name: "0emptyButton", image: "darkerD", x:CGFloat(positions[0][0]) , y: CGFloat(positions[0][1]), width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "1emptyButton", image: "darkerD", x:CGFloat(positions[1][0]) , y: CGFloat(positions[1][1]), width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "2emptyButton", image: "darkerD", x:CGFloat(positions[2][0]) , y: CGFloat(positions[2][1]), width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "3emptyButton", image: "darkerD", x:CGFloat(positions[3][0]) , y: CGFloat(positions[3][1]), width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "4emptyButton", image: "darkerD", x:CGFloat(positions[4][0]) , y: CGFloat(positions[4][1]), width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "leftChiBtn", image: "blueOrb", x: -160, y: -330, width: 250, height: 250, z: 7, alpha: 0, isAnchoring: false)
        makeImageNode(name: "rightChiBtn", image: "redOrb", x: 160, y: -330, width: 250, height: 250, z: 7, alpha: 0, isAnchoring: false)
    
        leftChiNode.position = CGPoint(x: 0, y: -10)
        leftChiNode.horizontalAlignmentMode = .center
        leftChiNode.fontSize = 34
        leftChiNode.fontColor = .white
        leftChiNode.zPosition = 8
        leftChiNode.name = "leftChi"
        leftChiNode.fontName = "Helvetica Bold"
     
        findImageNode(name: "leftChiBtn").addChild(leftChiNode)
        
       
        rightChiNode.position = CGPoint(x: 0, y: -10)
        rightChiNode.horizontalAlignmentMode = .center
        rightChiNode.fontSize = 34
        rightChiNode.fontColor = .white
        rightChiNode.zPosition = 8
        rightChiNode.name = "rightChi"
        rightChiNode.fontName = "Helvetica Bold"
        
        findImageNode(name: "rightChiBtn").addChild(rightChiNode)
        
        
        //建立三黑點+亮點, 並hidden
        /*
        makeImageNode(name: "bDot1", image: "bDot1", x: -70, y: -600, width: 60, height: 30, z: 2, alpha: 0, isAnchoring: false)
        makeImageNode(name: "bDot2", image: "bDot2", x: 0, y: -600, width: 60, height: 30, z: 2, alpha: 0, isAnchoring: false)
        makeImageNode(name: "bDot3", image: "bDot3", x: 70, y: -600, width: 60, height: 30, z: 2, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "lDot1", image: "lDot1", x: -70, y: -600, width: 105, height: 70, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "lDot2", image: "lDot2", x: 0, y: -600, width: 105, height: 70, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "lDot3", image: "lDot3", x: 70, y: -600, width: 105, height: 70, z: 3, alpha: 0, isAnchoring: false)
        */
        //避免多次按
        self.view?.isMultipleTouchEnabled = false
        
        
        
        //自我爆炸explode
        explodeEmitter = SKEmitterNode(fileNamed: "explode.sks")
        explodeEmitter?.position = CGPoint(x: 0, y: -150)
        explodeEmitter?.zPosition = 4
        explodeEmitter?.name = "explodeEmitter"
        explodeEmitter?.isHidden = true
        addChild(explodeEmitter!)
        
        //怪物爆炸
        monsterExplode = SKEmitterNode(fileNamed: "monsterExplode.sks")
        monsterExplode?.position = CGPoint(x: 0, y: 455)
        monsterExplode?.zPosition = 4
        monsterExplode?.name = "mExplode"
        monsterExplode?.isHidden = true
        addChild(monsterExplode!)
        
        //怪物攻擊
        monsterAttack = SKEmitterNode(fileNamed: "monsterAttack.sks")
        monsterAttack?.position = CGPoint(x: 0, y: -50)
        monsterAttack?.zPosition = 4
        monsterAttack?.name = "mAttack"
        monsterAttack?.isHidden = true
        addChild(monsterAttack!)
        
        //治癒效果
        healEffect = SKEmitterNode(fileNamed: "healEffect.sks")
        healEffect?.position = CGPoint(x: 0, y: -470)
        healEffect?.zPosition = 4
        healEffect?.name = "healEffect"
        healEffect?.isHidden = true
        addChild(healEffect!)
        
        //連擊Label
        makeLabelNode(x: 0, y: 100, alignMent: .center, fontColor: .white, fontSize: 70, text: "Combo Attack", zPosition: 5, name: "comboAttack", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        //抓寵物資訊
        petLife = pet?["petHp"] as! Int
        petAttack = pet?["petAtt"] as! Int
        if let petDefDouble = pet?["petDef"] as? Double{
            
            petDefense = Float(petDefDouble)
            
        } else if let petDefInt = pet?["petDef"] as? Int{
            
            petDefense = Float(petDefInt)
        }
       
        petDouble = pet?["petHit"] as! Int
        petExtra = pet?["petMag"] as! Int
        petHeal = pet?["petHeal"] as! Int
        petType = pet?["petType"] as! String
        
        
        //製作寵物畫面
        let petImg = pet!["petImg"] as! String
        let petName = pet!["petName"] as! String

        makeImageNode(name: "petAva", image: petImg, x: -190, y: -480, width: 120, height: 120, z: 2, alpha: 1, isAnchoring: false)
        makeLabelNode(x: -80, y: -480, alignMent: .left, fontColor: .white, fontSize: 35, text: petName, zPosition: 2, name: "petName", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        makeLabelNode(x: -200, y: -565, alignMent: .left, fontColor: .white, fontSize: 25, text: "生命值 \(petLife)", zPosition: 1, name: "petLife", fontName: "Helvetica", isHidden: false, alpha: 1)
        makeLabelNode(x: -200, y: -605, alignMent: .left, fontColor: .white, fontSize: 25, text: "攻擊力 \(petAttack)", zPosition: 1, name: "petAttack", fontName: "Helvetica", isHidden: false, alpha: 1)
        makeLabelNode(x: -50, y: -565, alignMent: .left, fontColor: .white, fontSize: 25, text: "魔攻 \(petExtra)", zPosition: 1, name: "petMag", fontName: "Helvetica", isHidden: false, alpha: 1)
        makeLabelNode(x: -50, y: -605, alignMent: .left, fontColor: .white, fontSize: 25, text: "防禦 \(petDefense)", zPosition: 1, name: "petDef", fontName: "Helvetica", isHidden: false, alpha: 1)
        makeLabelNode(x: 100, y: -565, alignMent: .left, fontColor: .white, fontSize: 25, text: "爆擊 \(petDouble)%", zPosition: 1, name: "petHit", fontName: "Helvetica", isHidden: false, alpha: 1)
        makeLabelNode(x: 100, y: -605, alignMent: .left, fontColor: .white, fontSize: 25, text: "治癒 \(petHeal)", zPosition: 1, name: "petHeal", fontName: "Helvetica", isHidden: false, alpha: 1)
        if petType != ""{
        makeImageNode(name: "petType", image: petType, x: 200, y: -470, width: 50, height: 50, z: 2, alpha: 1, isAnchoring: false)
        }
        print("petType:\(petType)")
    }
    
    //拉開任務＋連結開始學習
    func openQuest(){
        //拉開任務板子的action
        let questBoardAction = SKAction.resize(toHeight: 359, duration: 0.3)
        
        //拉開任務 ＋ 開始學習階段
        findImageNode(name: "questBoard").run(questBoardAction) {[weak self] in
            
            let action = self!.typingAction(text: "loading", nodeName: "questTitle", finalText: "Quest")
            self!.run(action, completion: {[weak self] in
                
                //開始學習階段, 也是產生學習單字的func
                self!.startLearning()
                
                //可以按畫面
                self?.isUserInteractionEnabled = true
                //可以按button
                self!.isButtonEnable = true
                
            })
            
        }
        
    }
    
    //學習階段, 也是產生學習單字的func
    func startLearning(){
        
        //找目前sequence的英文+中文字
        let quarterCount = wordSets.count / 4
        let engWord = wordSets[currentWordSequence]
        let chiWord = wordSets[quarterCount +  currentWordSequence]
        
        //製作中英文字
        makeWords(word: engWord, lang: "engWord")
        makeWords(word: chiWord, lang: "chiWord")
        
        //字fade in
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        for node in children{
            
            if (node.name?.contains("Word"))!{
                
                node.run(fadeIn, completion: {[weak self] in
                    
                    if (node.name?.contains("chiWord"))!{
                        
                        //中文字產生完之後, 就產生掃描線及發音
                        self!.scanAndPronounce()
                        
                        //產生黑點點
                        /*
                        self!.findImageNode(name: "bDot1").alpha = 1
                        self!.findImageNode(name: "bDot2").alpha = 1
                        self!.findImageNode(name: "bDot3").alpha = 1
                          */
 
                    }
                    
                })
                
            }
        }
        
    }
    
    //元素單位練習完成
    @objc func notifyEndUnit(){
        
    }
    
    @objc func notifyBackToBackpack(){
    
        
    }
    
    //製作掃描線+發音
    func scanAndPronounce(){
        
        //抓任務背景node
        if let questBoard = findImageNode(name: "questBoard") as SKSpriteNode?{
            
            //抓任務背景寬度
            let questBoardWidth = questBoard.size.width
            
            //設定掃描總高度
            let engChiWordHeight:CGFloat = 174
            
            // semi-autoplay 檢查
            
            //製作掃描線
            //避免已有scanningline *這一定要
            if childNode(withName: "scanning") != nil {
                
                print("already has scanning line")
                
            } else {
                
                //製作scanningline
                makeNode(name: "scanning", color: diamondGreen, x: 0, y: 120, width: questBoardWidth, height: 1, z: 3, isAnchoring: false, alpha: 1)
                
            }
            
            //往下掃瞄速度
            let scanAction = SKAction.moveTo(y: 120 - engChiWordHeight, duration: 0.3)
            //線縮起來速度
            let shrinkAction = SKAction.resize(toWidth: 0, duration: 0.08)
            let sequenceAction = SKAction.sequence([scanAction,shrinkAction])
            
            //啟動掃描動畫
            
            if let scanningLine = findImageNode(name: "scanning") as SKSpriteNode?{
                
                scanningLine.run(sequenceAction, completion: {[weak self] in
                    //播放發音
                    self!.pronounce()
                    
                    let removeAction = SKAction.run({
                        
                        //移除掃描線
                        scanningLine.removeFromParent()
                        
                    })
                    
                    self!.run(removeAction, completion: {
                        
                        //允許再按掃描
                        self!.isScanning = false
                        
                        //判斷在聽讀模式還是練習模式
                        //非戰鬥模式時才亮燈
                        if self!.isBattleMode == false {
                            
                            if self!.isPracticeMode == false {
                                
                                self!.playSoundTime += 1
                                
                                //聽讀模式
                                //self!.lightDotFunc(times: self!.playSoundTime)
                               
                                
                            } else{
                                
                                //練習模式
                                //self!.lightDotFunc(times: self!.correctTime)
                        
                                
                            }
                            
                        }
                    }
                    )
                })
            }
        }
    }
    
    //單純發音功能, 要搭配scanAndPronounce使用
    func pronounce(){
        
        let pronounceAction = SKAction.playSoundFileNamed(wordsToPronounce + ".mp3", waitForCompletion: true)
        run(pronounceAction)
        
    }
    
    //亮燈功能, 也順便切換hint的字
    func lightDotFunc(times: Int){
        
        let fadeIn = SKAction.fadeIn(withDuration: 0.3)
        
        switch times {
            
        case 1:
            findImageNode(name: "lDot1").run(fadeIn)
        case 2:
            findImageNode(name: "lDot2").run(fadeIn)
        case 3:
            
            findImageNode(name: "lDot3").run(fadeIn)
            
            if isPracticeMode == false {
                
                //更改hint文字
                findLabelNode(name: "hint").text = "[ 準備進入練習 ]"
                
            } else {
                //回到學習單字
                isUserInteractionEnabled = false
                
                findLabelNode(name: "hint").text = "[ 練習完成 ]"
                
                findImageNode(name: "lDot3").alpha = 0
                
            }
            
        default:
            break
        }
        
    }
    
    //戰鬥模式
    func battleMode(){
        
        //抓怪物名稱來做圖片
        //let monsterName = monsters[monsterSequence]
        
        //找目前sequence的英文+中文字
        let halfCount = wordSets.count / 2
        let monsterId = wordSets[halfCount + currentWordSequence]
        //let monsterIdInt = Int(monsterId)
        var monsterName = String()
        
        
        //抓monster資訊
        for monster in monsters{
            
            if monsterId == monster["monId"] as! String{
                monsterName = monster["monName"] as! String
                monsterType = monster["monType"] as! String
                monsterHp = monster["monHp"] as! Int
                monsterAtt = monster["monAtt"] as! Int
                monsterMagic = monster["monMag"] as! Int
                monsterImg = monster["monImg"] as! String
            }
            
        }
        
        //抓怪物名字
        var monsterNameGroup = [String]()
    
        //抓r數字
        var monGroup = Int()
        
        //如果圖片是亂數, 就抓亂數組別
        if monsterImg.first == "r" {
        let groupNum = monsterImg.replacingOccurrences(of: "r", with: "")
        monGroup = Int(groupNum)! - 1
        }
        
        
        //依照組別append名字來提供亂數
        for n in 0 ..< monsterNames.count{
            
           monsterNameGroup.append(monsterNames[n][monGroup])
            
        }
        
        //沒名字就亂數
        if monsterName == "" {
            let randomNumber = Int(arc4random_uniform(UInt32(monsterNameGroup.count)))

            //怪物名字
            monsterName = monsterNameGroup[randomNumber]
            //怪物圖片
            monsterImg = String(monGroup + 1) + "-" + String(randomNumber + 1)
            
        }
        
        //進入battle模式
        isBattleMode = true
        
        //隱藏QuestTitle
        findLabelNode(name: "questTitle").text = ""
        
        //移除進度點
        removeSomeNodes(name: "Dot")
        
        //移除選項字
        removeSomeNodes(name: "Sel")
        
        //移除中英文字
        removeSomeNodes(name: "Word")
        
        //更改hint
        findLabelNode(name: "hint").text = ""
        
        //怪物畫面
        //makeImageNode(name: "monsterBlurredBg", image: "blurredBg", x: 0, y: 500, width: 750, height: 431, z: 2, alpha: 0, isAnchoring: false)
        
        // 建立怪物 width:750
        //makeImageNode(name: "monsterEffect", image: "monsterEffect", x: 0, y: 450, width: 0, height: 431, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "monster", image: monsterImg, x: 0, y: -150, width: 241, height: 285, z: 1, alpha: 0, isAnchoring: false)
        
        //怪物titleBg
        makeImageNode(name: "monsterTitleBg", image: "monsterTitle", x: 0, y: 632, width: 750, height: 70, z: 4, alpha: 0, isAnchoring: false)
        
        //怪物title
        makeLabelNode(x: 0, y: 600, alignMent: .center, fontColor: tiffanyColor, fontSize: 35, text: monsterName, zPosition: 5, name: "monsterTitle", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        //怪物血Bg
        makeImageNode(name: "monsterBloodBg", image: "bloodBg", x: 0, y: 200, width: 510, height: 20, z: 4, alpha: 0, isAnchoring: false)
        //怪物血
        makeImageNode(name: "monsterBlood", image: "monsterBlood", x: -256, y: 190, width: 510, height: 20, z: 5, alpha: 0, isAnchoring: true)
        
        /*
        //player血Bg
        
        makeImageNode(name: "playerBloodBg", image: "bloodBg", x: 0, y: -490, width: 500, height: 20, z: 4, alpha: 0, isAnchoring: false)
        
        //player血
        makeImageNode(name: "playerBlood", image: "playerBlood", x: -273, y: -525, width: 545, height: 70, z: 5, alpha: 0, isAnchoring: true)
        */
        
        //player血Bg
        
        makeImageNode(name: "playerBloodBg", image: "bloodBg", x: 65, y: -510, width: 390, height: 20, z: 4, alpha: 0, isAnchoring: false)
        
        //player血
        makeImageNode(name: "playerBlood", image: "playerBlood", x: -148, y: -545, width: 425, height: 70, z: 5, alpha: 0, isAnchoring: true)
        
        //確認血量
        fullMonsterBlood = findImageNode(name: "monsterBlood").size.width
        fullPlayerBlood = findImageNode(name: "playerBlood").size.width
        
        
        //瞄準器
        makeImageNode(name: "aimer", image: "aimer", x: 0, y: -150, width: 477, height: 477, z: 2, alpha: 0, isAnchoring: false)
        //瞄準圈
        makeImageNode(name: "aimerCircle", image: "aimerCircle", x: 0, y: -150, width: 305, height: 287, z: 2, alpha: 0, isAnchoring: false)
        //瞄準心
        makeImageNode(name: "aimerHeart", image: "aimerHeart", x: 0, y: -150, width: 144, height: 144, z: 2, alpha: 0, isAnchoring: false)
        
        
        
        for node in children{
            
            //把選項alpha弄淡
            if (node.name?.contains("emptyButton"))!{
                
                node.alpha = 0
                
            }
            if (node.name?.contains("filledButton"))!{
                
                node.alpha = 0
                
            }
            
        }
        
        //怪物出現前動畫, 出現後顯時所有資訊
        monsterAppearIntro{[weak self] in
            
            //顯示怪物Label, x = 0
            let label = self!.findLabelNode(name: "questTitle")
            label.position.x = 0
            label.fontSize = 35
            label.horizontalAlignmentMode = .center
            label.text = "戰鬥開始"
            
            self!.findLabelNode(name: "hint").text = "[ 結合正確音節攻擊元素怪 ]"
            
            //顯示所有怪物資訊及玩家血條
            self!.changeImageAlfa(name: "monsterTitleBg", toAlpha: 1, time: 0)
            self!.changeLabelAlfa(name: "monsterTitle", toAlpha: 1, time: 0)
            self!.changeImageAlfa(name: "monsterBloodBg", toAlpha: 1, time: 0)
            self!.changeImageAlfa(name: "monsterBlood", toAlpha: 1, time: 0)
            self!.changeImageAlfa(name: "playerBloodBg", toAlpha: 1, time: 0)
            self!.changeImageAlfa(name: "playerBlood", toAlpha: 1, time: 0)
            
            
            //瞄準器動畫
            self!.aimerAnimation()
            
            
            //開始戰鬥
            self!.battleTest()
        }
        
    }
    
    
    //瞄準器的旋轉動畫
    func aimerAnimation(){
        
        changeImageAlfa(name: "aimer", toAlpha: 1, time: 0.1)
        changeImageAlfa(name: "aimerCircle", toAlpha: 1, time: 0.1)
        changeImageAlfa(name: "aimerHeart", toAlpha: 1, time: 0.1)
        
        let turnLeft = SKAction.rotate(toAngle: 0.5, duration: 3)
        let turnRight = SKAction.rotate(toAngle: -0.5, duration: 4)
        
        let leftSequence = SKAction.sequence([turnLeft,turnRight])
        let leftRepeat = SKAction.repeatForever(leftSequence)
        
        let rightSequence = SKAction.sequence([turnRight,turnLeft])
        let rightRepeat = SKAction.repeatForever(rightSequence)
        
        findImageNode(name: "aimer").run(leftRepeat)
        findImageNode(name: "aimerCircle").run(rightRepeat)
        
        
    }
    
    
    //放大後消失的動畫, 瞄準器使用
    func enlargeAndDisappear(name:String){
        
        let width = findImageNode(name: name).frame.width * 2
        let height = findImageNode(name: name).frame.height * 2
        let enlarge = SKAction.resize(toWidth: width, height: height, duration: 0.5)
        let alphaAction = SKAction.run {[weak self] in
            self!.changeImageAlfa(name: name, toAlpha: 0, time: 0.4)
        }
        
        let sequence = SKAction.group([enlarge,alphaAction])
        //findImageNode(name: name).run(sequence)
        
        findImageNode(name: name).run(sequence) {[weak self] in
            self!.findImageNode(name: name).removeFromParent()
        }
        
    }
    
    //怪物出現畫面動畫
    func monsterAppearIntro(finished: @escaping () -> Void){
        
        //左右框
        makeImageNode(name: "leftFrame", image: "leftFrame", x: -450, y: 50, width: 141, height: 29, z: 2, alpha: 1, isAnchoring: false)
        makeImageNode(name: "rightFrame", image: "rightFrame", x: 450, y: 30, width: 141, height: 29, z: 2, alpha: 1, isAnchoring: false)
        //發現怪物字樣
        makeLabelNode(x: 0, y: 25, alignMent: .center, fontColor: diamondGreen, fontSize: 50, text: "發現怪物", zPosition: 2, name: "monsterFound", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        let toRight = SKAction.moveTo(x: -215, duration: 0.05)
        let floatToRight = SKAction.moveTo(x: -195, duration: 2)
        let sequence = SKAction.sequence([toRight,floatToRight])
        findImageNode(name: "leftFrame").run(sequence)
        
        let toLeft = SKAction.moveTo(x: 215, duration: 0.05)
        let floatToLeft = SKAction.moveTo(x: 195, duration: 2)
        let sequence1 = SKAction.sequence([toLeft,floatToLeft])
        findImageNode(name: "rightFrame").run(sequence1)
        
        let wait = SKAction.wait(forDuration: 0.05)
        let fadeIn = SKAction.fadeIn(withDuration: 0)
        let waitLonger = SKAction.wait(forDuration: 1.5)
        let fadeOut = SKAction.fadeOut(withDuration: 0)
        let waitTillEnd = SKAction.wait(forDuration: 0.5)
        let vanishToLeft = SKAction.moveTo(x: -450, duration: 0.05)
        let vanishToRight = SKAction.moveTo(x: 450, duration: 0.05)
        
        let sequence2 = SKAction.sequence([wait,fadeIn,waitLonger,fadeOut,wait,fadeIn,waitTillEnd])
        
        findLabelNode(name: "monsterFound").run(sequence2) {[weak self] in
            
            self!.findImageNode(name: "leftFrame").run(vanishToLeft)
            self!.findImageNode(name: "rightFrame").run(vanishToRight)
            self!.findLabelNode(name: "monsterFound").alpha = 0
            
            //1. 模糊背景
            //self!.changeImageAlfa(name: "monsterBlurredBg", toAlpha: 1, time: 0.2)
            
            //2. 怪物後方背景
            
            //let enlarge = SKAction.resize(toWidth: 750, duration: 0.2)
            //self!.changeImageAlfa(name: "monsterEffect", toAlpha: 1, time: 0.2)
            
            // self!.findImageNode(name: "monsterEffect").run(enlarge, completion: {[weak self] in
            
            //3. 怪物出現, 然後永久上下動
            let showUp = SKAction.run({
                self!.changeImageAlfa(name: "monster", toAlpha: 1, time: 0)
            })
            
            let up = SKAction.moveTo(y: -140, duration: 0.2)
            let down = SKAction.moveTo(y: -150, duration: 0.3)
            let wait = SKAction.wait(forDuration: 0.2)
            let upWaitDown = SKAction.sequence([up,wait,down])
            let repeatAction = SKAction.repeatForever(upWaitDown)
            let sequence = SKAction.sequence([showUp,repeatAction])
            self!.findImageNode(name: "monster").run(sequence)
            
            finished()
            
            //  })
            
        }
        
    }
    
    
    
    //啟動戰鬥功能 -> 利用測驗機制
    func battleTest(){
        
        //找目前sequence的英文+中文字
        let halfCount = wordSets.count / 4
        let engWord = wordSets[currentWordSequence]
        let chiWord = wordSets[halfCount +  currentWordSequence]
        
        //製作中英文字
        makeWords(word: engWord, lang: "engWord")
        makeWords(word: chiWord, lang: "chiWord")
        
        //確認產生完中文字就開始
        if (self.childNode(withName: "chiWord") as! SKLabelNode?) != nil{
            
            //中文字產生完之後, 就產生掃描線及發音
            scanAndPronounce()
            
            //可以按畫面
            isUserInteractionEnabled = true
            
            //測驗的機制
            learningTest()
            
        }
        
        //中文字fade in
        /*
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        for node in children{
            
            if (node.name?.contains("chiWord"))!{
                
                node.run(fadeIn, completion: {[weak self] in
                    
                    //中文字產生完之後, 就產生掃描線及發音
                    self!.scanAndPronounce()
                    
                    //可以按畫面
                    self!.isUserInteractionEnabled = true
                    
                    //測驗的機制
                    self!.learningTest()
                    
                    
                })
                
            }
        }
        */
    }
    
    //學習階段的測驗
    func learningTest(){
        
        //讓英文字alpha變淡
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.3)
        
        //顯示空格子
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.3)
        
        for node in children{
            
            //隱藏英文單字
            if (node.name?.contains("engWord"))!{
                
                node.run(fadeOut)
            }
            
            
            //顯示選項罐子
            if (node.name?.contains("emptyButton"))!{
                
                node.run(fadeIn)
            }
        }
        
        //中文字隱藏
        
        if isBattleMode{
            
            changeLabelAlfa(name: "chiWord", toAlpha: 0, time: 0.3)
        }
        
        
        //抓目前單字
        let currentWord = wordSets[currentWordSequence]
        
        //分目前單字音節
        currentWordArray = currentWord.components(separatedBy: " ")
        
        //計算音節數
        let currentWordSyllableCounts = currentWordArray.count
        
        //抓部首以外的英文字
        var otherWords = [String]()
        
        //在所有英文字裡面, 如果音節沒有重複目前顯示的音節, 就把它加入到otherWords裡
        for i in 0 ..< wordSets.count / 4{
            
            let word = wordSets[i]
            let sepWordArray = word.components(separatedBy: " ")
            
            for s in sepWordArray{
                
                if !currentWordArray.contains(s) {
                    otherWords.append(s)
                    
                }
            }
        }
        
        //去除array裡重複的字
        let otherWordsOrderSets = otherWords.orderedSet
        
        //產生[0,1,2...]用來移除前一亂數
        var countArray = [Int]()
        
        var randomNumbers = Int()
        
        for i in 0 ..< otherWordsOrderSets.count{
            
            countArray.append(i)
        }
        
        //產生真正來顯示用的多餘單字
        var extraWords = [String]()
        
        
        //補不足的選項
        switch currentWordSyllableCounts {
            
        case 1:
            
            for _ in 0 ..< 4 {
                randomNumbers = Int(arc4random_uniform(UInt32(countArray.count)))
                extraWords.append(otherWordsOrderSets[countArray[randomNumbers]])
                countArray.remove(at: randomNumbers)
                
            }
            
        case 2:
            
            for _ in 0 ..< 3 {
                randomNumbers = Int(arc4random_uniform(UInt32(countArray.count)))
                extraWords.append(otherWordsOrderSets[countArray[randomNumbers]])
                countArray.remove(at: randomNumbers)
                
            }
            
        case 3:
            
            for _ in 0 ..< 2 {
                
                randomNumbers = Int(arc4random_uniform(UInt32(countArray.count)))
                extraWords.append(otherWordsOrderSets[countArray[randomNumbers]])
                countArray.remove(at: randomNumbers)
            }
            
        case 4:
            randomNumbers = Int(arc4random_uniform(UInt32(countArray.count)))
            extraWords.append(otherWordsOrderSets[countArray[randomNumbers]])
            countArray.remove(at: randomNumbers)
            
            
        default:
            break
        }
        
        
        //先把該單字音節填入
        for word in currentWordArray{
            
            shownWords.append(word)
            
        }
        
        //假如有多餘選項字, 填入
        if extraWords.count > 0 {
            for extraWord in extraWords {
                
                shownWords.append(extraWord)
                
            }
        }
        
        //改變字的順序順序
        shownWords.shuffled()
        
        //建立所有單字選項
        //設定5格的位置
        let positions = [[-160,-370],[-260,-90],[160,-370],[260,-90],[0,100]]
        
        for i in 0 ..< shownWords.count{
            
            makeLabelNode(x: CGFloat(positions[i][0]), y: CGFloat(positions[i][1]), alignMent: .center, fontColor: .white, fontSize: 60, text: shownWords[i], zPosition: 5, name: shownWords[i] + String(i) + "Sel", fontName: "Helvetica", isHidden: false, alpha: 1)
            
            //可按按鍵
            isUserInteractionEnabled = true
            
            //把建立的選項名稱放入array裡
            selNodeNames.append(shownWords[i] + String(i) + "Sel")
            
        }
        
        
        isDragAndPlayEnable = true
        
    }
    
    //關上任務版+再打開的動畫
    func closeQuestBoardAndReopen(){
        
        //選項alpha變淡+移除選項字
        for node in children{
            
            if (node.name?.contains("filledButton"))!{
                changeImageAlfa(name: node.name!, toAlpha: 0, time: 0.3)
                
            }
            
            if (node.name?.contains("emptyButton"))!{
                changeImageAlfa(name: node.name!, toAlpha: 0, time: 0.3)
            }
            
            if (node.name?.contains("Sel"))!{
                node.removeFromParent()
            }
            
        }
        //把questTitle字消失
        findLabelNode(name: "questTitle").text = ""
        
        //remove所有的字Node
        removeSomeNodes(name: "Word")
        removeSomeNodes(name: "hint")
        
        //關上任務板子的action
        let questBoardClose = SKAction.resize(toHeight: 0, duration: 0.3)
        findImageNode(name: "questBoard").run(questBoardClose){[weak self] in
            
            //拉開任務板子的action
            self!.openQuest()
            
        }
        
    }
    
    //移除node的func
    func removeSomeNodes(name:String){
        
        for node in children{
            
            if (node.name?.contains(name))!{
                
                node.isHidden = true
                node.removeFromParent()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            location = touch.location(in: self)
            
            let node : SKNode = self.atPoint(location)
            
            //確認中文正確與否
            if node.name == "leftChiBtn" || node.name == "leftChi"{
                if leftOrRight == 0 {
                    //答對
                
                    changeImageAlfa(name: "leftChiBtn", toAlpha: 0, time: 0.1)
                    changeImageAlfa(name: "rightChiBtn", toAlpha: 0, time: 0.1)
                    leftChiNode.text = ""
                    rightChiNode.text = ""
                    
                    battleModeRight()
                    
                    
                }else{
                    //答錯
                    changeImageAlfa(name: "leftChiBtn", toAlpha: 0, time: 0.1)
                    changeImageAlfa(name: "rightChiBtn", toAlpha: 0, time: 0.1)
                    leftChiNode.text = ""
                    rightChiNode.text = ""
        
                    battleModeWrong()
               
                }
                
            }
            
            if node.name == "rightChiBtn" || node.name == "rightChi"{
                if leftOrRight == 1 {
                    //答對
                    
                    //removeSomeNodes(name: "ChiBtn")
                    changeImageAlfa(name: "leftChiBtn", toAlpha: 0, time: 0.1)
                    changeImageAlfa(name: "rightChiBtn", toAlpha: 0, time: 0.1)
                    leftChiNode.text = ""
                    rightChiNode.text = ""
            
                    battleModeRight()
                    
                }else{
                    //答錯
                    
                    //答錯
                    changeImageAlfa(name: "leftChiBtn", toAlpha: 0, time: 0.1)
                    changeImageAlfa(name: "rightChiBtn", toAlpha: 0, time: 0.1)
                    leftChiNode.text = ""
                    rightChiNode.text = ""
                    
                    battleModeWrong()
                }
                
            }

            
            
            //遊戲結束
            if node.name == "getButton" || node.name == "quitButton"{
                
                //跳轉回元素表
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "endUnit"), object: nil, userInfo: nil)
                //移除node及動畫
                removeEverything()
            }
            
            //刪除背包元素的ok按鍵
            if node.name == "okButton" {
                
                //紀錄關卡
                if unitNumber == 9{
                    
                    gamePassed = [spotNumber + 1:0]
                }else {
                    
                    gamePassed = [spotNumber: unitNumber + 1]
                }
                //然後儲存關卡
                let userDefaults = UserDefaults.standard
                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed!)
                userDefaults.set(encodedObject, forKey: "gamePassed")
                
                //在此傳4個值給Vc
                let valuePass:[String:Any] = ["page":elemPageToPass,"seg":segIndexToPass,"typeSeg":typeSegToPass, "elem":syllablesToCheck]
  
                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: "backToBackpack"), object: nil, userInfo: valuePass)
                
                //移除所有的NODE
                removeEverything()
            }
            
            
            //得到寵物後的按鈕
            if node.name == "getPetButton"{
                
                //Part 1. 連接後端
                //Part 2. 刪除元素
                //Part 3. 跳回關卡
                //Part 4. 儲存關卡進度
                
                //紀錄關卡
                if unitNumber == 9{
                    
                    gamePassed = [spotNumber + 1:0]
                }else {
                    
                    gamePassed = [spotNumber: unitNumber + 1]
                }
                //然後儲存關卡
                let userDefaults = UserDefaults.standard
                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed!)
                userDefaults.set(encodedObject, forKey: "gamePassed")
                
                let id = user?["id"] as! String
                getPet(id: id, petId: upgradeValue)
                
                //刪除兩個元素
                deleteElem(elem:upgradeNames[0])
                deleteElem(elem:upgradeNames[1])
                
                
                //把所有elem歸零, 合併元素在selElem裡
                exactElemSaved = [[-1:-1],[-1:-1],[-1:-1]]
                
                //let userDefaults = UserDefaults.standard
                let encodedObject1 = NSKeyedArchiver.archivedData(withRootObject: exactElemSaved!)
                userDefaults.set(encodedObject1, forKey: "exactElemSaved")
                userDefaults.synchronize()
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "endUnit"), object: nil, userInfo: nil)

                //移除所有的Node
                removeEverything()
                
            }
            
            
            //按鈕功能, 暫時用不到
            if isButtonEnable {
                if node.name == "button"{
                    print("button pressed")
                    
                }
            }
            
            if node.name == "1Love"{

                if wordsLoved[0] == 0{
                    
                  
                    let bundlePath = Bundle.main.path(forResource: "heart", ofType: "png")
                    let imageFile = UIImage(contentsOfFile: bundlePath!)
                    let texture = SKTexture(image: imageFile!)
                    findImageNode(name: "1Love").texture = texture
 
                    wordsLoved[0] = 1
                    
                    
                    
                } else {
                    
                    
                    let bundlePath = Bundle.main.path(forResource: "unHeart", ofType: "png")
                    let imageFile = UIImage(contentsOfFile: bundlePath!)
                    let texture = SKTexture(image: imageFile!)
                    findImageNode(name: "1Love").texture = texture
                    
                    wordsLoved[0] = 0
                    
                }
            
            }
            if node.name == "2Love"{
                
                if wordsLoved[1] == 0{
                    
                    
                    let bundlePath = Bundle.main.path(forResource: "heart", ofType: "png")
                    let imageFile = UIImage(contentsOfFile: bundlePath!)
                    let texture = SKTexture(image: imageFile!)
                    findImageNode(name: "2Love").texture = texture
                    
                    wordsLoved[1] = 1
                    
                } else {
                    
                    
                    let bundlePath = Bundle.main.path(forResource: "unHeart", ofType: "png")
                    let imageFile = UIImage(contentsOfFile: bundlePath!)
                    let texture = SKTexture(image: imageFile!)
                    findImageNode(name: "2Love").texture = texture
                    
                    wordsLoved[1] = 0
                    
                }

                
                
            }
            if node.name == "3Love"{
                
                if wordsLoved[2] == 0{
                    
                    
                    let bundlePath = Bundle.main.path(forResource: "heart", ofType: "png")
                    let imageFile = UIImage(contentsOfFile: bundlePath!)
                    let texture = SKTexture(image: imageFile!)
                    findImageNode(name: "3Love").texture = texture
                    
                    wordsLoved[2] = 1
                    
                } else {
                    
                    
                    let bundlePath = Bundle.main.path(forResource: "unHeart", ofType: "png")
                    let imageFile = UIImage(contentsOfFile: bundlePath!)
                    let texture = SKTexture(image: imageFile!)
                    findImageNode(name: "3Love").texture = texture
                    
                    wordsLoved[2] = 0
                    
                }
                
                
            }
            //按主畫面的功能
            
            if isScanning == false{
                
                //假如發音按超過三次要開始練習, 三次跳練習目前放在update裡面
                if playSoundTime < 3{
                    
                    //按到這些範圍要發音
                    if node.name == "questBoard" || (node.name?.contains("engWord"))! || (node.name?.contains("chiWord"))!{
                        
                        scanAndPronounce()
                    }
                }
            }
            
            //**** 開始拖拉遊戲 dragAndPlay ***
            if isDragAndPlayEnable {
                
                //在建立一條新的線
                line = SKShapeNode()
                line?.strokeColor = pinkColor
                line?.lineWidth = 8
                line?.name = "line"
                line?.zPosition = 4
                line?.glowWidth = 2
                
                addChild(line!)
                
                //指定好第一下的位置
                firstTouch = touch.location(in: self)
                
                let node : SKNode = self.atPoint(firstTouch)
                
                //假設有選項單字
                if shownWords.count > 0 {
                    
                    //抓選項方塊
                    for i in 0 ..< selNodeNames.count{
                        
                        //按到任何按鈕
                        if node.name == "se" + String(i){
                            
                            //必須獨立使用touchTimes +=1 才偵測的正確...
                            self.touchTimes += 1
                            
                            let wordChosen = shownWords[i]
                            
                            let name = node.name!
                            
                            //從名稱當中移除該node
                            if let idx = selNodeNames.index(of:name) {
                                selNodeNames.remove(at: idx)
                            }
                            
                            //建立一個透明覆蓋Node
                            makeNode(name: "new" + name, color: .clear, x: node.position.x, y: node.position.y, width: node.frame.width, height: node.frame.height, z: node.zPosition + 1, isAnchoring: false, alpha: 1)
                            
                            //新增到已經按到的node裡
                            nodesTouched.append(findImageNode(name: "new" + name))
                            
                            //建立暫時顯示單字
                            showEnterWords(word: wordChosen)
                            
                            //藥水動畫
                            pourPoison(word: wordChosen, poisonNumber: i)
                            
                            //瞄準器縮小
                            if isBattleMode{
                                findImageNode(name: "aimerHeart").run(zoomIn())
                            }
                            
                        }
                    }
                }
            }
            
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //確認有按到任何選項單字才會開始偵測move動作
        if touchTimes > 0{
            
            for touch in touches{
                
                isEndOnNode = true
                
                //設定正在移動中的位置
                movingTouch = touch.location(in: self)
                
                let node : SKNode = self.atPoint(movingTouch)
                
                //畫線
                drawLine()
                
                //移除上一個node的功能
                //避免重複移除
                if isRemoved == false {
                    
                    let nodesTouchedCount = nodesTouched.count
                    
                    //假如按到兩個以上的node, 才會移除
                    if nodesTouchedCount > 1 {
                        
                        //假如碰到的node是前一個
                        if node.name == nodesTouched[nodesTouchedCount - 2].name {
                            
                            //移除藥水
                            //取得數字順序
                            let idx = nodesTouchedCount - 1
                            let node = nodesTouched[idx]
                            let nameToRemove = node.name
                            let seq = Int((nameToRemove?.replacingOccurrences(of: "newse", with: ""))!)
                            let word = shownWords[seq!]
                            removePoison(word: word, poisonNumber: seq!)
                            
                            //阻擋重複移除
                            isRemoved = true
                            
                            //移除掉目前這個的發亮node
                            let nextNode = nodesTouched[nodesTouchedCount - 1]
                            nextNode.removeFromParent()
                            
                            //記錄裡也要刪掉
                            nodesTouched.remove(at: nodesTouchedCount - 1)
                            
                            //按到次數少1
                            touchTimes -= 1
                            
                            //然後畫線
                            drawLine()
                            
                            //移除上一個輸入的答案
                            wordEntered.removeLast()
                            
                            //抓所有輸入的答案連成一串字
                            var fullText = String()
                            for i in wordEntered {
                                fullText += i
                                
                            }
                            
                            //更改輸入字
                            findLabelNode(name: "tempWord").text = fullText
                            
                        }
                        
                    }
                    
                }
                
                //移動中遇到其它4個node
                if node.name == selNodeNames[0] || node.name == selNodeNames[1] || node.name == selNodeNames[2] || node.name == selNodeNames[3]{
                    
                    //取得數字順序
                    let name = node.name!
                    let index = Int(name.replacingOccurrences(of: "se", with: ""))
                    
                    //避免連續加node
                    if isTouched == false{
                        
                        //阻擋連續加node
                        isTouched = true
                        
                        touchTimes += 1
                        
                        //產生覆蓋的透明node
                        makeNode(name: "new" + name, color: .clear, x: node.position.x, y: node.position.y, width: node.frame.width, height: node.frame.height, z: node.zPosition + 1, isAnchoring: false, alpha: 1)
                        
                        nodesTouched.append(findImageNode(name: "new" + name))
                        
                        //找出選擇的單字
                        let wordChosen = shownWords[index!]
                        
                        //畫面上show出單字
                        showEnterWords(word: wordChosen)
                        
                        //藥水動畫
                        pourPoison(word: wordChosen, poisonNumber: index!)
                        

                    }
                    
                    //檢查已經增加第幾個node, 然後做固定轉折點
                    switch touchTimes {
                        
                    case 2:
                        
                        fixedSecondTouch = getCgPoint(name: name)
                        
                    case 3:
                        
                        fixedThirdTouch = getCgPoint(name: name)
                        
                    case 4:
                        
                        fixedFourthTouch = getCgPoint(name: name)
                        
                    case 5:
                        
                        fixedFifthTouch = getCgPoint(name: name)
                        
                    default:
                        break
                    }
                    
                    //轉折點設置好後畫線
                    drawLine()
                    
                    
                } else {
                    
                    //手指離開方塊時

                    //避免一直重複執行
                    isTouched = false
                    
                    isRemoved = false
                    
                }
                
            }
        }
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        //手指離開後對答案的機制
        
        //確認有按到任何選項單字才會開始偵測end動作
        if touchTimes > 0{
            
            
            if isDragAndPlayEnable {
                
                //****確認模式****
                if isBattleMode {
                    // Part 1. 戰鬥模式
                    
                    //瞄準器放大
                    findImageNode(name: "aimerHeart").run(zoomOut())
                    
                    //避免再次按
                    isUserInteractionEnabled = false
                    
                    //移除上一次的發亮按鈕
                    removeSomeNodes(name: "new")
                    
                    
                    //初始化
                    selNodeNames = ["se0","se1","se2","se3","se4"]
                    
                    for touch in touches{
                        
                        let lastTouch = touch.location(in: self)
                        
                        let node : SKNode = self.atPoint(lastTouch)
                        
                        //是否修改線的長度
                        if node.name == selNodeNames[0] || node.name == selNodeNames[1] || node.name == selNodeNames[2] || node.name == selNodeNames[3] || node.name == selNodeNames[4]{
                            
                            //最後有碰到node, 不修改線
                            
                        } else {
                            //最後一個沒碰到node的話, 一放開縮短線
                            
                            isEndOnNode = false
                            
                            drawLine()
                            
                        }
                        
                        
                    }
                    
                    //固定線
                    /*
                     line = SKShapeNode()
                     line?.strokeColor = diamondGreen
                     line?.lineWidth = 8
                     line?.name = "line"
                     line?.zPosition = 4
                     line?.glowWidth = 2
                     addChild(line!)
                     */
                    
                    //初始化
                    isFirstTouch = false
                    touchTimes = 0
                    isTouched = false
                    nodesTouched.removeAll(keepingCapacity: false)
                    
                    
                    //指定名稱的變數
                    let monster = "monsterBlood"
                    let player = "playerBlood"
                    
                    //抓目前怪物及玩家血量
                    
                    monsterBlood = findImageNode(name: monster).size.width
                    playerBlood = findImageNode(name: player).size.width
      
                    
                    //假如答案正確, 啟動攻擊
                    if wordEntered == currentWordArray{
                        
                        //放大後消失移除
                        enlargeAndDisappear(name: "aimer")
                        enlargeAndDisappear(name: "aimerCircle")
                        enlargeAndDisappear(name: "aimerHeart")
                        
                        scanAndPronounce()
                        
                        //移除線
                        removeSomeNodes(name: "line")
                        
                        //Part 1. 選項顏色變淡+移除選項字
                        //Part 2. 建立兩個選項
                        //Part 3. 亂數顯示中文
                        //Part 4. 判定正確與否
                        
                        for node in children{
                            
                            if (node.name?.contains("filledButton"))!{
                                changeImageAlfa(name: node.name!, toAlpha: 0, time: 0.1)
                            }
                            
                            if (node.name?.contains("emptyButton"))!{
                                changeImageAlfa(name: node.name!, toAlpha: 0, time: 0.1)
                            }
                            
                            if (node.name?.contains("Sel"))!{
                                node.removeFromParent()
                            }
                            
 
                        }
                        
                      //顯示中文選項
                        
                        
 
                        //抓亂數中文
                        let quarterCount = wordSets.count / 4
                        let halfCount = wordSets.count / 2
                        let chiWord = wordSets[quarterCount +  currentWordSequence]
                        var allChiWords = [String]()
                        for i in quarterCount ..< halfCount{
                            allChiWords.append(wordSets[i])
                        }
                        
                        allChiWords.remove(at: currentWordSequence)

                        //亂數
                        let randomNumber = Int(arc4random_uniform(UInt32(allChiWords.count)))
                        let randomChi = allChiWords[randomNumber]
                        var selChiWords = [String]()
                        
                        selChiWords.append(chiWord)
                        selChiWords.append(randomChi)
                        
                        let randomL = Int(arc4random_uniform(UInt32(2)))
                        var randomR = Int()
                        if randomL == 0 {
                            //左對
                            randomR = 1
                            leftOrRight = 0
                        } else {
                            //右對
                            randomR = 0
                                leftOrRight = 1
                        }
                        
                        leftChiNode.text = selChiWords[randomL]
                        rightChiNode.text = selChiWords[randomR]
                        
                        let leftChiBtn = findImageNode(name: "leftChiBtn")
                        let rightChiBtn = findImageNode(name:"rightChiBtn")
                        
                        let showAlpha = SKAction.fadeAlpha(to: 1, duration: 0.1)
                        leftChiBtn.run(showAlpha)
                        rightChiBtn.run(showAlpha, completion: {[weak self] in
                            
                               self!.isUserInteractionEnabled = true
                            
                        })
 
                    
                        /*
                        //把temp字改顏色
                        let tempNode = findLabelNode(name: "tempWord")
                        let changeColor = SKAction.colorize(with: pinkColor, colorBlendFactor: 1, duration: 0.3)
                        tempNode.run(changeColor, completion: {[weak self] in
                            
                            //自我爆炸動畫
                            let explode = SKAction.run({
                                self!.explodeEmitter?.isHidden = false
                                self!.explodeEmitter?.resetSimulation()
                                
                            })
                            //等待爆炸秒數
                            let waitAction = SKAction.wait(forDuration: 0.7)
                            let sequence = SKAction.sequence([explode,waitAction])
                            
                            //temp自我爆炸後攻擊怪物
                            self!.run(sequence, completion: {
                                
                                //正確攻擊
                                self!.findImageNode(name: "monster").run(self!.rightAttack())
                                
                                //移除上一次的線
                                self!.removeSomeNodes(name: "line")
                                
                                
                            })
                            
                            
                            //等待攻擊動畫秒數後扣分
                            let when = DispatchTime.now() + 2.3
                            
                            DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                                
                                //算爆擊機率
                                let randomNumber = Int(arc4random_uniform(UInt32(100)))
                                var isDoubleHit = false
                                if randomNumber <= self!.petDouble{
                                    isDoubleHit = true
                                }
                                

                                // 總魔攻單位數 = (人的魔攻屬性 * 0.5/1/1.5)
                                //模擬屬性攻擊
                                let petType = self!.petType
                                
                                var magicTimes:CGFloat = 1

                                //計算寵物攻擊怪的屬性倍數
                                switch petType{
                                    
                                case "wood":
                                    if self!.monsterType == "earth"{
                                        magicTimes = 1.5
                                    } else if self!.monsterType == "metal"{
                                        magicTimes = 0.5
                                    }
                                case "earth":
                                    if self!.monsterType == "water"{
                                        magicTimes = 1.5
                                    } else if self!.monsterType == "wood"{
                                        magicTimes = 0.5
                                    }
                                    
                                case "water":
                                    if self!.monsterType == "fire"{
                                        magicTimes = 1.5
                                    } else if self!.monsterType == "earth"{
                                        magicTimes = 0.5
                                    }
                                    
                                case "fire":
                                    if self!.monsterType == "metal"{
                                        magicTimes = 1.5
                                    } else if self!.monsterType == "water"{
                                        magicTimes = 0.5
                                    }
                                    
                                case "metal":
                                    if self!.monsterType == "wood"{
                                        magicTimes = 1.5
                                    } else if self!.monsterType == "fire"{
                                        magicTimes = 0.5
                                    }
                                    
                                default:
                                    break
                                    
                                }
               
                                
                                //計算怪屬性攻擊倍數
                                var monsterMagicTimes:CGFloat = 1
                                
                                //再做一個判斷怪屬性攻擊倍數的switch
                                switch self!.monsterType{
                                    
                                case "wood":
                                    if petType == "earth"{
                                        monsterMagicTimes = 1.5
                                    } else if petType == "metal"{
                                        monsterMagicTimes = 0.5
                                    }
                                case "earth":
                                    if petType == "water"{
                                        monsterMagicTimes = 1.5
                                    } else if petType == "wood"{
                                        monsterMagicTimes = 0.5
                                    }
                                    
                                case "water":
                                    if petType == "fire"{
                                        monsterMagicTimes = 1.5
                                    } else if petType == "earth"{
                                        monsterMagicTimes = 0.5
                                    }
                                    
                                case "fire":
                                    if petType == "metal"{
                                        monsterMagicTimes = 1.5
                                    } else if petType == "water"{
                                        monsterMagicTimes = 0.5
                                    }
                                    
                                case "metal":
                                    if petType == "wood"{
                                        monsterMagicTimes = 1.5
                                    } else if petType == "fire"{
                                        monsterMagicTimes = 0.5
                                    }
                                    
                                default:
                                    break
                                    
                                }
                                
                                
                                //總攻擊單位數 =  (人攻 - 怪防)
                                var attackPoint = CGFloat(self!.petAttack) * (magicTimes) - CGFloat(self!.monsterDef)
                                
                                //計算亂數
                                attackPoint = self!.randomPoint(points: attackPoint)

                                
                                
                                //怪攻擊單位數 = (怪攻 - 人防)
                                var monsterAttackPoint = CGFloat(self!.monsterAtt) * monsterMagicTimes - CGFloat(self!.petDefense)
                                
                                //計算亂數
                                monsterAttackPoint = self!.randomPoint(points: monsterAttackPoint)
                                
                                
                                
                                //人魔法攻擊單位算法
                                var magicAttackPoint = CGFloat(self!.petExtra) * magicTimes
                                
                                //計算亂數
                                magicAttackPoint = self!.randomPoint(points: magicAttackPoint)
                                

                                //怪魔法攻擊單位算法
                                var monsterMagicAttackPoint = CGFloat(self!.monsterMagic) * monsterMagicTimes
                                
                                //計算亂數
                                monsterMagicAttackPoint = self!.randomPoint(points: monsterMagicAttackPoint)
                                
                                
                                //show普攻字
                                let comboAttack = self!.findLabelNode(name: "comboAttack")
                                comboAttack.alpha = 1
                                comboAttack.text = "普攻: \(attackPoint)"
                                
                                
                                //先普攻
                                self!.attack(point: CGFloat(attackPoint), whom: monster, finished: {
                                    
                                    //隱藏普攻字
                                    self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                    
                                    //假如怪死
                                    if self!.monsterBlood == 0 {
                                        //這局結束
                                        //下一場比賽
                                        self!.nextBattle()
                                        
                                    } else {
                                        //假如怪沒死再魔攻
                                        
                                        //假如有魔攻擊
                                        if magicAttackPoint > 0 {
                                            
                                            //顯示魔攻字樣
                                            comboAttack.alpha = 1
                                            comboAttack.fontColor = .yellow
                                            comboAttack.text = "魔攻: \(magicAttackPoint)"
                                            
                                            self!.attack(point: magicAttackPoint, whom: monster, finished: {
                                                
                                                self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                
                                                //怪死的話
                                                if self!.monsterBlood == 0 {
                                                    //這局結束
                                                    //下一場比賽
                                                    self!.nextBattle()
                                                    
                                                } else {
                                                    //確認是否有爆擊
                                                    if isDoubleHit{
                                                        
                                                        //顯示爆擊字樣
                                                        comboAttack.alpha = 1
                                                        comboAttack.text = "爆擊: \(CGFloat(attackPoint) + magicAttackPoint)"
                                                        
                                                        //爆擊攻擊 普+魔
                                                        
                                                        let comboPoints = CGFloat(attackPoint) + magicAttackPoint
                                                        self!.attack(point: comboPoints, whom: monster, finished: {
                                                            
                                                            //怪死的話
                                                            if self!.monsterBlood == 0 {
                                                                //這局結束
                                                                //下一場比賽
                                                                self!.nextBattle()
                                                                
                                                            } else {
                                                                //檢查是否有治癒
                                                                if self!.petHeal > 0{
                    
                                                                    //補血
                                                                    self!.heal(point: CGFloat((self!.petHeal)), whom: player, finished: {
                                                                        
                                                                        self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                                        
                                                                        //換怪攻擊人
                                                                        
                                                                        //怪普攻字樣
                                                                        comboAttack.alpha = 1
                                                                        comboAttack.fontColor = .cyan
                                                                        comboAttack.text = "怪物攻擊:\(monsterAttackPoint)"
                                                                        
                                                                        self!.attack(point: CGFloat(monsterAttackPoint), whom: player, finished: {
                                                                            
                                                                            //隱藏字樣
                                                                            self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                                            
                                                                            if self!.playerBlood == 0 {
                                                                                //假如玩家死亡
                                                                                //print("player dead")
                                                                                //self!.nextBattle()
                                                             
                                                                                self!.failedToGetElement()
                                                                            } else {
                                                                                //假如人還沒死
                                                                                //確認有無怪物魔法攻擊
                                                                                
                                                                                if monsterMagicAttackPoint > 0 {
                                                                                    //有的話就魔法攻擊人
                                                                                    
                                                                                    //怪魔法攻擊字樣
                                                                                    comboAttack.alpha = 1
                                                                                    comboAttack.fontColor = self!.pinkColor
                                                                                    comboAttack.text = "怪物魔法: \(monsterMagicAttackPoint)"
                                                                                    
                                                                                    self!.attack(point: monsterMagicAttackPoint, whom: player, finished: {
                                                                                        
                                                                                        //隱藏字樣
                                                                                        self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                                                        
                                                                                        if self!.playerBlood == 0 {
                                                                                            //假如玩家死亡
                                                                                            //print("player dead")
                                                                                            //self!.nextBattle()
                                                               
                                                                                            self!.failedToGetElement()
                                                                                        }else {
                                                                                            
                                                                                            //繼續比賽
                                                                                            self!.continueBattle()
                                                                                            
                                                                                        }
                                                                                        
                                                                                        
                                                                                    })
                                                                                    
                                                                                    
                                                                                } else {
                                                                                    
                                                                                    //繼續比賽
                                                                                    self!.continueBattle()
                                                                                    
                                                                                }
                                                                                
                                                                                
                                                                            }
                                                                            
                                                                            
                                                                        })
                                                                        
                                                                    })
                                                                    
                                                                    
                                                                    
                                                                    
                                                                } else {
                                                                
                                                                
                                                                //換怪攻擊人
                                                                
                                                                //怪普攻字樣
                                                                comboAttack.alpha = 1
                                                                comboAttack.fontColor = .cyan
                                                                comboAttack.text = "怪物攻擊:\(monsterAttackPoint)"
                                                                
                                                                self!.attack(point: CGFloat(monsterAttackPoint), whom: player, finished: {
                                                                    
                                                                    //隱藏字樣
                                                                    self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                                    
                                                                    if self!.playerBlood == 0 {
                                                                        //假如玩家死亡
                                                                        //print("player dead")
                                                                        //self!.nextBattle()
                                                                        self!.failedToGetElement()
                                                                    } else {
                                                                        //假如人還沒死
                                                                        //確認有無怪物魔法攻擊
                                                                        
                                                                        if monsterMagicAttackPoint > 0 {
                                                                            //有的話就魔法攻擊人
                                                                            
                                                                            //怪魔法攻擊字樣
                                                                            comboAttack.alpha = 1
                                                                            comboAttack.fontColor = self!.pinkColor
                                                                            comboAttack.text = "怪物魔法: \(monsterMagicAttackPoint)"
                                                                            
                                                                            self!.attack(point: monsterMagicAttackPoint, whom: player, finished: {
                                                                                
                                                                                //隱藏字樣
                                                                                self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                                                
                                                                                if self!.playerBlood == 0 {
                                                                                    //假如玩家死亡
                                                                                    //print("player dead")
                                                                                    //self!.nextBattle()
                                                              
                                                                                    self!.failedToGetElement()
                                                                                }else {
                                                                                    
                                                                                    //繼續比賽
                                                                                    self!.continueBattle()
                                                                                    
                                                                                }
                                                                                
                                                                                
                                                                            })
                                                                            
                                                                            
                                                                        } else {
                                                                            
                                                                            //繼續比賽
                                                                            self!.continueBattle()
                   
                                                                        }
                                                                        
                                                                        
                                                                    }
                                                                    
                                                                    
                                                                })
      
                                                            }

                                                        }
                                                            
                                                        })
                                                        
                                                    } else {
                                                        
                                                        //檢查是否有治癒
                                                        
                                                        if self!.petHeal > 0{
                                                            
                                                            self!.heal(point: CGFloat((self!.petHeal)), whom: player, finished: {
                                                                
                                                                self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                                
                                                                //換怪攻擊人
                                                                //顯示字樣
                                                                comboAttack.alpha = 1
                                                                comboAttack.fontColor = .cyan
                                                                comboAttack.text = "怪物攻擊:\(monsterAttackPoint)"
                                                                
                                                                self!.attack(point: CGFloat(monsterAttackPoint), whom: player, finished: {
                                                                    
                                                                    //隱藏字樣
                                                                    
                                                                    self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                                    
                                                                    if self!.playerBlood == 0 {
                                                                        //假如玩家死亡
                                                                        //print("player dead")
                                                                        //self!.nextBattle()
                                                                        self!.failedToGetElement()
                                                                    } else {
                                                                        //假如人還沒死
                                                                        //確認有無怪物魔法攻擊
                                                                        
                                                                        if monsterMagicAttackPoint > 0 {
                                                                            //有的話就魔法攻擊人
                                                                            //顯示怪物魔法字樣
                                                                            comboAttack.alpha = 1
                                                                            comboAttack.fontColor = self!.pinkColor
                                                                            comboAttack.text = "怪物魔法: \(monsterMagicAttackPoint)"
                                                                            
                                                                            self!.attack(point: monsterMagicAttackPoint, whom: player, finished: {
                                                                                
                                                                                //隱藏字樣
                                                                                self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                                                
                                                                                if self!.playerBlood == 0 {
                                                                                    //假如玩家死亡
                                                                                    //print("player dead")
                                                                                    //self!.nextBattle()
                                                            
                                                                                    self!.failedToGetElement()
                                                                                }else {
                                                                                    
                                                                                    //繼續比賽
                                                                                    self!.continueBattle()
                                                                                    
                                                                                }
                                                                                
                                                                            })
                                                                            
                                                                            
                                                                        } else {
                                                                            
                                                                            //繼續比賽
                                                                            self!.continueBattle()
                                                                            
                                                                            
                                                                        }
                                                                        
                                                                        
                                                                    }
                                                                    
                                                                    
                                                                })

                                                                
                                                            })
                                                            
                                                            
                                                            
                                                        } else {
                                                        
                                                        
                                                        
                                                        //換怪攻擊人
                                                        //顯示字樣
                                                        comboAttack.alpha = 1
                                                        comboAttack.fontColor = .cyan
                                                        comboAttack.text = "怪物攻擊:\(monsterAttackPoint)"
                                                        
                                                        self!.attack(point: CGFloat(monsterAttackPoint), whom: player, finished: {
                                                            
                                                            //隱藏字樣
                                        
                                                            self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                            
                                                            if self!.playerBlood == 0 {
                                                                //假如玩家死亡
                                                                //print("player dead")
                                                                //self!.nextBattle()
                                                                self!.failedToGetElement()
                                                                
                                                            } else {
                                                                //假如人還沒死
                                                                //確認有無怪物魔法攻擊
                                                                
                                                                if monsterMagicAttackPoint > 0 {
                                                                    //有的話就魔法攻擊人
                                                                    //顯示怪物魔法字樣
                                                                    comboAttack.alpha = 1
                                                                    comboAttack.fontColor = self!.pinkColor
                                                                    comboAttack.text = "怪物魔法: \(monsterMagicAttackPoint)"
                                                                    
                                                                    self!.attack(point: monsterMagicAttackPoint, whom: player, finished: {
                                                                        
                                                                        //隱藏字樣
                                                                        self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                                        
                                                                        if self!.playerBlood == 0 {
                                                                            //假如玩家死亡
                                                                            //print("player dead")
                                                                            //self!.nextBattle()
                                                               
                                                                            self!.failedToGetElement()
                                                                        }else {
                                                                            
                                                                            //繼續比賽
                                                                            self!.continueBattle()
                                                                            
                                                                        }

                                                                    })
                                                                    
                                                                    
                                                                } else {
                                                                    
                                                                    //繼續比賽
                                                                    self!.continueBattle()
       
                                                                    
                                                                }
                                                                
                                                                
                                                            }
                                                            
                                                            
                                                        })
       
                                                    }
                                                }
                                                    
                                                }
                                                
                                            })
                                            
                                        } else {
                                            //看有沒有爆擊
                                            if isDoubleHit{
                                                //有的話就普攻再打一次, 做一個爆擊動畫func
                                                //爆擊字樣
                                                comboAttack.text = "爆擊: \(attackPoint)"
                                                
                                                self!.attack(point: CGFloat(attackPoint), whom: monster, finished: {
                                                    
                                                    //隱藏字樣
                                                    self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                    
                                                    //怪死的話
                                                    if self!.monsterBlood == 0 {
                                                        //這局結束
                                                        //下一場比賽
                                                        self!.nextBattle()
                                                        
                                                    } else {
                                                        //檢查是否有治癒術
                                                        if self!.petHeal > 0 {
                                                            //治癒
                                  
                                                            
                                                            self!.heal(point: CGFloat(self!.petHeal), whom: player, finished: {
                                                                
                                                                self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                                
                                                                
                                                                //換怪攻人
                                                                
                                                                //顯示字樣
                                                                comboAttack.alpha = 1
                                                                comboAttack.fontColor = .cyan
                                                                comboAttack.text = "怪物攻擊:\(monsterAttackPoint)"
                                                                
                                                                self!.attack(point: CGFloat(monsterAttackPoint), whom: player, finished: {
                                                                    
                                                                    //隱藏字樣
                                                                    self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                                    
                                                                    if self!.playerBlood == 0 {
                                                                        //假如玩家死亡
                                                                        //print("player dead")
                                                                        //self!.nextBattle()
                                                                        self!.failedToGetElement()
                                                                    } else {
                                                                        //假如人還沒死
                                                                        //確認有無怪物魔法攻擊
                                                                        
                                                                        if monsterMagicAttackPoint > 0 {
                                                                            //有的話就魔法攻擊人
                                                                            
                                                                            //顯示字樣
                                                                            comboAttack.alpha = 1
                                                                            comboAttack.fontColor = self!.pinkColor
                                                                            comboAttack.text = "怪物魔法: \(monsterMagicAttackPoint)"
                                                                            
                                                                            self!.attack(point: monsterMagicAttackPoint, whom: player, finished: {
                                                                                
                                                                                //隱藏字樣
                                                                                self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                                                if self!.playerBlood == 0 {
                                                                                    //假如玩家死亡
                                                                                    //print("player dead")
                                                                                    //self!.nextBattle()
                                                    
                                                                                    self!.failedToGetElement()
                                                                                }else {
                                                                                    
                                                                                    //繼續比賽
                                                                                    self!.continueBattle()
                                                                                    
                                                                                }
                                                                                
                                                                                
                                                                            })
                                                                            
                                                                            
                                                                        } else {
                                                                            
                                                                            //繼續比賽
                                                                            self!.continueBattle()
                                                                            
                                                                            
                                                                        }
                                                                        
                                                                        
                                                                    }
                                                                    
                                                                    
                                                                })
 
                                                                
                                                            })
                                   
                                                            
                                                        } else {

                                                        //換怪攻人
                                                        
                                                        //顯示字樣
                                                        comboAttack.alpha = 1
                                                        comboAttack.fontColor = .cyan
                                                        comboAttack.text = "怪物攻擊:\(monsterAttackPoint)"
                                                        
                                                        self!.attack(point: CGFloat(monsterAttackPoint), whom: player, finished: {
                                                            
                                                            //隱藏字樣
                                                            self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                            
                                                            if self!.playerBlood == 0 {
                                                                //假如玩家死亡
                                                                //print("player dead")
                                                                //self!.nextBattle()
                                                                self!.failedToGetElement()
                                                            } else {
                                                                //假如人還沒死
                                                                //確認有無怪物魔法攻擊
                                                                
                                                                if monsterMagicAttackPoint > 0 {
                                                                    //有的話就魔法攻擊人
                                                                    
                                                                    //顯示字樣
                                                                    comboAttack.alpha = 1
                                                                    comboAttack.fontColor = self!.pinkColor
                                                                    comboAttack.text = "怪物魔法: \(monsterMagicAttackPoint)"
                                                                    
                                                                    self!.attack(point: monsterMagicAttackPoint, whom: player, finished: {
                                                                        
                                                                        //隱藏字樣
                                                                        self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                                        if self!.playerBlood == 0 {
                                                                            //假如玩家死亡
                                                                            //print("player dead")
                                                                            //self!.nextBattle()
                                                 
                                                                            self!.failedToGetElement()
                                                                        }else {
                                                                            
                                                                            //繼續比賽
                                                                            self!.continueBattle()
                                                                            
                                                                        }
                                                                        
                                                                        
                                                                    })
                                                                    
                                                                    
                                                                } else {
                                                                    
                                                                    //繼續比賽
                                                                    self!.continueBattle()
           
                                                                    
                                                                }
                                                                
                                                                
                                                            }
                                                            
                                                            
                                                        })
            
                                                    }
                                                }
                                                    
                                                })
                      
                                            } else {
                                                //沒有的話就換怪攻擊
                                                
                                                if self!.petHeal > 0 {
                                                    //治癒術

                                                    self!.heal(point: CGFloat(self!.petHeal), whom: player, finished: {
                                                        
                                                        
                                                        self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                        
                                                        //顯示字樣
                                                        comboAttack.alpha = 1
                                                        comboAttack.fontColor = .cyan
                                                        comboAttack.text = "怪物攻擊:\(monsterAttackPoint)"
                                                        
                                                        self!.attack(point: CGFloat(monsterAttackPoint), whom: player, finished: {
                                                            
                                                            //隱藏字樣
                                                            self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                            
                                                            if self!.playerBlood == 0 {
                                                                //假如玩家死亡
                                                                //print("player dead")
                                                                //self!.nextBattle()
                                                                self!.failedToGetElement()
                                                            } else {
                                                                //假如人還沒死
                                                                //確認有無怪物魔法攻擊
                                                                
                                                                if monsterMagicAttackPoint > 0 {
                                                                    //有的話就魔法攻擊人
                                                                    
                                                                    //顯示字樣
                                                                    comboAttack.alpha = 1
                                                                    comboAttack.fontColor = self!.pinkColor
                                                                    comboAttack.text = "怪物魔法: \(monsterMagicAttackPoint)"
                                                                    
                                                                    self!.attack(point: monsterMagicAttackPoint, whom: player, finished: {
                                                                        
                                                                        //隱藏字樣
                                                                        self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                                        
                                                                        
                                                                        if self!.playerBlood == 0 {
                                                                            //假如玩家死亡
                                                                            //print("player dead")
                                                                            //self!.nextBattle()
                                                               self!.failedToGetElement()
                                                                        }else {
                                                                            
                                                                            //繼續比賽
                                                                            self!.continueBattle()
                                                                            
                                                                        }
                                                                        
                                                                        
                                                                    })
                                                                    
                                                                    
                                                                } else {
                                                                    
                                                                    //繼續比賽
                                                                    self!.continueBattle()
                                                                    
                                                                    
                                                                }
                                                                
                                                                
                                                            }
                                                            
                                                            
                                                        })

                                                        
                                                    })
                                                    
                                                    
                                                } else {
                                                
                                                
                                                //顯示字樣
                                                comboAttack.alpha = 1
                                                comboAttack.fontColor = .cyan
                                                comboAttack.text = "怪物攻擊:\(monsterAttackPoint)"
                                                
                                                self!.attack(point: CGFloat(monsterAttackPoint), whom: player, finished: {
                                                    
                                                    //隱藏字樣
                                                    self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                    
                                                    if self!.playerBlood == 0 {
                                                        //假如玩家死亡
                                                        //print("player dead")
                                                        //self!.nextBattle()
                                                        self!.failedToGetElement()
                                                    } else {
                                                        //假如人還沒死
                                                        //確認有無怪物魔法攻擊
                                                        
                                                        if monsterMagicAttackPoint > 0 {
                                                            //有的話就魔法攻擊人
                                                            
                                                            //顯示字樣
                                                            comboAttack.alpha = 1
                                                            comboAttack.fontColor = self!.pinkColor
                                                            comboAttack.text = "怪物魔法: \(monsterMagicAttackPoint)"
                                                            
                                                            self!.attack(point: monsterMagicAttackPoint, whom: player, finished: {
                                                                
                                                                //隱藏字樣
                                                                self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                                

                                                                if self!.playerBlood == 0 {
                                                                    //假如玩家死亡
                                                                    //print("player dead")
                                                                    //self!.nextBattle()
                                                                    self!.failedToGetElement()
                                                                }else {
                                                                    
                                                                    //繼續比賽
                                                                    self!.continueBattle()
                                                                    
                                                                }
                                                                
                                                                
                                                            })
                                                            
                                                            
                                                        } else {
                                                            
                                                            //繼續比賽
                                                            self!.continueBattle()
    
                                                            
                                                        }
                                                        
                                                        
                                                    }
                                                    
                                                    
                                                })
       
                                                
                                            }
                                            
                                        }

                                        }
                                        
                                    }
                                })
                                
                              
                            })
                            
                            
                        })
                        */
                        
                    } else {
                        //答案錯誤
                        
                        //移除線
                        //放大後消失移除
                        
                         enlargeAndDisappear(name: "aimer")
                         enlargeAndDisappear(name: "aimerCircle")
                         enlargeAndDisappear(name: "aimerHeart")
                        
                        removeSomeNodes(name: "line")
                        battleModeWrong()
                        
                        /*
                        //抓正確音節數有幾個
                        var correctSyllableCounts = Int()
                        let syllableCounts = currentWordArray.count
                        let enterCounts = wordEntered.count
                        var checkCounts = Int()
                        
                        if enterCounts > syllableCounts {
                            
                            checkCounts = syllableCounts
                        } else {
                            
                            checkCounts = enterCounts
                        }
                        
                        //確認總共對幾個音節
                        for i in 0 ..< checkCounts{
                            
                            if wordEntered[i] == currentWordArray[i] {
                                correctSyllableCounts += 1
                            }
                        }
                        
                        
                        //放大後消失移除
                        enlargeAndDisappear(name: "aimer")
                        enlargeAndDisappear(name: "aimerCircle")
                        enlargeAndDisappear(name: "aimerHeart")
                        
                        
                        //先閃紅字 +  再攻擊
                        findLabelNode(name: "tempWord").run(wrongAnswerAction(), completion: {[weak self] in
                            //等待攻擊動畫秒數後扣分
                            // let when = DispatchTime.now() + 2.3
                            
                            // DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                            
                            
                            //算爆擊機率
                            //模擬爆擊機率: 答案錯誤為零
                            let doubleRate:Int = 0
                            let randomNumber = Int(arc4random_uniform(UInt32(100)))
                            var isDoubleHit = false
                            if randomNumber <= doubleRate{
                                isDoubleHit = true
                            }
                            
                            //總攻擊單位數 =  (人攻*按照正確音節比例 - 怪防) ***假如攻擊力小於防禦就視為0
                            var attackPoint = Int()
                            if correctSyllableCounts > 0 {
                                if (self!.petAttack * correctSyllableCounts / syllableCounts) > self!.monsterDef{
                                    attackPoint = (self!.petAttack * correctSyllableCounts / syllableCounts - self!.monsterDef)
                                } else{
                                    
                                    attackPoint = 0
                                }
                            } else {
                              
                                attackPoint = 0
                            }
                            
                            //怪攻擊單位數 = (怪攻 - 人防)
                            let monsterAttackPoint = (CGFloat(self!.monsterAtt) - CGFloat(self!.petDefense))
                            
                            //模擬屬性攻擊
                            let petType = "wood"
                            
                            //怪物魔攻屬性
                            var monsterMagicTimes:CGFloat = 1
                            
                            //再做一個判斷怪屬性攻擊倍數的switch
                            switch self!.monsterType{
                                
                            case "wood":
                                if petType == "earth"{
                                    monsterMagicTimes = 1.5
                                } else if petType == "metal"{
                                    monsterMagicTimes = 0.5
                                }
                            case "earth":
                                if petType == "water"{
                                    monsterMagicTimes = 1.5
                                } else if petType == "wood"{
                                    monsterMagicTimes = 0.5
                                }
                                
                            case "water":
                                if petType == "fire"{
                                    monsterMagicTimes = 1.5
                                } else if petType == "earth"{
                                    monsterMagicTimes = 0.5
                                }
                                
                            case "fire":
                                if petType == "metal"{
                                    monsterMagicTimes = 1.5
                                } else if petType == "water"{
                                    monsterMagicTimes = 0.5
                                }
                                
                            case "metal":
                                if petType == "wood"{
                                    monsterMagicTimes = 1.5
                                } else if petType == "fire"{
                                    monsterMagicTimes = 0.5
                                }
                                
                            default:
                                break
                                
                            }
                            
                            //怪魔法攻擊單位算法
                            let monsterMagicAttackPoint = CGFloat(self!.monsterMagic) * monsterMagicTimes
                            
                            //show普攻字
                            let comboAttack = self!.findLabelNode(name: "comboAttack")
                            comboAttack.alpha = 1
                        
                            
                            if attackPoint > 0{
                                    comboAttack.fontColor = .green
                                comboAttack.text = "失誤普攻: \(attackPoint)"
                            } else {
                                
                                comboAttack.fontColor = .red
                                comboAttack.text = "未擊中怪物"
                            }
                            
                            //先普攻
                            self!.attack(point: CGFloat(attackPoint), whom: monster, finished: {
                                
                                self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                
                                self!.removeSomeNodes(name: "line")
                                
                                //假如怪死
                                if self!.monsterBlood == 0 {
                                    //這局結束
                                    //下一場比賽
                                    self!.nextBattle()
                                    
                                } else {
                                    //確認是否有治癒
                                    if self!.petHeal > 0 {
                                        
                                        
                                        self!.heal(point: CGFloat(self!.petHeal), whom: player, finished: {
                                            
                                            
                                            self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                            
                                            //怪打人
                                            
                                            comboAttack.alpha = 1
                                            comboAttack.fontColor = .blue
                                            comboAttack.text = "怪物攻擊: \(monsterAttackPoint)"
                                            
                                            self!.attack(point: CGFloat(monsterAttackPoint), whom: player, finished: {
                                                
                                                self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                
                                                //假如人死
                                                if self!.playerBlood == 0 {
                                                    //這局結束
                                                    //下一場比賽
                                                    //self!.nextBattle()
                                                    self!.failedToGetElement()
                                                } else {
                                                    
                                                    //假如人沒死
                                                    
                                                    //確認怪有沒有魔攻
                                                    if monsterMagicAttackPoint > 0 {
                                                        //有的話就魔法攻擊人
                                                        
                                                        comboAttack.alpha = 1
                                                        comboAttack.fontColor = self!.pinkColor
                                                        comboAttack.text = "怪物魔法: \(monsterMagicAttackPoint)"
                                                        
                                                        self!.attack(point: monsterMagicAttackPoint, whom: player, finished: {
                                                            
                                                            self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)

                                                            
                                                            if self!.playerBlood == 0 {
                                                                //假如玩家死亡
                                                                //print("player dead")
                                                                //self!.nextBattle()
                                                                self!.failedToGetElement()
                                                            }else {
                                                                
                                                                //繼續比賽
                                                                self!.continueBattle()
                                                                
                                                            }
                                                            
                                                            
                                                        })
                                                        
                                                        
                                                    } else {
                                                        
                                                        //繼續比賽
                                                        self!.continueBattle()
                                                        
                                                    }
                                                    

                                                }
                                                
                                                
                                            })

                                        })
                                        

                                    } else {
                                    
                                    
                                    //怪打人
                                    
                                    comboAttack.alpha = 1
                                    comboAttack.fontColor = .blue
                                    comboAttack.text = "怪物攻擊: \(monsterAttackPoint)"
                                    
                                    self!.attack(point: CGFloat(monsterAttackPoint), whom: player, finished: {
                                        
                                        self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                        
                                        //假如人死
                                        if self!.playerBlood == 0 {
                                            //這局結束
                                            //下一場比賽
                                            //self!.nextBattle()
                                            self!.failedToGetElement()
                                        } else {
                                            
                                            //假如人沒死
                                            
                                            //確認怪有沒有魔攻
                                            if monsterMagicAttackPoint > 0 {
                                                //有的話就魔法攻擊人
                                                
                                                comboAttack.alpha = 1
                                                comboAttack.fontColor = self!.pinkColor
                                                comboAttack.text = "怪物魔法: \(monsterMagicAttackPoint)"
                                                
                                                self!.attack(point: monsterMagicAttackPoint, whom: player, finished: {
                                                    
                                                    self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                    
                                                    if self!.playerBlood == 0 {
                                                        //假如玩家死亡
                                                        //print("player dead")
                                                        //self!.nextBattle()
                                                        self!.failedToGetElement()
                                                    }else {
                                                        
                                                        //繼續比賽
                                                        self!.continueBattle()
                                                        
                                                    }
                                                    
                                                    
                                                })
                                                
                                                
                                            } else {
                                                
                                                //繼續比賽
                                                self!.continueBattle()
                                                
                                            }
                                            

                                            
                                        }
                                        

                                    })
                                    
                                }
                            }
                            })
                            
                        })
                        
                        */
                    }
                    
                    
                } else {
                    
                    // Part 2.練習模式
                    
                    //移除上一次的發亮按鈕
                    removeSomeNodes(name: "new")
                    //移除上一次的線
                    removeSomeNodes(name: "line")
                    
                    //初始化
                    selNodeNames = ["se0","se1","se2","se3","se4"]
                    
                    for touch in touches{
                        let lastTouch = touch.location(in: self)
                        
                        let node : SKNode = self.atPoint(lastTouch)
                        
                        //是否修改線
                        if node.name == selNodeNames[0] || node.name == selNodeNames[1] || node.name == selNodeNames[2] || node.name == selNodeNames[3] || node.name == selNodeNames[4]{
                            
                            //最後有碰到node, 不修改線
                            
                        } else {
                            //最後一個沒碰到node的話, 一放開縮短線
                            
                            isEndOnNode = false
                            
                            drawLine()
                            
                        }
                        
                    }
                    
                    /*
                     //固定線
                     line = SKShapeNode()
                     line?.strokeColor = diamondGreen
                     line?.lineWidth = 8
                     line?.name = "line"
                     line?.zPosition = 4
                     line?.glowWidth = 2
                     addChild(line!)
                     */
                    
                    //初始化
                    isFirstTouch = false
                    touchTimes = 0
                    isTouched = false
                    nodesTouched.removeAll(keepingCapacity: false)
                    
                    //假如答案正確
                    if wordEntered == currentWordArray{
                        
                        //部首音節變色...
                        
                        //1. 把顯示的輸入字刪除
                        findLabelNode(name: "tempWord").text = ""
                        
                        //2. 顯示原本有音節變色的字
                        
                        for node in children{
                            if (node.name?.contains("engWord"))!{
                                changeLabelAlfa(name: node.name!, toAlpha: 1, time: 0.3)
                                
                            }
                            
                        }
                        
                        //不能按畫面
                        self.isUserInteractionEnabled = false
                        
                        //避免再次顯示掃描線
                        isScanning = true
                        
                        //播放單字
                        self.scanAndPronounce()
                        
                        //輸入正確音節數歸零
                        //alreadyCorrectsyllables = 0
                        
                        //初始化
                        shownWords.removeAll(keepingCapacity: false)
                        wordEntered.removeAll(keepingCapacity: false)
                        
                        //正確數+1
                        correctTime += 1
                        
                        let when = DispatchTime.now() + 0.5
                        
                        //關上任務版
                        DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                            
                            //確認練習幾次後跳轉
                            if self!.correctTime < 1 {
                                //再次練習
                                
                                //能按畫面
                                self!.isUserInteractionEnabled = true
                                
                                //選項顏色變淡+移除選項字
                                for node in self!.children{
                                    
                                    if (node.name?.contains("filledButton"))!{
                                        self!.changeImageAlfa(name: node.name!, toAlpha: 0, time: 0)
                                    }
                                    
                                    if (node.name?.contains("emptyButton"))!{
                                        self!.changeImageAlfa(name: node.name!, toAlpha: 0, time: 0)
                                    }
                                    
                                    if (node.name?.contains("Sel"))!{
                                        node.removeFromParent()
                                    }
                                }
                                
                                //再次啟動練習
                                self!.learningTest()
                                self!.isButtonEnable = false
                                
                            } else {
                                //繼續產生學習單字
                                //self!.dotSparkingFunc()
                                
                                let when = DispatchTime.now() + 0.5
                                
                                DispatchQueue.main.asyncAfter(deadline: when, execute: {
                                    
                                    //把順序+1
                                    
                                    
                                    //if self!.currentWordSequence < self!.wordSets.count / 4 - 1{
                                    
                                    if self!.currentWordSequence < (self!.unitNumber + 1) * 3 - 1{
                                        
                                        self!.currentWordSequence += 1
                                        
                                        //解除practiceMode
                                        self!.isPracticeMode = false
                                        
                                        //正確數歸零
                                        self!.correctTime = 0
                                        
                                        //播放次數歸零
                                        self!.playSoundTime = 0
                                        
                                        //點點消失
                                        /*
                                        self!.findImageNode(name: "lDot1").alpha = 0
                                        self!.findImageNode(name: "lDot2").alpha = 0
                                        self!.findImageNode(name: "lDot3").alpha = 0
                                        
                                        self!.findImageNode(name: "bDot1").alpha = 0
                                        self!.findImageNode(name: "bDot2").alpha = 0
                                        self!.findImageNode(name: "bDot3").alpha = 0
                                        */
                                        
                                        //任務版重來
                                        self!.closeQuestBoardAndReopen()
                                        
                                        //不能dragAndPlay
                                        self!.isDragAndPlayEnable = false
                                        
                                    } else {
                                        //
                                        //self!.currentWordSequence = 0
                                        
                                        //三個字學完後
                                        self!.currentWordSequence  = self!.unitNumber * 3
                                        
                                        //進入battleMode
                                        self!.battleMode()
                                        
                                        
                                    }
                                    
                                })
                                
                            }
                        })
                        
                    } else {
                        
                        //答案錯誤的機制
                    
                        //不能按畫面
                        self.isUserInteractionEnabled = false
                        //避免再次顯示掃描線
                        isScanning = true
                        //把輸入過的答案移除
                        wordEntered.removeAll(keepingCapacity: false)
                        
                        
                        findLabelNode(name: "tempWord").run(wrongAnswerAction(), completion: {[weak self] in
                            
                            //能按畫面
                            self!.isUserInteractionEnabled = true
                            
                            //選項顏色變淡+移除選項字
                            for node in self!.children{
                                
                                if (node.name?.contains("filledButton"))!{
                                    self!.changeImageAlfa(name: node.name!, toAlpha: 0, time: 0)
                                }
                                
                                //把選項字回復成白色
                                if (node.name?.contains("Sel"))!{
                                    
                                    if let node = node as? SKLabelNode{
                                        
                                        node.fontColor = .white
                                        
                                    }
                                    
                                    //把輸入字刪除
                                    
                                    self!.findLabelNode(name: "tempWord").text = ""
                                    
                                }
                                
                            }
                            
                            self!.isButtonEnable = false
                            
                            //能再次按發音
                            self!.isScanning = false
                            
                        })
                        
                    }
                    
                }
            }
        }
    }
    
    func battleModeRight(){
        
        
        //指定名稱的變數
        let monster = "monsterBlood"
        let player = "playerBlood"
        
        //show中文字
        changeLabelAlfa(name: "chiWord", toAlpha: 1, time: 0.1)
        
        //show正確
        let comboAttack = findLabelNode(name: "comboAttack")
        comboAttack.alpha = 1
        comboAttack.fontColor = .green
        comboAttack.text = "CORRECT！"
        
        
        //把temp字改顏色
        let tempNode = findLabelNode(name: "tempWord")
        let changeColor = SKAction.colorize(with: pinkColor, colorBlendFactor: 1, duration: 0.3)
        tempNode.run(changeColor, completion: {[weak self] in
            
            //隱藏正確字樣
            self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.1)
            
            //自我爆炸動畫
            let explode = SKAction.run({
                self!.explodeEmitter?.isHidden = false
                self!.explodeEmitter?.resetSimulation()
                
            })
            //等待爆炸秒數
            let waitAction = SKAction.wait(forDuration: 0.7)
            let sequence = SKAction.sequence([explode,waitAction])
            
            //temp自我爆炸後攻擊怪物
            self!.run(sequence, completion: {
                
                //正確攻擊
                self!.findImageNode(name: "monster").run(self!.rightAttack())
                
                //移除上一次的線
                //self!.removeSomeNodes(name: "line")
                
                
            })
            
            
            //等待攻擊動畫秒數後扣分
            let when = DispatchTime.now() + 2.3
            
            DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                
                //算爆擊機率
                let randomNumber = Int(arc4random_uniform(UInt32(100)))
                var isDoubleHit = false
                if randomNumber <= self!.petDouble{
                    isDoubleHit = true
                }
                
                
                // 總魔攻單位數 = (人的魔攻屬性 * 0.5/1/1.5)
                //模擬屬性攻擊
                let petType = self!.petType
                
                var magicTimes:CGFloat = 1
                
                //計算寵物攻擊怪的屬性倍數
                switch petType{
                    
                case "wood":
                    if self!.monsterType == "earth"{
                        magicTimes = 1.5
                    } else if self!.monsterType == "metal"{
                        magicTimes = 0.5
                    }
                case "earth":
                    if self!.monsterType == "water"{
                        magicTimes = 1.5
                    } else if self!.monsterType == "wood"{
                        magicTimes = 0.5
                    }
                    
                case "water":
                    if self!.monsterType == "fire"{
                        magicTimes = 1.5
                    } else if self!.monsterType == "earth"{
                        magicTimes = 0.5
                    }
                    
                case "fire":
                    if self!.monsterType == "metal"{
                        magicTimes = 1.5
                    } else if self!.monsterType == "water"{
                        magicTimes = 0.5
                    }
                    
                case "metal":
                    if self!.monsterType == "wood"{
                        magicTimes = 1.5
                    } else if self!.monsterType == "fire"{
                        magicTimes = 0.5
                    }
                    
                default:
                    break
                    
                }
                
                
                //計算怪屬性攻擊倍數
                var monsterMagicTimes:CGFloat = 1
                
                //再做一個判斷怪屬性攻擊倍數的switch
                switch self!.monsterType{
                    
                case "wood":
                    if petType == "earth"{
                        monsterMagicTimes = 1.5
                    } else if petType == "metal"{
                        monsterMagicTimes = 0.5
                    }
                case "earth":
                    if petType == "water"{
                        monsterMagicTimes = 1.5
                    } else if petType == "wood"{
                        monsterMagicTimes = 0.5
                    }
                    
                case "water":
                    if petType == "fire"{
                        monsterMagicTimes = 1.5
                    } else if petType == "earth"{
                        monsterMagicTimes = 0.5
                    }
                    
                case "fire":
                    if petType == "metal"{
                        monsterMagicTimes = 1.5
                    } else if petType == "water"{
                        monsterMagicTimes = 0.5
                    }
                    
                case "metal":
                    if petType == "wood"{
                        monsterMagicTimes = 1.5
                    } else if petType == "fire"{
                        monsterMagicTimes = 0.5
                    }
                    
                default:
                    break
                    
                }
                
                
                //總攻擊單位數 =  (人攻 - 怪防)
                var attackPoint = CGFloat(self!.petAttack) * (magicTimes) - CGFloat(self!.monsterDef)
                
                //計算亂數
                attackPoint = self!.randomPoint(points: attackPoint)
                
                
                
                //怪攻擊單位數 = (怪攻 - 人防)
                var monsterAttackPoint = CGFloat(self!.monsterAtt) * monsterMagicTimes - CGFloat(self!.petDefense)
                
                //計算亂數
                monsterAttackPoint = self!.randomPoint(points: monsterAttackPoint)
                
                
                
                //人魔法攻擊單位算法
                var magicAttackPoint = CGFloat(self!.petExtra) * magicTimes
                
                //計算亂數
                magicAttackPoint = self!.randomPoint(points: magicAttackPoint)
                
                
                //怪魔法攻擊單位算法
                var monsterMagicAttackPoint = CGFloat(self!.monsterMagic) * monsterMagicTimes
                
                //計算亂數
                monsterMagicAttackPoint = self!.randomPoint(points: monsterMagicAttackPoint)
                
                
                //show普攻字
                //let comboAttack = self!.findLabelNode(name: "comboAttack")
                comboAttack.alpha = 1
                comboAttack.text = "普攻: \(attackPoint)"
                
                
                //先普攻
                self!.attack(point: CGFloat(attackPoint), whom: monster, finished: {
                    
                    //隱藏普攻字
                    self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                    
                    //假如怪死
                    if self!.monsterBlood == 0 {
                        //這局結束
                        //下一場比賽
                        self!.nextBattle()
                        
                    } else {
                        //假如怪沒死再魔攻
                        
                        //假如有魔攻擊
                        if magicAttackPoint > 0 {
                            
                            //顯示魔攻字樣
                            comboAttack.alpha = 1
                            comboAttack.fontColor = .yellow
                            comboAttack.text = "魔攻: \(magicAttackPoint)"
                            
                            self!.attack(point: magicAttackPoint, whom: monster, finished: {
                                
                                self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                
                                //怪死的話
                                if self!.monsterBlood == 0 {
                                    //這局結束
                                    //下一場比賽
                                    self!.nextBattle()
                                    
                                } else {
                                    //確認是否有爆擊
                                    if isDoubleHit{
                                        
                                        //顯示爆擊字樣
                                        comboAttack.alpha = 1
                                        comboAttack.text = "爆擊: \(CGFloat(attackPoint) + magicAttackPoint)"
                                        
                                        //爆擊攻擊 普+魔
                                        
                                        let comboPoints = CGFloat(attackPoint) + magicAttackPoint
                                        self!.attack(point: comboPoints, whom: monster, finished: {
                                            
                                            //怪死的話
                                            if self!.monsterBlood == 0 {
                                                //這局結束
                                                //下一場比賽
                                                self!.nextBattle()
                                                
                                            } else {
                                                //檢查是否有治癒
                                                if self!.petHeal > 0{
                                                    
                                                    //補血
                                                    self!.heal(point: CGFloat((self!.petHeal)), whom: player, finished: {
                                                        
                                                        self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                        
                                                        //換怪攻擊人
                                                        
                                                        //怪普攻字樣
                                                        comboAttack.alpha = 1
                                                        comboAttack.fontColor = .cyan
                                                        comboAttack.text = "怪物攻擊:\(monsterAttackPoint)"
                                                        
                                                        self!.attack(point: CGFloat(monsterAttackPoint), whom: player, finished: {
                                                            
                                                            //隱藏字樣
                                                            self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                            
                                                            if self!.playerBlood == 0 {
                                                                //假如玩家死亡
                                                                //print("player dead")
                                                                //self!.nextBattle()
                                                                
                                                                self!.failedToGetElement()
                                                            } else {
                                                                //假如人還沒死
                                                                //確認有無怪物魔法攻擊
                                                                
                                                                if monsterMagicAttackPoint > 0 {
                                                                    //有的話就魔法攻擊人
                                                                    
                                                                    //怪魔法攻擊字樣
                                                                    comboAttack.alpha = 1
                                                                    comboAttack.fontColor = self!.pinkColor
                                                                    comboAttack.text = "怪物魔法: \(monsterMagicAttackPoint)"
                                                                    
                                                                    self!.attack(point: monsterMagicAttackPoint, whom: player, finished: {
                                                                        
                                                                        //隱藏字樣
                                                                        self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                                        
                                                                        if self!.playerBlood == 0 {
                                                                            //假如玩家死亡
                                                                            //print("player dead")
                                                                            //self!.nextBattle()
                                                                            
                                                                            self!.failedToGetElement()
                                                                        }else {
                                                                            
                                                                            //繼續比賽
                                                                            self!.continueBattle()
                                                                            
                                                                        }
                                                                        
                                                                        
                                                                    })
                                                                    
                                                                    
                                                                } else {
                                                                    
                                                                    //繼續比賽
                                                                    self!.continueBattle()
                                                                    
                                                                }
                                                                
                                                                
                                                            }
                                                            
                                                            
                                                        })
                                                        
                                                    })
                                                    
                                                    
                                                    
                                                    
                                                } else {
                                                    
                                                    
                                                    //換怪攻擊人
                                                    
                                                    //怪普攻字樣
                                                    comboAttack.alpha = 1
                                                    comboAttack.fontColor = .cyan
                                                    comboAttack.text = "怪物攻擊:\(monsterAttackPoint)"
                                                    
                                                    self!.attack(point: CGFloat(monsterAttackPoint), whom: player, finished: {
                                                        
                                                        //隱藏字樣
                                                        self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                        
                                                        if self!.playerBlood == 0 {
                                                            //假如玩家死亡
                                                            //print("player dead")
                                                            //self!.nextBattle()
                                                            self!.failedToGetElement()
                                                        } else {
                                                            //假如人還沒死
                                                            //確認有無怪物魔法攻擊
                                                            
                                                            if monsterMagicAttackPoint > 0 {
                                                                //有的話就魔法攻擊人
                                                                
                                                                //怪魔法攻擊字樣
                                                                comboAttack.alpha = 1
                                                                comboAttack.fontColor = self!.pinkColor
                                                                comboAttack.text = "怪物魔法: \(monsterMagicAttackPoint)"
                                                                
                                                                self!.attack(point: monsterMagicAttackPoint, whom: player, finished: {
                                                                    
                                                                    //隱藏字樣
                                                                    self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                                    
                                                                    if self!.playerBlood == 0 {
                                                                        //假如玩家死亡
                                                                        //print("player dead")
                                                                        //self!.nextBattle()
                                                                        
                                                                        self!.failedToGetElement()
                                                                    }else {
                                                                        
                                                                        //繼續比賽
                                                                        self!.continueBattle()
                                                                        
                                                                    }
                                                                    
                                                                    
                                                                })
                                                                
                                                                
                                                            } else {
                                                                
                                                                //繼續比賽
                                                                self!.continueBattle()
                                                                
                                                            }
                                                            
                                                            
                                                        }
                                                        
                                                        
                                                    })
                                                    
                                                }
                                                
                                            }
                                            
                                        })
                                        
                                    } else {
                                        
                                        //檢查是否有治癒
                                        
                                        if self!.petHeal > 0{
                                            
                                            self!.heal(point: CGFloat((self!.petHeal)), whom: player, finished: {
                                                
                                                self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                
                                                //換怪攻擊人
                                                //顯示字樣
                                                comboAttack.alpha = 1
                                                comboAttack.fontColor = .cyan
                                                comboAttack.text = "怪物攻擊:\(monsterAttackPoint)"
                                                
                                                self!.attack(point: CGFloat(monsterAttackPoint), whom: player, finished: {
                                                    
                                                    //隱藏字樣
                                                    
                                                    self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                    
                                                    if self!.playerBlood == 0 {
                                                        //假如玩家死亡
                                                        //print("player dead")
                                                        //self!.nextBattle()
                                                        self!.failedToGetElement()
                                                    } else {
                                                        //假如人還沒死
                                                        //確認有無怪物魔法攻擊
                                                        
                                                        if monsterMagicAttackPoint > 0 {
                                                            //有的話就魔法攻擊人
                                                            //顯示怪物魔法字樣
                                                            comboAttack.alpha = 1
                                                            comboAttack.fontColor = self!.pinkColor
                                                            comboAttack.text = "怪物魔法: \(monsterMagicAttackPoint)"
                                                            
                                                            self!.attack(point: monsterMagicAttackPoint, whom: player, finished: {
                                                                
                                                                //隱藏字樣
                                                                self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                                
                                                                if self!.playerBlood == 0 {
                                                                    //假如玩家死亡
                                                                    //print("player dead")
                                                                    //self!.nextBattle()
                                                                    
                                                                    self!.failedToGetElement()
                                                                }else {
                                                                    
                                                                    //繼續比賽
                                                                    self!.continueBattle()
                                                                    
                                                                }
                                                                
                                                            })
                                                            
                                                            
                                                        } else {
                                                            
                                                            //繼續比賽
                                                            self!.continueBattle()
                                                            
                                                            
                                                        }
                                                        
                                                        
                                                    }
                                                    
                                                    
                                                })
                                                
                                                
                                            })
                                            
                                            
                                            
                                        } else {
                                            
                                            
                                            
                                            //換怪攻擊人
                                            //顯示字樣
                                            comboAttack.alpha = 1
                                            comboAttack.fontColor = .cyan
                                            comboAttack.text = "怪物攻擊:\(monsterAttackPoint)"
                                            
                                            self!.attack(point: CGFloat(monsterAttackPoint), whom: player, finished: {
                                                
                                                //隱藏字樣
                                                
                                                self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                
                                                if self!.playerBlood == 0 {
                                                    //假如玩家死亡
                                                    //print("player dead")
                                                    //self!.nextBattle()
                                                    self!.failedToGetElement()
                                                    
                                                } else {
                                                    //假如人還沒死
                                                    //確認有無怪物魔法攻擊
                                                    
                                                    if monsterMagicAttackPoint > 0 {
                                                        //有的話就魔法攻擊人
                                                        //顯示怪物魔法字樣
                                                        comboAttack.alpha = 1
                                                        comboAttack.fontColor = self!.pinkColor
                                                        comboAttack.text = "怪物魔法: \(monsterMagicAttackPoint)"
                                                        
                                                        self!.attack(point: monsterMagicAttackPoint, whom: player, finished: {
                                                            
                                                            //隱藏字樣
                                                            self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                            
                                                            if self!.playerBlood == 0 {
                                                                //假如玩家死亡
                                                                //print("player dead")
                                                                //self!.nextBattle()
                                                                
                                                                self!.failedToGetElement()
                                                            }else {
                                                                
                                                                //繼續比賽
                                                                self!.continueBattle()
                                                                
                                                            }
                                                            
                                                        })
                                                        
                                                        
                                                    } else {
                                                        
                                                        //繼續比賽
                                                        self!.continueBattle()
                                                        
                                                        
                                                    }
                                                    
                                                    
                                                }
                                                
                                                
                                            })
                                            
                                        }
                                    }
                                    
                                }
                                
                            })
                            
                        } else {
                            //看有沒有爆擊
                            if isDoubleHit{
                                //有的話就普攻再打一次, 做一個爆擊動畫func
                                //爆擊字樣
                                comboAttack.text = "爆擊: \(attackPoint)"
                                
                                self!.attack(point: CGFloat(attackPoint), whom: monster, finished: {
                                    
                                    //隱藏字樣
                                    self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                    
                                    //怪死的話
                                    if self!.monsterBlood == 0 {
                                        //這局結束
                                        //下一場比賽
                                        self!.nextBattle()
                                        
                                    } else {
                                        //檢查是否有治癒術
                                        if self!.petHeal > 0 {
                                            //治癒
                                            
                                            
                                            self!.heal(point: CGFloat(self!.petHeal), whom: player, finished: {
                                                
                                                self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                
                                                
                                                //換怪攻人
                                                
                                                //顯示字樣
                                                comboAttack.alpha = 1
                                                comboAttack.fontColor = .cyan
                                                comboAttack.text = "怪物攻擊:\(monsterAttackPoint)"
                                                
                                                self!.attack(point: CGFloat(monsterAttackPoint), whom: player, finished: {
                                                    
                                                    //隱藏字樣
                                                    self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                    
                                                    if self!.playerBlood == 0 {
                                                        //假如玩家死亡
                                                        //print("player dead")
                                                        //self!.nextBattle()
                                                        self!.failedToGetElement()
                                                    } else {
                                                        //假如人還沒死
                                                        //確認有無怪物魔法攻擊
                                                        
                                                        if monsterMagicAttackPoint > 0 {
                                                            //有的話就魔法攻擊人
                                                            
                                                            //顯示字樣
                                                            comboAttack.alpha = 1
                                                            comboAttack.fontColor = self!.pinkColor
                                                            comboAttack.text = "怪物魔法: \(monsterMagicAttackPoint)"
                                                            
                                                            self!.attack(point: monsterMagicAttackPoint, whom: player, finished: {
                                                                
                                                                //隱藏字樣
                                                                self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                                if self!.playerBlood == 0 {
                                                                    //假如玩家死亡
                                                                    //print("player dead")
                                                                    //self!.nextBattle()
                                                                    
                                                                    self!.failedToGetElement()
                                                                }else {
                                                                    
                                                                    //繼續比賽
                                                                    self!.continueBattle()
                                                                    
                                                                }
                                                                
                                                                
                                                            })
                                                            
                                                            
                                                        } else {
                                                            
                                                            //繼續比賽
                                                            self!.continueBattle()
                                                            
                                                            
                                                        }
                                                        
                                                        
                                                    }
                                                    
                                                    
                                                })
                                                
                                                
                                            })
                                            
                                            
                                        } else {
                                            
                                            //換怪攻人
                                            
                                            //顯示字樣
                                            comboAttack.alpha = 1
                                            comboAttack.fontColor = .cyan
                                            comboAttack.text = "怪物攻擊:\(monsterAttackPoint)"
                                            
                                            self!.attack(point: CGFloat(monsterAttackPoint), whom: player, finished: {
                                                
                                                //隱藏字樣
                                                self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                
                                                if self!.playerBlood == 0 {
                                                    //假如玩家死亡
                                                    //print("player dead")
                                                    //self!.nextBattle()
                                                    self!.failedToGetElement()
                                                } else {
                                                    //假如人還沒死
                                                    //確認有無怪物魔法攻擊
                                                    
                                                    if monsterMagicAttackPoint > 0 {
                                                        //有的話就魔法攻擊人
                                                        
                                                        //顯示字樣
                                                        comboAttack.alpha = 1
                                                        comboAttack.fontColor = self!.pinkColor
                                                        comboAttack.text = "怪物魔法: \(monsterMagicAttackPoint)"
                                                        
                                                        self!.attack(point: monsterMagicAttackPoint, whom: player, finished: {
                                                            
                                                            //隱藏字樣
                                                            self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                            if self!.playerBlood == 0 {
                                                                //假如玩家死亡
                                                                //print("player dead")
                                                                //self!.nextBattle()
                                                                
                                                                self!.failedToGetElement()
                                                            }else {
                                                                
                                                                //繼續比賽
                                                                self!.continueBattle()
                                                                
                                                            }
                                                            
                                                            
                                                        })
                                                        
                                                        
                                                    } else {
                                                        
                                                        //繼續比賽
                                                        self!.continueBattle()
                                                        
                                                        
                                                    }
                                                    
                                                    
                                                }
                                                
                                                
                                            })
                                            
                                        }
                                    }
                                    
                                })
                                
                            } else {
                                //沒有的話就換怪攻擊
                                
                                if self!.petHeal > 0 {
                                    //治癒術
                                    
                                    self!.heal(point: CGFloat(self!.petHeal), whom: player, finished: {
                                        
                                        
                                        self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                        
                                        //顯示字樣
                                        comboAttack.alpha = 1
                                        comboAttack.fontColor = .cyan
                                        comboAttack.text = "怪物攻擊:\(monsterAttackPoint)"
                                        
                                        self!.attack(point: CGFloat(monsterAttackPoint), whom: player, finished: {
                                            
                                            //隱藏字樣
                                            self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                            
                                            if self!.playerBlood == 0 {
                                                //假如玩家死亡
                                                //print("player dead")
                                                //self!.nextBattle()
                                                self!.failedToGetElement()
                                            } else {
                                                //假如人還沒死
                                                //確認有無怪物魔法攻擊
                                                
                                                if monsterMagicAttackPoint > 0 {
                                                    //有的話就魔法攻擊人
                                                    
                                                    //顯示字樣
                                                    comboAttack.alpha = 1
                                                    comboAttack.fontColor = self!.pinkColor
                                                    comboAttack.text = "怪物魔法: \(monsterMagicAttackPoint)"
                                                    
                                                    self!.attack(point: monsterMagicAttackPoint, whom: player, finished: {
                                                        
                                                        //隱藏字樣
                                                        self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                        
                                                        
                                                        if self!.playerBlood == 0 {
                                                            //假如玩家死亡
                                                            //print("player dead")
                                                            //self!.nextBattle()
                                                            self!.failedToGetElement()
                                                        }else {
                                                            
                                                            //繼續比賽
                                                            self!.continueBattle()
                                                            
                                                        }
                                                        
                                                        
                                                    })
                                                    
                                                    
                                                } else {
                                                    
                                                    //繼續比賽
                                                    self!.continueBattle()
                                                    
                                                    
                                                }
                                                
                                                
                                            }
                                            
                                            
                                        })
                                        
                                        
                                    })
                                    
                                    
                                } else {
                                    
                                    
                                    //顯示字樣
                                    comboAttack.alpha = 1
                                    comboAttack.fontColor = .cyan
                                    comboAttack.text = "怪物攻擊:\(monsterAttackPoint)"
                                    
                                    self!.attack(point: CGFloat(monsterAttackPoint), whom: player, finished: {
                                        
                                        //隱藏字樣
                                        self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                        
                                        if self!.playerBlood == 0 {
                                            //假如玩家死亡
                                            //print("player dead")
                                            //self!.nextBattle()
                                            self!.failedToGetElement()
                                        } else {
                                            //假如人還沒死
                                            //確認有無怪物魔法攻擊
                                            
                                            if monsterMagicAttackPoint > 0 {
                                                //有的話就魔法攻擊人
                                                
                                                //顯示字樣
                                                comboAttack.alpha = 1
                                                comboAttack.fontColor = self!.pinkColor
                                                comboAttack.text = "怪物魔法: \(monsterMagicAttackPoint)"
                                                
                                                self!.attack(point: monsterMagicAttackPoint, whom: player, finished: {
                                                    
                                                    //隱藏字樣
                                                    self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                                    
                                                    
                                                    if self!.playerBlood == 0 {
                                                        //假如玩家死亡
                                                        //print("player dead")
                                                        //self!.nextBattle()
                                                        self!.failedToGetElement()
                                                    }else {
                                                        
                                                        //繼續比賽
                                                        self!.continueBattle()
                                                        
                                                    }
                                                    
                                                    
                                                })
                                                
                                                
                                            } else {
                                                
                                                //繼續比賽
                                                self!.continueBattle()
                                                
                                                
                                            }
                                            
                                            
                                        }
                                        
                                        
                                    })
                                    
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                })
                
                
            })
            
            
        })
        
    }
    
    func battleModeWrong(){
        
        //指定名稱的變數
        let monster = "monsterBlood"
        let player = "playerBlood"
        
        //抓正確音節數有幾個
        var correctSyllableCounts = Int()
        let syllableCounts = currentWordArray.count
        let enterCounts = wordEntered.count
        var checkCounts = Int()
        
        if enterCounts > syllableCounts {
            
            checkCounts = syllableCounts
        } else {
            
            checkCounts = enterCounts
        }
        
        //確認總共對幾個音節
        for i in 0 ..< checkCounts{
            
            if wordEntered[i] == currentWordArray[i] {
                correctSyllableCounts += 1
            }
        }
        
        
        //放大後消失移除
        /*
        enlargeAndDisappear(name: "aimer")
        enlargeAndDisappear(name: "aimerCircle")
        enlargeAndDisappear(name: "aimerHeart")
        */
        
        //show正確
        let comboAttack = findLabelNode(name: "comboAttack")
        comboAttack.alpha = 1
        comboAttack.fontColor = .red
        comboAttack.text = "WRONG！"
        
        //先閃紅字 +  再攻擊
        findLabelNode(name: "tempWord").run(wrongAnswerAction(), completion: {[weak self] in
            //等待攻擊動畫秒數後扣分
            // let when = DispatchTime.now() + 2.3
            
            // DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
            
            //隱藏正確字樣
            self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.1)
            
            //算爆擊機率
            //模擬爆擊機率: 答案錯誤為零
            let doubleRate:Int = 0
            let randomNumber = Int(arc4random_uniform(UInt32(100)))
            var isDoubleHit = false
            if randomNumber <= doubleRate{
                isDoubleHit = true
            }
            
            //總攻擊單位數 =  (人攻*按照正確音節比例 - 怪防) ***假如攻擊力小於防禦就視為0
            var attackPoint = Int()
            if correctSyllableCounts > 0 {
                if (self!.petAttack * correctSyllableCounts / syllableCounts) > self!.monsterDef{
                    attackPoint = (self!.petAttack * correctSyllableCounts / syllableCounts - self!.monsterDef)
                } else{
                    
                    attackPoint = 0
                }
            } else {
                
                attackPoint = 0
            }
            
            //怪攻擊單位數 = (怪攻 - 人防)
            let monsterAttackPoint = (CGFloat(self!.monsterAtt) - CGFloat(self!.petDefense))
            
            //模擬屬性攻擊
            let petType = "wood"
            
            //怪物魔攻屬性
            var monsterMagicTimes:CGFloat = 1
            
            //再做一個判斷怪屬性攻擊倍數的switch
            switch self!.monsterType{
                
            case "wood":
                if petType == "earth"{
                    monsterMagicTimes = 1.5
                } else if petType == "metal"{
                    monsterMagicTimes = 0.5
                }
            case "earth":
                if petType == "water"{
                    monsterMagicTimes = 1.5
                } else if petType == "wood"{
                    monsterMagicTimes = 0.5
                }
                
            case "water":
                if petType == "fire"{
                    monsterMagicTimes = 1.5
                } else if petType == "earth"{
                    monsterMagicTimes = 0.5
                }
                
            case "fire":
                if petType == "metal"{
                    monsterMagicTimes = 1.5
                } else if petType == "water"{
                    monsterMagicTimes = 0.5
                }
                
            case "metal":
                if petType == "wood"{
                    monsterMagicTimes = 1.5
                } else if petType == "fire"{
                    monsterMagicTimes = 0.5
                }
                
            default:
                break
                
            }
            
            //怪魔法攻擊單位算法
            let monsterMagicAttackPoint = CGFloat(self!.monsterMagic) * monsterMagicTimes
            
            //show普攻字
            let comboAttack = self!.findLabelNode(name: "comboAttack")
            comboAttack.alpha = 1
            
            
            if attackPoint > 0{
                comboAttack.fontColor = .green
                comboAttack.text = "失誤普攻: \(attackPoint)"
            } else {
                
                comboAttack.fontColor = .red
                comboAttack.text = "未擊中怪物"
            }
            
            //先普攻
            self!.attack(point: CGFloat(attackPoint), whom: monster, finished: {
                
                self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                
                //移除線的功能在外面先做好
                //self!.removeSomeNodes(name: "line")
                
                //假如怪死
                if self!.monsterBlood == 0 {
                    //這局結束
                    //下一場比賽
                    self!.nextBattle()
                    
                } else {
                    //確認是否有治癒
                    if self!.petHeal > 0 {
                        
                        
                        self!.heal(point: CGFloat(self!.petHeal), whom: player, finished: {
                            
                            
                            self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                            
                            //怪打人
                            
                            comboAttack.alpha = 1
                            comboAttack.fontColor = .blue
                            comboAttack.text = "怪物攻擊: \(monsterAttackPoint)"
                            
                            self!.attack(point: CGFloat(monsterAttackPoint), whom: player, finished: {
                                
                                self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                
                                //假如人死
                                if self!.playerBlood == 0 {
                                    //這局結束
                                    //下一場比賽
                                    //self!.nextBattle()
                                    self!.failedToGetElement()
                                } else {
                                    
                                    //假如人沒死
                                    
                                    //確認怪有沒有魔攻
                                    if monsterMagicAttackPoint > 0 {
                                        //有的話就魔法攻擊人
                                        
                                        comboAttack.alpha = 1
                                        comboAttack.fontColor = self!.pinkColor
                                        comboAttack.text = "怪物魔法: \(monsterMagicAttackPoint)"
                                        
                                        self!.attack(point: monsterMagicAttackPoint, whom: player, finished: {
                                            
                                            self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                            
                                            
                                            if self!.playerBlood == 0 {
                                                //假如玩家死亡
                                                //print("player dead")
                                                //self!.nextBattle()
                                                self!.failedToGetElement()
                                            }else {
                                                
                                                //繼續比賽
                                                self!.continueBattle()
                                                
                                            }
                                            
                                            
                                        })
                                        
                                        
                                    } else {
                                        
                                        //繼續比賽
                                        self!.continueBattle()
                                        
                                    }
                                    
                                    
                                }
                                
                                
                            })
                            
                        })
                        
                        
                    } else {
                        
                        
                        //怪打人
                        
                        comboAttack.alpha = 1
                        comboAttack.fontColor = .blue
                        comboAttack.text = "怪物攻擊: \(monsterAttackPoint)"
                        
                        self!.attack(point: CGFloat(monsterAttackPoint), whom: player, finished: {
                            
                            self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                            
                            //假如人死
                            if self!.playerBlood == 0 {
                                //這局結束
                                //下一場比賽
                                //self!.nextBattle()
                                self!.failedToGetElement()
                            } else {
                                
                                //假如人沒死
                                
                                //確認怪有沒有魔攻
                                if monsterMagicAttackPoint > 0 {
                                    //有的話就魔法攻擊人
                                    
                                    comboAttack.alpha = 1
                                    comboAttack.fontColor = self!.pinkColor
                                    comboAttack.text = "怪物魔法: \(monsterMagicAttackPoint)"
                                    
                                    self!.attack(point: monsterMagicAttackPoint, whom: player, finished: {
                                        
                                        self!.changeLabelAlfa(name: "comboAttack", toAlpha: 0, time: 0.5)
                                        
                                        if self!.playerBlood == 0 {
                                            //假如玩家死亡
                                            //print("player dead")
                                            //self!.nextBattle()
                                            self!.failedToGetElement()
                                        }else {
                                            
                                            //繼續比賽
                                            self!.continueBattle()
                                            
                                        }
                                        
                                        
                                    })
                                    
                                    
                                } else {
                                    
                                    //繼續比賽
                                    self!.continueBattle()
                                    
                                }
                                
                                
                                
                            }
                            
                            
                        })
                        
                    }
                }
            })
            
        })

        
        
    }
    
    
    func zoomIn() -> SKAction{
        
        let zoomIn = SKAction.resize(toWidth: 100, height: 100, duration: 0.1)
        return zoomIn
    }
    func zoomOut() -> SKAction{
        
        let zoomOut = SKAction.resize(toWidth: 144, height: 144, duration: 0.2)
        return zoomOut
    }

    
    func randomPoint(points:CGFloat) -> CGFloat{
        
        var returnPoints = CGFloat()
        returnPoints = points
        
        let attackRan = Int(arc4random_uniform(UInt32(returnPoints * 0.05)))
        let attackPlusOrMinus = Int(arc4random_uniform(UInt32(2)))
        if attackPlusOrMinus == 1 {
            returnPoints = returnPoints + CGFloat(attackRan)
        } else {
            
            returnPoints = returnPoints - CGFloat(attackRan)
            
        }

        return returnPoints
    }
    
    
    
    //失敗攻擊
    func missAttack() -> SKAction{
        
        //建立miss字
        makeLabelNode(x: 0, y: 445, alignMent: .center, fontColor: .white, fontSize: 60, text: "MISS", zPosition: 7, name: "miss", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        
        //fadein+fadeout
        let fadeIn = SKAction.fadeIn(withDuration: 0.2)
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let sequence = SKAction.sequence([fadeIn,fadeOut])
        
        //執行
        let action = SKAction.run {[weak self] in
            self!.findLabelNode(name: "miss").run(sequence) {[weak self] in
                self!.findLabelNode(name: "miss").removeFromParent()
                
            }
        }
        return action
        
    }
    
    //combo攻擊
    func comboAttack() -> SKAction{
        
        //所有會出現的圖, 這部分可以多加一點圖
        makeImageNode(name: "attEff", image: "attack3", x: 0, y: 455, width: 120, height: 120, z: 7, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "attEff2", image: "attack5", x: -40, y: 475, width: 40, height: 40, z: 6, alpha: 0, isAnchoring: false)
        makeImageNode(name: "attEff3", image: "attack5", x: -20, y: 455, width: 60, height: 66, z: 6, alpha: 0, isAnchoring: false)
        makeImageNode(name: "attEff4", image: "attack5", x: 40, y: 435, width: 15, height: 15, z: 6, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "starAttEff", image: "attack2", x: 0, y: 455, width: 100, height: 100, z: 7, alpha: 0, isAnchoring: false)
        
        
        //慢慢出現 1秒
        let appear = SKAction.fadeIn(withDuration: 1)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([appear,remove])
        
        //所有圖跑慢慢出現
        let action = SKAction.run {[weak self] in
            
            self!.findImageNode(name: "attEff").run(sequence)
            self!.findImageNode(name: "attEff2").run(sequence)
            self!.findImageNode(name: "attEff3").run(sequence)
            self!.findImageNode(name: "attEff4").run(sequence)
            
        }
        
        
        //星星出現+變大+fadeout 0.17秒
        let starAppear = SKAction.fadeIn(withDuration: 0.05)
        let enlarge = SKAction.resize(toWidth: 130, height: 130, duration: 0.02)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let backToSize = SKAction.resize(toWidth: 65, height: 65, duration: 0)
        let starSequence = SKAction.sequence([starAppear,enlarge,fadeOut,backToSize])
        
        //星星改變位置
        let pos = CGPoint(x: 40, y: 500)
        let pos2 = CGPoint(x: -20, y: 400)
        let changePosition = SKAction.move(to: pos, duration: 0)
        let chagePosition2 = SKAction.move(to: pos2, duration: 0)
        
        //合併
        let changePosSequence = SKAction.sequence([starSequence,changePosition,starSequence,chagePosition2,starSequence])
        
        //星星攻擊特效
        let effect = SKAction.run {[weak self] in
            self!.findImageNode(name: "starAttEff").run(changePosSequence, completion: {
                self!.findImageNode(name: "starAttEff").removeFromParent()
            })
            
        }
        
        //等待慢慢出現後星星攻擊
        let wait = SKAction.wait(forDuration: 1)
        let effectSequence = SKAction.sequence([action,wait,effect])
        
        //monster震動動畫, 需搭配monster.run
        let point1 = CGPoint(x: 20, y: -140)
        let point2 = CGPoint(x: 0, y: -150)
        let move1 = SKAction.move(to: point1, duration: 0.1)
        let move2 = SKAction.move(to: point2, duration: 0.1)
        let wait2 = SKAction.wait(forDuration: 1)
        let tremble = SKAction.sequence([move1,move2])
        let tremble3Times = SKAction.repeat(tremble, count: 3)
        let waitAndTremble = SKAction.sequence([wait2,tremble3Times])
        
        let groupAction = SKAction.group([waitAndTremble,effectSequence])
        
        //輸出動畫
        return groupAction
    }
    
    
    //答對時的攻擊, 旋轉後攻擊
    func rightAttack() -> SKAction {
        
        //所有效果
        makeImageNode(name: "pinkAttEff", image: "attack4", x: 20, y: -150, width: 159, height: 137, z: 6, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "darkAttEff", image: "attack1", x: -10, y: -210, width: 111 * 0.5, height: 92 * 0.5, z: 6, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "attEff", image: "attack3", x: 80, y: -190, width: 70, height: 70, z: 7, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "attEff2", image: "attack5", x: -70, y: -250, width: 40, height: 40, z: 6, alpha: 0, isAnchoring: false)
        makeImageNode(name: "attEff3", image: "attack5", x: -50, y: -230, width: 60, height: 66, z: 6, alpha: 0, isAnchoring: false)
        makeImageNode(name: "attEff4", image: "attack5", x: 40, y: -220, width: 15, height: 15, z: 6, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "attEff5", image: "attack3", x: -100, y: -145, width: 120, height: 120, z: 6, alpha: 0, isAnchoring: false)
        
        //出現後旋轉 1秒
        let appear = SKAction.fadeIn(withDuration: 0.2)
        let rotate = SKAction.rotate(byAngle: 0.5, duration: 0.8)
        let group = SKAction.group([appear,rotate])
        
        //fadeOut 0.2秒
        let fadeOut = SKAction.fadeOut(withDuration: 0.2)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([group,fadeOut,remove])
        
        //全體都出現旋轉後移除
        let action = SKAction.run {[weak self] in
            
            self!.findImageNode(name: "pinkAttEff").run(sequence)
            self!.findImageNode(name: "darkAttEff").run(sequence)
            self!.findImageNode(name: "attEff").run(sequence)
            self!.findImageNode(name: "attEff2").run(sequence)
            self!.findImageNode(name: "attEff3").run(sequence)
            self!.findImageNode(name: "attEff4").run(sequence)
            self!.findImageNode(name: "attEff5").run(sequence)
            
        }
        
        //主要攻擊圖
        makeImageNode(name: "solidAttEff", image: "attack5", x: -40, y: -180, width: 80, height: 88, z: 6, alpha: 0, isAnchoring: false)
        
        //出現+變大+消失 0.17秒
        let appear2 = SKAction.fadeIn(withDuration: 0.05)
        let enlarge = SKAction.resize(toWidth: 130, height: 130, duration: 0.02)
        let fadeOut2 = SKAction.fadeOut(withDuration: 0.1)
        let backToSize = SKAction.resize(toWidth: 65, height: 65, duration: 0)
        let sequence2 = SKAction.sequence([appear2,enlarge,fadeOut2,backToSize])
        
        //等待出現後旋轉 + 改變兩個位置來攻擊 1秒
        let pos = CGPoint(x: 40, y: -155)
        let pos2 = CGPoint(x: -20, y: -255)
        let changePosition = SKAction.move(to: pos, duration: 0)
        let chagePosition2 = SKAction.move(to: pos2, duration: 0)
        let wait = SKAction.wait(forDuration: 1)
        let changePosSequence = SKAction.sequence([wait,sequence2,changePosition,sequence2,chagePosition2,sequence2])
        
        //攻擊動畫
        let runThis = SKAction.run {[weak self] in
            self!.findImageNode(name: "solidAttEff").run(changePosSequence, completion: {
                self!.removeSomeNodes(name: "solidAttEff")
            })
            
        }
        
        //把出現+旋轉+攻擊 合一
        let finalSequence = SKAction.sequence([action,runThis])
        
        //怪物震動動畫, 必須用monster來run
        let point1 = CGPoint(x: 20, y: -140)
        let point2 = CGPoint(x: 0, y: -150)
        let move1 = SKAction.move(to: point1, duration: 0.1)
        let move2 = SKAction.move(to: point2, duration: 0.1)
        let wait2 = SKAction.wait(forDuration: 1.2)
        let tremble = SKAction.sequence([move1,move2])
        let tremble3Times = SKAction.repeat(tremble, count: 3)
        let waitAndTremble = SKAction.sequence([wait2,tremble3Times])
        let groupAction = SKAction.group([waitAndTremble,finalSequence])
        
        //輸出
        return groupAction
        
    }
    
    //一般攻擊
    func normalAttack() -> SKAction{
        
        //會出現的圖
        makeImageNode(name: "hollowAttEff", image: "attack6", x: 0, y: 455, width: 65, height: 65, z: 5, alpha: 0, isAnchoring: false)
        makeImageNode(name: "solidAttEff", image: "attack5", x: -40, y: 475, width: 80, height: 88, z: 6, alpha: 0, isAnchoring: false)
        makeImageNode(name: "lightAttEff", image: "attack3", x: 0, y: 455, width: 120, height: 120, z: 7, alpha: 0, isAnchoring: false)
        
        //快速閃:出現+放大+fadeOut+變回原型 * 3
        let appear = SKAction.fadeIn(withDuration: 0.05)
        let enlarge = SKAction.resize(toWidth: 130, height: 130, duration: 0.02)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let backToSize = SKAction.resize(toWidth: 65, height: 65, duration: 0)
        let sequence = SKAction.sequence([appear,enlarge,fadeOut,backToSize])
        let repeat3Times = SKAction.repeat(sequence, count: 3)
        
        //改變位置
        let pos = CGPoint(x: 40, y: 500)
        let pos2 = CGPoint(x: -20, y: 400)
        let changePosition = SKAction.move(to: pos, duration: 0)
        let chagePosition2 = SKAction.move(to: pos2, duration: 0)
        let changePosSequence = SKAction.sequence([sequence,changePosition,sequence,chagePosition2,sequence])
        
        //合併
        let effect = SKAction.run {[weak self] in
            
            //先快速閃爍結束後再改變位置
            self!.findImageNode(name: "hollowAttEff").run(repeat3Times, completion: {
                
                self!.findImageNode(name: "hollowAttEff").removeFromParent()
                
                self!.findImageNode(name: "solidAttEff").run(changePosSequence, completion: {
                    
                    self!.findImageNode(name: "solidAttEff").removeFromParent()
                    
                })
            })
            
        }
        
        //怪物震動動畫, 必須用monster來run
        
        let point1 = CGPoint(x: 20, y: -140)
        let point2 = CGPoint(x: 0, y: -150)
        let move1 = SKAction.move(to: point1, duration: 0.1)
        let move2 = SKAction.move(to: point2, duration: 0.1)
        let wait = SKAction.wait(forDuration: 0.51)
        let tremble = SKAction.sequence([move1,move2])
        let tremble3Times = SKAction.repeat(tremble, count: 3)
        let waitAndTremble = SKAction.sequence([wait,tremble3Times])
        let groupAction = SKAction.group([waitAndTremble,effect])
        
        //輸出動畫
        return groupAction
        
    }
    
    func nextBattle(){
        
        //更改怪物出現次序
        /*
         if monsterSequence < monsters.count - 1 {
         monsterSequence += 1
         } else {
         monsterSequence = 0
         }
         */
        //初始化
        shownWords.removeAll(keepingCapacity: false)
        wordEntered.removeAll(keepingCapacity: false)
        battleComboTime = 0
        
        //移除畫面
        removeSomeNodes(name: "monster")
        removeSomeNodes(name: "player")
        removeSomeNodes(name: "Frame")
        removeSomeNodes(name: "tempWord")
        
        //更改單字次序
        
        //if currentWordSequence < wordSets.count / 4 - 1{
        
        if currentWordSequence < (unitNumber + 1) * 3 - 1{
            
            currentWordSequence += 1
            
            //開始戰鬥, 建立下一個單字
            battleMode()
            
            
        }  else {
            
            //currentWordSequence = 0
            //currentWordSequence = unitNumber * 3

            //取得元素
            //取得User資料, 比對元素,
            
            if let getElements = user?["getElement"] as? String{
                
                
                if getElements.contains(syllablesToCheck){
                    
                    //有得到過, 暫時先跳回
                    
                    //跳轉回元素表
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "endUnit"), object: nil, userInfo: nil)
                    
                    //移除node及動畫
                    removeEverything()
                    
                    
                } else {
                    //得到元素
                    
                    //指定得到元素及使用者id
                    let element = syllablesToCheck
                    let id = user?["id"] as! String
                    
                    //在此要先確認此元素是否已滿, 滿的話就要提示刪除
                   
                    //列舉一般元素的func
                    let normalTypes = ["hp","att","def","heal","hit"]
                    
                    //確認背包是否已滿
                    var bagIsFull = Bool()
                    
                    //分析出func來看它是屬於背包的哪類元素, 並且設定好三個value準備傳送nc使用
                    for i in 0 ..< elements.count{
                        
                        if let name = elements[i]["name"] as String?{
                            
                            if element == name{
                                
                                if let type = elements[i]["func"]{
                                    //歸類normal以及排除rare
                                    
                                    //排除rare
                                    if !type.contains(","){
                                        
                                        //歸類normal
                                       
                                        if normalTypes.contains(type){
                                            
                                            //歸類為normal
                                            
                                            //如果滿的話
                                            if normalElemsFull{

                                                bagIsFull = true
                                                
                                                elemPageToPass = 0
                                                segIndexToPass = 0
                                                typeSegToPass = -1
                                                
                                            } else {
                                                
                                                  bagIsFull = false
                                                
                                            }

                                            
                                        } else {
                                            //另外歸類為屬性+合併
                                            
                                            switch type{
                                                
                                            case "metal":
                                                if metalElemsFull{
                                                    
                                                    //print("metal元素滿了")
                                                      bagIsFull = true
                                                    elemPageToPass = 1
                                                    segIndexToPass = 1
                                                    typeSegToPass = 0

                                                    
                                                } else {
                                                    
                                                    //print("metal元素還有")
                                                    bagIsFull = false
                                                }
                                            case "wood":
                                                if woodElemsFull{
                                                    //print("wood元素滿了")
                                                      bagIsFull = true
                                                    elemPageToPass = 2
                                                    segIndexToPass = 1
                                                    typeSegToPass = 1
                                                    
                                                    
                                                } else {
                                                
                                                    //print("wood元素還有")
                                                    bagIsFull = false
                                                }
                                            case "water":
                                                if waterElemsFull{
                                                    
                                                    //print("water元素滿了")
                                                      bagIsFull = true
                                                    elemPageToPass = 3
                                                    segIndexToPass = 1
                                                    typeSegToPass = 2
                                                    
                                                } else {
                                                    
                                                    //print("water元素還有")
                                                    bagIsFull = false
                                                }
                                            case "fire":
                                                if fireElemsFull{
                                                    
                                                    //print("fire元素滿了")
                                                      bagIsFull = true
                                                    elemPageToPass = 4
                                                    segIndexToPass = 1
                                                    typeSegToPass = 3
                                                    
                                                } else {
                                                    
                                                    //print("fire元素還有")
                                                    bagIsFull = false
                                                }
                                            case "earth":
                                                if earthElemsFull{
                                                    
                                                    //print("earth元素滿了")
                                                      bagIsFull = true
                                                    elemPageToPass = 5
                                                    segIndexToPass = 1
                                                    typeSegToPass = 4
                                                    
                                                    
                                                } else {
                                                    //print("earth元素還有")
                                                    bagIsFull = false
                                                    
                                                }
                                            case "upgrade":
                                                
                                                if let elemValue = elements[i]["value"] as String?{
                                                    
                                                    for (name,value) in upgradeElemsInfo {
                                                        
                                                        if value == elemValue{
                                                            
                                                            upgradeCount += 1
                                                            //append顯示名字
                                                            upgradeNames.append(name)
                                                            //所合併的寵物
                                                            upgradeValue = value
                                                            
                                                        }
                                                    }
                                                    
                                                    /*
                                                    for i in 0 ..< upgradeElems.count{
                                                        
                                                        if upgradeElems[i] == elemValue{
                                                            
                                                            upgradeCount += 1
                                                            
                                                        }
                    
                                                    }
                                                    */
                                                }
 
                                                if upgradeCount == 2 {
                                                    
                                                    isUpgrade = true
                                                    
                                                }
                                                
                                                //假如背包滿而且還沒要升級
                                                if combineElemsFull && isUpgrade == false{
                                                    
                                                    //print("合併元素滿了")
                                                    bagIsFull = true
                                                    
                                                    elemPageToPass = 6
                                                    segIndexToPass = 2
                                                    typeSegToPass = -1
                                                    
                                                } else {
                                                    
                                                    //print("合併元素還有")
                                                    bagIsFull = false
                                                    
                                                }
                                                
                                            default:
                                                break
                                            }
 
                                            
                                        }
           
                                        //以下為rare
                                    } else {
                                        
                                        
                                        
                                        if rareElemsFull{
                                            
                                            
                                            //print("rare元素滿了")
                                            bagIsFull = true
                                            
                                            elemPageToPass = 7
                                            segIndexToPass = 3
                                            typeSegToPass = -1
                                            
                                        } else {
                                            
                                            
                                            //print("rare元素還有")
                                            bagIsFull = false
                                        }
                      
                                        
                                    }
                         
                                }
                   
                                
                            }
                            
           
                        }
                        

                    }
                    
                    
                
                    //Part 1. 判斷是否寵物合併升級
                    //Part 2. 上方判斷完後就能知道背包是否已滿
                    
                    if isUpgrade {
                        
                        //如果要合併寵物的話
                        //Part 1. 合併動畫
                        //Part 2. 抓寵物圖片
                        //Part 3. 一樣跳回原畫面
                        //Part 4. 儲存關卡進度
                        
                        //print(upgradeElemsInfo)
                        //print(syllablesToCheck)
                        
                        notifyUpgrade()

                    } else if bagIsFull {
                        //背包滿了
                        
                        //Part 1. 在獲得畫面跳出警告, 警告完後往下
                        //Part 2. 跳到非遊戲的背包畫面
                        //Part 3. 顯示該元素頁面
                        //Part 4. 把所有selIndex重置
                        //Part 5. 規定一定要刪掉其中一個
                        //Part 6. 刪除完之後後端getElement + showElem
                        //Part 7. showElem之後跳到空位
                        //Part 8. 儲存關卡進度
                        
                        //通知背包已滿
                        notifyBagIsFull()
                        
                    } else {
                    
                        //背包還沒滿
                    
                    
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
                                
                                //紀錄關卡
                                if self!.unitNumber == 9{

                                    gamePassed = [self!.spotNumber + 1:0]
                                }else {
                                    
                                    gamePassed = [self!.spotNumber: self!.unitNumber + 1]
                                }
                                //然後儲存
                                let userDefaults = UserDefaults.standard
                                let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed!)
                                userDefaults.set(encodedObject, forKey: "gamePassed")


                                //得到元素動畫
                                self!.getElementAnimation()
                                
                            } catch{
                                
                                print("catch error")
                                
                                
                            }
                        } else {
                            
                            print("urlsession has error")
                            
                        }
                    }).resume()
                        }
                }
                
            }
            
        }
        
    }
    
    //快速抓圖片
    func makeImage(name:String) ->UIImage{
        let image = UIImage(named: name + ".png")
        return image!
    }
    
    
    
    //合併元素
    
    func notifyUpgrade(){
        
        //Part 1. 抓出三個元素
        //Part 2. 三個元素合併後發亮
        //Part 3. 浮現寵物
        //Part 4. 顯示寵物數值
        var node = SKSpriteNode()
        //var node1 = SKSpriteNode() //不用作中間那個元素的動畫
        var node2 = SKSpriteNode()
        
        //製作畫面
        makeImageNode(name: "getElementBg", image: "winBg", x: 0, y: 0, width: 750, height: 1334, z: 10, alpha: 1, isAnchoring: false)

        let elemImg = "combineGem"

        
        //顯示元素1
        makeImageNode(name: "getElement", image: elemImg, x: -250, y: 200, width: 200, height: 200, z: 11, alpha: 1, isAnchoring: false)
        //顯示元素2
        makeImageNode(name: "getElement1", image: elemImg, x: 0, y: 200, width: 200, height: 200, z: 16, alpha: 1, isAnchoring: false)
        //顯示元素3
        makeImageNode(name: "getElement2", image: elemImg, x: 250, y: 200, width: 200, height: 200, z: 11, alpha: 1, isAnchoring: false)
        
        
        //亮星星, 星星位置要抓
        makeImageNode(name: "1star", image: "star1", x: -160, y: -73, width: 100, height: 96.3, z: 11, alpha: 1, isAnchoring: false)
        makeImageNode(name: "2star", image: "star1", x: 00, y: -73, width: 100, height: 96.3, z: 11, alpha: 1, isAnchoring: false)
        makeImageNode(name: "3star", image: "star1", x: 160, y: -73, width: 100, height: 96.3, z: 11, alpha: 1, isAnchoring: false)
        
        let elemName = syllablesToCheck.components(separatedBy: .decimalDigits)
        let elemNum = syllablesToCheck.replacingOccurrences(of: elemName[0], with: "")
        
        let elemNameLabel = SKLabelNode()
        elemNameLabel.position = CGPoint(x: 0, y: -12)
        elemNameLabel.horizontalAlignmentMode = .center
        elemNameLabel.fontSize = 45
        elemNameLabel.text = elemName[0]
        elemNameLabel.name = "elemNameLabel"
        elemNameLabel.fontName = "Helvetica Bold"
        elemNameLabel.fontColor = .black
        elemNameLabel.zPosition = 13
        
        let elemNumLabel = SKLabelNode()
        elemNumLabel.position = CGPoint(x: 28, y: -36)
        elemNumLabel.horizontalAlignmentMode = .center
        elemNumLabel.fontSize = 23
        elemNumLabel.text = elemNum
        elemNumLabel.name = "elemNumLabel"
        elemNumLabel.fontName = "Helvetica Bold"
        elemNumLabel.fontColor = .black
        elemNumLabel.zPosition = 14
        
        if let elemImgNode = findImageNode(name: "getElement") as SKSpriteNode?{
            elemImgNode.addChild(elemNameLabel)
            elemImgNode.addChild(elemNumLabel)
            node = elemImgNode
        }

        
        //讀upgradeElemsInfo裡的名字
        let firstElemName = upgradeNames[0]
        let elemName1 = firstElemName.components(separatedBy: .decimalDigits)
        let elemNum1 = firstElemName.replacingOccurrences(of: elemName1[0], with: "")
        
        let elemNameLabel1 = SKLabelNode()
        elemNameLabel1.position = CGPoint(x: 0, y: -12)
        elemNameLabel1.horizontalAlignmentMode = .center
        elemNameLabel1.fontSize = 45
        elemNameLabel1.text = elemName1[0]
        elemNameLabel1.name = "elemNameLabel"
        elemNameLabel1.fontName = "Helvetica Bold"
        elemNameLabel1.fontColor = .black
        elemNameLabel1.zPosition = 17
        
        let elemNumLabel1 = SKLabelNode()
        elemNumLabel1.position = CGPoint(x: 28, y: -36)
        elemNumLabel1.horizontalAlignmentMode = .center
        elemNumLabel1.fontSize = 23
        elemNumLabel1.text = elemNum1
        elemNumLabel1.name = "elemNumLabel"
        elemNumLabel1.fontName = "Helvetica Bold"
        elemNumLabel1.fontColor = .black
        elemNumLabel1.zPosition = 18
        
        if let elemImgNode = findImageNode(name: "getElement1") as SKSpriteNode?{
            elemImgNode.addChild(elemNameLabel1)
            elemImgNode.addChild(elemNumLabel1)
            //node1 = elemImgNode //不用作中間那個元素的動畫

        }

        let secondElemName = upgradeNames[1]

        let elemName2 = secondElemName.components(separatedBy: .decimalDigits)
        let elemNum2 = secondElemName.replacingOccurrences(of: elemName2[0], with: "")
        let elemNameLabel2 = SKLabelNode()
        elemNameLabel2.position = CGPoint(x: 0, y: -12)
        elemNameLabel2.horizontalAlignmentMode = .center
        elemNameLabel2.fontSize = 45
        elemNameLabel2.text = elemName2[0]
        elemNameLabel2.name = "elemNameLabel"
        elemNameLabel2.fontName = "Helvetica Bold"
        elemNameLabel2.fontColor = .black
        elemNameLabel2.zPosition = 13
        
        let elemNumLabel2 = SKLabelNode()
        elemNumLabel2.position = CGPoint(x: 28, y: -36)
        elemNumLabel2.horizontalAlignmentMode = .center
        elemNumLabel2.fontSize = 23
        elemNumLabel2.text = elemNum2
        elemNumLabel2.name = "elemNumLabel"
        elemNumLabel2.fontName = "Helvetica Bold"
        elemNumLabel2.fontColor = .black
        elemNumLabel2.zPosition = 14
        
        if let elemImgNode = findImageNode(name: "getElement2") as SKSpriteNode?{
            elemImgNode.addChild(elemNameLabel2)
            elemImgNode.addChild(elemNumLabel2)
            node2 = elemImgNode
        }
        
        
        //三元素合一動畫
     
        let moveToRight = SKAction.moveTo(x: 0, duration: 0.5)
        let moveToLeft = SKAction.moveTo(x: 0, duration: 0.5)
        let disappear = SKAction.hide()
        let nodeAction = SKAction.sequence([moveToRight,disappear])
        let node2Action = SKAction.sequence([moveToLeft,disappear])
        
        node.run(nodeAction)
        node2.run(node2Action) {[weak self] in
            
            //發亮消失然後產生寵物
            
            self!.changeImageAlfa(name: "getElement", toAlpha: 0, time: 0.3)
            self!.changeImageAlfa(name: "getElement1", toAlpha: 0, time: 0.3)
            self!.changeImageAlfa(name: "getElement2", toAlpha: 0, time: 0.3)
            
            
            //產生寵物
            self!.makeImageNode(name: "petGet", image: self!.upgradeValue, x: 0, y: 200, width: 250, height: 250, z: 20, alpha: 0, isAnchoring: false)
          
            self!.changeImageAlfa(name: "petGet", toAlpha: 1, time: 0.5)
            
            self!.makeImageNode(name: "movingLight", image: "movingLight", x: 0, y: 200, width: 650, height: 601, z: 11, alpha: 1, isAnchoring: false)
            self!.makeImageNode(name: "movingLight2", image: "movingLight", x: 0, y: 200, width: 650, height: 601, z: 11, alpha: 1, isAnchoring: false)
            
            
            let movingLight = self!.childNode(withName: "movingLight") as! SKSpriteNode
            let movingLight2 = self!.childNode(withName: "movingLight2") as! SKSpriteNode
            let action = SKAction.rotate(toAngle: 360, duration: 5000)
            let action2 = SKAction.rotate(toAngle: -360, duration: 6000)
            movingLight.run(action)
            movingLight2.run(action2)
            
            for i in 0 ..< self!.partOnePets.count{
                if let petId = self!.partOnePets[i]["petId"] as! String?{
                    
                    if petId == self!.upgradeValue{
                        
                        if let petName = self!.partOnePets[i]["petName"] as! String?{

                        //製作文字
                        self!.makeLabelNode(x: 0, y: -220, alignMent: .center, fontColor: .white, fontSize: 40, text: "獲得新寵物: " + petName, zPosition: 14, name: "loseText", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
                        }
                        
                        //製作按鈕
                        self!.makeImageNode(name: "getPetButton", image: "okBtn", x: 0, y: -400, width:276, height: 144, z: 24, alpha: 1, isAnchoring: false)
                        
                        self!.isUserInteractionEnabled = true
                        
                        
                        
                    }
                    
                    
                    
                }
                
            }
            
            
        }
        
        
    }
    
    func notifyBagIsFull(){
        
     
        //製作畫面
        makeImageNode(name: "getElementBg", image: "winBg", x: 0, y: 0, width: 750, height: 1334, z: 10, alpha: 1, isAnchoring: false)
        makeImageNode(name: "movingLight", image: "movingLight", x: 0, y: 200, width: 650, height: 601, z: 11, alpha: 1, isAnchoring: false)
        makeImageNode(name: "movingLight2", image: "movingLight", x: 0, y: 200, width: 650, height: 601, z: 11, alpha: 1, isAnchoring: false)
       
        //製作按鈕
        makeImageNode(name: "okButton", image: "okBtn", x: 0, y: -400, width:276, height: 144, z: 14, alpha: 1, isAnchoring: false)
        
        //用紅底當警告
        makeNode(name: "getElementWarningBg", color: .red, x: 0, y: 0, width: 750, height: 1334, z: 13, isAnchoring: false, alpha: 0.5)
        
        //在此要抓元素的屬性來決定元素圖案
        var elemImg = "elemG"
        
        for i in 0 ..< elements.count{
            
            if syllablesToCheck == elements[i]["name"]{
                
                if let function = elements[i]["func"]{
                    
                    //不包含雙元素
                    if !function.contains(","){

                        switch function{
                            
                        case "hp":
                            elemImg = "normalGem"
                        case "att":
                            elemImg = "normalGem"
                        case "def":
                            elemImg = "normalGem"
                        case "hit":
                            elemImg = "normalGem"
                        case "heal":
                            elemImg = "normalGem"
                        case "wood":
                            elemImg = "woodGem"
                        case "earth":
                            elemImg = "earthGem"
                        case "water":
                            elemImg = "waterGem"
                        case "fire":
                            elemImg = "fireGem"
                        case "metal":
                            elemImg = "metalGem"
                        case "upgrade":
                            elemImg = "combineGem"
                            
                        default:
                            elemImg = "normalGem"
                            
                        }
                        
                        
                        
                    } else {
                        
                        elemImg = "rareGem"
                        
                        
                    }
                    
                }
                
            }
            
        }
        
        //顯示元素
        makeImageNode(name: "getElement", image: elemImg, x: 0, y: 200, width: 200, height: 200, z: 12, alpha: 1, isAnchoring: false)
        
        
        //製作文字
        makeLabelNode(x: 0, y: -220, alignMent: .center, fontColor: .white, fontSize: 40, text: "背包已滿，先丟掉不要的元素", zPosition: 14, name: "loseText", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        
        
        //亮星星, 星星位置要抓
        makeImageNode(name: "1star", image: "star1", x: -160, y: -73, width: 100, height: 96.3, z: 11, alpha: 1, isAnchoring: false)
        makeImageNode(name: "2star", image: "star1", x: 00, y: -73, width: 100, height: 96.3, z: 11, alpha: 1, isAnchoring: false)
        makeImageNode(name: "3star", image: "star1", x: 160, y: -73, width: 100, height: 96.3, z: 11, alpha: 1, isAnchoring: false)
        
        let movingLight = childNode(withName: "movingLight") as! SKSpriteNode
        let movingLight2 = childNode(withName: "movingLight2") as! SKSpriteNode
        let action = SKAction.rotate(toAngle: 360, duration: 5000)
        let action2 = SKAction.rotate(toAngle: -360, duration: 6000)
        movingLight.run(action)
        movingLight2.run(action2)
        
        isUserInteractionEnabled = true
        
        //let elemImg = syllablesToCheck + "g"
        
        let elemName = syllablesToCheck.components(separatedBy: .decimalDigits)
        let elemNum = syllablesToCheck.replacingOccurrences(of: elemName[0], with: "")
        
        let elemNameLabel = SKLabelNode()
        elemNameLabel.position = CGPoint(x: 0, y: -12)
        elemNameLabel.horizontalAlignmentMode = .center
        elemNameLabel.fontSize = 45
        elemNameLabel.text = elemName[0]
        elemNameLabel.name = "elemNameLabel"
        elemNameLabel.fontName = "Helvetica Bold"
        elemNameLabel.fontColor = .black
        elemNameLabel.zPosition = 13
        
        let elemNumLabel = SKLabelNode()
        elemNumLabel.position = CGPoint(x: 28, y: -36)
        elemNumLabel.horizontalAlignmentMode = .center
        elemNumLabel.fontSize = 23
        elemNumLabel.text = elemNum
        elemNumLabel.name = "elemNumLabel"
        elemNumLabel.fontName = "Helvetica Bold"
        elemNumLabel.fontColor = .black
        elemNumLabel.zPosition = 14
        
        
        if let elemImgNode = findImageNode(name: "getElement") as SKSpriteNode?{
            elemImgNode.addChild(elemNameLabel)
            elemImgNode.addChild(elemNumLabel)
        }
    }
    
    
    //得到元素動畫
    func getElementAnimation(){
        
        // 動畫部分要重做
        
        //確認是否為得到多元素, 然後顯示
        
        makeImageNode(name: "getElementBg", image: "winView", x: 0, y: 0, width: 750, height: 1334, z: 10, alpha: 1, isAnchoring: false)
        makeImageNode(name: "movingLight", image: "movingLight", x: 0, y: 230, width: 650, height: 601, z: 11, alpha: 1, isAnchoring: false)
        makeImageNode(name: "movingLight2", image: "movingLight", x: 0, y: 230, width: 650, height: 601, z: 11, alpha: 1, isAnchoring: false)
        
       //在此要抓元素的屬性來決定元素圖案
        
        var elemImg = "elemG"
        
        for i in 0 ..< elements.count{
            
            if syllablesToCheck == elements[i]["name"]{
                
                if let function = elements[i]["func"]{
                    
                    //不包含雙元素
                    if !function.contains(","){
                        

                        switch function{
                            
                        case "hp":
                            elemImg = "normalGem"
                        case "att":
                            elemImg = "normalGem"
                        case "def":
                            elemImg = "normalGem"
                        case "hit":
                            elemImg = "normalGem"
                        case "heal":
                            elemImg = "normalGem"
                        case "wood":
                            elemImg = "woodGem"
                        case "earth":
                            elemImg = "earthGem"
                        case "water":
                            elemImg = "waterGem"
                        case "fire":
                            elemImg = "fireGem"
                        case "metal":
                            elemImg = "metalGem"
                        case "upgrade":
                            elemImg = "combineGem"
                            
                        default:
                            elemImg = "normalGem"
                            
                        }

                        
                        
                    } else {
                        
                        elemImg = "rareGem"
                        
                        
                    }
                   
                }

            }
            
        }
        
        
        makeImageNode(name: "getElement", image: elemImg, x: 0, y: 230, width: 200, height: 200, z: 12, alpha: 1, isAnchoring: false)
    
        //製作按鈕
        makeImageNode(name: "getButton", image: "getButton", x: 0, y: -500, width:300, height: 90, z: 11, alpha: 1, isAnchoring: false)

        //製作文字
        makeLabelNode(x: 0, y: 30, alignMent: .center, fontColor: .white, fontSize: 34, text: "獲得新魔法元素，可用於裝備寵物", zPosition: 11, name: "loseText", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        
        //亮星星, 星星位置要抓
        /*
        makeImageNode(name: "1star", image: "star1", x: -160, y: -73, width: 100, height: 96.3, z: 11, alpha: 1, isAnchoring: false)
        makeImageNode(name: "2star", image: "star1", x: 00, y: -73, width: 100, height: 96.3, z: 11, alpha: 1, isAnchoring: false)
        makeImageNode(name: "3star", image: "star1", x: 160, y: -73, width: 100, height: 96.3, z: 11, alpha: 1, isAnchoring: false)
        */
        
        //做checkMark
        makeImageNode(name: "1ch", image: "chMark", x: -330, y: -90, width: 104, height: 79, z: 11, alpha: 1, isAnchoring: false)
        makeImageNode(name: "2ch", image: "chMark", x: -330, y: -200, width: 104, height: 79, z: 11, alpha: 1, isAnchoring: false)
        makeImageNode(name: "3ch", image: "chMark", x: -330, y: -300, width: 104, height: 79, z: 11, alpha: 1, isAnchoring: false)
        
        //顯示三個單字
        let quarterCount = wordSets.count / 4
        let halfCount = wordSets.count / 2
        
        let firstEngWord = wordSets[firstSequence].replacingOccurrences(of: " ", with: "")
        let firstChiWord = wordSets[quarterCount + firstSequence]
        let firstPartWord = wordSets[quarterCount + halfCount + firstSequence]
        let secondEngWord = wordSets[firstSequence + 1].replacingOccurrences(of: " ", with: "")
        let secondChiWord = wordSets[quarterCount + firstSequence + 1]
        let secondPartWord = wordSets[quarterCount + halfCount + firstSequence + 1]
        let thirdEngWord = wordSets[firstSequence + 2].replacingOccurrences(of: " ", with: "")
        let thirdChiWord = wordSets[quarterCount + firstSequence + 2]
        let thirdPartWord = wordSets[quarterCount + halfCount + firstSequence + 2]
        
        //檢查單字有無加入最愛
        //假設
        let myWords = ["cat","cap","art","cancel"]
        var image1 = "unHeart"
        var image2 = "unHeart"
        var image3 = "unHeart"
        if myWords.contains(firstEngWord){
            wordsLoved[0] = 1
        image1 = "heart"
        }
        if myWords.contains(secondEngWord){
            wordsLoved[1] = 1
            image2 = "heart"
        }
        if myWords.contains(thirdEngWord){
            wordsLoved[2] = 1
            image3 = "heart"
        }
        
        
        makeLabelNode(x: -260, y: -110, alignMent: .left, fontColor: .white, fontSize: 50, text: firstEngWord + " (" + firstPartWord + ") " + firstChiWord , zPosition: 11, name: "firstWord", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        makeLabelNode(x: -260, y: -220, alignMent: .left, fontColor: .white, fontSize: 50, text: secondEngWord + " (" + secondPartWord + ") " + secondChiWord , zPosition: 11, name: "secondWord", fontName: "Helvetica Bold", isHidden: false, alpha: 1)

        makeLabelNode(x: -260, y: -320, alignMent: .left, fontColor: .white, fontSize: 50, text: thirdEngWord  + " (" + thirdPartWord + ") " + thirdChiWord, zPosition: 11, name: "thirdWord", fontName: "Helvetica Bold", isHidden: false, alpha: 1)

        //check是否為最愛單字然後顯示圖片
        
        
        
        makeImageNode(name: "1Love", image: image1, x: 330, y: -90, width: 56, height: 48, z: 11, alpha: 1, isAnchoring: false)
        makeImageNode(name: "2Love", image: image2, x: 330, y: -200, width: 56, height: 48, z: 11, alpha: 1, isAnchoring: false)
        makeImageNode(name: "3Love", image: image3, x: 330, y: -300, width: 56, height: 48, z: 11, alpha: 1, isAnchoring: false)

        
        let movingLight = childNode(withName: "movingLight") as! SKSpriteNode
        let movingLight2 = childNode(withName: "movingLight2") as! SKSpriteNode
        let action = SKAction.rotate(toAngle: 360, duration: 5000)
        let action2 = SKAction.rotate(toAngle: -360, duration: 6000)
        movingLight.run(action)
        movingLight2.run(action2)
        
        isUserInteractionEnabled = true
        
        //let elemImg = syllablesToCheck + "g"
        
        let elemName = syllablesToCheck.components(separatedBy: .decimalDigits)
        let elemNum = syllablesToCheck.replacingOccurrences(of: elemName[0], with: "")
        
        let elemNameLabel = SKLabelNode()
        elemNameLabel.position = CGPoint(x: 0, y: -12)
        elemNameLabel.horizontalAlignmentMode = .center
        elemNameLabel.fontSize = 45
        elemNameLabel.text = elemName[0]
        elemNameLabel.name = "elemNameLabel"
        elemNameLabel.fontName = "Helvetica Bold"
        elemNameLabel.fontColor = .black
        elemNameLabel.zPosition = 13
        
        let elemNumLabel = SKLabelNode()
        elemNumLabel.position = CGPoint(x: 28, y: -36)
        elemNumLabel.horizontalAlignmentMode = .center
        elemNumLabel.fontSize = 23
        elemNumLabel.text = elemNum
        elemNumLabel.name = "elemNumLabel"
        elemNumLabel.fontName = "Helvetica Bold"
        elemNumLabel.fontColor = .black
        elemNumLabel.zPosition = 14
        
        
        if let elemImgNode = findImageNode(name: "getElement") as SKSpriteNode?{
            elemImgNode.addChild(elemNameLabel)
            elemImgNode.addChild(elemNumLabel)
        }
        
    }
    
    
    func failedToGetElement(){
        
        //初始化
        shownWords.removeAll(keepingCapacity: false)
        wordEntered.removeAll(keepingCapacity: false)
        battleComboTime = 0
        
        //移除畫面
        removeSomeNodes(name: "monster")
        removeSomeNodes(name: "player")
        removeSomeNodes(name: "Frame")
        removeSomeNodes(name: "tempWord")
        
        //製作元素

        //製作背景
        makeImageNode(name: "loseBg", image: "loseBg", x: 0, y: 0, width: 750, height: 1334, z: 10, alpha: 1, isAnchoring: false)
        
        //製作按鈕
        makeImageNode(name: "quitButton", image: "quitButton", x: 0, y: -400, width:300, height: 90, z: 11, alpha: 1, isAnchoring: false)
        
        
        var elemImg = "elemG"
        
        for i in 0 ..< elements.count{
            
            if syllablesToCheck == elements[i]["name"]{
                
                if let function = elements[i]["func"]{
                    
                    //不包含雙元素
                    if !function.contains(","){
                        
                        
                        switch function{
                            
                        case "hp":
                            elemImg = "normalGem"
                        case "att":
                            elemImg = "normalGem"
                        case "def":
                            elemImg = "normalGem"
                        case "hit":
                            elemImg = "normalGem"
                        case "heal":
                            elemImg = "normalGem"
                        case "wood":
                            elemImg = "woodGem"
                        case "earth":
                            elemImg = "earthGem"
                        case "water":
                            elemImg = "waterGem"
                        case "fire":
                            elemImg = "fireGem"
                        case "metal":
                            elemImg = "metalGem"
                        case "upgrade":
                            elemImg = "combineGem"
                            
                        default:
                            elemImg = "normalGem"
                            
                        }
                        
                        
                        
                    } else {
                        
                        
                        elemImg = "rareGem"
                    }
                    
                }
                
            }
            
        }


        
        //製作元素
        makeImageNode(name: "getElement", image: elemImg, x: 0, y: 200, width: 200, height: 200, z: 12, alpha: 1, isAnchoring: false)
        
        //製作文字
        makeLabelNode(x: 0, y: -220, alignMent: .center, fontColor: .white, fontSize: 30, text: "", zPosition: 11, name: "loseText", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        
        //亮星星, 星星位置要抓
        makeImageNode(name: "1star", image: "star1", x: -160, y: -73, width: 100, height: 96.3, z: 11, alpha: 0, isAnchoring: false)
        makeImageNode(name: "2star", image: "star1", x: 00, y: -73, width: 100, height: 96.3, z: 11, alpha: 0, isAnchoring: false)
        //makeImageNode(name: "3star", image: "star1", x: 160, y: -73, width: 100, height: 96.3, z: 11, alpha: 0, isAnchoring: false)
        
        let star1 = findImageNode(name: "1star")
        let star2 = findImageNode(name: "2star")
        //let star3 = findImageNode(name: "3star")
        
        let loseTextLabel = findLabelNode(name: "loseText")
        
        var checkStar = Int()
        //做底數
        let endUnitNumber = (unitNumber + 1) * 3
        checkStar = endUnitNumber - currentWordSequence
        
        if let getElements = user?["getElement"] as? String{
            
            
            if getElements.contains(syllablesToCheck){
                
                checkStar = 4
                
            }
        }
        
        switch checkStar {
            case 4:
            loseTextLabel.text = "You Already Got This Element"
        case 3:
            print("過0關")
            loseTextLabel.text = "You Need To Win 3 Stars To Get Element"
        case 2:
            print("過1關")
            loseTextLabel.text = "You Need 2 More Stars To Get The Element"
            star1.alpha = 1
        case 1:
            print("過2關")
            loseTextLabel.text = "You Need 1 More Star To Get The Element"
            star1.alpha = 1
            star2.alpha = 2
        default:
            break
        }
          isUserInteractionEnabled = true
        
        //加入元素的名稱 及數字
        
        let elemName = syllablesToCheck.components(separatedBy: .decimalDigits)
        let elemNum = syllablesToCheck.replacingOccurrences(of: elemName[0], with: "")
        
        let elemNameLabel = SKLabelNode()
        elemNameLabel.position = CGPoint(x: 0, y: -12)
        elemNameLabel.horizontalAlignmentMode = .center
        elemNameLabel.fontSize = 45
        elemNameLabel.text = elemName[0]
        elemNameLabel.name = "elemNameLabel"
        elemNameLabel.fontName = "Helvetica Bold"
        elemNameLabel.fontColor = .black
        elemNameLabel.zPosition = 13
        
        let elemNumLabel = SKLabelNode()
        elemNumLabel.position = CGPoint(x: 28, y: -36)
        elemNumLabel.horizontalAlignmentMode = .center
        elemNumLabel.fontSize = 23
        elemNumLabel.text = elemNum
        elemNumLabel.name = "elemNumLabel"
        elemNumLabel.fontName = "Helvetica Bold"
        elemNumLabel.fontColor = .black
        elemNumLabel.zPosition = 14
        

        if let elemImgNode = findImageNode(name: "getElement") as SKSpriteNode?{
        elemImgNode.addChild(elemNameLabel)
        elemImgNode.addChild(elemNumLabel)
        }

        
    }
    
    
    func removeEverything(){
        
        self.removeAllActions()
        self.removeAllChildren()
        
    }
    
    
    func wrongAnswerAction() -> SKAction{
        //閃紅字動畫
        let wait = SKAction.wait(forDuration: 0.2)
        let redFontAction = SKAction.run({[weak self] in
            self!.findLabelNode(name: "tempWord").fontColor = .red
        })
        let whiteFontAction = SKAction.run({[weak self] in
            self!.findLabelNode(name: "tempWord").fontColor = .white
        })
        let sequence = SKAction.sequence([redFontAction,wait,whiteFontAction,wait])
        let repeatAction = SKAction.repeat(sequence, count: 2)
        
        return repeatAction
    }
    
    
    func continueBattle(){
        
        
        //瞄準器
        makeImageNode(name: "aimer", image: "aimer", x: 0, y: -150, width: 477, height: 477, z: 2, alpha: 0, isAnchoring: false)
        //瞄準圈
        makeImageNode(name: "aimerCircle", image: "aimerCircle", x: 0, y: -150, width: 305, height: 287, z: 2, alpha: 0, isAnchoring: false)
        //瞄準心
        makeImageNode(name: "aimerHeart", image: "aimerHeart", x: 0, y: -150, width: 144, height: 144, z: 2, alpha: 0, isAnchoring: false)
        
        
        //fadeOut
        changeLabelAlfa(name: "tempWord", toAlpha: 0, time: 0.1)
        //中文一起fadeOut
        changeLabelAlfa(name: "chiWord", toAlpha: 0, time: 0.1)
        
        //發音
        scanAndPronounce()
        
        //選項顏色變淡+移除選項字
        for node in children{
            
            if (node.name?.contains("filledButton"))!{
                changeImageAlfa(name: node.name!, toAlpha: 0, time: 0.1)
            }
            
            if (node.name?.contains("emptyButton"))!{
                changeImageAlfa(name: node.name!, toAlpha: 0, time: 0.1)
            }
            
            if (node.name?.contains("Sel"))!{
                node.removeFromParent()
            }
        }
        
        //1. 把顯示的輸入字刪除
        findLabelNode(name: "tempWord").text = ""
        
        //顏色回復白色
        findLabelNode(name: "tempWord").color = .white
        
        //初始化
        shownWords.removeAll(keepingCapacity: false)
        wordEntered.removeAll(keepingCapacity: false)
        
        //下一次開始的時間等待秒數
        let when = DispatchTime.now() + 0.8
        
        DispatchQueue.main.asyncAfter(deadline: when) {[weak self] in
            
            //啟動aimer動畫
            self!.aimerAnimation()
            
            //2. tempWord Alpha調整
            self!.changeLabelAlfa(name: "tempWord", toAlpha: 1, time: 0)
            
            //能按畫面
            self!.isUserInteractionEnabled = true
            
            //再次啟動練習, 不用battleTest是因為不用再建立新的單字
            self!.learningTest()
            self!.isButtonEnable = false
        }
        
    }
    
    
    //治癒功能
    func heal(point:CGFloat,whom:String,finished: @escaping () -> Void){
        
        //每個單位的扣分計算法
        //var hurtMonster = fullMonsterBlood / 9 * point
        
        //人的血量單位設定, 目前都是以100當單位..
        var healPlayer = fullPlayerBlood / CGFloat(petLife) * point
      
        //show治癒術
        let comboAttack = findLabelNode(name: "comboAttack")
        comboAttack.alpha = 1
        comboAttack.fontColor = .blue

        
        
        //假如未扣血就不補血
        if playerBlood == fullPlayerBlood{
            
            healPlayer = 0
            comboAttack.text = ""
       
        } else if (playerBlood + healPlayer) > fullPlayerBlood{
            
            //假如補血超過, 就只補到滿
            
            //補血動畫
            healEffect?.isHidden = false
            healEffect?.resetSimulation()
            
            healPlayer = healPlayer - (playerBlood + healPlayer - fullPlayerBlood)
                    comboAttack.text = "治癒: \(petHeal)"
            
        } else {
            
            healEffect?.isHidden = false
            healEffect?.resetSimulation()
            comboAttack.text = "治癒: \(petHeal)"
            
        }
        
        //治癒畫面
            let healAction = SKAction.resize(toWidth: playerBlood + healPlayer, duration: 0.2)
            findImageNode(name: whom).run(healAction)
            playerBlood = playerBlood + healPlayer
        
        //扣分後的短暫等待
        let when = DispatchTime.now() + 0.5
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            finished()
        }
        
        
    }
    
    
    
    //扣分的func
    func attack(point:CGFloat,whom:String,finished: @escaping () -> Void){
        
        //每個單位的扣分計算法
        //var hurtMonster = fullMonsterBlood / 9 * point
        
        //人的血量設定
        var hurtPlayer = fullPlayerBlood / CGFloat(petLife) * point
        
        var hurtMonster = fullMonsterBlood / CGFloat(monsterHp) * point
        
        //假如超過分數就扣光
        if hurtMonster > monsterBlood {
            hurtMonster = monsterBlood
        }
        
        if hurtPlayer > playerBlood{
            hurtPlayer = playerBlood
        }
        
        //扣血畫面
        
        switch whom {
        case "monsterBlood":
            
            let hurtAction = SKAction.resize(toWidth: monsterBlood - hurtMonster, duration: 0.2)
            findImageNode(name: whom).run(hurtAction)
            monsterBlood = monsterBlood - hurtMonster
            

        case "playerBlood":
            let hurtAction = SKAction.resize(toWidth: playerBlood - hurtPlayer, duration: 0.2)
            findImageNode(name: whom).run(hurtAction)
            playerBlood = playerBlood - hurtPlayer
            

        default:
            break
        }
        
        //扣分後的短暫等待
        let when = DispatchTime.now() + 0.5
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            finished()
        }
        
        
    }
    
    //show單字在畫面上
    func showEnterWords(word:String){
        
        //填入array
        wordEntered.append(word)
        
        //建立labelNode, 有的話就改text內容
        if let tempNode = childNode(withName: "tempWord") as? SKLabelNode {
            
            //appendText
            var fullText = String()
            for i in wordEntered {
                
                //製作完整文字
                fullText += i
                tempNode.text = fullText
                
            }
            
        } else {
            
            //沒有的話就建立labelNode
            makeLabelNode(x: 0, y: 380, alignMent: .center, fontColor: .white, fontSize: 100, text: word, zPosition: 3, name: "tempWord", fontName: "Helvetica", isHidden: false, alpha: 1)
            
            
        }
    }
    
    
    func pourPoison(word:String, poisonNumber:Int){
        
        //找選項正確音節
        let selectedLabel = findLabelNode(name: word + String(poisonNumber) + "Sel")
        
        //改變label fontColor
        let changeTextColor = SKAction.run {
            selectedLabel.fontColor = .white
        }
        run(changeTextColor)
        
        
        //按鈕發亮, 要設置為0秒完成, 否則會異常
        let buttonName =  String(poisonNumber) + "filledButton"
        changeImageAlfa(name: buttonName, toAlpha: 1, time: 0)
        
    }
    
    func removePoison(word:String, poisonNumber:Int){
        
        
        //找選項正確音節
        let selectedLabel = findLabelNode(name: word + String(poisonNumber) + "Sel")
        
        //改變label fontColor
        let changeTextColor = SKAction.run {
            selectedLabel.fontColor = .white
        }
        run(changeTextColor)
        
        
        //解除選項
        let buttonName =  String(poisonNumber) + "filledButton"
        changeImageAlfa(name: buttonName, toAlpha: 0, time: 0)
        
        
        
    }
    
    
    //回傳SKLabelNode打字動畫+閃爍指令的func
    func typingAction(text:String, nodeName:String, finalText:String) -> SKAction{
        
        //輸入的text
        let questText = text
        //把text拆成array並加入底線_
        var questTextArray = questText.characters.map { String($0) }
        
        questTextArray.append("_")
        
        var i = 0
        
        //每字間隔0.1秒
        let wait = SKAction.wait(forDuration: 0.1)
        
        //開始顯示打字動畫
        let typingAction = SKAction.run {[weak self] in
            
            self?.findLabelNode(name: nodeName).text = (self?.findLabelNode(name: nodeName).text!)! + questTextArray[i]
            
            i += 1
            
        }
        
        
        let sequence = SKAction.sequence([wait,typingAction])
        //讓打字動畫做到字數數量
        let repeatAction = SKAction.repeat(sequence, count: questTextArray.count)
        
        //底線閃爍
        let sparklingAction1 = SKAction.run {[weak self] in
            self?.findLabelNode(name: nodeName).text = questText + "_"
            
        }
        let sparklingAction2 = SKAction.run {[weak self] in
            self?.findLabelNode(name: nodeName).text = questText
        }
        
        let sparklingSequence = SKAction.sequence([sparklingAction1,wait,sparklingAction2,wait])
        //讓底線閃爍4次
        let repeatSparklingAction = SKAction.repeat(sparklingSequence, count: 2)
        
        //顯示最後text
        let finalWord = SKAction.run {
            
            self.findLabelNode(name: nodeName).text = finalText
            
        }
        
        //把打字+底線閃爍加在一起
        let allSparklingAction = SKAction.sequence([repeatAction,repeatSparklingAction, finalWord])
        
        return allSparklingAction
        
    }
    
    
    //建立音節單字的func
    func makeWords(word:String, lang:String){
        
        //首先設定不是_e
        isSpecialE = false
        
        //設定x及y的位置
        var posX = CGFloat()
        var posY = CGFloat()
        
        //字型大小
        var fontSize = CGFloat()
        
        //對齊位置
        var align:SKLabelHorizontalAlignmentMode?
        
        //製作中文字
        if lang == "chiWord" {
            
            //label的屬性
            align = .center
            posY = 270
            fontSize = 70
            
            //建立中文字
            makeLabelNode(x: 0, y: posY, alignMent: align!, fontColor: .white, fontSize: fontSize, text: word, zPosition: 2, name: "chiWord", fontName: "Helvetica Light", isHidden: false, alpha: 0)
            
            
            //製作英文字
        } else if lang == "engWord"{
            
            //分音節
            var sepWords = word.components(separatedBy: " ")
            
            //計算字母有多少個, 用來決定xPos
            var characterCounts = 0
            for i in sepWords{
                //characterCounts = characterCounts + i.characters.count
                characterCounts = characterCounts + i.count
            }
            
            switch characterCounts {
            case 1...3:
                posX = -115
            case 4...6:
                posX = -150
            case 7...10:
                posX = -175
            case 11...15:
                posX = -240
            case 16...20:
                posX = -280
            default:
                posX = -180
            }
            
            //label的屬性
            align = .left
            posY = 380
            fontSize = 100
            
            //加一個順序
            nextWordSequence += 1
            
            //還原該單字
            wordsToPronounce = word.replacingOccurrences(of: " ", with: "")
            
            //產生提示
            let hintY = findImageNode(name: "questBoard").frame.minY
            
            //戰鬥模式就不做這個hint了
            if isBattleMode == false{
                makeLabelNode(x: 0, y: hintY + 10, alignMent: .center, fontColor: .white, fontSize: 30, text: "[ 請按畫面聽讀單字 ]", zPosition: 2, name: "hint" , fontName: "Helvetica Light", isHidden: false, alpha: 1)
            }
            
            //抓音節數
            //let sepCount = sepWords.count
            
            //抓部首
            syllablesToCheck = syllables[unitNumber]
            
            //去掉數字
            syllablesWithoutDigit = (syllablesToCheck.components(separatedBy: NSCharacterSet.decimalDigits) as NSArray).componentsJoined(by: "")
            
            //提供給_e部首字的sepWord使用
            var newSepWords = [["1"],["1"],["1"],["1"],["1"]]
            
            //確認新增順序
            var sequenceToAppend = -1
            var specialSyllable = Int()
            
            //在此先拆每個單字的字母來看是否有三個字母並且符合 _e規則的音節
            
            for i in 0 ..< sepWords.count{
                
                //先清空字母array
                characters.removeAll(keepingCapacity: false)
                
                let sepWord = sepWords[i]
                
                //直接拆單字字母變成character, 填入array裡面
                for i in sepWord{
                    characters.append(i)
                    
                }
                
                //確認是否是_e的部首, 有的話就做新字
                if syllablesWithoutDigit.contains("_e"){
                    
                    //確認是_e部首
                    isSpecialE = true
                    
                    //(1)有任何字節是三個字母
                    if characters.count == 3 {
                        
                        //(2)第一個字母是母音
                        if vowels.contains(String(characters[0])){
                            
                            
                            //(3)第三個字母是e
                            if characters[2] == "e"{
                                
                                //***符合: _e 部首
                                
                                //要開始填入的順序+1
                                sequenceToAppend += 1
                                
                                //設定此順序為部首字的特別順序
                                specialSyllable = sequenceToAppend
                                
                                //假如這個array位置的第一個字是1, 就移除
                                if newSepWords[sequenceToAppend][0] == "1"{
                                    
                                    newSepWords[sequenceToAppend].removeFirst()
                                    
                                }
                                
                                //建立三個字母進去
                                for i in 0 ..< 3 {
                                    newSepWords[sequenceToAppend].append(String(characters[i]))
                                }
                                
                                
                            } else {
                                
                                //最後一個字母不是e
                                
                                sequenceToAppend += 1
                                if newSepWords[sequenceToAppend][0] == "1"{
                                    newSepWords[sequenceToAppend].removeFirst()
                                }
                                newSepWords[sequenceToAppend].append(sepWord)
                                
                            }
                            
                        }  else {
                            
                            //第一個字母不是母音
                            sequenceToAppend += 1
                            if newSepWords[sequenceToAppend][0] == "1"{
                                newSepWords[sequenceToAppend].removeFirst()
                            }
                            newSepWords[sequenceToAppend].append(sepWord)
                            
                            
                        }
                    } else {
                        
                        //沒有三個字母
                        sequenceToAppend += 1
                        if newSepWords[sequenceToAppend][0] == "1" {
                            newSepWords[sequenceToAppend].removeFirst()
                        }
                        newSepWords[sequenceToAppend].append(sepWord)
                        
                        
                    }
                    
                }
                
            }
            
            
            
            //===========以下為做字功能, 分成兩部分===============
            
            //Part 1. 有三字母部首的話
            if isSpecialE{
                
                //***在此做_e單字
                
                //跑所有字節
                for i in 0 ..< newSepWords.count{
                    
                    //用不到的字節就不做字
                    if newSepWords[i][0] != "1"{
                        
                        //***有append字母的才來做單字
                        
                        //Part 1. 假如是_e部首
                        if i == specialSyllable {
                            
                            
                            var fontColor = UIColor()
                            
                            //裡面的每一個字母
                            for s in 0 ..< newSepWords[i].count{
                                
                                //抓每個字
                                let sepWord = newSepWords[i][s]
                                
                                //指定名字
                                syllableWordName = sepWord +  String(s) + lang
                                
                                //做1,3音節顏色
                                switch s{
                                case 0:
                                    fontColor = .red
                                case 1:
                                    fontColor = .white
                                case 2:
                                    fontColor = .red
                                    
                                default:
                                    break
                                }
                                
                                //做字
                                if s > 0 {
                                    
                                    //非第一組字
                                    if let leftNode = childNode(withName: newSepWords[i][s - 1] + String(s - 1) + lang) as? SKLabelNode{
                                        
                                        let nextX = CGFloat(leftNode.frame.origin.x + leftNode.frame.width + 4)
                                        
                                        makeLabelNode(x: nextX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: syllableWordName, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                                    }
                                    
                                } else{
                                    
                                    //若是第一個字母
                                    
                                    //如果不是第一個字節
                                    if i != 0 {
                                        
                                        //位置要抓前一非部首的音節位置
                                        
                                        if let leftNode = childNode(withName: normalSyllableName) as? SKLabelNode{
                                            
                                            let nextX = CGFloat(leftNode.frame.origin.x + leftNode.frame.width + 4)
                                            
                                            makeLabelNode(x: nextX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: syllableWordName, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                                            
                                        }
                                        
                                    } else {
                                        
                                        //若是第一個字節, 直接製作
                                        makeLabelNode(x: posX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: syllableWordName, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                                        
                                        
                                        
                                    }
                                    
                                    
                                }
                                
                            }
                            
                        }  else {
                            
                            //若不是部首字
                            let sepWord = newSepWords[i][0]
                            
                            //取名字
                            normalSyllableName = sepWord + String(i) + lang
                            
                            //非元素字顏色
                            let fontColor = UIColor.white
                            
                            if i > 0 {
                                
                                //非第一組字, 要抓上一個字的結尾位置
                                
                                //先確認前個字是否接部首字
                                if i - 1 == specialSyllable{
                                    
                                    //是的話就抓部首字位置
                                    if let leftNode = childNode(withName: syllableWordName) as? SKLabelNode{
                                        let nextX = CGFloat(leftNode.frame.origin.x + leftNode.frame.width + 4)
                                        
                                        makeLabelNode(x: nextX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: normalSyllableName, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                                    }
                                    
                                } else {
                                    //不是的話抓上一個一般字的位置
                                    if let leftNode = childNode(withName: sepWords[i - 1] + String(i - 1) + lang) as? SKLabelNode{
                                        
                                        let nextX = CGFloat(leftNode.frame.origin.x + leftNode.frame.width + 4)
                                        
                                        makeLabelNode(x: nextX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: normalSyllableName, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                                        
                                    }
                                    
                                    
                                    
                                }
                                
                                
                                
                            } else{
                                
                                //第一組字
                                makeLabelNode(x: posX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: normalSyllableName, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                                
                            }
                            
                        }
                    }
                }
                
            } else {
                
                
                // Part 2. 不是_e, 就在這裡做單字
                
                
                //一個單字以處理成array之後建立每一個array的value
                for i in 0 ..< sepWords.count{
                    
                    let sepWord = sepWords[i]
                    //檢查有沒有元素的字節, 有的話顯示為黃色
                    //if syllablesWithoutDigit.contains(sepWord){ //之前這寫法會把相同字母也include進去, 不準確
                    
                    if syllablesWithoutDigit == sepWord{
                        let fontColor = UIColor.yellow
                        
                        if i > 0 {
                            
                            //非第一組字
                            if let leftNode = childNode(withName: sepWords[i - 1] + String(i - 1) + lang) as? SKLabelNode{
                                
                                let nextX = CGFloat(leftNode.frame.origin.x + leftNode.frame.width + 4)
                                
                                makeLabelNode(x: nextX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: sepWord + String(i) + lang, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                                
                            }
                            
                        } else{
                            //第一組字
                            makeLabelNode(x: posX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: sepWord  + String(i) + lang, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                            
                        }
                        
                    } else {
                        
                        //非元素字
                        let fontColor = UIColor.white
                        
                        if i > 0 {
                            
                            
                            //非第一組字
                            if let leftNode = childNode(withName: sepWords[i - 1] + String(i - 1) + lang) as? SKLabelNode{
                                
                                let nextX = CGFloat(leftNode.frame.origin.x + leftNode.frame.width + 4)
                                
                                makeLabelNode(x: nextX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: sepWord + String(i) + lang, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                                
                            }
                            
                        } else{
                            
                            
                            //第一組字
                            makeLabelNode(x: posX, y: posY, alignMent: align!, fontColor: fontColor, fontSize: fontSize, text: sepWord, zPosition: 2, name: sepWord + String(i) + lang, fontName: "Helvetica Light", isHidden: false, alpha: 0)
                            
                        }
                        
                        
                        
                    }
                    
                }
            }
        }
    }
    
    
    //畫線功能
    func drawLine(){
        
        path = CGMutablePath()
        
        switch touchTimes {
            
        case 1:
            
            path.move(to: firstTouch)
            
            if isEndOnNode{
                path.addLine(to: movingTouch)
            } else {
                removeSomeNodes(name: "new")
            }
        case 2:
            
            path.move(to: firstTouch)
            path.addLine(to: fixedSecondTouch)
            if isEndOnNode{
                path.addLine(to: movingTouch)
            }
        case 3:
            
            path.move(to: firstTouch)
            path.addLine(to: fixedSecondTouch)
            path.addLine(to: fixedThirdTouch)
            
            if isEndOnNode{
                path.addLine(to: movingTouch)
            }
        case 4:
            
            path.move(to: firstTouch)
            path.addLine(to: fixedSecondTouch)
            path.addLine(to: fixedThirdTouch)
            path.addLine(to: fixedFourthTouch)
            
            if isEndOnNode{
                path.addLine(to: movingTouch)
                
            }
            
        case 5:
            
            path.move(to: firstTouch)
            path.addLine(to: fixedSecondTouch)
            path.addLine(to: fixedThirdTouch)
            path.addLine(to: fixedFourthTouch)
            path.addLine(to: fixedFifthTouch)
            
            if isEndOnNode{
                path.addLine(to: movingTouch)
                
            }
            
        default:
            break
        }
        
        line!.path = path
        
    }
    
    //抓node的位置func
    func getCgPoint(name:String) -> CGPoint{
        
        let node = childNode(withName: name) as! SKSpriteNode
        let xPos = node.frame.midX
        let yPos = node.frame.midY
        let position = CGPoint(x: xPos, y: yPos)
        return position
    }
    
    
    //找labelNode
    func findLabelNode(name:String) -> SKLabelNode{
        var node:SKLabelNode?
        node = childNode(withName: name) as? SKLabelNode
        return node!
        
    }
    
    //找IMAGE的skspritenode
    func findImageNode(name:String) -> SKSpriteNode{
        var node:SKSpriteNode?
        if let nodeFound = childNode(withName: name) as? SKSpriteNode{
            node = nodeFound
        }
        return node!
        
    }
    
    //製作image的skspriteNode
    func makeImageNode(name:String, image:String, x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat, z:CGFloat, alpha:CGFloat, isAnchoring:Bool){
        
        
        let bundlePath = Bundle.main.path(forResource: image, ofType: "png")
        let imageFile = UIImage(contentsOfFile: bundlePath!)
        let texture = SKTexture(image: imageFile!)
        let node = SKSpriteNode()
        
        node.size = CGSize(width: width, height: height)
        node.name = name
        node.texture = texture
        node.position = CGPoint(x: x, y: y)
        node.zPosition = z
        node.alpha = alpha
        
        if isAnchoring{
            
            node.anchorPoint = CGPoint(x: 0, y: 0)
        }
        
        addChild(node)
        
    }
    
    //製作一般labelNode
    func makeLabelNode(x:CGFloat,y:CGFloat,alignMent:SKLabelHorizontalAlignmentMode,fontColor:UIColor,fontSize:CGFloat,text:String,zPosition:CGFloat,name:String,fontName:String, isHidden:Bool, alpha:CGFloat){
        
        let node = SKLabelNode()
        node.position = CGPoint(x: x, y: y)
        node.horizontalAlignmentMode = alignMent
        node.fontSize = fontSize
        node.text = text
        node.fontColor = fontColor
        node.zPosition = zPosition
        node.name = name
        node.fontName = fontName
        node.isHidden = isHidden
        node.alpha = alpha
        
        
        addChild(node)
        
    }
    
    //製作SKNode
    func makeNode(name:String, color:UIColor, x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat, z:CGFloat, isAnchoring:Bool, alpha: CGFloat){
        
        let size = CGSize(width: width, height: height)
        let node = SKSpriteNode(color: color, size: size)
        node.alpha = alpha
        node.name = name
        node.position = CGPoint(x: x, y: y)
        node.zPosition = z
        
        if isAnchoring{
            
            node.anchorPoint = CGPoint(x: 0, y: 0)
        }
        
        addChild(node)
        
    }
    
    
    func changeImageAlfa(name:String, toAlpha:CGFloat, time:TimeInterval){
        
        if let node = childNode(withName: name) as? SKSpriteNode{
            let alphaAction = SKAction.fadeAlpha(to: toAlpha, duration: time)
            node.run(alphaAction)
            
        }
        
    }
    
    func changeLabelAlfa(name:String, toAlpha:CGFloat, time:TimeInterval){
        
        if let node = childNode(withName: name) as? SKLabelNode{
            let alphaAction = SKAction.fadeAlpha(to: toAlpha, duration: time)
            node.run(alphaAction)
            
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        //發音三次後直跳練習
        
        if playSoundTime == 1 {
            //直接開啟練習
            //只開啟一次
            playSoundTime = 0
            
            //封鎖按鍵
            isUserInteractionEnabled = false
            
            //dotSparkingFunc()
            
            let when = DispatchTime.now() + 0.5
            
            DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                
                //開始學習練習模式
                self!.isPracticeMode = true
                
                //點點消失
                /*
                self!.findImageNode(name: "lDot1").alpha = 0
                self!.findImageNode(name: "lDot2").alpha = 0
                self!.findImageNode(name: "lDot3").alpha = 0
                */
                
                //更改提示字
                self!.findLabelNode(name: "hint").text = "[ 練習拼字 ]"
                
                //發音次數歸零
                self!.playSoundTime = 0
                
                //啟動練習
                self!.learningTest()
                self!.isButtonEnable = false
                
            })
            
        }
        

    }
    
    
    func dotSparkingFunc(){
        
        let sparkling1 = SKAction.fadeAlpha(to: 0, duration: 0.1)
        let sparkling2 = SKAction.fadeAlpha(to: 1, duration: 0.1)
        let sequence = SKAction.sequence([sparkling1,sparkling2])
        let repeatAction = SKAction.repeat(sequence, count: 2)
        
        for node in children{
            
            if (node.name?.contains("lDot"))!{
                
                node.run(repeatAction)
                
            }
        }
    }
    
    
    
    //上傳得到的寵物
    func getPet(id:String,petId:String){
        
        // url to access our php file
        let url = URL(string: "http://ec2-52-199-122-149.ap-northeast-1.compute.amazonaws.com/wordDrug/getPet.php")!
        
        // request url
        var request = URLRequest(url: url)
        
        // method to pass data POST - cause it is secured
        request.httpMethod = "POST"
        
        // body gonna be appended to url
        let body = "userID=\(id)&getPet=\(petId)"
        
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
                    
                    
                } catch{
                    
                    print("catch error")
                    
                    
                }
            } else {
                
                print("urlsession has error")
                
            }
        }).resume()
        
    }

    
    //刪除元素
    func deleteElem(elem:String){
        
        let id = user?["id"] as! String
        let element = elem
        
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
                    
                    
                } catch{
                    
                    print("catch error")
                    
                    
                }
            } else {
                
                print("urlsession has error")

            }
        }).resume()
        
    }
    
    
    
}


extension Array where Element: Hashable {
    var orderedSet: Array {
        return NSOrderedSet(array: self).array as? Array ?? []
    }
}

extension Array {
    mutating func shuffled() {
        for _ in self {
            // generate random indexes that will be swapped
            var (a, b) = (Int(arc4random_uniform(UInt32(self.count - 1))), Int(arc4random_uniform(UInt32(self.count - 1))))
            if a == b { // if the same indexes are generated swap the first and last
                a = 0
                b = self.count - 1
            }
            self.swapAt(a, b)
        }
    }
}


