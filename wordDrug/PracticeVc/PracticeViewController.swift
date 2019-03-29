//
//  PracticeViewController.swift
//  wordDrug
//
//  Created by Ethan on 2019/3/7.
//  Copyright © 2019年 playplay. All rights reserved.
//

import UIKit
import ProgressHUD

class PracticeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating{
    
    @IBOutlet weak var enterGameButton: UIButton!

    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    let greenColor = UIColor.init(red: 138/255, green: 252/255, blue: 188/255, alpha: 1)
    let darkBackgroundColor = UIColor.init(red: 32/255, green: 26/255, blue: 27/255, alpha: 1)
    let searchFieldLightGrayColor = UIColor.init(red: 45/255, green: 39/255, blue: 41/255, alpha: 1)
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    //var selectedWord = [Int]()
    
//    let allWords = ["abandon","character","chocolate","capital","money","venture","stock","hatred","love","peace"]
    
    var searchArr: [Word] = [Word](){
        didSet {
            // 重設 searchArr 後重整 tableView
            self.tableView.reloadData()
        }
    }
    
    var selectedArray: [Word] = [Word](){
        didSet{

            self.tableView.reloadData()
        }
    }
    
    var allWords:[Word]?
    var isChecked = false
    var selectedWord = [Word]() {
        didSet{
            self.selectedWordCountLabel.text = "已選擇 " + String(selectedWord.count) + " 字"
        }
        
    }
   
    let checkBtn = UIButton(type: .system)
    
    var selectedWordCountLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 建立 UISearchController 並設置搜尋控制器為 nil
        self.searchController = UISearchController(searchResultsController: nil)
        
        // 將更新搜尋結果的對象設為 self
        self.searchController.searchResultsUpdater = self
        
        // 搜尋時是否隱藏 NavigationBar
        // 這個範例沒有使用 NavigationBar 所以設置什麼沒有影響
        self.searchController
            .hidesNavigationBarDuringPresentation = false
        
        // 搜尋時是否使用燈箱效果 (會將畫面變暗以集中搜尋焦點)
        self.searchController
            .dimsBackgroundDuringPresentation = false
        
        // 搜尋框的樣式
        self.searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.barTintColor = darkBackgroundColor
        searchController.searchBar.barStyle = .black
        searchController.searchBar.sizeToFit()
        

        loadWord()
        setUpUi()
        
        
    }
    
    func loadWord(){
        
        FetchWords.shared.FetchWordFunc {[weak self] (words) in
      
            print("word results count:\(words.count)")
            self!.allWords = words
            print("allWord Count:\(self!.allWords!.count)")
            self!.tableView.reloadData()
            
        }
    }
    
    func setUpUi(){
        var iPadDif:CGFloat!
        
        var dif = CGFloat()
        
        
        switch height {
            
        case 1366, 1336, 1112:
            dif = 1
            iPadDif = 2
        case 1024:
            dif = 1
            iPadDif = 1.5
        case 812:
            dif = 1.1
            iPadDif = 1
        case 736:
            dif = 1.1
            iPadDif = 1
        case 667:
            dif = 1
            iPadDif = 1
        case 568:
            dif = 0.9
            iPadDif = 1
        default:
            dif = 1.1
            iPadDif = 1
            break
        }
        
        self.view.backgroundColor = darkBackgroundColor
        

        let titleLabel = UILabel()
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant:15).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true


        titleLabel.textAlignment = .center
        titleLabel.text = "自訂練習"
        titleLabel.font = UIFont(name: "Helvetica Bold", size: 25)
        titleLabel.textColor = greenColor
        //titleLabel.backgroundColor = .red
        
        view.addSubview(selectedWordCountLabel)
        selectedWordCountLabel.translatesAutoresizingMaskIntoConstraints = false
        selectedWordCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectedWordCountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant:5).isActive = true
        selectedWordCountLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        selectedWordCountLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        selectedWordCountLabel.textColor = .white
        selectedWordCountLabel.adjustsFontSizeToFitWidth = true
        selectedWordCountLabel.text = "已選擇 0 字"
        
        

        
        let backBtn = UIButton(type: .system)
        backBtn.setBackgroundImage(UIImage(named: "greenBackBtn"), for: .normal)
        view.addSubview(backBtn)
        
        backBtn.anchor(top: view.safeTopAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: nil, padding: .init(top: 35 * iPadDif * dif, left: 25 * iPadDif * dif, bottom: 0, right: 0), size: .init(width: 19 * iPadDif * dif, height: 31 * iPadDif * dif))
        
        backBtn.addTarget(self, action: #selector(PracticeViewController.leavePracticeVC), for: .touchUpInside)
        
  
        view.addSubview(checkBtn)
        
        let attrs = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor : greenColor]
        
        let attrs2 = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor : UIColor.black]
    
        checkBtn.anchor(top: backBtn.topAnchor, leading: nil, bottom: nil, trailing: view.safeRightAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: -20), size: CGSize(width: 95, height: 30))
        checkBtn.setAttributedTitle(NSAttributedString(string: "查看已選擇", attributes: attrs), for: .normal)
        checkBtn.layer.borderColor = greenColor.cgColor
        checkBtn.layer.borderWidth = 1
        checkBtn.layer.cornerRadius = 10
        checkBtn.addTarget(self, action: #selector(PracticeViewController.checkAllSelected), for: .touchUpInside)
        
        let searchView = UIView()
        self.view.addSubview(searchView)
        searchView.anchor(top: backBtn.bottomAnchor, leading: view.safeLeftAnchor, bottom: nil, trailing: view.safeRightAnchor, padding: .init(top: 5, left: 5, bottom: 0, right: -5), size: CGSize(width: width, height: 50))

        searchView.addSubview(searchController.searchBar)

        enterGameButton.translatesAutoresizingMaskIntoConstraints = false
        enterGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        enterGameButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant:15).isActive = true
        enterGameButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        enterGameButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        enterGameButton.setAttributedTitle(NSAttributedString(string: "開始練習", attributes: attrs2), for: .normal)
        enterGameButton.backgroundColor = greenColor
        enterGameButton.layer.cornerRadius = enterGameButton.frame.width / 8
        
        
        
        tableView.anchor(top: searchView.bottomAnchor, leading: view.safeLeftAnchor, bottom: view.bottomAnchor, trailing: view.safeRightAnchor, padding: .init(top: 10, left: 10, bottom: -90, right: -10))
        
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        for word in selectedWord {
            word.isSelected = false
        }
     
        FetchWords.shared.wordArray.removeAll()

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        if searchController.isActive{
   
            searchArr[indexPath.row].isSelected = !searchArr[indexPath.row].isSelected
            
            if searchArr[indexPath.row].isSelected{
                selectedWord.append(searchArr[indexPath.row])
            } else {
                let indexToRemove = selectedWord.index{$0 === searchArr[indexPath.row]}
                selectedWord.remove(at: indexToRemove!)
            }
            
        }  else if isChecked {
            
          
            selectedArray[indexPath.row].isSelected = !selectedArray[indexPath.row].isSelected
            
            if !selectedArray[indexPath.row].isSelected{
                let indexToRemove = selectedWord.index{$0 === selectedArray[indexPath.row]}
                selectedWord.remove(at: indexToRemove!)
                selectedArray.remove(at: indexPath.row)
            }

            
        } else {
            allWords![indexPath.row].isSelected = !allWords![indexPath.row].isSelected
            if allWords![indexPath.row].isSelected{
                selectedWord.append(allWords![indexPath.row])
            } else {
                
                let indexToRemove = selectedWord.index{$0 === allWords![indexPath.row]}
                selectedWord.remove(at: indexToRemove!)

                
            }
            
        }
        
        
        
        
//        if selectedWord.contains(indexPath.row){
//            let index = selectedWord.firstIndex(of: indexPath.row)
//            selectedWord.remove(at: index!)
//        } else {
//
//        selectedWord.append(indexPath.row)
//        }
        
        tableView.reloadData()
//        print(selectedWord)
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return searchArr.count
            
        } else if isChecked{
            
            return selectedWord.count
            
        } else {
            if allWords != nil {
                
                print("all word count:\(allWords!.count)")
            return allWords!.count
        } else {
            return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! PracticeTableViewCell

        if searchController.isActive{
            cell.word = searchArr[indexPath.row]
            if searchArr[indexPath.row].isSelected{
                cell.checkSpot.isHidden = false
            } else {
                cell.checkSpot.isHidden = true
            }
            
        } else if isChecked{
            cell.word = selectedArray[indexPath.row]
            if selectedArray[indexPath.row].isSelected{
                cell.checkSpot.isHidden = false
            } else {
                cell.checkSpot.isHidden = true
            }

        } else {
            
                cell.word = allWords![indexPath.row]
                if allWords![indexPath.row].isSelected{
                    cell.checkSpot.isHidden = false
                } else {
                    cell.checkSpot.isHidden = true
                }
         
        }
      
        cell.selectionStyle = .none
        
//        if let _ = selectedWord.firstIndex(of: indexPath.row) {
//            cell.checkSpot.isHidden = false
//        } else {
//            cell.checkSpot.isHidden = true
//        }

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let attrs = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor : greenColor]

        isChecked = false
        selectedArray.removeAll()
        
        checkBtn.setAttributedTitle(NSAttributedString(string: "查看已選擇", attributes: attrs), for: .normal)

        
        guard let searchText = searchController.searchBar.text else {
            return
    
        }
     
        guard let allWords = allWords else {return}
   
        searchArr = allWords.filter({ (word) -> Bool in
            return word.engWord.localizedStandardContains(searchText)
        })
        
    }
    
    
    @objc func checkAllSelected(){

        let attrs = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor : greenColor]

        searchController.isActive = false

        if isChecked{
            isChecked = false
            selectedArray.removeAll()
            checkBtn.setAttributedTitle(NSAttributedString(string: "查看已選擇", attributes: attrs), for: .normal)
        } else {
        
            isChecked = true
            selectedArray = selectedWord
            checkBtn.setAttributedTitle(NSAttributedString(string: "返回列表", attributes: attrs), for: .normal)
            if selectedArray.count != 0 {
            let firstIndex = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: firstIndex, at: .top, animated: false)
            }
        }
        
    }

    @objc func leavePracticeVC(){
        self.dismiss(animated: false, completion: nil)
    }
   
    @IBAction func enterGameClicked(_ sender: Any) {
        
        if selectedWord.count > 0{
            
            performSegue(withIdentifier: "practiceToGame", sender: self)
        } else {
            
            ProgressHUD.showError("請選擇要練習的單字")
        }
        
    }
    
    deinit {
        print("practiceVc deinit")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "practiceToGame"{
            
            //暫時保留以後可以做歡迎畫面
            let destineVc = segue.destination as! NewGameViewController
            
            destineVc.wordsToPractice = selectedWord
            destineVc.gameMode = 3
            
        }
    }
    
}
