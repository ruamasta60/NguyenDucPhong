//
//  EditViewController.swift
//  PhongNguyenDucBaiTap
//
//  Created by phongnd on 10/5/20.
//  Copyright © 2020 phongnd. All rights reserved.
//

import UIKit
protocol EditViewControllerDelegate {
    func didClickDone(_ object: StaffObject, index: Int)
}

class EditViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var swichButton: UISwitch!
    
    var object: StaffObject?
    var delegate: EditViewControllerDelegate?
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width: 300, height: 250)
        self.bindData()
    }

    func bindData() {
        nameText.text = self.object?.name
        addressText.text = self.object?.address
        if self.object!.isMale {
            self.swichButton.setOn(true, animated: false)
        } else {
            self.swichButton.setOn(false, animated: false)
        }
        self.setSex()
    }
    
    @IBAction func changeValue(_ sender: UISwitch) {
        if sender.isOn {
            object?.isMale = true
        } else {
            object?.isMale = false
        }
        self.setSex()
    }
    
    func setSex() {
        self.sexLabel.text = self.object!.isMale ? "Giới tính: Nam" : "Giới tính: Nữ"
    }
    
    @IBAction func agreeButton(_ sender: Any) {
        object?.name = self.nameText.text ?? ""
        object?.address = self.addressText.text ?? ""
        self.dismiss(animated: true) {
            self.delegate?.didClickDone(self.object!, index: self.index)
        }
    }
}
