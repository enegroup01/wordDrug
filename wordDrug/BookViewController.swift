//
//  BookViewController.swift
//  wordDrug
//
//  Created by Ethan on 2017/11/14.
//  Copyright © 2017年 playplay. All rights reserved.
//

import UIKit

class BookViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource {
    
    //暫時使用的單字
    var wordSets = [String]()
    //要show的字內容
    var engWordsToShow = [String]()
    var chiWordsToShow = [String]()
    var partOfSpeechToShow = [String]()
    
    //目前所有音節
    /*
    let syllableSets = [["ab1","ac1","ad1","a_e1","af1","ai1","al1","am1","an1","any1"],["ap1","ar1","as1","at1","au1","aw1","ay1","ba1","be1","bi1"],["bit1","bl1","bo1","br1","bu1","by1","ce1","ch1","ci1","ble1"],["ck1","cl1","co1","com1","con1","cian1","cr1","ct1","de1","di1"],["do1","dr1","dy1","dis1","ea1","ee1","el1","em1","en1","er1"],["et1","ew1","ex1","ey1","fi1","fl1","fo1","fr1","ft1","ful1"],["ge1","gi1","gl1","go1","gr1","he1","hi1","id1","ie1","igh1"],    ["il1","im1","in1","ing1","ir1","is1","ject1","kn1","le1","li1"],["ly1","mi1","nd1","no1","nt1","oa1","ob1","oe1","of1","oi1"],["old1","on1","ong1","oo1","op1","or1","ot1","ou1","ow1","oy1"],["ph1","pi1","pl1","pr1","rare1","re1","ro1","ry1","sh1","si1"],["sk1","so1","sp1","st1","sion1","th1","ti1","tion1","tive1","tle1"],["to1","tr1","ture1","ty1","ub1","ue1","ui1","um1","un1","up1"],["ur1","ut1","war1","wh1","ab2","ac2","ad2","a_e2","af2","ai2"]]
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
    
    //匯入所有的音節array
    var allSyllables = [String]()
    
    //特殊色
    let lightCyan = UIColor.init(red: 154/255, green: 1, blue: 1, alpha: 1)
    let lightYellow = UIColor.init(red: 1, green: 228/255, blue: 167/255, alpha: 1)
    let darkYellow = UIColor.init(red: 117/255, green: 100/255, blue: 61/255, alpha: 1)
    
    @IBOutlet weak var topColumnView: UIImageView!
    @IBOutlet weak var bgView: UIImageView!
    
    @IBOutlet weak var elementView: UICollectionView!
    @IBOutlet weak var wordView: UITableView!
    @IBOutlet weak var worldButtonView: UIButton!
    
    @IBOutlet weak var rightButtonView: UIButton!
    @IBOutlet weak var leftButtonView: UIButton!
    @IBOutlet weak var bottomColumnView: UIImageView!
    
    //紀錄所有顏色
    var cellColors = [Int]()
    var labelColors = [Int]()
    
    //所有得到的元素
    var allGetElements = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        //背景
        let bgImage = UIImage(named: "bookBg.png")
        bgView.image = bgImage
        
        //上方
        let topColumnImage = UIImage(named: "topColumn.png")
        topColumnView.image = topColumnImage
        
        //底部
        let bottomColumnImage = UIImage(named: "bottomColumn.png")
        bottomColumnView.image = bottomColumnImage
        
        //單字區
        let wordViewImage = UIImage(named: "wordBg.png")
        wordView.backgroundView = UIImageView(image: wordViewImage)
        
        //透明背景
        elementView.backgroundColor = .clear
        
        
        //把所有部首加入到一個array
        for i in syllableSets{
            
            for s in i {
                
                allSyllables.append(s)
                
            }
        }
        
        //設定所有外框為暗色
        for _ in 0 ..< 140{
            cellColors.append(0)
            labelColors.append(0)
        }
        
        //抓使用者得到的元素
        let getElemets = user?["getElement"] as! String
        
        //做成新的array
        allGetElements = getElemets.components(separatedBy: ";")
        
        for i in 0 ..< allSyllables.count{
            
            if allGetElements.contains(allSyllables[i]){
                labelColors[i] = 1

            }
        }
        
        
    }
    @IBAction func rightButtonClicked(_ sender: Any) {
    }
    
    
    @IBAction func leftButtonClicked(_ sender: Any) {
    }
    
    @IBAction func worldButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //單字區的行數
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //cell背景顏色透明
        cell.backgroundColor = .clear
        
        //設定label的參數
        let wordLabel = cell.viewWithTag(1) as! UILabel
        wordLabel.textColor = lightCyan
        wordLabel.adjustsFontSizeToFitWidth = true
        
        //顯示單字資訊
        if engWordsToShow.count > 0 {
            let engWord = engWordsToShow[indexPath.row]
            let chiWord = chiWordsToShow[indexPath.row]
            let partOfSpeech = partOfSpeechToShow[indexPath.row]
            
            wordLabel.text = engWord + " " + partOfSpeech + " " + chiWord
            
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //元素表數量
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return allSyllables.count
        
    }
    
    
    
    // 每個 cell 要顯示的內容
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            
            let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: "elementCell", for: indexPath as IndexPath)
            
            //設定外框顏色
            let darkElementFrameImage = UIImage(named: "darkElementFrame.png")
            let lightElementFrameImage = UIImage(named: "lightElementFrame.png")
            
            //設定外框
            let bgImageView = cell.viewWithTag(3) as! UIImageView
            
            //抓有沒有按到
            if cellColors[indexPath.row] == 0 {
                bgImageView.image = darkElementFrameImage
            } else {
                
                bgImageView.image = lightElementFrameImage
                
            }
            
            //設定元素字label
            let elementLabel = cell.viewWithTag(1) as! UILabel
            //設定元素號碼小Label
            let elementLevelLabel = cell.viewWithTag(2) as! UILabel
            
            //所有輪到要顯示的元素
            let element = allSyllables[indexPath.row]
            
            //確認是否有得到該元素
            if labelColors[indexPath.row] == 1 {
                    //設定顏色
                    elementLevelLabel.textColor = lightYellow
                    elementLabel.textColor = lightYellow
            } else {
                    //設定顏色
                    elementLevelLabel.textColor = darkYellow
                    elementLabel.textColor = darkYellow
            }
            
            //純元素沒數字
            let elementWithoutDigit = (element.components(separatedBy: NSCharacterSet.decimalDigits) as NSArray).componentsJoined(by: "")
            
            let elementWithoutLetter = (element.components(separatedBy: NSCharacterSet.letters) as NSArray).componentsJoined(by: "")
            //純數字
            let elementWithoutLetterAndUnderline = elementWithoutLetter.replacingOccurrences(of: "_", with: "")
            
            //在label裡顯示
            elementLabel.text = elementWithoutDigit
            elementLevelLabel.text = elementWithoutLetterAndUnderline

            return cell
            
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = elementView.cellForItem(at: indexPath)
        
        //設定外框顏色
        let lightCellFrameImage = UIImage(named: "lightElementFrame")
        let darkElementFrameImage = UIImage(named: "darkElementFrame.png")
        
        //抓所有看得見的cell
        let visibleCells = elementView.visibleCells
        
        //把所有看得見的cell做成暗色, 用這個方式不要每一個cell都變色一次會lag
        for cell in visibleCells{
            let imageView = cell.viewWithTag(3) as! UIImageView
            imageView.image = darkElementFrameImage
            
        }
        
        //指定按到的imageView
        let bgImageView = cell?.viewWithTag(3) as! UIImageView
        //按到的變亮
        bgImageView.image = lightCellFrameImage
        
        
        //取消其他的亮光數字
        for i in 0 ..< cellColors.count{
            cellColors[i] = 0
        }
        
        //保持著亮光
        cellColors[indexPath.row] = 1
        
        
        //讀取Bundle裡的文字檔, 用來顯示在上方
        var wordFile:String?
        
        let fileNumber = Int(indexPath.row / 10) + 1
        let name = "1-" + String(fileNumber)

        if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
            engWordsToShow.removeAll(keepingCapacity: false)
            chiWordsToShow.removeAll(keepingCapacity: false)
            partOfSpeechToShow.removeAll(keepingCapacity: false)
            
            do {
                wordFile = try String(contentsOfFile: filepath)
                let words = wordFile?.components(separatedBy: "; ")
                
                //把字讀取到wordSets裡
                wordSets = words!
                
                //抓正確的字順序
                let divideNumber = wordSets.count / 4
                
                //sequence是以10為單位所以取餘數
                let unitSequence = indexPath.row % 10
                
                let currentEngSequence = unitSequence * 3
                
                //抓三個英文字
                for i in currentEngSequence ..< unitSequence * 3 + 3{
                    
                    let word = wordSets[i]
                    let wordWithoutSpace = word.replacingOccurrences(of: " ", with: "")
                    engWordsToShow.append(wordWithoutSpace)
                    
                }
                
               //抓三個中文字
                for i in (currentEngSequence + divideNumber) ..< (unitSequence * 3 + 3 + divideNumber) {
                    let word = wordSets[i]
                    chiWordsToShow.append(word)
                }
                
                //抓三個詞性
                for i in (currentEngSequence + divideNumber * 3) ..< (unitSequence * 3 + 3 + divideNumber * 3){
                    let partOfSpeech = wordSets[i]
                    partOfSpeechToShow.append(partOfSpeech)
                    
                }
                
                
                //重讀字的位置
                wordView.reloadData()
                
            } catch {
                // contents could not be loaded
            }
        } else {
            // example.txt not found!
        }
    }
}
