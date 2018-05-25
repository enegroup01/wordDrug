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
        alertText.text = "選擇練習模式"
        alertText.numberOfLines = 0
        alertText.textAlignment = .center
        alertText.adjustsFontSizeToFitWidth = true
        alertBg.addSubview(alertText)
        
        
        practiceWordBtn.frame = CGRect(x: alertBg.frame.minX, y: alertBg.frame.maxY - 44 * dif * xDif, width: alertBg.frame.width / 2, height: height * 44 / 667)
        
        practiceWordBtn.setTitle("複習單字", for: .normal)
        practiceWordBtn.setTitleColor(darkRed, for: .normal)
        practiceWordBtn.addTarget(self, action: #selector(LessonViewController.practiceWord), for: .touchUpInside)
        self.view.addSubview(practiceWordBtn)
        
        practiceSenBtn.frame = CGRect(x: practiceWordBtn.frame.maxX, y: alertBg.frame.maxY - 44 * dif * xDif, width: alertBg.frame.width / 2, height: height * 44 / 667)
        practiceSenBtn.setTitle("複習句型", for: .normal)
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
        
        alertText.text = "選擇練習模式"
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
                
                
                if self!.gamePassedDic == [0:0]{
                    
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
                
                
                if self!.gamePassedDic == [0:0]{
                    
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
            
        case 1:
            gamePassedDic = gamePassed2!
            mapPassedInt = mapPassed2!
            increaseNum = 5
            
        default:
            break
        }
        
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
        
        alertText.text = "學習單字不足，無法練習\n 至少需要學習一個單元才能複習"
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
