//
//  NewBookViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/3/15.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit
import TwicketSegmentedControl


class NewBookViewController: UIViewController,TwicketSegmentedControlDelegate, UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
    
    var sylArray = [String]()
    var collectionTouched = [Int]()

    let segControl = TwicketSegmentedControl()
    let darkPurpleColor = UIColor.init(red: 82/255, green: 90/255, blue: 120/255, alpha: 1)
    let segSliderBgColor = UIColor.init(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.25)
    let btnOffColor = UIColor.init(red: 115/255, green: 115/255, blue: 115/255, alpha: 1)
    let btnOnColor = UIColor.init(red: 223/255, green: 223/255, blue: 223/255, alpha: 1)
    
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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        segControl.frame = CGRect(x: 50, y: 25, width: 300, height: 30)
        
        self.view.addSubview(segControl)
        
        let titles = ["正確單字", "錯誤單字", "最愛單字"]
        segControl.setSegmentItems(titles)
        segControl.backgroundColor = .clear
        segControl.sliderBackgroundColor = segSliderBgColor
        segControl.segmentsBackgroundColor = .clear
        segControl.defaultTextColor = darkPurpleColor
        segControl.highlightTextColor = .white
        segControl.isSliderShadowHidden = true
        
        
        segControl.delegate = self
        collectionView.delegate = self
        tableView.delegate = self
        
        collectionView.backgroundColor = .clear
        tableView.backgroundColor = .clear
        let bgImg = UIImage(named:"wordTableBg.png")
        tableView.backgroundView = UIImageView(image: bgImg)
        tableView.separatorColor = UIColor.init(red: 215/255, green: 217/255, blue: 226/255, alpha: 1)
        tableView.separatorInset = .init(top: 0, left: 48, bottom: 0, right: 70)
        
        //設定Btn顏色狀態
        autoPlayText.textColor = btnOffColor
        playSenText.textColor = btnOffColor
        playTimesText.textColor = btnOnColor
        playTimesImg.image = UIImage(named:"bookTimes0.png")
        playSpeedImg.image = UIImage(named:"bookSpeed0.png")
        playSpeedText.textColor = btnOffColor
        
        //讀取所有syl
        for group in syllableSets{
            for syl in group{

                let sylBreaks = syl.components(separatedBy: NSCharacterSet.decimalDigits)
                let syl = sylBreaks[0]
                if !sylArray.contains(syl){
                    
                    sylArray.append(syl)
                }
            }

        }
        
        print(sylArray)
        
        for _ in 0 ..< sylArray.count{
            
            collectionTouched.append(0)
            
            
        }
        print(sylArray.count)
        print(collectionTouched.count)
        print(collectionTouched)
        
        
    }
    func didSelect(_ segmentIndex: Int) {
        
        print(segmentIndex)
        
    }
    
    var isAutoPlay = false
    @IBAction func playClicked(_ sender: Any) {
        
        if isAutoPlay{
            autoPlayText.textColor = btnOffColor
            autoPlayImg.image = UIImage(named:"bookPlayOff.png")
            isAutoPlay = false
        } else {
            autoPlayText.textColor = btnOnColor
            autoPlayImg.image = UIImage(named:"bookPlayOn.png")
            isAutoPlay = true
            
            
        }
        
        
    }
    
    var isPlaySentence = false
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
    
    
    var playTimes = 0
    @IBAction func playTimesClicked(_ sender: Any) {
        
        switch playTimes{
            
        case 0:
            playTimesImg.image = UIImage(named:"bookTimes1.png")
            playTimes = 1
        case 1:
            playTimesImg.image = UIImage(named:"bookTimes2.png")
            playTimes = 2
        case 2:
            playTimesImg.image = UIImage(named:"bookTimes0.png")
            playTimes = 0
            default:
        break
            
            
            
        }
        
        
    }
    
    var slowSpeed = 0
    @IBAction func playSpeedClicked(_ sender: Any) {
        
        switch slowSpeed{
            
        case 0:
            playSpeedImg.image = UIImage(named:"bookSpeed1.png")
            slowSpeed = 1
                playSpeedText.textColor = btnOnColor
        case 1:
            playSpeedImg.image = UIImage(named:"bookSpeed2.png")
                        playSpeedText.textColor = btnOnColor
            slowSpeed = 2
        case 2:
            playSpeedImg.image = UIImage(named:"bookSpeed0.png")
            playSpeedText.textColor = btnOffColor
            slowSpeed = 0
        default:
            break
            
            
            
        }
        
        
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        return 10
    }
    

    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
                let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath)
        cell.backgroundColor = .clear
        return cell
        
        
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return sylArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        for i in 0 ..< collectionTouched.count{
            collectionTouched[i] = 0

        }
        collectionTouched[indexPath.row] = 1
        collectionView.reloadData()
        
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: "SylCell", for: indexPath as IndexPath)
        let blueBall = cell.viewWithTag(2) as! UIImageView
        let sylText = cell.viewWithTag(1) as!UILabel
        let sylToDisplay = sylArray[indexPath.row]
        sylText.text = sylToDisplay
        
        if collectionTouched[indexPath.row] == 1 {
            
            blueBall.isHidden = false
        } else {
            blueBall.isHidden = true
            
        }

        return cell
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

