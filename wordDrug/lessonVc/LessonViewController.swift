//
//  LessonViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/4/19.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit
import AVFoundation

class LessonViewController: UIViewController{
    let map1SyllableSets = [["ab1","ac1","ad1","a_e1","af1","ai1","al1","am1","an1","any1"],
                            ["ap1","ar1","as1","at1","au1","aw1","ay1","ba1","be1","bi1"],
                            ["bit1","bl1","bo1","br1","bu1","by1","ce1","ch1","ci1","ble1"],
                            ["ck1","cl1","co1","com1","con1","di1","cr1","ct1","de1","cian1"],
                            ["do1","dr1","dy1","dis1","ea1","ee1","el1","en1","er1","em1"],
                            ["et1","ew1","ex1","ey1","fi1","fl1","fo1","fr1","ft1","ful1"],
                            ["ge1","gi1","gl1","go1","gr1","he1","hi1","id1","ie1","igh1"],
                            ["il1","im1","in1","ing1","ir1","is1","ject1","le1","li1","kn1"],
                            ["ly1","mi1","nd1","no1","oa1","ob1","o_e1","of1","oi1","nt1"],
                            ["old1","on1","ong1","oo1","op1","or1","ot1","ou1","ow1","oy1"],
                            ["ph1","pi1","pl1","pr1","cop1","ro1","ry1","sh1","si1","re1"],
                            ["sk1","so1","st1","sion1","th1","ti1","tion1","tive1","tle1","sp1"],
                            ["to1","tr1","ty1","ub1","u_e1","ui1","um1","un1","up1","ture1"],
                            ["ur1","ut1","war1","wh1","ab2","ac2","ad2","a_e2","ai2","af2"],
                            ["er34","er35","er36","ea34","ea35","ble4","ble5","fr3","at4","ple2"]]
    
    let map2SyllableSets = [["al2","am2","an2","ar2","as2","at2","au2","aw2","ay2","be2"],
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
    
    let map3SyllableSets = [["un3","ur3","wh3","a_e4","ad4","ai4","al4","am4","an4","um3"],
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
    
    let map4SyllableSets = [["sh7","st7","th7","a_e8","ai8","al8","am8","an8","ar8","ay8"],
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
    
    let map5SyllableSets = [["mi2","mi3","mud1","na1","nd3","ny1","olf1","oo13","ood1","or13"],
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

    let map6SyllableSets = [["a_e17","ar19","br5","ce10","em5","er52","my1","set1","st18","tain1"],
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
                            ["a_e20","ch15","cl9","com6","con7","cr4","cy1","ea41","sh11","ta1"]]
    
    let map7SyllableSets = [["am9","ce12","ch16","cl10","com7","con8","cr5","i_e16","ing11","ry5"],
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
                            ["con21","dis11","ge13","ly5","ment5","nd6","o_e10","oi4","ry13","tion15"]]

    
    let map8SyllableSets = [["a_e25","con22","dis12","e_e1","en36","er59","or30","sion3","sive1","sure1"],
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

    let map9SyllableSets = [["a_e31","al35","ce20","ew3","ful5","gle1","in23","jo1","tion22","ui5"],
                            ["a_e32","al36","ce21","in24","kn2","ko1","lab1","ly8","ness2","tion23"],
                            ["ar26","ble10","bug1","er66","gr7","i_e21","in25","kn3","la1","u_e6"],
                            ["au10","aw5","ay15","ea46","en38","in26","ing17","rn2","th13","ty8"],
                            ["an26","ck10","er67","igh7","lo1","ly9","oa8","oo21","or37","ture4"],
                            ["al37","by3","ea47","er68","gi4","in27","ou26","ous2","sp2","tion24"],
                            ["a_e33","ad6","ai17","ai38","ce22","er69","ge15","in29","ma1","tic3"],
                            ["al39","cal1","ch22","i_e22","in28","it2","me1","ph4","sh15","sure2"],
                            ["ble11","cle2","er70","igh8","il3","ment7","mi4","mis1","mo2","sion5"],
                            ["el16","er71","mis2","mu1","or38","ple3","th14","ture5","ty9","ug1"],
                            ["a_e34","al40","al41","ee28","ly10","mis3","na2","ne1","oo22","tion25"],
                            ["ck11","ew4","less1","no2","od1","or39","ous3","ow16","tr5","ur9"],
                            ["ch23","er72","ing18","oc1","on5","op4","or40","pic1","sive2","tion26"],
                            ["al42","ce23","er73","ge16","oa9","or41","ou27","ough1","th20","tion27"],
                            ["ar32","ck15","ea54","eigh1","er90","i_e30","th19","we1","wh5","wh6"]]
    
    let map10SyllableSets = [["a_e35","an27","ci7","ea52","ma1","o_e13","ow17","ox1","pa1","sh16"],
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
    
    
    let map11SyllableSets = [["a_e38","al50","ce32","er83","i_e26","ing22","ry6","sa1","sc2","tion38"],
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

    let map12SyllableSets = [["ab3","ac5","ce34","ly18","mic3","my2","or51","sion10","sive4","tion42"],
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
               ["a_e47","al56","ar36","au13","aw8","ba4","ful18","ge24","us4","oo25"],
               ["ar37","ba5","be4","ea56","en43","er94","it4","ly20","ness4","ow21"],
               ["as5","bi3","bl4","br11","ch31","ck17","ea57","ee32","ge25","gi6"],
               ["bl5","bo3","ce38","er95","ing30","oa10","old3","oo26","sh28","th23"]]

    let map13SyllableSets = [["a_e48","ai21","bl6","br12","ew6","i_e34","qu10","que2","th24","ty17"],
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
    
    let map14SyllableSets = [["a_e53","ce43","con34","cy3","de4","e_e3","en45","i_e35","tive10","ty21"],
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
    
    
    let map15SyllableSets = [["a_e66","al68","er105","fr5","ge30","ment16","or59","ou31","tion62","ty23"],
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
    
    let map16SyllableSets = [["a_e79","ai24","al76","in59","ing39","or62","ous15","ry23","tive14","u_e19"],
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
    
    
    let map17SyllableSets = [["ai25","al84","ce59","ly29","ous18","pre1","ry26","tion74","tive17","ture12"],
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
    
    
    let map18SyllableSets = [["ar44","ce66","i_e50","o_e27","ou37","ph17","sh40","so3","sp9","tion84"],
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
    
    
    
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var syllableLabel: UILabel!
    @IBOutlet weak var lessonLabel: UILabel!
    @IBOutlet weak var lessonTitleLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    @IBOutlet weak var progressLength: UIImageView!
    @IBOutlet weak var fullLength: UIImageView!
    @IBOutlet weak var enterBtn: UIButton!
    let pinkColor = UIColor.init(red: 247/255, green: 127/255, blue: 124/255, alpha: 1)
    var mapNumToReceive = Int()
   
    
    //被選擇到的音節
    var syllableSets = [[String]()]
    
    var wordSets = [String]()
    //做三個字
    var words = [NSMutableAttributedString(),NSMutableAttributedString(),NSMutableAttributedString()]
    
    var mapNum = Int()
    var spotNum = Int()
    var unitNum = Int()
    var gameMode = Int()
    
    @IBOutlet weak var reviewBtn: UIButton!
    
    //所有alertView的變數
    var alertBg = UIImageView()
    var alertText = UILabel()
    var ghostBtn = UIButton()
    var ghost2Btn = UIButton()
    var practiceWordBtn = UIButton()
    var practiceSenBtn = UIButton()
    var leftBtnClickedImg = UIImageView()
    var rightBtnClickedImg = UIImageView()
    var bigQuitBtn = UIButton()
    let darkRed = UIColor.init(red: 192/255, green: 40/255, blue: 75/255, alpha: 1)
    
    
    
    //發音單字
    var synWord = String()
    
    //Text to speech合成器
    var synth = AVSpeechSynthesizer()
    var audioSession = AVAudioSession.sharedInstance()
   
    
    //收到的課程數字
    var courseReceived = Int()
    
    
    var isClassAllPassed = false
    
    var maxMapNum = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        var dif = CGFloat()
        var xDif = CGFloat()
        switch height {
        case 812:
            xDif = 1.2
            dif = 1

        case 736:
            xDif = 1
            dif = 1.1
      
            
        case 667:
            xDif = 1
            dif = 1

            
        case 568:
            xDif = 1
            dif = 0.9

            
        default:
            xDif = 1
            dif = 0.9
            
        }

        
        //加入alertView
        let lightGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.58)
        ghostBtn.frame = CGRect(x: 0, y: 0, width: width, height: height)
        ghostBtn.backgroundColor = lightGray
        ghostBtn.addTarget(self, action: #selector(LessonViewController.removeBtns), for: .touchUpInside)
        self.view.addSubview(ghostBtn)
        
        
        
        alertBg.frame = CGRect(x: (width - 237 * dif) / 2, y: height * 2 /  5, width: width * 237 / 375, height: height * 140 / 667)
        alertBg.image = UIImage(named: "reviewSelectBg.png")
        self.view.addSubview(alertBg)
        
        ghost2Btn.frame = CGRect(x: (width - 237 * dif) / 2, y: height * 2 /  5, width: width * 237 / 375, height: height * 140 / 667)
        self.view.addSubview(ghost2Btn)
        
        alertText.frame = CGRect(x: 5 * dif , y: 5 * dif, width: alertBg.frame.width - 5 * dif * 2, height: alertBg.frame.height / 2)
        alertText.font = UIFont(name: "Helvetica Neue Bold", size: 28)
        alertText.textColor = .white
        alertText.text = "請選擇模式"
        alertText.numberOfLines = 2
        alertText.textAlignment = .center
        alertText.adjustsFontSizeToFitWidth = true
        alertBg.addSubview(alertText)
        
        
        practiceWordBtn.frame = CGRect(x: alertBg.frame.minX, y: alertBg.frame.maxY - 44 * dif * xDif, width: alertBg.frame.width / 2, height: height * 44 / 667)
        
        practiceWordBtn.setTitle("拼字王挑戰", for: .normal)
        practiceWordBtn.setTitleColor(darkRed, for: .normal)
        practiceWordBtn.addTarget(self, action: #selector(LessonViewController.practiceWord), for: .touchUpInside)
        self.view.addSubview(practiceWordBtn)
        
        practiceSenBtn.frame = CGRect(x: practiceWordBtn.frame.maxX, y: alertBg.frame.maxY - 44 * dif * xDif, width: alertBg.frame.width / 2, height: height * 44 / 667)
        practiceSenBtn.setTitle("句型冠軍榜", for: .normal)
        practiceSenBtn.setTitleColor(darkRed, for: .normal)
        practiceSenBtn.addTarget(self, action: #selector(LessonViewController.practiceSen), for: .touchUpInside)
        self.view.addSubview(practiceSenBtn)
        
        bigQuitBtn = UIButton(type: .system)
        bigQuitBtn.frame = CGRect(x: alertBg.frame.minX, y: alertBg.frame.maxY - 44 * dif * xDif, width: alertBg.frame.width, height: height * 44 / 667)
 
        bigQuitBtn.setTitle("我知道了", for: .normal)
        bigQuitBtn.setTitleColor(.darkGray, for: .normal)
        
        bigQuitBtn.addTarget(self, action:#selector(LessonViewController.removeBtns), for: .touchUpInside)
        self.view.addSubview(bigQuitBtn)
        
        leftBtnClickedImg.frame = practiceWordBtn.frame
        leftBtnClickedImg.image = UIImage(named: "leftBtnClickedImg.png")
        
        rightBtnClickedImg.frame = practiceSenBtn.frame
        rightBtnClickedImg.image = UIImage(named: "rightBtnClickedImg.png")
        
        self.view.addSubview(leftBtnClickedImg)
        self.view.addSubview(rightBtnClickedImg)
        leftBtnClickedImg.alpha = 0
        rightBtnClickedImg.alpha = 0

        
        backBtn.frame = CGRect(x: width / 10, y: width / 8, width: 19, height: 31)
        lessonTitleLabel.frame = CGRect(x: width * 5.5 / 7, y: backBtn.frame.minY - 10 * dif, width: 66 , height: 22)
        
        lessonLabel.frame = CGRect(x: width * 3 / 4, y: lessonTitleLabel.frame.maxY, width: width / 4, height: 60 * dif)
        lessonLabel.backgroundColor = .clear

        
        syllableLabel.frame = CGRect(x: 0, y: height / 5 * dif, width: width, height: height / 3.5 * dif)
    

        syllableLabel.textAlignment = .center
        //syllableLabel.backgroundColor = .blue
        

        firstLabel.frame = CGRect(x: 0, y: syllableLabel.frame.maxY + 10 * dif, width: width, height: 44 * dif)
        
        //firstLabel.backgroundColor = .red
        secondLabel.frame = CGRect(x: 0, y: firstLabel.frame.maxY, width: width, height: 44 * dif)
        //secondLabel.backgroundColor = .green
              thirdLabel.frame = CGRect(x: 0, y: secondLabel.frame.maxY, width: width, height: 44 * dif)
        
        //thirdLabel.backgroundColor = .yellow
        
        
        enterBtn.frame = CGRect(x: width / 2, y: height - 66 * dif, width: width / 2, height: 66 * dif)
        
        reviewBtn.frame = CGRect(x: 0, y: height - 66 * dif, width: width / 2, height: 66 * dif)
        
        fullLength.frame = CGRect(x: 0, y: enterBtn.frame.minY, width: width, height: 3)
        
        
        //拉到最前方
        self.view.bringSubview(toFront: ghostBtn)
        self.view.bringSubview(toFront: alertBg)
        self.view.bringSubview(toFront: ghost2Btn)
        self.view.bringSubview(toFront: practiceWordBtn)
        self.view.bringSubview(toFront: practiceSenBtn)
        self.view.bringSubview(toFront: leftBtnClickedImg)
        self.view.bringSubview(toFront: rightBtnClickedImg)
        self.view.bringSubview(toFront: bigQuitBtn)
        
        removeBtns()


        
    }
    
    //syn發音
    func synPronounce(){
        print("pronounce")
        print(synWord)
        
        do {
            
            //設置成ambient看能不能避免任何interruption 造成當機
            
            try audioSession.setCategory(AVAudioSessionCategoryAmbient)
            try audioSession.setMode(AVAudioSessionModeDefault)
            try audioSession.setActive(true)
            
        } catch  {
            print("error")
        }
        
        
        
        var rateFloat = Float()
        
        let utterance = AVSpeechUtterance(string: synWord)
        let utterance2 = AVSpeechUtterance(string: synWord)
        
        
            rateFloat = 0.45
            utterance.postUtteranceDelay = 0
    
        utterance2.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance2.rate = rateFloat
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = rateFloat
        
        
        //stopSpeech()
         //發音等待時間
         let when = DispatchTime.now() + 2
         
         DispatchQueue.main.async {[weak self] in
         
         guard let strongSelf = self else{
         return
         }
         //strongSelf.synth.stopSpeaking(at: .immediate)
         strongSelf.synth.speak(utterance)
         
         DispatchQueue.main.asyncAfter(deadline: when, execute: {
         strongSelf.synth.speak(utterance2)
         
         })
         }
         
        
    }

    
    @objc func removeBtns(){
        
        alertText.text = "請選擇模式"
        ghostBtn.isHidden = true
        alertBg.isHidden = true
        ghost2Btn.isHidden = true
        practiceWordBtn.isHidden = true
        practiceSenBtn.isHidden = true
        leftBtnClickedImg.isHidden = true
        rightBtnClickedImg.isHidden = true
        bigQuitBtn.isHidden = true
        practiceSenBtn.isEnabled = true
        practiceWordBtn.isEnabled = true
    }
    
    
    
    @objc func practiceSen(){
        print("practice Sen")
        
        gameMode = 2
        
        UIView.animate(withDuration: 0.06, animations: {[weak self] in
            
            self!.rightBtnClickedImg.alpha = 1
            
            
        }) {[weak self] (finished:Bool) in
            
            
            if finished {
                
                self!.rightBtnClickedImg.alpha = 0
                
                self?.practiceWordBtn.isEnabled = false
                self?.practiceSenBtn.isEnabled = false
                
                //有bug, 印出以下兩數字

                print(self!.mapPassedInt)
                print(self!.gamePassedDic)
                
                
                if self!.gamePassedDic == [0:0] && self!.mapNumToReceive >= self!.mapPassedInt{
                    
                    print("不能練習句子")
                    self!.cannotPracticeAlert()
                    
                
                } else {
                    
                     self!.performSegue(withIdentifier: "toGameVc", sender: self)
                }
                
                /*
                if self!.mapPassedInt == 0 {
                    
                    if self!.gamePassedDic == [0:0] {
                 
                        
                        
                    } else {
                 
                        
                    }
                } else {
   
                    self!.performSegue(withIdentifier: "toGameVc", sender: self)
                    
                }
                */

                
            }
        }
        
        
    }
    
    @objc func practiceWord(){
        print("practice word")
        
        gameMode = 1
        
        UIView.animate(withDuration: 0.06, animations: {[weak self] in
            
            self!.leftBtnClickedImg.alpha = 1
            
            
        }) {[weak self] (finished:Bool) in
            
            
            if finished {
                self!.leftBtnClickedImg.alpha = 0
                self?.practiceSenBtn.isEnabled = false
                self?.practiceWordBtn.isEnabled = false
                
                
                if self!.gamePassedDic == [0:0] && self!.mapNumToReceive >= self!.mapPassedInt{
                    
                    print("不能練習單字")
                    self!.cannotPracticeAlert()
                } else {
                    
                    self!.performSegue(withIdentifier: "toGameVc", sender: self)
                }
                
                /*
                if self!.mapPassedInt == 0 {
                    
                    if self!.gamePassedDic == [0:0] {
                        
                        print("不能練習")
                    } else {
                        
                        self!.performSegue(withIdentifier: "toGameVc", sender: self)
                    }
                    
                } else {
                
                self!.performSegue(withIdentifier: "toGameVc", sender: self)
                }
                
                */
            }
        }
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        practiceSenBtn.isEnabled = true
        practiceWordBtn.isEnabled = true
        removeBtns()
        
    }
    
    var gamePassedDic:[Int:Int]?
    var mapPassedInt = Int()
    var increaseNum = Int()
    
    override func viewWillAppear(_ animated: Bool) {
        
       
        //確認進入的地圖是否為當下地圖, 是的話跳轉到目前的元素, 不是的話代表以全過關, 跳轉到第一個重來
        
        //測試用
        
        //mapNumToReceive = 0
        //gamePassed = [4:3]
        //mapPassed = 0
        
        switch courseReceived {
        case 0:
            gamePassedDic = gamePassed!
            mapPassedInt = mapPassed!
            increaseNum = 0
            maxMapNum = 5
            
        case 1:
            gamePassedDic = gamePassed2!
            mapPassedInt = mapPassed2!
            increaseNum = 5
            maxMapNum = 6
            
        case 2:
            gamePassedDic = gamePassed3!
            mapPassedInt = mapPassed3!
            increaseNum = 11
            maxMapNum = 7
        default:
            break
        }
        
        
    
        
        if isClassAllPassed == false{
        
        let attrs0 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 45), NSAttributedStringKey.foregroundColor : pinkColor]
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor : UIColor.white]
        let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 40), NSAttributedStringKey.foregroundColor : UIColor.cyan]
        let attrs3 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 40), NSAttributedStringKey.foregroundColor : UIColor.white]
        
        //增加數字來抓正確的值
        mapNumToReceive += increaseNum
        
        switch mapNumToReceive {
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
        
        var syllablesWithoutDigit = String()
        
        var progressFloat = CGFloat()
        
        //再把數字減回來
        mapNumToReceive -= increaseNum
        
        if mapNumToReceive == mapPassedInt {
            //抓目前的元素
            
            for (s,u) in gamePassedDic! {
                
                let syllableChosen = syllableSets[s][u]
                
                let syllableChosenArray = syllableChosen.components(separatedBy: NSCharacterSet.decimalDigits)
                
                syllablesWithoutDigit = syllableChosenArray[0]
                syllableLabel.text = syllablesWithoutDigit
         
                mapNum = mapPassedInt
                spotNum = s
                unitNum = u
                progressFloat = CGFloat(u + 1)
                
            }
            
        } else {
            
            print("not the same")
            //跳轉到該地圖的第一個元素
            mapNum = mapNumToReceive
            spotNum = 0
            unitNum = 0
            progressFloat = 10
            
            let syllableChosen = syllableSets[spotNum][unitNum]
            
            let syllableChosenArray = syllableChosen.components(separatedBy: NSCharacterSet.decimalDigits)
            
            syllablesWithoutDigit = syllableChosenArray[0]
            
            syllableLabel.text = syllablesWithoutDigit
            
        }
        
 
        //第幾課
        let lessonText = NSMutableAttributedString(string: String(spotNum + 1), attributes: attrs0)
        lessonText.append(NSMutableAttributedString(string: " / 15", attributes: attrs1))
        lessonLabel.attributedText = lessonText
        
        //進度條
        progressLength.frame = CGRect(x: 0, y: fullLength.frame.minY, width: width * progressFloat / 10, height: 3)
        
        //讀取Bundle裡的文字檔
        var wordFile:String?
        
        //供抓字用 & pass給 gameVc
        mapNum += increaseNum
        
        let name = String(mapNum + 1) + "-" + String(spotNum + 1)
        
        print(name)
        
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
        
        //這個engWords是尚未attr的, attr完的是
        var allThreeEngWordsArray = [[String]]()
        var allThreeEngWords = [String]()
        
        let engWord0 = wordSets[unitNum * 3].components(separatedBy: " ")
        let engWord1 = wordSets[unitNum * 3 + 1].components(separatedBy: " ")
        let engWord2 = wordSets[unitNum * 3 + 2].components(separatedBy: " ")
        
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
        
        var attrWords = [[NSMutableAttributedString](),[NSMutableAttributedString](),[NSMutableAttributedString]()]
        
        
        if syllablesWithoutDigit.contains("_"){
            //specialE的作法
            
            var characters = [Character]()
            let vowels = ["a","e","i","o","u"]
            
            //每一個英文字節拆字母
            for w in 0 ..< allThreeEngWordsArray.count{
                
                for i in 0 ..< allThreeEngWordsArray[w].count{
                    
                    characters.removeAll(keepingCapacity: false)
                    
                    for c in allThreeEngWordsArray[w][i]{
                        
                        characters.append(c)
                    }
                    
                    if characters.count == 3{
                        if characters[2] == "e"{
                            
                            if vowels.contains(String(characters[0])){
                                
                                
                                //剛好是_e部首
                                let word = NSMutableAttributedString(string: String(characters[0]), attributes: attrs2)
                                attrWords[w].append(word)
                                let word1 = NSMutableAttributedString(string: String(characters[1]), attributes: attrs3)
                                attrWords[w].append(word1)
                                let word2 = NSMutableAttributedString(string: String(characters[2]), attributes: attrs2)
                                attrWords[w].append(word2)
                                
                                
                            } else {
                                
                                for c in 0 ..< characters.count {
                                    
                                    let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs3)
                                    attrWords[w].append(word)
                                }
                                
                            }
                            
                        } else {
                            
                            for c in 0 ..< characters.count {
                                
                                let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs3)
                                attrWords[w].append(word)
                            }
                            
                        }
                        
                    } else {
                        
                        for c in 0 ..< characters.count {
                            
                            let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs3)
                            attrWords[w].append(word)
                        }
                        
                    }
                    
                }
            }
            
        } else {
            //非specialE的作法
            
            //抓三個字的array
            for w in 0 ..< allThreeEngWordsArray.count{
                
                //抓array的音節,  只抓一個字
                for i in 0 ..< allThreeEngWordsArray[w].count{
                    
                    if let engWord = allThreeEngWordsArray[w][i] as String?{
                        
                        if engWord == syllablesWithoutDigit{
                            //符合部首字
                            
                            let word = NSMutableAttributedString(string: engWord, attributes: attrs2)
                            attrWords[w].append(word)
                            
                            
                        } else{
                            //一般字元
                            
                            let word = NSMutableAttributedString(string: engWord, attributes: attrs3)
                            
                            attrWords[w].append(word)
                            
                        }
                    }
                    
                }
                
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
        firstLabel.attributedText = words[0]
        secondLabel.attributedText = words[1]
        thirdLabel.attributedText = words[2]

        enterBtn.isEnabled = true
        
        //指定音節
        synWord = syllablesWithoutDigit
                
        //音節發音
        //synPronounce()
        
        } else {
            //進度條
            
            
            let attrs0 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 36), NSAttributedStringKey.foregroundColor : UIColor.white]
            let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 36), NSAttributedStringKey.foregroundColor : pinkColor]
            
            let attrWords = NSMutableAttributedString()
            let text1 = NSMutableAttributedString(string: "此單元結束", attributes: attrs0)
            let text2 = NSMutableAttributedString(string: "請選擇", attributes: attrs0)
            let text3 = NSMutableAttributedString(string: "挑戰模式", attributes: attrs1)
            
            let text4 = NSMutableAttributedString(string: "來複習", attributes: attrs0)
            
            attrWords.append(text1)
            attrWords.append(NSMutableAttributedString(string: "\n"))
            attrWords.append(text2)
            attrWords.append(text3)
            attrWords.append(NSMutableAttributedString(string: "\n"))
            attrWords.append(text4)
            
            progressLength.frame = CGRect(x: 0, y: fullLength.frame.minY, width: fullLength.frame.width, height: 3)
            enterBtn.isEnabled = false
            enterBtn.setTitle("課程結束", for: .normal)
            //syllableLabel.text = "此單元結束\n請選擇下方快速複習\n挑戰模式"
            syllableLabel.attributedText = attrWords
            //syllableLabel.font = UIFont(name: "Helvetica Bold", size: 36)
            syllableLabel.adjustsFontSizeToFitWidth = true
            syllableLabel.numberOfLines = 3
            syllableLabel.textAlignment = .center
            
        }
    }

    @IBAction func enterGameClicked(_ sender: Any) {
        
        gameMode = 0
        enterBtn.isEnabled = false
        performSegue(withIdentifier: "toGameVc", sender: self)
    }
    
    @IBAction func reviewBtnClicked(_ sender: Any) {
        
        ghostBtn.isHidden = false
        alertBg.isHidden = false
        ghost2Btn.isHidden = false
        practiceWordBtn.isHidden = false
        practiceSenBtn.isHidden = false
        leftBtnClickedImg.isHidden = false
        rightBtnClickedImg.isHidden = false
        
    }
    
    func cannotPracticeAlert(){
        
        alertText.text = "此課程尚未學習，無法挑戰\n 至少需要學習一個單元才能挑戰複習"
        ghostBtn.isHidden = false
        
        
        alertBg.image = UIImage(named: "reviewQuitBg.png")
        alertBg.isHidden = false
        bigQuitBtn.isHidden = false
        ghost2Btn.isHidden = false
        practiceWordBtn.isHidden = true
        practiceSenBtn.isHidden = true
        //leftBtnClickedImg.isHidden = false
        //rightBtnClickedImg.isHidden = false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toGameVc"{
            let destinationVC = segue.destination as! NewGameViewController
            destinationVC.spotNumber = spotNum
            destinationVC.unitNumber = unitNum
            destinationVC.mapNumber = mapNum
            destinationVC.gameMode = gameMode
            destinationVC.courseReceived = courseReceived
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
