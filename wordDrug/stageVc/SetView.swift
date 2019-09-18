//
//  SetView.swift
//  wordDrug
//
//  Created by Ethan on 2019/9/7.
//  Copyright © 2019年 playplay. All rights reserved.
//

import UIKit

let closeSettingViewKey = "closeSettingView"
let reloadCollectionViewKey = "reloadCollectionView"

class SetView: UIView{
    
    var bgImageView = UIImageView()
    var cancelBtn: UIButton = {
        var btn = UIButton(type: UIButton.ButtonType.system)
        
        btn.setBackgroundImage(UIImage(named: "setCancelBtn.png"), for: .normal)
        btn.addTarget(self, action: #selector(SetView.cancelBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    var okBtn: UIButton = {
        var btn = UIButton(type: UIButton.ButtonType.system)
        
        btn.setBackgroundImage(UIImage(named: "setOkBtn.png"), for: .normal)
        btn.addTarget(self, action: #selector(SetView.okBtnClicked), for: .touchUpInside)
        
        return btn
    }()
    
    var picker = UIPickerView()
    var selectedIndex = Int()
    var courseReceived = Int()
    
    var pickerData: [String]?{
        didSet{
            picker.reloadAllComponents()
        }
    }
    
    var titleLabel: UILabel = {
        var lb = UILabel()
        lb.textAlignment = .center
        
        lb.textColor = #colorLiteral(red: 1, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
        return lb
    }()
    var wordCountLabel: UILabel = {
        var lb = UILabel()
        lb.textAlignment = .center
        
        lb.textColor = .white
        return lb
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(SetView.notifyCloseSettingView), name: NSNotification.Name(closeSettingViewKey), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SetView.notifyReloadCollectionView), name: NSNotification.Name(reloadCollectionViewKey), object: nil)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var xFactor = CGFloat()
    var bigXFactor = CGFloat()
    var heightFactor = CGFloat()
    var minusXFactor = CGFloat()
    var pickerFontSize = CGFloat()
    
    var totalWordSets = Int()
    
    func setupView(){
        
        switch height {
            
        case 1366, 1336:
            print("big iPad")
            xFactor = 2
            heightFactor = 1.5
            bigXFactor = 3
            minusXFactor = -14
            pickerFontSize = 50
            
        case 1024, 1194, 1112:
            print("small iPad")
            xFactor = 2
            heightFactor = 1.5
            bigXFactor = 3
            minusXFactor = -5
            pickerFontSize = 50
            
        case 812:
            print("iPhone X")
            xFactor = 1
            heightFactor = 1
            bigXFactor = 1
            minusXFactor = 1
            pickerFontSize = 25
            
        case 736:
            print("iPhone plus")
            xFactor = 1
            heightFactor = 1
            bigXFactor = 1
            minusXFactor = 1
            pickerFontSize = 25
            
        case 667:
            print("iPhone")
            xFactor = 1
            heightFactor = 1
            bigXFactor = 1
            minusXFactor = 1
            pickerFontSize = 25
            
        case 568:
            print("iPhone SE")
            xFactor = 1
            heightFactor = 1
            bigXFactor = 1
            minusXFactor = 1
            pickerFontSize = 25
            
        default:
            xFactor = 1
            heightFactor = 1
            bigXFactor = 1
            minusXFactor = 1
            pickerFontSize = 25
            
        }
        
        

        
        self.frame = CGRect(x: (width - 320) / 4, y: (height - 387) / 4, width: 320 * xFactor, height: 387 * xFactor)
        
        bgImageView.frame = CGRect(x: 0, y: 0, width: 320 * xFactor, height: 387 * xFactor)
        bgImageView.image = UIImage(named: "settingBg.png")
        self.addSubview(bgImageView)
        
        
        picker.frame = CGRect(x: 0, y: 100, width: self.frame.width, height: self.frame.height / 2 * heightFactor)
        
        picker.delegate = self
        picker.dataSource = self
        //        picker.backgroundColor = .blue
        
        self.addSubview(picker)
        
        cancelBtn.frame = CGRect(x: self.frame.midX - 117 * bigXFactor, y: picker.frame.maxY + 30 / xFactor + minusXFactor, width: 77 * heightFactor, height: 40 * heightFactor)
        self.addSubview(cancelBtn)
        
        
        okBtn.frame = CGRect(x: self.frame.midX + 10 * minusXFactor, y: picker.frame.maxY + 30 / xFactor + minusXFactor, width: 77 * heightFactor, height: 40 * heightFactor)
        self.addSubview(okBtn)
        
        self.addSubview(titleLabel)
        titleLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 50 * xFactor)
        //        titleLabel.backgroundColor = .brown
        titleLabel.font = UIFont(name: "Helvetica Bold", size: pickerFontSize)
        
        self.addSubview(wordCountLabel)
        wordCountLabel.frame = CGRect(x: 0, y: 45 * xFactor, width: self.frame.width, height: 30 * xFactor)
        //        wordCountLabel.backgroundColor = .red
        wordCountLabel.font = UIFont(name: "Helvetica Bold", size: pickerFontSize - 10)
        
        
    }
    
    @objc func cancelBtnClicked(){
        //close
        NotificationCenter.default.post(name: NSNotification.Name.init(closeSettingViewKey), object: nil, userInfo: nil)
    }
    
    @objc func notifyReloadCollectionView(){
        print("notify reload")
        
    }
    
    @objc func okBtnClicked(){
        
        if lan == "zh-Hans" && courseReceived == 0{
            totalWordSets = 110
        } else {
            totalWordSets = 150
        }
        
        //print("setView totalWordSets : \(totalWordSets)")
        let newMapPassed = selectedIndex / totalWordSets
        let restNumbers = selectedIndex % totalWordSets
        let newGameSpotNum = restNumbers / 10
        let newGameUnitNum = restNumbers % 10
        let newGamePassed:[Int:Int] = [newGameSpotNum:newGameUnitNum]
        
        //print("courseReceived:\(courseReceived)newMap:\(newMapPassed), newGame:\(newGamePassed)")
        
        var tempMapPassed = String()
        var tempGamePassed = String()
        switch courseReceived {
            
        case 0:
            tempMapPassed = kMapPassed
            tempGamePassed = kGamePassed
            mapPassed = newMapPassed
            gamePassed = newGamePassed
            
        case 1:
            
            tempMapPassed = kMapPassed2
            tempGamePassed = kGamePassed2
            mapPassed2 = newMapPassed
            gamePassed2 = newGamePassed
            
        case 2:
            tempMapPassed = kMapPassed3
            tempGamePassed = kGamePassed3
            mapPassed3 = newMapPassed
            gamePassed3 = newGamePassed
        case 3:
            tempMapPassed = kMapPassed4
            tempGamePassed = kGamePassed4
            mapPassed4 = newMapPassed
            gamePassed4 = newGamePassed
        case 4:
            tempMapPassed = kMapPassed5
            tempGamePassed = kGamePassed5
            mapPassed5 = newMapPassed
            gamePassed5 = newGamePassed
        case 6:
            tempMapPassed = kMapPassed7
            tempGamePassed = kGamePassed7
            mapPassed7 = newMapPassed
            gamePassed7 = newGamePassed
        case 7:
            tempMapPassed = kMapPassed8
            tempGamePassed = kGamePassed8
            mapPassed8 = newMapPassed
            gamePassed8 = newGamePassed
        case 8:
            tempMapPassed = kMapPassed9
            tempGamePassed = kGamePassed9
            mapPassed9 = newMapPassed
            gamePassed9 = newGamePassed
        default:
            break
            
        }
        
        //然後儲存
        let userDefaults = UserDefaults.standard
        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: newGamePassed)
        UserDefaults.standard.set(newMapPassed, forKey: tempMapPassed)
        userDefaults.set(encodedObject, forKey: tempGamePassed)
        
        //reload collectionView
        NotificationCenter.default.post(name: NSNotification.Name.init(reloadCollectionViewKey), object: nil, userInfo: nil)
        
    }
    
    @objc func notifyCloseSettingView(){
        
    }
    
}

extension SetView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerData == nil {
            return 0
        } else {
            return (pickerData?.count)!
        }
        
    }
    
    // returns width of column and height of row for each component.
    @available(iOS 2.0, *)
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat{
        
        return self.frame.width
        
    }
    
    @available(iOS 2.0, *)
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        
        return 30 * xFactor
    }
    
    
    //    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
    //
    //        let eachRowString = pickerData![row]
    //
    //        let chapter = picker.selectedRow(inComponent: 0) / 150
    //        titleLabel.text = "第\(chapter + 1)單元"
    //        let setNumber = picker.selectedRow(inComponent: 0) % 150
    //        wordCountLabel.text = "第\(setNumber + 1)組字"
    //
    //        return eachRowString
    //
    //    }
    
    
    //    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    //
    //        let attrs = [NSAttributedString.Key.font : UIFont(name: "Helvetica Bold", size: 100)]
    //
    //        let eachRowString = pickerData![row]
    //
    //        let eachRowAttributed = NSAttributedString(string: eachRowString, attributes: attrs as [NSAttributedString.Key : Any])
    //
    //        let chapter = picker.selectedRow(inComponent: 0) / 150
    //        titleLabel.text = "第\(chapter + 1)單元"
    //        let setNumber = picker.selectedRow(inComponent: 0) % 150
    //        wordCountLabel.text = "第\(setNumber + 1)組字"
    //
    //        return eachRowAttributed
    //    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        if lan == "zh-Hans" && courseReceived == 0{
            totalWordSets = 110
        } else {
            totalWordSets = 150
        }
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Helvetica", size: pickerFontSize)
            pickerLabel?.textAlignment = .center
        }
        let eachRowString = pickerData![row]
        pickerLabel!.text = eachRowString
        let chapter = picker.selectedRow(inComponent: 0) / totalWordSets
        titleLabel.text = "第\(chapter + 1)單元"
        let setNumber = picker.selectedRow(inComponent: 0) % totalWordSets
        wordCountLabel.text = "第\(setNumber + 1)組字"
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        print(row)
        selectedIndex = row
        
        let chapter = row / totalWordSets
        titleLabel.text = "第\(chapter + 1)單元"
        let setNumber = row % totalWordSets
        wordCountLabel.text = "第\(setNumber + 1)組字"
        
        
    }
}
