//
//  NewGameScene.swift
//  wordDrug
//
//  Created by Ethan on 2018/2/1.
//  Copyright © 2018年 playplay. All rights reserved.
//

import SpriteKit
import GameplayKit

let leaveGameKey = "leaveGame"
let startToRecognizeKey = "startToRecognize"
let pronounceWordKey = "pronounceWord"
let addScoreKey = "addScore"
let pauseKey = "pause"
let stopLimitTimerKey = "stopLimitTimer"
let playEndingMusicKey = "playEndingMusic"
let removePronounceBtnKey = "removePlaySoundBtn"

class NewGameScene: SKScene {

    var syllableSets = [[String]()]
    
    //集合所有音節在一起
    //var allSyllables = [String]()
    
    //以下為各地圖的音節

    
    
    let map1SyllableSets:[[String]] = [["sk1","so1","st1","sion1","th1","ti1","tion1","tive1","tle1","sp1"],
                            ["ap1","ar1","as1","at1","au1","aw1","ay1","ba1","be1","bi1"],
                            ["bit1","bl1","bo1","br1","bu1","by1","ce1","ch1","ci1","ble1"],
                            ["ck1","cl1","co1","com1","con1","di1","cr1","ct1","de1","cian1"],
                            ["do1","dr1","dy1","dis1","ea1","ee1","el1","en1","er1","em1"],
                            ["et1","ew1","ex1","ey1","fi1","fl1","fo1","fr1","ft1","ful1"],
                            ["ab1","ac1","ad1","a_e1","af1","ai1","al1","am1","an1","any1"],
        ["il1","im1","in1","ing1","ir1","is1","ject1","le1","li1","kn1"],
        ["ly1","mi1","nd1","no1","oa1","ob1","o_e1","of1","oi1","nt1"],
        ["old1","on1","ong1","oo1","op1","or1","ot1","ou1","ow1","oy1"],
        ["ph1","pi1","pl1","pr1","cop1","ro1","ry1","sh1","si1","re1"],
        ["ge1","gi1","gl1","go1","gr1","he1","hi1","id1","ie1","igh1"],
        ["to1","tr1","ty1","ub1","u_e1","ui1","um1","un1","up1","ture1"],
        ["ur1","ut1","war1","wh1","ab2","ac2","ad2","a_e2","ai2","af2"],
        ["er34","er35","er36","ea34","ea35","ble4","ble5","fr3","at4","ple2"]]
    
    
    let map2SyllableSets:[[String]] = [["al2","am2","an2","ar2","as2","at2","au2","aw2","ay2","be2"],
                            ["bo2","bu2","ce2","ch2","ck2","cl2","co2","com2","cr2", "con2"],
                            ["di2","do2","dr2","ea2","ee2","el2","en2","er2","et2", "em2"],
                            ["ew2","ex2","ey2","fi2","fr2","gr2","hi2","ie2","igh2","ge2"],
                            ["il2","im2","in2","ing2","ir2","is2","ly2","oa2","o_e2", "nd2"],
                            ["oi2","on2","ong2","oo2","op2","or2","ot2","ou2","ow2","ph2"],
                            ["pr2","ness1","re2","ry2","sh2","sk2","st2","th2","tion2","tr2"],
                            ["ture2","u_e2","i_e1","i_e2","ue1","ue2","ui2","um2","un2","ty2"],
                            ["up2","ur2","wh2","a_e3","ai3","al3","am3","an3","ac3","ad3"],
                            ["ar3","at3","aw3","ay3","be3","ce3","ch3","ck3","cl3","au3"],
                            ["ea3","ee3","el3","em3","en3","er3","et3","ex3","ey3","con3"],
                            ["i_e3","igh3","im3","in3","ing3","ir3","o_e3","oa3","oi3", "ge3"],
                            ["on3","ong3","oo3","op3","or3","ot3","ou3","ow3","pr3","gar1"],
                            ["re3","sh3","st3","th3","tion3","tr3","ty3","u_e3","ui3","ry3"],
                            ["er37","er38","er39","er40","er41","er42","er43","er44","er45","er46"]]
    
    let map3SyllableSets:[[String]] = [["un3","ur3","wh3","a_e4","ad4","ai4","al4","am4","an4","um3"],
                            ["ar4","au4","ay4","ce4","ch4","ck4","ea4","ee4","el4","em4"],
                            ["en4","er4","ex4","ge4","i_e4","igh4","im4","in4","ing4","ir4"],
                            ["o_e4","oa4","on4","oo4","or4","ot4","ou4","ow4","mo1","pr4"],
                            ["re4","sh4","st4","th4","ui4","um4","un4","ur4","a_e5","tion4"],
                            ["ad5","ai5","al5","am5","an5","ar5","au5","ay5","ce5","ch5"],
                            ["ck5","ea5","ee5","el5","en5","er5","ge5","i_e5","in5","im5"],
                            ["ing5","ir5","o_e5","oa5","oo5","or5","ou5","ow5","go2","pr5"],
                            ["sh5","st5","th5","tion5","un5","ur5","a_e6","ai6","al6","am6"],
                            ["an6","ar6","ay6","ce6","ch6","ck6","ea6","ee6","el6","en6"],
                            ["er6","i_e6","in6","ing6","o_e6","oo6","or6","ou6","ow6","oa6"],
                            ["pr6","buy1","sh6","st6","th6","un6","ur6","a_e7","ai7","tion6"],
                            ["al7","am7","an7","ar7","ay7","ch7","ea7","ee7","el7","ce7"],
                            ["en7","er7","i_e7","in7","ing7","oo7","or7","ou7","ow7","gy1"],
                            ["er47","er48","er49","er50","er51","er52","ea36","ea37","ea38","ce9"]]
    
    let map4SyllableSets:[[String]] = [["sh7","st7","th7","a_e8","ai8","al8","am8","an8","ar8","ay8"],
                            ["ce8","ea8","ee8","el8","en8","er8","i_e8","in8","ing8","ch8"],
                            ["oo8","or8","ou8","ow8","nic1","st8","th8","a_e9","ai9","sh8"],
                            ["al9","an9","ar9","ay9","ea9","ee9","el9","er9","i_e9","en9"],
                            ["in9","oo9","or9","ou9","ow9","ple1","st9","th9","a_e10","ai10"],
                            ["al10","an10","ar10","ea10","ee10","el10","en10","er10","i_e10","ay10"],
                            ["in10","oo10","or10","ou10","ow10","vil1","st10","a_e11","ai11","al11"],
                            ["an11","ar11","ay11","ea11","ee11","el11","en11","er11","i_e11","in11"],
                            ["oo11","or11","ow11","ju1","st11","a_e12","al12","an12","ar12","ai12"],
                            ["ou11","ea12","ee12","el12","en12","er12","i_e12","in12","or12","oo12"],
                            ["ou12","ow12","que1","sc1","sent1","sic1","so2","st12","stle1","ult1"],
                            ["zle1","a_e13","ai13","al13","ame1","an13","ar13","bed1","ble2","bt1"],
                            ["by2","cle1","cus1","dis2","ea13","ee13","el13","en13","er13","cian2"],
                            ["ge6","gh1","gi2","gn1","gu1","i_e13","in13","lar1","mb1","mid1"],
                            ["st17","an21","ng1","ge7","ou22","str1","pi2","ca1","ax1","ax2"]]
    
    let map5SyllableSets:[[String]] = [["mi2","mi3","mud1","na1","nd3","ny1","olf1","oo13","ood1","or13"],
                            ["ou13","st13","sw1","tle2","a_e14","al14","an14","ar14","ea14","sym1"],
                            ["ee14","en14","er14","i_e14","in14","oo14","or14","ou14","st14","a_e15"],
                            ["al15","an15","ar15","ea15","ee15","en15","er15","i_e15","in15","oo15"],
                            ["or15","ou15","st15","al16","an16","ea16","ee16","en16","er16","ar16"],
                            ["oo16","or16","ou16","st16","al17","an17","ar17","ea17","ee17","in16"],
                            ["en17","er17","in17","oo17","or17","ou17","al18","an18","ea18","ar18"],
                            ["ee18","en18","er18","in18","or18","ou18","an19","ea19","ee19","al19"],
                            ["en19","er19","or19","ou19","al20","ea20","ee20","en20","er20","an20"],
                            ["or20","ou20","ea21","ee21","en21","er21","or21","ou21","ea22","al21"],
                            ["ee22","en22","er22","or22","ea23","ee23","en23","er23","or23","ee24"],
                            ["ea24","en24","er24","or24","en25","er25","ea25","ea26","en26","or25"],
                            ["er26","ea27","en27","er27","ea28","en28","er28","ea29","en29","er29"],
                            ["ea30","en30","er30","ea31","er31","ea32","er32","ea33","er33","en31"],
                            ["bet1","a_e16","ba2","ban1","bar1","bl2","br2","br3","br4","ble3"]]
    
    
    let map6SyllableSets:[[String]] = [["a_e17","ar19","br5","ce10","em5","er52","my1","set1","st18","tain1"],
                            ["au6","ch9","ing9","mic1","ph3","sh9","th10","tic1","tion7","u_e4"],
                            ["ai14","ar20","au7","aw4","ct2","ful2","ge8","nd4","tive2","ue3"],
                            ["a_e18","ac4","al22","au8","ban2","et4","ly3","ou23","sin1","sit1"],
                            ["au9","ay12","ba3","beg1","ee25","el14","or26","ry4","sis1","ty4"],
                            ["bi2","bio1","bl3","ble6","en32","fit1","is3","ny2","old2","sh10"],
                            ["an22","br6","bu3","ca2","ing10","oo18","oy2","sy1","um5","ur7"],
                            ["a_e19","al23","ar21","br7","bu4","ca3","ea39","ge9","tion8","ture3"],
                            ["br8","bu5","ca4","ce11","ch10","ci3","cl4","er53","ir6","oa7"],
                            ["ar22","br9","ca5","ch11","ci4","ci5","ck7","cl5","co3","o_e7"],
                            ["br10","ca7","ch12","cl6","co4","com3","con4","dy2","nd5","oo19"],
                            ["ca6","ch13","cl7","com4","con5","dy3","or27","ou24","tion9","u_e5"],
                            ["ch14","cl8","com5","con6","cr3","er54","or28","ous1","ub2","up3"],
                            ["a_e20","ch15","cl9","com6","con7","cr4","cy1","ea41","sh11","ta1"],
                            ["i_e29","ly16","on7","ry10","sh25","st28","tw2","un9","up4","us1"]]
    
    let map7SyllableSets:[[String]] = [["am9","ce12","ch16","cl10","com7","con8","cr5","i_e16","ing11","ry5"],
                            ["ay13","ch17","cl11","com8","con9","cr6","de2","en33","ry12","tion10"],
                            ["a_e21","an23","ch18","com9","con10","cr7","de3","igh5","pr7","ty5"],
                            ["ai15","ch19","com10","con11","cr8","er55","ge10","ment2","pr8","tion11"],
                            ["com11","con12","cr9","dia1","dic1","er56","gi3","i_e17","o_e8","tion12"],
                            ["com12","con13","cr10","di3","dis3","im6","ip1","ir7","pl2","st29"],
                            ["a_e22","com13","con14","cr11","dis4","dr3","i_e18","o_e9","ow13","sion2"],
                            ["con15","cr12","dis5","dr4","ea40","ow14","rn1","sk3","th11","ul1"],
                            ["al24","ble7","con16","dis6","dr5","en34","it1","mic2","tion13","tive3"],
                            ["ch20","cian3","con17","dis7","dr6","ly4","nic2","nt2","tic2","ty6"],
                            ["a_e23","con18","dis8","dr7","em6","ge11","ing12","ment3","or29","wh4"],
                            ["al25","ce13","con19","dis9","en35","er57","ge12","ment4","qu1","tle3"],
                            ["a_e24","al26","ce14","con20","ct3","dis10","en40","er58","tion14","ve1"],
                            ["con21","dis11","ge13","ly5","ment5","nd6","o_e10","oi4","ry13","tion15"],
                            ["ai19","er89","ge21","gue1","less3","ry11","ry9","ty15","un10","ur11"]]
    
    
    let map8SyllableSets:[[String]] = [["a_e25","con22","dis12","e_e1","en36","er59","or30","sion3","sive1","sure1"],
                ["a_e26","ai16","al27","ci6","con23","dis13","en37","eye1","or31","sh12"],
                ["a_e27","al28","ble8","ce15","ck8","con24","fi3","i_e19","ing13","ry14"],
                ["con25","ea42","er60","fl1","fo2","ful3","or32","ou25","sh13","tion16"],
                ["an24","ay14","ce16","ee26","fl2","fr4","igh6","ing14","or33","qu2"],
                ["al29","ar23","er61","ga1","ly6","sh14","th12","ty7","un7","ur8"],
                ["a_e28","al30","ch21","ft2","gl2","go3","gr3","in19","ir8","odd1"],
                ["al31","an25","ce17","er62","ful4","gl3","gr4","gu2","ha1","ing15"],
                ["ar24","ea43","ee27","er63","gr5","ha2","i_e20","id2","tion17","tr4"],
                ["ar25","ck9","ey4","gr6","ho1","ly7","o_e11","oo20","or34","ow15"],
                ["a_e29","al32","ble9","dle1","ea44","ge14","hu1","ol1","or35","tion18"],
                ["al33","ce18","ct4","er64","im7","in20","ing16","o_e12","sion4","tion19"],
                ["ce19","ct5","ea45","in21","ject2","or36","qu3","tion20","tive4","ult2"],
                ["a_e30","al34","el15","er65","in22","ja1","je1","ment6","tem1","tion21"],
                ["a_e42","al53","ar31","ea53","ee31","el17","ge22","tion41","un11","vic1"]]

    
    
    let map9SyllableSets:[[String]] = [["a_e31","al35","ce20","ew3","ful5","gle1","in23","jo1","tion22","ui5"],
    ["a_e32","al36","ce21","in24","kn2","ko1","lab1","ly8","ness2","tion23"],
    ["ar26","ble10","bug1","er66","gr7","i_e21","in25","kn3","la1","u_e6"],
    ["au10","aw5","ay15","ea46","en38","in26","ing17","rn2","th13","ty8"],
    ["an26","ck10","er67","igh7","lo1","ly9","oa8","oo21","or37","ture4"],
    ["al37","by3","ea47","er68","gi4","in27","ou26","ous2","sp2","tion24"],
    ["a_e33","ad6","ai17","al38","ce22","er69","ge15","in29","ma1","tic3"],
    ["al39","cal1","ch22","i_e22","in28","it2","me1","ph4","sh15","sure2"],
    ["ble11","cle2","er70","igh8","il3","ment7","mi4","mis1","mo2","sion5"],
    ["el16","er71","mis2","mu1","or38","ple3","th14","ture5","ty9","ug1"],
    ["a_e34","al40","al41","ee28","ly10","mis3","na2","ne1","oo22","tion25"],
    ["ck11","ew4","less1","no2","od1","or39","ous3","ow16","tr5","ur9"],
    ["ch23","er72","ing18","oc1","on5","op4","or40","pic1","sive2","tion26"],
    ["al42","ce23","er73","ge16","oa9","or41","ou27","ough1","th20","tion27"],
    ["ar32","ck15","ea54","eigh1","er90","i_e30","th19","we1","wh5","wh6"]]
    
    
    
    let map10SyllableSets:[[String]] = [["a_e35","an27","ci7","ea52","ma1","o_e13","ow17","ox1","pa1","sh16"],
    ["al43","ar27","ce24","ea48","ee29","i_e23","ly11","pa2","rl1","sion6"],
    ["a_e36","al44","er74","ing19","ph5","ri1","st19","tic4","ty10","um6"],
    ["al45","ay16","ce25","er75","ge17","or42","ous4","ph6","po1","sion7"],
    ["er76","ful6","i_e24","ly12","o_e14","ph7","po2","pr9","tion28","ty11"],
    ["al46","ble12","ce26","er77","ph8","po3","pr10","sive3","tion29","tive5"],
    ["ch24","ct6","er78","gy2","pr11","pu1","sh17","tion30","u_e7","ur10"],
    ["ai18","al47","an28","ar28","aw6","er79","ge18","pr12","qu4","tion31"],
    ["ear1","el19","ing20","ly13","nd7","pr13","qu5","re5","tion32","ty12"],
    ["a_e37","al48","ce27","er80","gi5","or43","pr14","qu6","re6","tion33"],
    ["ble13","dy4","ea49","less2","o_e15","re7","re8","sent2","tion34","tive6"],
    ["ce28","ct7","er81","i_e25","ment8","nt3","re9","tion35","tr6","ue4"],
    ["ch25","er82","fle1","id3","ous5","re10","rh1","sion8","tion37","wr1"],
    ["al49","ce29","ck12","ing21","ly14","re11","ro2","sia1","tic5","tion36"],
    ["dom1","i_e31","in31","ing28","it3","ld1","ness3","or49","wh7","wo1"]]
    
    
    let map11SyllableSets:[[String]] = [["a_e38","al50","ce32","er83","i_e26","ing22","ry6","sa1","sc2","tion38"],
    ["ch26","ci8","e_e2","ea50","en39","ew5","oo23","ry7","sh18","ty13"],
    ["ble14","ce33","ei1","ex5","igh9","im8","in30","ri2","sh19","ture6"],
    ["a_e39","ch27","ee30","er84","ing23","ip2","ly15","sh26","sl1","tion39"],
    ["ce30","ck13","ob2","oi5","or44","ou28","sh20","sm1","sn1","some1"],
    ["ar29","ge19","ing24","kle1","ow18","qu7","so2","sp3","st20","str2"],
    ["a_e40","al51","ble15","ea51","some2","sp4","st21","str3","sub1","tion40"],
    ["er85","i_e27","or45","pl3","sp5","st22","str4","sub2","um7","un8"],
    ["a_e41","ck14","ing25","on6","ry8","st23","str5","sym2","ta2","th15"],
    ["ar30","er86","nd8","nt4","o_e16","ph9","sh21","sm2","sp6","st24"],
    ["al52","ble16","i_e28","ough2","sh22","sion9","sp7","st25","te1","th16"],
    ["ce31","igh10","ing26","oe1","sh23","some3","sp8","st26","th17","to2"],
    ["ch28","er87","ge20","mb2","or46","or47","sh24","st27","th18","tour1"],
    ["ble17","er88","ful7","ing27","oo24","or48","ous6","tw1","ty14","u_e8"],
    ["aw7","dom2","el18","er91","ly17","or50","ow19","wh8","wr2","yo1"]]

    let map12SyllableSets:[[String]] = [["ab3","ac5","ce34","ly18","mic3","my2","or51","sion10","sive4","tion42"],
                             ["a_e43","ab4","ble18","ch29","ci9","com14","ge23","ing29","ou29","u_e9"],
                             ["ab5","ad7","al54","cr13","ct8","dr8","pt1","qu8","ture7","ult3"],
                             ["a_e44","ad8","cy2","ment9","mic4","ny3","ous7","tion43","tive7","ty16"],
                             ["ai20","ar33","ce35","en41","er92","ft3","i_e32","o_e17","tion44","um8"],
                             ["am10","an29","ce36","gy3","ong4","ple4","sis2","tion45","u_e10","ur12"],
                             ["a_e45","au11","ea55","ment10","nt5","ow20","oy3","ry15","th21","tic6"],
                             ["al55","ar34","ay17","cle3","i_e33","ly19","pr15","qu9","re12","tic7"],
                             ["a_e46","ar35","as3","ct9","et5","gn2","in49","or52","sh27","tion46"],
                             ["as4","at5","ce37","ck16","em7","en42","er93","ph10","sure3","sym3"],
                             ["au12","ble19","ch30","oi6","ous8","th22","tion47","u_e11","ue5","um9"],
                             ["a_e47","al56","ar36","au13","aw8","ba4","ful18","ge24","is4","oo25"],
                             ["ar37","ba5","be4","ea56","en43","er94","it4","ly20","ness4","ow21"],
                             ["as5","bi3","bl4","br11","ch31","ck17","ea57","ee32","ge25","gi6"],
                             ["bl5","bo3","ce38","er95","ing30","oa10","old3","oo26","sh28","th23"]]
    
    
    let map13SyllableSets:[[String]] = [["a_e48","ai21","bl6","br12","ew6","i_e34","qu10","que2","th24","ty17"],
                 ["ab6","al57","bl7","br13","bu6","by4","ch32","ck18","dle2","gy4"],
                 ["a_e49","an30","ar38","ble20","br14","bu7","ca8","cap1","or53","ria1"],
                 ["al58","an31","ar39","bu8","ca9","er96","gue2","ry16","sh29","ty18"],
                 ["am11","ca10","ce39","ch33","ci10","cl12","er97","ment11","nic3","ph11"],
                 ["ay18","ce40","ch34","ci11","cl13","fy1","ge26","tic8","tion48","ty19"],
                 ["al59","ce41","ch35","ci12","cl14","co23","com15","ee33","sion11","tion49"],
                 ["ble21","ch36","cl15","co24","com16","con26","ment12","sive5","tion50","tive8"],
                 ["ch37","co25","com17","con27","ing31","ment13","sion12","tion51","tive9","ty20"],
                 ["a_e50","ce42","ch38","com18","con28","er98","ous9","qu11","ry17","tion52"],
                 ["a_e51","ch39","com19","con29","er99","on8","or54","ou30","tion53","u_e12"],
                 ["al60","ch40","ck19","com20","con30","cr14","ing32","ow22","sh30","ui6"],
                 ["al61","ble22","ch41","com21","con31","cr15","ple5","ture8","ue6","um10"],
                 ["ch42","com22","con32","cr16","ing33","ly21","o_e18","u_e13","ur13","us2"],
                 ["a_e52","ch43","con33","ea58","en44","er100","que4","sh31","ur14","zle2"]]

    let map14SyllableSets:[[String]] = [["a_e53","ce43","con34","cy3","de4","e_e3","en45","i_e35","tive10","ty21"],
                             ["a_e54","ce44","con35","de5","er101","et6","ge27","i_e36","oi7","tion54"],
                             ["a_e55","al62","con36","de","di4","gr8","ma2","sion13","tion55","u_e14"],
                             ["a_e56","ay19","ble23","ce45","con37","de7","dis14","er102","tion56","tive11"],
                             ["a_e57","ai22","ch44","con38","de8","dis15","i_e37","o_e19","tic9","tion57"],
                             ["a_e58","con39","dis16","dr9","el20","ly22","oo27","or55","ow23","ry18"],
                             ["a_e59","con40","dis17","dy5","ic1","ing34","sive8","tem2","tic10","tion58"],
                             ["a_e60","al63","cian4","con41","dis18","ly23","ment14","nt6","or56","ow24"],
                             ["ce46","cy4","dis19","ee34","em8","ge28","i_e38","less4","li2","u_e15"],
                             ["al64","ble24","dis20","en46","igh11","ment15","o_e20","ous10","th25","tion59"],
                             ["a_e61","al65","au14","ce47","ge29","ly24","nic4","sion14","tion60","vo1"],
                             ["a_e62","al66","dis21","er103","or57","qu12","sive6","tic11","tr7","ty22"],
                             ["a_e63","an32","ck20","ea59","en47","er104","ing35","ry19","sh32","tion61"],
                             ["a_e64","al67","aw9","ce48","fl3","i_e39","it5","kle2","st30","u_e16"],
                             ["a_e65","ble25","ee35","fl4","fo3","ing36","o_e21","oa11","or58","sh33"]]

    
    let map15SyllableSets:[[String]] = [["a_e66","al68","er105","fr5","ge30","ment16","or59","ou31","tion62","ty23"],
                             ["a_e67","au15","ce49","ea60","ga2","or60","ous11","th26","tion63","un12"],
                             ["a_e69","al69","con42","ge32","gl4","gle2","i_e40","tic12","tle4","ture9"],
                             ["a_e68","an33","er106","ge33","gr9","im9","ing37","ous12","ph12","u_e17"],
                             ["a_e70","an34","ar40","ble26","ee36","gr10","in50","ow25","sh34","ul2"],
                             ["ar41","au16","ch45","ea61","er107","ha3","less5","st31","tic13","ty24"],
                             ["a_e71","ck21","ge34","ho2","o_e22","ou32","ous13","ry20","ug2","um11"],
                             ["a_e72","al70","ble27","ce50","dle3","gy5","i_e41","im10","sion15","tion64"],
                             ["al71","ble28","ce51","ge35","im11","in51","ing38","ment17","sive7","tive12"],
                             ["a_e73","al72","ble29","ce52","gue3","in52","in53","tion65","tive13","ty25"],
                             ["a_e74","al73","ble30","ce53","cy5","er108","in54","ly25","ry21","tion66"],
                             ["a_e75","ai23","al74","ble31","in55","or61","ous14","ry22","tion67","ue7"],
                             ["a_e76","am12","ay20","ea62","ey5","i_e42","in56","la2","ph13","u_e18"],
                             ["a_e77","al75","ce54","er109","i_e43","igh12","im12","in57","ly26","ty26"],
                             ["a_e78","ck22","en48","er110","ge36","in58","lo2","oa12","oo28","tion68"]]
    
    let map16SyllableSets:[[String]] = [["a_e79","ai24","al76","in59","ing39","or62","ous15","ry23","tive14","u_e19"],
                             ["a_e80","ar42","ble32","ch46","er111","in60","ma3","ow26","tion69","ture10"],
                             ["al77","ce55","em9","en49","ful9","in61","ma4","me2","tic14","um12"],
                             ["al78","i_e44","in62","ly27","me3","mis4","mo3","ry24","ty27","us3"],
                             ["a_e81","ch47","er112","in63","me4","ment18","oi8","ture11","u_e20","um13"],
                             ["a_e82","al79","ea63","el21","ge37","na3","or63","sh35","tion70","tive15"],
                             ["al80","ble33","ck23","ct10","fy2","less6","ni1","ous16","tion71","ty28"],
                             ["a_e83","ble34","ce56","e_e4","ob3","ous17","ry25","sion16","th27","wh9"],
                             ["er113","in64","ing40","ly28","ob4","oc2","odd2","op5","or64","tion72"],
                             ["al81","ce57","ee37","er114","i_e45","ing41","nic5","o_e23","or65","ou33"],
                             ["a_e84","al82","cle4","el22","er115","i_e46","or66","ph14","sis3","u_e21"],
                             ["a_e85","ce58","ch48","ge38","gy6","ment19","pa3","sion17","tic15","ty29"],
                             ["al83","er116","ic2","it6","ou34","pe1","ph15","que3","tive16","ty30"],
                             ["er117","er118","or67","ou35","ow27","ph16","pi3","pl4","tion73","um14"],
                             ["a_e86","ble35","ch49","ea64","i_e47","igh13","o_e24","or68","po4","sh36"]]

    
    let map17SyllableSets:[[String]] = [["ai25","al84","ce59","ly29","ous18","pre1","ry26","tion74","tive17","ture12"],
                             ["ce60","cy6","ee38","ge39","i_e48","ous19","pr16","pre2","sure4","tion75"],
                             ["al85","ct11","ing42","o_e25","pr17","sion18","tion76","tive18","ty31","u_e22"],
                             ["ble36","o_e26","pr18","qu13","st32","tion77","ty32","ue8","um15","ur15"],
                             ["a_e87","an35","ar43","ck24","ge40","ly30","pr19","qu14","ra1","tion78"],
                             ["ai26","al86","aw10","ay21","ce61","ci13","ea65","ous20","sion19","tion79"],
                             ["a_e88","ee39","er119","gn3","ing43","less7","re13","re16","tion80","un13"],
                             ["ai27","ble37","ce62","ct12","ea66","pr20","qu15","re14","tion81","u_e23"],
                             ["al87","ce63","ge41","ly31","or69","qu16","re15","ri3","tion82","ue9"],
                             ["ble38","i_e49","im13","oa13","oo29","ou36","re17","ro3","ru1","tion83"],
                             ["a_e89","ce64","ft4","ge42","ous21","ple6","re18","sa2","sc3","ty33"],
                             ["a_e90","ce65","ch50","ing44","re19","ry27","sc4","se1","sh37","u_e24"],
                             ["al88","by5","ck25","e_e5","en50","er120","ment20","re20","ry28","sc5"],
                             ["a_e91","er121","ness5","re21","sc6","sh38","si2","sk4","sl2","ture13"],
                             ["er122","gle3","gy7","oa14","oi9","re22","sc7","sh39","sl3","th28"]]

    
    let map18SyllableSets:[[String]] = [["ar44","ce66","i_e50","o_e27","ou37","ph17","sh40","so3","sp9","tion84"],
                             ["a_e92","al89","ble39","ee40","ge43","ing45","ly32","ous22","sh41","sp10"],
                             ["ck26","ing46","ry29","sh42","sp11","st33","tic16","tle5","u_e25","um16"],
                             ["a_e93","ch51","ck27","ing47","oo30","sh43","sp12","st34","str6","sub3"],
                             ["al90","er123","i_e51","ment21","sh44","sp13","st35","str7","sub4","um17"],
                             ["ai28","am13","ge44","ow28","sh45","st36","su1","sub5","sym4","tic17"],
                             ["a_e94","al91","ar45","ea67","er124","sion20","st37","str8","syn1","ta3"],
                             ["ea68","er125","gy8","i_e52","ic3","or70","ry30","st38","ta4","th29"],
                             ["ce67","ch52","ck28","ge45","igh14","or71","st39","th30","ti2","tion85"],
                             ["ai29","an36","ble40","ce68","er126","ous23","th31","tion86","tr8","un14"],
                             ["a_e95","al92","i_e53","ing48","ly33","old4","th32","tr9","tw3","un15"],
                             ["a_e96","ch53","ly34","ous24","th33","tion87","tr10","ty34","un16","va1"],
                             ["al93","ce69","ness6","ous25","th35","tr11","ture14","ty35","un17","ve2"],
                             ["a_e97","al94","ax3","ble41","ge46","no3","th34","un18","ve3","vi1"],
                             ["ar46","ck29","th36","ut1","vi2","we1","wh10","wh11","wr1","ya1"]]
    
    
    
    
    
    
    
    //特殊顏色
    let lightGreen = UIColor.init(red: 196/255, green: 255/255, blue: 137/255, alpha: 1)
    let darkWordColor = UIColor.init(red: 104/255, green: 129/255, blue: 130/255, alpha: 1)
    let lightPink = UIColor.init(red: 255/255, green: 217/255, blue: 239/255, alpha: 100)
    let selectWordDarkColor = UIColor.init(red: 62/255, green: 60/255, blue: 61/255, alpha: 1)
    //分數顏色
    let pinkColor = UIColor.init(red: 1, green: 153/255, blue: 212/255, alpha: 1)
    let hintWordBlue = UIColor.init(red: 52/255, green: 136/255, blue: 182/255, alpha: 1)
    let specialYellow = UIColor.init(red: 239/255, green: 196/255, blue: 92/255, alpha: 1)
    
    
    //中文字左右對錯
    var leftOrRight = Int()
    let leftChiNode = SKLabelNode()
    let rightChiNode = SKLabelNode()
    
    //目前單字的順位
    var currentWordSequence = 0
    
    //目前練習順序
    var currentPracticeSequence = 0
    
    //暫時使用的單字
    var wordSets = [String]()
    //要抓全+殘的全部單字
    var allWordSets = [[String]]()

    //暫時使用的句子
    var sentenceSets = [String]()
    
    //此元素頁面裡所有的音節
    var syllables = [String]()
    
    //被設定好的頁數
    var spotNumber = Int()
    var unitNumber = Int()
    var gameMode = Int()
    var mapNumber = Int()
    
    //紀錄第一個sequence
    var firstSequence = Int()
    
    //做三個字的label
    var firstEngWordLabel = UILabel()
    var secondEngWordLabel = UILabel()
    var thirdEngWordLabel = UILabel()
    
    var firstChiWordLabel = UILabel()
    var secondChiWordLabel = UILabel()
    var thirdChiWordLabel = UILabel()
    
    //造字時的當下音節
    var syllablesToCheck = String()
    var firstSyllablesWithoutDigit = String()
    var secondSyllablesWithoutDigit = String()
    var thirdSyllablesWithoutDigit = String()
    
    //紀錄單字有沒有加入最愛
    var wordsLoved = [0,0,0]
  
    var firstEngWord = String()
    var secondEngWord = String()
    var thirdEngWord = String()
    var wrongWords = [String]()
    var myWrongWords = [String]()
    
    
    //是否能按功能button
    var isButtonEnable = false
    
    //紀錄按到了幾次node
    var touchTimes = 0
    
    //做三個字
    var words = [NSMutableAttributedString(),NSMutableAttributedString(),NSMutableAttributedString()]
    
    //var words = NSMutableAttributedString()
    
    //發音單字
    var wordsToPronounce = String()
    
    //正確的答案
    var currentWordArray = [String]()
    
    //選項單字
    var shownWords = [String]()
    
    //是否能作答
    var isDragAndPlayEnable = false
    
    //所有node的名稱
    var selNodeNames = ["se0","se1","se2","se3","se4"]
    
    //紀錄手指位置
    var location = CGPoint()
    
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
    
    //輸入的答案
    var wordEntered = [String]()
    
    //有沒有按畫面
    var isTouched = false
    //結束有沒有在node上
    var isEndOnNode = false
    //node有沒有移除
    var isRemoved = false
    
    //指定目前的label
    var currentEngWordLabel = UILabel()
    var currentChiWordLabel = UILabel()
    
    //存放三個中文字
    var allThreeChiWords = [String]()
    var allThreeEngWords = [String]()
    
    var popQuizThreeChiWords = [String]()
    var popQuizThreeEngWords = [String]()

    //控制是否為第二次聽考
    var isBackToSpell = false
    
    var countScoreTimer = Timer()
    var answerTime = 0
    
    //紀錄已加過的分數
    var scoreAdded = Int()
    var isFinalGetPoint = false
    
    //紀錄三個字的正確與否
    var correctResults = ["0","0","0"]
    var wrongChinese = ["0","0","0"]
    
    //記錄我的最愛以及錯誤單字
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var allUnitSpotNums = [[Int]]()
    
    var randomSpots = [Int]()
    var randomUnits = [Int]()
    
    var popQuizTimer = Timer()
    
    var isChangeYPos = false
    
    var isPopQuiz = false
    
    var allPopQuizEngWords = [String]()
    var allPopQuizChiWords = [String]()
    var randomNums = [0,1,2,3,4,5]
    var engRandomNums = [Int]()
    
    var popQuizSeq = 0
    
    var sparkle:SKEmitterNode?
    var sparkle1:SKEmitterNode?
    var sparkle2:SKEmitterNode?
    
    var gamePassedDic:[Int:Int]?
    var mapPassedInt = Int()
    var increaseNum = Int()
    var courseReceived = Int()
    
    var popQuizRight = -1
    
    var wordReviewCount = Int()
    
    
    var maxSpotNum = Int()
    var maxMapNum = Int()
    
    var isFinalPopCorrect = false
    
    
    var rightSound = SKAction()
    var wrongSound = SKAction()
    var endSound = SKAction()

    let purpleColor = UIColor.init(red: 212/255, green: 141/255, blue: 249/255, alpha: 1)

   
    let orangeColor = UIColor.init(red: 232/255, green: 98/255, blue: 61/255, alpha: 1)
    
  
    
    override func didMove(to view: SKView) {
        
         makeLabelNode(x: 0, y: -290, alignMent: .center, fontColor: .white, fontSize: 40, text: "", zPosition: 3, name: "showHint", fontName: "Helvetica Bold", isHidden: true, alpha: 1)
        
        
        //啟動離開遊戲
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyLeaveGame), name: NSNotification.Name("leaveGame"), object: nil)
        
        //口試Nc (單字 + 句子)
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyStartToRecognize), name: NSNotification.Name("startToRecognize"), object: nil)
        
        //接收聽考Nc
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.backToSpell), name: NSNotification.Name("backToSpell"), object: nil)
        
        //啟動造句子Nc
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyShowSentence), name: NSNotification.Name("showSentence"), object: nil)
        
        //接收下個單字
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.receiveCorrectPracticeNextWord), name: NSNotification.Name("practiceNextWord"), object: nil)
        
        //重新寫NC
        //1. 啟動發音
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyPronounceWord), name: NSNotification.Name("pronounceWord"), object: nil)
        
        //計分
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.addScore), name: NSNotification.Name("addScore"), object: nil)
        
      //接受倒數
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.startCountDown), name: NSNotification.Name("startCountDown"), object: nil)
        
        //啟動時間到
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyTimesUp), name: NSNotification.Name("timesUp"), object: nil)

        //啟動顯示tagView
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyShowTag), name: NSNotification.Name("showTag"), object: nil)
        
        //啟動顯示tagView
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.readyToReadSentence), name: NSNotification.Name("readyToReadSentence"), object: nil)
        
        //啟動顯示tagView
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyReadSentence), name: NSNotification.Name("readSentence"), object: nil)
        
        //啟動顯示tagView
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyOnlyPracticeSentence), name: NSNotification.Name("onlyPracticeSentence"), object: nil)

        //重新開始練習句子
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyStopReview), name: NSNotification.Name("stopReview"), object: nil)
        
        //暫停
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyPause), name: NSNotification.Name("pause"), object: nil)
        
        //接收再度倒數
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.restartCounting), name: NSNotification.Name("restartCounting"), object: nil)
        
        
        //接收再度倒數
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyStopLimitTimer), name: NSNotification.Name("stopLimitTimer"), object: nil)
        
        //接收再度倒數
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.playEndingMusic), name: NSNotification.Name("playEndingMusic"), object: nil)
        
        //移除發音符號
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameScene.notifyRemovePronounceBtn), name:  NSNotification.Name("removePlaySoundBtn"), object: nil)

        
        //接收再度倒數

        //先解決算出wordSequence之後再來讀取所有的字
        
        
        rightSound = SKAction.playSoundFileNamed("correct.wav", waitForCompletion: false)
        wrongSound = SKAction.playSoundFileNamed("wrong30.mp3", waitForCompletion: false)
        endSound = SKAction.playSoundFileNamed("ending30.mp3", waitForCompletion: false)
       
        
        
        
        
        if gameMode == 2 {
        
           
            //進入純粹練習句子的func
            
            //在此的func都只會執行一次
            //載入各種字
            loadAllKindsOfWord()
            
            currentWordSequence = 0
          
            //只做句子練習畫面
            setUpSentenceScreen()
            
        } else if gameMode == 1 {
            
            //讀目前課程數字數量
            switch courseReceived {
                
            case 0:
                
                gamePassedDic = gamePassed!
                mapPassedInt = mapPassed!
                increaseNum = 0
                maxMapNum = 5
                maxSpotNum = 14
                
            case 1:
                
                gamePassedDic = gamePassed2!
                mapPassedInt = mapPassed2!
                increaseNum = 5
                maxMapNum = 6
                maxSpotNum = 14
                
            case 2:
                
                gamePassedDic = gamePassed3!
                mapPassedInt = mapPassed3!
                increaseNum = 11
                maxMapNum = 7
                maxSpotNum = 14
                
            default:
                break
                
            }
       
            //做所有亂數可能性的array
            
            //隨機單字
                //在此抓測驗單字的亂數順序
            
            var tempGamePassedDic:[Int:Int]?
            
        //    if mapPassedInt == maxMapNum {
                //如果已破關
            if mapNumber < mapPassedInt{
                
                tempGamePassedDic = [maxSpotNum:9]
                
                
            } else {
                
                tempGamePassedDic = gamePassedDic
            }
            
                
                for (s,u) in tempGamePassedDic!{
                    
                    //1. 填入spot上限供亂數選擇
           
                    //填入全部
                    if s > 0 {
                        
                        allUnitSpotNums = [Array<Any>](repeating: [Int](), count: s + 1) as! [[Int]]
                        
                        for i in 0 ..< (s) {
                            
                            for n in 0 ..< 30{
                                
                                allUnitSpotNums[i].append(n)
                                
                            }
                            
                        }
                        
                        //填入殘值
                        if u > 0 {
                            
                            for i in 0 ..< u * 3 {
                                
                                allUnitSpotNums[allUnitSpotNums.count - 1].append(i)
                                
                            }
                            
                        } else {
                            
                            
                            allUnitSpotNums.remove(at: allUnitSpotNums.count - 1)
                            
                        }

                    
                        
                    } else {
                        
                        allUnitSpotNums = [Array<Any>](repeating: [Int](), count: 1) as! [[Int]]
                        //填入殘值
                        if u > 0 {
                            
                            for i in 0 ..< u * 3 {
                                
                                allUnitSpotNums[0].append(i)
                                
                            }
                        }
                    }
                    
                }
            
            //在此確認是否有字可以複習沒有就跳出alert
             //   if allUnitSpotNums != [[Int]()]{

            
            /*
            if mapNumber < mapPassedInt{
                //手動加三個
                
                allUnitSpotNums[allUnitSpotNums.count - 1].append(27)
                allUnitSpotNums[allUnitSpotNums.count - 1].append(28)
                allUnitSpotNums[allUnitSpotNums.count - 1].append(29)
                
                
                
            }
            */
            
            print(allUnitSpotNums)
            //載入各種字
            loadAllKindsOfWord()
            //設定畫面
            setUpScreen()
     
                /*
                } else {
                    
                    
                    print("can't practice")
                    
            }
            */
        } else if gameMode == 0{
        
            //載入各種字
            loadAllKindsOfWord()
            //設定畫面
            setUpScreen()
            
            
            //提示timer
            //hintTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NewGameScene.showHint), userInfo: nil, repeats: true)
            
            
            
            
        }
        //避免多次按
        self.view?.isMultipleTouchEnabled = false
        
        makeImageNode(name: "popUpBlock", image: "popUpBlock2", x: 0, y: -1334 / 2 + 228 * 1.5, width: 750, height: 228, z: 7, alpha: 0, isAnchoring: false)
        makeLabelNode(x: 0, y: -1380 / 2 + 228 * 1.5, alignMent: .center, fontColor: .white, fontSize: 70, text: "", zPosition: 8, name: "popUpLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        makeImageNode(name: "popDownBlock", image: "popDownBlock2", x: 0, y: -1334 / 2 + 114, width: 750, height: 228, z: 7, alpha: 0, isAnchoring: false)
        makeLabelNode(x: 0, y: -1380 / 2 + 114, alignMent: .center, fontColor: .white, fontSize: 70, text: "", zPosition: 8, name: "popDownLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
   
    
    
   
    
    
    }
    
    //載入各種字, 這裡面的load word要換位置避免浪費資源
    func loadAllKindsOfWord(){
        
        //抓三個random, 抓完之後移除, 然後再抓三個, 為了配合原本的機制
        if gameMode == 1 {
            
            allWordSets.removeAll(keepingCapacity: false)
            randomSpots.removeAll(keepingCapacity: false)
            randomUnits.removeAll(keepingCapacity: false)
            
            
    
            for _ in 0 ..< 3 {
                
                
                //新增目前能選擇的spotIndex
                let spotIndex = Int(arc4random_uniform(UInt32(allUnitSpotNums.count)))
                randomSpots.append(spotIndex)
                
                //從目前能選的spotIndex中選擇能選的unitIndex
                let unitCount = allUnitSpotNums[spotIndex].count
                let unitIndex = Int(arc4random_uniform(UInt32(unitCount)))
                randomUnits.append(allUnitSpotNums[spotIndex][unitIndex])
                
                
                //移除
                
                allUnitSpotNums[spotIndex].remove(at: unitIndex)
                
                if allUnitSpotNums[spotIndex].count == 0 {
                    
                    allUnitSpotNums.remove(at: spotIndex)
                }

            }
            
            print("randomSpots\(randomSpots)")
            print("randomUnits\(randomUnits)")
       
        }
        
        //讀取所有錯誤的字供比對

        if let myWrongWordsString = user?["wrongWords"] as! String?{
            myWrongWords = myWrongWordsString.components(separatedBy: ";")
        //    print("myWrongWords:\(myWrongWords)")
        }
        
      //  print("unitNumber:\(unitNumber)")
     //   print("spotNumber:\(spotNumber)")
       
        //測試用
        
        
        /*
         spotNumber = 0
         unitNumber = 1
 */

        
        //抓正確的音節
        
        //設定地圖的音節
        switch mapNumber {
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
            
        default:
            break
        }
        
        //在此設定gameMode0的指定音標, gameMode1的分別音標在makeword裡面
        syllables = syllableSets[spotNumber]
        
        
        if gameMode == 0 {
            
            //抓正確unit
            currentWordSequence = 3 * unitNumber
            firstSequence = currentWordSequence
            
        //讀取Bundle裡的文字檔
        var wordFile:String?
        
        let name = String(mapNumber + 1) + "-" + String(spotNumber + 1)
        print("name:\(name)")
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
            
        } else if gameMode == 1 {
            
            var tempGamePassDic:[Int:Int]?
            
            if mapPassedInt == maxMapNum {
                //假如mapPassInt等於最大map數, 那就mapPassInt 不加1, gamePassedDic以最大值

                
                mapPassedInt += increaseNum - 1
                tempGamePassDic = [maxSpotNum:9]
                
                
            } else if mapNumber < mapPassedInt{
                
                mapPassedInt += increaseNum
                   tempGamePassDic = [maxSpotNum:9]
                
                
                
            } else {
            
            //抓目前map數值的正確檔案名稱
            mapPassedInt += increaseNum
                tempGamePassDic = gamePassedDic
            }
            
            for (s,_) in tempGamePassDic!{
                
                //讀取已完整的所有字集
                
                for i in 0 ..< (s + 1){
                    
                    var wordFile:String?
                    //前面的1代表第一張地圖
                    let name = String(describing: mapPassedInt + 1) + "-" + String(i + 1)
                    
                    //抓字
                    if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
                        do {
                            wordFile = try String(contentsOfFile: filepath)
                            let words = wordFile?.components(separatedBy: "; ")
                            
                            //把字讀取到wordSets裡
                            allWordSets.append(words!)
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
        
        print(allWordSets)
        
    }
    
    
    var hintSec = Int()
    
    
    /*
    @objc func showHint(){
        
        hintSec += 1
        
        
    }
    */
    
    
    
    @objc func notifyRemovePronounceBtn(){
        
        print("notify remove pronounce btn")
    }
    
    
    
    @objc func playEndingMusic(){
        
        self.run(endSound)
        
    }
    
    @objc func notifyOnlyPracticeSentence(){
        
    }
    
    @objc func notifyPause(){
        
    }
    
    @objc func restartCounting(){
     
        let lineNode = findImageNode(name: "countDownLine")
        
        if lineNode.isPaused && !lineNode.alpha.isZero{
            print("resume count down")
            lineNode.isPaused = false
        }

    }
    
    
    //只做句子練習畫面
    func setUpSentenceScreen(){
        
        var chiBtnDif = CGFloat()
      //  var iPadDif = CGFloat()
        
        switch  height {
        case 812:
            chiBtnDif = 0.8
            iPadDif = 1
   
        case 736:
            chiBtnDif = 1
            iPadDif = 1

        case 667:
            chiBtnDif = 0.95
iPadDif = 1
        case 568:
            chiBtnDif = 0.9
iPadDif = 1
        default:
            chiBtnDif = 0.9
iPadDif = 1.2
        }
        
        //背景
        makeImageNode(name: "gameBg", image: "newGameBg2", x: 0, y: 0, width: 754, height: 1334, z: 0, alpha: 1, isAnchoring: false)
        
        makeImageNode(name: "recogWordsBg", image: "recogWordsBg", x: 0, y: 0, width: 750, height: 228, z: 10, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "countDownLine", image: "countDownLine", x: -375, y: -114, width: 750, height: 5, z: 11, alpha: 0, isAnchoring: true)
        
        
             makeImageNode(name: "pause", image: "pauseBtn", x: -330 * chiBtnDif, y: 550 / iPadDif, width: 39, height: 64, z: 2, alpha: 1, isAnchoring: false)

        //單字量Label, 這部分是新的
        makeLabelNode(x: 350 * chiBtnDif, y: 550 / iPadDif, alignMent: .right, fontColor: .clear, fontSize: 35, text: "0", zPosition: 1, name: "scoreLabel", fontName: "Helvetica Neue", isHidden: false, alpha: 1)
    
        //提示字
        makeLabelNode(x: -425, y: 0, alignMent: .center, fontColor: .white, fontSize: 50, text: "", zPosition: 1, name: "hintLeftLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        makeLabelNode(x: 425, y: 0, alignMent: .center, fontColor: .white, fontSize: 50, text: "", zPosition: 1, name: "hintRightLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        
        
        
        //send Nc
        
         let wordSequence:[String:Int] = ["wordSequence":currentWordSequence]
        
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "onlyPracticeSentence"), object: nil, userInfo: wordSequence)

    }
    
    //載入畫面
        var engFontSize = CGFloat()
    func setUpScreen(){
        
        findLabelNode(name: "showHint").text = "請連線拼字"
        
        var chiBtnDif = CGFloat()
        var dif = CGFloat()

    
        
        switch  height {
        case 812:
            chiBtnDif = 0.8
            dif = 0.9
            iPadDif = 1
            engFontSize = 65
        case 736:
            chiBtnDif = 1
            dif = 0.9
            iPadDif = 1
            engFontSize = 65
        case 667:
            chiBtnDif = 0.95
            dif = 1
            iPadDif = 1
            engFontSize = 60
        case 568:
            chiBtnDif = 0.9
            dif = 0.9
            iPadDif = 1
            engFontSize = 50
        default:
            chiBtnDif = 0.9
            dif = 0.9
            iPadDif = 1.2
            engFontSize = 65
        }
        
        //背景
        var bgImgString = String()
       
        
        
        var lightImg = "lightSel"
        var darkImg = "darkSel"
        var pauseImg = String()
        
        var textColor = UIColor()
        switch gameMode{
        case 0:
            
            bgImgString = "newGameBg"
            lightImg = "lightSel"
            darkImg = "darkSel"
            pauseImg  = "pauseBtn"
            textColor = pinkColor
            
        case 1:
            bgImgString = "newGameBg2"
            lightImg = "lightSel2"
            darkImg = "darkSel2"
            pauseImg  = "pauseBtn2"
            textColor = UIColor.clear
            
        default:
            break
            
        }
        
        
        //暫時測試用
        makeImageNode(name: "gameBg", image: bgImgString, x: 0, y: 0, width: 754, height: 1334, z: 0, alpha: 1, isAnchoring: false)
        
        //makeImageNode(name: "gameBg", image: "popQuizBg", x: 0, y: 0, width: 754, height: 1334, z: 0, alpha: 1, isAnchoring: false)
        
        
        makeImageNode(name: "pause", image: pauseImg, x: -330 * chiBtnDif, y: 550 / iPadDif, width: 39, height: 64, z: 2, alpha: 1, isAnchoring: false)
        
        // 製作TimerBg & timer label
        
        makeLabelNode(x: 0, y: height * 3 / 5 * dif, alignMent: .center, fontColor: specialYellow, fontSize: 50, text: "限時挑戰", zPosition: 2, name: "quizTitle", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        
        makeImageNode(name: "timerBg", image: "timerBg", x: 0, y: height * 2 / 5 * dif, width: 277 * dif, height: 185 * dif, z: 1, alpha: 0, isAnchoring: false)
        
        makeLabelNode(x: -65 * dif, y: height * 1.4 / 5 * dif, alignMent: .center, fontColor: .white, fontSize: 130, text: "0", zPosition: 2, name: "bigNumber", fontName: "Helvetica Neue", isHidden: false, alpha: 0)
        
        makeLabelNode(x: 65 * dif, y: height * 1.4 / 5 * dif, alignMent: .center, fontColor: .white, fontSize: 130, text: "3", zPosition: 2, name: "smallNumber", fontName: "Helvetica Neue", isHidden: false, alpha: 0)

        makeLabelNode(x: 0, y: -50 * dif, alignMent: .center, fontColor: .white, fontSize: 110, text: "", zPosition: 1, name: "bigChineseLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 0)
        
        
        makeImageNode(name: "recogWordsBg", image: "recogWordsBg", x: 0, y: 0, width: 750, height: 228, z: 10, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "countDownLine", image: "countDownLine", x: -375, y: -114, width: 750, height: 5, z: 11, alpha: 0, isAnchoring: true)
        

        //分數Label, 這部分是新的
         makeLabelNode(x: 350 * chiBtnDif, y: 550 / iPadDif, alignMent: .right, fontColor: textColor, fontSize: 35, text: "0", zPosition: 1, name: "scoreLabel", fontName: "Helvetica Neue", isHidden: false, alpha: 1)
        
        
        
        //測試用看星星的位置
        makeImageNode(name: "star0", image: "emptyStar", x: 210 * chiBtnDif, y: 520, width: 50, height: 48, z: 2, alpha: 0, isAnchoring: false)
         makeImageNode(name: "star1", image: "emptyStar", x: 280 * chiBtnDif, y: 520, width: 50, height: 48, z: 2, alpha: 0, isAnchoring: false)
         makeImageNode(name: "star2", image: "emptyStar", x: 350 * chiBtnDif, y: 520, width: 50, height: 48, z: 2, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "star3", image: "filledStar", x: 210 * chiBtnDif, y: 480, width: 50, height: 48, z: 2, alpha: 0, isAnchoring: false)
        makeImageNode(name: "star4", image: "filledStar", x: 280 * chiBtnDif, y: 480, width: 50, height: 48, z: 2, alpha: 0, isAnchoring: false)
        makeImageNode(name: "star5", image: "filledStar", x: 350 * chiBtnDif, y: 480, width: 50, height: 48, z: 20, alpha: 0, isAnchoring: false)
        
        
        //測試星星移動
        /*
        let wait = SKAction.wait(forDuration: 1)
        let pointsPosition = CGPoint(x: 250, y: 400)
        let rotate = SKAction.rotate(toAngle: 720, duration: 0.2)
        let moveTo = SKAction.move(to: pointsPosition, duration: 0.2)
        
        let groupAction = SKAction.group([rotate,moveTo])
        let sequence = SKAction.sequence([wait,groupAction])
        findImageNode(name: "star5").run(sequence)
 */
        
        sparkle = SKEmitterNode(fileNamed: "fire.sks")
        sparkle?.position = CGPoint(x: 210 * chiBtnDif, y: 520)
        sparkle?.name = "spark"
        sparkle?.isHidden = true
        
        self.addChild(sparkle!)

 
        sparkle1 = SKEmitterNode(fileNamed: "fire.sks")
        sparkle1?.position = CGPoint(x: 280 * chiBtnDif, y: 520)
        sparkle1?.name = "spark"
        sparkle1?.isHidden = true
        
        self.addChild(sparkle1!)
       
        sparkle2 = SKEmitterNode(fileNamed: "fire.sks")
        sparkle2?.position = CGPoint(x: 350 * chiBtnDif, y: 520)
        sparkle2?.name = "spark"
        sparkle2?.isHidden = true
        
        self.addChild(sparkle2!)


        
        
        //提示字
        makeLabelNode(x: -425, y: 0, alignMent: .center, fontColor: .white, fontSize: 50, text: "", zPosition: 1, name: "hintLeftLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        makeLabelNode(x: 425, y: 0, alignMent: .center, fontColor: .white, fontSize: 50, text: "", zPosition: 1, name: "hintRightLabel", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        
        //製作按鈕
        let lightWidth:CGFloat = 150
        let lightHeight:CGFloat = 150
        let darkWidth:CGFloat = 150
        let darkHeight:CGFloat = 150

        let positions = [[-135,-500],[-230,-280],[135,-500],[230,-280],[0,-90]]
        
        //選項按鈕
        
        makeNode(name: "se0", color: .clear, x:CGFloat(positions[0][0]) , y: CGFloat(positions[0][1]) / iPadDif, width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se1", color: .clear, x:CGFloat(positions[1][0]) , y: CGFloat(positions[1][1]) / iPadDif, width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se2", color: .clear, x:CGFloat(positions[2][0]) , y: CGFloat(positions[2][1]) / iPadDif, width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se3", color: .clear, x:CGFloat(positions[3][0]) , y: CGFloat(positions[3][1]) / iPadDif, width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        makeNode(name: "se4", color: .clear, x:CGFloat(positions[4][0]) , y: CGFloat(positions[4][1]) / iPadDif, width: darkWidth, height: darkHeight, z: 6, isAnchoring: false, alpha: 1)
        
        //填滿按鈕
        
        makeImageNode(name: "0filledButton", image: lightImg, x:CGFloat(positions[0][0]) , y: CGFloat(positions[0][1]) / iPadDif, width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "1filledButton", image: lightImg, x:CGFloat(positions[1][0]), y: CGFloat(positions[1][1]) / iPadDif, width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "2filledButton", image: lightImg, x:CGFloat(positions[2][0]) , y: CGFloat(positions[2][1]) / iPadDif, width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "3filledButton", image: lightImg, x:CGFloat(positions[3][0]) , y: CGFloat(positions[3][1]) / iPadDif, width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        makeImageNode(name: "4filledButton", image: lightImg, x:CGFloat(positions[4][0]) , y: CGFloat(positions[4][1]) / iPadDif, width: lightWidth, height: lightHeight, z: 4, alpha: 0, isAnchoring: false)
        
        
        //空的按鈕
        makeImageNode(name: "0emptyButton", image: darkImg, x:CGFloat(positions[0][0]) , y: CGFloat(positions[0][1]) / iPadDif, width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "1emptyButton", image: darkImg, x:CGFloat(positions[1][0]) , y: CGFloat(positions[1][1]) / iPadDif, width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "2emptyButton", image: darkImg, x:CGFloat(positions[2][0]) , y: CGFloat(positions[2][1]) / iPadDif, width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "3emptyButton", image: darkImg, x:CGFloat(positions[3][0]) , y: CGFloat(positions[3][1]) / iPadDif, width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        makeImageNode(name: "4emptyButton", image: darkImg, x:CGFloat(positions[4][0]) , y: CGFloat(positions[4][1]) / iPadDif, width: darkWidth, height: darkHeight, z: 3, alpha: 0, isAnchoring: false)
        

        //製作中文選項
        
        //暫時測試用
        
        var leftSqr = String()
        var rightSqr = String()
        
        switch gameMode{
            
        case 0:
        leftSqr = "leftRoundedSqr"
        rightSqr = "rightRoundedSqr"
            
        case 1:
            leftSqr = "leftRoundedSqr2"
            rightSqr = "rightRoundedSqr2"
        case 2:
            leftSqr = "leftRoundedSqr"
            rightSqr = "rightRoundedSqr"
            
        default:
            break
            
            
        }
        
        
        makeImageNode(name: "leftChiBtn", image: leftSqr, x: -187 * chiBtnDif, y: -365, width: 320 * chiBtnDif, height: 320 * chiBtnDif, z: 7, alpha: 0, isAnchoring: false)
        makeImageNode(name: "rightChiBtn", image: rightSqr, x: 187 * chiBtnDif, y: -365, width: 320 * chiBtnDif, height: 320 * chiBtnDif, z: 7, alpha: 0, isAnchoring: false)
        
        //makeImageNode(name: "leftChiBtn", image: "popQuizBlock", x: -187 * chiBtnDif, y: -365, width: 320 * chiBtnDif, height: 320 * chiBtnDif, z: 7, alpha: 1, isAnchoring: false)
        //makeImageNode(name: "rightChiBtn", image: "popQuizBlock", x: 187 * chiBtnDif, y: -365, width: 320 * chiBtnDif, height: 320 * chiBtnDif, z: 7, alpha: 1, isAnchoring: false)
        
        //加入中文字選項的node
        leftChiNode.position = CGPoint(x: -187 * chiBtnDif, y: -375 / iPadDif)
        leftChiNode.horizontalAlignmentMode = .center
        leftChiNode.fontSize = 60
        leftChiNode.fontColor = .white
        leftChiNode.zPosition = 8
        leftChiNode.name = "leftChi"
        leftChiNode.fontName = "Helvetica Bold"
        //leftChiNode.text = "age"

        adjustLabelFontSizeToFitRect(labelNode: leftChiNode, rect: findImageNode(name: "leftChiBtn").frame)

        addChild(leftChiNode)
        
        rightChiNode.position = CGPoint(x: 187 * chiBtnDif, y: -375 / iPadDif)
        rightChiNode.horizontalAlignmentMode = .center
      
        rightChiNode.fontSize = 60
        rightChiNode.fontColor = .white
        rightChiNode.zPosition = 8
        rightChiNode.name = "rightChi"
        rightChiNode.fontName = "Helvetica Bold"
        //rightChiNode.text = "congratulations"
        adjustLabelFontSizeToFitRect(labelNode: rightChiNode, rect: findImageNode(name: "rightChiBtn").frame)
        
        addChild(rightChiNode)
        
        
        
        //建立三個單字
        
        //firstEngWordLabel.frame = CGRect(x: 187.5 + 375, y: 110, width: 200, height: 80)
        firstEngWordLabel.frame = CGRect(x: (width - 200 * dif) / 2 + width, y: 110 * dif / iPadDif, width: 260 * dif, height: 80 * dif)
        
        //firstEngWordLabel.backgroundColor = .cyan
        firstEngWordLabel.textColor = darkWordColor
        firstEngWordLabel.textAlignment = .center
        firstEngWordLabel.adjustsFontSizeToFitWidth = true
        firstEngWordLabel.font = UIFont(name: "Helvetica Bold", size: engFontSize)
        firstEngWordLabel.text = ""
        self.view?.addSubview(firstEngWordLabel)
        
        //英文單字的Node
        //firstChiWordLabel.frame = CGRect(x: 187.5 + 375, y: 205, width: 90, height: 40)
        firstChiWordLabel.frame = CGRect(x: (width - 90 * dif) / 2 + width, y: 205 * dif / iPadDif, width: 260 * dif, height: 40 * dif)
        //firstChiWordLabel.backgroundColor = .green
        firstChiWordLabel.textColor = pinkColor
        firstChiWordLabel.textAlignment = .center
        firstChiWordLabel.adjustsFontSizeToFitWidth = true
        firstChiWordLabel.font = UIFont(name: "Helvetica Bold", size: 30)
        firstChiWordLabel.text = ""
        self.view?.addSubview(firstChiWordLabel)
        
        //popQuizTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NewGameScene.popQuizCountDown), userInfo: nil, repeats: true)
        
        //建立好畫面後開始動畫
        
        
       
        makeImageNode(name: "abort", image: "abortPng", x: 300 * chiBtnDif, y: 500 / iPadDif, width: 131, height: 46, z: 3, alpha: 0, isAnchoring: false)
        
        introAnimation()
        
    }
    
    func adjustLabelFontSizeToFitRect(labelNode:SKLabelNode, rect:CGRect) {
        
        // Determine the font scaling factor that should let the label text fit in the given rectangle.
        let scalingFactor = min(rect.width / labelNode.frame.width, rect.height / labelNode.frame.height)
        
        // Change the fontSize.
        
        labelNode.fontSize *= scalingFactor * 0.95
        
        
        
        if labelNode.fontSize > 80 {
            
            labelNode.fontSize = 80
        }
 
        print(labelNode.fontSize)
        // Optionally move the SKLabelNode to the center of the rectangle.
        labelNode.position = CGPoint(x: rect.midX, y: rect.midY - labelNode.frame.height / 2.0)
    }
    
    //Part 1. intro: 開始學習單字的提示字樣滑入, 飛出
    
    
    @objc func popQuizCountDown(){
        
        
        var bigNum = Int(findLabelNode(name: "bigNumber").text!)!
        var smallNum = Int(findLabelNode(name: "smallNumber").text!)!
        
        if smallNum > 1 {
            
            smallNum -= 1
            
            //smallNumBlink()
            findLabelNode(name: "bigNumber").text = String(bigNum)
            findLabelNode(name: "smallNumber").text = String(smallNum)
            
        } else if bigNum > 0 {
            
            bigNum -= 1
            smallNum = 9
            //smallNumBlink()
            //bigNumBlink()
            findLabelNode(name: "bigNumber").text = String(bigNum)
            findLabelNode(name: "smallNumber").text = String(smallNum)
            
        } else {
            

            //倒數停止
            //不能按鈕
            //顯示時間到
            //顯示正確打圈
            //秒數變紅色
            //暫停一秒後繼續下一題
            

            popQuizTimer.invalidate()
            
            isUserInteractionEnabled = false
            
            findLabelNode(name: "quizTitle").text = "時間到！"
            findLabelNode(name: "quizTitle").fontColor = .red
            findLabelNode(name: "bigNumber").fontColor = .red
            findLabelNode(name: "smallNumber").fontColor = .red
            findLabelNode(name: "bigNumber").text = "0"
            findLabelNode(name: "smallNumber").text = "0"
            
            let wait = SKAction.wait(forDuration: 1)
            
            self.run(wait) {[weak self] in
                self!.chooseChineseResult(isCorrect: false)
                
                self!.findLabelNode(name: "quizTitle").text = "限時挑戰"
                self!.findLabelNode(name: "quizTitle").fontColor = .white
                self!.findLabelNode(name: "bigNumber").fontColor = .white
                self!.findLabelNode(name: "smallNumber").fontColor = .white
                self!.findLabelNode(name: "smallNumber").text = "3"


            }
            
        }
        

        
    }
    
    func introAnimation(){
        
        hintSlideIn(leftText: "學習", rightText: "單字",waitTime: 1.3) {[weak self] in
            
            self!.makeWords()
            
        }
        
    }
    
    // 2. makeWords: 讀取所有的字, 造字
    func makeWords(){
        
        //這個engWords是尚未attr的, attr完的是
        var allThreeEngWordsArray = [[String]]()
    
        var engWord0 = [String]()
        var chiWord0 = String()
        var engWord1 = [String]()
        var chiWord1 = String()
        var engWord2 = [String]()
        var chiWord2 = String()
        
        
        //popQuiz使用
        var allThreePopQuizEngWordsArray = [[String]]()
        
        var engWord3 = [String]()
        var chiWord3 = String()
        var engWord4 = [String]()
        var chiWord4 = String()
        var engWord5 = [String]()
        var chiWord5 = String()
        
        
        let quarterCount = wordSets.count / 3
        
        print(quarterCount)
        
        if gameMode == 1 {
            
            //random unit兩個都要放入去抓, 要找正確的地方放
            
            print("count:\(allWordSets.count)")
            engWord0 = allWordSets[randomSpots[0]][randomUnits[0]].components(separatedBy: " ")
            chiWord0 = allWordSets[randomSpots[0]][randomUnits[0 + quarterCount]]
            engWord1 = allWordSets[randomSpots[1]][randomUnits[1]].components(separatedBy: " ")
            chiWord1 = allWordSets[randomSpots[1]][randomUnits[1 + quarterCount]]
            engWord2 = allWordSets[randomSpots[2]][randomUnits[2]].components(separatedBy: " ")
            chiWord2 = allWordSets[randomSpots[2]][randomUnits[2 + quarterCount]]
            
            print(engWord0)
            print(chiWord0)
            print(engWord1)
            print(chiWord1)
            print(engWord2)
            print(chiWord2)
            
            
        } else if gameMode == 0 {
            
        engWord0 = wordSets[currentWordSequence].components(separatedBy: " ")
        chiWord0 = wordSets[quarterCount +  currentWordSequence]
        engWord1 = wordSets[currentWordSequence + 1].components(separatedBy: " ")
        chiWord1 = wordSets [quarterCount +  currentWordSequence + 1]
        engWord2 = wordSets[currentWordSequence + 2].components(separatedBy: " ")
        chiWord2 = wordSets [quarterCount +  currentWordSequence + 2]
            
            
            if (unitNumber + 1) % 2 == 0{

            
        //popQuiz使用
            
            engWord3 = wordSets[currentWordSequence - 3].components(separatedBy: " ")
            chiWord3 = wordSets[quarterCount +  currentWordSequence - 3]
            engWord4 = wordSets[currentWordSequence - 2].components(separatedBy: " ")
            chiWord4 = wordSets[quarterCount +  currentWordSequence - 2]
            engWord5 = wordSets[currentWordSequence - 1].components(separatedBy: " ")
            chiWord5 = wordSets[quarterCount +  currentWordSequence - 1]
            
     
                allThreePopQuizEngWordsArray.append(engWord3)
                allThreePopQuizEngWordsArray.append(engWord4)
                allThreePopQuizEngWordsArray.append(engWord5)
                
                
                for i in 0 ..< allThreePopQuizEngWordsArray.count{
                    var word = String()
                    
                    for syl in allThreePopQuizEngWordsArray[i]{
                        
                        word = word + syl
                    }
                    
                    popQuizThreeEngWords.append(word)
                    
                }
                
                
                
                //append中文字
                popQuizThreeChiWords.append(chiWord3)
                popQuizThreeChiWords.append(chiWord4)
                popQuizThreeChiWords.append(chiWord5)
                
                print(popQuizThreeEngWords)
                print(popQuizThreeChiWords)
            }
            
        }
        
        allThreeEngWordsArray.append(engWord0)
        allThreeEngWordsArray.append(engWord1)
        allThreeEngWordsArray.append(engWord2)
        
    
        for i in 0 ..< allThreeEngWordsArray.count{
            var word = String()
            
            for syl in allThreeEngWordsArray[i]{
                
                word = word + syl
            }
            
            allThreeEngWords.append(word)
      
        }
        
        
        
        //append中文字
        allThreeChiWords.append(chiWord0)
        allThreeChiWords.append(chiWord1)
        allThreeChiWords.append(chiWord2)
        
        //字型顏色
        let attrs0 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: engFontSize), NSAttributedStringKey.foregroundColor : UIColor.white]
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: engFontSize), NSAttributedStringKey.foregroundColor : UIColor.cyan]
        
        
        //先抓音節, 待寫gameMode==1的條件式
        
        var firstSyllablesToCheck = String()
        var secondSyllablesToCheck = String()
        var thirdSyllablesToCheck = String()
        
        //三個音節供去掉數字
        var threeSyllables = ["","",""]
        
        if gameMode == 0 {
        
            syllablesToCheck = syllables[unitNumber]
            threeSyllables = [syllablesToCheck,syllablesToCheck,syllablesToCheck]
       
      
        } else if gameMode == 1 {
            firstSyllablesToCheck = syllableSets[randomSpots[0]][randomUnits[0] / 3]
            secondSyllablesToCheck = syllableSets[randomSpots[1]][randomUnits[1] / 3]
            thirdSyllablesToCheck = syllableSets[randomSpots[2]][randomUnits[2] / 3]
          
            threeSyllables = [firstSyllablesToCheck,secondSyllablesToCheck,thirdSyllablesToCheck]
            
        }

        
        //去掉數字
        
        firstSyllablesWithoutDigit = (threeSyllables[0].components(separatedBy: NSCharacterSet.decimalDigits) as NSArray).componentsJoined(by: "")
        secondSyllablesWithoutDigit = (threeSyllables[1].components(separatedBy: NSCharacterSet.decimalDigits) as NSArray).componentsJoined(by: "")
        thirdSyllablesWithoutDigit = (threeSyllables[2].components(separatedBy: NSCharacterSet.decimalDigits) as NSArray).componentsJoined(by: "")

        
        //去掉數字後加入到group供辨認
        var syllablesGroup = [String]()
        
        syllablesGroup.append(firstSyllablesWithoutDigit)
        syllablesGroup.append(secondSyllablesWithoutDigit)
        syllablesGroup.append(thirdSyllablesWithoutDigit)
        
        
        var attrWords = [[NSMutableAttributedString](),[NSMutableAttributedString](),[NSMutableAttributedString]()]
        
        //以下為生成attr的步驟
        //1. 確認是否是specialE
        
        
        for sg in 0 ..< syllablesGroup.count {
        
        if syllablesGroup[sg].contains("_"){
            //specialE的作法
            
            var characters = [Character]()
            let vowels = ["a","e","i","o","u"]
            
            //每一個英文字節拆字母
          //  for w in 0 ..< allThreeEngWordsArray.count{
                
                for i in 0 ..< allThreeEngWordsArray[sg].count{
                    
                    characters.removeAll(keepingCapacity: false)
                    
                    for c in allThreeEngWordsArray[sg][i]{
                        
                        characters.append(c)
                    }
                    
                    if characters.count == 3{
                        if characters[2] == "e"{
                            
                            if vowels.contains(String(characters[0])){
                                
                                
                                //剛好是_e部首
                                let word = NSMutableAttributedString(string: String(characters[0]), attributes: attrs1)
                                attrWords[sg].append(word)
                                let word1 = NSMutableAttributedString(string: String(characters[1]), attributes: attrs0)
                                attrWords[sg].append(word1)
                                let word2 = NSMutableAttributedString(string: String(characters[2]), attributes: attrs1)
                                attrWords[sg].append(word2)
                                
                                
                            } else {
                                
                                for c in 0 ..< characters.count {
                                    
                                    let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs0)
                                    attrWords[sg].append(word)
                                }
                                
                            }
                            
                        } else {
                            
                            for c in 0 ..< characters.count {
                                
                                let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs0)
                                attrWords[sg].append(word)
                            }
                            
                        }
                        
                    } else {
                        
                        for c in 0 ..< characters.count {
                            
                            let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs0)
                            attrWords[sg].append(word)
                        }
                        
                        
                    }
                    
                    
                }
           // }
            
        } else {
            //非specialE的作法
            
            //抓三個字的array
         //   for w in 0 ..< allThreeEngWordsArray.count{
                
                //抓array的音節,  只抓一個字
                for i in 0 ..< allThreeEngWordsArray[sg].count{
                    
                    if let engWord = allThreeEngWordsArray[sg][i] as String?{
                        
                        if engWord == syllablesGroup[sg]{
                            //符合部首字
                            
                            let word = NSMutableAttributedString(string: engWord, attributes: attrs1)
                            attrWords[sg].append(word)
                            
                            
                        } else{
                            //一般字元
                            
                            let word = NSMutableAttributedString(string: engWord, attributes: attrs0)
                            
                            attrWords[sg].append(word)
                            
                        }
                    }
                    
                }
                
         //   }
            
        }
        
        }
        //*** 以下為共同的造字func, 把字造到words裡
        
        for w in 0 ..< attrWords.count {
            
            for i in 0 ..< attrWords[w].count { //[w]
                
                if i == 0 {
                    words[w] = attrWords[w][i] //[w]
                    
                } else {
                    words[w].append(attrWords[w][i]) //[w]
                }
            }
        }
        
        
        //造完字後顯示出英文部分
        
        if gameMode == 1 {
            
            //隱藏上方的單字換成對話框
            firstEngWordLabel.isHidden = true
            firstChiWordLabel.isHidden = true

        }
        
        firstEngWordLabel.attributedText = words[0]
        firstChiWordLabel.text = chiWord0
        
        //造完字單字滑入 - 一次性動畫
        slideInAnimation()
        
    }
    
    
    
    //Part 3. slideIn: 單字滑進來
    func slideInAnimation(){
        
        UIView.animate(withDuration: 0.3, animations: {[weak self] in
            
            self!.firstEngWordLabel.center.x = self!.width / 2
            
        })
        
        UIView.animate(withDuration: 0.3, animations: {[weak self] in
            self!.firstChiWordLabel.center.x = self!.width / 2
            }, completion: { [weak self](finished:Bool) in
                if finished{
                    
                    //設定發音單字
                    if self!.gameMode == 0 {
                        
                        self!.wordsToPronounce = self!.wordSets[self!.currentWordSequence].replacingOccurrences(of: " ", with: "")
                        
                    } else if self!.gameMode == 1 {
                        
                        self!.wordsToPronounce = self!.allWordSets[self!.randomSpots[0]][self!.randomUnits[0]].replacingOccurrences(of: " ", with: "")
                        
                    }
                    

                    
                    if self!.gameMode == 1 {
                   
                        //reviewMode不發音 , 留到後方practice發音, 原因好像不明顯...
                     
                        self!.reviewWordMode()
                    
                    } else {
                    
                        self!.practice()
                        
                        let wordToPass:[String:Any] = ["wordToPass":self!.wordsToPronounce,"pronounceTime":1]
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pronounceWord"), object: nil, userInfo: wordToPass)
                    }
                 
                    
                    
                }
                
        })
        
        
    }
    
    @objc func notifyShowTag(){
        
    }
    
    var hintTime = 0
    @objc func readyToReadSentence(){
        
        
        if hintTime == 0 {
            
            hintSlideIn(leftText: "換你", rightText: "發音", waitTime: 1.3) {[weak self] in
                
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "readSentence"), object: nil, userInfo: nil)
                
                self!.hintTime += 1
                
            }
        } else {
            

                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: "readSentence"), object: nil, userInfo: nil)
            
        }
     
 
        
    
 
    }
    
    @objc func notifyReadSentence(){
        
                findImageNode(name: "recogWordsBg").alpha = 1
    }
    
    @objc func startCountDown(){
        //開始倒數tagQuestion
        
        //顯示放棄鈕
        

        if let abortKey = childNode(withName: "abort") as? SKSpriteNode{
            
            abortKey.alpha = 1
        }
        
        
        let lineNode = findImageNode(name: "countDownLine")
        lineNode.alpha = 1
    
        var sec = TimeInterval()
        
        switch courseReceived{
          
        case 0:
            sec = 20
        case 1:
            sec = 30
        case 2:
            sec = 40
        default:
            break

        }
        
        
         let countDownAction = SKAction.resize(toWidth: 0, duration: sec)
        
        lineNode.run(countDownAction) {[weak self] in
            
            print("stop counting")
            
            self!.run(self!.wrongSound)
            
            
            //send Nc
            if self!.gameMode == 2 {
           
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopReview"), object: nil, userInfo: nil)
          
            } else if self!.gameMode == 0 {
                
                
                //timesUp
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "timesUp"), object: nil, userInfo: nil)
                
                self!.isFinalGetPoint = false
                
                
                //在此的功能為刪除倒數線
                self!.practiceNextWord()

            }
            

            
        }
        
        
    }
    
    @objc func notifyTimesUp(){
        
        
    }
    
    @objc func backToSpell(_ notification:NSNotification){
        
        
        
        
        //抓分數
        if let addScore = notification.userInfo?["addScore"] as? Int{
            if addScore != 0 {
                if gameMode == 0 {
                countScore(score: addScore)
                    
                  
                }
            }
            
        }
        
        isUserInteractionEnabled = false
        
        //隱藏上方的單字換成對話框
        firstEngWordLabel.isHidden = true
        firstChiWordLabel.isHidden = true
        
        //錄音字欄位
        findImageNode(name: "recogWordsBg").alpha = 0
        
        //建立說話圖示
        makeImageNode(name: "talkPng", image: "talkPng", x: 0, y: 380 / iPadDif, width: 256, height: 196, z: 1, alpha: 1, isAnchoring: false)
        
        
        //宣告此為第二次練習
        isBackToSpell = true
        
        //練習
        practice()
        
    }
    
    func reviewWordMode(){
        isUserInteractionEnabled = false
        
        
        //錄音字欄位
        findImageNode(name: "recogWordsBg").alpha = 0
        
        //建立說話圖示
        makeImageNode(name: "talkPng", image: "talkPng", x: 0, y: 380, width: 256, height: 196, z: 1, alpha: 1, isAnchoring: false)
        
        
        //宣告此為第二次練習
        isBackToSpell = true
        
        //練習
        practice()
        
    }
    

    
    @objc func addScore(_ notification:NSNotification){
        
        
        print("enter addScore")
        
        if let addScore = notification.userInfo?["addScore"] as? Int{
            if addScore != 0 {
                if gameMode == 0 {
            countScore(score: addScore)
                }
        }
        }
        //有finalPoints就是要啟動倒數Timer
        if (notification.userInfo?["finalPoints"] as? Int) != nil{
            
         
            
                //tag倒數
                startCountDown()
            

        }
    
        
    }
    
    
    @objc func notifyPronounceWord(){
        
    }
    

    
    
    deinit {
        NotificationCenter.default.removeObserver(self)

        print("gamescene deinit")
    }
    
    
    //練習模式
    var iPadDif = CGFloat()
    func practice(){
        
        
        if isBackToSpell{
        
        hintSec = 0
        findLabelNode(name: "showHint").text = "請連線拼字"
        }
        
        
        
        switch  height {
        case 812:

            iPadDif = 1
        case 736:

            iPadDif = 1
        case 667:
     
            iPadDif = 1
        case 568:
     
            iPadDif = 1
        default:
    
            iPadDif = 1.2
        }
        
        hintSlideIn(leftText: "連線", rightText: "拼字",waitTime: 1) {[weak self] in
            
            //是否要發音, 判斷是不是第一個字
            var shouldPronounce = Bool()
            
            //暫時都不改變等待時間 var - let
            let waitTime = DispatchTime.now()
            
            //等待發音練完後再進入練習
            /*
            if self!.currentPracticeSequence != 0 {
                waitTime = DispatchTime.now() + 0.6
            }
*/
            //首先指定好上方中英文的label
            
            DispatchQueue.main.asyncAfter(deadline: waitTime) {[weak self] in
                
                switch self!.currentPracticeSequence{
                    
                case 0:
                    
                    //設定發不發音, gameMode1也被引導到這邊來
                    if self!.isBackToSpell{
                        
                        shouldPronounce = true
                   
                        
                        
                    } else {
                        shouldPronounce = false
                        //self!.isUserInteractionEnabled = true
                        //發音完後變色
                        self!.firstEngWordLabel.textColor = self!.darkWordColor

                    }
                    
                    //第二個字及第三個字
                    
                case 1...:

                    self?.firstEngWordLabel.attributedText = self!.words[self!.currentPracticeSequence]
                    self!.firstChiWordLabel.text = self!.allThreeChiWords[self!.currentPracticeSequence]
                    
                    if self!.gameMode == 0 {
                        
                        let moveBack = SKAction.moveTo(y: -290, duration: 0)
                        
                        self!.findLabelNode(name: "showHint").run(moveBack)

                        
                        self!.hintSec = 0
                        self!.findLabelNode(name: "showHint").text = "請連線拼字"
                    
                    self!.wordsToPronounce =  self!.wordSets[self!.currentWordSequence].replacingOccurrences(of: " ", with: "")
                    
                    } else if self!.gameMode == 1 {
                        
                         self!.wordsToPronounce =  self!.allWordSets[self!.randomSpots[self!.currentPracticeSequence]][self!.randomUnits[self!.currentPracticeSequence]].replacingOccurrences(of: " ", with: "")
                        
                    }
                        shouldPronounce = true

                default:
                    break
                }
                
                
                if shouldPronounce{
                    
       
                    
                    //發音, 用再seq > 0, backToSpell, practiceNextWord
                    
                    //目前都只念一次, 暫時保留
                    var speakTime = Int()
                    if self!.isBackToSpell{
                        speakTime = 1
                        
                    } else {
                        //2改成1
                        speakTime = 1
                    }
                    
                    
                    
                    let wordToPass:[String:Any] = ["wordToPass":self!.wordsToPronounce,"pronounceTime":speakTime]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pronounceWord"), object: nil, userInfo: wordToPass)
                    
                    //發音後等一下再變黑
                    let when = DispatchTime.now() + 0.3
                    
                    DispatchQueue.main.asyncAfter(deadline: when, execute: {
                        self!.firstEngWordLabel.textColor = self!.darkWordColor
                        
                        if !self!.countScoreTimer.isValid {
                                self!.isUserInteractionEnabled = true
                            
                            
                         
                            
                        }
                    
                    })

                    
                }

            }
        }
        
        
        
        //抓目前單字
        
        var currentWord = String()
        if gameMode == 0 {
        
            currentWord = wordSets[currentWordSequence]
        
        } else if gameMode == 1{
            
            currentWord = allWordSets[randomSpots[currentPracticeSequence]][randomUnits[currentPracticeSequence]]
            
        }
        //分目前單字音節
        currentWordArray = currentWord.components(separatedBy: " ")
        
        //計算音節數
        let currentWordSyllableCounts = currentWordArray.count
        
        //抓部首以外的英文字
        var otherWords = [String]()
        
        if gameMode == 0 {
        
        //在所有英文字裡面, 如果音節沒有重複目前顯示的音節, 就把它加入到otherWords裡
        for i in 0 ..< wordSets.count / 3{
            
            let word = wordSets[i]
            let sepWordArray = word.components(separatedBy: " ")
            
            for s in sepWordArray{
                
                if !currentWordArray.contains(s) {
                    otherWords.append(s)
                    
                }
            }
        }
        } else if gameMode == 1 {
            
            for (s,_) in gamePassedDic!{
                
                let randomSpot = Int(arc4random_uniform(UInt32(s)))
                
                //在所有亂數spot英文字裡面, 如果音節沒有重複目前顯示的音節, 就把它加入到otherWords裡來做選項
                for i in 0 ..< allWordSets[randomSpot].count / 3{
                    
                    let word = allWordSets[randomSpot][i]
                    let sepWordArray = word.components(separatedBy: " ")
                    
                    for sw in sepWordArray{
                        
                        if !currentWordArray.contains(sw) {
                            otherWords.append(sw)
                            
                        }
                    }
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
        let positions = [[-135,-519],[-230,-299],[135,-519],[230,-299],[0,-109]]
        
        var waitMoreTime = DispatchTime.now()
        if isBackToSpell {
            waitMoreTime = DispatchTime.now() + 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: waitMoreTime) {[weak self] in
            
            //顯示空格子
            let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.3)
            
            for node in self!.children{
                
                //顯示選項罐子
                if (node.name?.contains("emptyButton"))!{
                    
                    node.run(fadeIn)
                }
            }

          
            for i in 0 ..< self!.shownWords.count{
                
               self!.makeLabelNode(x: CGFloat(positions[i][0]), y: CGFloat(positions[i][1])  / self!.iPadDif, alignMent: .center, fontColor: .white, fontSize: 50, text: self!.shownWords[i], zPosition: 5, name: self!.shownWords[i] + String(i) + "Sel", fontName: "Helvetica", isHidden: false, alpha: 1)
                
                
                //把建立的選項名稱放入array裡
                self!.selNodeNames.append(self!.shownWords[i] + String(i) + "Sel")
                
            }
            
            //可按按鍵
            //isUserInteractionEnabled = true
            
            //啟動連線功能
            self!.isDragAndPlayEnable = true
        }

        
    }

    
    func countScore(score:Int){
        
        isUserInteractionEnabled = false
        //isDragAndPlayEnable = false
        
        let scoreToPass:[String:Int] = ["Score":score]
        //print("score:\(score)")
        countScoreTimer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(NewGameScene.startCounting), userInfo: scoreToPass, repeats: true)
        
        
    }
    

    @objc func startCounting(){

       // print("1")
        if let userInfo = countScoreTimer.userInfo as? Dictionary<String, Int>{
            //print("2")
            if let scoreToAdd = userInfo["Score"]{
             //   print("3")
                
                let scoreLabel = findLabelNode(name: "scoreLabel")
              
                //let size = CGSize(width: 100, height: 100)
        
                //print("scoreAdded:\(scoreAdded) and score:\(scoreToAdd)")
                if scoreAdded < scoreToAdd {
               // print("4")
                
                scoreAdded += 10
                    scoreLabel.text = String(Int(scoreLabel.text!)! + 10)
                } else {
                 //   print("5")
                    scoreAdded = 0
                    countScoreTimer.invalidate()
        
                    isUserInteractionEnabled = true
                   // isDragAndPlayEnable = true
                    
                }
                
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        hintSec = 0

        
        for touch in touches{
            
            location = touch.location(in: self)
            
            let node : SKNode = self.atPoint(location)
            
            var chiBtnDif = CGFloat()
            //var dif = CGFloat()
            
            switch  height {
            case 812:
                chiBtnDif = 0.8
              //  dif = 1.15
            case 736:
                chiBtnDif = 1
              //  dif = 1.1
                
            case 667:
                chiBtnDif = 0.95
              //  dif = 1
                
            case 568:
                chiBtnDif = 0.9
              //  dif = 0.9
                
            default:
                
                chiBtnDif = 0.9
              //  dif = 0.9
                
            }
            
            
            //如果在popQuiz有按鈕就要暫停timer
            if !isPopQuiz && node.name == "pause" {
                
                //暫停counting
                
                let lineNode = findImageNode(name: "countDownLine")
                lineNode.isPaused = true
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pause"), object: nil, userInfo: nil)
                
            }
            
            //放棄func
            
            if node.name == "abort"{
                
                
                //放棄
                
                //timesUp
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "timesUp"), object: nil, userInfo: nil)
                
                isFinalGetPoint = false
                
                
                //在此的功能為刪除倒數線
                practiceNextWord()

                //findImageNode(name: "abort").alpha = 0
                
                
                
            }
            
            

            //之後要寫中文錯誤的機制
            //確認中文正確與否
            if node.name == "leftChiBtn" || node.name == "leftChi" || node.name == "popUpBlock" || node.name == "popUpLabel"{
                
                
                //重置hintSec
                
                
                //停止timer
                //數字歸位
                popQuizTimer.invalidate()
                findLabelNode(name: "bigNumber").text = "0"
                findLabelNode(name: "smallNumber").text = "3"
                
                if leftOrRight == 0 {
                    //答對
                          self.run(rightSound)
                    
                    changeImageAlfa(name: "leftChiBtn", toAlpha: 0, time: 0.1)
                    changeImageAlfa(name: "popUpBlock", toAlpha: 0, time: 0.1)
                    
                    
                    if isPopQuiz{
                        
                        
                  
                        
                        makeImageNode(name: "mark", image: "rightCircle", x: 0, y: -1334 / 2 + 228 * 1.5, width: 220 * chiBtnDif, height: 220 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                        
                        makeImageNode(name: "mark", image: "wrongX", x: 0, y: -1334 / 2 + 114, width: 220 * chiBtnDif, height: 230 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                        
                    } else {
                    
                    makeImageNode(name: "mark", image: "rightCircle", x: -190 * chiBtnDif, y: -355, width: 275 * chiBtnDif, height: 275 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                    makeImageNode(name: "mark", image: "wrongX", x: 190 * chiBtnDif, y: -355, width: 202 * chiBtnDif, height: 214 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                    }
                    
                    let when = DispatchTime.now() + 0.3
                    DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                        self!.chooseChineseResult(isCorrect: true)
                    })
                    
                    
                }else{
                    //答錯
                    
                    self.run(wrongSound)
                    changeImageAlfa(name: "leftChiBtn", toAlpha: 0, time: 0.1)
                    changeImageAlfa(name: "popDownBlock", toAlpha: 0, time: 0.1)
                    
                    
                    if isPopQuiz{
                        
                        makeImageNode(name: "mark", image: "wrongX", x: 0, y: -1334 / 2 + 228 * 1.5, width: 220 * chiBtnDif, height: 220 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                        
                        makeImageNode(name: "mark", image: "rightCircle", x: 0, y: -1334 / 2 + 114, width: 220 * chiBtnDif, height: 230 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                        
                    } else {
                    makeImageNode(name: "mark", image: "rightCircle", x: 190 * chiBtnDif, y: -355, width: 275 * chiBtnDif, height: 275 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                    
                    makeImageNode(name: "mark", image: "wrongX", x: -190 * chiBtnDif, y: -355, width: 202 * chiBtnDif, height: 214 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                }
                    /*
                     findLabelNode(name: "tempWord").text = "答錯"
                     findLabelNode(name: "tempWord").fontColor = lightPink
                     findLabelNode(name: "tempWord").fontSize = 60
                     */
                    
                    let time = DispatchTime.now() + 1
                    
                    DispatchQueue.main.asyncAfter(deadline: time, execute: {[weak self] in
                        
                        self!.chooseChineseResult(isCorrect: false)
                        
                    })
                    
                }
            }
            
            if node.name == "rightChiBtn" || node.name == "rightChi" || node.name == "popDownBlock" || node.name == "popDownLabel"{
                
                
                //停止timer
                //數字歸位
                popQuizTimer.invalidate()
                findLabelNode(name: "bigNumber").text = "0"
                findLabelNode(name: "smallNumber").text = "3"
                if leftOrRight == 1 {
                    //答對
                    self.run(rightSound)

                    //removeSomeNodes(name: "ChiBtn")
                    changeImageAlfa(name: "popDownBlock", toAlpha: 0, time: 0.1)
                    changeImageAlfa(name: "rightChiBtn", toAlpha: 0, time: 0.1)
                    
                    if isPopQuiz{
                        
                        makeImageNode(name: "mark", image: "wrongX", x: 0, y: -1334 / 2 + 228 * 1.5, width: 228 * chiBtnDif, height: 228 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                        
                        makeImageNode(name: "mark", image: "rightCircle", x: 0, y: -1334 / 2 + 114, width: 228 * chiBtnDif, height: 238 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                        
                        
                    } else {
                    makeImageNode(name: "mark", image: "wrongX", x: -190 * chiBtnDif, y: -355, width: 202 * chiBtnDif, height: 214 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                    makeImageNode(name: "mark", image: "rightCircle", x: 190 * chiBtnDif, y: -355, width: 275 * chiBtnDif, height: 275 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                    }
                    
                    let when = DispatchTime.now() + 0.3
                    DispatchQueue.main.asyncAfter(deadline: when, execute: {[weak self] in
                        self!.chooseChineseResult(isCorrect: true)
                    })
                    
                }else{
                    //答錯
                    
                    self.run(wrongSound)

                    //答錯
                    changeImageAlfa(name: "popDownBlock", toAlpha: 0, time: 0.1)
                    changeImageAlfa(name: "rightChiBtn", toAlpha: 0, time: 0.1)
                    
                    if isPopQuiz{
                        
                        
                        makeImageNode(name: "mark", image: "rightCircle", x: 0, y: -1334 / 2 + 228 * 1.5, width: 228 * chiBtnDif, height: 228 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                        
                        makeImageNode(name: "mark", image: "wrongX", x: 0, y:-1334 / 2 + 114, width: 228 * chiBtnDif, height: 238 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                        
                    } else {
                    makeImageNode(name: "mark", image: "rightCircle", x: -190 * chiBtnDif, y: -355, width: 275 * chiBtnDif, height: 275 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)

                    makeImageNode(name: "mark", image: "wrongX", x: 190 * chiBtnDif, y: -355, width: 202 * chiBtnDif, height: 214 * chiBtnDif, z: 9, alpha: 1, isAnchoring: false)
                    }
                        /*
                     findLabelNode(name: "tempWord").text = "答錯"
                     findLabelNode(name: "tempWord").fontColor = lightPink
                     findLabelNode(name: "tempWord").fontSize = 60
                     */
                    let time = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: time, execute: {[weak self] in
                        self!.chooseChineseResult(isCorrect: false)
                    })
                    
                    
                }
                
            }
            
            //**** 開始拖拉遊戲 dragAndPlay ***
            if isDragAndPlayEnable {
                
                print("began dragAndPlay")
                
                //在建立一條新的線
                line = SKShapeNode()
                
                if gameMode == 0 {
                line?.strokeColor = lightPink
                } else if gameMode == 1 {
                    
                    line?.strokeColor = orangeColor
                }
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
                            
                            //選項功能
                            selectBall(word: wordChosen, poisonNumber: i)
                            
                           
                        }
                    }
                }
            }
            
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        
        //確認有按到任何選項單字才會開始偵測move動作
        if touchTimes > 0{
            
            for touch in touches{
                
                
                
                //重置hintSec
                hintSec = 0
                
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
                            
                           
                            
                            //移除選項
                            //取得數字順序
                            let idx = nodesTouchedCount - 1
                            let node = nodesTouched[idx]
                            let nameToRemove = node.name
                            let seq = Int((nameToRemove?.replacingOccurrences(of: "newse", with: ""))!)
                            let word = shownWords[seq!]
                            removeBall(word: word, poisonNumber: seq!)
                            
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
                    print("touch new")

                    
                    
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
                        selectBall(word: wordChosen, poisonNumber: index!)
                        
                        
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
        
        //重置
        hintSec = 0
        
        if touchTimes > 0{
            
   
            if isDragAndPlayEnable{
                print("dragAndPlay")
                
                
                
                // Part 通用模式
                
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
                
           
                
                //初始化
                //isFirstTouch = false
                touchTimes = 0
                isTouched = false
                nodesTouched.removeAll(keepingCapacity: false)
                
              
                
                //假如答案正確
                if wordEntered == currentWordArray{
                    
                    hintSec = 0
                    findLabelNode(name: "showHint").text = ""
                    
     
                    
                    print("right answer")

                        //練習模式
                        //1. 把顯示的輸入字得分, 往上飄的動畫
                        rightScore()
                    
           
                        //以下兩兩個是聽考模式的協助功能
                        //移除talk圖示
                        removeSomeNodes(name: "talkPng")
                    
                        //顯示英文字
                        firstEngWordLabel.isHidden = false
                    
                        //2. 顯示原本有音節變色的字
                        firstEngWordLabel.attributedText = words[currentPracticeSequence]
                    
                        //不能按畫面
                        self.isUserInteractionEnabled = false
                    
                         //直接轉換isBackToSpell
                    
                        //如果是聽考模式就跳到選中文, gameMode1也是跳到這裡
                        if isBackToSpell {
                            
                            //計分
                            var score = Int()
                            
                            if answerTime == 0 {
                                
                                score = 300
                                
                            } else if answerTime == 1 {
                                
                                score = 150
                                
                                answerTime = 0
                            }
                            if gameMode == 0 {
                            countScore(score: score)
                            } else {
                                isUserInteractionEnabled = true
                            }
                            //跳到中文練習
                            isDragAndPlayEnable = false
                            
                            //要卡這個
                            testChinese()
                            
                        } else {
                            
                            if gameMode == 0{
                                
                                print("play right Sound")
                                
                                self.run(rightSound)
                            }
                            
                         
                            //第一次練習, 非聽考模式
                            
                            /*
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pronounceWord"), object: nil, userInfo: nil)
                            */
                            //發音
                            
                            /*
                            let contents:[String:Int] = ["pronounceTime":1]
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pronounceWord"), object: nil, userInfo: contents)
*/
                            
                            //初始化
                            shownWords.removeAll(keepingCapacity: false)
                            wordEntered.removeAll(keepingCapacity: false)
                            
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
                            
                            
                            if gameMode == 0 {
                            countScore(score: 100)
                            }
                            
                            //在此卡一個正確動畫
                            
                            hintSlideIn(leftText: "很棒", rightText: "喔！", waitTime: 1, finished: {[weak self] in
                                
                                
                                self!.hintSlideIn(leftText: "換你", rightText: "發音", waitTime: 1.5, finished: {
                                    
                                    //口試
                                    //self!.recognizeWord()
                                    //開始辨認單字NC
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startToRecognize"), object: nil, userInfo: nil)
                                    
                                    //self!.hintSec = 0
                                    //self!.findLabelNode(name: "showHint").text = "請按一下麥克風"
                                    
                                    //不能dragAndPlay
                                    self!.isDragAndPlayEnable = false
                                    
                                })
                                
                            })
                            
                           
                        }
                    
               
                } else {
                    
                    //答案錯誤的機制
                    
                    print("wrong answer")
                    
           
                        self.run(wrongSound)
                    

                    //再次練習打錯的話就跳走, 之後要做答錯提示畫面
                    if isBackToSpell{
                        
                        //如果是gameMode == 1, 錯一次就遊戲停止
                     
                        
                        
                        if answerTime < 1 {
                            
                            answerTime += 1
                            //再次練習
                            
                            //不能按畫面
                            self.isUserInteractionEnabled = false
                            
                            //把輸入過的答案移除
                            wordEntered.removeAll(keepingCapacity: false)
                            
                            
                            findLabelNode(name: "tempWord").run(wrongAnswerAction(), completion: {[weak self] in
                                
                                //能按畫面
                                self!.isUserInteractionEnabled = true
                                
                                
                                if self!.gameMode == 1 {
                                    
                                    
                                    let wordCount:[String:Int] = ["wordCount":self!.wordReviewCount]
                                    
                                    print(wordCount)
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopReview"), object: nil, userInfo: wordCount)

                                    
                                    
                                } else {
                                
                                
                                
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
                                
                            }
                            })

                            
                            
                        } else {
                            
                            
                            
                            findLabelNode(name: "showHint").text = ""
                            
                            answerTime = 0
                            //失去機會
                            
                            //準備進入中文選項, 不能拖拉 這個應該就是bug
                            isDragAndPlayEnable = false
                            
                            //紀錄錯誤單字
                            correctResults[currentPracticeSequence] = "1"
                            var wrongWord = String()
                            
                            if gameMode == 0 {
                                wrongWord = wordSets[currentWordSequence].replacingOccurrences(of: " ", with: "")
                            } else if gameMode == 1 {
                                
                                wrongWord = allWordSets[randomSpots[currentPracticeSequence]][randomUnits[currentPracticeSequence]].replacingOccurrences(of: " ", with: "")
                            }
                            wrongWords.append(wrongWord)
                            
                            
                            //以下兩兩個是聽考模式的協助功能
                            //移除talk圖示
                            removeSomeNodes(name: "talkPng")
                            
                            //顯示英文字
                            firstEngWordLabel.isHidden = false
                            
                            //2. 顯示原本有音節變色的字
                            firstEngWordLabel.attributedText = words[currentPracticeSequence]
                            
                            //把輸入字刪除
                            findLabelNode(name: "tempWord").text = ""
                            
                               testChinese()
                            
                            
                        }
                        
                        
                        

                    }else {
                    
                    
                      print("wrong Answer action")
                        
                        //不能按畫面
                        self.isUserInteractionEnabled = false
                    
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
                            
                            
                        })

                }
                    
                }
                
            }
        }
        
    }
    
    
    //辨識單字
    func recognizeWord(){
        
        //隱藏不需要的東西

    }
    
    
    
    func testChinese(){
        
        
        hintSec = 0
        let moveUp = SKAction.moveTo(y: -150, duration: 0)
        
        findLabelNode(name: "showHint").run(moveUp)
        findLabelNode(name: "showHint").text = "請選擇正確中文"
        
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
        
        var allChiWords = [String]()
        var chiWord = String()
        
        if gameMode == 0 {
        
        //抓亂數中文
        let quarterCount = wordSets.count / 3
        let halfCount = wordSets.count / 3 * 2
        chiWord = wordSets[quarterCount +  currentWordSequence]
  
        for i in quarterCount ..< halfCount{
            allChiWords.append(wordSets[i])
        }
        
        allChiWords.remove(at: currentWordSequence)
       
        } else if gameMode == 1 {
            
            //抓亂數中文
            let quarterCount = allWordSets[randomSpots[currentPracticeSequence]].count / 3
            let halfCount = allWordSets[randomSpots[currentPracticeSequence]].count / 3 * 2

            
            chiWord = allWordSets[randomSpots[currentPracticeSequence]][randomUnits[currentPracticeSequence] + quarterCount]
            
            
            for i in quarterCount ..< halfCount{
                allChiWords.append(allWordSets[randomSpots[currentPracticeSequence]][i])
            }
          
            //移除掉正確答案
            allChiWords.remove(at: randomUnits[currentPracticeSequence])

        }
        
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
        
           adjustLabelFontSizeToFitRect(labelNode: leftChiNode, rect: findImageNode(name: "leftChiBtn").frame)
        
           adjustLabelFontSizeToFitRect(labelNode: rightChiNode, rect: findImageNode(name: "rightChiBtn").frame)
        //只修正一次Y的位置
        /*
        if isChangeYPos == false {
        leftChiNode.position.y = leftChiNode.frame.origin.y - leftChiNode.frame.height / 6
        rightChiNode.position.y = rightChiNode.frame.origin.y - rightChiNode.frame.height / 6
        isChangeYPos = true
        }
*/
        
        let leftChiBtn = findImageNode(name: "leftChiBtn")
        let rightChiBtn = findImageNode(name:"rightChiBtn")
        
        //let leftChiBtn = findLabelNode(name: "popUpBlock")
        //let rightChiBtn = findLabelNode(name: "popDownBlock")
        
        let showAlpha = SKAction.fadeAlpha(to: 1, duration: 0.1)
        leftChiBtn.run(showAlpha)
        
        rightChiBtn.run(showAlpha)
        /*
        rightChiBtn.run(showAlpha, completion: {[weak self] in
            
            //self!.isUserInteractionEnabled = true
            
        })
        */
    }
    
    //show句子
    @objc func notifyShowSentence(){
        
        //字隱藏
        
        firstEngWordLabel.text = ""
        firstChiWordLabel.text = ""
        firstEngWordLabel.isHidden = true
        firstChiWordLabel.isHidden = true
        findImageNode(name: "leftChiBtn").alpha = 0
        findImageNode(name: "rightChiBtn").alpha = 0
        leftChiNode.text = ""
        rightChiNode.text = ""
        removeSomeNodes(name: "mark")
        
    }
    
    
    @objc func receiveCorrectPracticeNextWord(){

        self.run(rightSound)
        //countScore
        if gameMode == 0 {
        countScore(score: 500)
        }
        practiceNextWord()
        isFinalGetPoint = true
        
    }
    
    //練習下個字或是結束本回合 / 進入popQuiz
    func practiceNextWord(){
        
        let lineNode = findImageNode(name: "countDownLine")
        //把倒數線回復並隱藏
        lineNode.removeAllActions()
        lineNode.size = CGSize(width: 750, height: 5)
        lineNode.alpha = 0
        hintTime = 0
        
        
        if let abortKey = childNode(withName: "abort") as? SKSpriteNode{
            
            abortKey.alpha = 0
        }
        
        
        
        if gameMode == 0 {
        
        if currentWordSequence < (unitNumber + 1) * 3 - 1{
            
            /*
            //把倒數線回復並隱藏
            lineNode.removeAllActions()
            lineNode.size = CGSize(width: 750, height: 5)
            lineNode.alpha = 0
            */
            
            //順序加一
            currentWordSequence += 1
            currentPracticeSequence += 1
            
            shownWords.removeAll(keepingCapacity: false)
            wordEntered.removeAll(keepingCapacity: false)
            
            
            //準備下一個字的練習
            isBackToSpell = false
            
            findImageNode(name: "recogWordsBg").alpha = 0
            
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
            
                firstEngWordLabel.isHidden = false
                firstChiWordLabel.isHidden = false
                practice()
            
            //沒練習完就繼續練習
            isFinalGetPoint = false
            
        } else {
            //三個字以練習完
            
            //不能暫停
            findImageNode(name: "pause").isHidden = true
            
            //在此確認是否為雙數結束
            
            if (unitNumber + 1) % 2 == 0{
                
                print("雙數結尾")
                

                //進入pop quiz
                
                isPopQuiz = true
                
                // 載入新背景
                // 刪除舊畫面
                findImageNode(name: "recogWordsBg").alpha = 0
                changeTexture(nodeName: "gameBg", newTexture: "popQuizBg2")
                
                findImageNode(name: "star0").alpha = 1
                findImageNode(name: "star1").alpha = 1
                findImageNode(name: "star2").alpha = 1
                
                
                hintSlideIn(leftText: "限時", rightText: "挑戰", waitTime: 1.2) {[weak self] in
                    
                    //把這些畫面包起來,少寫很多self!.
                    self!.setupPopQuizScreen()
                    self!.popQuiz()
                }
                
                /*
                print(randomNums)
                print(engRandomNums)
                print(allPopQuizChiWords)
                print(allPopQuizEngWords)
                */
                
                
            } else {
                
                print("單數結尾")
                
                
                //抓三個單字的狀態 + 分數
                //lineNode.removeAllActions()
               
                let scoreLabel = findLabelNode(name: "scoreLabel")
                
                var scoreToPass = scoreLabel.text!
                if isFinalGetPoint{
                  
                    scoreToPass = String(Int(scoreLabel.text!)! + 500)
                    
                }
                //應該不用在加500
               
                
                if user != nil {
                //這是連接後端的func
                addWrongWords()
                }
                
                let threeWords:[String:[String]] = ["engWords":allThreeEngWords,"chiWords":allThreeChiWords,"wrongWords":wrongWords,"score":[scoreToPass],"correctResults":correctResults,"popQuizRight":[String(popQuizRight)],"wrongChinese":wrongChinese]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "leaveGame"), object: nil, userInfo: threeWords)

                
            }
            
        }

            
        } else if gameMode == 1 {
            
            
            let moveBack = SKAction.moveTo(y: -290, duration: 0)
            
            findLabelNode(name: "showHint").run(moveBack)
            
            //以下為單純複習單字的機制
            //確認allunitspotnums有無用完
            if allUnitSpotNums.count == 0 {
                
            
                //練完的機制要先確認這次loadAllKindsOfWord的三個字是否已經用完
                if currentPracticeSequence == 2 {
                    
                    //之後要接續練完的畫面
                        print("練完了")
                    
                    
                    
                    let wordCount:[String:Int] = ["wordCount":wordReviewCount]
                    
                    print(wordCount)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopReview"), object: nil, userInfo: wordCount)
                    
                    
                    
                } else {
                    
                    print("檢查點繼續練")
                    
                    /*
                    //把倒數線回復並隱藏
                    lineNode.removeAllActions()
                    lineNode.size = CGSize(width: 750, height: 5)
                    lineNode.alpha = 0
                    */
                    //順序加一
                    
                    
                   // currentPracticeSequence += 1
                    
                    
                    if currentPracticeSequence == 2 {
                        
                        currentPracticeSequence = 0
                    } else {
                        
                        currentPracticeSequence += 1
                        
                    }
 
                    shownWords.removeAll(keepingCapacity: false)
                    wordEntered.removeAll(keepingCapacity: false)
                    
                    
                    //準備下一個字的練習, 這裡是否需要不一定
                    isBackToSpell = false
                    
                    findImageNode(name: "recogWordsBg").alpha = 0
                    
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
                    
                    if currentPracticeSequence == 0 {
                        //重新做三個字
                        loadAllKindsOfWord()
                        makeWords()
                        
                    } else {
                        
                        //直接複習下個字
                        reviewWordMode()
                  
                    }
                    
                }
                

            } else {
                print("繼續練")
                
                /*
                //把倒數線回復並隱藏
                lineNode.removeAllActions()
                lineNode.size = CGSize(width: 750, height: 5)
                lineNode.alpha = 0
                */
                
                
                //順序加一
                
                if currentPracticeSequence == 2 {
          
                currentPracticeSequence = 0
                } else {

                    currentPracticeSequence += 1
                    
                }
                shownWords.removeAll(keepingCapacity: false)
                wordEntered.removeAll(keepingCapacity: false)
                
                
                
                //準備下一個字的練習
                isBackToSpell = false
                
                findImageNode(name: "recogWordsBg").alpha = 0
                
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
                
                
                if currentPracticeSequence == 0 {
                    //重新做三個字
                    
                    //workAround -1 因為等等會+1
                    mapPassedInt -= increaseNum
                    
                    loadAllKindsOfWord()
                    makeWords()
                    
                } else {
                    
                    //直接複習下個字
                    reviewWordMode()
                }
            }
   
            
        } else if gameMode == 2 {
            //只練習句子
            
                print("practice next sentence")
                
            //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopReview"), object: nil, userInfo: nil)
            
            
            /*
                let wordSequence:[String:Int] = ["wordSequence":currentWordSequence]
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "onlyPracticeSentence"), object: nil, userInfo: wordSequence)
              */
 
            
        }
        
    }
    
    
    
    @objc func notifyStopLimitTimer(){
        
        
    }
    
    func setupPopQuizScreen(){
        
       
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopLimitTimer"), object: nil, userInfo: nil)
        
        //隱藏放棄鈕
        
        findLabelNode(name: "quizTitle").alpha = 1
        findImageNode(name: "timerBg").alpha = 1
        findLabelNode(name: "bigNumber").alpha = 1
        findLabelNode(name: "smallNumber").alpha = 1
        findLabelNode(name: "bigChineseLabel").alpha = 1
        //findImageNode(name: "leftChiBtn").alpha = 1
        //findImageNode(name: "rightChiBtn").alpha = 1
        //changeTexture(nodeName: "leftChiBtn", newTexture: "popQuizBlock")
        //changeTexture(nodeName: "rightChiBtn", newTexture: "popQuizBlock")
        
        adjustLabelFontSizeToFitRect(labelNode: findLabelNode(name: "bigChineseLabel"), rect: findLabelNode(name: "bigChineseLabel").frame)
        
        findImageNode(name: "popUpBlock").alpha = 1
        findImageNode(name: "popDownBlock").alpha = 1
        
        // 載入前二組單字
        
        
        for i in 0 ..< 3{
            
            allPopQuizEngWords.append(allThreeEngWords[i])
            allPopQuizEngWords.append(popQuizThreeEngWords[i])
            allPopQuizChiWords.append(allThreeChiWords[i])
            allPopQuizChiWords.append(popQuizThreeChiWords[i])
            
        }
        
        randomNums.shuffled()
        engRandomNums = randomNums
    }
    
    
    //製作popQuiz的字及答案
    func popQuiz(){
        
        //回復可以按鈕
        
        if !countScoreTimer.isValid{
            print("countscore timer not activated")
        isUserInteractionEnabled = true
        }
        
        
        if popQuizSeq > 2 {
            
            print("3 pop quizes over")
            
            //移除畫面
            //離開遊戲
            
            //以下function等同單數離開
            let scoreLabel = findLabelNode(name: "scoreLabel")
            
            var scoreToPass = scoreLabel.text!
            /*
            if isFinalGetPoint{
                 scoreToPass = String(Int(scoreLabel.text!)! + 500)
            }
           */
            
            if isFinalPopCorrect{
                
                scoreToPass = String(Int(scoreLabel.text!)! + 300)
            }
            
            //這是連接後端的func
            addWrongWords()
            
            
            let threeWords:[String:[String]] = ["engWords":allThreeEngWords,"chiWords":allThreeChiWords,"score":[scoreToPass],"correctResults":correctResults,"popQuizRight":[String(popQuizRight)],"wrongChinese":wrongChinese,"wrongWords":wrongWords]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "leaveGame"), object: nil, userInfo: threeWords)
            
        } else {
            
            //remove pronounceBtn
            print("trigger remove btn")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "removePlaySoundBtn"), object: nil, userInfo: nil)
            
            
            //啟動timer
            popQuizTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NewGameScene.popQuizCountDown), userInfo: nil, repeats: true)
        
            var twoEngAnswers = [String]()
       
            let chiQuestion = allPopQuizChiWords[randomNums[popQuizSeq]]
        
            let correctEng = allPopQuizEngWords[randomNums[popQuizSeq]]
        
            //抓另一個英文選項, 移除第一個位置, 因為數量一直遞減
            engRandomNums.remove(at: 0)
            
            let ran = Int(arc4random_uniform(UInt32(engRandomNums.count)))
            let wrongEng = allPopQuizEngWords[engRandomNums[ran]]

            let rightRan = Int(arc4random_uniform(UInt32(2)))
            if rightRan == 0 {
                
                twoEngAnswers.append(correctEng)
                twoEngAnswers.append(wrongEng)
                leftOrRight = 0
                
            } else {
                twoEngAnswers.append(wrongEng)
                twoEngAnswers.append(correctEng)
                leftOrRight = 1
                
            }
            
     
            findLabelNode(name: "bigChineseLabel").text = chiQuestion
            
            findLabelNode(name: "popUpLabel").text = twoEngAnswers[0]
            findLabelNode(name: "popDownLabel").text = twoEngAnswers[1]
            
            //leftChiNode.text = twoEngAnswers[0]
            //rightChiNode.text = twoEngAnswers[1]
            
            adjustLabelFontSizeToFitRect(labelNode: findLabelNode(name: "popUpLabel"), rect: findLabelNode(name: "popUpLabel").frame)
            adjustLabelFontSizeToFitRect(labelNode: findLabelNode(name: "popDownLabel"), rect: findLabelNode(name: "popDownLabel").frame)
            
            //adjustLabelFontSizeToFitRect(labelNode: leftChiNode, rect: findImageNode(name: "leftChiBtn").frame)
            
            //adjustLabelFontSizeToFitRect(labelNode: rightChiNode, rect: findImageNode(name: "rightChiBtn").frame)
        
            popQuizSeq += 1
        
        }
        
    }
    
    @objc func notifyStopReview(){
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
        
        hintSec += 1
        
        if hintSec >  150{
            //都沒動就發動
            //print("需要提醒")
            findLabelNode(name: "showHint").isHidden = false
            
            
        } else {
            //print("x")
            findLabelNode(name: "showHint").isHidden = true
        }
        
        
        
        
    }
    
    //*** 以下皆為一些自己建立的func 或是extension ***
    
    
    
    //新增錯誤單字
    
    func addWrongWords(){
        
        print("final wrongWords\(wrongWords)")
        if wrongWords.count > 0 {
            //確認有錯字
            
            for word in wrongWords{
                
                //避免重複
                if !myWrongWords.contains(word){
                    
                    print("wrongword:\(word)")
                    
                    let id = user?["id"] as! String
                    
                    // url to access our php file
                    let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/addWrongWord.php")!
                    
                    // request url
                    var request = URLRequest(url: url)
                    
                    // method to pass data POST - cause it is secured
                    request.httpMethod = "POST"
                    
                    // body gonna be appended to url
                    let body = "userID=\(id)&wrongWord=\(word)"
                    
                    // append body to our request that gonna be sent
                    request.httpBody = body.data(using: .utf8)
                    
                    URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
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
        }
        
    }
    
    //換圖片
    func changeTexture(nodeName:String,newTexture:String){
        
        if let node = childNode(withName: nodeName) as? SKSpriteNode{
            if let bundlePath = Bundle.main.path(forResource: newTexture, ofType: "png"){
                let imageFile = UIImage(contentsOfFile: bundlePath)
                let texture = SKTexture(image: imageFile!)
                node.texture = texture
                
            }
            
        }
        
    }
    
    //製作image的skspriteNode
    func makeImageNode(name:String, image:String, x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat, z:CGFloat, alpha:CGFloat, isAnchoring:Bool){
        
        if let bundlePath = Bundle.main.path(forResource: image, ofType: "png"){
            let imageFile = UIImage(contentsOfFile: bundlePath)
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
        
        
        if #available(iOS 11, *) {
            node.numberOfLines = 0
            
        } else {
            // Fallback on earlier versions
            
        }
        
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
    
    //找IMAGE的skspritenode
    func findImageNode(name:String) -> SKSpriteNode{
        var node:SKSpriteNode?
        if let nodeFound = childNode(withName: name) as? SKSpriteNode{
            node = nodeFound
        }
        return node!
        
    }
    
    //找labelNode
    func findLabelNode(name:String) -> SKLabelNode{
        
        var node:SKLabelNode?
        if let nodeFound = childNode(withName: name) as? SKLabelNode{
            node = nodeFound
        }
        return node!
        
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
    
    //單純造方塊字Label的功能
    func makeBlockLabel(x:Int,y:Int){
        let node = SKLabelNode()
        node.position = CGPoint(x: 0, y: 0)
        node.horizontalAlignmentMode = .center
        node.fontSize = 20
        node.text = ""
        node.fontColor = .white
        node.zPosition = 2
        node.name = "\(x)-\(y)BlockLabel"
        node.fontName = "Helvetica Neue"
        node.isHidden = false
        node.alpha = 1
        
        if let parentNode = findImageNode(name: "\(x)-\(y)") as SKSpriteNode?{
            parentNode.addChild(node)
            
        }
    }
    
    
    //單純發音功能
    func pronounce(finished: @escaping () -> Void){
        
        
        let pronounceAction = SKAction.playSoundFileNamed(wordsToPronounce + ".mp3", waitForCompletion: true)
        run(pronounceAction)
        
        finished()
    }
    
    //暫時用不到
    
    @objc func stopPlayAudio(){
        
        SKAction.stop()
        
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
            makeLabelNode(x: 0, y: 0, alignMent: .center, fontColor: .white, fontSize: 80, text: word, zPosition: 3, name: "tempWord", fontName: "Helvetica", isHidden: false, alpha: 1)
            
            
        }
    }
    
    
    func selectBall(word:String, poisonNumber:Int){
        
        //找選項正確音節
        let selectedLabel = findLabelNode(name: word + String(poisonNumber) + "Sel")
        
        //改變label fontColor
        let changeTextColor = SKAction.run {[weak self] in
            
            if self!.gameMode == 0 {
            
            selectedLabel.fontColor = self!.selectWordDarkColor
            }
        }
        run(changeTextColor)
        
        
        //按鈕發亮, 要設置為0秒完成, 否則會異常
        let buttonName =  String(poisonNumber) + "filledButton"
        changeImageAlfa(name: buttonName, toAlpha: 1, time: 0)
        
    }
    
    
    //抓node的位置func
    func getCgPoint(name:String) -> CGPoint{
        
        let node = childNode(withName: name) as! SKSpriteNode
        let xPos = node.frame.midX
        let yPos = node.frame.midY
        let position = CGPoint(x: xPos, y: yPos)
        return position
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
    
    func removeBall(word:String, poisonNumber:Int){
        
        
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
    
    //移除node的func
    func removeSomeNodes(name:String){
        
        for node in children{
            
            if (node.name?.contains(name))!{
                
                node.isHidden = true
                node.removeFromParent()
            }
        }
    }
    
    //答對得分機制
    func rightScore(){
        
        let cgPoint = CGPoint(x: 0, y: firstEngWordLabel.frame.origin.y)
        let flyUp = SKAction.move(to: cgPoint, duration: 0.3)
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.3)
        
        let combine = SKAction.group([flyUp,fadeOut])
        
        findLabelNode(name: "tempWord").run(combine) {[weak self] in
            
            self!.findLabelNode(name: "tempWord").removeFromParent()
            
        }
        
        
        
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
    
    func hintSlideIn(leftText:String,rightText:String,waitTime:TimeInterval,finished: @escaping () -> Void){
        
        
        let toRight = SKAction.moveTo(x: -50, duration: 0.3)
        let toLeft = SKAction.moveTo(x: 50, duration: 0.3)
        let disToRight = SKAction.moveTo(x: 425, duration: 0.05)
        let disToLeft = SKAction.moveTo(x: -425, duration: 0.05)
        let wait = SKAction.wait(forDuration: waitTime)
        
        findLabelNode(name: "hintLeftLabel").text = leftText
        findLabelNode(name: "hintRightLabel").text = rightText
        
        findLabelNode(name: "hintLeftLabel").run(toRight)
        findLabelNode(name: "hintRightLabel").run(toLeft)
        
        self.run(wait) {[weak self] in
            
            let combine = SKAction.run({
                self!.findLabelNode(name: "hintLeftLabel").run(disToLeft)
                self!.findLabelNode(name: "hintRightLabel").run(disToRight)
            })
            
            self!.run(combine, completion: {
                finished()
            })
            
        }
        
    }
    
    
    //popQuiz的計分邏輯還沒寫
    
    func chooseChineseResult(isCorrect:Bool){
        
        //正確
        
        //計分部分, 之後要寫複習的計分
        
        if isCorrect{
            
            
            if gameMode == 0 {
            countScore(score: 300)
                
                
                findLabelNode(name: "showHint").text = ""
                
                
            } else if gameMode == 1 {
                //update wordReviewCount
                
                wordReviewCount += 1
                
                practiceNextWord()
                
                //刪掉一些不該出現的
                notifyShowSentence()
                
                
                
            }
            
      
            
            if isPopQuiz{
            
                popQuizRight += 1
            let fadeIn = SKAction.fadeIn(withDuration: 0.1)
            let moveUp = SKAction.moveTo(y: 520, duration: 0.1)
            let groupAction = SKAction.group([fadeIn,moveUp])
            let wait = SKAction.wait(forDuration: 0.05)
            
                switch popQuizRight {
                case 0:
                    let sparkleAction = SKAction.run {[weak self] in
                        self!.sparkle?.isHidden = false
                        self!.sparkle?.resetSimulation()
                    }
                    let sequence = SKAction.sequence([wait,sparkleAction])
                    let groupAgain = SKAction.group([sequence,groupAction])
                    
                    findImageNode(name: "star3").run(groupAgain)
                case 1:
                    
                    let sparkleAction = SKAction.run {[weak self] in
                        self!.sparkle1?.isHidden = false
                        self!.sparkle1?.resetSimulation()
                    }
                    let sequence = SKAction.sequence([wait,sparkleAction])
                    let groupAgain = SKAction.group([sequence,groupAction])
                    
                    findImageNode(name: "star4").run(groupAgain)
                    
                    
                case 2:
                    let sparkleAction = SKAction.run {[weak self] in
                        self!.sparkle2?.isHidden = false
                        self!.sparkle2?.resetSimulation()
                    }
                    let sequence = SKAction.sequence([wait,sparkleAction])
                    let groupAgain = SKAction.group([sequence,groupAction])
                    
                    isFinalPopCorrect = true
                    findImageNode(name: "star5").run(groupAgain)
                    
                default:
                    break
                    
                    
                }
                
         
            }
            
            //如果是popQuiz就繼續挑戰
            if isPopQuiz {
                
                //findImageNode(name: "leftChiBtn").alpha = 1
                //findImageNode(name: "rightChiBtn").alpha = 1
                
                
                findImageNode(name: "popUpBlock").alpha = 1
                findImageNode(name: "popDownBlock").alpha = 1
                
                //leftChiNode.text = ""
                //rightChiNode.text = ""
                
                findLabelNode(name: "popUpLabel").text = ""
                findLabelNode(name: "popDownLabel").text = ""
                
                removeSomeNodes(name: "mark")
                
                popQuiz()
                
            } else {
                
                let wordSequenceToPass:[String:Any] = ["currentWordSequence":String(currentWordSequence),"pronounceTime":1]
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showSentence"), object: nil, userInfo: wordSequenceToPass)
            }
            
            
        } else {
            //錯誤的話
            correctResults[currentPracticeSequence] = "1"
            
            //紀錄中文錯誤
            wrongChinese[currentPracticeSequence] = "1"
            
            var wrongWord = String()
            
            if gameMode == 0 {
                
                findLabelNode(name: "showHint").text = ""
                
                
             wrongWord = wordSets[currentWordSequence].replacingOccurrences(of: " ", with: "")
                
                
                //send Nc
                //testing add here
                
                /*
                 let wordSequence:[String:Int] = ["wordSequence":currentWordSequence]
                 
                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: "onlyPracticeSentence"), object: nil, userInfo: wordSequence)
                 */
                
                
                //如果是popQuiz就繼續挑戰
                if isPopQuiz {
                    
        
                    
                    //findImageNode(name: "leftChiBtn").alpha = 1
                    //findImageNode(name: "rightChiBtn").alpha = 1
                    findImageNode(name: "popUpBlock").alpha = 1
                    findImageNode(name: "popDownBlock").alpha = 1
                    
                    
                    
                    //leftChiNode.text = ""
                    //rightChiNode.text = ""
                    findLabelNode(name: "popUpLabel").text = ""
                    findLabelNode(name: "popDownLabel").text = ""
                    
                    
                    removeSomeNodes(name: "mark")
                    
                    popQuiz()
                    
                } else {
                    
                    let wordSequenceToPass:[String:Any] = ["currentWordSequence":String(currentWordSequence),"pronounceTime":1]
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showSentence"), object: nil, userInfo: wordSequenceToPass)
                }

                
                if !wrongWords.contains(wrongWord){
                    wrongWords.append(wrongWord)
                }

                
                
                
                
                
            } else if gameMode == 1 {
                
                //應該不用指定wrongWord因為不需要update
                   // wrongWord = allWordSets[randomSpots[currentPracticeSequence]][randomUnits[currentPracticeSequence]].replacingOccurrences(of: " ", with: "")
                
                
                    let wordCount:[String:Int] = ["wordCount":wordReviewCount]
              
                print(wordCount)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopReview"), object: nil, userInfo: wordCount)

                
            }
            


        }
        
        
   
        
    }
    

    
    
    
    func battleModeWrong(){
        print("wrong")
    }
    
    @objc func notifyStartToRecognize(){
        
        //顯示錄音文字背景
        findImageNode(name: "recogWordsBg").alpha = 1
    }
    
    @objc func notifyLeaveGame(){
        
        print("notified")
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

