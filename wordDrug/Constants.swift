//
//  Constants.swift
//  wordDrug
//
//  Created by Ethan on 2018/8/17.
//  Copyright © 2018年 playplay. All rights reserved.
//

import Foundation


public let userDefaults = UserDefaults.standard


//第一張地圖 1-15探索點元素 已更新過
public let map1SyllableSets:[[String]] =
[["sk1","so1","st1","sion1","th1","ti1","tion1","tive1","tle1","sp1"],
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

//第二張地圖1-15探索點 已更新過
public let map2SyllableSets:[[String]] =
[["al2","am2","an2","ar2","as2","at2","au2","aw2","ay2","be2"],
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

//第三張地圖1-15探索點 已更新過
public let map3SyllableSets:[[String]] =
[["un3","ur3","wh3","a_e4","ad4","ai4","al4","am4","an4","um3"],
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

//第四張地圖1-15探索點 已更新過
public let map4SyllableSets:[[String]] =
[["sh7","st7","th7","a_e8","ai8","al8","am8","an8","ar8","ay8"],
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

//第五張地圖1-15探索點 已更新過
public let map5SyllableSets:[[String]] =
[["mi2","mi3","mud1","na1","nd3","ny1","olf1","oo13","ood1","or13"],
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


//第六張地圖1-15探索點
public let map6SyllableSets:[[String]] =
[["a_e17","ar19","br5","ce10","em5","er52","my1","set1","st18","tain1"],
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

//第七張地圖1-15探索點
public let map7SyllableSets:[[String]] =
[["am9","ce12","ch16","cl10","com7","con8","cr5","i_e16","ing11","ry5"],
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

//第八張地圖1-15探索點
public let map8SyllableSets:[[String]] =
[["a_e25","con22","dis12","e_e1","en36","er59","or30","sion3","sive1","sure1"],
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

//第九張地圖1-15探索點
public let map9SyllableSets:[[String]] =
[["a_e31","al35","ce20","ew3","ful5","gle1","in23","jo1","tion22","ui5"],
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

//第十張地圖1-15探索點
public let map10SyllableSets:[[String]] =
[["a_e35","an27","ci7","ea52","ma1","o_e13","ow17","ox1","pa1","sh16"],
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

//第十一張地圖1-15探索點
public let map11SyllableSets:[[String]] =
[["a_e38","al50","ce32","er83","i_e26","ing22","ry6","sa1","sc2","tion38"],
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

//第十二張地圖12-1到12-15探索點
public let map12SyllableSets:[[String]] =
[["ab3","ac5","ce34","ly18","mic3","my2","or51","sion10","sive4","tion42"],
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

//多益第二張地圖13-1 到13-15探索點
public let map13SyllableSets:[[String]] =
[["a_e48","ai21","bl6","br12","ew6","i_e34","qu10","que2","th24","ty17"],
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

//多益第三張地圖14-1 到14-15探索點
public let map14SyllableSets:[[String]] =
[["a_e53","ce43","con34","cy3","de4","e_e3","en45","i_e35","tive10","ty21"],
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

//多益第四張地圖15-1 到15-15探索點
public let map15SyllableSets:[[String]] =
[["a_e66","al68","er105","fr5","ge30","ment16","or59","ou31","tion62","ty23"],
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

//多益第五張地圖16-1 到16-15探索點
public let map16SyllableSets:[[String]] =
[["a_e79","ai24","al76","in59","ing39","or62","ous15","ry23","tive14","u_e19"],
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

//多益第六張地圖17-1 到17-15探索點
public let map17SyllableSets:[[String]] =
[["ai25","al84","ce59","ly29","ous18","pre1","ry26","tion74","tive17","ture12"],
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

//多益第七張地圖18-1 到18-15探索點
public let map18SyllableSets:[[String]] =
[["ar44","ce66","i_e50","o_e27","ou37","ph17","sh40","so3","sp9","tion84"],
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

//雅斯第一張地圖19-1 到19-15探索點
public let map19SyllableSets:[[String]] =
[["al95","ce78","ci14","dr10","e_e6","ment23","or72","pt2","qu17","tion98"],
["ab8","ac6","ge47","ly35","mic5","my3","nt7","tion96","u_e26","un19"],
["a_e99","ab9","ac7","ble42","ch54","com23","cr17","ing49","ou38","tion97"],
["a_e98","ab7","ce70","i_e54","ment22","oa15","sh46","tion88","tive19","ty36"],
["ad9","ce79","in65","ly36","qu18","sion21","sive9","tion99","tive20","ult4"],
["ad10","ce80","ct13","cy7","ir9","or73","ous26","ry31","tion100","ture15"],
["a_e100","ai30","ar47","ble43","en51","er127","gr11","ment24","ny4","um18"],
["a_e101","gy9","o_e28","ong5","ot5","ow29","oy4","tion101","u_e27","ur16"],
["a_e102","am14","ame2","ce81","fy3","ment25","ple7","sis4","tion102","ty38"],
["a_e103","al96","an37","ex6","lar2","ly37","ou39","ous27","que5","tic18"],
["an38","au17","ble44","ea69","i_e55","oi10","pr21","tion103","tive21","us4"],
["a_e104","ar48","ay22","ce82","ge48","gy10","ment26","na4","nt8","st40"],
["ar49","as6","cle5","em10","er128","gn4","i_e56","ment27","tion104","u_e28"],
["ar50","as7","at6","ch55","ck30","ph18","sh61","sure5","th37","tr12"],
["ai31","au18","aw11","ce83","ey6","ful10","nd9","tic19","tion105","ue10"]]

//雅斯第二張地圖20-1 到20-15探索點
public let map20SyllableSets:[[String]] =
[["a_e105","ad11","au19","ax4","ba6","fle2","ge49","is5","tion106","um19"],
["al97","ar51","au20","ban3","bar2","ble45","el123","ly38","on9","oo31"],
["bar3","be5","bio2","ea73","en52","er129","ge50","il4","ow30","ry32"],
["an39","be6","bl8","ea70","i_e57","ing50","ness7","old5","oo32","th38"],
["bl9","bo4","br4","ch56","dle4","igh15","oo33","or74","ow35","th39"],
["ai32","al98","bl10","br16","bu9","by6","ca11","ck31","some4","tle6"],
["a_e106","an40","an41","ble46","br17","bu10","ca12","ee41","tion107","ty39"],
["ar52","br18","bu11","ca13","ch57","ing51","less8","ry33","sh62","ture16"],
["al99","ar53","br19","bu12","ca14","ce84","ea74","er130","ous28","rn3"],
["a_e107","ar54","br20","ca15","ce85","ch58","ew7","ment28","ry34","ty40"],
["al100","au21","br21","ce86","ch59","cl16","i_e58","o_e29","oa16","tion108"],
["ch60","ci15","cl17","co26","dy6","ea75","nic6","oi11","tion109","tive22"],
["a_e108","br23","ch61","cl18","com24","con43","ment29","sion22","sive10","tion110"],
["ch62","cl19","com25","con44","cy8","ous29","sion23","sis5","tion111","tive23"],
["a_e109","br22","ch63","cl20","com26","con45","nd10","ness8","or75","tion112"]]

//雅斯第三張地圖21-1 到21-15探索點
public let map21SyllableSets:[[String]] =
[["ce87","ch64","com27","con46","mic6","or76","or77","po5","sion24","tion114"],
["aw12","com29","con47","cr18","er131","mo4","ou40","sh63","sy2","tion113"],
["al101","ch75","ck32","com28","con48","cr19","ing52","tion115","u_e29","um20"],
["ble47","ch65","com30","con49","cr20","er132","ism1","tion116","ty41","ur17"],
["am15","com31","con50","cr21","er133","ly39","ous30","ry35","tion117","ur18"],
["a_e110","ay23","bt2","ce88","com32","con51","cr22","ing53","ta5","tion118"],
["a_e111","cl21","com33","con52","cr23","ct14","ea76","ee42","i_e59","o_e30"],
["a_e112","ce89","com34","con54","cy9","de9","en53","fy4","tion119","tive24"],
["a_e113","al102","ar55","com35","con53","cr24","en54","qu19","sh64","tion120"],
["a_e114","com36","con55","de11","er134","i_e60","ment30","tion121","tive25","ty42"],
["ce90","con56","ct15","de10","dia2","dic2","er135","i_e61","o_e31","tion122"],
["ce94","con57","de12","ge51","gi7","i_e62","im14","sion25","tion123","u_e30"],
["ble48","ce91","con58","cy10","de13","dis22","ma5","ous31","tic20","tion24"],
["a_e115","ch66","con59","de14","di5","dis23","er136","i_e63","sion26","tion125"],
["aw13","con60","dis24","dr11","ge52","nt9","o_e32","ow36","tic21","ul3"]]

//雅斯第四張地圖22-1 到22-15探索點
public let map22SyllableSets:[[String]] =
[["con61","dis25","dr12","dw1","ea77","ly40","th40","tion126","tr13","ty43"],
["cian5","con62","dis26","dr13","en55","ject3","mic7","or78","st41","tion127"],
["a_e116","ce92","con63","dis27","dr14","ge53","it7","ment31","ry36","tion128"],
["ch67","cle6","con64","dis28","em11","gr12","ment32","oi12","sis6","tion29"],
["ai33","ce93","con65","dis29","em12","en56","ment33","pr22","qu20","sure6"],
["a_e117","al103","con66","dis30","em13","en57","pt3","qu21","tion130","tr14"],
["a_e118","al104","ay24","con67","dis31","nt10","or79","tion131","um21","ve4"],
["a_e119","al105","ce95","cl22","con68","dis32","ge54","ment34","sion27","sive11"],
["a_e120","au22","con69","dis33","er137","ex7","i_e64","tion132","tive26","ture17"],
["con70","dis34","en58","er138","ex8","ly41","o_e33","sion28","sive12","tion133"],
["a_e121","con71","ct16","dis35","ex9","ful11","or80","sh65","tion134","ty44"],
["a_e122","al106","an42","ble49","ci16","con72","dis36","th41","tic22","tion135"],
["a_e123","ble50","ch68","ck33","dis37","ee43","er139","gue4","ous32","ry37"],
["al107","ce96","fi4","fl5","i_e65","ing54","ir10","sh66","tion136","u_e31"],
["cy11","ee44","er140","fl6","fo4","oa17","oe2","oo34","or81","sh67"]]

//雅斯第五張地圖23-1 到23-15探索點
public let map23SyllableSets:[[String]] =
[["a_e124","fl7","fr6","ing55","or82","ou41","th42","tion137","tion138","ture18"],
["al108","ble51","fl8","fr7","ge55","or83","ow37","ry38","str9","ue11"],
["a_e125","al109","ea78","ga3","ge56","gl5","gle4","gy11","oa18","or84"],
["ful12","fy5","ga4","ge57","gl6","go4","gr13","ous33","ty45","u_e32"],
["a_e126","ar56","bit2","ee45","ge58","gl7","gr14","ou42","ow38","tic23"],
["ai34","al110","am16","an43","ar57","dy7","ful13","ge59","gr15","oo35"],
["an44","ar58","au23","aw14","con73","en59","gr16","less9","st42","ty46"],
["ar59","ce97","ea79","el24","er141","ge60","gr17","igh16","ing56","ph19"],
["ch69","ck34","ea71","gr18","i_e66","in66","ly42","ous34","ow31","th43"],
["al111","ble52","ge61","gr19","mid2","o_e34","op6","or85","ty47","ul4"],
["a_e127","e_e7","gr20","im15","ment35","or86","pl5","sh68","stle2","tion139"],
["a_e128","ble53","con74","dle5","im16","in67","qu22","sis7","sive13","tion140"],
["al112","ble54","ce98","im17","in68","ly43","ment36","tion141","tive27","ur19"],
["a_e129","al113","ct17","ge62","in69","or87","ous35","ry39","tion142","ty48"],
["al114","ble55","ce99","ct18","in70","ment37","tion143","tive28","tr15","ty49"]]

//雅斯第六張地圖24-1 到24-15探索點
public let map24SyllableSets:[[String]] =
[["a_e130","al115","ce100","in71","lar3","ly44","ny5","oi13","ous36","tion144"],
["a_e131","ble56","ce101","ee46","er142","ge63","i_e67","in72","ry40","tion145"],
["a_e132","al116","ay25","ea80","in73","ing57","kn4","la3","tion146","ture19"],
["a_e133","ar60","ce102","ea81","er143","i_e68","im18","in74","o_e35","tion147"],
["by7","ck35","er144","ge64","in75","oa19","qu23","st43","tic24","tion148"],
["a_e134","al117","er145","fy6","in76","oo36","ry41","tive29","ty50","u_e33"],
["ai35","ar61","ble57","ce103","in77","oo37","ous37","ple8","sion29","ty51"],
["al118","ar62","gi8","ism2","ma6","sh69","sive14","sk5","st44","ture20"],
["al119","ch70","el25","i_e69","in78","ly45","me5","nic7","tion149","um22"],
["a_e135","ai36","ce104","cy12","gle5","gr21","igh17","in79","me6","ry42"],
["a_e136","ge65","i_e70","in80","mis5","mo5","oa20","th44","ty52","u_e34"],
["er146","in81","ing58","mis6","mo6","or88","ou43","ous38","ry43","sh70"],
["a_e137","al120","au24","ble58","in82","ous39","tion150","tion151","tive30","tr16"],
["el26","in83","less10","ly46","ough3","tion152","ty53","u_e35","us5","wh12"],
["a_e138","al121","en60","fy7","in84","ject4","on10","ong6","ous40","ry44"]]

//雅斯第七張地圖25-1 到25-15探索點
public let map25SyllableSets:[[String]] =
[["ble59","ce105","er147","in86","nt11","op7","set2","sion30","tion153","ur20"],
["ce106","en61","ge66","in85","ism3","ment38","op8","or89","ou44","um23"],
["al122","er148","ing59","oa21","oo38","or90","ou45","ous41","ow39","st45"],
["ck36","dy8","i_e71","igh18","ing60","or91","ow32","ox2","sh71","th45"],
["a_e39","al123","an45","ar63","ci17","cle7","i_e72","tion154","ture21","u_e36"],
["a_e140","an46","ch71","ea82","ee47","pe2","sion31","tic25","tr17","ty54"],
["a_e141","ce107","er149","it8","lar4","or92","pe3","ph20","sive15","tion155"],
["ai37","al124","e_e8","ment39","nt12","ph21","que6","sis8","tive31","u_e37"],
["ch72","ge67","o_e36","ow34","ph22","pi4","pl6","sure7","tion156","un20"],
["al125","ce108","ck37","o_e37","or93","pl7","po6","tic26","tr18","ty55"],
["ble60","ch73","ing61","ly47","ou46","pl8","pre3","sion32","tion157","ty56"],
["ce109","ct19","cy13","i_e73","ous42","ple9","pr23","pre4","u_e38","um24"],
["an47","ce110","ge68","o_e38","pr24","pre5","sion33","tic27","tion158","tive32"],
["a_e142","al126","ce111","er150","o_e39","pr25","pre6","sh72","tion159","ty57"],
["gy12","nt13","pr26","pre7","pu2","qu24","tive33","ty58","ue12","ui7"]]

//雅斯第八張地圖26-1 到26-15探索點
public let map26SyllableSets:[[String]] =
[["ai38","an48","ar64","ch74","ck38","ow33","pr27","qu25","ry45","tion160"],
["aw15","ay26","fy8","ge69","ly48","pr28","qu26","ra2","tion161","tle7"],
["al127","ble61","ci18","ea83","el127","i_e74","qu27","sion34","tion162","u_e39"],
["ai39","ce112","ct20","ee48","ing62","nd11","or97","re23","tion163","ur21"],
["a_e143","ce113","e_e9","ee49","gi9","gn5","ject5","oi14","re24","tion164"],
["al128","ble62","ce71","ew8","ment40","ous43","qu28","re25","sis9","tion165"],
["ble63","ce72","ea84","or94","re26","str10","tion166","tive34","tr19","u_e40"],
["i_e75","ly49","o_e40","oa22","ous44","re27","ri4","st46","tion167","ty59"],
["a_e144","al129","i_e76","ou47","re28","ri5","ry46","th46","tion168","u_e41"],
["ar65","au25","ce73","ge70","lar5","nic8","ou48","re29","ri6","sc8"],
["ea85","ee50","en62","ew9","old6","re30","ri7","sc9","sh47","ture22"],
["a_e145","ck39","e_e10","ment41","ness9","re31","sc10","set3","sh48","ty60"],
["al130","ci19","igh19","ing63","nt14","ph23","re32","sc11","sh49","si3"],
["ay27","ce74","en63","er151","ous45","re33","sc12","sh50","sk6","sl4"],
["ble64","ck40","ly50","oa23","re34","ry47","sh51","sl5","sn2","so4"]]

//雅斯第九張地圖27-1 到27-15探索點
public let map27SyllableSets:[[String]] =
[["oo39","or95","re35","sc13","sh52","sl6","tion89","ty61","u_e42","wh13"],
["a_e146","al131","ar66","ci20","fy9","i_e77","re36","sh53","sp14","st47"],
["al132","dy9","ple10","sh54","sp15","st48","tic28","tion90","tle8","um25"],
["a_e147","ch76","ey7","gy13","ing64","sh55","sp16","st49","str11","tion91"],
["ble65","ce75","en64","ge71","sh56","sion35","sp17","st50","str12","sub6"],
["ow40","ry48","sh57","sp18","st51","str13","sub7","tr20","ue13","um26"],
["ge72","i_e78","ous46","sh58","st52","str14","sub8","sw2","ur22","us6"],
["ea72","ee51","er152","ny6","ple11","sh59","st53","str15","sub9","sym5"],
["ai40","ar67","ck41","en65","kle3","sh60","st54","str16","sym6","ta6"],
["a_e148","al133","ce76","ea86","o_e41","ph24","st55","str17","sym7","tion92"],
["ble66","i_e79","igh20","nt15","or96","ry49","sion36","st56","th47","tr21"],
["al134","ble67","er153","ly51","ous47","th48","tion93","tr22","tw4","ty62"],
["a_e149","al135","i_e80","ing65","ly52","th49","tion94","tr23","ty37","un21"],
["a_e150","ble68","ce77","ge73","th50","tion95","tr24","un22","va2","war2"],
["al136","ea87","ge74","oo40","ous48","th51","tr25","va3","wh14","wr3"]]

//托福第一張地圖28-1 到28-15探索點
public let map28SyllableSets:[[String]] =
[["ab10","an56","bl11","ee53","i_e109","ly63","ment53","ou52","ru2","tion178"],
["ac9","ce125","cian6","cr29","ct23","fl12","ing83","ly62","tic35","ty73"],
["ac8","ad12","ce124","ct22","i_e91","ing82","ness14","or113","tive43","ty72"],
["a_e161","al158","am17","an57","ble82","ft5","in95","my4","ous64","u_e45"],
["ai42","ar74","as8","ch83","ing81","ly61","oa24","oy5","pr30","qu30"],
["an58","ar73","as9","au29","dr16","ea92","er155","ment45","ness13","oi17"],
["au28","be8","ck45","ful16","igh22","ing80","less14","oo43","que7","sh80"],
["au27","aw17","be7","br25","bu13","ca16","ism9","less13","tion177","ur26"],
["al157","ce123","dr15","gr23","i_e90","ous63","ry57","stle3","tic34","ur25"],
["al156","ble81","ch82","ci24","cl23","ex12","gi13","gy16","ph28","tive42"],
["ce122","ch81","ci23","com39","con84","cy15","ph27","ry56","sion41","tr33"],
["al155","ce121","com38","con83","cr28","ge81","ing79","or112","ow42","ture25"],
["a_e160","al154","cle9","com37","con82","cr27","fr9","ge80","or102","um29"],
["al153","ble80","con81","cr26","de16","el29","en69","or101","tion176","ty71"],
["con80","de15","dis39","er154","gr22","ly60","oa26","ous62","sion40","tive41"]]

//托福第二張地圖29-1 到29-15探索點
public let map29SyllableSets:[[String]] =
[["a_e159","al152","ci22","con79","dis38","ful15","gi12","ness12","ry55","th57"],
["ce120","con78","do3","em15","en72","ge79","less12","ment44","ong7","sh79"],
["ble79","en68","gle6","ic9","ing78","mis7","nic9","o_e45","tle9","tr32"],
["ar72","ch80","ee52","ex11","i_e89","ic8","ism8","st63","tic33","tion175"],
["al151","ay28","ex10","fa1","fl11","igh21","ing77","o_e44","on11","th56"],
["fl10","fr8","ful14","fy11","gi11","ing76","ous61","sh78","u_e44","un28"],
["al150","fo1","ga6","gl8","ir11","lar8","nd12","old7","ous60","tic32"],
["ch79","er153","ga5","ing75","ly59","or111","ty70","ue14","um28","us8"],
["ce109","fl9","gu3","im21","in94","ment43","ous59","sive17","tive46","ty69"],
["a_e158","ble78","con77","i_e88","im20","in93","ing74","nt18","sh77","tive40"],
["an59","el28","ew10","il5","in92","ly58","ous58","tic31","tive39","u_e43"],
["al149","ar71","ce118","ch78","ea91","in91","th55","ty68","ul5","va4"],
["al148","au26","ic7","in90","ism7","or100","ou51","sion39","st62","tic30"],
["a_e157","al147","ck44","gi10","less11","ou50","ph26","ry54","tion174","ur24"],
["al146","ge78","ic6","ly57","nt17","or110","ous57","pl10","tive38","ty67"]]

//托福第三張地圖30-1 到30-15探索點
public let map30SyllableSets:[[String]] =
[["ce117","er152","ie3","ly56","oo42","pl9","qu29","sis11","tion173","war3"],
["a_e156","ble77","br24","ce116","cle8","en71","ing73","or109","ous56","re40"],
["al145","dle6","i_e87","mic8","ness11","re39","ry53","sc15","st61","tr31"],
["cr25","ea90","gy15","ism6","oe3","ple13","re38","sc14","sh76","ty66"],
["ea89","ge77","lar7","oi16","re37","sh75","sl7","sm3","sp20","ture24"],
["a_e155","ai41","ct21","fy10","in89","ple12","sion38","sp19","ue17","um27"],
["ab11","aw16","ble76","i_e86","ing72","o_e43","sh74","sub10","sym8","ui8"],
["al144","an60","ble75","ch77","oi15","ous55","th54","tr30","un27","ur23"],
["al143","ble74","ge76","im19","ing71","ness10","sive16","tion172","ty65","un26"],
["ble73","i_e85","ic5","in88","nt16","oo41","ous54","tive37","un25","wa1"],
["a_e151","al137","ame3","an61","ar68","ble69","br26","ce114","ci21","ck42"],
["a_e152","ar69","ble70","ce115","ci30","ck43","con75","cy14","dy10","e_e11"],
["a_e153","al138","ar70","ble71","con76","e_e12","ea88","em14","en66","er174"],
["a_e154","al139","ble72","en67","er175","fy15","ge75","gy14","i_e81","ic4"],
["al140","ble98","co27","en70","i_e82","il6","in87","ing66","ir13","ism4"]]

//托福第四張地圖31-1 到31-15探索點
public let map31SyllableSets:[[String]] =
[["al141","en81","i_e83","ing67","ism5","lar6","ly53","ma7","ment42","nt23"],
["al142","i_e84","ing68","ly54","o_e42","old8","on12","or106","ou49","ous49"],
["ing69","ject6","ly55","or107","ou58","ous51","ow41","ph25","pr29","pt4"],
["ing70","or108","ous50","po7","qu38","ry50","sa3","set4","sion37","sis10"],
["or98","ous52","ry51","sh73","sk7","sn3","st57","th52","tic29","tion169"],
["or99","ous53","ry52","st58","sw3","th53","tion170","tive35","tr26","ture23"],
["ous76","pa4","st59","str18","tian1","tion171","tive36","tr27","ty63","ue16"],
["a_e162","ac10","ai46","al159","st60","tr28","ty64","un23","us11","va5"],
["a_e163","ac11","ai43","al160","am18","an62","ar75","tr29","un24","us7"],
["a_e164","ai44","al161","am19","an63","ar76","au30","aw18","ay29","bl12"],
["a_e165","ai45","al162","an64","ar77","au31","aw19","ay30","bl13","ble83"],
["a_e166","ai47","al163","an65","ar78","au32","aw20","ay31","ble84","bu14"],
["a_e167","ai48","al164","an66","ar79","au33","aw21","ay32","ble85","ce126"],
["a_e168","ai49","al165","an67","ar80","au34","ay33","ble86","ce127","ch84"],
["a_e169","al166","ar81","ble87","ce128","ch85","ci25","ck46","cl24","com40"]]

//托福第五張地圖32-1 到32-15探索點
public let map32SyllableSets:[[String]] =
[["a_e170","al167","ar82","ble88","ce129","ch86","ci26","ck47","com41","con100"],
["a_e171","al168","ar83","ble89","ce130","ch87","ci27","ck48","com42","con101"],
["a_e172","al169","ar84","ble90","ce131","ch88","ci28","ck49","com43","con102"],
["a_e173","al170","ar85","ble91","ce132","ch89","ci29","com44","con85","cos1"],
["a_e174","al171","ar86","ble92","ce133","ch90","com45","con86","cr30","ct24"],
["a_e175","al172","ar87","ble93","ce134","ch91","com46","con87","cr31","ct25"],
["a_e176","al173","ar88","ble94","ce135","ch92","com47","ct26","cy16","de17"],
["a_e177","al174","ble95","ce136","ch93","con88","ct27","cy17","di6","dis40"],
["a_e178","al175","ble96","ce137","con89","cy18","dic3","dis41","dle7","dr17"],
["a_e179","al176","ble97","ce138","con90","cy19","dis42","dr18","e_e13","ea100"],
["a_e180","al177","ce139","con92","dis43","e_e14","ea101","el130","en73","er156"],
["a_e181","al178","ce140","con91","dis44","e_e15","ea102","ee54","en74","er157"],
["a_e182","al179","ce141","con93","dis45","ea103","ee55","en75","er158","ew11"],
["a_e183","al180","ce142","con94","dis46","ea104","ee56","en76","er159","ex13"],
["a_e184","al181","ce143","con95","dis47","ea93","ee57","en77","er161","ex14"]]

//托福第六張地圖33-1 到33-15探索點
public let map33SyllableSets:[[String]] =
[["a_e185","al182","ce144","con96","ea94","ee58","en78","er160","ex15","fl13"],
["a_e186","al183","ce145","con97","ea95","ee59","en79","er162","fix1","fr10"],
["a_e187","al184","ce146","con98","ea96","ee60","er163","fr11","ful17","fy12"],
["a_e188","al185","ce147","con99","ea97","en80","er164","fr12","ful18","fy13"],
["a_e189","al186","ce148","ea98","er165","ful19","fy14","ge82","gi14","gl9"],
["al187","ce149","ea99","er166","ge83","gr24","gue5","gy17","i_e100","ic10"],
["al188","ce150","er167","ge84","gr25","gy18","i_e101","ic11","igh23","im22"],
["al189","ce151","er168","ge85","gr26","i_e102","ic12","igh24","im23","in100"],
["er169","ge86","gr28","i_e103","im24","in101","ing84","ir12","ism10","it10"],
["er170","ge87","gr27","i_e104","in102","ing85","it11","lar10","less15","ly64"],
["er171","ge88","i_e105","in103","ing86","it9","lar11","less16","ly65","me7"],
["er172","ge89","i_e106","in104","ing87","lar9","ly66","ment46","mic10","ness15"],
["er173","ge90","i_e107","in105","ing88","ly67","ment47","mic9","nt19","o_e46"],
["ge91","i_e108","in106","ing89","ly68","ment48","mid3","nt20","o_e47","oa25"],
["ge92","i_e110","in107","ing90","ly69","ment49","nt21","o_e48","oa27","oi18"]]

//托福第七張地圖34-1 到34-15探索點
public let map34SyllableSets:[[String]] =
[["ge93","i_e111","in108","ing91","ment50","nt22","o_e49","oa28","oc3","oi19"],
["ge94","i_e112","in96","ing92","ment51","o_e50","oi21","oo44","or103","ou53"],
["i_e113","in97","ing93","ment52","o_e51","oi20","oo45","or104","ou54","ous65"],
["i_e114","in98","ing94","o_e52","oi22","oo46","or105","ou55","ous66","ow43"],
["i_e92","in99","o_e53","oo47","or114","ou57","ous67","ow44","oy6","pe4"],
["i_e93","oo48","or115","ou56","ous68","ow45","oy7","ph29","pl11","ple14"],
["i_e94","or116","ous69","ow46","ph30","ple15","pr31","pt5","qu31","que8"],
["i_e95","or117","ous70","ow47","ph31","ple16","pr32","qu32","re41","ry58"],
["i_e96","or118","ous71","ow48","ph32","pr33","qu33","re42","ry59","set5"],
["i_e97","or119","ous72","pr34","qu34","re43","ry60","sh81","sion42","sis12"],
["i_e98","or120","ous73","pr35","qu35","re44","ry61","sh82","sion43","sis13"],
["i_e99","or121","ous74","pr36","qu36","re45","ry62","sh83","sion44","sis14"],
["or122","ous75","qu37","ry63","sh84","sion45","sis15","sive18","sp21","st64"],
["or123","ry64","sh85","sion46","sis16","sive19","sp22","st65","str19","sym10"],
["or124","ry65","sh86","sion47","sive20","sp23","st66","str20","sym9","th58"]]

//托福第八張地圖35-1 到35-15探索點
public let map35SyllableSets:[[String]] =
[["or125","ry66","sh87","sion48","sive21","st67","ta7","th59","tic36","tion179"],
["or126","ry67","sh88","sion49","sive22","st68","th60","tic37","tion180","tive44"],
["or127","sh89","sion50","sive23","st69","th61","ti3","tic38","tion181","tive45"],
["sh90","sion51","st70","th62","tic39","tion182","tive47","tle10","tr34","ture26"],
["sh91","sive24","st71","th63","tic40","tion183","tive48","tr35","ture27","ty74"],
["sh92","st72","tic41","tion184","tive49","tr36","ture28","ty75","u_e46","ue15"],
["sh93","st73","tic42","tion185","tive50","tr37","ture29","ty76","u_e47","ul6"],
["sh94","st74","tic43","tion186","tive51","tr38","ture30","ty77","u_e48","ul7"],
["tic44","tion187","tive52","tr39","ty78","u_e49","um30","un29","ur27","us9"],
["tic45","tion188","tive53","tr40","u_e50","um31","un30","ur28","us10","ve5"],
["tic46","tion189","ty79","ty80","u_e51","um32","un31","ur29","vo2","wh15"],
["tion190","tion191","tion192","tive54","ty81","u_e52","um33","ur30","wr4","zle3"],
["tion193","tion194","tion195","ty82","ty83","ty84","u_e53","um34","ur31","ur32"],
["tion196","tion197","tion198","tion199","ty85","ty86","ty87","u_e54","u_e55","ur33"],
["tion200","tion201","tion202","tion203","tion204","ty88","ty89","ty90","u_e56","u_e57"]]
