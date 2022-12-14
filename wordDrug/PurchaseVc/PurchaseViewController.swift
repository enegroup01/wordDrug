//
//  PurchaseViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/6/6.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit
import StoreKit


let purchasedKey = "purchased"
let failedToPurchaseKey = "failedToPurchase"

class PurchaseViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    let purchaseVC_dialogueTitle = NSLocalizedString("purchaseVC_dialogueTitle", comment: "")
    let purchaseVC_dialogueSubTitle = NSLocalizedString("purchaseVC_dialogueSubTitle", comment: "")
    let purchaseVC_downTitle = NSLocalizedString("purchaseVC_downTitle", comment: "")
    let purchaseVC_downTitle2 = NSLocalizedString("purchaseVC_downTitle2", comment: "")
    let purchaseVC_iKnowBtnText = NSLocalizedString("purchaseVC_iKnowBtnText", comment: "")
    let purchaseVC_restoreMsgLabelText = NSLocalizedString("purchaseVC_restoreMsgLabelText", comment: "")
    let purchaseVC_restoreOkMsg = NSLocalizedString("purchaseVC_restoreOkMsg", comment: "")
    let purchaseVC_purchaseBtnText = NSLocalizedString("purchaseVC_purchaseBtnText", comment: "")
    let purchaseVC_purchaseBtnDollars = NSLocalizedString("purchaseVC_purchaseBtnDollars", comment: "")
    let purchaseVC_purchaseFailedMsg = NSLocalizedString("purchaseVC_purchaseFailedMsg", comment: "")
    let purchaseVC_internetErrorMsg = NSLocalizedString("purchaseVC_internetErrorMsg", comment: "")
    let purchaseVC_restoreFailedMsg = NSLocalizedString("purchaseVC_restoreFailedMsg", comment: "")
    let purchaseVC_purchaseOkMsg = NSLocalizedString("purchaseVC_purchaseOkMsg", comment: "")
    let purchaseVC_restoreBtnTitle = NSLocalizedString("purchaseVC_restoreBtnTitle", comment: "")

    
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
    
    var isDirectedFromGame = false
    
    var dif = CGFloat()
    var newDif = CGFloat()
    
    var activityIndicator = UIActivityIndicatorView()
    
    //所有alertView的變數
    var alertBg = UIImageView()
    var alertText = UILabel()
    var ghostBtn = UIButton()
    var ghost2Btn = UIButton()
    var practiceWordBtn = UIButton()
    var practiceSenBtn = UIButton()
    var leftBtnClickedImg = UIImageView()
    var rightBtnClickedImg = UIImageView()
    let darkRed = UIColor.init(red: 192/255, green: 40/255, blue: 75/255, alpha: 1)
    let orangeColor = UIColor.init(red: 232/255, green: 98/255, blue: 61/255, alpha: 1)

    @IBOutlet weak var restoreBtn: UIButton!
    
    var restoreTimer = Timer()
    
    var titleFontSize: CGFloat!
    var subTitleFontSize:CGFloat!
    var iPadDif: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(PurchaseViewController.purchasedFunc), name: NSNotification.Name("purchased"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PurchaseViewController.failedFunc), name: NSNotification.Name("failedToPurchase"), object: nil)
        
      
   
        var xDif = CGFloat()
   

        var btnDif:CGFloat!

        
        switch height {
            
        case 1366, 1336:
            newDif = 1.35
            dif = 8
            
            xDif = 0
         
            iPadDif = 2.5
            titleFontSize = 56
            subTitleFontSize = 32
            btnDif = 1.5
            
    
        case 1024, 1194, 1112:
            newDif = 1.35
            dif = 8
          
            xDif = 0
   
            iPadDif = 1.8
            titleFontSize = 45
            subTitleFontSize = 24
            btnDif = 1.2
            
        case 812:
            
            //iPhoneX
            newDif = 1.35
            dif = 8

            xDif = 25

            iPadDif = 1.2
            titleFontSize = 26
            subTitleFontSize = 18
            btnDif = 1
            
        case 736:
            //plus
            newDif = 1.1
            dif = 0
  
            xDif = 10
     
            iPadDif = 1.2
            titleFontSize = 28
            subTitleFontSize = 18
            btnDif = 1
            
        case 667:
            
            newDif = 1
            dif = 0
   
            xDif = 10
            iPadDif = 1
            titleFontSize = 26
            subTitleFontSize = 16
            btnDif = 1
            
        case 568:
            
            newDif = 0.9
      
            xDif = 10
            dif = 0

            iPadDif = 0.9
            titleFontSize = 24
            subTitleFontSize = 14
            btnDif = 0.9
       
        default:
            newDif = 1.35
            dif = 8
            
            xDif = 25
            
            iPadDif = 1.2
            titleFontSize = 26
            subTitleFontSize = 18
            btnDif = 1

            break
        }
        
        
        //upBg.frame = CGRect(x: 0, y: 0, width: width, height: 250)
        upBg.contentMode = .scaleAspectFill
        
        upBg.anchor(top: nil, leading: view.safeLeftAnchor, bottom: view.centerYAnchor, trailing: view.safeRightAnchor, padding: .init(top: 0, left: 0, bottom: -height / 10, right: 0))
        
        //purchaseBtn.frame = CGRect(x: 0, y: upBg.frame.maxY, width: width, height: 72)

        //downBg.frame = CGRect(x: 0, y: purchaseBtn.frame.maxY, width: width, height: height - upBg.frame.height - purchaseBtn.frame.height)
        

        
        purchaseBtn.anchor(top: upBg.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: view.safeRightAnchor, size: .init(width: width, height: height / 10))
       // purchaseBtn.titleLabel?.font = purchaseBtn.titleLabel?.font.withSize(titleFontSize)
        
 
        
        downBg.anchor(top: purchaseBtn.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: view.safeRightAnchor)
        
        
        //dialogueBg.frame = CGRect(x: (width - 276) / 2, y: (upBg.frame.height - 140) / 2, width: 276, height: 140)
        dialogueBg.translatesAutoresizingMaskIntoConstraints = false
        dialogueBg.widthAnchor.constraint(equalToConstant: 276 * iPadDif).isActive = true
        dialogueBg.heightAnchor.constraint(equalToConstant: 140 * iPadDif).isActive = true
        dialogueBg.centerXAnchor.constraint(equalTo: upBg.centerXAnchor).isActive = true
        dialogueBg.bottomAnchor.constraint(equalTo: purchaseBtn.topAnchor, constant: -30 * iPadDif).isActive = true

        
        
        //dialogueTitle.backgroundColor = .green
        //dialogueTitle.frame = CGRect(x:dialogueBg.frame.minX + 10, y: dialogueBg.frame.minY + 10, width: 230, height: 80)
        dialogueTitle.textAlignment = .left
        dialogueTitle.text = purchaseVC_dialogueTitle
        dialogueTitle.font = dialogueTitle.font.withSize(titleFontSize)
        
        
        
        dialogueTitle.translatesAutoresizingMaskIntoConstraints = false
        dialogueTitle.widthAnchor.constraint(equalToConstant: 230 * iPadDif).isActive = true
        dialogueTitle.heightAnchor.constraint(equalToConstant: 80 * iPadDif).isActive = true
        dialogueTitle.centerXAnchor.constraint(equalTo: dialogueBg.centerXAnchor).isActive = true
        dialogueTitle.centerYAnchor.constraint(equalTo: dialogueBg.centerYAnchor, constant: -10 * iPadDif).isActive = true
        
        
        //dialogueSubTitle.backgroundColor = .yellow
        //dialogueSubTitle.frame = CGRect(x: dialogueBg.frame.minX + 10, y: dialogueTitle.frame.maxY + 10, width: dialogueBg.frame.width, height: 22)
        
        
        dialogueSubTitle.text = purchaseVC_dialogueSubTitle
        dialogueSubTitle.textAlignment = .left
        dialogueSubTitle.adjustsFontSizeToFitWidth = true
        
        dialogueSubTitle.font = dialogueSubTitle.font.withSize(subTitleFontSize)
        
        dialogueSubTitle.translatesAutoresizingMaskIntoConstraints = false
        dialogueSubTitle.widthAnchor.constraint(equalToConstant: 230 * iPadDif).isActive = true
        dialogueSubTitle.heightAnchor.constraint(equalToConstant: 30 * iPadDif).isActive = true
        dialogueSubTitle.centerXAnchor.constraint(equalTo: dialogueBg.centerXAnchor).isActive = true
        dialogueSubTitle.topAnchor.constraint(equalTo: dialogueTitle.bottomAnchor).isActive = true
        
       
        //downTitle.backgroundColor = .red
        //downTitle.frame = CGRect(x: 0, y: downBg.frame.minY + downBg.frame.height / 20, width: width, height: 44)
        downTitle.text = purchaseVC_downTitle
        downTitle.font = downTitle.font.withSize(subTitleFontSize)
        
        downTitle.translatesAutoresizingMaskIntoConstraints = false
        downTitle.widthAnchor.constraint(equalToConstant: width).isActive = true
        downTitle.heightAnchor.constraint(equalToConstant: 44 * iPadDif).isActive = true
        downTitle.centerXAnchor.constraint(equalTo: downBg.centerXAnchor).isActive = true
        downTitle.topAnchor.constraint(equalTo: purchaseBtn.bottomAnchor, constant: 15 * iPadDif).isActive = true
        
        
        
        //downTitle2.backgroundColor = .purple
        //downTitle2.frame = CGRect(x: 0, y: downTitle.frame.maxY, width: width, height: 100)
        downTitle2.text = purchaseVC_downTitle2
         downTitle2.font = downTitle2.font.withSize(subTitleFontSize)
       
        downTitle2.translatesAutoresizingMaskIntoConstraints = false
        downTitle2.widthAnchor.constraint(equalToConstant: width).isActive = true
        downTitle2.heightAnchor.constraint(equalToConstant: 100 * iPadDif).isActive = true
        downTitle2.centerXAnchor.constraint(equalTo: downBg.centerXAnchor).isActive = true
        downTitle2.topAnchor.constraint(equalTo: downTitle.bottomAnchor).isActive = true
        
        //backBtn.frame = CGRect(x: 15, y: 17 + dif + iPadSmall, width: 19, height: 31)
        
        backBtn.anchor(top: view.safeTopAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: nil, padding: .init(top: 15 * iPadDif - xDif, left: 15 * iPadDif, bottom: 0, right: 0), size: .init(width: 19 * iPadDif, height: 31 * iPadDif))
        
        

        //加入alertView
        
        let lightGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.58)
        ghostBtn.frame = CGRect(x: 0, y: 0, width: width, height: height)
        ghostBtn.backgroundColor = lightGray
        //ghostBtn.addTarget(self, action: #selector(NewBookViewController.removeBtns), for: .touchUpInside)
        self.view.addSubview(ghostBtn)
        
       // alertBg.frame = CGRect(x: (width - 237 * newDif) / 2 + xDif, y: height * 2 /  5, width: width * 237 / 375, height: height * 140 / 667)
        alertBg.image = UIImage(named: "reviewQuitBg3.png")
        self.view.addSubview(alertBg)

        alertBg.translatesAutoresizingMaskIntoConstraints = false
        alertBg.widthAnchor.constraint(equalToConstant: 237 * iPadDif).isActive = true
        alertBg.heightAnchor.constraint(equalToConstant: 140 * iPadDif).isActive = true
        alertBg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertBg.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        //alertText.frame = CGRect(x: 5 * newDif , y: 15 * newDif, width: alertBg.frame.width - 5 * newDif * 2, height: alertBg.frame.height / 2)
        alertText.font = UIFont(name: "Helvetica Bold", size: subTitleFontSize)
        alertText.textColor = .white
        // alertText.text = ""
        //test
        alertText.text = ""
        //alertText.backgroundColor = .green
        alertText.numberOfLines = 0
        alertText.textAlignment = .center
        alertText.adjustsFontSizeToFitWidth = true
        
        //alertBg.addSubview(alertText)
        self.view.addSubview(alertText)
        alertText.translatesAutoresizingMaskIntoConstraints = false
        alertText.widthAnchor.constraint(equalToConstant: 200 * iPadDif).isActive = true
        alertText.heightAnchor.constraint(equalToConstant: 50 * iPadDif).isActive = true
        alertText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertText.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -5 * iPadDif).isActive = true
        
        
        
        //practiceWordBtn.frame = CGRect(x: alertBg.frame.minX, y: alertBg.frame.maxY - 40 * cellDif + iPadSmall, width: alertBg.frame.width, height: height * 44 / 667)
   
        //practiceWordBtn.backgroundColor = .green
        //practiceWordBtn.alpha = 0.2
        practiceWordBtn.titleLabel?.font = UIFont(name: "Helvetica Bold", size: subTitleFontSize)
        practiceWordBtn.titleLabel?.numberOfLines = 0
        practiceWordBtn.setTitle(purchaseVC_iKnowBtnText, for: .normal)
        practiceWordBtn.setTitleColor(orangeColor, for: .normal)
        practiceWordBtn.addTarget(self, action: #selector(PurchaseViewController.removeBtns), for: .touchUpInside)
        self.view.addSubview(practiceWordBtn)
        practiceWordBtn.anchor(top: nil, leading: alertBg.leadingAnchor, bottom: alertBg.bottomAnchor, trailing: alertBg.trailingAnchor, size: .init(width: 0, height: 44 * iPadDif))
    
        //拉到最前方
        self.view.bringSubviewToFront(ghostBtn)
        self.view.bringSubviewToFront(alertBg)
        self.view.bringSubviewToFront(alertText)
 
        self.view.bringSubviewToFront(practiceWordBtn)
        //self.view.bringSubview(toFront: practiceSenBtn)
  
      
       // restoreBtn.frame = CGRect(x: width - 81 * 1.05, y: purchaseBtn.frame.minY - 31, width: 81 , height: 26 )
        
        
       // let restoreMsgLabel = UILabel(frame: CGRect(x: restoreBtn.frame.minX, y: restoreBtn.frame.minY - 25, width: 80, height: 26))
        
        let restoreMsgLabel = UILabel()
             self.view.addSubview(restoreMsgLabel)
        restoreMsgLabel.anchor(top: view.safeTopAnchor, leading: nil, bottom: nil, trailing: view.safeRightAnchor, padding: .init(top: 10 * iPadDif - xDif, left: 0, bottom: 0, right: -15 * iPadDif), size: .init(width: 81 * btnDif, height: 26 * btnDif))
        restoreMsgLabel.font = UIFont(name: "Helvetica", size: subTitleFontSize * 0.7)
        restoreMsgLabel.textColor = .white
        restoreMsgLabel.text = purchaseVC_restoreMsgLabelText
        restoreMsgLabel.textAlignment = .center
        restoreMsgLabel.adjustsFontSizeToFitWidth = true
        
       
        restoreBtn.anchor(top: restoreMsgLabel.bottomAnchor, leading: restoreMsgLabel.leadingAnchor, bottom: nil, trailing: nil, size: .init(width: 81 * btnDif, height: 26 * btnDif))
        restoreBtn.titleLabel?.font = restoreBtn.titleLabel?.font.withSize(subTitleFontSize * 0.7)
        restoreBtn.setTitle(purchaseVC_restoreBtnTitle, for: .normal)
        
        removeBtns()
        
    }
    
    @IBAction func restoreBtnClicked(_ sender: Any) {
        
        if SKPaymentQueue.canMakePayments(){
            
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        
            SKPaymentQueue.default().remove(self)
            SKPaymentQueue.default().add(self)
        
            SKPaymentQueue.default().restoreCompletedTransactions()

        }
    }
    
    
    @objc func restoreOK(){
        
        ghostBtn.isHidden = false
        alertBg.isHidden = false
        alertText.isHidden = false
        alertText.text = purchaseVC_restoreOkMsg
        practiceWordBtn.isHidden = false
        practiceSenBtn.isHidden = false
        
    }
    
    
    @objc func removeBtns(){
        
        
        ghostBtn.isHidden = true
        alertBg.isHidden = true
        alertText.isHidden = true
        
        practiceWordBtn.isHidden = true
        practiceSenBtn.isHidden = true

        //show error msgs
        if isDirectedFromGame{
            
            self.dismiss(animated: false, completion: nil)
        }
        
    }
    
    var isDirectToRegister = false
    
    override func viewWillAppear(_ animated: Bool) {
        
        //開始loading
     
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100 * iPadDif, height: 100 * iPadDif))
        activityIndicator.layer.zPosition = 15
        let alphaGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.layer.cornerRadius = activityIndicator.frame.width / 20
        activityIndicator.backgroundColor = alphaGray
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        view.addSubview(activityIndicator)
      
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()

        isDirectToRegister = false
        purchaseBtn.isEnabled = false
        restoreBtn.isEnabled = false
        
        var iapProductName = String()
        if lan == "zh-Hans" {
            iapProductName = "simUnlockTimeLimit"
            
        } else {
            
            iapProductName = "unlockTimeLimit"
        }
        
        let productIdentifiers: Set<String> = [iapProductName]
       
        let productRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productRequest.delegate = self
        productRequest.start()
    
        
        //確認是否有購買
        
        let isPurchased = UserDefaults.standard.object(forKey: "isPurchased") as! Bool
        
        if isPurchased {
            //有買
            
            //已購買
            print("purchased!")
            
            //activityIndicator.stopAnimating()
            //UIApplication.shared.endIgnoringInteractionEvents()
            
            purchasedBtnText()
            
            /*
            restoreBtn.isEnabled = false
            restoreBtn.setTitle("成功購買", for: .normal)
            */
            
            restoreBtn.removeTarget(self, action: #selector(PurchaseViewController.restoreBtnClicked(_:)), for: .touchUpInside)
            restoreBtn.addTarget(self, action: #selector(PurchaseViewController.restoreOK), for: .touchUpInside)
            
        } else {
            //沒買
            
            print("didn't buy")
            
            //這在appDelegate裡已經執行
            //SKPaymentQueue.default().add(self)
            
            let attrWords = NSMutableAttributedString()
            
            let attrs0 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: subTitleFontSize)]
            
            let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: titleFontSize)]
            
            let btnText = NSMutableAttributedString(string: purchaseVC_purchaseBtnText, attributes: attrs0)
            let btnText2 = NSMutableAttributedString(string: purchaseVC_purchaseBtnDollars, attributes: attrs1)
            
            attrWords.append(btnText)
            attrWords.append(NSAttributedString(string: "\n"))
            attrWords.append(btnText2)
            
            purchaseBtn.titleLabel?.numberOfLines = 2
            purchaseBtn.titleLabel?.textAlignment = .center
            purchaseBtn.setAttributedTitle(attrWords, for: .normal)
            
            
        }
        

        
        
    }

    
    @objc func purchasedFunc(){
        
        print("successfully purchased")
        
        //SKPaymentQueue.default().finishTransaction(transaction)
        //print("purchased")
        //Apply purchase here, store info in userDefaults....
        
        //紀錄已購買
        UserDefaults.standard.set(true, forKey: "isPurchased")
        
        
        //暫時先使用在這裡
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
        
        purchasedBtnText()
        
        
        
    }
    
    @objc func failedFunc(){
    
    
   
        print("purchase VC failed To Puchase")
        
        //SKPaymentQueue.default().finishTransaction(transaction)
        //print("failed")
        
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
        
        ghostBtn.isHidden = false
        alertBg.isHidden = false
        alertText.isHidden = false
        alertText.text = purchaseVC_purchaseFailedMsg
        practiceWordBtn.isHidden = false
        practiceSenBtn.isHidden = false
    
    }
    
   
    
    func purchasedBtnText(){
        
        let attrWords = NSMutableAttributedString()
        
        let attrs0 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: subTitleFontSize)]
        
        let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: titleFontSize)]
        
        let btnText = NSMutableAttributedString(string: purchaseVC_purchaseOkMsg, attributes: attrs0)
        let btnText2 = NSMutableAttributedString(string: "Thank you!", attributes: attrs1)
        
        attrWords.append(btnText)
        attrWords.append(NSAttributedString(string: "\n"))
        attrWords.append(btnText2)
        purchaseBtn.titleLabel?.numberOfLines = 2
        purchaseBtn.titleLabel?.textAlignment = .center
        purchaseBtn.setAttributedTitle(attrWords, for: .normal)
        purchaseBtn.isUserInteractionEnabled = false
        
        
        purchaseBtn.isEnabled = true
        //restoreBtn.isEnabled = true
        
        if isDirectedFromGame{
            
            self.dismiss(animated: false, completion: nil)
        }
        
        
    }
    
    
    func errorLoadingProductBtnText(){
        
        
        let attrWords = NSMutableAttributedString()
        
        let attrs0 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: subTitleFontSize)]
        
        let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: titleFontSize)]
        
        let btnText = NSMutableAttributedString(string: purchaseVC_internetErrorMsg, attributes: attrs0)
        let btnText2 = NSMutableAttributedString(string: "Sorry!", attributes: attrs1)
        
        attrWords.append(btnText)
        attrWords.append(NSAttributedString(string: "\n"))
        attrWords.append(btnText2)
        
        
        purchaseBtn.titleLabel?.numberOfLines = 2
        purchaseBtn.titleLabel?.textAlignment = .center
        purchaseBtn.setAttributedTitle(attrWords, for: .normal)
        
        
        purchaseBtn.isUserInteractionEnabled = false
        
        
        purchaseBtn.isEnabled = false
        
        
    }
    
    
    
    func purchasedBtnFailedText(){
        

        let attrWords = NSMutableAttributedString()
        
        let attrs0 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: subTitleFontSize)]
        
        let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: titleFontSize)]
        
        let btnText = NSMutableAttributedString(string: purchaseVC_purchaseBtnText, attributes: attrs0)
        let btnText2 = NSMutableAttributedString(string: purchaseVC_purchaseBtnDollars, attributes: attrs1)
        
        attrWords.append(btnText)
        attrWords.append(NSAttributedString(string: "\n"))
        attrWords.append(btnText2)
        

        purchaseBtn.titleLabel?.numberOfLines = 2
        purchaseBtn.titleLabel?.textAlignment = .center
        purchaseBtn.setAttributedTitle(attrWords, for: .normal)
       
        
        purchaseBtn.isUserInteractionEnabled = true
        
        
        purchaseBtn.isEnabled = true
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self)
        
        restoreTimer.invalidate()
        
        //這應該不用在這裡remove
        //SKPaymentQueue.default().remove(self)
        
    }
    
    deinit {
        print("purchase deinit")
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        print("loaded product")
        
         if response.products.count > 0 {
            
            print("products found")
        
        for product in response.products{
            
            
            print("product:\(product.productIdentifier), \(product.localizedTitle), \(product.price.floatValue )")
            
            DispatchQueue.main.async {[weak self] in
                self!.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                self!.activeProduct = product
                
                self!.purchaseBtn.isEnabled = true
                self!.restoreBtn.isEnabled = true
                

            }
          
            }
    
         } else {
            
            print("no products found")
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            purchaseBtn.isEnabled = false
            restoreBtn.isEnabled = false
            
            //寫一個網路太慢讀不到的反應
            errorLoadingProductBtnText()
            
        }
        
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        
        print(error)
        
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
        purchaseBtn.isEnabled = false
        restoreBtn.isEnabled = false
        
        //寫一個網路太慢讀不到的反應
        errorLoadingProductBtnText()
    }
    
    
    @IBAction func buyClicked(_ sender: Any) {
        
        if let activeProduct = activeProduct {
            
            print("buying")
            
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            let payment = SKPayment(product: activeProduct)
            SKPaymentQueue.default().add(payment)
            
        }
    
    }
    
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "fromPurchaseToRegisterVc"{
//
//            let destineVc = segue.destination as! RegisterViewController
//            destineVc.isDirectedHere = true
//
//        }
//    }
    
 
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions{
            
            
            switch (transaction.transactionState){
                
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                print("restored")
          
                
                activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                restoreTimer.invalidate()
                second = 0
                
                ghostBtn.isHidden = false
                alertBg.isHidden = false
                alertText.isHidden = false
                alertText.text = purchaseVC_restoreOkMsg
                practiceWordBtn.isHidden = false
                practiceSenBtn.isHidden = false
                
                UserDefaults.standard.set(true, forKey: "isPurchased")
                purchasedBtnText()
                
                
            default:
                break
            }
        }
        
        
    }
    
  
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        
        //啟動restore倒數timer
        
        restoreTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PurchaseViewController.countTime), userInfo: nil, repeats: true)

    }
    

    
    var second = Int()
    @objc func countTime(){
  
        //秒數增加到6
        if second < 6{
            
            second += 1
            
        } else {
            
            restoreTimer.invalidate()
            second = 0
            
           
                print("沒有東西restored")
                activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                ghostBtn.isHidden = false
                alertBg.isHidden = false
                alertText.isHidden = false
                alertText.text = purchaseVC_restoreFailedMsg
                practiceWordBtn.isHidden = false
                practiceSenBtn.isHidden = false

                purchasedBtnFailedText()
                
                //紀錄沒買過
                UserDefaults.standard.set(false, forKey: "isPurchased")
            
            
        }
   
    }
    
    
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
   
        
        
        //此處應該要印出error訊息, 才不會誤導使用者
        if let error = error as Error?{
            
            print(error.localizedDescription)
        }
        
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
        
        
        ghostBtn.isHidden = false
        alertBg.isHidden = false
        alertText.isHidden = false
        //alertText.text = "\n您還沒有購買無限時間喔!"
        
        //目前會顯示錯誤訊息
        alertText.text = purchaseVC_restoreFailedMsg
        
        practiceWordBtn.isHidden = false
        practiceSenBtn.isHidden = false
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
