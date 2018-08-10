//
//  NewBookViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/3/15.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit
import TwicketSegmentedControl
import Speech



class NewBookViewController: UIViewController,TwicketSegmentedControlDelegate, UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, AVSpeechSynthesizerDelegate{
    
    
    //所有音節
    var syllableSets = [String]()
    
    let map1SyllableSets:[[String]] = [["a_e98","ab7","ce70","i_e54","ment22","oa15","sh46","tion88","tive19","ty36"],
                                       ["ab8","ac6","ge47","ly35","mic5","my3","nt7","tion96","u_e26","un19"],
                                       ["a_e99","ab9","ac7","ble42","ch54","com23","cr17","ing49","ou38","tion97"],
                                       ["al95","ce78","ci14","dr10","e_e6","ment23","or72","pt2","qu17","tion98"],
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
    
    let map2SyllableSets:[[String]] = [["a_e105","ad11","au19","ax4","ba6","fle2","ge49","is5","tion106","um19"],
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
    
    let map3SyllableSets:[[String]] = [["ce87","ch64","com27","con46","mic6","or76","or77","po5","sion24","tion114"],
                                       ["aw12","com29","con47","cr18","er131","mo4","ou40","sh63","sy2","tion113"],
                                       ["al101","ch75","ck32","com28","con48","cr19","ing52","tion115","u_e29","um20"],
                                       ["ble47","ch65","com30","con49","cr20","er132","ism1","tion116","ty41","ur17"],
                                       ["am15","com31","con50","cr21","er133","ly39","ous30","ry35","tion117","ur18"],
                                       ["a_e110","at23","bt2","ce88","com32","con51","cr22","ing53","ta5","tion118"],
                                       ["a_e111","cl21","com33","con52","cr23","ct14","ea76","ee42","i_e59","o_e30"],
                                       ["a_e112","ce89","com34","con54","cy9","de9","en53","fy4","tion119","tive24"],
                                       ["a_e113","al102","ar55","com35","con53","cr24","en54","qu19","sh64","tion120"],
                                       ["a_e114","com36","con55","de11","er134","i_e60","ment30","tion121","tive25","ty42"],
                                       ["ce90","con56","ct15","de10","dia2","dic2","er135","i_e61","o_e31","tion122"],
                                       ["ce94","con57","de12","ge51","gi7","i_e62","im14","sion25","tion123","u_e30"],
                                       ["ble48","ce91","con58","cy10","de13","dis22","ma5","ous31","tic20","tion24"],
                                       ["a_e115","ch66","con59","de14","di5","dis23","er136","i_e63","sion26","tion125"],
                                       ["aw13","con60","dis24","dr11","ge52","nt9","o_e32","ow36","tic21","ul3"]]
    
    
    let map4SyllableSets:[[String]] = [["con61","dis25","dr12","dw1","ea77","ly40","th40","tion126","tr13","ty43"],
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
    let map5SyllableSets:[[String]] = [["a_e124","fl7","fr6","ing55","or82","ou41","th42","tion137","tion138","ture18"],
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
    
    let map6SyllableSets:[[String]] = [["a_e130","al115","ce100","in71","lar3","ly44","ny5","oi13","ous36","tion144"],
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
    
    let map7SyllableSets:[[String]] = [["ble59","ce105","er147","in86","nt11","op7","set2","sion30","tion153","ur20"],
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
    
    let map8SyllableSets:[[String]] = [["ai38","an48","ar64","ch74","ck38","ow33","pr27","qu25","ry45","tion160"],
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
    
    let map9SyllableSets:[[String]] = [["oo39","or95","re35","sc13","sh52","sl6","tion89","ty61","u_e42","wh13"],
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
    
    
    
    /*
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
    */
    
    /*
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
 
 
 */
 
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
    
    //刪掉數字的音節
    var sylArray = [String]()
    
    //整理過的音節
    var sortedSylArray = [String]()
    
    //選擇到的音節
    var collectionTouched = [Int]()
    
    //上方的seg
    let segControl = TwicketSegmentedControl()
    
    //let darkPurpleColor = UIColor.init(red: 82/255, green: 90/255, blue: 120/255, alpha: 1)
    let darkPurpleColor = UIColor.init(red: 124/255, green: 136/255, blue: 183/255, alpha: 1)
    let segSliderBgColor = UIColor.init(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.25)
    let btnOffColor = UIColor.init(red: 115/255, green: 115/255, blue: 115/255, alpha: 1)
    let btnOnColor = UIColor.init(red: 223/255, green: 223/255, blue: 223/255, alpha: 1)
    
    //table & collection
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var autoPlayImg: UIImageView!
    @IBOutlet weak var autoPlayText: UILabel!
    
    @IBOutlet weak var playSenImg: UIImageView!
    @IBOutlet weak var playSenText: UILabel!
    
    @IBOutlet weak var playTimesText: UILabel!
    @IBOutlet weak var playTimesImg: UIImageView!
    
    @IBOutlet weak var playSpeedImg: UIImageView!
    @IBOutlet weak var playSpeedText: UILabel!
    
    @IBOutlet weak var practiceText: UILabel!
    @IBOutlet weak var practiceImg: UIImageView!
    //所有的單字的array
    var wordSets = [[String]]()
    var sentenceSets = [[String]]()
    
    //殘值的字的array
    var tempWordSets = [[String]]()
    var tempSentenceSets = [[String]]()
    
    //所有背過的單字, 中文, 詞性, 音節, 英文句, 中文句
    var engWordsToShow = [String]()
    var chiWordsToShow = [String]()
    var partOfSpeechToShow = [String]()
    var syllablesToShow = [String]()
    var engSenToShow = [String]()
    var chiSenToShow = [String]()

    var sortedEngWordsToShow = [String]()
      var sortedChiWordsToShow = [String]()
      var sortedPartOfSpeechToShow = [String]()
      var sortedSyllablesToShow = [String]()
      var sortedEngSenToShow = [String]()
      var sortedChiSenToShow = [String]()
    
    //使用者的字群
    var myFavWords = [String]()
    var myWrongWords = [String]()
    
    //指定我的最愛
    var myFavEngWordsToShow = [String]()
    var myFavChiWordsToShow = [String]()
    var myFavPartOfSpeechToShow = [String]()
    var myFavSyllablesToShow = [String]()
    var myFavEngSenToShow = [String]()
    var myFavChiSenToShow = [String]()
    
    var myWrongEngWordsToShow = [String]()
    var myWrongChiWordsToShow = [String]()
    var myWrongPartOfSpeechToShow = [String]()
    var myWrongSyllablesToShow = [String]()
    var myWrongEngSenToShow = [String]()
    var myWrongChiSenToShow = [String]()
    
    var engWordsSelected = [String]()
    var chiWordsSelected = [String]()
    var partOfSpeechSelected = [String]()
    var syllablesSelected = [String]()
    var engSenSelected = [String]()
    var chiSenSelected = [String]()
    
    //我的最愛圖片是否要顯示的array
    var myFavImgs = [Int]()
    
    //之後判斷加入最愛的時刻
    var likeMode = true
    
    //collection選到的index
    var collectionSelectedIndex:Int?
    
    //對應的syllable
    var sylSelected:String?
    
    //播放發音
    //Text to speech合成器
    var synth = AVSpeechSynthesizer()
    
    //發音單字
    var synEngWord = String()
    var synChiWord = String()
    var synEngSen = String()
    var synChiSen = String()
    
    //設定發音次數
    var speakTimes = 1
    //發音速度：0.5標準
    var speakRate = 0.45
    let lightRed = UIColor.init(red: 1, green: 0, blue: 0, alpha: 0.3)
    
    //是否要唸句子
    var isPlaySentence = true
    
    //避免tableView & collectionView戶卡
    var isScrolling = false
    
    //是否連續播放
    var isAutoPlay = false
    
    //endScrolling後才能按collectionView
    var isCollectionViewSelectabel = true
    
    var currentWordIndex = Int()
    
    //目前播放過幾次
    var alreadyPlayTimes = 0
    //發音階段
    var step = 1
    @IBOutlet weak var bookViewBottomBg: UIImageView!
    
    let width =  UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height

    @IBOutlet weak var playSpeedBtn: UIButton!
    @IBOutlet weak var playTimesBtn: UIButton!
    @IBOutlet weak var sentenceBtn: UIButton!
    @IBOutlet weak var practiceBtn: UIButton!
    
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var newBookBg: UIImageView!
    
    
    var dif = CGFloat()
    var cellDif = CGFloat()
    var seperatorDif = CGFloat()
    var fontDif = Int()
    
    
    //所有alertView的變數
    var alertBg = UIImageView()
    var alertText = UILabel()
    var ghostBtn = UIButton()
    var ghost2Btn = UIButton()
    var practiceWordBtn = UIButton()
    var practiceSenBtn = UIButton()
    var leftBtnClickedImg = UIImageView()
    var rightBtnClickedImg = UIImageView()
    let darkRed = UIColor.init(red: 192/255, green: 40/255, blue: 75/255, alpha: 1)
    let orangeColor = UIColor.init(red: 232/255, green: 98/255, blue: 61/255, alpha: 1)

    let wrongPronounceWords:[[String:[String]]] = [["烘焙":["烘陪"]], ["affect":["a fect"]], ["頭髮":["頭法"]], ["campaign":["cam pain"]], ["和":["汗"]], ["woman":["wo men"]], ["snowman":["snow man"]], ["fisherman":["fisher man"]], ["gentleman":["gentle man"]], ["supermarket":["super market"]], ["劣拙地":["列濁地"]], ["begin":["be ghing"]], ["巧克力":["巧顆粒"]], ["lead":["leed"]], ["tear":["tee er"]], ["度數":["度樹"]], ["年紀較長的":["年紀較漲的"]], ["告訴":["吿速"]], ["envelope":["anvelope"]], ["sensor":["sen sir"]], ["友誼":["有宜"]], ["kilometer":["killa meter"]], ["桶子":["統子"]], ["油炸":["油柵"]], ["外框":["外筐"]], ["高麗菜":["高力菜"]], ["油炸的":["油柵的"]], ["磨坊":["魔訪"]], ["螫":["遮"]], ["kneepad":["knee pad"]], ["iron":["eye ern"]], ["歌曲":["哥取"]], ["鵝":["蛾"]], ["forehead":["fore head"]], ["數":["鼠"]], ["April":["eigh pro"]], ["重播":["蟲剝"]], ["槳糊":["降胡"]], ["stupid":["stubid"]], ["錫":["習"]], ["曲線":["娶線"]], ["風箏":["風蒸"]], ["comb":["kome"]], ["wolf":["wallf"]], ["absurd":["a bsurd"]]]
    
    var courseReceived = Int()
    
    var syllableGroup = [[[String()]]]
    var mapPassedInt:Int?
    var gamePassedDic:[Int:Int]?
    var increaseNum = Int()
    
    var maxMapNum = Int()
    var maxSpotNum = Int()
    
    var isAllEmpty = true
    
    var xDif = CGFloat()
    
    
    
    var wordsToAddToFav = [String]()
    var wordsToDeleteInFav = [String]()
    var wordsToDeleteInWrong = [String]()

    
    var favAddedLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var iPadSmall = CGFloat()
 
        switch height {
        case 812:
            
            seperatorDif = 1.1
            dif = 1.35
            cellDif = 1.2
            fontDif = 0
            xDif = 50
            iPadSmall = 0
            
        case 736:
            seperatorDif = 1.1
            dif = 1.1
            cellDif = 1.1
            fontDif = 3
            xDif = 0
            iPadSmall = 0
        case 667:
            
            seperatorDif = 1
            dif = 1
            cellDif = 1
            fontDif = 4
            xDif = 0
            iPadSmall = 0
        case 568:
            seperatorDif = 0.9
            dif = 0.9
            cellDif = 0.9
            fontDif = 5
            xDif = 0
            iPadSmall = 0
        default:
            seperatorDif = 0.9
            dif = 0.9
            cellDif = 0.9
            fontDif = 5
            xDif = 0
            iPadSmall = 10
            
            
        }
        
        
        print("courseReceived\(courseReceived)")
        
        switch courseReceived{
            
        case 0:
            syllableGroup.append(map1SyllableSets)
            syllableGroup.append(map2SyllableSets)
            syllableGroup.append(map3SyllableSets)
            syllableGroup.append(map4SyllableSets)
            syllableGroup.append(map5SyllableSets)
            mapPassedInt = mapPassed
            gamePassedDic = gamePassed
            increaseNum = 0
            maxMapNum = 5
            maxSpotNum = 14
            
        
        case 1:
            syllableGroup.append(map6SyllableSets)
            syllableGroup.append(map7SyllableSets)
            syllableGroup.append(map8SyllableSets)
            syllableGroup.append(map9SyllableSets)
            syllableGroup.append(map10SyllableSets)
            syllableGroup.append(map11SyllableSets)
            
            mapPassedInt = mapPassed2
            gamePassedDic = gamePassed2
            increaseNum = 5
            maxMapNum = 6
            maxSpotNum = 14
            
            
            
        case 2:
            syllableGroup.append(map12SyllableSets)
            syllableGroup.append(map13SyllableSets)
            syllableGroup.append(map14SyllableSets)
            syllableGroup.append(map15SyllableSets)
            syllableGroup.append(map16SyllableSets)
            syllableGroup.append(map17SyllableSets)
            syllableGroup.append(map18SyllableSets)

            
            mapPassedInt = mapPassed3
            gamePassedDic = gamePassed3
            increaseNum = 11
            maxMapNum = 7
            maxSpotNum = 14
            
        default:
            break
      
        }
        
        //加入alertView
       
        let lightGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.58)
        ghostBtn.frame = CGRect(x: 0, y: 0, width: width, height: height)
        ghostBtn.backgroundColor = lightGray
        //ghostBtn.addTarget(self, action: #selector(NewBookViewController.removeBtns), for: .touchUpInside)
        self.view.addSubview(ghostBtn)
        
        alertBg.frame = CGRect(x: (width - 237 * dif) / 2 + xDif, y: height * 2 /  5, width: width * 237 / 375, height: height * 140 / 667)
        alertBg.image = UIImage(named: "reviewQuitBg3.png")
        self.view.addSubview(alertBg)
        
        ghost2Btn.frame = CGRect(x: (width - 237 * dif) / 2, y: height * 2 /  5, width: width * 237 / 375, height: height * 140 / 667)
        self.view.addSubview(ghost2Btn)
        
        alertText.frame = CGRect(x: 5 * dif , y: 15 * dif, width: alertBg.frame.width - 5 * dif * 2, height: alertBg.frame.height / 2)
        alertText.font = UIFont(name: "Helvetica Bold", size: 16)
        alertText.textColor = .white
        alertText.text = "選擇練習模式"
        alertText.numberOfLines = 0
        alertText.textAlignment = .center
        alertText.adjustsFontSizeToFitWidth = true
        alertBg.addSubview(alertText)
        
        
        practiceWordBtn.frame = CGRect(x: alertBg.frame.minX, y: alertBg.frame.maxY - 40 * cellDif + iPadSmall, width: alertBg.frame.width, height: height * 44 / 667)
   
        practiceWordBtn.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 16)
        practiceWordBtn.setTitle("我知道了", for: .normal)
        practiceWordBtn.setTitleColor(orangeColor, for: .normal)
        practiceWordBtn.addTarget(self, action: #selector(NewBookViewController.practiceWord), for: .touchUpInside)
        self.view.addSubview(practiceWordBtn)
        
        /*
        practiceSenBtn.frame = CGRect(x: practiceWordBtn.frame.maxX, y: alertBg.frame.maxY - 44 * dif, width: alertBg.frame.width / 2, height: height * 44 / 667)
        practiceSenBtn.setTitle("複習句型", for: .normal)
        practiceSenBtn.setTitleColor(darkRed, for: .normal)
        practiceSenBtn.addTarget(self, action: #selector(NewBookViewController.practiceSen), for: .touchUpInside)
        self.view.addSubview(practiceSenBtn)
*/
        
        
        leftBtnClickedImg.frame = practiceWordBtn.frame
        leftBtnClickedImg.image = UIImage(named: "leftBtnClickedImg.png")
        
        rightBtnClickedImg.frame = practiceSenBtn.frame
        rightBtnClickedImg.image = UIImage(named: "rightBtnClickedImg.png")
        
        self.view.addSubview(leftBtnClickedImg)
        self.view.addSubview(rightBtnClickedImg)
        leftBtnClickedImg.alpha = 0
        rightBtnClickedImg.alpha = 0
        

        // Do any additional setup after loading the view.
        //layOut
        newBookBg.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
         backBtn.frame = CGRect(x: width / 14, y: width / 10, width: 19, height: 31)
        
        //設定好segMent
        segControl.frame = CGRect(x: backBtn.frame.maxX, y: backBtn.frame.minY,width: width - backBtn.frame.width * 4, height: 30 * dif)
        self.view.addSubview(segControl)
        
        collectionView.frame = CGRect(x: backBtn.frame.minX, y: segControl.frame.maxY + 5 * dif, width: width - (backBtn.frame.minX * 2), height: height / 3.2)
        tableView.frame = CGRect(x: 0, y: collectionView.frame.maxY, width: width, height: height - collectionView.frame.maxY - 66 * dif)
        
        bookViewBottomBg.frame = CGRect(x: 0, y: tableView.frame.maxY, width: width, height: 66 * dif)
        
        playBtn.frame = CGRect(x: 0, y: tableView.frame.maxY, width: width / 4, height: 66 * dif)
        //playBtn.backgroundColor = .red
        
        //autoPlayImg.frame = CGRect(x: (width / 5 - 23 * dif) / 2, y: bookViewBottomBg.frame.minY + 12 * dif, width: 23 * dif, height: 23 * dif)
        
        autoPlayImg.center = CGPoint(x: playBtn.frame.midX, y: bookViewBottomBg.frame.midY - 12 * dif)
        autoPlayImg.frame.size = CGSize(width: 23 * dif, height: 23 * dif)
        
        //autoPlayText.frame = CGRect(x:(width / 5 - 72 * dif) / 2, y: height - 21 * 1.2 * dif, width: 72 * dif , height: 21 * dif)
       autoPlayText.frame.size = CGSize(width: 72 * dif , height: 21 * dif)
        autoPlayText.center = CGPoint(x: playBtn.frame.midX, y: height - 11 * 1.2 * dif)
        
        sentenceBtn.frame = CGRect(x: playBtn.frame.maxX, y: tableView.frame.maxY, width: width / 4, height: 66 * dif)
       
        //sentenceBtn.backgroundColor = .green
        
        //playSenImg.frame = CGRect(x: width / 5 + (width / 5 - 27 * dif) / 2 ,y: bookViewBottomBg.frame.minY + 12 * dif, width: 27 * dif, height: 23 * dif)
        
        playSenImg.center = CGPoint(x: sentenceBtn.frame.midX, y: bookViewBottomBg.frame.midY - 12 * dif)
        playSenImg.frame.size = CGSize(width: 27 * dif, height: 23 * dif)
       
        //playSenText.frame = CGRect(x: width / 5 + (width / 5 - 79 * dif) / 2, y: height - 21 * 1.2 * dif, width: 79 * dif , height: 21 * dif)
        playSenText.frame.size = CGSize(width: 79 * dif , height: 21 * dif)
        playSenText.center = CGPoint(x: sentenceBtn.frame.midX, y: height - 11 * 1.2 * dif)
        
        playTimesBtn.frame = CGRect(x: sentenceBtn.frame.maxX, y: tableView.frame.maxY, width: width / 4, height: 66 * dif)
       
        //playTimesBtn.backgroundColor = .yellow
        
        //playTimesImg.frame = CGRect(x: width * 2 / 5 + (width / 5 - 46 * dif) / 2, y: bookViewBottomBg.frame.minY + 18 * dif, width: 46 * dif, height: 8 * dif)
        
        playTimesImg.center = CGPoint(x: playTimesBtn.frame.midX, y: bookViewBottomBg.frame.midY - 11 * dif)
        playTimesImg.frame.size = CGSize(width: 46 * dif, height: 8 * dif)
        
        
        //playTimesText.frame = CGRect(x: width * 2 / 5 + (width / 5 - 76 * dif) / 2, y: height - 21 * 1.2 * dif, width: 76 * dif, height: 21 * dif)
        playTimesText.frame.size = CGSize(width: 76 * dif, height: 21 * dif)
        playTimesText.center = CGPoint(x: playTimesBtn.frame.midX, y: height - 11 * 1.2 * dif)
        
        playSpeedBtn.frame = CGRect(x: playTimesBtn.frame.maxX, y: tableView.frame.maxY, width: width / 4, height: 66 * dif)
        
        //playSpeedBtn.backgroundColor = .purple
        
        playSpeedImg.frame = CGRect(x: width * 3 / 5 + (width / 5 - 44 * dif) / 2, y: bookViewBottomBg.frame.minY + 12 * dif, width: 44 * dif, height: 28 * dif)
        
        
        playSpeedImg.center = CGPoint(x: playSpeedBtn.frame.midX, y: bookViewBottomBg.frame.midY - 11 * dif)
        playSpeedImg.frame.size = CGSize(width: 44 * dif, height: 28 * dif)
        
        
        
        playSpeedText.frame = CGRect(x: width * 3 / 5 + (width / 5 - 76 * dif) / 2, y:  height - 21 * 1.2 * dif, width: 76 * dif, height: 21 * dif)
        playSpeedText.frame.size = CGSize(width: 76 * dif, height: 21 * dif)
        playSpeedText.center = CGPoint(x: playSpeedBtn.frame.midX, y: height - 11 * 1.2 * dif)
        
        /*
        practiceBtn.frame = CGRect(x: playSpeedBtn.frame.maxX, y: tableView.frame.maxY, width: width / 5, height: 66 * dif)
        
        practiceImg.frame = CGRect(x: width * 4 / 5 + (width / 5 - 24 * dif) / 2, y: bookViewBottomBg.frame.minY + 12 * dif, width: 24 * dif, height: 24 * dif)
        
        practiceText.frame = CGRect(x: width * 4 / 5 + (width / 5 - 76 * dif) / 2, y:  height - 21 * 1.2 * dif, width: 76 * dif, height: 21 * dif)
        */
        
        practiceBtn.isHidden = true
        practiceImg.isHidden = true
        practiceText.isHidden = true
        
        /*
        playBtn.backgroundColor = .green
        sentenceBtn.backgroundColor = .red
        playTimesBtn.backgroundColor = .green
        playSpeedBtn.backgroundColor = .red
        
        collectionView.backgroundColor = .red
        */
        //設定delegate來監控讀音
        synth.delegate = self
        
        let titles = ["正確單字", "錯誤單字", "最愛單字"]
        segControl.setSegmentItems(titles)
        segControl.backgroundColor = .clear
        segControl.sliderBackgroundColor = segSliderBgColor
        segControl.segmentsBackgroundColor = .clear
        segControl.defaultTextColor = darkPurpleColor
        segControl.highlightTextColor = .white
        segControl.isSliderShadowHidden = true
        
        //所有的delegate
        segControl.delegate = self
        collectionView.delegate = self
        tableView.delegate = self
        tableView.isUserInteractionEnabled = true
        
        collectionView.backgroundColor = .clear
        tableView.backgroundColor = .clear
        
        let bgImg = UIImage(named:"wordTableBg.png")
        tableView.backgroundView = UIImageView(image: bgImg)
        tableView.separatorColor = UIColor.init(red: 215/255, green: 217/255, blue: 226/255, alpha: 1)
        tableView.separatorInset = .init(top: 0, left: 50 * seperatorDif, bottom: 0, right: 70)
        
        //設定Btn顏色狀態
        autoPlayText.textColor = btnOffColor
        playSenText.textColor = btnOffColor
        playTimesText.textColor = btnOnColor
        playTimesImg.image = UIImage(named:"bookTimes0.png")
        playSpeedImg.image = UIImage(named:"bookSpeed0.png")
        playSpeedText.textColor = btnOffColor
        playSenText.textColor = btnOnColor
        playSenImg.image = UIImage(named:"bookSenOn.png")
        
        
        favAddedLabel.frame = CGRect(x: (width - width * 0.8) / 2 , y: height / 2, width: width * 0.8, height: 50)
        favAddedLabel.adjustsFontSizeToFitWidth = true
        favAddedLabel.textColor = .white
        favAddedLabel.backgroundColor = .black
        favAddedLabel.clipsToBounds = true
        favAddedLabel.layer.cornerRadius = favAddedLabel.frame.width / 15
        favAddedLabel.font = UIFont(name: "Helvetica Bold", size: 20)
        favAddedLabel.textAlignment = .center
        favAddedLabel.numberOfLines = 2
        favAddedLabel.alpha = 0
        self.view.addSubview(favAddedLabel)
        self.view.bringSubview(toFront: favAddedLabel)
        
        
        //歸類所有syllable
        
        syllableGroup.removeFirst()
        
        for groupSet in syllableGroup{
            
            for group in groupSet{
                
                for syl in group{
                    
                    syllableSets.append(syl)
                    
                }
            }
        }
 

  
        
        //讀取所有syl, 排除相同的再次出現
        for syl in syllableSets{
 
     
                let sylBreaks = syl.components(separatedBy: NSCharacterSet.decimalDigits)
                let sylOnlyText = sylBreaks[0]
                
              //  if !sylArray.contains(sylOnlyText){
                    
                    sylArray.append(sylOnlyText)
               // }
            
            if !sortedSylArray.contains(sylOnlyText){
                
                
                sortedSylArray.append(sylOnlyText)
            }
            
        }
        
        
        
        //建立collectionView按鈕數量
        for _ in 0 ..< sortedSylArray.count{
            
         
            collectionTouched.append(0)
            
        }
        
        //預設第一個元素
        collectionTouched[0] = 1
        
        //讀取已過地圖
        //mapPassed = 1
        
        //spot & unit, 當下已過的地圖裡的關卡數字
        //gamePassed = [0:0]
        
        /*
        print("book mapPassed:\(mapPassed!)")
        print("book gamPassed:\(gamePassed!)")
        */
        //所有已過關的地圖字都要抓進去
        
        
        if mapPassedInt == maxMapNum{
            
            //在這裡 -1 後面要加回來
            mapPassedInt! -= 1
            gamePassedDic = [maxSpotNum:9]
        }
        
        
        
        
        
        for m in 0 ..< mapPassedInt!{
            //要讀取裡面的全部
    
       
            //讀取已完整的所有字集 + 句子
            //print("m:\(m)")
            //目前設置15的原因因為所有探索點都有15個, 若之後不同課程有不同的探索點數, 要抓動態探索點數字
            
            
            //在此要加上increaseNum才能抓到正確的檔案
            
            for i in 0 ..< 15{
                
                var wordFile:String?
                //前面的1代表第一張地圖
                let name = String(m + increaseNum + 1) + "-" + String(i + 1)
                let sName = "s\(String(m + increaseNum + 1))-" + String(i + 1)
            
                
                //抓字
                if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
                    do {
                        wordFile = try String(contentsOfFile: filepath)
                        let words = wordFile?.components(separatedBy: "; ")
                        
                        //把字讀取到wordSets裡
                        wordSets.append(words!)
                        //print(contents)
                        
                    } catch {
                        // contents could not be loaded
                    }
                } else {
                    // example.txt not found!
                }
                
                var sentenceFile:String?
                
                //抓句子
                if let filepath = Bundle.main.path(forResource: sName, ofType: "txt") {
                    do {
                        sentenceFile = try String(contentsOfFile: filepath)
                        let words = sentenceFile?.components(separatedBy: "; ")
                        
                        //把字讀取到wordSets裡
                        sentenceSets.append(words!)
                        //print(contents)
                        
                    } catch {
                        // contents could not be loaded
                    }
                } else {
                    // example.txt not found!
                }
                
            }
        
        }
        
        
        //接著抓目前最新開放地圖裡的完成字 + 殘字
        for (s,_) in gamePassedDic!{
  
            
            
            //讀取已完整的所有字集 + 句子
            for i in 0 ..< (s){
                

                var wordFile:String?
                //前面的1代表第一張地圖
                
                //裡面的檔名也要加上increaseNum
                let name = String(describing: mapPassedInt! + increaseNum + 1) + "-" + String(i + 1)
                let sName = "s\(String(describing: mapPassedInt! + increaseNum + 1))-" + String(i + 1)
                
                //抓字
                if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
                    do {
                        wordFile = try String(contentsOfFile: filepath)
                        let words = wordFile?.components(separatedBy: "; ")
                        
                        //把字讀取到wordSets裡
                        wordSets.append(words!)
                        //print(contents)
                        
                    } catch {
                        // contents could not be loaded
                    }
                } else {
                    // example.txt not found!
                }
                
                var sentenceFile:String?
                
                //抓句子
                if let filepath = Bundle.main.path(forResource: sName, ofType: "txt") {
                    do {
                        sentenceFile = try String(contentsOfFile: filepath)
                        let words = sentenceFile?.components(separatedBy: "; ")
                        
                        //把字讀取到wordSets裡
                        sentenceSets.append(words!)
                        //print(contents)
                        
                    } catch {
                        // contents could not be loaded
                    }
                } else {
                    // example.txt not found!
                }
                
            }
            
            //再來讀取殘餘的英文字 + 句子
            var wordFile:String?

            //讀取最新一層的字
            
            //檔名要加上increaseNum
            let name = String(describing: mapPassedInt! + increaseNum + 1) + "-" + String(s + 1)
            let sName = "s\(String(describing: mapPassedInt! + increaseNum + 1))-" +  String(s + 1)
            
            if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
                do {
                    wordFile = try String(contentsOfFile: filepath)
                    let words = wordFile?.components(separatedBy: "; ")
                    
                    //把字讀取到wordSets裡
                    tempWordSets.append(words!)
                    //print(contents)
                    
                } catch {
                    // contents could not be loaded
                }
            } else {
                // example.txt not found!
            }
            
            
            
            var sentenceFile:String?
            
            //抓句子
            if let filepath = Bundle.main.path(forResource: sName, ofType: "txt") {
                do {
                    sentenceFile = try String(contentsOfFile: filepath)
                    let words = sentenceFile?.components(separatedBy: "; ")
                    
                    //把字讀取到wordSets裡
                    tempSentenceSets.append(words!)
                    //print(contents)
                    
                } catch {
                    // contents could not be loaded
                }
            } else {
                // example.txt not found!
            }
            
        }
        
        
        //抓所有單字
        //Part 1. 抓完整值
        
        //抓單字
        for i in 0 ..< wordSets.count{
            
           
            for w in 0 ..< 30{
                
                engWordsToShow.append(wordSets[i][w])
                
                //抓出正確的順序
                let syllableSequence = Int(i * 10) +  Int(w / 3)
                syllablesToShow.append(sylArray[syllableSequence]) //[i]
                
            }
            
            for c in 30 ..< 60{
                

                chiWordsToShow.append(wordSets[i][c])
            }
            
            for p in 60 ..< 90{
                

                partOfSpeechToShow.append(wordSets[i][p])
            }
            
        }
        
        //抓完整句子
        for i in 0 ..< sentenceSets.count{

           
            for e in 0 ..< 30{

                engSenToShow.append(sentenceSets[i][e])
                
            }
            
            for c in 30 ..< 60{
     
                chiSenToShow.append(sentenceSets[i][c])
            }
            
        }
        
        //Part 2. 抓殘值 ＆ 抓可能出現錯字的最新三個
        
        
        //* * * 抓已append完的音節數量, 之後殘值以此數量append
        let sequence = Int(syllablesToShow.count / 3)
        
        for (_,g) in gamePassedDic!{
            

            
            for w in 0 ..< ((g + 1) * 3){
                
                
                engWordsToShow.append(tempWordSets[0][w])
    
                let syllableSequence = sequence + Int(w / 3)

                syllablesToShow.append(sylArray[syllableSequence]) //[s]
                
                engSenToShow.append(tempSentenceSets[0][w])
                
                
            }
            
            for w in 30 ..< (30 + (g + 1) * 3){
                
            
                chiWordsToShow.append(tempWordSets[0][w])
                
                chiSenToShow.append(tempSentenceSets[0][w])
           
            }
            
            for w in 60 ..< (60 + (g + 1) * 3){
                
            
                partOfSpeechToShow.append(tempWordSets[0][w])
           
            }
            
        }
        
        
        //這部分之後要分course類了
        //載入我的最愛單字
        if let myWordsString = user?["myWords"] as! String?{
            myFavWords = myWordsString.components(separatedBy: ";")
        }
        
        //載入我的錯誤單字
        if let myWrongWordsString = user?["wrongWords"] as! String?{
            myWrongWords = myWrongWordsString.components(separatedBy: ";")
            
        }
        
        //填入所有字的數量, 等等準備抓我的最愛的部分
        for _ in 0 ..< engWordsToShow.count - 3{

            myFavImgs.append(0)
        }
        
        //兩個音節做比對, 抓新字的順序
        for s in 0 ..< sortedSylArray.count{

            
            for i in 0 ..< sylArray.count{

                
                if sortedSylArray[s] == sylArray[i]{
                    
                    
                    for n in 0 ..< 3 {

                        
                        //音節過多, 單字不夠多所以要確認數量
                        if engWordsToShow.count > ((i * 3) + n){
                        
                        sortedEngWordsToShow.append(engWordsToShow[(i * 3) + n])
                        sortedChiWordsToShow.append(chiWordsToShow[(i * 3) + n])
                        sortedPartOfSpeechToShow.append(partOfSpeechToShow[(i * 3) + n])
                        sortedSyllablesToShow.append(syllablesToShow[(i * 3) + n])
                        sortedEngSenToShow.append(engSenToShow[(i * 3) + n])
                        sortedChiSenToShow.append(chiSenToShow[(i * 3) + n])
                      
                        }
                        
                    }
                    
                }
                
            }
            
        }
        print("sorted:\(sortedEngWordsToShow.count)")
        print("notSorted:\(engWordsToShow.count)")
       
        //從所有的單字裡去找match到的我的最愛單字
        for i in 0 ..< sortedEngWordsToShow.count{
            
            //這個完整字沒有拆音節
            let word = sortedEngWordsToShow[i].replacingOccurrences(of: " ", with: "")
            let chiWord = sortedChiWordsToShow[i]
            let partOfSpeech = sortedPartOfSpeechToShow[i]
            let syllables = sortedSyllablesToShow[i]
            //這個字才有拆音節
            let wordToAppend = sortedEngWordsToShow[i]
            let engSenToAppend = sortedEngSenToShow[i]
            let chiSenToAppend = sortedChiSenToShow[i]
            
            for myWord in myFavWords{
                
                if myWord == word {

                    myFavEngWordsToShow.append(wordToAppend)
                    myFavChiWordsToShow.append(chiWord)
                    myFavPartOfSpeechToShow.append(partOfSpeech)
                    myFavSyllablesToShow.append(syllables)
                    myFavEngSenToShow.append(engSenToAppend)
                    myFavChiSenToShow.append(chiSenToAppend)
                    
                    //抓全部單字要反紅的部分
                    //myFavImgs[i] = 1
                    
                }
                
            }
            
            //抓我的錯字
            for myWrongWord in myWrongWords{
                
                if myWrongWord == word {
                    
                    myWrongEngWordsToShow.append(wordToAppend)
                    myWrongChiWordsToShow.append(chiWord)
                    myWrongPartOfSpeechToShow.append(partOfSpeech)
                    myWrongSyllablesToShow.append(syllables)
                    myWrongEngSenToShow.append(engSenToAppend)
                    myWrongChiSenToShow.append(chiSenToAppend)
                    
                }
                
            }
            
        }
        
        //設定好要show的第一組單字就是全部的單字
        engWordsSelected = sortedEngWordsToShow
        chiWordsSelected = sortedChiWordsToShow
        partOfSpeechSelected = sortedPartOfSpeechToShow
        syllablesSelected = sortedSyllablesToShow
        engSenSelected = sortedEngSenToShow
        chiSenSelected = sortedChiSenToShow
        
        //移除三個多增加的數量, 這三個是可能會錯的部分?? 為什麼只移除engWordsSelected..應該是因為這樣return cell就直接少三個
        
      
        if (mapPassedInt! + 1) != maxMapNum{
            
            print("要移除三個")
        
        for  _ in 0 ..< 3 {
            
            engWordsSelected.removeLast()
        }
            
            
        }
        //預設collectionView的syl
        collectionSelectedIndex = 0
        
        //拉到最前方
        self.view.bringSubview(toFront: ghostBtn)
        self.view.bringSubview(toFront: alertBg)
        self.view.bringSubview(toFront: ghost2Btn)
        self.view.bringSubview(toFront: practiceWordBtn)
        self.view.bringSubview(toFront: practiceSenBtn)
        self.view.bringSubview(toFront: leftBtnClickedImg)
        self.view.bringSubview(toFront: rightBtnClickedImg)
        
        removeBtns()
        
        
        //預設值
        alertTextShown = "\n此課程尚未學習任何單字\n單字集還是空的喔!"
        
    }
    
    
    deinit {
        print("book deinit")
    }
    
    @objc func removeBtns(){
        
        
        
        ghostBtn.isHidden = true
        alertBg.isHidden = true
        ghost2Btn.isHidden = true
        practiceWordBtn.isHidden = true
        practiceSenBtn.isHidden = true
        leftBtnClickedImg.isHidden = true
        rightBtnClickedImg.isHidden = true
 
 
    }
    
    @objc func practiceWord(){
        print("practice word")
        
        //self.dismiss(animated: false, completion: nil)
  
        
        UIView.animate(withDuration: 0.06, animations: {[weak self] in
            
            self!.leftBtnClickedImg.alpha = 1
           
            
        }) {[weak self] (finished:Bool) in
            
            
            if finished {
                self!.leftBtnClickedImg.alpha = 0
        
                self!.removeBtns()
                //self!.isAlertPoppedOut = false
            }
        }
        
        
    }
    
    @objc func practiceSen(){
        print("practice Sen")
        
        
        UIView.animate(withDuration: 0.06, animations: {[weak self] in
            
            self!.rightBtnClickedImg.alpha = 1
            
            
        }) {[weak self] (finished:Bool) in
            
            
            if finished {
                self!.rightBtnClickedImg.alpha = 0
                
            }
        }
        
        
    }
    
    
    
    //addToFav animation
    
    func addToFavAnimation(word:String){
        
        favAddedLabel.text = "\(word)\n已新增至最愛"
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {[weak self] in
            self!.favAddedLabel.alpha = 1
            self!.favAddedLabel.frame.origin.y -= 20
        
        
        }) {[weak self] (finished:Bool) in
            
            UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveLinear, animations: {
                self!.favAddedLabel.alpha = 0
            }, completion: {[weak self] (finished:Bool) in
                
                self!.favAddedLabel.frame.origin.y += 20
                
                
                
            })
            
            
            
        }
        
        
        
    }
    
    //再次載入所有單字裡我的最愛要反紅的字, 使用時機: 在我的最愛裡修改過後跳回所有單字
    //顯示是否有加入最愛先不要做
    func loadAllWordFavs(){
        
        
        
        
        alertTextShown = "\n此課程尚未學習任何單字\n單字集還是空的喔!"
        
        //載入我的最愛單字
        if let myWordsString = user?["myWords"] as! String?{
            myFavWords = myWordsString.components(separatedBy: ";")
        }
        
        
        /*
        myFavImgs.removeAll(keepingCapacity: false)
        
        //填入所有字的數量, 等等準備抓我的最愛的部分
        for _ in 0 ..< engWordsToShow.count - 3{
            myFavImgs.append(0)
            
        }
        */
        //去對有沒有符合我的最愛然後將其反紅
        /*
        for i in 0 ..< engWordsToShow.count{
            
            let word = engWordsToShow[i].replacingOccurrences(of: " ", with: "")
            
            for myWord in myFavWords{
                
                if myWord == word {
                    
                    //抓全部單字要反紅的部分
                    //myFavImgs[i] = 1
                    
                }
                
            }
            
        }
        */
    }
    
    
    
    var laterSaveMyFav = [String]()
    
    //讀取我的最愛的單字, 使用時機: (1) 在我的最愛裡刪除最愛單字, 做即時反應 (2) 其他時候跳轉到我的最愛畫面時
    func loadMyFavWords(){
        
        
        alertTextShown = "\n此課程還沒加任何字\n到我的最愛!"
        
        //載入我的最愛單字
        if let myWordsString = user?["myWords"] as! String?{
            myFavWords = myWordsString.components(separatedBy: ";")
        }
        
        
        //刪除所有已append的值
        myFavEngWordsToShow.removeAll(keepingCapacity: false)
        myFavChiWordsToShow.removeAll(keepingCapacity: false)
        myFavPartOfSpeechToShow.removeAll(keepingCapacity: false)
        myFavSyllablesToShow.removeAll(keepingCapacity: false)
        myFavEngSenToShow.removeAll(keepingCapacity: false)
        myFavChiSenToShow.removeAll(keepingCapacity: false)
       // myFavImgs.removeAll(keepingCapacity: false)
        
        
        //所有單字反紅
        /*
        for _ in 0 ..< myFavWords.count{
            
            myFavImgs.append(1)
            
        }
        */
        
        //把臨時的加入myFavWord裡
        
 
        
        //以所有的單字來match我的最愛單字的資訊
        for i in 0 ..< sortedEngWordsToShow.count{
            
            //做比對使用
            let word = sortedEngWordsToShow[i].replacingOccurrences(of: " ", with: "")
            
            
            for myWord in myFavWords{
                
                if myWord == word && !tempFavWordsToDelete.contains(myWord) {
                    
                    let chiWord = sortedChiWordsToShow[i]
                    let partOfSpeech = sortedPartOfSpeechToShow[i]
                    let syllables = sortedSyllablesToShow[i]
                    let wordToAppend = sortedEngWordsToShow[i]
                    let engSenToAppend = sortedEngSenToShow[i]
                    let chiSenToAppend = sortedChiSenToShow[i]
                    
                    myFavEngWordsToShow.append(wordToAppend)
                    myFavChiWordsToShow.append(chiWord)
                    myFavPartOfSpeechToShow.append(partOfSpeech)
                    myFavSyllablesToShow.append(syllables)
                    myFavEngSenToShow.append(engSenToAppend)
                    myFavChiSenToShow.append(chiSenToAppend)
                    
                    
                }
                
            }
            
            
        }
        
        //目前機制 先看delete完再看add就是正確
        for temp in tempMyFav {
            
            
            for fav in myFavWords{
                
                
                if temp == fav && !tempFavWordsToDelete.contains(temp){
                    
                    
                    tempMyFav = tempMyFav.filter { $0 != temp }
                }
                
            }
            
            
        }



        //以所有的單字來match我的最愛單字的資訊
        for i in 0 ..< sortedEngWordsToShow.count{
            
            //做比對使用
            let word = sortedEngWordsToShow[i].replacingOccurrences(of: " ", with: "")
            
            
            for myWord in tempMyFav{
                
                if myWord == word {
                    
                    let chiWord = sortedChiWordsToShow[i]
                    let partOfSpeech = sortedPartOfSpeechToShow[i]
                    let syllables = sortedSyllablesToShow[i]
                    let wordToAppend = sortedEngWordsToShow[i]
                    let engSenToAppend = sortedEngSenToShow[i]
                    let chiSenToAppend = sortedChiSenToShow[i]
                    
                    myFavEngWordsToShow.append(wordToAppend)
                    myFavChiWordsToShow.append(chiWord)
                    myFavPartOfSpeechToShow.append(partOfSpeech)
                    myFavSyllablesToShow.append(syllables)
                    myFavEngSenToShow.append(engSenToAppend)
                    myFavChiSenToShow.append(chiSenToAppend)
                    
                    
                }
                
            }
            
            
        }

        


        
        
        //選擇好要show的單字
        engWordsSelected = myFavEngWordsToShow
        chiWordsSelected = myFavChiWordsToShow
        partOfSpeechSelected = myFavPartOfSpeechToShow
        syllablesSelected = myFavSyllablesToShow
        engSenSelected = myFavEngSenToShow
        chiSenSelected = myFavChiSenToShow
        
        //不產生動畫的reload
        tableView.reloadData()
 
        findMatchCollectionCell()
        
    }
    
    
    
    //載入錯誤單字, 使用時機: 移除錯誤單字即時顯示使用
    func loadMyWrongWords(){
        
        alertTextShown = "\n此課程到目前為止\n無任何錯字!"
        
        //載入我的錯誤單字
        if let myWrongWordsString = user?["wrongWords"] as! String?{
            myWrongWords = myWrongWordsString.components(separatedBy: ";")
            
        }
        
        myWrongEngWordsToShow.removeAll(keepingCapacity: false)
        myWrongChiWordsToShow.removeAll(keepingCapacity: false)
        myWrongPartOfSpeechToShow.removeAll(keepingCapacity: false)
        myWrongSyllablesToShow.removeAll(keepingCapacity: false)
        myWrongEngSenToShow.removeAll(keepingCapacity: false)
        myWrongChiSenToShow.removeAll(keepingCapacity: false)
        
        print(myWrongWords.count)
        
        for i in 0 ..< sortedEngWordsToShow.count{
            
            let word = sortedEngWordsToShow[i].replacingOccurrences(of: " ", with: "")
            
                for myWrongWord in myWrongWords{
                    
                     if myWrongWord == word && !tempWrongWordsToDelete.contains(myWrongWord){
                    
                    
                    let chiWord = sortedChiWordsToShow[i]
                    let partOfSpeech = sortedPartOfSpeechToShow[i]
                    let syllables = sortedSyllablesToShow[i]
                    let wordToAppend = sortedEngWordsToShow[i]
                    let engSenToAppend = sortedEngSenToShow[i]
                    let chiSenToAppend = sortedChiSenToShow[i]
                    
                    myWrongEngWordsToShow.append(wordToAppend)
                    myWrongChiWordsToShow.append(chiWord)
                    myWrongPartOfSpeechToShow.append(partOfSpeech)
                    myWrongSyllablesToShow.append(syllables)
                    myWrongEngSenToShow.append(engSenToAppend)
                    myWrongChiSenToShow.append(chiSenToAppend)
                    }
                }

            
            
        /*
            
            //抓我的錯字
            for myWrongWord in myWrongWords{
                
                //排除暫時刪除的字
      //          for temp in tempWrongWordsToDelete{
                
                
                if myWrongWord == word {
                    
                    if tempWrongWordsToDelete.count > 0 {
                    
                    for temp in tempWrongWordsToDelete {
                        
                        if myWrongWord != temp {
                            
                            
                            let chiWord = sortedChiWordsToShow[i]
                            let partOfSpeech = sortedPartOfSpeechToShow[i]
                            let syllables = sortedSyllablesToShow[i]
                            let wordToAppend = sortedEngWordsToShow[i]
                            let engSenToAppend = sortedEngSenToShow[i]
                            let chiSenToAppend = sortedChiSenToShow[i]
                            
                            myWrongEngWordsToShow.append(wordToAppend)
                            myWrongChiWordsToShow.append(chiWord)
                            myWrongPartOfSpeechToShow.append(partOfSpeech)
                            myWrongSyllablesToShow.append(syllables)
                            myWrongEngSenToShow.append(engSenToAppend)
                            myWrongChiSenToShow.append(chiSenToAppend)

                        }
                        
                    }
                    } else {
             
                    
                    }
                }
          
                
            }
            
            */
        }
 
        engWordsSelected = myWrongEngWordsToShow
        chiWordsSelected = myWrongChiWordsToShow
        partOfSpeechSelected = myWrongPartOfSpeechToShow
        syllablesSelected = myWrongSyllablesToShow
        engSenSelected = myWrongEngSenToShow
        chiSenSelected = myWrongChiSenToShow
        
        
        tableView.reloadData()
        findMatchCollectionCell()
    }
    
    //上方segMent選擇
    
    var alertTextShown = String()

    func didSelect(_ segmentIndex: Int) {
        
        //停止所有func
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        switch segmentIndex{
            
        case 0:
            
            isAllEmpty = true
            //再次讀我的最愛反紅部分, 這件事情暫時不用作
            //loadAllWordFavs()
            //切換到可以修改最愛的模式
            likeMode = true
      
         
            
            engWordsSelected = sortedEngWordsToShow
            chiWordsSelected = sortedChiWordsToShow
            partOfSpeechSelected = sortedPartOfSpeechToShow
            syllablesSelected = sortedSyllablesToShow
            engSenSelected = sortedEngSenToShow
            chiSenSelected = sortedChiSenToShow
            
            
            //移除三個多增加的數量
             if (mapPassedInt! + 1) != maxMapNum{
                
            
                for  _ in 0 ..< 3 {
                
                engWordsSelected.removeLast()
            
                }
            
            }
            tableView.reloadData()
            findMatchCollectionCell()
            
        case 1:
            
            isAllEmpty = false
            likeMode = false
            //讀取錯字
            
            //內包含findMatch
            loadMyWrongWords()
        

            
            
        case 2:
            
            isAllEmpty = false
            likeMode = true
            //內包含findMatch
            loadMyFavWords()

            
        default:
            break
        }
        
        
        
    }
    
    
    //自動播放鍵
    @IBAction func playClicked(_ sender: Any) {
        
        if isAutoPlay{
            
            //立即停止發音 & 停止上次動作
            stopSpeech()
            
            autoPlayText.textColor = btnOffColor
            autoPlayImg.image = UIImage(named:"bookPlayOff.png")
            isAutoPlay = false
            
            //停止播放
            
            
        } else {

            //立即停止發音 & 停止上次動作
            stopSpeech()
            
            autoPlayText.textColor = btnOnColor
            autoPlayImg.image = UIImage(named:"bookPlayOn.png")
            isAutoPlay = true
            
            
            //確認是否有字, 才會發音
            if engWordsSelected.count > 0 {
            
            
            //Part 1. scroll停止
            tableView.setContentOffset(tableView.contentOffset, animated: false)
            
            //Part 2. 抓visible的中間cell
            if let cells = tableView.visibleCells as [UITableViewCell]?{
                
                //設定選擇到的cell
                var selectedCell = UITableViewCell()

                //首先抓最上方的cell Index
                let topCell = tableView.indexPathsForVisibleRows![0]
                
                //確認有沒有全部顯示
                let cellRect = tableView.rectForRow(at: topCell)
                let isCompletelyVisible = tableView.bounds.contains(cellRect)
    
                //如果index是0, 又全部顯示, 就選擇第一個cell
                if topCell.row == 0 && isCompletelyVisible{
                    
                    selectedCell = cells[0]
   
                    
                    //其餘狀態選第2個
                } else if cells.count > 1 {
                    
                    selectedCell = cells[1]
   
                }
                
                //抓目前cell的label
                let currentEngWordLabel = selectedCell.viewWithTag(2) as! UILabel
                
                //比對單字
                    for i in 0 ..< engWordsSelected.count{
                        
                        let engWord = engWordsSelected[i].replacingOccurrences(of: " ", with: "")
                        
                        //抓出順序
                        if engWord == currentEngWordLabel.text!{
                            
                            //指定順序及發音單字
                            currentWordIndex = i
                            
                            synEngWord = engWord
                            
                            
                            //抓發音錯誤字集
                            for i in 0 ..< wrongPronounceWords.count{
                                
                                for (word,rightWord) in wrongPronounceWords[i]{
                                    
                                    //假如有抓到的話
                                    if word == engWord{
                                        print("found wrong pronounce word")
                                        synEngWord = rightWord[0]
                                        
                                    }
                                    
                                }
                                
                            }

                            
                            
                            
                            
                            
                            
                            synChiWord = chiWordsSelected[i]
                            synEngSen = engSenSelected[i]
                            synChiSen = chiSenSelected[i]
                            
                        }
                    }
                
                    //跳轉到該個單字
                    let index = IndexPath(row: currentWordIndex, section: 0)
                    tableView.scrollToRow(at: index, at: .middle, animated: true)
                    
                    let row = tableView.cellForRow(at: index)
                    UIView.animate(withDuration: 0.2, animations: {[weak self] in
                        
                        row?.backgroundColor = self!.lightRed
                        }, completion: { (finished:Bool) in
                            if finished{
                                UIView.animate(withDuration: 0.2, animations: {
                                    
                                    row?.backgroundColor = .clear
                                })
                                
                            }
                    })
                    
                    
                    //Part 3. 往下播放
                    synPronounce()
                
            }
            }else {
                
                //找不到字
                print("no word")
            }
        }
        
        
    }
    
    @IBAction func practiceBtnClicked(_ sender: Any) {
        print("enter practice")
        
        ghostBtn.isHidden = false
        alertBg.isHidden = false
        ghost2Btn.isHidden = false
        practiceWordBtn.isHidden = false
        practiceSenBtn.isHidden = false
        leftBtnClickedImg.isHidden = false
        rightBtnClickedImg.isHidden = false
        
        
    }
    
    //播放完每次發音後的行為, 在此控制所有發音順序
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        
       
        switch step{
         
        //英單
        case 1:
            
            switch speakTimes{
            case 1:

                alreadyPlayTimes = 0
                pronounceChi()
                
                
            case 2:
   
                switch alreadyPlayTimes{
                    
                case 1:
            
                    pronounceEng()
      
                case 2:
    
                    alreadyPlayTimes = 0
                    pronounceChi()
       
                default:
                    break
                    
                }
                
            case 3:
                switch alreadyPlayTimes{
                case 1:
                    pronounceEng()
                case 2:
              
                    pronounceEng()
                case 3:
            
                    alreadyPlayTimes = 0
                    pronounceChi()
                    
                default:
                    break

                }
            default:
                break
                
            }
         
      //中單
        case 2:
            
            //假如不播放句子, 就直接重播
            if !isPlaySentence{
                
                if !synth.isSpeaking{
                    autoPlayFunc()
                }
            } else {
                
                
                //英句
                //或者往下播放句子
                pronounceEngSen()

            }
            
        
            //中句
        case 3:
   
            pronounceChiSen()
            

            //是否重播
        case 4:

            
            
            switch speakTimes{
            case 1:
                if !synth.isSpeaking{
                    autoPlayFunc()
                }
                alreadyPlayTimes = 0
                
            case 2:
                
                switch alreadyPlayTimes{
                case 1:

                    pronounceEngSen()
                case 2:
                    
                    alreadyPlayTimes = 0
                    if !synth.isSpeaking{
                        autoPlayFunc()
                    }
                    
                    
                default:
                    break
                    
                }
                
            case 3:
                switch alreadyPlayTimes{
                    
                case 1:

                    pronounceEngSen()
                case 2:
                    

                    pronounceEngSen()
                case 3:
                    
                    alreadyPlayTimes = 0
                    if !synth.isSpeaking{
                        autoPlayFunc()
                    }
                    
                    
                default:
                    break
                    
                    
                }
            default:
                break
                
            }
            
        default:
            break
            
        }
        
        
    }
    
    func autoPlayFunc(){
        
        //繼續往下Play
        if isAutoPlay{
            
            
            if currentWordIndex < engWordsSelected.count - 1{
                currentWordIndex += 1
                
                synEngWord = engWordsSelected[currentWordIndex].replacingOccurrences(of: " ", with: "")
                
                //抓發音錯誤字集
                for i in 0 ..< wrongPronounceWords.count{
                    
                    for (word,rightWord) in wrongPronounceWords[i]{
                        
                        //假如有抓到的話
                        if word == synEngWord{
                            print("found wrong pronounce word")
                            synEngWord = rightWord[0]
                            
                        }
                        
                    }
                    
                }
                
                
                
                synChiWord = chiWordsSelected[currentWordIndex]
                synEngSen = engSenSelected[currentWordIndex]
                synChiSen = chiSenSelected[currentWordIndex]
                
                
                let index = IndexPath(row: currentWordIndex, section: 0)
                tableView.scrollToRow(at: index, at: .middle, animated: true)
                
                let row = tableView.cellForRow(at: index)
                UIView.animate(withDuration: 0.2, animations: {[weak self] in
                    
                    row?.backgroundColor = self!.lightRed
                    }, completion: { (finished:Bool) in
                        if finished{
                            UIView.animate(withDuration: 0.2, animations: {
                                
                                row?.backgroundColor = .clear
                            })
                            
                        }
                })
                
                synPronounce()
                
            }
            
        }
    }
    
    @IBAction func playSentenceClicked(_ sender: Any) {
        
        if isPlaySentence{
            playSenText.textColor = btnOffColor
            playSenImg.image = UIImage(named:"bookSenOff.png")
            isPlaySentence = false
        } else {
            playSenText.textColor = btnOnColor
            playSenImg.image = UIImage(named:"bookSenOn.png")
            isPlaySentence = true
            
            
        }
        
    }
    
    @IBAction func playTimesClicked(_ sender: Any) {
        
        switch speakTimes{
            
        case 1:
            playTimesImg.image = UIImage(named:"bookTimes1.png")
            speakTimes = 2
        case 2:
            playTimesImg.image = UIImage(named:"bookTimes2.png")
            
            speakTimes = 3
        case 3:
            playTimesImg.image = UIImage(named:"bookTimes0.png")
            speakTimes = 1
        default:
            break
            
        }
        
    }
    
    
    @IBAction func playSpeedClicked(_ sender: Any) {
        
        switch speakRate{
            
        case 0.45:
            playSpeedImg.image = UIImage(named:"bookSpeed1.png")
            playSpeedText.textColor = btnOnColor
            speakRate = 0.25
            
        case 0.25:
            playSpeedImg.image = UIImage(named:"bookSpeed2.png")
            playSpeedText.textColor = btnOnColor
            
            
            speakRate = 0.15
            
        case 0.15:
            playSpeedImg.image = UIImage(named:"bookSpeed0.png")
            playSpeedText.textColor = btnOffColor
            
            
            speakRate = 0.45
            
        default:
            break
            
            
            
        }
        //立即停止發音 & 停止上次動作
        
        if synth.isSpeaking{

            //立即停止
            stopSpeech()
            
            //再次播放
            alreadyPlayTimes = 0
            synPronounce()
        }
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        print(engWordsSelected.count)
        
        if engWordsSelected.count == 0 {
            
            print("沒有字")
            
            
            ghostBtn.isHidden = false
            alertBg.isHidden = false
            ghost2Btn.isHidden = false
            practiceWordBtn.isHidden = false
            //practiceSenBtn.isHidden = false
            leftBtnClickedImg.isHidden = false
            rightBtnClickedImg.isHidden = false
            alertText.text = alertTextShown
            alertText.textAlignment = .center
            
            if isAllEmpty{
                //設定直接跳出畫面
                
                practiceWordBtn.removeTarget(self, action: #selector(NewBookViewController.practiceWord), for: .touchUpInside)
                practiceWordBtn.addTarget(self, action: #selector(NewBookViewController.backBtnClicked(_:)), for: .touchUpInside)
                
                
                
            } else {
                
                
            }
            
            
            
        }
        
        return engWordsSelected.count
        
        //return 5
     
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellHight = tableView.frame.height / 2.5 / cellDif
        return cellHight
        
        
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let engWordSize = width / 14
        let chiWordSize = width / 30
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath) as! BookTableViewCell
    
        let syllableLabel = cell.viewWithTag(1) as! UILabel
        let engWordLabel = cell.viewWithTag(2) as! UILabel
        let partOfSpeechLabel = cell.viewWithTag(3) as! UILabel
        let chiWordLabel = cell.viewWithTag(4) as! UILabel
        let engSenLabel = cell.viewWithTag(5) as! UILabel
        let chiSenLabel = cell.viewWithTag(6) as! UILabel

        
        
        cell.accessoryType = .disclosureIndicator
        
        if indexPath.row == 0 {
            
            
            
            
            cell.hintLabel.isHidden = false
            
 
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse,.repeat], animations: {
                
                UIView.setAnimationRepeatCount(5)
                cell.hintLabel.alpha = 0
            })
            
            
        } else {
            
            cell.hintLabel.isHidden = true
        }
        
        
        /*
        cell.accessoryView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height:10))
        cell.accessoryView?.layer.cornerRadius = (cell.accessoryView?.frame.width)! / 2
        cell.accessoryView?.backgroundColor = .lightGray
        */
        
        //抓音節的字母 +  數字
        let syllableText = syllablesSelected[indexPath.row]
        
        //let syllableNum = syllablesSelected[indexPath.row].replacingOccurrences(of: syllableText[0], with: "")
        

        
        
        //抓字
        let engWords = engWordsSelected[indexPath.row]

        
        //拆音節成array
        let engWordArray = engWords.components(separatedBy: " ")
       
        //定義母音
        let vowels = ["a","e","i","o","u"]
        
        //字型顏色
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: engWordSize), NSAttributedStringKey.foregroundColor : UIColor.cyan]
        let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: engWordSize), NSAttributedStringKey.foregroundColor : UIColor.white]
        
        //假如音節是_e, 另外處理
        if syllableText.contains("_") {

            var characters = [Character]()
            
            var attrWords = [NSMutableAttributedString]()
            
            //每一個英文字節拆字母
            for i in 0 ..< engWordArray.count{
                
                characters.removeAll(keepingCapacity: false)
                
                for i in engWordArray[i]{

                    

                    characters.append(i)
                    
                }
                
                
                //確認是不是_e部首, 目前設定為三個字母, 若要增加要在這裡修改
                if characters.count == 3 {
                    if characters[2] == "e"{
                        if vowels.contains(String(characters[0])){

                            
                            //剛好是_e部首
                            let word = NSMutableAttributedString(string: String(characters[0]), attributes: attrs1)
                            attrWords.append(word)
                            let word1 = NSMutableAttributedString(string: String(characters[1]), attributes: attrs2)
                            attrWords.append(word1)
                            let word2 = NSMutableAttributedString(string: String(characters[2]), attributes: attrs1)
                            attrWords.append(word2)
                            
                            
                            //以下確認非部首字就loop through 然後新增
                        } else {
                            
                            for c in 0 ..< characters.count {
                                
                                let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs2)
                                attrWords.append(word)
                            }
                        }
                        
                    } else {
                        
                        for c in 0 ..< characters.count {
                            
                            let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs2)
                            attrWords.append(word)
                        }
                        
                    }
                    
                } else {
                    
                    for c in 0 ..< characters.count {
                        
                        let word = NSMutableAttributedString(string: String(characters[c]), attributes: attrs2)
                        attrWords.append(word)
                    }
                    
                }
            }
            
            var word = NSMutableAttributedString()
            
            //跑這個字的array然後append成一個字串
            for i in 0 ..< attrWords.count {
                
                if i == 0 {
                    word = attrWords[i]
                } else {
                    word.append(attrWords[i])
                }
            }
            
            engWordLabel.attributedText = word
            
        } else {
            //非_e部首, 設定一些字的顏色
            
            var attrWords = [NSMutableAttributedString]()
            
            for i in 0 ..< engWordArray.count{
                
                if let engWord = engWordArray[i] as String?{
                    
                    //如果此字節是音節字元
                    if engWord.lowercased() == syllableText{
                        
                        let word = NSMutableAttributedString(string: engWord, attributes: attrs1)
                        attrWords.append(word)
                        
                    } else {
                        //一般字元
                        let word = NSMutableAttributedString(string: engWord, attributes: attrs2)
                        attrWords.append(word)
                    }
                    
                }
                
            }
            //造字
            var word = NSMutableAttributedString()
            for i in 0 ..< attrWords.count {
                if i == 0 {
                    word = attrWords[i]
                } else {
                    word.append(attrWords[i])
                }
            }
            
            engWordLabel.attributedText = word
        }
        
        
        //中文字及詞性
        let chiWord = chiWordsSelected[indexPath.row]
        let partOfSpeech = partOfSpeechSelected[indexPath.row].replacingOccurrences(of: "\r\n", with: "")
        
        //chiWordLabel.text = "(" + partOfSpeech + ")" + " " +  chiWord
        chiWordLabel.text = chiWord
        
        chiWordLabel.font = UIFont(name: "System Semibold", size: chiWordSize)
        engSenLabel.font = UIFont(name: "System Semibold", size: chiWordSize)
        chiSenLabel.font = UIFont(name: "System Semibold", size: chiWordSize)
        
        partOfSpeechLabel.font = UIFont(name: "Helvetica Neue Medium", size: chiWordSize)
        partOfSpeechLabel.adjustsFontSizeToFitWidth = true
        partOfSpeechLabel.text = partOfSpeech
        syllableLabel.adjustsFontSizeToFitWidth = true
        syllableLabel.text = syllableText
        
        chiSenLabel.adjustsFontSizeToFitWidth = true
        engSenLabel.adjustsFontSizeToFitWidth = true
        //抓句子
        let engSen = engSenSelected[indexPath.row]
        let chiSen = chiSenSelected[indexPath.row]
        
        engSenLabel.text = engSen
        chiSenLabel.text = chiSen
        
        cell.backgroundColor = .clear
        
        
        return cell
        
        
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    var tempMyFav = [String]()
    var tempFavWordsToDelete = [String]()
    var tempWrongWordsToDelete = [String]()
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        
        switch segControl.selectedSegmentIndex{
            
        case 0:
            
            
            let addToFavAction = UITableViewRowAction(style: .default, title: "加入最愛") { [weak self](action, indexPath) in
                
                //抓單字
                
                let wordToCheck = self!.engWordsSelected[indexPath.row]
                
                let wordToAdd = wordToCheck.replacingOccurrences(of: " ", with: "")
          
                
                //tempMyFav
                
                if !self!.tempMyFav.contains(wordToAdd){
                
                self!.tempMyFav.append(wordToAdd)
                
                }
                
                self!.addToFavAnimation(word: wordToAdd)
                
                
                /*
                if self!.tempFavWordsToDelete.count > 0 {
                
                for i in 0 ..< self!.tempFavWordsToDelete.count {
                    
                    if self!.tempFavWordsToDelete[i] == wordToAdd {
                        
                        self!.tempFavWordsToDelete.remove(at: i)
                  
                    }
                    
                    }
               
                }
                 
            */
                
                
                
                
                
                
                
                
                
                
                
                
                
                
            }
         
            print("add:\(tempMyFav)")
            
            print("toDelete:\(tempFavWordsToDelete)")

            return [addToFavAction]

            
        case 1:
            
            
            let addToFavAction = UITableViewRowAction(style: .default, title: "加入最愛") {[weak self] (action, indexPath) in
                
                //抓單字
                
                let wordToCheck = self!.engWordsSelected[indexPath.row]
                
                let wordToAdd = wordToCheck.replacingOccurrences(of: " ", with: "")
                
                print(wordToAdd)
                
                //tempMyFav
                
                if !self!.tempMyFav.contains(wordToAdd){
                    
                    self!.tempMyFav.append(wordToAdd)
                    
                }
                
               
                           self!.addToFavAnimation(word: wordToAdd)

                /*
                if self!.tempFavWordsToDelete.count > 0 {
                
                for i in 0 ..< self!.tempFavWordsToDelete.count {
                    
                    if self!.tempFavWordsToDelete[i] == wordToAdd {
                        
                        self!.tempFavWordsToDelete.remove(at: i)
                    }
                    
                }
                }
                */
                
                
            }

            
            let deleteAction = UITableViewRowAction(style: .normal, title: "移除單字", handler: {[weak self] (action, indexPath) in
                
                
                let wordToCheck = self!.engWordsSelected[indexPath.row]
                let wordToDelete = wordToCheck.replacingOccurrences(of: " ", with: "")
                
                //之後給後端儲存使用
                self!.tempWrongWordsToDelete.append(wordToDelete)
                
                
                //前段直接刪掉
                self!.engWordsSelected.remove(at: indexPath.row)
                self!.syllablesSelected.remove(at: indexPath.row)
                self!.chiWordsSelected.remove(at: indexPath.row)
                self!.partOfSpeechSelected.remove(at: indexPath.row)
                self!.engSenSelected.remove(at: indexPath.row)
                self!.chiSenSelected.remove(at: indexPath.row)
                
                
                self!.tableView.reloadData()
                

            })
            
             print("add:\(tempMyFav)")
             print("toDelete:\(tempFavWordsToDelete)")
             print("wrongToDelete:\(tempWrongWordsToDelete)")

            return [addToFavAction,deleteAction]

            
        case 2:
            
            let deleteAction = UITableViewRowAction(style: .normal, title: "移除最愛", handler: {[weak self] (action, indexPath) in
                
                
                let wordToCheck = self!.engWordsSelected[indexPath.row]
                let wordToDelete = wordToCheck.replacingOccurrences(of: " ", with: "")
                
                
                //之後給後端儲存使用
                if !self!.tempFavWordsToDelete.contains(wordToDelete) {
                self!.tempFavWordsToDelete.append(wordToDelete)
                
                }
                
                
            /*
                var indexToRemove = [Int]()
                for i in 0 ..< self!.tempMyFav.count{
                    
                    if self!.tempMyFav[i] == wordToDelete {
                        
                        indexToRemove.append(i)
                        
                    }

                }
                */
                
                
                for temp in self!.tempMyFav {
                    
                    
                    if temp == wordToDelete {
                                self?.tempMyFav = self!.tempMyFav.filter { $0 != temp }
                        
                    }
                    
                }
                
                
        
                
 
                
                
                //for前端顯示only
                self!.engWordsSelected.remove(at: indexPath.row)
                self!.syllablesSelected.remove(at: indexPath.row)

                self!.chiWordsSelected.remove(at: indexPath.row)
                self!.partOfSpeechSelected.remove(at: indexPath.row)
                self!.engSenSelected.remove(at: indexPath.row)
                self!.chiSenSelected.remove(at: indexPath.row)
 
                self!.tableView.reloadData()
                
            })

             print("toDelete:\(tempFavWordsToDelete)")
             print("toAdd:\(tempMyFav)")
            
            return [deleteAction]

        default:
            return []
        
            
        }


        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //立即停止發音 & 停止上次動作
        
        alreadyPlayTimes = 0
        currentWordIndex = indexPath.row
        
        stopSpeech()
        
        synEngWord = engWordsSelected[indexPath.row].replacingOccurrences(of: " ", with: "")
        
    
        //抓發音錯誤字集
        for i in 0 ..< wrongPronounceWords.count{
            
            for (word,rightWord) in wrongPronounceWords[i]{
                
                //假如有抓到的話
                if word == synEngWord{
                    print("found wrong pronounce word")
                    synEngWord = rightWord[0]
                    
                }
                
            }
            
        }
        
        
        synChiWord = chiWordsSelected[indexPath.row]
        
        if isPlaySentence{
            synEngSen = engSenSelected[indexPath.row]
            synChiSen = chiSenSelected[indexPath.row]
        }else {
            
            synEngSen = ""
            synChiSen = ""
        }
        
        
        synPronounce()
        
        let row = tableView.cellForRow(at: indexPath)
        UIView.animate(withDuration: 0.2, animations: {[weak self] in
            
            row?.backgroundColor = self!.lightRed
            }, completion: { (finished:Bool) in
                if finished{
                    UIView.animate(withDuration: 0.2, animations: {
                        
                        row?.backgroundColor = .clear
                    })
                    
                }
        })
        let index = IndexPath(row: indexPath.row, section: 0)
        tableView.scrollToRow(at: index, at: .middle, animated: true)
        
    }
    
    //用以下兩個方法來檢測scroll暫停時間
    
    @objc func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //滾動時不能選擇
        isCollectionViewSelectabel = false
        segControl.isEnabled = false
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(NewBookViewController.scrollViewDidEndDecelerating(_:)), object: nil)

        perform(#selector(NewBookViewController.scrollViewDidEndDecelerating(_:)), with: nil, afterDelay: 0.1)
        
    }
    
    @objc func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //滾動停止可以選擇
        isCollectionViewSelectabel = true
        segControl.isEnabled = true
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(NewBookViewController.scrollViewDidScroll(_:)), object: nil)
    
        //用這個func來決定collectionView Cell要顯示哪個
        
        if scrollView == tableView{
            
                  findMatchCollectionCell()
        }
  
        print("end scrolling")
        
    }
    
    //指定一個數字, 去找符合音節的字
    var indexToChange = Int()
    
    //決定collectionView 那個cell被選擇
    func findMatchCollectionCell(){
        
      
        
        if engWordsSelected.count > 0 {
        
        if let cells = tableView.visibleCells as [UITableViewCell]?{
            
            //抓最後那個cell的音節
            //定義音節的label, 有可能因為無值而找不到
            var sylTextLabel = UILabel()
            
            if cells.count > 2 {
                sylTextLabel = cells[1].viewWithTag(1) as! UILabel
                
            } else if cells.count > 0{
                sylTextLabel = cells[cells.count - 1].viewWithTag(1) as! UILabel
            }
            
            

         
                for i in 0 ..< sortedSylArray.count{
                    
                    if sortedSylArray[i] == sylTextLabel.text! {
                        indexToChange = i
                    }
                }
            
            //假如找到的話就做collecitonView更新
                //設定選項顏色
                for c in 0 ..< collectionTouched.count{
                    
                    collectionTouched[c] = 0
                }
                
                collectionTouched[indexToChange] = 1

        }
        } else {
            
            //找不到任何字, 把所有collection cell選項歸零
            for c in 0 ..< collectionTouched.count{
                collectionTouched[c] = 0
            }

        }
    
        //重整collectionView
        isScrolling = true

        
        let indexToScroll = IndexPath(row: indexToChange, section: 0)
        collectionView.scrollToItem(at: indexToScroll, at: .centeredVertically, animated: true)
        
        collectionView.reloadData()

    }
    
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return sortedSylArray.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isCollectionViewSelectabel{
            //設定選項顏色
            for i in 0 ..< collectionTouched.count{
                collectionTouched[i] = 0
                
            }
            collectionTouched[indexPath.row] = 1
            
            //指定文字
            collectionSelectedIndex = indexPath.row
            
            isScrolling = false
            
            collectionView.reloadData()
        }
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: "SylCell", for: indexPath as IndexPath)
        
        
        let blueBall = cell.viewWithTag(2) as! UIImageView
        let sylText = cell.viewWithTag(1) as!UILabel
        let sylToDisplay = sortedSylArray[indexPath.row]
        
        sylText.text = sylToDisplay
        sylText.textColor = btnOffColor
        
        sylSelected = sortedSylArray[collectionSelectedIndex!]
        
        if !isScrolling{
            jumpToRow(sylSelected: sylSelected!)
        }
        
        

        
        
        if collectionTouched[indexPath.row] == 1 {
            sylText.textColor = .white
            blueBall.isHidden = false
        } else {
            blueBall.isHidden = true
            sylText.textColor = .darkGray
            
        }
        
        return cell
        
    }
    
//var isAlertPoppedOut = false
    func jumpToRow(sylSelected:String){
        
        var isJump = false
        //找對應的row, 並跳過去
        
            for i in 0 ..< syllablesSelected.count{
            
                if isJump == false {
                
            //確認有字可以跳, 因爲有一些是正開放可以學習的單字但是不代表已經過了
            if syllablesSelected[i] == sylSelected{
   
                if i < tableView.numberOfRows(inSection: 0){
                    
                    if i == 0 {
                        
                        let index = IndexPath(row: 0, section: 0)
                        
                        tableView.scrollToRow(at: index, at: .top, animated: true)
                        
                        isJump = true
                        
                    } else {
                        
                        let index = IndexPath(row: i + 1, section: 0)
                        
                        tableView.scrollToRow(at: index, at: .bottom, animated: true)
                        
                        isJump = true
                        
                    }
                    
                }
    
            } else {
                
                
                    }
                    
                }
        }
    
        
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        
        synth.stopSpeaking(at: .immediate)
        synth.delegate = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //重設synth & 他的delegate
    func stopSpeech(){
        
        if synth.isSpeaking{
            
            synth.stopSpeaking(at: .immediate)
            synth = AVSpeechSynthesizer()
            synth.delegate = self
            
        }
    }
    
    //syn發音
    func synPronounce(){
        
        do {

            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
        } catch  {
            
        }
       
        
        pronounceEng()
        
        
    }
    
    
    @objc func pronounceEng(){
        
        alreadyPlayTimes += 1
        step = 1
        let engWord = AVSpeechUtterance(string: synEngWord)
        engWord.voice = AVSpeechSynthesisVoice(language: "en-US")
        engWord.rate = Float(speakRate)
        synth.speak(engWord)
        print("already:\(alreadyPlayTimes)")
        
    }
    
    @objc func pronounceChi(){
        
        step = 2
        let chiWord = AVSpeechUtterance(string:synChiWord)
        chiWord.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        chiWord.rate = 0.48
        synth.speak(chiWord)
        
        
    }
    
    //英文句子念完才算結束
    
    @objc func pronounceEngSen(){
        
        
        step = 3
        let engSen = AVSpeechUtterance(string:synEngSen)
        engSen.voice = AVSpeechSynthesisVoice(language: "en-US")
        engSen.rate = Float(speakRate)
        synth.speak(engSen)
        
    }
    
    
    @objc func pronounceChiSen(){
        
        
        alreadyPlayTimes += 1
        step = 4
        
        print("alreadyPlay:\(alreadyPlayTimes)")
        
        let chiSen = AVSpeechUtterance(string:synChiSen)
        chiSen.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        chiSen.rate = 0.48
        synth.speak(chiSen)
        
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        
        //在此存檔後端
        
        print("book will disapear")
        
        //確認錯誤單字的刪除狀態
        
        if tempWrongWordsToDelete.count > 0 {
            
            
            
            for word in tempWrongWordsToDelete {
                
                
                wordsToDeleteInWrong.append(word)
                print("錯誤字刪除:\(word)")
                
                
                
            }
            
            
            
        }
        
        
        
        
        
        //確認我的最愛刪除狀況
        
        if tempFavWordsToDelete.count > 0 {
            
            
            for word in tempFavWordsToDelete {
                
                
                if myFavWords.contains(word) {
                    
                    //有包含的話
                    

                    //確認有沒有add
                    
                    
                    if !tempMyFav.contains(word){
                        
                        
                        //直接delete
                        
                        print("刪除字1:\(word)")
                        wordsToDeleteInFav.append(word)
                        
                        
                        for fav in tempMyFav {
                            
                            
                            if !myFavWords.contains(fav) {
                                
                                
                                
                                wordsToAddToFav.append(fav)
                                
                                tempMyFav = tempMyFav.filter { $0 != fav }

                                
                                print("新增字1:\(fav)")
                                
                            }
                            
                        }
                        
                        
                        
                        
                        
                    }

                    
                    
                    
                    

                    
                } else {
                    
                    
                    
                    //沒有包含的話
                    
                    
                    for fav in tempMyFav {
                        
                     
                            //直接add
                        
                            wordsToAddToFav.append(fav)
                        
                        tempMyFav = tempMyFav.filter { $0 != fav }
                            
                            print("新增字2:\(fav)")
                   
                        
                        
                    }
                    

                    
                    
                    
                    
                }
                

            }
            
            
            
        } else {
            
            if tempMyFav.count > 0 {
                
                
                //直接add
                
                

                for fav in tempMyFav {
                    
                    
                    if !myFavWords.contains(fav) {
                             wordsToAddToFav.append(fav)
                    
                    print("新增字3:\(fav)")
                    
                    }
                    
                }
                
                
                
                
                
                
                
                
                
            }
            
        }
       
        
        
        print(wordsToAddToFav)
        
        if wordsToAddToFav.count > 0 {
            
            addWord()
        }
        
        
        if wordsToDeleteInFav.count > 0 {
            
            removeWord()
        }
        
        if wordsToDeleteInWrong.count > 0 {
            
            removeWrongWord()
            
            
        }
    }
    
    
    
    
    //新增最愛單字
    func addWord(){
        

        for word in wordsToAddToFav {
        
            
            let id = user?["id"] as! String
            
            // url to access our php file
            let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/addWord.php")!
            
            // request url
            var request = URLRequest(url: url)
            
            // method to pass data POST - cause it is secured
            request.httpMethod = "POST"
            
            // body gonna be appended to url
            let body = "userID=\(id)&word=\(word)"
            
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
                            //self?.isParseEnabled = true
                            return
                        }
                        print("add word")
                        
                   
                        //再次儲存使用者資訊
                        UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                        
                        //載入我的最愛單字
                        /*
                        if let myWordsString = user!["myWords"] as! String?{
                            self!.myWords = myWordsString.components(separatedBy: ";")
                            
                        }
                        self?.isParseEnabled = true
                        */
                    } catch{
                       // self?.isParseEnabled = true
                        print("catch error")
                        
                        
                    }
                } else {
                 //   self?.isParseEnabled = true
                    print("urlsession has error")
                    
                }
            }).resume()
        }
            }
    
    
    
    func removeWord(){
        
        for word in wordsToDeleteInFav{
            let id = user?["id"] as! String
            
            // url to access our php file
            let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/removeWord.php")!
            
            // request url
            var request = URLRequest(url: url)
            
            // method to pass data POST - cause it is secured
            request.httpMethod = "POST"
            
            // body gonna be appended to url
            let body = "userID=\(id)&word=\(word)"
            
            // append body to our request that gonna be sent
            request.httpBody = body.data(using: .utf8)
            
            URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
                // no error
                if error == nil {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        guard let parseJSON = json else {
                            print("Error while parsing")
                          //  self?.isParseEnabled = true
                            //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                            return
                        }
                        
                        
                        
                        //再次儲存使用者資訊
                        UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                        print(user!)
                        /*
                        //載入我的最愛單字
                        if let myWordsString = user!["myWords"] as! String?{
                            self!.myWords = myWordsString.components(separatedBy: ";")
                            
                        }
                        
                        self?.isParseEnabled = true
                        */
                    } catch{
                        
                      //  self?.isParseEnabled = true
                        print("catch error")
                        
                    }
                } else {
               //     self?.isParseEnabled = true
                    print("urlsession has error")
                    
                }
            }).resume()
        }
    }
    
    func removeWrongWord(){
        
        for word in wordsToDeleteInWrong{
            let id = user?["id"] as! String
            
            // url to access our php file
            let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/removeWrongWord.php")!
            
            // request url
            var request = URLRequest(url: url)
            
            // method to pass data POST - cause it is secured
            request.httpMethod = "POST"
            
            // body gonna be appended to url
            let body = "userID=\(id)&word=\(word)"
            
            // append body to our request that gonna be sent
            request.httpBody = body.data(using: .utf8)
            
            URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
                // no error
                if error == nil {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        guard let parseJSON = json else {
                            print("Error while parsing")
                            //  self?.isParseEnabled = true
                            //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                            return
                        }
                        
                  
                        
                        
                        //再次儲存使用者資訊
                        UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                        print(user!)
                        /*
                         //載入我的最愛單字
                         if let myWordsString = user!["myWords"] as! String?{
                         self!.myWords = myWordsString.components(separatedBy: ";")
                         
                         }
                         
                         self?.isParseEnabled = true
                         */
                    } catch{
                        
                        //  self?.isParseEnabled = true
                        print("catch error")
                        
                    }
                } else {
                    //     self?.isParseEnabled = true
                    print("urlsession has error")
                    
                }
            }).resume()
        }
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

