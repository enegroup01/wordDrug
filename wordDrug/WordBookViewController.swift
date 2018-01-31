//
//  WordBookViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/1/23.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class WordBookViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    
    //背景
    @IBOutlet weak var wordBookBg: UIImageView!
    
    //可左右的view, 選擇單字等級
    @IBOutlet weak var myScrollView: UIScrollView!
    
    //下方的點點
    @IBOutlet weak var myPageController: UIPageControl!
    
    //設定seg的高度
    @IBOutlet weak var segHeight: NSLayoutConstraint!
    
    //自動播放鍵
    @IBOutlet weak var autoplayBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //seg控制
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
    
    //所有的單字的array
    var wordSets = [[String]]()
    //殘值的字的array
    var tempWordSets = [[String]]()
    
    //所有背過的單字, 中文, 詞性, 音節
    var engWordsToShow = [String]()
    var chiWordsToShow = [String]()
    var partOfSpeechToShow = [String]()
    var syllablesToShow = [String]()
    
    //我的最愛
    var myFavWords = [String]()
    var myWrongWords = [String]()
    
    var myFavEngWordsToShow = [String]()
    var myFavChiWordsToShow = [String]()
    var myFavPartOfSpeechToShow = [String]()
    var myFavSyllablesToShow = [String]()
    
    var myWrongEngWordsToShow = [String]()
    var myWrongChiWordsToShow = [String]()
    var myWrongPartOfSpeechToShow = [String]()
    var myWrongSyllablesToShow = [String]()
    
    var engWordsSelected = [String]()
    var chiWordsSelected = [String]()
    var partOfSpeechSelected = [String]()
    var syllablesSelected = [String]()
    
    //我的最愛圖片是否要顯示的array
    var myFavImgs = [Int]()
    
    var location = CGPoint()
    
  
    var activityIndicator = UIActivityIndicatorView()
    
    var likeMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.layer.zPosition = 15
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.addSubview(activityIndicator)

        
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

        //設定segControl
        segControl.addTarget(self, action: #selector(WordBookViewController.segSelected), for: .valueChanged)
        
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
        
        let fakeGamePassed = gamePassed!
        for (s,_) in fakeGamePassed{
            
            //讀取已完整的所有字集
            for i in 0 ..< (s){
                
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
            var wordFile:String?
            
            //讀取最新一層的字
            let name = "1-" + String(s + 1)
            
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
       
        }
        
        //抓所有單字
        //Part 1. 抓完整值
        for i in 0 ..< wordSets.count{
            for w in 0 ..< 30{
                
                engWordsToShow.append(wordSets[i][w])
                
                let syllableSequence = Int(w / 3)
                syllablesToShow.append(syllableSets[i][syllableSequence])

            }
            
            for c in 30 ..< 60{
                
                chiWordsToShow.append(wordSets[i][c])
            }
            
            for p in 90 ..< 120{
                
                partOfSpeechToShow.append(wordSets[i][p])
            }
            
        }
        
        //Part 2. 抓殘值 ＆ 抓可能出現錯字的最新三個
        for (s,g) in fakeGamePassed{
        
        for w in 0 ..< ((g + 1) * 3){
            engWordsToShow.append(tempWordSets[0][w])
            let syllableSequence = Int(w / 3)
            syllablesToShow.append(syllableSets[s][syllableSequence])
        }
        for w in 30 ..< (30 + (g + 1) * 3){
            chiWordsToShow.append(tempWordSets[0][w])
        }
  
        for w in 90 ..< (90 + (g + 1) * 3){
            partOfSpeechToShow.append(tempWordSets[0][w])
        }
            
        }
        
        
        
        //載入我的最愛單字
        if let myWordsString = user!["myWords"] as! String?{
            myFavWords = myWordsString.components(separatedBy: ";")
        }
        
        //載入我的錯誤單字
        if let myWrongWordsString = user!["wrongWords"] as! String?{
            myWrongWords = myWrongWordsString.components(separatedBy: ";")
            
        }
        
        //填入所有字的數量, 等等準備抓我的最愛的部分
        for _ in 0 ..< engWordsToShow.count - 3{
            myFavImgs.append(0)
        }
        
        
        //從所有的單字裡去找match到的我的最愛單字
        for i in 0 ..< engWordsToShow.count{
            
            //這個完整字沒有拆音節
            let word = engWordsToShow[i].replacingOccurrences(of: " ", with: "")
            let chiWord = chiWordsToShow[i]
            let partOfSpeech = partOfSpeechToShow[i]
            let syllables = syllablesToShow[i]
            //這個字才有拆音節
            let wordToAppend = engWordsToShow[i]
            
            for myWord in myFavWords{
                
                if myWord == word {
                    
                    myFavEngWordsToShow.append(wordToAppend)
                    myFavChiWordsToShow.append(chiWord)
                    myFavPartOfSpeechToShow.append(partOfSpeech)
                    myFavSyllablesToShow.append(syllables)
                    
                    //抓全部單字要反紅的部分
                    myFavImgs[i] = 1
                    
                }
                
            }
            
            //抓我的錯字
            for myWrongWord in myWrongWords{
                
                if myWrongWord == word {
                    
                    myWrongEngWordsToShow.append(wordToAppend)
                    myWrongChiWordsToShow.append(chiWord)
                    myWrongPartOfSpeechToShow.append(partOfSpeech)
                    myWrongSyllablesToShow.append(syllables)
                    

                }
                
            }
            
        }
        
        print(myFavEngWordsToShow)
        print(myFavChiWordsToShow)
        print(myFavPartOfSpeechToShow)
        print(myFavSyllablesToShow)
        
        //設定好要show的第一組單字就是全部的單字
        engWordsSelected = engWordsToShow
        chiWordsSelected = chiWordsToShow
        partOfSpeechSelected = partOfSpeechToShow
        syllablesSelected = syllablesToShow
        
        
        //移除三個多增加的數量, 這三個是可能會錯的部分
        for  _ in 0 ..< 3 {
            engWordsSelected.removeLast()
        }
        

    }
    
    
    //再次載入所有單字裡我的最愛要反紅的字, 使用時機: 在我的最愛裡修改過後跳回所有單字
    func loadAllWordFavs(){
        
        //載入我的最愛單字
        if let myWordsString = user!["myWords"] as! String?{
            myFavWords = myWordsString.components(separatedBy: ";")
        }
        
        myFavImgs.removeAll(keepingCapacity: false)
        
        //填入所有字的數量, 等等準備抓我的最愛的部分
        for _ in 0 ..< engWordsToShow.count - 3{
            myFavImgs.append(0)

        }
        
        //去對有沒有符合我的最愛然後將其反紅
        for i in 0 ..< engWordsToShow.count{
            
            let word = engWordsToShow[i].replacingOccurrences(of: " ", with: "")
            
            for myWord in myFavWords{
                
                if myWord == word {

                    //抓全部單字要反紅的部分
                    myFavImgs[i] = 1
                    
                }
                
            }
        
        }
        
    }
    
    
    //讀取我的最愛的單字, 使用時機: (1) 在我的最愛裡刪除最愛單字, 做即時反應 (2) 其他時候跳轉到我的最愛畫面時
    func loadMyFavWords(){
        
        //載入我的最愛單字
        if let myWordsString = user!["myWords"] as! String?{
            myFavWords = myWordsString.components(separatedBy: ";")
        }

        //刪除所有已append的值
        myFavEngWordsToShow.removeAll(keepingCapacity: false)
        myFavChiWordsToShow.removeAll(keepingCapacity: false)
        myFavPartOfSpeechToShow.removeAll(keepingCapacity: false)
        myFavSyllablesToShow.removeAll(keepingCapacity: false)
        myFavImgs.removeAll(keepingCapacity: false)
        
        
        //所有單字反紅
        for _ in 0 ..< myFavWords.count{
            
            myFavImgs.append(1)
            
        }

        
        //以所有的單字來match我的最愛單字的資訊
        for i in 0 ..< engWordsToShow.count{
            
            let word = engWordsToShow[i].replacingOccurrences(of: " ", with: "")
            let chiWord = chiWordsToShow[i]
            let partOfSpeech = partOfSpeechToShow[i]
            let syllables = syllablesToShow[i]
            let wordToAppend = engWordsToShow[i]

            for myWord in myFavWords{
                
                if myWord == word {
                    
                    myFavEngWordsToShow.append(wordToAppend)
                    myFavChiWordsToShow.append(chiWord)
                    myFavPartOfSpeechToShow.append(partOfSpeech)
                    myFavSyllablesToShow.append(syllables)
                    
                    
                }
                
            }

        }

        //選擇好要show的單字
        engWordsSelected = myFavEngWordsToShow
        chiWordsSelected = myFavChiWordsToShow
        partOfSpeechSelected = myFavPartOfSpeechToShow
        syllablesSelected = myFavSyllablesToShow

        //不產生動畫的reload
        tableView.reloadData()

    }
    
    //載入錯誤單字, 使用時機: 移除錯誤單字即時顯示使用
    func loadMyWrongWords(){
        
        //載入我的錯誤單字
        if let myWrongWordsString = user!["wrongWords"] as! String?{
            myWrongWords = myWrongWordsString.components(separatedBy: ";")
            
        }
        
        myWrongEngWordsToShow.removeAll(keepingCapacity: false)
        myWrongChiWordsToShow.removeAll(keepingCapacity: false)
        myWrongPartOfSpeechToShow.removeAll(keepingCapacity: false)
        myWrongSyllablesToShow.removeAll(keepingCapacity: false)
        
        
        for i in 0 ..< engWordsToShow.count{
            
            let word = engWordsToShow[i].replacingOccurrences(of: " ", with: "")
            let chiWord = chiWordsToShow[i]
            let partOfSpeech = partOfSpeechToShow[i]
            let syllables = syllablesToShow[i]
            let wordToAppend = engWordsToShow[i]
            
            
            //抓我的錯字
            for myWrongWord in myWrongWords{
                
                if myWrongWord == word {
                    
                    myWrongEngWordsToShow.append(wordToAppend)
                    myWrongChiWordsToShow.append(chiWord)
                    myWrongPartOfSpeechToShow.append(partOfSpeech)
                    myWrongSyllablesToShow.append(syllables)
                    
                    
                }
                
                
            }
            
            
            
        }

        engWordsSelected = myWrongEngWordsToShow
        chiWordsSelected = myWrongChiWordsToShow
        partOfSpeechSelected = myWrongPartOfSpeechToShow
        syllablesSelected = myWrongSyllablesToShow
        
        tableView.reloadData()
        
    }
    
    //seg選項的func
    @objc func segSelected(sender:UISegmentedControl){
        
        //抓index
        let index = segControl.selectedSegmentIndex
        
        switch index{
            
        case 0:
            print("all words")
            
            //再次讀我的最愛反紅部分
            loadAllWordFavs()
            //切換到可以修改最愛的模式
            likeMode = true
            
            //設定要顯示的字
            engWordsSelected = engWordsToShow
            chiWordsSelected = chiWordsToShow
            partOfSpeechSelected = partOfSpeechToShow
            syllablesSelected = syllablesToShow
            
            //移除三個多增加的數量
            for  _ in 0 ..< 3 {
            engWordsSelected.removeLast()
            }
            
            tableView.reloadData()
        case 1:
            print("my Fav words")
            
            likeMode = true
            //把所有的func包起來, 供刪除最愛單字即時更新畫面使用
            loadMyFavWords()
            
        case 2:
            print("my Wrong Words")
            
            likeMode = false
            //讀取錯字
            loadMyWrongWords()
            
        default:
            break
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


    //確認有多少行
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{

        return engWordsSelected.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath) as! WordBookTableViewCell
        //cell背景顏色透明
        cell.backgroundColor = .clear
        
        //先設定好全部的TAG
        let syllableLabel = cell.viewWithTag(1) as! UILabel
        let syllableNumberLabel = cell.viewWithTag(5) as! UILabel
        let engWordLabel = cell.viewWithTag(2) as! UILabel
        let chiWordLabel = cell.viewWithTag(3) as! UILabel
        let heartImg = cell.viewWithTag(4) as! UIImageView
        
        //如果是在錯字區, 就顯示刪除鍵
        if segControl.selectedSegmentIndex == 2 {
            heartImg.image = UIImage(named: "crossBtn.png")
            
        } else {
        
        //在第1或第2區 我的最愛顯示反紅
        if myFavImgs[indexPath.row] == 0 {
            
            heartImg.image = UIImage(named: "unHeart.png")
            
        } else {
            
            heartImg.image = UIImage(named: "heart.png")
            
        }
        }
        
        //抓音節的字母 +  數字
        let syllableText = syllablesSelected[indexPath.row].components(separatedBy: .decimalDigits)
        let syllableNum = syllablesSelected[indexPath.row].replacingOccurrences(of: syllableText[0], with: "")
        
        //抓字
        let engWords = engWordsSelected[indexPath.row]
        //拆音節成array
        let engWordArray = engWords.components(separatedBy: " ")
        //定義母音
        let vowels = ["a","e","i","o","u"]
        
        //字型顏色
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 35), NSAttributedStringKey.foregroundColor : UIColor.cyan]
        let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 35), NSAttributedStringKey.foregroundColor : UIColor.white]
        let attrs3 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 35), NSAttributedStringKey.foregroundColor : UIColor.orange]
        
        //假如音節是_e, 另外處理
        if syllableText[0].contains("_") {
            
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
                            let word = NSMutableAttributedString(string: String(characters[0]), attributes: attrs3)
                            attrWords.append(word)
                            let word1 = NSMutableAttributedString(string: String(characters[1]), attributes: attrs2)
                            attrWords.append(word1)
                            let word2 = NSMutableAttributedString(string: String(characters[2]), attributes: attrs3)
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
                if engWord == syllableText[0]{
                    
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
        
        chiWordLabel.text = "(" + partOfSpeech + ")" + " " +  chiWord
        syllableLabel.adjustsFontSizeToFitWidth = true
        syllableLabel.text = syllableText[0]
        syllableNumberLabel.text = syllableNum
        
        
        //按讚及取消的function + 刪除的func
        cell.tapAction = {[weak self] (cell) in
            
            
            //刪除的func
            if self!.likeMode == false {
                
                print("delete mode")
                self!.activityIndicator.startAnimating()
                UIApplication.shared.beginIgnoringInteractionEvents()
                
                
                //抓字
                let word = self!.engWordsSelected[indexPath.row].replacingOccurrences(of: " ", with: "")
                
                //刪除錯字
                self!.removeWrongWord(word: word)
                

            } else {
        
            if self!.myFavImgs[indexPath.row] == 0{
                //加入最愛
                self!.activityIndicator.startAnimating()
                UIApplication.shared.beginIgnoringInteractionEvents()

                //更改顏色及加字
                self!.myFavImgs[indexPath.row] = 1
                
                let word = self!.engWordsSelected[indexPath.row].replacingOccurrences(of: " ", with: "")
                self!.addWord(word: word)
                
                //不產生動畫的reload
                UIView.performWithoutAnimation {
                    self!.tableView.reloadRows(at: [indexPath], with: .none)
                }

            } else {
                //取消最愛
                self!.activityIndicator.startAnimating()
                UIApplication.shared.beginIgnoringInteractionEvents()

                //更改顏色及刪除字
                self!.myFavImgs[indexPath.row] = 0
               
                let word = self!.engWordsSelected[indexPath.row].replacingOccurrences(of: " ", with: "")
                self!.removeWord(word: word)
                //不產生動畫的reload
                UIView.performWithoutAnimation {
                    self!.tableView.reloadRows(at: [indexPath], with: .none)
                }


            }
            }
  
        }
        
        return cell
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //cell的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //播放發音
        
        for touch in touches{
            
            location = touch.location(in: self.view)
          
        }
        
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func autoplayClicked(_ sender: Any) {
    }
    
    //新增最愛
    func addWord(word:String){
        
        
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
                        
                        DispatchQueue.main.async(execute: {
                            self!.activityIndicator.stopAnimating()
                            UIApplication.shared.endIgnoringInteractionEvents()
                        })
                    } catch{
                        
                        print("catch error")
                        
                        
                    }
                } else {
                    
                    print("urlsession has error")
                    
                }
            }).resume()
        
    }

    
    //刪除最愛單字
    func removeWord(word:String){
        

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
                    
                        DispatchQueue.main.async(execute: {
                            self!.activityIndicator.stopAnimating()
                            UIApplication.shared.endIgnoringInteractionEvents()
                            
                            
                            //如果剛好是在我的最愛, 那就即時更新畫面
                            if self!.segControl.selectedSegmentIndex == 1 {
                            
                                //載入我的最愛單字
                             self!.loadMyFavWords()
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

    //移除錯誤單字
    func removeWrongWord(word:String){
        
        
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
                    
                    DispatchQueue.main.async(execute: {
                        self!.activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        
                        self!.loadMyWrongWords()
                        
                        
                    })
                    
                    
                    
                } catch{
                    
                    print("catch error")
                    
                }
            } else {
                
                print("urlsession has error")
                
            }
        }).resume()
        
    }
    
}
