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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let cell = tableView.dequeueReusableCell(withIdentifier: "chartCell", for: indexPath) as! ChartTableViewCell
        
        cell.backgroundColor = .clear
        
        cell.rankLabel.text = String(indexPath.row + 1)
        
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return height / 8
        
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
