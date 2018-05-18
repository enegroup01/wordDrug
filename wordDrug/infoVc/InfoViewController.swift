//
//  InfoViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/5/18.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var infoTableView: UITableView!
    @IBOutlet weak var chartUpBg: UIImageView!
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        chartUpBg.frame = CGRect(x: 0, y: 0, width: width, height: height / 2.2)
        infoTableView.frame = CGRect(x: 0, y: chartUpBg.frame.maxY, width: width, height: height - chartUpBg.frame.height)
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let heightForRow = infoTableView.frame.height / 2
        
        return heightForRow
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoTableViewCell
        
        cell.backgroundColor = .clear
        
        let infoTitles = ["單字成就", "發音成就", "句型成就", "快速挑戰"]
        let sub1Titles = ["拼字正確率","發音正確率","排列正確率","正確關卡數"]
        let sub2Titles = ["中文正確率",String(),"發音正確率",String()]
        let sub1Rate = [78,80,100,70]
        let sub2Rate = [80,Int(),70,Int()]
        
        cell.infoTitle.text = infoTitles[indexPath.row]
        cell.sub1Rate.text = String(sub1Rate[indexPath.row]) + "%"
        if sub2Rate[indexPath.row] != Int(){
            cell.sub2Rate.text = String(sub2Rate[indexPath.row]) + "%"
            
        }
        
        cell.sub1Title.text = sub1Titles[indexPath.row]
        if sub2Titles[indexPath.row] != String(){
            
            cell.sub2Title.text = sub2Titles[indexPath.row]
        }
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 4
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
