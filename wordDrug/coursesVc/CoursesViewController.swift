//
//  CoursesViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/2/21.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
