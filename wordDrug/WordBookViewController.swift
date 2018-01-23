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
        
        return 10
        
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath)
        //cell背景顏色透明
        cell.backgroundColor = .clear
        
        
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
