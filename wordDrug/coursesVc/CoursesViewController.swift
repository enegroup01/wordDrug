//
//  CoursesViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/2/21.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController {
    @IBOutlet weak var block0: UIImageView!
    @IBOutlet weak var block2: UIImageView!
    @IBOutlet weak var block0LBtn: UIButton!
    
    @IBOutlet weak var block0RBtn: UIButton!
    @IBOutlet weak var block3: UIImageView!
    @IBOutlet weak var block1: UIImageView!
    

    @IBOutlet weak var dialogueBg: UIImageView!

    @IBOutlet weak var dialogueLabel: UILabel!
    
    @IBOutlet weak var block0WordCountLabel: UILabel!
    
    @IBOutlet weak var block1WordCountLabel: UILabel!
    
    @IBOutlet weak var block2WordCountLabel: UILabel!
    
    @IBOutlet weak var block3WordCountLabel: UILabel!
    
    @IBOutlet weak var block0TitleImg: UIImageView!
    
    @IBOutlet weak var block1TitleImg: UIImageView!
    @IBOutlet weak var block3TitleImg: UIImageView!
    
    @IBOutlet weak var block0BookImg: UIImageView!
    
    @IBOutlet weak var block1BookImg: UIImageView!
    
    
    @IBOutlet weak var block2BookImg: UIImageView!
    
    @IBOutlet weak var block3BookImg: UIImageView!
    @IBOutlet weak var block2TitleImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("coursesVC:\(user!)")
        
        //layOut
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
       
        
        var xPos = CGFloat()
        var fontSize = CGFloat()
        var titleDif = CGFloat()
        switch  height {
        case 812:
            fontSize = 20
            xPos = -22
            titleDif = 1
        case 736:
     
            fontSize = 18
            xPos = 0
            titleDif = 1
            
        case 667:

            fontSize = 18
            xPos = 0
            titleDif = 0.9
            
        case 568:
            fontSize = 16
            xPos = 0
            titleDif = 0.8
            
        default:
            break
            
        }
        
        let nickname = user?["username"] as! String
        
        block0.frame = CGRect(x: xPos, y: 0, width: width, height: height / 4)
        block0.contentMode = .scaleAspectFill
        block1.frame = CGRect(x: xPos, y: height / 4, width: width, height: height / 4)
        block2.frame = CGRect(x: xPos, y: height / 2, width: width, height: height / 4)
        block3.frame = CGRect(x: xPos, y: height * 3 / 4, width: width, height: height / 4)
        
        block0LBtn.frame = CGRect(x: 0, y: 0, width: width * 3 / 4 + width / 42, height: height / 4)
        block0RBtn.frame = CGRect(x: block0LBtn.frame.width, y: 0, width: width - block0LBtn.frame.width, height: height / 4)
        
        dialogueBg.frame = CGRect(x: width / 3, y: block0.frame.height / 5.5, width: width * 1.8 / 3, height: block0.frame.height / 5)
        
        dialogueLabel.frame = CGRect(x: dialogueBg.frame.origin.x + dialogueBg.frame.width / 40, y: dialogueBg.frame.origin.y + dialogueBg.frame.height / 4, width: dialogueBg.frame.width * 19 / 20, height: dialogueBg.frame.height / 2)
        
       dialogueLabel.adjustsFontSizeToFitWidth = true
       dialogueLabel.text = "Hi! \(nickname) 請選擇課程"
        
        
        block0WordCountLabel.frame = CGRect(x: dialogueBg.frame.origin.x * 1.2, y: block0.frame.height / 2, width: width / 2.8, height: block0.frame.height / 3)
        //block0WordCountLabel.backgroundColor = .red
        block0WordCountLabel.adjustsFontSizeToFitWidth = true
        block1WordCountLabel.frame = CGRect(x: dialogueBg.frame.origin.x * 1.2, y: block1.frame.origin.y + block1.frame.height / 3, width: width / 2.8, height: block0.frame.height / 3)
        //block1WordCountLabel.backgroundColor = .red
        block1WordCountLabel.adjustsFontSizeToFitWidth = true
        block2WordCountLabel.frame = CGRect(x: dialogueBg.frame.origin.x * 1.2, y: block2.frame.origin.y + block2.frame.height / 3, width: width / 2.8, height: block0.frame.height / 3)
        //block2WordCountLabel.backgroundColor = .red
        block2WordCountLabel.adjustsFontSizeToFitWidth = true
        block3WordCountLabel.frame = CGRect(x: dialogueBg.frame.origin.x * 1.2, y: block3.frame.origin.y + block3.frame.height / 3, width: width / 2.8, height: block0.frame.height / 3)
        //=block3WordCountLabel.backgroundColor = .red
        block3WordCountLabel.adjustsFontSizeToFitWidth = true
        
        /*
        block0Text.frame = CGRect(x: block0.frame.width / 26, y: block0.frame.height / 3, width: 272, height: 94)
           block1Text.frame = CGRect(x: block0.frame.width / 26, y: block1.frame.origin.y + block0.frame.height / 3, width: 272, height: 97)
           block2Text.frame = CGRect(x: block0.frame.width / 26, y: block2.frame.origin.y + block0.frame.height / 3, width: 272, height: 84)
           block3Text.frame = CGRect(x: block0.frame.width / 26, y:  block3.frame.origin.y + block0.frame.height / 3, width: 272, height: 82)
      */
        
        block0TitleImg.frame = CGRect(x: block0.frame.width / 26, y: block0.frame.height / 3, width: 136 * titleDif, height: 94 * titleDif)
        block1TitleImg.frame = CGRect(x: block0.frame.width / 26, y: block1.frame.origin.y + block0.frame.height / 5, width: 136 * titleDif, height: 97 * titleDif)
        block2TitleImg.frame = CGRect(x: block0.frame.width / 26, y: block2.frame.origin.y + block0.frame.height / 4, width: 136 * titleDif, height: 81 * titleDif)
        block3TitleImg.frame = CGRect(x: block0.frame.width / 26, y:  block3.frame.origin.y + block0.frame.height / 4, width: 136 * titleDif, height: 81 * titleDif)

        
        block0BookImg.frame = CGRect(x: width - width / 6, y: block0WordCountLabel.frame.origin.y + height / 70, width: 41 * titleDif, height: 45 * titleDif)
        block1BookImg.frame = CGRect(x: width - width / 6, y: block1WordCountLabel.frame.origin.y + height / 70, width: 41 * titleDif, height: 45 * titleDif)
        block2BookImg.frame = CGRect(x: width - width / 6, y: block2WordCountLabel.frame.origin.y + height / 70, width: 41 * titleDif, height: 45 * titleDif)
        block3BookImg.frame = CGRect(x: width - width / 6, y: block3WordCountLabel.frame.origin.y + height / 70, width: 41 * titleDif, height: 45 * titleDif)
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func elementaryClicked(_ sender: Any) {
        performSegue(withIdentifier: "toStageVc", sender: self)
    }
    
    @IBAction func intermediateClicked(_ sender: Any) {
    }
    
    @IBAction func toeicClicked(_ sender: Any) {
    }
    
    @IBAction func toeflClicked(_ sender: Any) {
    }
    
    @IBAction func toNewBookBtn(_ sender: Any) {
        performSegue(withIdentifier: "toNewBookVc", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /*
        if segue.identifier == "toNewBookVc"{
            
            let destinationVc = segue.destination as! NewBookViewController
            
            //之後這裡要傳送的是課程名稱

            
        }
        */
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
