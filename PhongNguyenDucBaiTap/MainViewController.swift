//
//  MainViewController.swift
//  PhongNguyenDucBaiTap
//
//  Created by TTC Training on 11/10/20.
//  Copyright © 2020 phongnd. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, VTCalendarViewDelegate {

    @IBOutlet weak var calendarView: VTCalendarView!
    var listDateAccept = [VTDate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.delegateVT = self
        self.navigationController?.title = "Bài tập đào tạo"
        
        calendarView.isShowHeader = true
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)

        let year =  components.year
        let month = components.month
        
        calendarView.chosenMonth = month!
        calendarView.chosenYear = year!
        
    }
    
    @IBAction func bt1action(_ sender: Any) {        
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func bt2action(_ sender: Any) {
        let vc2 = BaiTap2ViewController.init(nibName: "BaiTap2ViewController", bundle: nil)
        self.navigationController?.pushViewController(vc2, animated: true)
    }
    
    @IBAction func bt3Action(_ sender: Any) {
        let vc3 = BaiTap3ViewController.init(nibName: "BaiTap3ViewController", bundle: nil)
        self.navigationController?.pushViewController(vc3, animated: true)
    }
    
    func didAcceptCalendar(_ vtCalendarView: VTCalendarView, selectedDates: VTDate) {
        print("\(selectedDates.day)\(selectedDates.month)\(selectedDates.year)")
    }
}
