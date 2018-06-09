//
//  ChartViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/5/23.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    @IBOutlet weak var chartBg: UIImageView!
    
    @IBOutlet weak var chartTableView: UITableView!
    

    @IBOutlet weak var chart0Btn: UIButton!
    @IBOutlet weak var chart1Btn: UIButton!
    
    @IBOutlet weak var chart2Btn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    var dif = CGFloat()
    var photoDif = CGFloat()
    var usernames = [String]()
    var scores = [String]()
    var avas = [String]()
    var wordCounts = [Int]()
    var wordReviewCounts = [Int]()
    var senReviewCounts = [Int]()
    let grassGreen = UIColor.init(red: 215/255, green: 1, blue: 0, alpha: 1)
    var rankMode = Int()
    
    let lightGrayColor = UIColor.init(red: 206/255, green: 208/255, blue: 208/255, alpha: 1)
    
    
    
        var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        switch height {
        case 812:
            
            
            dif = 1.1
            photoDif = 1
            
        case 736:
            
            dif = 1
            photoDif = 1
            
        case 667:
            
            dif = 1
            photoDif = 0.8
            
        case 568:
            

            dif = 1
            photoDif = 0.7
        default:
            dif = 1
            photoDif = 0.7
            
        }
        
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.layer.zPosition = 15
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.addSubview(activityIndicator)
        
        chartBg.frame = CGRect(x: 0, y: 0, width: width, height: height)
        chartBg.contentMode = .scaleAspectFill
        
        chartTableView.frame = CGRect(x: 0, y: height / 10, width: width, height: height * 9 / 10)
        
        chartTableView.backgroundColor = .clear
        
        /*
        chartTitle.frame = CGRect(x: width / 2 - 50, y: chartTableView.frame.minY / 3, width: 100, height: 33)
        //chartTitle.backgroundColor = .red
        chartTitle.textAlignment = .center
        */
        backBtn.frame = CGRect(x: width / 30, y: height / 30, width: 19 * dif, height: 31 * dif)
        
        
        chart0Btn.frame = CGRect(x: width / 3 - 75, y: chartTableView.frame.minY / 3.3, width: 75, height: 50)
        chart0Btn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        chart0Btn.titleLabel?.textAlignment = .center
        chart0Btn.setTitle("總分\n排行榜", for:.normal)
        //chart0Btn.backgroundColor = .red
        
        chart1Btn.frame = CGRect(x: width / 2 - 30, y: chartTableView.frame.minY / 3.3, width: 75, height: 50)
        chart1Btn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        chart1Btn.titleLabel?.textAlignment = .center
        chart1Btn.setTitle("英文\n拼字王", for:.normal)
        //chart1Btn.backgroundColor = .red
        
        
        chart2Btn.frame = CGRect(x: width - 75 * 1.5, y: chartTableView.frame.minY / 3.3, width: 75, height: 50)
        chart2Btn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        chart2Btn.titleLabel?.textAlignment = .center
        chart2Btn.setTitle("句型\n冠軍榜", for:.normal)
        //chart2Btn.backgroundColor = .red
        
    }
    
    
    @IBAction func chart2Clicked(_ sender: Any) {
        
        
        chart2Btn.setTitleColor(grassGreen, for: .normal)
        chart1Btn.setTitleColor(lightGrayColor, for: .normal)
        chart0Btn.setTitleColor(lightGrayColor, for: .normal)
        
        rankMode = 2
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        rankReview(type: 1)
        
    }
    
    @IBAction func chart1Clicked(_ sender: Any) {
        
        chart1Btn.setTitleColor(grassGreen, for: .normal)
        chart0Btn.setTitleColor(lightGrayColor, for: .normal)
        chart2Btn.setTitleColor(lightGrayColor, for: .normal)
       // self.view.isUserInteractionEnabled = false
        
        rankMode = 1
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        disableBtns()
        rankReview(type: 0)
        
    }
    @IBAction func chart0Clicked(_ sender: Any) {
        
        chart0Btn.setTitleColor(grassGreen, for: .normal)
        chart1Btn.setTitleColor(lightGrayColor, for: .normal)
        chart2Btn.setTitleColor(lightGrayColor, for: .normal)
       // self.view.isUserInteractionEnabled = false
        rankMode = 0
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        disableBtns()
        rankUsers()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        chart0Btn.setTitleColor(grassGreen, for: .normal)
        chart1Btn.setTitleColor(lightGrayColor, for: .normal)
        chart2Btn.setTitleColor(lightGrayColor, for: .normal)
      //  self.view.isUserInteractionEnabled = false
        rankMode = 0
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        disableBtns()
     rankUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usernames.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let cell = tableView.dequeueReusableCell(withIdentifier: "chartCell", for: indexPath) as! ChartTableViewCell
        
        cell.backgroundColor = .clear
        
        cell.rankLabel.text = String(indexPath.row + 1)
        cell.usernameLabel.text = usernames[indexPath.row]
        
        if rankMode == 0 {
        cell.totalScoreLabel.text = scores[indexPath.row]
        cell.wordCountLabel.text = String(wordCounts[indexPath.row])
            cell.wordCountTitleLabel.text = "單字量"
        } else if rankMode == 1 {
            
            cell.totalScoreLabel.text = ""
            cell.wordCountTitleLabel.text = "單字達成"
            cell.wordCountLabel.text = String(wordReviewCounts[indexPath.row])
            
            
        } else if rankMode == 2 {
            
            cell.totalScoreLabel.text = ""
            cell.wordCountTitleLabel.text = "句型達成"
            cell.wordCountLabel.text = String(senReviewCounts[indexPath.row])
      
        }
        
        if avas[indexPath.row] != "" {
            print("ava not nil")
           // let newString = avas[indexPath.row].replacingOccurrences(of: "__", with: "&")
         
                let imageUrl = URL(string: avas[indexPath.row])!
            
                // get data from image url
                let imageData = try? Data(contentsOf: imageUrl)
                
                // if data is not nill assign it to ava.Img
                if imageData != nil {
                    
                    
                    print("imgData not nil")
                    
                    DispatchQueue.main.async(execute: {[weak self] in
                        cell.avaImg.image = UIImage(data: imageData!)
                        
                        self!.activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        //self!.view.isUserInteractionEnabled = true
                        self!.enableBtns()
                    })
                }
                
                
            } else {
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            //self!.view.isUserInteractionEnabled = true
            enableBtns()
                
                cell.avaImg.image = UIImage(named: "avatar.png")
            }
    
        
        
               return cell
        
    }
        
 

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return height / 8
        
    }
    
    
    func enableBtns(){
        
        chart0Btn.isEnabled = true
        chart1Btn.isEnabled = true
        chart2Btn.isEnabled = true
        
    }
    
    func disableBtns(){
        
        chart0Btn.isEnabled = false
        chart1Btn.isEnabled = false
        chart2Btn.isEnabled = false
        
    }
    func rankReview(type:Int){
        
        // url to access our php file
        var urlString = String()
        
        if type == 0 {
        urlString = "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/rankReviewWords.php"
        } else if type == 1{
            
        urlString = "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/rankReviewSens.php"
        }
    

        
        let url = URL(string: urlString)!
        // request url
        var request = URLRequest(url: url)
        
        // method to pass data POST - cause it is secured
        request.httpMethod = "GET"
        
        // append body to our request that gonna be sent
        //request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {[weak self] data, response, error in
            // no error
            if error == nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [NSDictionary]
                    
                    guard let parseJSON = json else {
                        print("Error while parsing")
                        
                        self!.enableBtns()
                        self!.activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                        return
                    }
                    
                    print("rank")
                    //再次儲存使用者資訊
                    
                    //print(parseJSON)
                    
                    
                    self!.usernames.removeAll(keepingCapacity: false)
                    self!.avas.removeAll(keepingCapacity: false)
                    self!.wordReviewCounts.removeAll(keepingCapacity: false)
                    self!.senReviewCounts.removeAll(keepingCapacity: false)
                    self!.wordCounts.removeAll(keepingCapacity: false)
                    self!.scores.removeAll(keepingCapacity: false)
                    
                    for i in 0 ..< parseJSON.count{
                        
                        
                        if let username = parseJSON[i]["nickname"] as? String{
                            
                            self!.usernames.append(username)
                            
                        }
                        
                        if let ava = parseJSON[i]["ava"] as? String{
                            
                            let newAva = ava.replacingOccurrences(of: "__", with: "&")
                            
                            self!.avas.append(newAva)
                            
                        }
                        
                        
                         if let wordCounts = parseJSON[i]["wordReviewCounts"] as? Int{
                   
                            self!.wordReviewCounts.append(wordCounts)
                            
                         }
                         
                         
                         if let senCounts = parseJSON[i]["senReviewCounts"] as? Int{
                         
                         
                            self!.senReviewCounts.append(senCounts)
                         
                         }
              
                    

                    DispatchQueue.main.async(execute: {
                        
                        
                        self!.chartTableView.reloadData()

                        
                        //self!.view.isUserInteractionEnabled = true
    
                    })
                    
                    }
                    
                } catch{
                    
                    print("catch error")
                     self!.enableBtns()
                    self!.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                 //   self!.view.isUserInteractionEnabled = true
                    
                }
            } else {
                
                print("urlsession has error")
                 self!.enableBtns()
                self!.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
               // self!.view.isUserInteractionEnabled = true
                
            }
        }).resume()
        
    }
    
    
    func rankUsers(){
        
        // url to access our php file
        let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/rankUser.php")!
        
        // request url
        var request = URLRequest(url: url)
        
        // method to pass data POST - cause it is secured
        request.httpMethod = "GET"
        
        // append body to our request that gonna be sent
        //request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {[weak self] data, response, error in
            // no error
            if error == nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [NSDictionary]
                    
                    guard let parseJSON = json else {
                        print("Error while parsing")
                         self!.enableBtns()
                        self!.activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                        return
                    }
                    
                    print("rank")
                    //再次儲存使用者資訊

                    //print(parseJSON)

                    
                    
                    
                    self!.usernames.removeAll(keepingCapacity: false)
                    self!.avas.removeAll(keepingCapacity: false)
                    self!.wordReviewCounts.removeAll(keepingCapacity: false)
                    self!.senReviewCounts.removeAll(keepingCapacity: false)
                    self!.wordCounts.removeAll(keepingCapacity: false)
                    self!.scores.removeAll(keepingCapacity: false)
                    
                    for i in 0 ..< parseJSON.count{
                        
                        
                        if let username = parseJSON[i]["nickname"] as? String{
                 
                            self!.usernames.append(username)

                        }
                        
                        if let ava = parseJSON[i]["ava"] as? String{

                            let newAva = ava.replacingOccurrences(of: "__", with: "&")
                            
                            self!.avas.append(newAva)
                       
                        }
                        
                        /*
                        if let wordCounts = parseJSON[i]["wordReviewCounts"] as? Int{
                           newDic![i]["wordCounts"] = String(wordCounts)
                        }
                        
                        
                        if let senCounts = parseJSON[i]["senReviewCounts"] as? Int{
                            
                                             newDic![i]["senCounts"] = String(senCounts)
                            
                            
                        }
         
                        */
    
                        
                        if let score = parseJSON[i]["score"] as? Int{
                            
                            self!.scores.append(String(score))
                        }
                        
                       
                        print(self!.avas)
                      
                        var mapWord = Int()
                        var mapWord2 = Int()
                        
                        
                        if let mapPassed = parseJSON[i]["mapPassed"] as? String{
                            mapWord = Int(mapPassed)! * 450
                            
                        }
                        if let mapPassed2 = parseJSON[i]["mapPassed2"] as? String{
                            mapWord2 = Int(mapPassed2)! * 420
                        }
                        
                        /*
                        if let mapPassed3 = user["mapPassed3"] as? String{
                          
                            
                        }
                        if let mapPassed4 = user["mapPassed4"] as? String{
                      
                            
                        }
                        */
                        var gameWord = Int()
                        var gameWord2 = Int()
                      
                        if let gamePassed = parseJSON[i]["gamePassed"] as? String{
                            
                            let sep = gamePassed.components(separatedBy: ":")
                            gameWord = Int(sep[0])! * 30 + Int(sep[1])! * 3
                            
       
                        }
                        if let gamePassed2 = parseJSON[i]["gamePassed2"] as? String{
                
                            let sep = gamePassed2.components(separatedBy: ":")
                            gameWord2 = Int(sep[0])! * 30 + Int(sep[1])! * 3
                            
                        }
                        
                        
                        let totalWordCount = mapWord + mapWord2 + gameWord + gameWord2
                        self!.wordCounts.append(totalWordCount)
                        /*
                        if let gamePassed3 = parseJSON[i]["gamePassed3"] as? String{
                      
                            
                        }
                        if let gamePassed4 = parseJSON[i]["gamePassed4"] as? String{
                        
                            
                        }
                        */

                    }

  

                    DispatchQueue.main.async(execute: {
                        self!.chartTableView.reloadData()
     

                    })
                   
                    
                } catch{
                    
                    print("catch error")
                     self!.enableBtns()
                    self!.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    //self!.view.isUserInteractionEnabled = true
                    
                }
            } else {
                
                print("urlsession has error")
                 self!.enableBtns()
                self!.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                //self!.view.isUserInteractionEnabled = true
                
            }
        }).resume()
        
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
