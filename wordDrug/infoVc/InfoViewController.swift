//
//  InfoViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/5/18.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    let darkColor = UIColor.init(red: 41/255, green: 56/255, blue: 87/255, alpha: 1)
    let midColor = UIColor.init(red: 138/255, green: 152/255, blue: 170/255, alpha: 1)
    let lightColor = UIColor.init(red: 196/255, green: 203/255, blue: 213/255, alpha: 1)
    let yellowColor = UIColor.init(red: 255/255, green: 182/255, blue: 13/255, alpha: 1)

    
    @IBOutlet weak var checkRankBtn: UIButton!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rankCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreCountLabel: UILabel!
    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var changePhotoBtn: UIButton!
    @IBOutlet weak var avaImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var infoTableView: UITableView!
    @IBOutlet weak var chartUpBg: UIImageView!
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    var dif = CGFloat()
    var photoDif = CGFloat()
    
    var sub1Rates = [78,40,95,68]
    var sub2Rates = [77,Int(),Int(),Int()]
    
    @IBOutlet weak var alphaLayer: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(user)
        
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
            photoDif = 1
            
        }


        // Do any additional setup after loading the view.
        chartUpBg.frame = CGRect(x: 0, y: 0, width: width, height: height / 2.2)
        infoTableView.frame = CGRect(x: 0, y: chartUpBg.frame.maxY, width: width, height: height - chartUpBg.frame.height)
        
        
        backBtn.frame = CGRect(x: width / 30, y: height / 30, width: 19 * dif, height: 31 * dif)
        titleLabel.frame = CGRect(x: backBtn.frame.maxX , y: backBtn.frame.maxY / 2, width: width - backBtn.frame.maxX * 2, height: 28 * dif)
        titleLabel.textAlignment = .center
        //titleLabel.backgroundColor = .red
        
        avaImg.frame = CGRect(x: width / 2 - (120 * dif * photoDif) / 2, y: titleLabel.frame.maxY * 1.7 * photoDif, width: 120 * dif * photoDif, height: 120 * dif * photoDif)
        
        avaImg.contentMode = .scaleAspectFill
        avaImg.layer.cornerRadius = avaImg.frame.width / 2
        avaImg.layer.masksToBounds = true
        
        let cgWhite = UIColor.white.cgColor
        
        avaImg.layer.borderColor = cgWhite
        avaImg.layer.borderWidth = 3
        
        changePhotoBtn.frame = CGRect(x: avaImg.frame.maxX - 28 * dif, y: avaImg.frame.maxY - 28 * dif, width: 28 * dif, height: 28 * dif)
        
        usernameLabel.frame = CGRect(x: 50, y: avaImg.frame.maxY + 30 * dif / 2, width: width - 100, height: 30 * dif)
        
        
        alphaLayer.frame = CGRect(x: 0, y: chartUpBg.frame.maxY - 60 * dif, width: width, height: 60 * dif)
        
        
        wordCountLabel.frame = CGRect(x: backBtn.frame.minX + 10 * dif, y: alphaLayer.frame.minY + 5 * dif, width: 90 * dif, height: 23 * dif)
        
        //wordCountLabel.backgroundColor = .green
        wordCountLabel.textAlignment = .center
        wordCountLabel.adjustsFontSizeToFitWidth = true
        
        wordLabel.frame = CGRect(x: wordCountLabel.frame.minX, y: wordCountLabel.frame.maxY + 5 * dif, width: 90 * dif, height: 23 * dif)
        
        //wordLabel.backgroundColor = .green
        wordLabel.textAlignment = .center
        wordLabel.adjustsFontSizeToFitWidth = true
        
        scoreCountLabel.frame = CGRect(x: width / 2 - 45 * dif, y: alphaLayer.frame.minY + 5 * dif, width: 90 * dif, height: 23 * dif)
        
        //scoreCountLabel.backgroundColor = .green
        scoreCountLabel.textAlignment = .center
        scoreCountLabel.adjustsFontSizeToFitWidth = true
        
        scoreLabel.frame = CGRect(x: scoreCountLabel.frame.minX, y: wordCountLabel.frame.maxY + 5 * dif, width: 90 * dif, height: 23 * dif)
        
        //scoreLabel.backgroundColor = .green
        scoreLabel.textAlignment = .center
        scoreLabel.adjustsFontSizeToFitWidth = true
        
        
        rankCountLabel.frame = CGRect(x: scoreCountLabel.frame.maxX + scoreCountLabel.frame.minX - wordCountLabel.frame.maxX, y: alphaLayer.frame.minY + 5 * dif, width: 90 * dif, height: 23 * dif)
        
        //rankCountLabel.backgroundColor = .green
        rankCountLabel.textAlignment = .center
        rankCountLabel.adjustsFontSizeToFitWidth = true
        
        rankLabel.frame = CGRect(x: rankCountLabel.frame.minX, y: wordCountLabel.frame.maxY + 5 * dif, width: 90 * dif, height: 23 * dif)
        
        //rankLabel.backgroundColor = .green
        rankLabel.textAlignment = .center
        rankLabel.adjustsFontSizeToFitWidth = true
        
        checkRankBtn.frame = CGRect(x: rankCountLabel.frame.maxX - 80 * dif, y: alphaLayer.frame.minY - 30 * dif, width: 80 * dif, height: 30 * dif)
        
        checkRankBtn.setTitleColor(yellowColor, for: .normal)
        //checkRankBtn.backgroundColor = .red
        
        /*
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    print("ok")
                } else {}
            })
        }
        */
        
        //getUserInfo()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let heightForRow = height / 4 / dif
        
        return heightForRow
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func changePhotoClicked(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        picker.allowsEditing = true
        picker.modalPresentationStyle = .overFullScreen
        
        
        
        self.present(picker, animated: true, completion: nil)
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoTableViewCell
        
        cell.backgroundColor = .clear
        
        
        
        let infoTitles = ["單字成就", "發音成就", "句型成就", "快速挑戰"]
        let sub1Titles = ["拼字正確率","發音正確率","排列正確率","正確關卡數"]
        let sub2Titles = ["中文正確率",String(),String(),String()]

        var totalRates = [Int(),Int(),Int(),Int()]
        
        cell.infoTitle.text = infoTitles[indexPath.row]
        cell.sub1Rate.text = String(sub1Rates[indexPath.row]) + "%"
        
        if sub2Rates[indexPath.row] != Int(){
            cell.sub2Rate.text = String(sub2Rates[indexPath.row]) + "%"
            
        } else {
            
            cell.sub2Rate.text = ""
        }
        
        cell.sub1Title.text = sub1Titles[indexPath.row]
        if sub2Titles[indexPath.row] != String(){
            
            cell.sub2Title.text = sub2Titles[indexPath.row]
        } else {
            
            cell.sub2Title.text = ""
        }
     
        for i in 0 ..< sub1Rates.count{
            
            let firstRate = sub1Rates[i]
            let secondRate = sub2Rates[i]
            
            if secondRate != Int(){
                
                let avgRate:Int = (firstRate + secondRate) / 2
                
                totalRates[i] = avgRate
                
            } else {
                
                totalRates[i] = firstRate
            }
        }
        cell.totalRate.text = String(totalRates[indexPath.row]) + "%"

        
        cell.ringView.progress = 0.0
        
        
        CATransaction.setCompletionBlock {
            
            CATransaction.begin()
            CATransaction.setAnimationDuration(2)
            
            cell.ringView.progress = Double(totalRates[indexPath.row]) / Double(100)
            CATransaction.commit()
          
        }
        
        
        
        
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 4
    }

    
    override func viewWillAppear(_ animated: Bool) {
        getUserInfo()
        myRank()
    }
    
    //照片的func
    @IBAction func checkRankBtnClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toChartVc", sender: self)
    }
    
    
    func myRank(){
        
        
        // url to access our php file
        let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/myRank.php")!
        
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
                    
                    print(parseJSON)
                    
                    //抓名次
                    
       //             if let parseJsonDic = parseJSON as [NSDictionary]?{
                    
      
                        
                        for i in 0 ..< parseJSON.count{
         

                 
                            if let id = parseJSON[i]["id"] as? Int{
           
                                
                                let userId = user?["id"] as! String
                                
                                if String(id) == userId{
                                    
                                    DispatchQueue.main.async(execute: {
                                        print(i)
                                             self!.rankCountLabel.text = String(i + 1)
                                    })
                               
                     
                                }                                 
                                
                            }
                    }
                        
                        
                        
             //       }
                    
      
                    
                    
                    
 
                    
                } catch{
                    
                    print("catch error")
                    
                }
            } else {
                
                print("urlsession has error")
                
            }
        }).resume()
        
    }
    
    func getUserInfo(){
        
        print("perform get user")
        //指定個人大頭照
        if let avaImgUrl = user?["ava"] as? String{
            
            // communicate back user as main queue
            DispatchQueue.main.async(execute: {[weak self] in
                
                if avaImgUrl != "" {
                    
                    let imageUrl = URL(string: avaImgUrl)!
                    // get data from image url
                    let imageData = try? Data(contentsOf: imageUrl)
                    
                    // if data is not nill assign it to ava.Img
                    if imageData != nil {
                        DispatchQueue.main.async(execute: {
                            self?.avaImg.image = UIImage(data: imageData!)
                        })
                    }
                    
                    
                } else {
                    
                    self?.avaImg.image = UIImage(named: "avatar.png")
                }
            })
            
            
        } else {
            
            //沒有就用預設大頭照
            avaImg.image = UIImage(named: "avatar.png")
            
        }
        
        //取得暱稱
        if let nickname = user?["nickname"] as? String{
            
            self.usernameLabel.text = nickname
        }
        
        
        //算字數
        let allMapPassedCount = mapPassed! * 450 + mapPassed2! * 420
        var gamePassedCount = Int()
        var gamePassed2Count = Int()
        var gamePassed3Count = Int()
        var gamePassed4Count = Int()
        var allWordsCount = Int()
        var wrongWordsCount = Int()
        
        for (s,u) in gamePassed!{
            gamePassedCount = s * 30 + u * 3
        }
        for (s,u) in gamePassed2!{
            gamePassed2Count = s * 30 + u * 3
        }
        
        /*
        for (s,u) in gamePassed3!{
            gamePassed3Count = s * 30 + u * 3
        }
        for (s,u) in gamePassed4!{
            gamePassed4Count = s * 30 + u * 3
        }
 */
        allWordsCount = allMapPassedCount + gamePassedCount + gamePassed2Count + gamePassed3Count + gamePassed4Count
        
        wordCountLabel.text = String(allWordsCount)
        
        //抓分數
         if let score = user?["score"] as? String{
            
            scoreCountLabel.text = score
            
        }
        
        
        //算拼字正確率
        if let wrongWords = user?["wrongWords"] as? String{
            
            
            print(wrongWords)
            
            let wrongWordArray = wrongWords.components(separatedBy: ";")
            
            wrongWordsCount = wrongWordArray.count - 1
           
        }
        
        
        if allWordsCount == 0 {
            //這樣的話比例也是0
            
            sub1Rates[0] = 0
        } else {
        
        sub1Rates[0] = Int((1 - (Double(wrongWordsCount) / Double(allWordsCount))) * 100)
        }
        
        //中文正確率
        
        
        if let wrongChinese = user?["wrongChinese"] as? String{
            
            print(wrongChinese)
            print(allWordsCount)

            if allWordsCount == 0 {
                //這樣的話比例也是0
                
                sub2Rates[0] = 0
            } else {
            
            sub2Rates[0] = Int((1 - (Double(wrongChinese)! / Double(allWordsCount))) * 100)
            
            }
        }
        

        
        
        
        //發音正確率
        
        if let proRate = user?["proRate"] as? String{
            
            sub1Rates[1] = Int(proRate)!
        }

        
        //句子排列正確率
        
        if let senRate = user?["senRate"] as? String{
            
            sub1Rates[2] = Int(senRate)!
        }
        

        
        
    }

    
    
    // selected image
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
  //  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        avaImg.image = info[UIImagePickerControllerEditedImage] as? UIImage
        
        
         self.dismiss(animated: false, completion: nil)
        
        /*
        self.dismiss(animated: true) {
            /*
            let value = UIInterfaceOrientation.landscapeLeft.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
 */
        }
        */
        
        
        // call func of uploading file to server
        uploadAva()
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
        /*
        self.dismiss(animated: true) {
            let value = UIInterfaceOrientation.landscapeLeft.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        }
        */
    }
    

    // custom body of HTTP request to upload image file
    func createBodyWithParams(_ parameters: [String: String]?, filePathKey: String?, imageDataKey: Data, boundary: String) -> Data {
        
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "ava.jpg"
        
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey)
        body.appendString("\r\n")
        
        body.appendString("--\(boundary)--\r\n")
        
        return body as Data
        
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // upload image to serve
    func uploadAva() {
        
        // shotcut id
        let id = user!["id"] as! String
        
        //let id = "135"
        
        // url path to php file
        let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/updateAva.php")!
        
        // declare request to this file
        var request = URLRequest(url: url)
        
        // declare method of passign inf to this file
        request.httpMethod = "POST"
        
        // param to be sent in body of request
        let param = ["id" : id]
        
        // body
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // compress image and assign to imageData var
        let imageData = UIImageJPEGRepresentation(avaImg.image!, 0.5)
        
        // if not compressed, return ... do not continue to code
        if imageData == nil {
            return
        }
        
        // ... body
        request.httpBody = createBodyWithParams(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        
        
        // launc session
        URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            
            // get main queue to communicate back to user
            DispatchQueue.main.async(execute: {
                
                if error == nil {
                    
                    do {
                        // json containes $returnArray from php
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        // declare new parseJSON to store json
                        guard let parseJSON = json else {
                            print("Error while parsing")
                            //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                            
                            return
                        }
                        
                        // get id from $returnArray["id"] - parseJSON["id"]
                        let id = parseJSON["id"]
                        
                        // successfully uploaded
                        if id != nil {
                            print("got Id")
                            
                            
                            // save user information we received from our host
                            
                            UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                            user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                            
                            print(user)
                        } else {
                            print("didn't get id")
                            // get main queue to communicate back to user
                            DispatchQueue.main.async(execute: {
                                let message = parseJSON["message"] as! String
                                //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                                
                                print(message)
                            })
                            
                        }
                        
                        // error while jsoning
                    } catch {
                        
                        if let error = error as? NSError{
                            
                            print(error)
                        }
                        
                        print("error while parsing")/*
                         // get main queue to communicate back to user
                         DispatchQueue.main.async(execute: {
                         let message = error as! String
                         print(message)
                         appDelegate.createAlert(title: self.generalErrorTitleText, message: self.generalErrorMessageText, view: self)
                         
                         })
                         */
                    }
                    
                    // error with php
                } else {
                    
                    // get main queue to communicate back to user
                    DispatchQueue.main.async(execute: {
                        let message = error!.localizedDescription
                        print(message)
                        //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                        
                        
                    })
                    
                }
                
                
            })
            
            }.resume()
        
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
// Creating protocol of appending string to var of type data
extension NSMutableData {
    
    func appendString(_ string : String) {
        
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
        
    }
    
}

