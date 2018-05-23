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
    
    
    @IBOutlet weak var chartTitle: UILabel!
    
    @IBOutlet weak var backBtn: UIButton!
    var dif = CGFloat()
    var photoDif = CGFloat()
    var usernames = [String]()
    var scores = [String]()
    var avas = [String]()
    var wordCounts = [Int]()
    
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
        
        chartBg.frame = CGRect(x: 0, y: 0, width: width, height: height)
        chartBg.contentMode = .scaleAspectFill
        
        chartTableView.frame = CGRect(x: 0, y: height / 10, width: width, height: height * 9 / 10)
        
        chartTableView.backgroundColor = .clear
        
        chartTitle.frame = CGRect(x: width / 2 - 50, y: chartTableView.frame.minY / 3, width: 100, height: 33)
        //chartTitle.backgroundColor = .red
        chartTitle.textAlignment = .center
        
        backBtn.frame = CGRect(x: width / 30, y: height / 30, width: 19 * dif, height: 31 * dif)
        
        
    
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        cell.totalScoreLabel.text = scores[indexPath.row]
        cell.wordCountLabel.text = String(wordCounts[indexPath.row])
        
        
        if avas[indexPath.row] != "" {
                
                let imageUrl = URL(string: avas[indexPath.row])!
                // get data from image url
                let imageData = try? Data(contentsOf: imageUrl)
                
                // if data is not nill assign it to ava.Img
                if imageData != nil {
                    DispatchQueue.main.async(execute: {
                        cell.avaImg.image = UIImage(data: imageData!)
                    })
                }
                
                
            } else {
                
                cell.avaImg.image = UIImage(named: "avatar.png")
            }
    
               return cell
        
    }
        
 

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return height / 8
        
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
                        
                        //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                        return
                    }
                    
                    print("rank")
                    //再次儲存使用者資訊

                    //print(parseJSON)
                    
                    for eachUser in parseJSON{
                        
                        if let username = eachUser["username"] as? String{
                            
                            self!.usernames.append(username)
                            
                        }
                        
                        if let score = eachUser["score"] as? Int{
                            
                            self!.scores.append(String(score))
                        }
                        
                        if let ava = eachUser["ava"] as? String{
                            
                            self!.avas.append(ava)
                        }
                        print(self!.avas)
                      
                        var mapWord = Int()
                        var mapWord2 = Int()
                        
                        
                        if let mapPassed = eachUser["mapPassed"] as? String{
                            mapWord = Int(mapPassed)! * 450
                            
                        }
                        if let mapPassed2 = eachUser["mapPassed2"] as? String{
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
                      
                        if let gamePassed = eachUser["gamePassed"] as? String{
                            
                            let sep = gamePassed.components(separatedBy: ":")
                            gameWord = Int(sep[0])! * 30 + Int(sep[1])! * 3
                            
       
                        }
                        if let gamePassed2 = eachUser["gamePassed2"] as? String{
                
                            let sep = gamePassed2.components(separatedBy: ":")
                            gameWord2 = Int(sep[0])! * 30 + Int(sep[1])! * 3
                            
                        }
                        
                        
                        let totalWordCount = mapWord + mapWord2 + gameWord + gameWord2
                        self!.wordCounts.append(totalWordCount)
                        /*
                        if let gamePassed3 = user["gamePassed3"] as? String{
                      
                            
                        }
                        if let gamePassed4 = user["gamePassed4"] as? String{
                        
                            
                        }
                        */
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                    

                    DispatchQueue.main.async(execute: {
                         self!.chartTableView.reloadData()
                    })
                   
                    print(self!.avas.count)
                    
                } catch{
                    
                    print("catch error")
                    
                }
            } else {
                
                print("urlsession has error")
                
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
