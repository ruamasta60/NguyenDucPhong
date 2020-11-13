//
//  BaiTap2ViewController.swift
//  PhongNguyenDucBaiTap
//
//  Created by TTC Training on 11/10/20.
//  Copyright © 2020 phongnd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaiTap2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var expandingSwitch: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    
    let homeModel = BaiTap2ViewModel()
    let disposeBag = DisposeBag()
    
    var isOpened = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.title = "Bài tập 2"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "ZoomOutTableViewCell", bundle: nil), forCellReuseIdentifier: "ZoomOutTableViewCell")
        tableView.register(UINib(nibName: "ZoomInTableViewCell", bundle: nil), forCellReuseIdentifier: "ZoomInTableViewCell")
        
        setupBindingsDangChoVay()
        
        homeModel.getDangChoVayData()
    }
    
    @IBAction func segmenAction(_ sender: Any) {
        if self.segment.selectedSegmentIndex == 0 {
            setupBindingsDangChoVay()
            homeModel.getDangChoVayData()
        } else {
            setupBindingsDangVay()
            homeModel.getDangVayData()
        }
    }
    
    func setupBindingsDangChoVay() {
        homeModel.listObjectDangChoVay.subscribe(onNext: { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
    
    func setupBindingsDangVay() {
        homeModel.listObjectDangVay.subscribe(onNext: { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if segment.selectedSegmentIndex == 0 {
            return homeModel.listObjectDangChoVay.value.count
        } else {
            return homeModel.listObjectDangVay.value.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isOpened {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segment.selectedSegmentIndex == 0 {
            if indexPath.row == 0 {
            //Cell này coi là section này!
                let cell = tableView.dequeueReusableCell(withIdentifier: "ZoomOutTableViewCell") as! ZoomOutTableViewCell
                cell.nameLabel?.text = homeModel.listObjectDangChoVay.value[indexPath.section].name
                cell.moneyLabel?.text = homeModel.listObjectDangChoVay.value[indexPath.section].money
                cell.backgroundColor = .yellow
                return cell
            } else {
            //Cell tuỳ biến, đây là cell nhỏ sau khi mở rộng ra nhé!
                let cell = tableView.dequeueReusableCell(withIdentifier: "ZoomInTableViewCell") as! ZoomInTableViewCell
                cell.desLabel?.text = homeModel.listObjectDangChoVay.value[indexPath.section].content
                cell.moneyLabel?.text = homeModel.listObjectDangChoVay.value[indexPath.section].money
                cell.dateLabel?.text = homeModel.listObjectDangChoVay.value[indexPath.section].time
                cell.backgroundColor = .white
                return cell
            }
        } else {
            if indexPath.row == 0 {
            //Cell này coi là section này!
                let cell = tableView.dequeueReusableCell(withIdentifier: "ZoomOutTableViewCell") as! ZoomOutTableViewCell
                cell.nameLabel?.text = homeModel.listObjectDangVay.value[indexPath.section].name
                cell.moneyLabel?.text = homeModel.listObjectDangVay.value[indexPath.section].money
                cell.backgroundColor = .yellow
                return cell
            } else {
            //Cell tuỳ biến, đây là cell nhỏ sau khi mở rộng ra nhé!
                let cell = tableView.dequeueReusableCell(withIdentifier: "ZoomInTableViewCell") as! ZoomInTableViewCell
                cell.desLabel?.text = homeModel.listObjectDangVay.value[indexPath.section].content
                cell.moneyLabel?.text = homeModel.listObjectDangVay.value[indexPath.section].money
                cell.dateLabel?.text = homeModel.listObjectDangVay.value[indexPath.section].time
                cell.backgroundColor = .white
                return cell
            }
        }
    }
    
    @IBAction func expandAction(_ sender: Any) {
        self.isOpened = !isOpened
        self.tableView.reloadData()
    }
    
}
