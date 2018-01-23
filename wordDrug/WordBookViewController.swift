//
//  WordBookViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/1/23.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class WordBookViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    
    @IBOutlet weak var wordBookBg: UIImageView!
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    @IBOutlet weak var myPageController: UIPageControl!
    
    @IBOutlet weak var segHeight: NSLayoutConstraint!
    @IBOutlet weak var autoplayBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segControl: UISegmentedControl!
    let specialGray = UIColor.init(red: 40/255, green: 49/255, blue: 58/255, alpha: 1)
    
    var fullSize: CGSize!

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
    
    var wordSets = [[String]]()
    var engWordsToShow = [String]()
    var chiWordsToShow = [String]()
    var partOfSpeechToShow = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //抓seg高度
        segHeight.constant = 75
        //設定seperator顏色
        tableView.separatorColor = specialGray
        
        //設定seg裡的圖片及文字
        let segImages = ["wordsGotMark","myFavMark","wrongMark"]
        let segImageSizes:[[CGFloat]] = [[46,37],[31,26],[25,29]]
        let segImagePoints:[[CGFloat]] = [[40,12],[170,24],[300,20]]
        let segLabelPoints:[[CGFloat]] = [[40,55],[160,55],[290,55]]
        let segLabelTexts = ["已背單字","我的最愛","背錯單字"]
        
        for i in 0 ..< segControl.numberOfSegments{
            
            let segImage = UIImageView()
            segImage.frame = CGRect(x: segImagePoints[i][0], y: segImagePoints[i][1], width: segImageSizes[i][0], height: segImageSizes[i][1])
            segImage.image = UIImage(named: segImages[i] + ".png")
            segImage.layer.zPosition = 2
            segControl.addSubview(segImage)
            
            let segLabel = UILabel()
            segLabel.frame = CGRect(x: segLabelPoints[i][0], y: segLabelPoints[i][1], width: 50, height: 10)
            segLabel.textColor = .white
            segLabel.font = UIFont(name: "Helvetica", size: 12)
            segLabel.textAlignment = .center
            segLabel.text = segLabelTexts[i]
            segLabel.layer.zPosition = 2
            segControl.addSubview(segLabel)

        }

        //設定scrollView
        fullSize = myScrollView.frame.size
        myScrollView.contentSize = CGSize(width: fullSize.width * 4, height: fullSize.height)
        myScrollView.delegate = self
        
        //設定scrollView文字
        let levelLabelTexts = ["英檢初級","英檢中級","多益單字","托福單字"]
        
        for i in 0...3 {
            
            let levelLabel = UILabel()
            
            let xPosition = myScrollView.frame.width * CGFloat(i)
            levelLabel.frame = CGRect(x: xPosition + 70, y: 0, width: self.myScrollView.frame.width - 150, height: self.myScrollView.frame.height)
            levelLabel.text = levelLabelTexts[i]
            levelLabel.font = UIFont(name: "Helvetica", size: 20)
            levelLabel.textColor = .white
            levelLabel.textAlignment = .center
            
            myScrollView.contentSize.width = myScrollView.frame.width * CGFloat(i + 1)
            myScrollView.addSubview(levelLabel)
     
        }
        //scrollView的func
        myPageController.addTarget(self, action: #selector(WordBookViewController.pageChanged), for: .valueChanged)
        
        //讀取所有單字
        //用目前的spotNumber:gameNumber來抓已解鎖幾關, 把所有的單字都抓出來後顯示
        
        for (s,g) in [1:2]{
            
            //讀取已完整的所有字集
            for i in 0 ..< (s + 1){
                
                var wordFile:String?
                
                let name = "1-" + String(i + 1)
                
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
                
                
                
            }
            
            //再來讀取殘餘的英文字
            
            
            
            
            
        }
        
        print(wordSets)
        
        //讀取英文字
        for i in 0 ..< wordSets.count{
            for w in 0 ..< 30{
                
                engWordsToShow.append(wordSets[i][w])
                
            }
            
            for c in 30 ..< 60{
                
                chiWordsToShow.append(wordSets[i][c])
            }
            
            for p in 90 ..< 120{
                
                partOfSpeechToShow.append(wordSets[i][p])
            }
            
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //用滑的換頁
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        myPageController.currentPage = page
        print(page)
        
    }
    
    //用點的換頁
    @objc func pageChanged(sender: UIPageControl) {
        // 依照目前圓點在的頁數算出位置
        var frame = myScrollView.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        
        // 再將 UIScrollView 滑動到該點
        myScrollView.scrollRectToVisible(frame, animated:true)
        print("current:\(sender.currentPage)")
    }

    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return engWordsToShow.count
        
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath)
        //cell背景顏色透明
        cell.backgroundColor = .clear
        
        let engWordLabel = cell.viewWithTag(2) as! UILabel
        let chiWordLabel = cell.viewWithTag(3) as! UILabel
        
        let engWord = engWordsToShow[indexPath.row]
        engWordLabel.text = engWord
        let chiWord = chiWordsToShow[indexPath.row]
        let partOfSpeech = partOfSpeechToShow[indexPath.row].replacingOccurrences(of: "\r\n", with: "")
        chiWordLabel.text = "(" + partOfSpeech + ")" + " " +  chiWord
        
        return cell
    }
    
    //cell的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
        
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
    }
    
    @IBAction func autoplayClicked(_ sender: Any) {
    }
    
}
