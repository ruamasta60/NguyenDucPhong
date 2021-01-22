//
//  VTCalendarView.swift
//  CalendarView
//
//  Created by Trung Nguyen on 10/31/18.
//  Copyright © 2018 Trung Nguyen. All rights reserved.
//
import Foundation
import UIKit

class VTCalendarView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var delegateVT: VTCalendarViewDelegate?
    
    let lstMonths = ["Thg01", "Thg02", "Thg03", "Thg04", "Thg05", "Thg06", "Thg07", "Thg08", "Thg09", "Thg10", "Thg11", "Thg12", ]
    var lstYear: [String] = []
    
    let startYear = 1900
    let endYear = 2200
    var enableToday = false
    var currentDay = VTDate.getCurrentDay()
    var chooseDate = -1
    
    var isShowHeader = true{
        didSet{
            showHeader(isShow: isShowHeader)
        }
    }
    
    func showHeader(isShow: Bool) {
        if isShow {
            headerView.isHidden = false
            
        }else{
            headerView.isHidden = true
        }
    }
    var chosenMonth = 8{
        didSet{
            setUpMonthYear()
            collectionView.reloadData()
        }
    }
    var chosenYear = 2021{
        didSet{
            setUpMonthYear()
            collectionView.reloadData()
        }
    }
    
    func reloadData(){
        collectionView.reloadData()
    }
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var pickerMonth: UIPickerView!
    @IBOutlet weak var pickerYear: UIPickerView!
    @IBOutlet weak var headerView: UIStackView!
    
    @IBOutlet weak var btnChooseMonth: UIButton!
    @IBOutlet weak var btnChooseYear: UIButton!
    @IBOutlet weak var btnBackMonth: UIButton!
    @IBOutlet weak var btnNextMonth: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpXib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "CalendarViewCell", bundle: nil), forCellWithReuseIdentifier: "calendarCell")
        
        setupHeaderView()
        
    }
    
    func loadFromXib() -> UIView? {
        let nibName = "VTCalendarView"
        let bundle = Bundle(for: type(of: self))
        let nibFile = UINib(nibName: nibName, bundle: bundle)
        return nibFile.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setUpXib() {
        guard let view = loadFromXib() else {
            return
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView = view
        addSubview(contentView)
        
        btnAccept.layer.cornerRadius = 5
        collectionView.layer.cornerRadius = 5
        collectionView.clipsToBounds = true
        
    }
    // MARK: - Actions
    func setupHeaderView() {
        showHeader(isShow: isShowHeader)
        let queue = DispatchQueue(label: "makeLstYear")
        queue.async {
            for item in self.startYear...self.endYear{
                self.lstYear.append(String(item))
            }
        }
        pickerYear.isHidden = true
        pickerMonth.isHidden = true
        pickerMonth.delegate = self
        pickerMonth.dataSource = self
        pickerYear.delegate = self
        pickerYear.dataSource = self
        setUpMonthYear()
    }
    
    func setUpMonthYear() {
        pickerMonth.selectRow(chosenMonth - 1, inComponent: 0, animated: false)
        pickerYear.selectRow(chosenYear-1900, inComponent: 0, animated: false)
        btnChooseMonth.setTitle("Thg\(chosenMonth)", for: .normal)
        btnChooseYear.setTitle("\(chosenYear)", for: .normal)
    }
    
    @IBAction func chooseMonthAction(_ sender: UIButton) {
        sender.alpha = 0.01
        pickerMonth.isHidden = false
    }
    
    @IBAction func chooseYearAction(_ sender: UIButton) {
        sender.alpha = 0.01
        pickerYear.isHidden = false
    }
    
    @IBAction func acceptAction(_ sender: Any) {
        let date = VTDate(day: self.chooseDate, month: self.chosenMonth, year: self.chosenYear)
        delegateVT?.didAcceptCalendar(self, selectedDates: date)
    }
    
    @IBAction func backMonthAction(_ sender: UIButton) {
        if chosenMonth == 1{
            chosenMonth = 12
            chosenYear = chosenYear - 1
        }else{
            chosenMonth = chosenMonth - 1
        }
        self.chooseDate = -1
    }
    @IBAction func nextMonthAction(_ sender: UIButton) {
        if chosenMonth == 12{
            chosenMonth = 1
            chosenYear = chosenYear + 1
        }else{
            chosenMonth = chosenMonth + 1
        }
        self.chooseDate = -1
    }
    
    
    // MARK: - CollectionView Delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var dayStart = VTDate.getstartDayofMonth(month: chosenMonth, year: chosenYear)
        if  dayStart == 1 {
            dayStart = 8
        }
        return dayStart + VTDate.getDaysInMonth(month: chosenMonth, year: chosenYear) - 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 7 - 1, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarViewCell
        cell.changeSelected(isSelect: false)
        var dayStart = VTDate.getstartDayofMonth(month: chosenMonth, year: chosenYear)
        if  dayStart == 1{
            dayStart = 8
        }
        let tgDate = indexPath.row + 3 - dayStart
        if tgDate > 0 {
            cell.lblNumber.text = String(tgDate)
            
            if tgDate == chooseDate {
                cell.lblNumber.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
                cell.lblNumber.textColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                cell.lblNumber.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.lblNumber.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
        else{
            cell.lblNumber.text = ""
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var dayStart = VTDate.getstartDayofMonth(month: chosenMonth, year: chosenYear)
        if  dayStart == 1 {
            dayStart = 8
        }
        let tgDate = indexPath.row + 3 - dayStart
        if tgDate > 0 {
            chooseDate = tgDate
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - PickerView delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerMonth {
            return lstMonths.count
        }
        if pickerView == pickerYear{
            return lstYear.count
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerMonth {
            return lstMonths[row]
        }
        if pickerView == pickerYear{
            return lstYear[row]
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerMonth {
            print(lstMonths[row])
            chosenMonth = row + 1
            btnChooseMonth.setTitle(lstMonths[row], for: .normal)
            btnChooseMonth.alpha = 1
            self.chooseDate = -1
        }
        if pickerView == pickerYear{
            print(lstYear[row])
            chosenYear = Int(lstYear[row])!
            btnChooseYear.setTitle(lstYear[row], for: .normal)
            btnChooseYear.alpha = 1
            self.chooseDate = -1
        }
        pickerView.isHidden = true
    }
}
