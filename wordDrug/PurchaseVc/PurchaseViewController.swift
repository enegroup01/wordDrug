//
//  PurchaseViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/6/6.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit
import StoreKit


class PurchaseViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    @IBOutlet weak var upBg: UIImageView!
    
    @IBOutlet weak var purchaseBtn: UIButton!
    
    @IBOutlet weak var downBg: UIImageView!
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    @IBOutlet weak var dialogueBg: UIImageView!
    
    @IBOutlet weak var dialogueTitle: UILabel!
    
    @IBOutlet weak var dialogueSubTitle: UILabel!
    
    @IBOutlet weak var downTitle: UILabel!
    
    @IBOutlet weak var downTitle2: UILabel!
    
    @IBOutlet weak var backBtn: UIButton!
    
    var activeProduct: SKProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        upBg.frame = CGRect(x: 0, y: 0, width: width, height: 250)
        purchaseBtn.frame = CGRect(x: 0, y: upBg.frame.maxY, width: width, height: 72)
        downBg.frame = CGRect(x: 0, y: purchaseBtn.frame.maxY, width: width, height: height - upBg.frame.height - purchaseBtn.frame.height)
        
        
        dialogueBg.frame = CGRect(x: (width - 276) / 2, y: (upBg.frame.height - 140) / 2, width: 276, height: 140)
        
        dialogueTitle.frame = CGRect(x:dialogueBg.frame.minX + 10, y: dialogueBg.frame.minY + 10, width: 230, height: 80)
        dialogueTitle.textAlignment = .left
        dialogueTitle.text = "無限時間\n讓英語學習無限大"
        
        dialogueSubTitle.frame = CGRect(x: dialogueBg.frame.minX + 10, y: dialogueTitle.frame.maxY + 10, width: dialogueBg.frame.width, height: 22)
        
        
        dialogueSubTitle.text = "所有課程不限時，一次全解鎖"
        dialogueSubTitle.textAlignment = .left
        
       
        
        downTitle.frame = CGRect(x: 0, y: downBg.frame.minY + downBg.frame.height / 20, width: width, height: 44)
        downTitle.text = "用最正確，最有效率的單字學習方式\n今天就開始你的學習計畫！"
        
        
        downTitle2.frame = CGRect(x: 0, y: downTitle.frame.maxY, width: width, height: 100)
        downTitle2.text = "英檢初級2100字\n英檢中級2250字\n多益滿分2400字\n及更多字庫更新內容..."
        
        
        backBtn.frame = CGRect(x: 15, y: 17, width: 19, height: 31)
        

        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //確認購買狀態
        
        purchaseBtn.isEnabled = false

        
        if let isPurchased = user?["isPurchased"] as? String{
            
            if isPurchased == "0" {
                
                print("not yet purchased")
                
                SKPaymentQueue.default().add(self)
                
                let productIdentifiers: Set<String> = ["unlockTimeLimit"]
                let productRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
                productRequest.delegate = self
                
                productRequest.start()

                let attrWords = NSMutableAttributedString()
                
                let attrs0 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)]
                
                let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 24)]
                
                let btnText = NSMutableAttributedString(string: "購買無限學習時間", attributes: attrs0)
                let btnText2 = NSMutableAttributedString(string: "$ 90.00", attributes: attrs1)
                
                attrWords.append(btnText)
                attrWords.append(NSAttributedString(string: "\n"))
                attrWords.append(btnText2)
                
                purchaseBtn.titleLabel?.numberOfLines = 2
                purchaseBtn.titleLabel?.textAlignment = .center
                purchaseBtn.setAttributedTitle(attrWords, for: .normal)
                
                
            } else if isPurchased == "1" {
                
                
                //已購買
                print("purchased!")
           
                purchasedBtnText()
                
            }
            
        }
        
    }

    
    func purchasedBtnText(){
        
        let attrWords = NSMutableAttributedString()
        
        let attrs0 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)]
        
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 24)]
        
        let btnText = NSMutableAttributedString(string: "您已購買無限學習時間", attributes: attrs0)
        let btnText2 = NSMutableAttributedString(string: "Thank you!", attributes: attrs1)
        
        attrWords.append(btnText)
        attrWords.append(NSAttributedString(string: "\n"))
        attrWords.append(btnText2)
        purchaseBtn.titleLabel?.numberOfLines = 2
        purchaseBtn.titleLabel?.textAlignment = .center
        purchaseBtn.setAttributedTitle(attrWords, for: .normal)
        purchaseBtn.isUserInteractionEnabled = false
        
        
        purchaseBtn.isEnabled = true
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        SKPaymentQueue.default().remove(self)
        
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        print("loaded product")
        
        for product in response.products{
            
            
            print("product:\(product.productIdentifier), \(product.localizedTitle), \(product.price.floatValue )")
            
            
            activeProduct = product
            
            
            purchaseBtn.isEnabled = true
            
            
            
        }
        
    }
    
    
    @IBAction func buyClicked(_ sender: Any) {
        

        
        if let activeProduct = activeProduct {
            
                    print("buying")
            
            let payment = SKPayment(product: activeProduct)
            SKPaymentQueue.default().add(payment)
            
            
            
            
            
            
        }
        
        
        
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions{
            
            
            switch (transaction.transactionState){
                
                
            case .purchased:
                
                SKPaymentQueue.default().finishTransaction(transaction)
                print("purchased")
                //Apply purchase here, store info in userDefaults....
                
                updatePurchased()
                
                
                
                
            case .failed:
                
                SKPaymentQueue.default().finishTransaction(transaction)
                print("failed")
                
                //show error msgs
                
   
            default:
                break
        
            }
   
        }
        
        
        
        
    }
    
    
    
    //更新mapPassed
    
    func updatePurchased(){
        
        
        let id = user?["id"] as! String
        
        // url to access our php file
        let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/updatePurchased.php")!
        
        // request url
        var request = URLRequest(url: url)
        
        // method to pass data POST - cause it is secured
        request.httpMethod = "POST"
        
        // body gonna be appended to url
        let body = "id=\(id)"
        
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
                    
                    UserDefaults.standard.set(1, forKey: "isPurchased")
                    
                    DispatchQueue.main.async(execute: {
                    
                        self!.purchasedBtnText()
                    })
          
                    
                    print(user!)
                    print("purchased updated")
                    
                } catch{
                    
                    print("catch error")
                    
                    
                }
            } else {
                print("urlsession has error")
                
            }
        }).resume()
        
        
        
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
