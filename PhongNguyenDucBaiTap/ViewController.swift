//
//  ViewController.swift
//  PhongNguyenDucBaiTap
//
//  Created by phongnd on 10/2/20.
//  Copyright © 2020 phongnd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let baseRequest = BaseRequest()
    @IBOutlet weak var tableView: UITableView!
    
    var list = [StaffObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "StaffTableViewCell", bundle: nil), forCellReuseIdentifier: "StaffTableViewCell")
        
        self.baseRequest.requestUrl(url: "https://my-json-server.typicode.com/vantrung8794/ttcTrainingRepo/db",
                                    type: EmployeeObject.self) { (array) in
            self.list = array.employees
            self.tableView.reloadData()
        }
    }
    
    func showAlert(_ index: Int) {
        let alert = UIAlertController(title: "Thông báo", message: "Bạn có muốn xóa nhân viên \(list[index].name)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .default, handler: { action in
            print("Đồng ý")
            self.list.remove(at: index)
            self.tableView.reloadSections(IndexSet(integer: 0), with: .top)
        }))
        alert.addAction(UIAlertAction(title: "Hủy bỏ", style: .cancel, handler: { action in
            print("Hủy bỏ")
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showEditController(sender: UIButton) {
        let editVC = EditViewController.init(nibName: "EditViewController", bundle: nil)
        editVC.modalPresentationStyle = .pageSheet
        editVC.object = list[sender.tag]
        editVC.delegate = self
        editVC.index = sender.tag
        self.present(editVC, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StaffTableViewCell") as! StaffTableViewCell
        cell.bindData(list[indexPath.row])
        cell.editButton.tag = indexPath.row
        cell.editClosure = {
            print("edit")
            self.showEditController(sender: cell.editButton)
        }
        
        cell.deleteClosure = {
            print("delete at \(indexPath.row)")
            self.showAlert(indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Danh sách nhân viên"
    }
}

extension ViewController: EditViewControllerDelegate {
    func didClickDone(_ object: StaffObject, index: Int) {
        list[index] = object
        self.tableView.reloadData()
    }
}
